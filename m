Return-Path: <linux-kernel+bounces-90929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 921358706EB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4D7C1C21E1D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3626E4C60B;
	Mon,  4 Mar 2024 16:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yJMljcVO"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0191F47A6C
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 16:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709569373; cv=none; b=BXj2iDiifs4HVKLGbyeMcgfJCKfIuN+2rB3/lgnMaGtbE7AMsrM2qdvdx6fTLl1CIuggbXQO/unjiRuQb8sVnGGGHGKtmqSojhK7uvrNULqh1vagP/51wk1HaqoBa7qbqJ8yFrmKHg5/V/RhK7mB0tNfq95snxTcgdwzMnTa6hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709569373; c=relaxed/simple;
	bh=kW7JCJO31lEwSLDJYPlDizRw0G1TW66mT2RjtfaXc5M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qVar+XDZllrMq2dPmgn59K/d9/kBoMGjwfjqUj9iUM7Eq0h9ZnujRHbVvqPxbkOUIUjEbKrQzluMdnxkO63aneAVg0fMA3aeiEyWM4YLLJW+JbLNRZ0qFm7YEQxgfoa1yf8+qaGoQRNZDezRbecGqSX15YSXZcxxNsS+dsNedbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yJMljcVO; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-412e1b52934so8052085e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 08:22:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709569369; x=1710174169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yJyamNFRAv3xfMQWs9hxsro+fRS73UwVpOB+wUw3hBc=;
        b=yJMljcVOOKG8wa10PGrWA6ppeeP+w4M5HNndELfzK/jbGQdCHdSGPY8bgZLbG/MIgo
         hCRGj1Xxefast0inHFuueLJOqS92zBm7K+SkvQevMhMdp6dun7yvgaFImgMwNuAbPvEZ
         0gYtTVeerHV9/fR36DDdoif+WmwiBHqZZWQfmBHRU6llQA4KBtAJ+1Q2TYxgwMqJGVq/
         X3NpmWnXtJI7FlTZC5gnGgfJy+nc7HUog3HXKkCO758mRkbDWajvwI7/7ujjeHnHQswr
         V+q9RCOHqfbsPypXO3QjnQPA/Bbjx+9c1O8z01zHZxrb9LDOvgaix5sv0J/A3tcmfxKL
         dZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709569369; x=1710174169;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yJyamNFRAv3xfMQWs9hxsro+fRS73UwVpOB+wUw3hBc=;
        b=DxBjMf2ar//ojWrpegFF8jN6pRGAlFXkzXnpBoyfxq/meC3fOSo83FD5FRozGg1tC8
         PSJlepduaZcJ06+wLwjPqhrJKdn/kCGYYQ/THHZGEb52vs/aY6N6qYr38fl/uXCJ7D4m
         1DeylNhVLsAmJALk2j7A1piC1tVbSCcB1mjckvCDzYp5BytqBpPUpKreAnQ/GVZ3S77M
         j2MfXwRPpCw/pCORUBbtRI0x6ZHyWhKBVngqNBO2Ri8Miw7T5Jh3WyRNok1AmO0Fq6SQ
         UCx9HooFDKDuwuthfIxhgmrrBeexnOHF/BrreW5NfwsyrKZL7gLhmgwqoWjcMDnd2Ugs
         FnEA==
X-Forwarded-Encrypted: i=1; AJvYcCXWJ/Hz3xX4A5oXuThiHsPjVn6b2rc9kpakqvV72i6JyeZ6ayPc9mN/v/W8JaOX8h1K80ZPRS0lOf1xBq3HarkPeJfCv94isrSoOUK4
X-Gm-Message-State: AOJu0YweT9Mdt9bJfnKYrYeL8BSPDtuKDgUZlRClsUaEsK0UPugDlTtm
	InQsDpAL6MQsZM15ZfxNaEa7g4nBMx/CaI/QwkCLj5pyDrpcTE9dhuPzr/GBWOM=
X-Google-Smtp-Source: AGHT+IE7mgWGKlhDIKoEASTtxNaJrZNaMEJ/tQfO+YfrKLNfyHXZ48/JDpqB3KxTO+aQbkvJNL6ELg==
X-Received: by 2002:a05:600c:4e93:b0:412:a015:9411 with SMTP id f19-20020a05600c4e9300b00412a0159411mr9758119wmq.6.1709569369268;
        Mon, 04 Mar 2024 08:22:49 -0800 (PST)
