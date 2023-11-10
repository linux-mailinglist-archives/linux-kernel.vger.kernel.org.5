Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DB27E835F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 21:05:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345142AbjKJUFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 15:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjKJUFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 15:05:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CBE9D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 12:05:15 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB22C433C8;
        Fri, 10 Nov 2023 20:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699646714;
        bh=lOmC1RzpzPbrRuQaSQab3+Pr63qCgL2kSiNOgA19+Iw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=onhJ+OYE89lq0qaOjb/9sr+He8iR14eZe4EF4w6zrjdNLZuShjUZAp2j98eZsYJjP
         bkc4+1foYY5yLwf4Cg8QU/AkQR5cFc26UEEKSP3Zb8TMH08XTJiKLrvnmgp0yh+hDy
         nG7kBdHW1WTcXfgbucz7MU0b7ZFEKV07WoIzvDj8HlMUXmjYuZG6t2puccltiDV0aZ
         CnfwaqOHqH2yrbFe7thLKwSKRYwoq1rpvNAm5AzhnqTd6AwgQ/j3nsc4tVNoAFrYth
         uvrhfADdetNB6oTFF9x7neuLM2BoQtlnhqunhZUc7vOJjWxbdgIXCfEgM3dC2Yaq5F
         7wAlr8BqOx84A==
Date:   Fri, 10 Nov 2023 12:05:13 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Long Li <longli@microsoft.com>
Cc:     "longli@linuxonhyperv.com" <longli@linuxonhyperv.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4] hv_netvsc: Mark VF as slave before exposing
 it to user-mode
Message-ID: <20231110120513.45ed505c@kernel.org>
In-Reply-To: <PH7PR21MB3263EBCF9600EEBD6D962B6ECEAEA@PH7PR21MB3263.namprd21.prod.outlook.com>
References: <1699484212-24079-1-git-send-email-longli@linuxonhyperv.com>
        <20231108181318.5360af18@kernel.org>
        <PH7PR21MB3263EBCF9600EEBD6D962B6ECEAEA@PH7PR21MB3263.namprd21.prod.outlook.com>
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

On Fri, 10 Nov 2023 00:43:55 +0000 Long Li wrote:
> The code above needs to work with and without netvsc (the possible
> master device) present.

I don't think that's a reasonable requirement for the kernel code.

The auto-bonding already puts the kernel into business of guessing
policy, which frankly we shouldn't be in.

Having the kernel guess even harder that there will be a master,
but it's not there yet, is not reasonable.
