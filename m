Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64483784013
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235450AbjHVLvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbjHVLvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:51:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8144CE9;
        Tue, 22 Aug 2023 04:51:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1605F60EA7;
        Tue, 22 Aug 2023 11:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B784EC433C7;
        Tue, 22 Aug 2023 11:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692705037;
        bh=K6qHsHNv+YaJ8gAyRbjPMOoeo0yAFJvWTILnD6NXzrE=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=BYLhxbdeFsyimUU8GJSdxRrKPCK6Gd07fV1royD5DhJEqaBUYAbh7bKX0+oGhxcy6
         17M/uHiscpfnpBqHsRMxJyXlBxuz1idjNnUzaAJuWL63sBDrs81MavnaslSZ0695oe
         12nDHMLoqoxANE9UsgMX/a/xJ7ANCprbT900470mZBoHiAo0XoyzoMO09P7vWboUv9
         pdWz+TXROq7UDq55fpVk/1fdtVGFJ1NAv+lwVfyl4IfT04BYZkXJ8iBtTxP2EyQVsD
         WvcC9PyM8/F0DS0ss7x0b7qZQshyB/G3twsl04XTcf49Mf17CE4rrLrGR8GGUEPH1q
         OqtNtkRD2adYA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Qiang Yu <quic_qianyu@quicinc.com>
Cc:     mani@kernel.org, quic_jhugo@quicinc.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_cang@quicinc.com, quic_mrana@quicinc.com
Subject: Re: [PATCH v2] mhi: host: Add standard ELF header image download
 functionality
References: <1691395192-16090-1-git-send-email-quic_qianyu@quicinc.com>
Date:   Tue, 22 Aug 2023 14:51:33 +0300
In-Reply-To: <1691395192-16090-1-git-send-email-quic_qianyu@quicinc.com>
        (Qiang Yu's message of "Mon, 7 Aug 2023 15:59:52 +0800")
Message-ID: <87edjvwb0a.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qiang Yu <quic_qianyu@quicinc.com> writes:

> From: Mayank Rana <quic_mrana@quicinc.com>
>
> Some devices (e.g. WLAN chips) are unable to handle the non-standard ELF
> format of the FBC image and thus need special handling of the FBC image.
>
> Add standard_elf_image flag which makes decision in terms of how FBC image
> based AMSS image is being downloaded with connected endpoint.
> FBC image is having two image combine: SBL image + AMSS image.
> 1. FBC image download using legacy single ELF header image format:
> - SBL image: 512KB of FBC image is downloaded using BHI.
> - AMSS image: full FBC image is downloaded using BHIe.
> 2. FBC image download using separate ELF header image format:
> - SBL image: 512 KB of FBC image is downloaded using BHI.
> - AMSS image: 512 KB onward FBC image is downloaded using BHIe.
> There is no change for SBL image download. Although AMSS image start
> address is end address of SBL image while using separate ELF header format.
>
> Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
> [quic_qianyu@quicinc.com: Update commit message, minor updates]
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>

I guess this is for an out-of-tree driver? I haven't heard any such
requirements for ath11k or ath12k.

> --- a/drivers/bus/mhi/host/boot.c
> +++ b/drivers/bus/mhi/host/boot.c
> @@ -495,6 +495,13 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
>  	 * device transitioning into MHI READY state
>  	 */
>  	if (mhi_cntrl->fbc_download) {
> +		dev_dbg(dev, "standard_elf_image: %s\n",
> +				(mhi_cntrl->standard_elf_image ? "True" : "False"));
> +		if (mhi_cntrl->standard_elf_image) {
> +			fw_data = firmware->data + mhi_cntrl->sbl_size;
> +			fw_sz = fw_sz - mhi_cntrl->sbl_size;
> +		}

So you are basically skipping the first sbl_size bytes of the firmware
file? Why not just fix the firmware file in userspace? Or maybe you can
use the recently added[1] mhi_cntrl->fw_data pointer and handle this in
your driver instead?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git/commit/?h=mhi-next&id=efe47a18e43f59f063a82ccaa464a3b4844bb8a8

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