Received: from localhost ([2a01:cb19:95ba:5000:d6dd:417f:52ac:335b])
        by smtp.gmail.com with ESMTPSA id l22-20020a05600c4f1600b004128f41a13fsm15180835wmq.38.2024.03.04.08.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 08:22:48 -0800 (PST)
From: Mattijs Korpershoek <mkorpershoek@baylibre.com>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>, Nas Chung
 <nas.chung@chipsnmedia.com>, Jackson Lee <jackson.lee@chipsnmedia.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Guillaume La Roque <glaroque@baylibre.com>, Brandon Brnich
 <b-brnich@ti.com>, Robert Beckett <bob.beckett@collabora.com>, Sebastian
 Fricke <sebastian.fricke@collabora.com>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: chips-media: wave5: Call v4l2_m2m_job_finish()
 in job_abort()
In-Reply-To: <21ba0e670fecea78bda7ebf2d75470c534c46bf1.camel@collabora.com>
References: <20240228-wave5-fix-abort-v1-1-7482b9316867@baylibre.com>
 <21ba0e670fecea78bda7ebf2d75470c534c46bf1.camel@collabora.com>
Date: Mon, 04 Mar 2024 17:22:48 +0100
Message-ID: <87il227yqv.fsf@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

Thank you for your prompt reply.

On ven., mars 01, 2024 at 09:01, Nicolas Dufresne <nicolas.dufresne@collabo=
ra.com> wrote:

> Hi,
>
> Le mercredi 28 f=C3=A9vrier 2024 =C3=A0 17:12 +0100, Mattijs Korpershoek =
a =C3=A9crit=C2=A0:
>> When aborting a stream, it's possible that v4l2_m2m_cancel_job()
>> remains stuck:
>>=20
>> [ 3498.490038][    T1] sysrq: Show Blocked State
>> [ 3498.511754][    T1] task:V4L2DecodeCompo state:D stack:12480 pid:2387=
  ppid:1      flags:0x04000809
>> [ 3498.521153][    T1] Call trace:
>> [ 3498.524333][    T1]  __switch_to+0x174/0x338
>> [ 3498.528611][    T1]  __schedule+0x5ec/0x9cc
>> [ 3498.532795][    T1]  schedule+0x84/0xf0
>> [ 3498.536630][    T1]  v4l2_m2m_cancel_job+0x118/0x194
>> [ 3498.541595][    T1]  v4l2_m2m_streamoff+0x34/0x13c
>> [ 3498.546384][    T1]  v4l2_m2m_ioctl_streamoff+0x20/0x30
>> [ 3498.551607][    T1]  v4l_streamoff+0x44/0x54
>> [ 3498.555877][    T1]  __video_do_ioctl+0x388/0x4dc
>> [ 3498.560580][    T1]  video_usercopy+0x618/0xa0c
>> [ 3498.565109][    T1]  video_ioctl2+0x20/0x30
>> [ 3498.569292][    T1]  v4l2_ioctl+0x74/0x8c
>> [ 3498.573300][    T1]  __arm64_sys_ioctl+0xb0/0xec
>> [ 3498.577918][    T1]  invoke_syscall+0x60/0x124
>> [ 3498.582368][    T1]  el0_svc_common+0x90/0xfc
>> [ 3498.586724][    T1]  do_el0_svc+0x34/0xb8
>> [ 3498.590733][    T1]  el0_svc+0x2c/0xa4
>> [ 3498.594480][    T1]  el0t_64_sync_handler+0x68/0xb4
>> [ 3498.599354][    T1]  el0t_64_sync+0x1a4/0x1a8
>> [ 3498.603832][    T1] sysrq: Kill All Tasks
>>=20
>> According to job_abort() documentation from v4l2_m2m_ops:
>>=20
>>   After the driver performs the necessary steps, it has to call
>>   v4l2_m2m_job_finish() or v4l2_m2m_buf_done_and_job_finish() as
>>   if the transaction ended normally.
>>=20
>> This is not done in wave5_vpu_dec_job_abort(). Neither switch_state() nor
>> wave5_vpu_dec_set_eos_on_firmware() does this.
>
> The doc said "the driver", not job_abort() specifically ...

Indeed. Seems I wanted to convince myself that this was job_abort()
specific. Sorry about that.

