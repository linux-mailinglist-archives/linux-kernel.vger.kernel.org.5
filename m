Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BBF07FEFB7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345477AbjK3NEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbjK3NEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:04:43 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABC910C9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:04:48 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2c9cb021d5bso7452661fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1701349486; x=1701954286; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=h/AzIgZ69SVJZSauMwI8prGr2BbJN9IKqCBcn3NqUkQ=;
        b=F3Dp+TMvaadI4cZbO2I/GFr/IFY23uaTFMDkr+YIjddiGBnV/t0ZAexsDnEXgkCYeM
         Y/UPg+6z8wnf/amhyJ45hiljnM47xtyEQrg942wke3pguzt6FS1Tzk3CispoUEOhj8BF
         2/ly6TtP7+gLMNycDLPleVLzWeIJvk/hHbav88iSWmcVfn2qF28og6p1ijWKQCeocbxT
         EUs3i5aUS5VgzB4O5MUuw7OPsTDuHiAgMIq7ZHZwIeNyfFUe9dV4O/jv2fhNGnkOVjcs
         VVGqCyueqgxSGa7lQucOV4JBUstsM/h7oBMjrvtqcMqvApRaK0QxWKLv3rbL+MhSKb2n
         lXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701349486; x=1701954286;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h/AzIgZ69SVJZSauMwI8prGr2BbJN9IKqCBcn3NqUkQ=;
        b=ozNn01Rgp3YiVwMiaR/CxzYl13Yais/poBSjK7+vvCq2/NjPV7eP9QTU4bjxaJKTOw
         /g0cV0wTmLt49mZ2O3ZrBj5cFW6HWQ9oVWQHIVoZh/EDqc2C2H7KPdHQokyiYEj9HfaW
         ye40UuDYLLJJI5bJJ3z7vw3JnR6GC9JlxIGoyczpjjxGrct6K/26ZArZSZRbLxW1Ptsx
         E4v+jxIjWWyEpaXOdWkDEQxwSEb7+xWCNvKzbo6kaIBKeixz8s0Ae28zwK5LOzMENUKC
         6uSXFj1twCW4nRGXnsJO/wKPWfNthpg6JFsm5CfwsqxZ69Sz5br60pd3kc4bbshdBC5d
         PPxw==
X-Gm-Message-State: AOJu0YxXgSxJ/LzMOliKq6zddnH8UC8JPKQCY6lylBEyCuoJKxGHUVe9
        26aGAd/hvQm6CMgUEyBFI6GPvA==
X-Google-Smtp-Source: AGHT+IE1KLEzmFe6iRfuCQKLGfgAiigHt59xNIPso/kj+zapqR/sE73oKWAyTaPuIAHgCgyPG3iwaQ==
X-Received: by 2002:a05:651c:11:b0:2c9:c396:fe30 with SMTP id n17-20020a05651c001100b002c9c396fe30mr3163531lja.43.1701349486204;
        Thu, 30 Nov 2023 05:04:46 -0800 (PST)
Received: from localhost ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id s8-20020a05600c45c800b00405c7591b09sm1962197wmo.35.2023.11.30.05.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 05:04:45 -0800 (PST)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
To:     Sebastian Fricke <sebastian.fricke@collabora.com>
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
In-Reply-To: <20231130103957.ww56zdspv2sw2lrr@basti-XPS-13-9310>
References: <20231129-wave5-panic-v1-1-e0fb5a1a8af4@baylibre.com>
 <20231130103957.ww56zdspv2sw2lrr@basti-XPS-13-9310>
Date:   Thu, 30 Nov 2023 14:04:44 +0100
Message-ID: <8734wnxuhf.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On jeu., nov. 30, 2023 at 11:39, Sebastian Fricke <sebastian.fricke@collabora.com> wrote:

> Hello Mattijs,
>
> Thanks for the patch!

Thank you for the prompt response/review.

>
> On 29.11.2023 11:37, Mattijs Korpershoek wrote:
>>The display frame region information received from the vpu also
>>contains the frame display index: info->index_frame_display.
>>
>>This index, being a s32, can be negative when a skip option is passed.
>>In that case, its value is DECODED_IDX_FLAG_SKIP (-2).
>>
>>When disp_idx == -2, the following exception occurs:
>
> Could you please highlight how you were able to produce this error? For
> example by providing the file you decoded in combination with the
> command that you used. (Please also provide the version of userspace you use)

My userspace is Android, based on Android 14.
The Android sources are described in this manifest:
https://gitlab.baylibre.com/baylibre/ti/android/aosp/manifest

The above sources are very close to AOSP mainline. We do not patch
frameworks/av, which is where most of the multimedia stuff lives.

For the decoding/encoding logic, we use the AOSP provided v4l2_codec2 HAL:
https://android.googlesource.com/platform/external/v4l2_codec2/

We apply some patches on top, mainly to fix android integration and to
force NV12 as platform specific pixel format.
This is my development branch for that:
https://gitlab.baylibre.com/baylibre/ti/android/aosp/external/v4l2_codec2/-/commits/mkorpershoek/v4l2-codec2

