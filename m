Return-Path: <linux-kernel+bounces-66118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3225855735
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18753B25058
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE3E1419AD;
	Wed, 14 Feb 2024 23:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Vq1TpUkH"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71B41419A6
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 23:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707953047; cv=none; b=hKAQ31bavy4Qsli0oEApizV9Ey7gDVdV2nF8tuHimwh+MdvLjBq/AxKOC+MBdFWEbwpzEYptLy+p5kXqCGJC6o0N25WnU+hox9/QCGBe+GyT3NAvjA/WYObx4yGM0aoNC2N/3vF2bVkXNH+uIHMV0erZpdgqQupbE4+sx8mMyI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707953047; c=relaxed/simple;
	bh=LXb9zvEAUj4G5USS7QdqgXSFhyO7Zsv4kbBM0PVwyEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bIgR3IHFJWWkJ6gsy3hUhtVWA9T7vyi5G8wVk6hJ9/INXDzz5GEtmX/k5IwBixLQ7rDNMpjWVu5SJS2SkDLoRJpt1yxGzK6N09SGKpjWE1M5HhUzBxz1qpkiBNdSfTOA42aeoXpxd695lVyIDg6nxrrcILhGP1JGkq9XE3Teics=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Vq1TpUkH; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e0a5472e7cso235949b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 15:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707953045; x=1708557845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RDEb+rnLgfUtd9dyUQwW7lwMH92r2hAhL3LLKomhzZc=;
        b=Vq1TpUkHcNeeQt0Xpda0VRShLH30WtVU+Ebu5HhoQkpj879uTEK4xL6ulXia+qOuzo
         X4mO3xOljhVchfsRBfLUzfwVk9RCHYO0oy0Z7VP5QEfvRvM8+o/mIKwNkXVf9Dzaxte9
         pyxLtPohhpdn7s1H/1logWhGCL0sMs0PwYIWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707953045; x=1708557845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RDEb+rnLgfUtd9dyUQwW7lwMH92r2hAhL3LLKomhzZc=;
        b=oMWI6/CWog4Wh8afNDBU8u3NxhoZ2tFIDfCshwW4liiy4ys8c7H0q3y0SY4DeAjaXY
         XtO/deH6+sd+aenuN5U3gQSNK3wiCYHFSuwAB7RK2ZGeHT57cuxBW/PwQiQREBYbijQN
         81x/G5zV68O50bEGGAN7xW6NPFFtQG8/YDoHB67Q5LHgQA9L/7NWC3S9qFe8IJ0ZhM9i
         g3+IiGTgOUs0QnqHdtisf4kngq2McJ1TukldO/c9McUUaBWzeqaSulyUdJqa6tfh/0Mt
         1HKm4BNVPbPcsLF2CPoI8f04HBlZlAgDBMcGHFPO9sgtey1Bv8Bre0UMJQ4piXwOqHu3
         paIA==
X-Forwarded-Encrypted: i=1; AJvYcCVCsmfeEl0nhGrfNz9se1IqOWSO8OS+RoNEABKLijEiITHLj35f2lYeAM9bUMLdJ/zgMSkHcgkmLmHljgQGiggoygX4BZ3tIPGvZs0V
X-Gm-Message-State: AOJu0Yw2iquAZtTQsvr6OdJB1jzcP9CjaBLdXDLMWsyLEVKuTFaZm2HZ
	O0YoCIWF97C45QWXoetHKqJVRQWxH5G4w9GRTMpOnLMw2OT+XMgBq04rGNBhZdAlOC6HkCPha1E
	Ddg==
