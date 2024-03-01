Return-Path: <linux-kernel+bounces-88530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB6A86E2ED
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 728411C2268D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE146EEF9;
	Fri,  1 Mar 2024 14:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hnd73O4/"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8EB40BE2;
	Fri,  1 Mar 2024 14:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709301706; cv=none; b=S4eBfwANQQGglXyJucT7LArytoyzX1prYr3CRFuAsr6WdwO8NLVBQ1HwZz3FTq7zJsMXitd9bmNR2niboGUPEgRAHcM2APJlDU0S2C6p1AqqBUh6QNEqvQU81GLcE9YhlPwU3MSOtAr2CbSnlWCoTyqnqI3dQW9khmrJKiATZtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709301706; c=relaxed/simple;
	bh=I0RZgu6yAwW+WqBjC4XbpIQQftvoiyeuI5lcrZj3qeQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iIQtNn5w+6LWxQXMudK3ANuW9e2wsDlzcyMepSOaZILMmlvJOjjefVKNbMw4pqBrsvUYwQ8tZ6zDKuSC9ix++LUt3BSTqvx+FpX250sqgHcOL9tzkzH1JA2L9/UePEmNa7gK7n/CVY2xrQHiS5++2jl64FxvBuaj6sGI0JVvqKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hnd73O4/; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709301700;
	bh=I0RZgu6yAwW+WqBjC4XbpIQQftvoiyeuI5lcrZj3qeQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=hnd73O4/eZmnUqFg6A1m7feufDQ9AnMwLbUBzWs7NGW94LoZedkx8RnAUvf61L/eW
	 bGqtgP0jIchQSdYpZfgq6czfJPil/xsOgbtkJ2kAI10SGoSxGY/Q/V8ye91qsRSPej
	 ODbVDzTqlhT3LCbwMSXnwMVKdRqUjPV4uhI9Mcmr3TXNf4KoGTBfuwLSxxOYmBs1TO
	 vwMIzdAHfKr/azalsuPb5C/M9jMr4jBi7M2X1IZruqeVxGi31tbBh3Xdp1dpaA6HFT
	 GVGW6PkNcK1aZZ49zG1Ovkva7W5vmD3IBSeO19pV6Y6czPxUcxVCUSWqbsAFDJWmGN
	 fUW6XbSDTTW8Q==
Received: from nicolas-tpx395.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nicolas)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id CFD43378003D;
	Fri,  1 Mar 2024 14:01:38 +0000 (UTC)
Message-ID: <21ba0e670fecea78bda7ebf2d75470c534c46bf1.camel@collabora.com>
Subject: Re: [PATCH] media: chips-media: wave5: Call v4l2_m2m_job_finish()
 in job_abort()
From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>, Nas Chung
	 <nas.chung@chipsnmedia.com>, Jackson Lee <jackson.lee@chipsnmedia.com>, 
	Mauro Carvalho Chehab
	 <mchehab@kernel.org>
Cc: Guillaume La Roque <glaroque@baylibre.com>, Brandon Brnich
 <b-brnich@ti.com>,  Robert Beckett <bob.beckett@collabora.com>, Sebastian
 Fricke <sebastian.fricke@collabora.com>,  linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 01 Mar 2024 09:01:35 -0500
In-Reply-To: <20240228-wave5-fix-abort-v1-1-7482b9316867@baylibre.com>
References: <20240228-wave5-fix-abort-v1-1-7482b9316867@baylibre.com>
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

Le mercredi 28 f=C3=A9vrier 2024 =C3=A0 17:12 +0100, Mattijs Korpershoek a =
=C3=A9crit=C2=A0:
> When aborting a stream, it's possible that v4l2_m2m_cancel_job()
> remains stuck:
>=20
> [ 3498.490038][    T1] sysrq: Show Blocked State
> [ 3498.511754][    T1] task:V4L2DecodeCompo state:D stack:12480 pid:2387 =
 ppid:1      flags:0x04000809