The command I use for decoding on the host is:
$ atest android.media.player.cts.MediaPlayerTest#testLocalVideo_MP4_H264_480x360_500kbps_25fps_AAC_Stereo_128kbps_44110Hz

This triggers a media player test on Android that will attempt to decode
the following h264 video:

video_480x360_mp4_h264_500kbps_25fps_aac_stereo_128kbps_44100hz.mp4

This file can be downloaded from Google directly:
https://dl.google.com/android/xts/cts/tests/tests/media/player/CtsMediaPlayerTestCases-2.1.zip

I hope the explanations will are sufficient. I do not consider
myself very knowledgeable on media/v4l2 so please let me know if you
need more details.

Thanks!
Mattijs

>
> Greetings,
> Sebastian
>
>>
>>[ 1530.782246][ T1900] Hardware name: Texas Instruments AM62P5 SK (DT)
>>[ 1530.788501][ T1900] pstate: a0400005 (NzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>[ 1530.796144][ T1900] pc : wave5_vpu_dec_get_output_info+0x300/0x308 [wave5]
>>[ 1530.803060][ T1900] lr : wave5_vpu_dec_get_output_info+0x80/0x308 [wave5]
>>[ 1530.809873][ T1900] sp : ffffffc00b85bc00
>>[ 1530.813872][ T1900] x29: ffffffc00b85bc00 x28: 0000000000000000 x27: 0000000000000001
>>[ 1530.821695][ T1900] x26: 00000000fffffffd x25: 00000000ffffffff x24: ffffff8812820000
>>[ 1530.829516][ T1900] x23: ffffff88199f7840 x22: ffffff8873f5e000 x21: ffffffc00b85bc58
>>[ 1530.837336][ T1900] x20: 0000000000000000 x19: ffffff88199f7920 x18: ffffffc00a899030
>>[ 1530.845156][ T1900] x17: 00000000529c6ef0 x16: 00000000529c6ef0 x15: 0000000000198487
>>[ 1530.852975][ T1900] x14: ffffffc009f2b650 x13: 0000000000058016 x12: 0000000005000000
>>[ 1530.860795][ T1900] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
>>[ 1530.868615][ T1900] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000004086
>>[ 1530.876434][ T1900] x5 : 0000000000000001 x4 : ffffffc001454b94 x3 : ffffffc001454d94
>>[ 1530.884256][ T1900] x2 : ffffffc00b8201d0 x1 : 0000000000000020 x0 : 0000000000000000
>>[ 1530.892087][ T1900] Call trace:
>>[ 1530.895225][ T1900]  wave5_vpu_dec_get_output_info+0x300/0x308 [wave5]
>>[ 1530.901788][ T1900]  wave5_vpu_dec_finish_decode+0x6c/0x3dc [wave5]
>>[ 1530.908081][ T1900]  wave5_vpu_irq_thread+0x140/0x168 [wave5]
>>[ 1530.913856][ T1900]  irq_thread_fn+0x44/0xa4
>>[ 1530.918154][ T1900]  irq_thread+0x15c/0x288
>>[ 1530.922330][ T1900]  kthread+0x104/0x1d4
>>[ 1530.926247][ T1900]  ret_from_fork+0x10/0x20
>>[ 1530.930520][ T1900] Code: 2a1f03ea 2a1f03eb 35ffef2c 17ffff74 (d42aa240)
>>[ 1530.937296][ T1900] ---[ end trace 0000000000000000 ]---
>>[ 1530.942596][ T1900] Kernel panic - not syncing: BRK handler: Fatal exception
>>[ 1530.949629][ T1900] SMP: stopping secondary CPUs
>>[ 1530.954244][ T1900] Kernel Offset: disabled
>>[ 1530.958415][ T1900] CPU features: 0x00,00000000,00800184,0000421b
>>[ 1530.964496][ T1900] Memory Limit: none
>>
>>Move the disp_info assignment after testing that the index is positive
>>to avoid the exception.
>>
>>Fixes: 45d1a2b93277 ("media: chips-media: wave5: Add vpuapi layer")
>>Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>>---
>> drivers/media/platform/chips-media/wave5/wave5-vpuapi.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>>diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
>>index 86b3993722db..1a3efb638dde 100644
>>--- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
>>+++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
>>@@ -508,8 +508,8 @@ int wave5_vpu_dec_get_output_info(struct vpu_instance *inst, struct dec_output_i
>> 	info->rc_decoded = rect_info;
>>
>> 	disp_idx = info->index_frame_display;
>>-	disp_info = &p_dec_info->dec_out_info[disp_idx];
>> 	if (info->index_frame_display >= 0 && info->index_frame_display < WAVE5_MAX_FBS) {
>>+		disp_info = &p_dec_info->dec_out_info[disp_idx];
>> 		if (info->index_frame_display != info->index_frame_decoded) {
>> 			/*
>> 			 * when index_frame_decoded < 0, and index_frame_display >= 0
>>
>>---
>>base-commit: a00b3f296eac3d43328615c3113e1a74143fc67a
>>change-id: 20231129-wave5-panic-82ea2d30042f
>>
>>Best regards,
>>-- 
>>Mattijs Korpershoek <mkorpershoek@baylibre.com>
>>
