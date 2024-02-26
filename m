Return-Path: <linux-kernel+bounces-82251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A27A868130
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9300B1F226D0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7077612FF82;
	Mon, 26 Feb 2024 19:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TbT37zpY"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9CA012FB3A;
	Mon, 26 Feb 2024 19:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708976350; cv=none; b=mAcFhVMYaQv9NA+ZZQyn6oW7Rlc9BtoGAEqHOpQ45g70+JG4AM0CibcepQ1SIuS0f4uiJ4az414msVlY0Qb1ue5Cio4EK/l7axMAmeHaNqYqIWbVlF/baJjQwEM5Lg7QUnkbcGNPEG5Ekzjnc7iwLCRK6K6iZHSOIEXAixG/2XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708976350; c=relaxed/simple;
	bh=LbcZ6qWq9CdIRdNMvzTM4cnq43tnvnfCY02gSxkWg6o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FrIcdbuQ282hq6Rw8Fuduno4P5UEQB6DI72PgnvcqUtfEPNJ1Mph6LmFlDz5bgdpMgnl5KeyGmTCAn9N27a286j4Uu+gxdypVtd7M//eYqZGf1XhPQLYKz7Xye0e9IHZtbu0SwjM3vD5AhFzfICNEkOV2BCZBvPDjE7TLDmfMwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TbT37zpY; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708976346;
	bh=LbcZ6qWq9CdIRdNMvzTM4cnq43tnvnfCY02gSxkWg6o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=TbT37zpYPH5KAbLLpe855oKrwwrgqsQTCy4TiemFVOyKXSaJiWz2opdr8Nv6I6pkI
	 qO3j1L259B+bCL8rDsIhIqIiihW5PBHv6znH/zNcJDLcP5yyW57KeIQ+4n9CyFUvyg
	 HCOyP5tEaNXgn8x21wTBF9E0cUmGyxqbuaxj3GxdqYUo/d0ysHemRo0SiEndbYmygl
	 4Syxih5KS0pDrQN5FvJoeaFcxuIjUy4SydreT2KygZe/yltMuEoQG196PuWEgdV4i/
	 ezujIPTzItOBSZuly5GkFggB0LRyPIqhImuFe8NGtVEAUSndzLro9pNgBfyL9wLzb0
	 i1dEGh3rUiIgQ==
Received: from nicolas-tpx395.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5165937820AF;
	Mon, 26 Feb 2024 19:39:04 +0000 (UTC)
Message-ID: <a50530974d05fb9a625b4bf6fbf531035161f443.camel@collabora.com>
Subject: Re: [PATCH v3,1/2] media: mediatek: vcodec: adding lock to protect
 decoder context list
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Yunfei Dong <yunfei.dong@mediatek.com>, =?ISO-8859-1?Q?N=EDcolas?= "F .
 R . A . Prado" <nfraprado@collabora.com>, Hans Verkuil
 <hverkuil-cisco@xs4all.nl>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Benjamin Gaignard
 <benjamin.gaignard@collabora.com>, Nathan Hebert <nhebert@chromium.org>, 
 Irui Wang <irui.wang@mediatek.com>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>, Fritz Koenig
 <frkoenig@chromium.org>,  Daniel Vetter <daniel@ffwll.ch>, Steve Cho
 <stevecho@chromium.org>, linux-media@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Project_Global_Chrome_Upstream_Group@mediatek.com, Steve Cho
 <stevecho@google.com>
Date: Mon, 26 Feb 2024 14:39:00 -0500
In-Reply-To: <20240222092609.31382-2-yunfei.dong@mediatek.com>
References: <20240222092609.31382-1-yunfei.dong@mediatek.com>
	 <20240222092609.31382-2-yunfei.dong@mediatek.com>
Autocrypt: addr=nicolas.dufresne@collabora.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

Le jeudi 22 f=C3=A9vrier 2024 =C3=A0 17:26 +0800, Yunfei Dong a =C3=A9crit=
=C2=A0:
> The ctx_list will be deleted when scp getting unexpected behavior, then t=
he
> ctx_list->next will be NULL, the kernel driver maybe access NULL pointer =
in
> function vpu_dec_ipi_handler when going through each context, then reboot=
.
>=20
> Need to add lock to protect the ctx_list to make sure the ctx_list->next =
isn't
> NULL pointer.

The cited crash no longer occurs for me, but it still sometimes crashes whi=
le
the SCP being rebooted. I think this patch can still go in, as it overall
improves the situation.

Meanwhile, here's my stress test using GStreamer and stream downloaded by
fluster. I call this script few times this way as it does not always crash.=
 The
test just keep starting decode sessions and terminate them after 2 seconds.=
 It
is highly parallel. Using too low number does not reproduce the crash, usin=
g too
high number leads to alloc failure, which wasn't the goal of this test.

/mtk-vcodec-crash.sh 100

Script code:
***
#!/bin/bash

test() {
	gst-launch-1.0 --no-fault filesrc location=3DTILES_B_Cisco_1.bin ! h265par=
se ! v4l2slh265dec ! fakevideosink &
	pid=3D$!

	sleep 2
	kill $pid
}

for i in $(seq 1 $1)
do
	test &
done

wait
***

