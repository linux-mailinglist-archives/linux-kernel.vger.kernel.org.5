Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9B07D5384
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 16:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343562AbjJXN74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234869AbjJXN7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:59:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ECF1D7B;
        Tue, 24 Oct 2023 06:59:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3873C433C8;
        Tue, 24 Oct 2023 13:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698155981;
        bh=dsmBnlL6bvCmPrgmLzqlJBYDPnEdRwCx2sRSLyjJX0Y=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=HtVoJ3OGlu4I0g7c6nceoQtrXqr+/rL/LttZelrFM0wKPsJvPOqfj3iSNYKVJE2LO
         0VIoSplFYuYpBei0qTA6kphdzyD+MgyNNRnl3g0Y03cOt8+rsYfgqp/Utq2z+PeAjy
         hnwOWkkINyyW3UY6nQ4Yx9XSoHwBebK2UXBElN4HVFVQio2wJHThXt/gi8juZoiSaY
         GjtlRiDTlxnqe/i6hB7btQ2B2opfa4avGMl1I7Y2MKxwVt0XwI8Tx2REMWl032JywK
         ZPvLrC1Vor+obo/PRX3UWJ5sDsLwig85VAEOFSrdwAMIB2/t1Uyhydx6Uzwo4bEmhi
         C/r9XXtEq4gjQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] wifi: ath11k: fix temperature event locking
References: <20231019153115.26401-1-johan+linaro@kernel.org>
        <20231019153115.26401-2-johan+linaro@kernel.org>
Date:   Tue, 24 Oct 2023 16:59:35 +0300
In-Reply-To: <20231019153115.26401-2-johan+linaro@kernel.org> (Johan Hovold's
        message of "Thu, 19 Oct 2023 17:31:14 +0200")
Message-ID: <87sf60xgs8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johan Hovold <johan+linaro@kernel.org> writes:

> The ath11k active pdevs are protected by RCU but the temperature event
> handling code calling ath11k_mac_get_ar_by_pdev_id() was not marked as a
> read-side critical section as reported by RCU lockdep:
>
> 	=============================
> 	WARNING: suspicious RCU usage
> 	6.6.0-rc6 #7 Not tainted
> 	-----------------------------
> 	drivers/net/wireless/ath/ath11k/mac.c:638 suspicious rcu_dereference_check() usage!
>
> 	other info that might help us debug this:
>
> 	rcu_scheduler_active = 2, debug_locks = 1
> 	no locks held by swapper/0/0.
> 	...
> 	Call trace:
> 	...
> 	 lockdep_rcu_suspicious+0x16c/0x22c
> 	 ath11k_mac_get_ar_by_pdev_id+0x194/0x1b0 [ath11k]
> 	 ath11k_wmi_tlv_op_rx+0xa84/0x2c1c [ath11k]
> 	 ath11k_htc_rx_completion_handler+0x388/0x510 [ath11k]
>
> Mark the code in question as an RCU read-side critical section to avoid
> any potential use-after-free issues.
>
> Fixes: a41d10348b01 ("ath11k: add thermal sensor device support")
> Cc: stable@vger.kernel.org      # 5.7
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

On what hardware and firmware version did you test this? As there's so
many different combos we use Tested-on tag to provide that information
in the commit message:

https://wireless.wiki.kernel.org/en/users/drivers/ath11k/submittingpatches#tested-on_tag

I can add that if you let me know what you used.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
