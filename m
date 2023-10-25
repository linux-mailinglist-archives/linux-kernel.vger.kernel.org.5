Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883767D67C9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234531AbjJYKCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234511AbjJYKCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:02:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E11110A;
        Wed, 25 Oct 2023 03:02:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806FCC433C7;
        Wed, 25 Oct 2023 10:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698228125;
        bh=ybu2QhM0g6Ex7UMsUBH7XX68xTRuJ62s71y77gSZog0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=C57jVZDbxfjQWkCIMYu1b+AZGs01SCimI77orisHJYNXv2PPVltTcQTOPSfXwglQb
         trI9FgmBKoIBQs7Nq9UHwtbokFk1TXVNNdY7oXpErNJ0YDQS7wspi8YGTIx/o2Oywf
         tvttOm35eD6UUN0+vd2qt53U4SlXrOLDpvevC+dpGq6i0E4AUvIAjUgZQ43RR1nXfr
         iWjUgGPwduvcH83k1/CQ0XT4Hz6p4IB11TxClNzGEpHuLBNeNBUw3GT2hQ8JfWShiC
         esXoUt9FwbUZl236S9y1BvbSn2Inl6Og1eDaRxW1Z40Za521/LpyQiUl9R0kB7NAce
         l0ev8qBHMajFg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] wifi: ath12k: fix dfs-radar and temperature event
 locking
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231019113650.9060-2-johan+linaro@kernel.org>
References: <20231019113650.9060-2-johan+linaro@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath12k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169822812144.891844.11172869557869063220.kvalo@kernel.org>
Date:   Wed, 25 Oct 2023 10:02:03 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johan Hovold <johan+linaro@kernel.org> wrote:

> The ath12k active pdevs are protected by RCU but the DFS-radar and
> temperature event handling code calling ath12k_mac_get_ar_by_pdev_id()
> was not marked as a read-side critical section.
> 
> Mark the code in question as RCU read-side critical sections to avoid
> any potential use-after-free issues.
> 
> Note that the temperature event handler looks like a place holder
> currently but would still trigger an RCU lockdep splat.
> 
> Compile tested only.
> 
> Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")
> Cc: stable@vger.kernel.org      # v6.2
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

2 patches applied to ath-next branch of ath.git, thanks.

69bd216e0493 wifi: ath12k: fix dfs-radar and temperature event locking
6afc57ea315e wifi: ath12k: fix htt mlo-offset event locking

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231019113650.9060-2-johan+linaro@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