The kernel Crash:
[   93.261248] Unable to handle kernel NULL pointer dereference at virtual
address 0000000000000008
[   93.270056] Mem abort info:
[   93.272880]   ESR =3D 0x0000000096000004
[   93.276804]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[   93.282233]   SET =3D 0, FnV =3D 0
[   93.285372]   EA =3D 0, S1PTW =3D 0
[   93.288561]   FSC =3D 0x04: level 0 translation fault
[   93.293493] Data abort info:
[   93.296424]   ISV =3D 0, ISS =3D 0x00000004, ISS2 =3D 0x00000000
[   93.301920]   CM =3D 0, WnR =3D 0, TnD =3D 0, TagAccess =3D 0
[   93.306977]   GCS =3D 0, Overlay =3D 0, DirtyBit =3D 0, Xs =3D 0
[   93.312321] user pgtable: 4k pages, 48-bit VAs, pgdp=3D0000000168daf000
[   93.318790] [0000000000000008] pgd=3D0000000000000000, p4d=3D00000000000=
00000
[   93.325588] Internal error: Oops: 0000000096000004 [#1] PREEMPT SMP
[   93.331842] Modules linked in: mt7921e mt7921_common mt792x_lib
mt76_connac_lib mt76 mac80211 btusb btintel mtk_vcodec_dec_hw btmtk btrtl
mtk_vcodec_dec btbcm cfg80211 bluetooth snd_sof_mt8195 mtk_vcodec_enc
mtk_adsp_common uvcvideo v4l2_vp9 snd_sof_xtensa_dsp v4l2_h264 mtk_vcodec_d=
bgfs
snd_sof_of snd_sof ecdh_generic mtk_vcodec_common ecc uvc elan_i2c
videobuf2_vmalloc crct10dif_ce cros_ec_lid_angle cros_ec_sensors snd_sof_ut=
ils
cros_ec_sensors_core cros_usbpd_logger cros_usbpd_charger fuse ip_tables ip=
v6
[   93.376652] CPU: 5 PID: 3210 Comm: h265parse0:sink Tainted: G        W  =
   =20
6.8.0-rc4-next-20240212+ #14
[   93.386463] Hardware name: Acer Tomato (rev3 - 4) board (DT)
[   93.392107] pstate: 80400009 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)
[   93.399054] pc : vcodec_vpu_send_msg+0x4c/0x190 [mtk_vcodec_dec]
[   93.405058] lr : vcodec_send_ap_ipi+0x78/0x170 [mtk_vcodec_dec]
[   93.410968] sp : ffff80008750bc20
[   93.414269] x29: ffff80008750bc20 x28: ffff1299f6d70000 x27: 00000000000=
00000
[   93.421391] x26: 0000000000000000 x25: 0000000000000000 x24: 00000000000=
00000
[   93.428512] x23: ffff80008750bc98 x22: 000000000000a003 x21: ffffd45c4cf=
ae000
[   93.435632] x20: 0000000000000010 x19: ffff1299fd668310 x18: 00000000000=
0001a
[   93.442753] x17: 000000040044ffff x16: ffffd45cb15dc648 x15: 00000000000=
00000
[   93.449874] x14: ffff1299c08da1c0 x13: ffffd45cb1f87a10 x12: ffffd45cb2f=
5fe80
[   93.456995] x11: 0000000000000001 x10: 0000000000001b30 x9 : ffffd45c4d1=
2b488
[   93.464116] x8 : 1fffe25339380d81 x7 : 0000000000000001 x6 : ffff1299c9c=
06c00
[   93.471236] x5 : 0000000000000132 x4 : 0000000000000000 x3 : 00000000000=
00000
[   93.478358] x2 : 0000000000000010 x1 : ffff80008750bc98 x0 : 00000000000=
00000
[   93.485479] Call trace:
[   93.487914]  vcodec_vpu_send_msg+0x4c/0x190 [mtk_vcodec_dec]
[   93.493563]  vcodec_send_ap_ipi+0x78/0x170 [mtk_vcodec_dec]
[   93.499125]  vpu_dec_deinit+0x1c/0x30 [mtk_vcodec_dec]
[   93.504254]  vdec_hevc_slice_deinit+0x30/0x98 [mtk_vcodec_dec]
[   93.510076]  vdec_if_deinit+0x38/0x68 [mtk_vcodec_dec]
[   93.515205]  mtk_vcodec_dec_release+0x20/0x40 [mtk_vcodec_dec]
[   93.521027]  fops_vcodec_release+0x64/0x118 [mtk_vcodec_dec]
[   93.526677]  v4l2_release+0x7c/0x100
[   93.530245]  __fput+0x80/0x2d8
[   93.533292]  __fput_sync+0x58/0x70
[   93.536681]  __arm64_sys_close+0x40/0x90
[   93.540590]  invoke_syscall+0x50/0x128
[   93.544329]  el0_svc_common.constprop.0+0x48/0xf0
[   93.549020]  do_el0_svc+0x24/0x38
[   93.552323]  el0_svc+0x38/0xd8
[   93.555367]  el0t_64_sync_handler+0xc0/0xc8
[   93.559537]  el0t_64_sync+0x1a8/0x1b0
[   93.563189] Code: d503201f f9401660 b900127f b900227f (f9400400)=20
[   93.569268] ---[ end trace 0000000000000000 ]---

