Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7467E2FEA
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 23:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233151AbjKFWhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 17:37:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbjKFWhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 17:37:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F73EAF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 14:37:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0757C433C8;
        Mon,  6 Nov 2023 22:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699310221;
        bh=KnWg66fiIqkuYC0T/uFVfOj96qkrkHSpP3jCOZgXqgQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TLEuc1hkIODtMEb3BiwZxEdqxQNP2v/9+Vxrf9wO1ngAh2Y9Sh1qOna8RrRNd+nl0
         Sl7vPPFM8PF5IvkFwHXWdS0URA4bjMwiAY32r4Hv4GgiYbKRqiefcu6nzpz9kXXph6
         dAFD2AKiRFIwjLT78caEFOCL9/THb1cmSJnXMXB23XOtsffvaFemIP7RohRuXBYT1x
         /fianyyDso/TKsa42ivVLRJShe5XenZ6araTmF1UXty05qjIU2QVTPH3yLCCXYGBsG
         LAdsaEnxlVkS1jTGmAAPoAmUvD7Sq27ekga6JWMh9wQO1CLZsgqiapUU9zVryStzBi
         mO0nCwIefHa5Q==
Date:   Mon, 6 Nov 2023 14:36:59 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Dae R. Jeong" <threeearcat@gmail.com>
Cc:     borisp@nvidia.com, john.fastabend@gmail.com, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ywchoi@casys.kaist.ac.kr
Subject: Re: Missing a write memory barrier in tls_init()
Message-ID: <20231106143659.12e0d126@kernel.org>
In-Reply-To: <ZUNLocdNkny6QPn8@dragonet>
References: <ZUNLocdNkny6QPn8@dragonet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Nov 2023 16:11:29 +0900 Dae R. Jeong wrote:
> In addition, I believe the {tls_setsockopt, tls_getsockopt}
> implementation is fine because of the address dependency. I think
> load-load reordering is prohibited in this case so we don't need a
> read barrier.

Sounds plausible, could you send a patch?

The smb_wmb() would be better placed in tls_init(), IMHO.