X-Google-Smtp-Source: AGHT+IHkhMzJqXVcg5LMKtoWWdc1O6Byt21DZm+LcOJeie0Be4pbw+2k/87g7kxK15qMGjymuxsFbw==
X-Received: by 2002:a05:6a20:9c8b:b0:19a:fad2:518b with SMTP id mj11-20020a056a209c8b00b0019afad2518bmr339247pzb.5.1707953044731;
        Wed, 14 Feb 2024 15:24:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV8+9+49LyyMYlVm0Q23wKQTZcGWEQyrsNGIVv0vid7sqZLm0gvk8D1qw5p53376rZzrBMg5DHafRgov130kZHHskK/dvoB2YLDib/M
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com. [209.85.216.51])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c14c00b001db6594bc27sm1246631plj.14.2024.02.14.15.24.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 15:24:04 -0800 (PST)
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-296cca9169bso283509a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 15:24:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXvmmwUEagv1+lQohueQX7LIzDbXtOqPFRK3J83r/HZRO43E483g4+yYS12YM8IFFKZH72mKFqEwJHO5ryqjL+rEVnfR0TXJ9d2onLR
X-Received: by 2002:ac8:5916:0:b0:42d:c742:3661 with SMTP id
 22-20020ac85916000000b0042dc7423661mr283778qty.25.1707952632988; Wed, 14 Feb
 2024 15:17:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111071713.16331-1-yunfei.dong@mediatek.com> <95daea30-14e6-4c0b-8a0c-60641efc9d92@collabora.com>
In-Reply-To: <95daea30-14e6-4c0b-8a0c-60641efc9d92@collabora.com>
From: Fritz Koenig <frkoenig@chromium.org>
Date: Wed, 14 Feb 2024 15:17:01 -0800
X-Gmail-Original-Message-ID: <CAMfZQbzcg64mO13_2=FCPu5A79f7BqD77OJMXReHKove6vVSFA@mail.gmail.com>
Message-ID: <CAMfZQbzcg64mO13_2=FCPu5A79f7BqD77OJMXReHKove6vVSFA@mail.gmail.com>
Subject: Re: [PATCH] media: mediatek: vcodec: setting request complete before
 buffer done
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: Yunfei Dong <yunfei.dong@mediatek.com>, 
	=?UTF-8?B?TsOtY29sYXMgRiAuIFIgLiBBIC4gUHJhZG8=?= <nfraprado@collabora.com>, 
	Nicolas Dufresne <nicolas.dufresne@collabora.com>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Nathan Hebert <nhebert@chromium.org>, Hsin-Yi Wang <hsinyi@chromium.org>, 
	Fritz Koenig <frkoenig@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, 
	Steve Cho <stevecho@chromium.org>, linux-media@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	Project_Global_Chrome_Upstream_Group@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have seen issues with this patch. It does fix the original issue,
but now some kernel panics are occuring.

