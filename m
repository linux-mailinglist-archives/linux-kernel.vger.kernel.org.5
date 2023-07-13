Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C2B751583
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 02:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233289AbjGMAvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 20:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbjGMAvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 20:51:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6142101;
        Wed, 12 Jul 2023 17:51:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DC56261904;
        Thu, 13 Jul 2023 00:51:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15641C433C8;
        Thu, 13 Jul 2023 00:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689209463;
        bh=V+Vc3hjjHuh25UinU0PX6yE946ivKVnfKEPeBSWk9QQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K3HmB2PZzULWXiOCPbKeRfxZRLqerrD+PiuJ1pv/ZYmELo+Mlk+H0SxSjHWLeK4Wo
         I1SEj1T5bMx2MnceT7BvSQBNgd0AqB8kDtSm6MXP1YzYXjAePFACYBkeE3EMEQoB1l
         cYMZrqlw4cWCzoZgQo94J7hb2HWBeHvZA1dW1XpskMSHtxFLqCDEdw/w4XSNihivJa
         3aoGfO7RRbmjg8NDIcVQIQsUMpiPFok6MZgPJdyiRLv7WvXOfxeoAdBcMs7P7ryDdl
         ljcaq/yts+XegC0ZqDlRVxDWRGWrnL367Lfh6jR+vWq+NxmuRnKsGMUVv5dUDOlVG8
         RBKupVXLZFgLQ==
Date:   Wed, 12 Jul 2023 17:51:02 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     pinkperfect <pinkperfect2021@gmail.com>
Cc:     amitkarwar@gmail.com, kvalo@kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: Fix integer underflow in
 mwifiex_process_mgmt_packet
Message-ID: <20230712175102.59d2bda9@kernel.org>
In-Reply-To: <20230705044350.838428-1-pinkperfect2021@gmail.com>
References: <20230705044350.838428-1-pinkperfect2021@gmail.com>
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

On Wed,  5 Jul 2023 04:43:50 +0000 pinkperfect wrote:
> In outside functions have checked upper limit of rx_pkt_length,
> in mwifiex_process_mgmt_packet should make sure rx_pkt_length not underflow
> to avoid OOB access.

Please add a Fixes tag.

> Signed-off-by: pinkperfect <pinkperfect2021@gmail.com>

We need something close to your legal name, or basically know who you
are. Because of developer certificate of origin. We're working on real
code under real copyright law..

> diff --git a/drivers/net/wireless/marvell/mwifiex/util.c b/drivers/net/wireless/marvell/mwifiex/util.c
> index 94c2d219835d..4291252e06ea 100644
> --- a/drivers/net/wireless/marvell/mwifiex/util.c
> +++ b/drivers/net/wireless/marvell/mwifiex/util.c
> @@ -399,6 +399,11 @@ mwifiex_process_mgmt_packet(struct mwifiex_private *priv,
>  
>  	pkt_len = le16_to_cpu(rx_pd->rx_pkt_length);
>  
> +	if (pkt_len < sizeof(struct ieee80211_hdr)) {

The callers also look at the header and the MAC addresses in it.
I think we need to pull this check earlier.

> +		mwifiex_dbg(priv->adapter, ERROR, "invalid rx_pkt_length");
> +		return -1;
