Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9097FED0A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 11:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345034AbjK3KkD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 05:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjK3Kj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 05:39:57 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04C810D1;
        Thu, 30 Nov 2023 02:40:02 -0800 (PST)
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sebastianfricke)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 48475660734A;
        Thu, 30 Nov 2023 10:40:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1701340801;
        bh=AdotPY2L4+LC5TF4e4060sRHPk0QN7bk3M/fEcvXxbs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FvqR0lKUYrlQzvI5ASO6O9CklMshxz7OJ+BfeuD/HckzftCMTGTurQW8WvrcW6xio
         1ObyPlXKseFiTZX1/Zj7VuAFBt/8p1IyZS2/x6EwGu8WSerfqdta3De65BAN+snytC
         HBhF+MEQNY08QZDOHda1DpzsgXQTnXRzcJQSdOarD/1gxiH8MBtsm+LubJJBsLW4Xd
         PHqarsAi6kGHSJYStZx/pqCIwDXMKeFv+rOiPLux4/Ph52j6/ROPglL8HUZEJ3oTj8
         wzHFInOK8Ju23d5vd4OxkDjcwxMYNmssYRlXXDdrDf4GKbz1YKVJ7VlwdH0Iu2qFDd
         pNvErACcILPFw==
Date:   Thu, 30 Nov 2023 11:39:57 +0100
From:   Sebastian Fricke <sebastian.fricke@collabora.com>
To:     Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc:     Nas Chung <nas.chung@chipsnmedia.com>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Guillaume La Roque <glaroque@baylibre.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Deborah Brouwer <deborah.brouwer@collabora.com>,
        Brandon Brnich <b-brnich@ti.com>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: chips-media: wave5: fix panic on decoding
 DECODED_IDX_FLAG_SKIP
Message-ID: <20231130103957.ww56zdspv2sw2lrr@basti-XPS-13-9310>
References: <20231129-wave5-panic-v1-1-e0fb5a1a8af4@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20231129-wave5-panic-v1-1-e0fb5a1a8af4@baylibre.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mattijs,

Thanks for the patch!

On 29.11.2023 11:37, Mattijs Korpershoek wrote:
>The display frame region information received from the vpu also
>contains the frame display index: info->index_frame_display.
>
>This index, being a s32, can be negative when a skip option is passed.
>In that case, its value is DECODED_IDX_FLAG_SKIP (-2).
>
>When disp_idx == -2, the following exception occurs:

Could you please highlight how you were able to produce this error? For
example by providing the file you decoded in combination with the
command that you used. (Please also provide the version of userspace you use)

Greetings,
Sebastian

>
>[ 1530.782246][ T1900] Hardware name: Texas Instruments AM62P5 SK (DT)
>[ 1530.788501][ T1900] pstate: a0400005 (NzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>[ 1530.796144][ T1900] pc : wave5_vpu_dec_get_output_info+0x300/0x308 [wave5]
>[ 1530.803060][ T1900] lr : wave5_vpu_dec_get_output_info+0x80/0x308 [wave5]
>[ 1530.809873][ T1900] sp : ffffffc00b85bc00
>[ 1530.813872][ T1900] x29: ffffffc00b85bc00 x28: 0000000000000000 x27: 0000000000000001
>[ 1530.821695][ T1900] x26: 00000000fffffffd x25: 00000000ffffffff x24: ffffff8812820000
>[ 1530.829516][ T1900] x23: ffffff88199f7840 x22: ffffff8873f5e000 x21: ffffffc00b85bc58
>[ 1530.837336][ T1900] x20: 0000000000000000 x19: ffffff88199f7920 x18: ffffffc00a899030
>[ 1530.845156][ T1900] x17: 00000000529c6ef0 x16: 00000000529c6ef0 x15: 0000000000198487
>[ 1530.852975][ T1900] x14: ffffffc009f2b650 x13: 0000000000058016 x12: 0000000005000000
>[ 1530.860795][ T1900] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
>[ 1530.868615][ T1900] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000004086
>[ 1530.876434][ T1900] x5 : 0000000000000001 x4 : ffffffc001454b94 x3 : ffffffc001454d94
>[ 1530.884256][ T1900] x2 : ffffffc00b8201d0 x1 : 0000000000000020 x0 : 0000000000000000
>[ 1530.892087][ T1900] Call trace:
>[ 1530.895225][ T1900]  wave5_vpu_dec_get_output_info+0x300/0x308 [wave5]
>[ 1530.901788][ T1900]  wave5_vpu_dec_finish_decode+0x6c/0x3dc [wave5]
>[ 1530.908081][ T1900]  wave5_vpu_irq_thread+0x140/0x168 [wave5]
>[ 1530.913856][ T1900]  irq_thread_fn+0x44/0xa4
>[ 1530.918154][ T1900]  irq_thread+0x15c/0x288
>[ 1530.922330][ T1900]  kthread+0x104/0x1d4
>[ 1530.926247][ T1900]  ret_from_fork+0x10/0x20
>[ 1530.930520][ T1900] Code: 2a1f03ea 2a1f03eb 35ffef2c 17ffff74 (d42aa240)
>[ 1530.937296][ T1900] ---[ end trace 0000000000000000 ]---
>[ 1530.942596][ T1900] Kernel panic - not syncing: BRK handler: Fatal exception
>[ 1530.949629][ T1900] SMP: stopping secondary CPUs
>[ 1530.954244][ T1900] Kernel Offset: disabled
>[ 1530.958415][ T1900] CPU features: 0x00,00000000,00800184,0000421b
>[ 1530.964496][ T1900] Memory Limit: none
>
>Move the disp_info assignment after testing that the index is positive
>to avoid the exception.
>
>Fixes: 45d1a2b93277 ("media: chips-media: wave5: Add vpuapi layer")
>Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>---
> drivers/media/platform/chips-media/wave5/wave5-vpuapi.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
>index 86b3993722db..1a3efb638dde 100644
>--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
>+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
>@@ -508,8 +508,8 @@ int wave5_vpu_dec_get_output_info(struct vpu_instance *inst, struct dec_output_i
> 	info->rc_decoded = rect_info;
>
> 	disp_idx = info->index_frame_display;
>-	disp_info = &p_dec_info->dec_out_info[disp_idx];
> 	if (info->index_frame_display >= 0 && info->index_frame_display < WAVE5_MAX_FBS) {
>+		disp_info = &p_dec_info->dec_out_info[disp_idx];
> 		if (info->index_frame_display != info->index_frame_decoded) {
> 			/*
> 			 * when index_frame_decoded < 0, and index_frame_display >= 0
>
>---
>base-commit: a00b3f296eac3d43328615c3113e1a74143fc67a
>change-id: 20231129-wave5-panic-82ea2d30042f
>
>Best regards,
>-- 
>Mattijs Korpershoek <mkorpershoek@baylibre.com>
>
