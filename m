Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2256D7D67C1
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234479AbjJYKBY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234477AbjJYKBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:01:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D07123;
        Wed, 25 Oct 2023 03:01:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B51C433C7;
        Wed, 25 Oct 2023 10:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698228077;
        bh=pHVZBBUZeJJACrobCo39QHBAU5G9lo0Us8u49XLaWF4=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=ClMGUXZUCMde94G13lpoO3c0rhFI06ZPtYzliOtGhMSl3DtrKs8+FfEVwVY9t9S7r
         ALIKtgsMijC2G1la8c1XmHrwXgQ+9VzrWBEvUngMue/BGhKpWn/sObkQtPlPTd2plG
         jwOXiB2F9MRMuCnzQYBdxYwR5L9HrF/0PORqOb1w+1TuDlsZi3DmOjeQTVnvZZcSDJ
         PFHN+stZ8toavxWKHWcBy5TPDYAxkpIkzYET3KHRwAH11hL1LIQGkMFLWYBguHGvXI
         xCtL46y0Ly2kWkCso+Mw6qJhYQqOnGa5NlvVRy4cFWQc9B4vwS7kIDIbym4yvRe+JU
         IhoE4jvmgszTg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: fix gtk offload status event locking
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231019155342.31631-1-johan+linaro@kernel.org>
References: <20231019155342.31631-1-johan+linaro@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>, stable@vger.kernel.org,
        Carl Huang <quic_cjhuang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169822807368.891844.11001606844056073292.kvalo@kernel.org>
Date:   Wed, 25 Oct 2023 10:01:15 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johan Hovold <johan+linaro@kernel.org> wrote:

> The ath11k active pdevs are protected by RCU but the gtk offload status
> event handling code calling ath11k_mac_get_arvif_by_vdev_id() was not
> marked as a read-side critical section.
> 
> Mark the code in question as an RCU read-side critical section to avoid
> any potential use-after-free issues.
> 
> Compile tested only.
> 
> Fixes: a16d9b50cfba ("ath11k: support GTK rekey offload")
> Cc: stable@vger.kernel.org      # 5.18
> Cc: Carl Huang <quic_cjhuang@quicinc.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

1dea3c0720a1 wifi: ath11k: fix gtk offload status event locking

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231019155342.31631-1-johan+linaro@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

