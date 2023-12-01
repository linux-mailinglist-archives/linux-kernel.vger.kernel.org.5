Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34C8801431
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 21:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379400AbjLAUSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 15:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjLAUSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 15:18:38 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D8D10E5
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 12:18:44 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-77ecedad216so10493685a.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 12:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1701461923; x=1702066723; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zbcp2+55huQu8CPla8lueZSpUNVj33kTQg+RzcFANMw=;
        b=w9hwIdyS5PRbuxX7aMk5xNmb2foZM7+uA5o6IV3i4Ve/Vtys9fWx6Q2VnzW5pTK6tZ
         vZ4xNsiP5eA9wKY1WQ0+1wmgQv9vuiGyFy9mPX9BfU6LJxy3Q+EsvNJlTmYw023f3I+E
         InFjsWX1WB/tX62cjjZ+6flWjPRzcJP19PEp9xhkv3np5X/dgcV/Us4+BaV1ZbXQUKIA
         H3Ee8UctsKSXovsB8v4xalGA/YYLEtG0xyxcbkq+9XACnmDwhITw3i+nnDSgNlwoaS/L
         kK8zZJGyf0mWGrH5SnT+OFo4ciJSGOLNBkKU/kM1ltQNnuzNzlvdI2aJIdLDESTrF9QM
         TIJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701461923; x=1702066723;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zbcp2+55huQu8CPla8lueZSpUNVj33kTQg+RzcFANMw=;
        b=jTuXmdzpEGZd+bEbdijgZjegsmXGpuKfzq7PdTBX6kOEjBqpyfFuB7yFZwXpv/qhL5
         Su0JzsMHE5+QtyEIJweQNfwPD6r86LLClf27YKdxhV/zfqRRfjd4207EL4u0O9ge8jw4
         eG8ahj7S64K3C4dldTwYWWANFdLzlqNspqy4Zs/uYPRDkN9cg7NDsUQ8xYq6GQWZxUn4
         wWwKmHFQhhs8OiI2K3hh3BDYKeCgb3BXGaHzJ/vCaXDqF5luDqmZHIIspc8Flyh+pp2N
         qke5ZiadERrD2BS46L7V0pP2XADuZb9veXPwktm+8lbHxJ27KE1M79qIjyIiX/QxWIPn
         /BlQ==
X-Gm-Message-State: AOJu0YxEKd3AOZljfKjIMRoKz2vAVQBZwnyvKVgXl8DIJyWYZO/ffbkT
        vrr7P3gj84yssNsGRfaH44Gg6w==
X-Google-Smtp-Source: AGHT+IFFZVY2Y5BOabysTp6MzRHSEt7/6Z7Fuagdwp+VGYsWIecSTvUjtfbdrC/p0Af42tLvNmkdOQ==
X-Received: by 2002:a05:620a:838b:b0:77e:fba3:9d00 with SMTP id pb11-20020a05620a838b00b0077efba39d00mr47167qkn.100.1701461923638;
        Fri, 01 Dec 2023 12:18:43 -0800 (PST)
Received: from nicolas-tpx395.localdomain ([2606:6d00:17:b5c::7a9])
        by smtp.gmail.com with ESMTPSA id pf20-20020a05620a859400b0077dcd786533sm1802471qkn.16.2023.12.01.12.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 12:18:43 -0800 (PST)
Message-ID: <42c1c5e14a30730bc140b6791f25e55d434aa4e3.camel@ndufresne.ca>
Subject: Re: [PATCH] media: chips-media: wave5: fix panic on decoding
 DECODED_IDX_FLAG_SKIP
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Nas Chung <nas.chung@chipsnmedia.com>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Guillaume La Roque <glaroque@baylibre.com>,
        Brandon Brnich <b-brnich@ti.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 01 Dec 2023 15:18:42 -0500
In-Reply-To: <20231129-wave5-panic-v1-1-e0fb5a1a8af4@baylibre.com>
References: <20231129-wave5-panic-v1-1-e0fb5a1a8af4@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mattijs,

