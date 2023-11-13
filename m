Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 846947EA037
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjKMPjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:39:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKMPjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:39:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA73910E2;
        Mon, 13 Nov 2023 07:39:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819ABC433C8;
        Mon, 13 Nov 2023 15:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699889988;
        bh=QpKKoeuWC0pCYvMri4WMZVGR1FislkCUUfjedW52+8g=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=LsvJlJdUzEM6WzOqNWI4Zo+T3V6Tn0+dD9l/eeJd/4eQbO/JHIIWnzcEqQzFMEYJh
         drgYzsaZwX2afmMpKIuJYwVswtSUikRDGIYv3jU+oxZmMOmLxDWeYBL9avIPBFY6xW
         LHabIpBI3PF+GmXYDRJSmBqgI+a3uN3ovxkRjia32a1AzobJtH3t85XmdEEX7SpLRI
         F4PEl1ZBU/h+p08gpeSVvaveQAdWUaxjNH3F5I52O8G1pD7N7LCv+kx/lKfsltOzk6
         16yYx5wLsblR4BDgsSF8g2jqovG2bhRL0mnmNcG+zGs12ekN+rsDEIDBommPcK8Hyy
         b9YTndGFwoC4w==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: Defer on rproc_get failure
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231027-ath11k-rproc-defer-v1-1-f6b6a812cd18@fairphone.com>
References: <20231027-ath11k-rproc-defer-v1-1-f6b6a812cd18@fairphone.com>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169988998449.3390604.914976926360003239.kvalo@kernel.org>
Date:   Mon, 13 Nov 2023 15:39:46 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luca Weiss <luca.weiss@fairphone.com> wrote:

> If we already have gotten the rproc_handle (meaning the "qcom,rproc"
> property is defined in the devicetree), it's a valid state that the
> remoteproc module hasn't probed yet so we should defer probing instead
> of just failing to probe.
> 
> This resolves a race condition when the ath11k driver probes and fails
> before the wpss remoteproc driver has probed, like the following:
> 
>   [    6.232360] ath11k 17a10040.wifi: failed to get rproc
>   [    6.232366] ath11k 17a10040.wifi: failed to get rproc: -22
>   [    6.232478] ath11k: probe of 17a10040.wifi failed with error -22
>        ...
>   [    6.252415] remoteproc remoteproc2: 8a00000.remoteproc is available
>   [    6.252776] remoteproc remoteproc2: powering up 8a00000.remoteproc
>   [    6.252781] remoteproc remoteproc2: Booting fw image qcom/qcm6490/fairphone5/wpss.mdt, size 7188
> 
> So, defer the probe if we hit that so we can retry later once the wpss
> remoteproc is available.
> 
> Tested-on: WCN6750 hw1.0 AHB WLAN.MSL.1.0.1-01264-QCAMSLSWPLZ-1.37886.3
> 
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

2a3ec40b98b4 wifi: ath11k: Defer on rproc_get failure

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231027-ath11k-rproc-defer-v1-1-f6b6a812cd18@fairphone.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

