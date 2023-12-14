Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FC6813869
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444001AbjLNRYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:24:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLNRYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:24:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3667D93
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:24:13 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 654E1C433C7;
        Thu, 14 Dec 2023 17:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702574652;
        bh=Lo++xlxLZ+5osBQRnqfeNnIUwruOjg2HtfW4cEdp9TU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bndVW96a5dPw/EEN9DFKm+FmNgfhGjXzX4JEA53PfvnIr/6fDD9jZCQCUY23OHDWx
         guW75UOqAw7zpVGgQpfIaoAeVkaBI/aHT7oKbUhVL1Kuwq6hG5Xruv1hfNvJf23tnV
         tP0gpoSw90lxSoA9wgaKZWwfD6Za0kzIELtVZUE0KekIai01mfKTXH7jodr0516CGD
         WfT7/G9j8yxnzNUpyzfcuD6kKkB1UM0+robF39A8VnHsrr8brFHVHQoDQ3mG8IMScP
         K3bvyH9CAPIdutDduQXm/G9ohUwimh8f1DPDA3ma+03Ye1CJ1yzdaGLireQfyz6Y+X
         u8yZSm8o0hBPA==
Date:   Thu, 14 Dec 2023 09:24:11 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     JustinLai0215 <justinlai0215@realtek.com>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Larry Chiu <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v14 06/13] rtase: Implement .ndo_start_xmit
 function
Message-ID: <20231214092411.62661528@kernel.org>
In-Reply-To: <ce315d58376c40d4abf82d80bf203c81@realtek.com>
References: <20231208094733.1671296-1-justinlai0215@realtek.com>
        <20231208094733.1671296-7-justinlai0215@realtek.com>
        <20231212113212.1cfb9e19@kernel.org>
        <ce315d58376c40d4abf82d80bf203c81@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2023 13:00:29 +0000 JustinLai0215 wrote:
> > I don't see how this is called, the way you split the submission makes it a bit
> > hard to review, oh well. Anyway - if you pass the NAPI budget here - that's not
> > right, it may be 0, and you'd loop forever.
> > For Tx - you should try to reap some fixed number of packets, say 128, the
> > budget is for Rx, not for Tx.  
> 
> Even if the budget is 0, this function will not loop forever, it will just run all tx_left.
> Or what changes would you like us to make?

Ah, good point. It does seem a little accidental to me :S
In that case perhaps always consume all completed packets?
@budget should not constrain Tx completions directly, see:
https://www.kernel.org/doc/html/next/networking/napi.html