[  369.634206] ------------[ cut here ]------------
[  369.634214]  __schedule+0x4bc/0x8b8
[  369.634216] WARNING: CPU: 6 PID: 6520 at
drivers/media/common/videobuf2/videobuf2-core.c:1063
vb2_buffer_done+0x184/0x228 [videobuf2_common]
[  369.634220] Modules linked in:
[  369.634231]  schedule+0x54/0xe0
[  369.634232]  8021q veth rfcomm algif_hash
[  369.634246]  schedule_preempt_disabled+0x2c/0x48
[  369.634247]  algif_skcipher af_alg lzo_rle
[  369.634262]  __mutex_lock+0x138/0x2ac
[  369.634272]  __mutex_lock_slowpath+0x1c/0x28
[  369.634281]  mutex_lock+0x50/0x74
[  369.634306]  fops_vcodec_open+0x5c/0x2e0 [mtk_vcodec_dec
879370ff125adc9fa45bebb553dd6005c95bb957]
[  369.634307]  lzo_compress zram uinput xt_cgroup
[  369.634322]  v4l2_open+0xa8/0x104
[  369.634323]  xt_MASQUERADE mtk_vcodec_dec_hw cros_ec_rpmsg
[  369.634339]  chrdev_open+0x12c/0x1c4
[  369.634340]  mt7921e mt7921_common mt76_connac_lib mt76
[  369.634355]  do_dentry_open+0x114/0x37c
[  369.634367]  vfs_open+0x3c/0x48
[  369.634377]  path_openat+0x1c8/0x8ac
[  369.634378]  mtk_vcodec_dec v4l2_h264 mtk_vcodec_enc v4l2_vp9
[  369.634393]  do_filp_open+0x94/0x11c
[  369.634395]  uvcvideo mtk_vcodec_dbgfs mtk_mdp3
[  369.634409]  do_sys_openat2+0x88/0x220
[  369.634419]  do_sys_open+0x60/0x88
[  369.634420]  mtk_vcodec_common btusb mtk_vpu
[  369.634433]  __arm64_sys_openat+0x30/0x3c
[  369.634435]  btmtk videobuf2_vmalloc btintel videobuf2_dma_contig
[  369.634450]  el0_svc_common+0xcc/0x1cc
[  369.634452]  videobuf2_memops v4l2_mem2mem videobuf2_v4l2 btbcm
[  369.634465]  do_el0_svc+0x30/0x90
[  369.634467]  btrtl videobuf2_common mac80211 cros_ec_typec
[  369.634480]  el0_svc+0x10/0x1c
[  369.634481]  typec
[  369.634491] PDLOG 2024/01/27 21:48:10.904 P0 SNK Charger ???
15175mV max 15000mV / 3000mA
[  369.634492]  snd_sof_mt8195 mtk_scp
[  369.634506]  el0_sync_handler+0x78/0x108
[  369.634507]  mtk_rpmsg snd_sof_xtensa_dsp
[  369.634520]  el0_sync+0x184/0x1c0
[  369.634521]  rpmsg_core mtk_adsp_common adsp_pcm mtk_scp_ipi
snd_sof_of snd_sof snd_sof_utils ip6table_nat fuse bluetooth
ecdh_generic ecc cfg80211 iio_trig_sysfs cros_ec_lid_angle
cros_ec_sensors cros_ec_sensors_core industrialio_triggered_buffer
kfifo_buf cros_ec_sensorhub r8153_ecm cdc_ether usbnet r8152 mii
joydev
[  369.634539] CPU: 6 PID: 6520 Comm: ThreadPoolForeg Tainted: G
 W         5.10.208-24103-g572c076ef3bf #1
69a06d15b220b7bbb6ae94835957d4263c132312
[  369.634540] Hardware name: MediaTek Tomato board (DT)
[  369.634541] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO BTYPE=3D--)
[  369.634544] pc : vb2_buffer_done+0x184/0x228 [videobuf2_common]
[  369.634546] lr : vb2ops_vdec_stop_streaming+0x58/0x130 [mtk_vcodec_dec]
[  369.634547] sp : ffffffc015be3a40
[  369.634548] x29: ffffffc015be3a40 x28: 0000000000000013
[  369.634550] x27: ffffffc015be3c70
[  369.634554] Kernel panic - not syncing: hung_task: blocked tasks
[  369.634556] x26: ffffffd6141bea30
[  369.634563] x25: ffffff8d656e6020 x24: ffffff8d16fc0500
[  369.634573] CPU: 3 PID: 68 Comm: khungtaskd Tainted: G        W
    5.10.208-24103-g572c076ef3bf #1