> [ 3498.521153][    T1] Call trace:
> [ 3498.524333][    T1]  __switch_to+0x174/0x338
> [ 3498.528611][    T1]  __schedule+0x5ec/0x9cc
> [ 3498.532795][    T1]  schedule+0x84/0xf0
> [ 3498.536630][    T1]  v4l2_m2m_cancel_job+0x118/0x194
> [ 3498.541595][    T1]  v4l2_m2m_streamoff+0x34/0x13c
> [ 3498.546384][    T1]  v4l2_m2m_ioctl_streamoff+0x20/0x30
> [ 3498.551607][    T1]  v4l_streamoff+0x44/0x54
> [ 3498.555877][    T1]  __video_do_ioctl+0x388/0x4dc
> [ 3498.560580][    T1]  video_usercopy+0x618/0xa0c
> [ 3498.565109][    T1]  video_ioctl2+0x20/0x30
> [ 3498.569292][    T1]  v4l2_ioctl+0x74/0x8c
> [ 3498.573300][    T1]  __arm64_sys_ioctl+0xb0/0xec
> [ 3498.577918][    T1]  invoke_syscall+0x60/0x124
> [ 3498.582368][    T1]  el0_svc_common+0x90/0xfc
> [ 3498.586724][    T1]  do_el0_svc+0x34/0xb8
> [ 3498.590733][    T1]  el0_svc+0x2c/0xa4
> [ 3498.594480][    T1]  el0t_64_sync_handler+0x68/0xb4
> [ 3498.599354][    T1]  el0t_64_sync+0x1a4/0x1a8
> [ 3498.603832][    T1] sysrq: Kill All Tasks
>=20
> According to job_abort() documentation from v4l2_m2m_ops:
>=20
>   After the driver performs the necessary steps, it has to call
>   v4l2_m2m_job_finish() or v4l2_m2m_buf_done_and_job_finish() as
>   if the transaction ended normally.
>=20
> This is not done in wave5_vpu_dec_job_abort(). Neither switch_state() nor
> wave5_vpu_dec_set_eos_on_firmware() does this.

The doc said "the driver", not job_abort() specifically ...

>=20
> Add the missing call to fix the v4l2_m2m_cancel_job() hangs.
>=20
> Fixes: 9707a6254a8a ("media: chips-media: wave5: Add the v4l2 layer")
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
> This has been tested on the AM62Px SK EVM using Android 14.
> See:
>     https://www.ti.com/tool/PROCESSOR-SDK-AM62P
>=20
> Note: while this is has not been tested on an upstream linux tree, I
> believe the fix is still valid for mainline and I would like to get
> some feedback on it.
>=20
> Thank you in advance for your time.
> ---
>  drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/d=
rivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> index ef227af72348..b03e3633a1bc 100644
> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
> @@ -1715,6 +1715,7 @@ static void wave5_vpu_dec_device_run(void *priv)
>  static void wave5_vpu_dec_job_abort(void *priv)
>  {
>  	struct vpu_instance *inst =3D priv;
> +	struct v4l2_m2m_ctx *m2m_ctx =3D inst->v4l2_fh.m2m_ctx;
>  	int ret;
> =20
>  	ret =3D switch_state(inst, VPU_INST_STATE_STOP);
> @@ -1725,6 +1726,8 @@ static void wave5_vpu_dec_job_abort(void *priv)
>  	if (ret)
>  		dev_warn(inst->dev->dev,
>  			 "Setting EOS for the bitstream, fail: %d\n", ret);
> +
> +	v4l2_m2m_job_finish(inst->v4l2_m2m_dev, m2m_ctx);

Wave5 firmware have no function to cancel pending jobs. By finishing the jo=
b
without caring about the firmware state, wave5_vpu_dec_finish_decode() will=
 be
called concurrently to another job. This change will effectively breaks see=
king,
and will cause warning and possibly memory corruption.

In principle, setting the EOS flag should be enough to ensure that the drai=
n
sequence is initiated, and that should allow finish_decoder() to be called,
which is the only clean way to get finish_job() to be called.

This driver implementation uses PIC_END operating mode of the IP, that ensu=
re
that each submitted job is assumed to be complete, which means each RUN wil=
l
lead to a matching IRQ. We had a similar stall during development which was
fixed with a firmware update, are you sure you have the very latest firmwar=
e ?
Any chance you can use v4l2-tracer to share what your software have been do=
ing ?

What you can though though, to fortify this a little, is to introduce a wat=
chdog
here. You can trigger it from abort, and on timeout, you will have to fully
reset and reboot the chip (which is not very fast, you don't want to do thi=
s at
all time). When the reset have completed, you will have to carefully reset =
the
driver state before you can safely continue. You'll need to add thread safe
protection against spurious finish_decode() call, in case the watchdog time=
out
raced with the firmware finally coming back to life.

regards,
Nicolas

p.s. you should perhaps trace the firmware job counters to try and understa=
nd
more about your specific hang.

>  }
> =20
>  static int wave5_vpu_dec_job_ready(void *priv)
>=20
> ---
> base-commit: 8c64f4cdf4e6cc5682c52523713af8c39c94e6d5
> change-id: 20240228-wave5-fix-abort-f72d25881cbd
>=20
> Best regards,