Le mercredi 29 novembre 2023 =C3=A0 11:37 +0100, Mattijs Korpershoek a =C3=
=A9crit=C2=A0:
> The display frame region information received from the vpu also
> contains the frame display index: info->index_frame_display.
>=20
> This index, being a s32, can be negative when a skip option is passed.
> In that case, its value is DECODED_IDX_FLAG_SKIP (-2).
>=20
> When disp_idx =3D=3D -2, the following exception occurs:
>=20
> [ 1530.782246][ T1900] Hardware name: Texas Instruments AM62P5 SK (DT)
> [ 1530.788501][ T1900] pstate: a0400005 (NzCv daif +PAN -UAO -TCO -DIT -S=
SBS BTYPE=3D--)
> [ 1530.796144][ T1900] pc : wave5_vpu_dec_get_output_info+0x300/0x308 [wa=
ve5]
> [ 1530.803060][ T1900] lr : wave5_vpu_dec_get_output_info+0x80/0x308 [wav=
e5]
> [ 1530.809873][ T1900] sp : ffffffc00b85bc00
> [ 1530.813872][ T1900] x29: ffffffc00b85bc00 x28: 0000000000000000 x27: 0=
000000000000001
> [ 1530.821695][ T1900] x26: 00000000fffffffd x25: 00000000ffffffff x24: f=
fffff8812820000
> [ 1530.829516][ T1900] x23: ffffff88199f7840 x22: ffffff8873f5e000 x21: f=
fffffc00b85bc58
> [ 1530.837336][ T1900] x20: 0000000000000000 x19: ffffff88199f7920 x18: f=
fffffc00a899030
> [ 1530.845156][ T1900] x17: 00000000529c6ef0 x16: 00000000529c6ef0 x15: 0=
000000000198487
> [ 1530.852975][ T1900] x14: ffffffc009f2b650 x13: 0000000000058016 x12: 0=
000000005000000
> [ 1530.860795][ T1900] x11: 0000000000000000 x10: 0000000000000000 x9 : 0=
000000000000000
> [ 1530.868615][ T1900] x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0=
000000000004086
> [ 1530.876434][ T1900] x5 : 0000000000000001 x4 : ffffffc001454b94 x3 : f=
fffffc001454d94
> [ 1530.884256][ T1900] x2 : ffffffc00b8201d0 x1 : 0000000000000020 x0 : 0=
000000000000000
> [ 1530.892087][ T1900] Call trace:
> [ 1530.895225][ T1900]  wave5_vpu_dec_get_output_info+0x300/0x308 [wave5]
> [ 1530.901788][ T1900]  wave5_vpu_dec_finish_decode+0x6c/0x3dc [wave5]
> [ 1530.908081][ T1900]  wave5_vpu_irq_thread+0x140/0x168 [wave5]
> [ 1530.913856][ T1900]  irq_thread_fn+0x44/0xa4
> [ 1530.918154][ T1900]  irq_thread+0x15c/0x288
> [ 1530.922330][ T1900]  kthread+0x104/0x1d4
> [ 1530.926247][ T1900]  ret_from_fork+0x10/0x20
> [ 1530.930520][ T1900] Code: 2a1f03ea 2a1f03eb 35ffef2c 17ffff74 (d42aa24=
0)
> [ 1530.937296][ T1900] ---[ end trace 0000000000000000 ]---
> [ 1530.942596][ T1900] Kernel panic - not syncing: BRK handler: Fatal exc=
eption
> [ 1530.949629][ T1900] SMP: stopping secondary CPUs
> [ 1530.954244][ T1900] Kernel Offset: disabled
> [ 1530.958415][ T1900] CPU features: 0x00,00000000,00800184,0000421b
> [ 1530.964496][ T1900] Memory Limit: none
>=20
> Move the disp_info assignment after testing that the index is positive
> to avoid the exception.
>=20
> Fixes: 45d1a2b93277 ("media: chips-media: wave5: Add vpuapi layer")
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  drivers/media/platform/chips-media/wave5/wave5-vpuapi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c b/dr=
ivers/media/platform/chips-media/wave5/wave5-vpuapi.c
> index 86b3993722db..1a3efb638dde 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpuapi.c
> @@ -508,8 +508,8 @@ int wave5_vpu_dec_get_output_info(struct vpu_instance=
 *inst, struct dec_output_i
>  	info->rc_decoded =3D rect_info;
> =20
>  	disp_idx =3D info->index_frame_display;
> -	disp_info =3D &p_dec_info->dec_out_info[disp_idx];
>  	if (info->index_frame_display >=3D 0 && info->index_frame_display < WAV=
E5_MAX_FBS) {
> +		disp_info =3D &p_dec_info->dec_out_info[disp_idx];

I could not reproduce the crash, it probably depends on the compiler versio=
n and
compiler options. This negative index should normally generate a pointer, e=
ven
if that points to bad location. I'd like to understand how that lead to a c=
rash.
If you have further information on this, I really like to get to the bottom=
 on
these subjects.

Meanwhile, this fix is obviously correct, we should not do that unless we h=
ave a
valid index.

Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

>  		if (info->index_frame_display !=3D info->index_frame_decoded) {
>  			/*
>  			 * when index_frame_decoded < 0, and index_frame_display >=3D 0
>=20
> ---
> base-commit: a00b3f296eac3d43328615c3113e1a74143fc67a
> change-id: 20231129-wave5-panic-82ea2d30042f
>=20
> Best regards,