69a06d15b220b7bbb6ae94835957d4263c132312
[  369.634574] x23: ffffff8d68cc94d0 x22: ffffff8d656e6328
[  369.634585] Hardware name: MediaTek Tomato board (DT)
[  369.634586] x21: 0000000000000000 x20: ffffff8d656e6208
[  369.634592] Call trace:
[  369.634593] x19: ffffff8d656e6000 x18: 0000000000001000
[  369.634604]  dump_backtrace+0x0/0x1e8
[  369.634605] x17: 6165642820314e4f x16: ffffffd68b3da1ac
[  369.634614]  show_stack+0x20/0x2c
[  369.634616] x15: 4c20736920747865 x14: 0000000000000003
[  369.634625]  dump_stack+0xd8/0x134
[  369.634626] x13: 0000000000000004 x12: 000000017a6a3d80
[  369.634635]  panic+0x168/0x3b4
[  369.634636] x11: c000000104dcc4c1 x10: 00000000ffffffff
[  369.634648]  hung_task_panic+0x0/0x3c
[  369.634649] x9 : ffffffd6141ba860 x8 : 0000000000000000
[  369.634660]  kthread+0x140/0x150
[  369.634662] x7 : 0000000000000000 x6 : 362e39363320205b
[  369.634671]  ret_from_fork+0x10/0x30
[  369.634673] x5 : ffffffd68c1a9e40 x4 : 0000000000000000
[  369.634676] x3 : ffffffc015be36a8 x2 : ffffffc015be36b0
[  369.634678] x1 : 0000000000000006 x0 : ffffff8d79780400
[  369.634680] Call trace:
[  369.634682]  vb2_buffer_done+0x184/0x228 [videobuf2_common
90d29a32bbd63b16e1c5ddef29383225f924f6e6]
[  369.634684]  vb2ops_vdec_stop_streaming+0x58/0x130 [mtk_vcodec_dec
879370ff125adc9fa45bebb553dd6005c95bb957]
[  369.634687] SMP: stopping secondary CPUs
[  369.634690]  __vb2_queue_cancel+0x40/0x1f0 [videobuf2_common
90d29a32bbd63b16e1c5ddef29383225f924f6e6]
[  369.634695]  vb2_core_streamoff+0x30/0xb4 [videobuf2_common
90d29a32bbd63b16e1c5ddef29383225f924f6e6]
[  369.634699]  vb2_streamoff+0x38/0x60 [videobuf2_v4l2
57948a05e97f8b4aaa75f86af62463f9372d2eda]
[  369.634702]  v4l2_m2m_streamoff+0x60/0x13c [v4l2_mem2mem
b612f8be320a497ae465ef738b2ab624e86ad82f]
[  369.634703]  v4l2_m2m_ioctl_streamoff+0x20/0x2c [v4l2_mem2mem
b612f8be320a497ae465ef738b2ab624e86ad82f]
[  369.634705]  v4l_streamoff+0x2c/0x38
[  369.634707]  __video_do_ioctl+0x2c4/0x3dc
[  369.634709]  video_usercopy+0x6d8/0xfac
[  369.634711]  video_ioctl2+0x20/0x2c
[  369.634712]  v4l2_ioctl+0x54/0x64
[  369.634714]  __arm64_sys_ioctl+0x98/0xd0
[  369.634716]  el0_svc_common+0xcc/0x1cc
[  369.634718]  do_el0_svc+0x30/0x90
[  369.634720]  el0_svc+0x10/0x1c
[  369.634722]  el0_sync_handler+0x78/0x108
[  369.634723]  el0_sync+0x184/0x1c0
[  369.634725] ---[ end trace bf910434181f5b65 ]---
[  369.634735] Kernel Offset: 0x167a800000 from 0xffffffc010000000
[  369.634747] PHYS_OFFSET: 0xfffffff400000000
[  369.634760] CPU features: 0x08040026,6a80aa38
[  369.634770] Memory Limit: none