>
>>=20
>> Add the missing call to fix the v4l2_m2m_cancel_job() hangs.
>>=20
>> Fixes: 9707a6254a8a ("media: chips-media: wave5: Add the v4l2 layer")
>> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
>> ---
>> This has been tested on the AM62Px SK EVM using Android 14.
>> See:
>>     https://www.ti.com/tool/PROCESSOR-SDK-AM62P
>>=20
>> Note: while this is has not been tested on an upstream linux tree, I
>> believe the fix is still valid for mainline and I would like to get
>> some feedback on it.
>>=20
>> Thank you in advance for your time.
>> ---
>>  drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>=20
>> diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c b/=
drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
>> index ef227af72348..b03e3633a1bc 100644
>> --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
>> +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-dec.c
>> @@ -1715,6 +1715,7 @@ static void wave5_vpu_dec_device_run(void *priv)
>>  static void wave5_vpu_dec_job_abort(void *priv)
>>  {
>>  	struct vpu_instance *inst =3D priv;
>> +	struct v4l2_m2m_ctx *m2m_ctx =3D inst->v4l2_fh.m2m_ctx;
>>  	int ret;
>>=20=20
>>  	ret =3D switch_state(inst, VPU_INST_STATE_STOP);
>> @@ -1725,6 +1726,8 @@ static void wave5_vpu_dec_job_abort(void *priv)
>>  	if (ret)
>>  		dev_warn(inst->dev->dev,
>>  			 "Setting EOS for the bitstream, fail: %d\n", ret);
>> +
>> +	v4l2_m2m_job_finish(inst->v4l2_m2m_dev, m2m_ctx);
>
> Wave5 firmware have no function to cancel pending jobs. By finishing the =
job
> without caring about the firmware state, wave5_vpu_dec_finish_decode() wi=
ll be
> called concurrently to another job. This change will effectively breaks s=
eeking,
> and will cause warning and possibly memory corruption.

Ah. That's not what I intended. This patch would completely break the
driver.
Thank you for explaining that to me.

>
> In principle, setting the EOS flag should be enough to ensure that the dr=
ain
> sequence is initiated, and that should allow finish_decoder() to be calle=
d,
> which is the only clean way to get finish_job() to be called.

>
> This driver implementation uses PIC_END operating mode of the IP, that en=
sure
> that each submitted job is assumed to be complete, which means each RUN w=
ill
> lead to a matching IRQ. We had a similar stall during development which w=
as
> fixed with a firmware update, are you sure you have the very latest firmw=
are ?

Interesting.

I double checked the firmware from linux-firmware:

$ ~/work/upstream/linux-firmware/ main md5sum cnm/wave521c_k3_codec_fw.bin
02c5faa5405559bd59a7361a32c2695a  cnm/wave521c_k3_codec_fw.bin

$ ~/ adb shell md5sum /vendor/firmware/cnm/wave521c_k3_codec_fw.bin
02c5faa5405559bd59a7361a32c2695a  /vendor/firmware/cnm/wave521c_k3_codec_fw=
bin

Which should be: "FW version : 1.0.3"

> Any chance you can use v4l2-tracer to share what your software have been =
doing ?

I did not know v4l2-tracer.
I tried to run it on android but it seems it segfaults when overriding
mmap().
I will continue to try to get some traces.

>
> What you can though though, to fortify this a little, is to introduce a w=
atchdog
> here. You can trigger it from abort, and on timeout, you will have to ful=
ly
> reset and reboot the chip (which is not very fast, you don't want to do t=
his at
> all time). When the reset have completed, you will have to carefully rese=
t the
> driver state before you can safely continue. You'll need to add thread sa=
fe
> protection against spurious finish_decode() call, in case the watchdog ti=
meout
> raced with the firmware finally coming back to life.

Ok, I can look into that as well.

Given that i'm not super familiar with multimedia, this has helped me a
lot.

Thanks!

>
> regards,
> Nicolas
>
> p.s. you should perhaps trace the firmware job counters to try and unders=
tand
> more about your specific hang.

I will look into it.

>
>>  }
>>=20=20
>>  static int wave5_vpu_dec_job_ready(void *priv)
>>=20
>> ---
>> base-commit: 8c64f4cdf4e6cc5682c52523713af8c39c94e6d5
>> change-id: 20240228-wave5-fix-abort-f72d25881cbd
>>=20
>> Best regards,