On Thu, Jan 11, 2024 at 1:15=E2=80=AFAM Benjamin Gaignard
<benjamin.gaignard@collabora.com> wrote:
>
>
> Le 11/01/2024 =C3=A0 08:17, Yunfei Dong a =C3=A9crit :
> > The request status of output queue will be set to MEDIA_REQUEST_STATE_C=
OMPLETE
> > when user space dequeue output buffer. Then calling v4l2_ctrl_request_c=
omplete
> > will get below warning, need to call v4l2_ctrl_request_complete before
> > v4l2_m2m_buf_done.
> > Workqueue: core-decoder vdec_msg_queue_core_work [mtk_vcodec_dec]
> > pstate: 80c00089 (Nzcv daIf +PAN +UAO -TCO BTYPE=3D--)
> > pc : media_request_object_bind+0xa8/0x124
> > lr : media_request_object_bind+0x50/0x124
> > sp : ffffffc011393be0
> > x29: ffffffc011393be0 x28: 0000000000000000
> > x27: ffffff890c280248 x26: ffffffe21a71ab88
> > x25: 0000000000000000 x24: ffffff890c280280
> > x23: ffffff890c280280 x22: 00000000fffffff0
> > x21: 0000000000000000 x20: ffffff890260d280
> > x19: ffffff890260d2e8 x18: 0000000000001000
> > x17: 0000000000000400 x16: ffffffe21a4584a0
> > x15: 000000000053361d x14: 0000000000000018
> > x13: 0000000000000004 x12: ffffffa82427d000
> > x11: ffffffe21ac3fce0 x10: 0000000000000001
> > x9 : 0000000000000000 x8 : 0000000000000003
> > x7 : 0000000000000000 x6 : 000000000000003f
> > x5 : 0000000000000040 x4 : ffffff89052e7b98
> > x3 : 0000000000000000 x2 : 0000000000000001
> > x1 : 0000000000000000 x0 : 0000000000000000
> > Call trace:
> >   media_request_object_bind+0xa8/0x124
> >   v4l2_ctrl_request_bind+0xc4/0x168
> >   v4l2_ctrl_request_complete+0x198/0x1f4
> >   mtk_vdec_stateless_cap_to_disp+0x58/0x8c [mtk_vcodec_dec 245a7c1e48ff=
1b2451a50e1dfcb174262b6b462c]
> >   vdec_vp9_slice_core_decode+0x1c0/0x268 [mtk_vcodec_dec 245a7c1e48ff1b=
2451a50e1dfcb174262b6b462c]
> >   vdec_msg_queue_core_work+0x60/0x11c [mtk_vcodec_dec 245a7c1e48ff1b245=
1a50e1dfcb174262b6b462c]
> >   process_one_work+0x140/0x480
> >   worker_thread+0x12c/0x2f8
> >   kthread+0x13c/0x1d8
> >   ret_from_fork+0x10/0x30
> >
> > 'Fixes: 7b182b8d9c852 ("media: mediatek: vcodec: Refactor get and put c=
apture buffer flow")'
> > Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
>
> Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>
> > ---
> >   .../mediatek/vcodec/decoder/mtk_vcodec_dec_drv.h     |  3 ++-
> >   .../vcodec/decoder/mtk_vcodec_dec_stateless.c        | 12 +++++++----=
-
> >   .../vcodec/decoder/vdec/vdec_av1_req_lat_if.c        |  7 +++++--
> >   .../vcodec/decoder/vdec/vdec_h264_req_multi_if.c     |  3 ++-
> >   .../vcodec/decoder/vdec/vdec_hevc_req_multi_if.c     |  3 ++-
> >   .../vcodec/decoder/vdec/vdec_vp9_req_lat_if.c        |  6 ++++--
> >   .../mediatek/vcodec/decoder/vdec_msg_queue.h         |  2 ++
> >   7 files changed, 24 insertions(+), 12 deletions(-)
> >
> > diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_=
dec_drv.h b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_d=
rv.h
> > index 849b89dd205c..3f5b625330bc 100644
> > --- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv=
h
> > +++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_drv=
h
> > @@ -111,7 +111,8 @@ struct mtk_vcodec_dec_pdata {
> >       int (*flush_decoder)(struct mtk_vcodec_dec_ctx *ctx);
> >       struct vdec_fb *(*get_cap_buffer)(struct mtk_vcodec_dec_ctx *ctx)=
;
> >       void (*cap_to_disp)(struct mtk_vcodec_dec_ctx *ctx, int error,
> > -                         struct media_request *src_buf_req);
> > +                         struct media_request *src_buf_req,
> > +                         struct vb2_v4l2_buffer *vb2_v4l2_src);
> >
> >       const struct vb2_ops *vdec_vb2_ops;
> >
> > diff --git a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_=
dec_stateless.c b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec=
_dec_stateless.c
> > index d54b3833790d..2efa34b6750b 100644
> > --- a/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_sta=
teless.c
> > +++ b/drivers/media/platform/mediatek/vcodec/decoder/mtk_vcodec_dec_sta=
teless.c
> > @@ -245,7 +245,8 @@ static const struct v4l2_frmsize_stepwise stepwise_=
fhd =3D {
> >   };
> >
> >   static void mtk_vdec_stateless_cap_to_disp(struct mtk_vcodec_dec_ctx =
*ctx, int error,
> > -                                        struct media_request *src_buf_=
req)
> > +                                        struct media_request *src_buf_=
req,
> > +                                        struct vb2_v4l2_buffer *vb2_v4=
l2_src)
> >   {
> >       struct vb2_v4l2_buffer *vb2_dst;
> >       enum vb2_buffer_state state;
> > @@ -266,6 +267,9 @@ static void mtk_vdec_stateless_cap_to_disp(struct m=
tk_vcodec_dec_ctx *ctx, int e
> >
> >       if (src_buf_req)
> >               v4l2_ctrl_request_complete(src_buf_req, &ctx->ctrl_hdl);
> > +
> > +     if (vb2_v4l2_src)
> > +             v4l2_m2m_buf_done(vb2_v4l2_src, state);
> >   }
> >
> >   static struct vdec_fb *vdec_get_cap_buffer(struct mtk_vcodec_dec_ctx =
*ctx)
> > @@ -374,14 +378,12 @@ static void mtk_vdec_worker(struct work_struct *w=
ork)
> >       state =3D ret ? VB2_BUF_STATE_ERROR : VB2_BUF_STATE_DONE;
> >       if (!IS_VDEC_LAT_ARCH(dev->vdec_pdata->hw_arch) ||
> >           ctx->current_codec =3D=3D V4L2_PIX_FMT_VP8_FRAME) {
> > -             v4l2_m2m_buf_done_and_job_finish(dev->m2m_dev_dec, ctx->m=
2m_ctx, state);
> >               if (src_buf_req)
> >                       v4l2_ctrl_request_complete(src_buf_req, &ctx->ctr=
l_hdl);
> > +             v4l2_m2m_buf_done_and_job_finish(dev->m2m_dev_dec, ctx->m=
2m_ctx, state);
> >       } else {
> > -             if (ret !=3D -EAGAIN) {
> > +             if (ret !=3D -EAGAIN)
> >                       v4l2_m2m_src_buf_remove(ctx->m2m_ctx);
> > -                     v4l2_m2m_buf_done(vb2_v4l2_src, state);
> > -             }
> >               v4l2_m2m_job_finish(dev->m2m_dev_dec, ctx->m2m_ctx);
> >       }
> >   }
> > diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_a=
v1_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_=
av1_req_lat_if.c
> > index 2b6a5adbc419..f277b907c345 100644
> > --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_av1_req_=
lat_if.c
> > +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_av1_req_=
lat_if.c
> > @@ -1064,6 +1064,8 @@ static int vdec_av1_slice_setup_lat_from_src_buf(=
struct vdec_av1_slice_instance
> >               return -EINVAL;
> >
> >       lat_buf->src_buf_req =3D src->vb2_buf.req_obj.req;
> > +     lat_buf->vb2_v4l2_src =3D src;
> > +
> >       dst =3D &lat_buf->ts_info;
> >       v4l2_m2m_buf_copy_metadata(src, dst, true);
> >       vsi->frame.cur_ts =3D dst->vb2_buf.timestamp;
> > @@ -2187,7 +2189,7 @@ static int vdec_av1_slice_core_decode(struct vdec=
_lat_buf *lat_buf)
> >                      &instance->core_vsi->trans.dma_addr_end);
> >       vdec_msg_queue_update_ube_rptr(&ctx->msg_queue, instance->core_vs=
i->trans.dma_addr_end);
> >
> > -     ctx->dev->vdec_pdata->cap_to_disp(ctx, 0, lat_buf->src_buf_req);
> > +     ctx->dev->vdec_pdata->cap_to_disp(ctx, 0, lat_buf->src_buf_req, l=
at_buf->vb2_v4l2_src);
> >
> >       return 0;
> >
> > @@ -2196,7 +2198,8 @@ static int vdec_av1_slice_core_decode(struct vdec=
_lat_buf *lat_buf)
> >       vdec_msg_queue_update_ube_rptr(&ctx->msg_queue, pfc->vsi.trans.dm=
a_addr_end);
> >
> >       if (fb)
> > -             ctx->dev->vdec_pdata->cap_to_disp(ctx, 1, lat_buf->src_bu=
f_req);
> > +             ctx->dev->vdec_pdata->cap_to_disp(ctx, 1, lat_buf->src_bu=
f_req,
> > +                                               lat_buf->vb2_v4l2_src);
> >
> >       return ret;
> >   }
> > diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h=
264_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vd=
ec_h264_req_multi_if.c
> > index 0e741e0dc8ba..7033999018ca 100644
> > --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req=
_multi_if.c
> > +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h264_req=
_multi_if.c
> > @@ -533,7 +533,7 @@ static int vdec_h264_slice_core_decode(struct vdec_=
lat_buf *lat_buf)
> >
> >   vdec_dec_end:
> >       vdec_msg_queue_update_ube_rptr(&lat_buf->ctx->msg_queue, share_in=
fo->trans_end);
> > -     ctx->dev->vdec_pdata->cap_to_disp(ctx, !!err, lat_buf->src_buf_re=
q);
> > +     ctx->dev->vdec_pdata->cap_to_disp(ctx, !!err, lat_buf->src_buf_re=
q, lat_buf->vb2_v4l2_src);
> >       mtk_vdec_debug(ctx, "core decode done err=3D%d", err);
> >       ctx->decoded_frame_cnt++;
> >       return 0;
> > @@ -606,6 +606,7 @@ static int vdec_h264_slice_lat_decode(void *h_vdec,=
 struct mtk_vcodec_mem *bs,
> >
> >       inst->vsi->dec.nal_info =3D buf[nal_start_idx];
> >       lat_buf->src_buf_req =3D src_buf_info->m2m_buf.vb.vb2_buf.req_obj=
req;
> > +     lat_buf->vb2_v4l2_src =3D &src_buf_info->m2m_buf.vb;
> >       v4l2_m2m_buf_copy_metadata(&src_buf_info->m2m_buf.vb, &lat_buf->t=
s_info, true);
> >
> >       err =3D vdec_h264_slice_fill_decode_parameters(inst, share_info);
> > diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_h=
evc_req_multi_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vd=
ec_hevc_req_multi_if.c
> > index 06ed47df693b..67fe3c4bfac3 100644
> > --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_hevc_req=
_multi_if.c
> > +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_hevc_req=
_multi_if.c
> > @@ -742,6 +742,7 @@ static int vdec_hevc_slice_setup_lat_buffer(struct =
vdec_hevc_slice_inst *inst,
> >
> >       src_buf_info =3D container_of(bs, struct mtk_video_dec_buf, bs_bu=
ffer);
> >       lat_buf->src_buf_req =3D src_buf_info->m2m_buf.vb.vb2_buf.req_obj=
req;
> > +     lat_buf->vb2_v4l2_src =3D &src_buf_info->m2m_buf.vb;
> >       v4l2_m2m_buf_copy_metadata(&src_buf_info->m2m_buf.vb, &lat_buf->t=
s_info, true);
> >
> >       *res_chg =3D inst->resolution_changed;
> > @@ -961,7 +962,7 @@ static int vdec_hevc_slice_core_decode(struct vdec_=
lat_buf *lat_buf)
> >
> >   vdec_dec_end:
> >       vdec_msg_queue_update_ube_rptr(&lat_buf->ctx->msg_queue, share_in=
fo->trans.dma_addr_end);
> > -     ctx->dev->vdec_pdata->cap_to_disp(ctx, !!err, lat_buf->src_buf_re=
q);
> > +     ctx->dev->vdec_pdata->cap_to_disp(ctx, !!err, lat_buf->src_buf_re=
q, lat_buf->vb2_v4l2_src);
> >       mtk_vdec_debug(ctx, "core decode done err=3D%d", err);
> >       ctx->decoded_frame_cnt++;
> >       return 0;
> > diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_v=
p9_req_lat_if.c b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_=
vp9_req_lat_if.c
> > index 69d37b93bd35..a7734d032269 100644
> > --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_=
lat_if.c
> > +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec/vdec_vp9_req_=
lat_if.c
> > @@ -723,6 +723,7 @@ static int vdec_vp9_slice_setup_lat_from_src_buf(st=
ruct vdec_vp9_slice_instance
> >               return -EINVAL;
> >
> >       lat_buf->src_buf_req =3D src->vb2_buf.req_obj.req;
> > +     lat_buf->vb2_v4l2_src =3D src;
> >
> >       dst =3D &lat_buf->ts_info;
> >       v4l2_m2m_buf_copy_metadata(src, dst, true);
> > @@ -2188,7 +2189,7 @@ static int vdec_vp9_slice_core_decode(struct vdec=
_lat_buf *lat_buf)
> >       mtk_vdec_debug(ctx, "core dma_addr_end 0x%lx\n",
> >                      (unsigned long)pfc->vsi.trans.dma_addr_end);
> >       vdec_msg_queue_update_ube_rptr(&ctx->msg_queue, pfc->vsi.trans.dm=
a_addr_end);
> > -     ctx->dev->vdec_pdata->cap_to_disp(ctx, 0, lat_buf->src_buf_req);
> > +     ctx->dev->vdec_pdata->cap_to_disp(ctx, 0, lat_buf->src_buf_req, l=
at_buf->vb2_v4l2_src);
> >
> >       return 0;
> >
> > @@ -2198,7 +2199,8 @@ static int vdec_vp9_slice_core_decode(struct vdec=
_lat_buf *lat_buf)
> >               vdec_msg_queue_update_ube_rptr(&ctx->msg_queue, pfc->vsi.=
trans.dma_addr_end);
> >
> >               if (fb)
> > -                     ctx->dev->vdec_pdata->cap_to_disp(ctx, 1, lat_buf=
->src_buf_req);
> > +                     ctx->dev->vdec_pdata->cap_to_disp(ctx, 1, lat_buf=
->src_buf_req,
> > +                                                       lat_buf->vb2_v4=
l2_src);
> >       }
> >       return ret;
> >   }
> > diff --git a/drivers/media/platform/mediatek/vcodec/decoder/vdec_msg_qu=
eue.h b/drivers/media/platform/mediatek/vcodec/decoder/vdec_msg_queue.h
> > index 1d9beb9e4a14..b0f2443d186f 100644
> > --- a/drivers/media/platform/mediatek/vcodec/decoder/vdec_msg_queue.h
> > +++ b/drivers/media/platform/mediatek/vcodec/decoder/vdec_msg_queue.h
> > @@ -55,6 +55,7 @@ struct vdec_msg_queue_ctx {
> >    * @rd_mv_addr:     mv addr for av1 lat hardware output, core hardwar=
e input
> >    * @tile_addr:      tile buffer for av1 core input
> >    * @ts_info: need to set timestamp from output to capture
> > + * @vb2_v4l2_src: the vb2 buffer of output queue
> >    * @src_buf_req: output buffer media request object
> >    *
> >    * @private_data: shared information used to lat and core hardware
> > @@ -71,6 +72,7 @@ struct vdec_lat_buf {
> >       struct mtk_vcodec_mem rd_mv_addr;
> >       struct mtk_vcodec_mem tile_addr;
> >       struct vb2_v4l2_buffer ts_info;
> > +     struct vb2_v4l2_buffer *vb2_v4l2_src;
> >       struct media_request *src_buf_req;
> >
> >       void *private_data;

