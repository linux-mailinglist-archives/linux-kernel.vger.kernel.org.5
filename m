Return-Path: <linux-kernel+bounces-31536-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D1D832FA2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 21:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35B84B23EAD
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 20:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0789B5674C;
	Fri, 19 Jan 2024 20:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrgFRrW1"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 586B441C98;
	Fri, 19 Jan 2024 20:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705695143; cv=none; b=IHrlSKT93v8/8f4c7YSllhNbxi2U6zWBsE671odCfKl2Q5vluIABnP0nYEqaT7+ODCLvfsvOZUQaT9QBhrOXzmmDu3OUHmEorzoy6Q8VT5exMB2+hKbIMZtomkUbJKIKor6oCAyHNxA6Wdcmn87SEKB0hMgEnoNgNvpJJz9BXJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705695143; c=relaxed/simple;
	bh=fXyLiyUsRSJIHfYDV21oU5ulEzgK0Z80Umh7/bQf1l4=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:Message-Id:
	 MIME-Version:Content-Type; b=IwXBEehVP80Y56Pym1pWSWCMMU3m58b8UMm8mkOwBVd6uDe33lXf+1lS6zHu3BDYmc1NtMaerP7mXgzGg1aIlyFPU223rlZ3WmJ2mUTqmyXceM7XoqEK5mM/BxX+DKeRVpOKZNmwb3DztPXyp0Dt6RSOMeXng5mO3/t90junRKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IrgFRrW1; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-559d95f1e69so1270167a12.2;
        Fri, 19 Jan 2024 12:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705695139; x=1706299939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:references:from:subject:cc:to:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2TS9bhCvX81BzYvjrCjCIu9g02Wi4a1sZOjpMM5Ue90=;
        b=IrgFRrW1lR1WLrzbCwdiWv+BKuTepIf5fjk0p2b+5B369+DnvaTAl6yl3S1DHVU+LO
         G1klm/mB5fQV7U0eY4Pv1dBTCGutZ5sFgwHF2Zgud0mr1TEg1KKRMaz3FcvLenCjb8Pl
         CEGsRrvxgeqVj05GWoRgsQex4BbR1fwwB+eUXZSudiho/l8xCBlUHrRr63tKMh3iPucY
         rfzGg44OhQ4p4BH4xwu7jKj/irSmYuSi8QMkerjWEKtX/xt5J9YYFwTjYbt4yvKCRdIx
         GumlgUaJ2LQ3Y0bFasMb58u22a2co6EjjgJ4WnkaL544UElxOWWOSwWueyDZ/64hjzzk
         67xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705695139; x=1706299939;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:references:from:subject:cc:to:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2TS9bhCvX81BzYvjrCjCIu9g02Wi4a1sZOjpMM5Ue90=;
        b=YfW21iiDM1Dv4CcWM6roIio8nv8QXIv/YmXDJNvnmeP7PN2N0BUhJRQ2OmmTiCYvUj
         lFGx60mEuTMjB5EH/7SmA50qEnMxrmHd587/a9Yl5D1+oIu2MQI7/p+oqOZvEjjRTMsy
         z3LNp3KP1hM6K8/X7cTfHW4Uh+HLVOfQC/zOuT25pP6j1ox4M7LFUj+CzwUAaMuoSkdt
         wm0aHruB2oBF6DwuogoAeOZoVRibs73wOjezN+tUyDauSZP36cpJTqnKysqzr9N2Gw5A
         0AazXKutMLlhlmLrDkej2pww3nOfx5fbt64mA5GmrMhEZfDWv32EK4efUkkkHaliyvJ4
         +yfQ==
X-Gm-Message-State: AOJu0YxO+6/kA/NHFhG54IYpR8bzPJfPa8omAEJLrxIHl3Nt1kKyNE4l
	CPAa3pbaBnv44zjrynXfqlCejFjDYQSehX6Lo0xOvOKwmOVjvY4w
X-Google-Smtp-Source: AGHT+IHBY5sL8v6bSnyjjfMHGuefWmvC3Qp9jRz4sRIp+KtsAFB7+lfrGd0LiAT881RGR3Cix1t0+A==
X-Received: by 2002:a17:906:46c8:b0:a28:e441:7983 with SMTP id k8-20020a17090646c800b00a28e4417983mr162618ejs.52.1705695139372;
        Fri, 19 Jan 2024 12:12:19 -0800 (PST)
Received: from localhost ([2a02:169:1e9:0:8f4d:9ee2:cc35:c67b])
        by smtp.gmail.com with ESMTPSA id w26-20020a17090652da00b00a1c7b20e9e6sm10636175ejn.32.2024.01.19.12.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 12:12:18 -0800 (PST)
Date: Fri, 19 Jan 2024 21:12:18 +0100
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: djogorchock@gmail.com, jikos@kernel.org, benjamin.tissoires@redhat.com,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Abaci Robot
 <abaci@linux.alibaba.com>
Subject: Re: [PATCH] HID: nintendo: Remove some unused functions
From: "Silvan Jegen" <s.jegen@gmail.com>
References: <20240119072729.54499-1-jiapeng.chong@linux.alibaba.com>
In-Reply-To: <20240119072729.54499-1-jiapeng.chong@linux.alibaba.com>
Message-Id: <3SMXOLWNXNNST.2TH7SLE53PSD3@homearch.localdomain>
User-Agent: mblaze/1.2-26-ga287cf9 (2023-10-22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:
> These functions are defined in the hid-nintendo.c file, but not called
> elsewhere, so delete these unused functions.
>=20
> drivers/hid/hid-nintendo.c:670:20: warning: unused function 'joycon_devic=
e_is_left_joycon'.
> drivers/hid/hid-nintendo.c:674:20: warning: unused function 'joycon_devic=
e_is_right_joycon'
>=20
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=3D7992
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/hid/hid-nintendo.c | 10 ----------
>  1 file changed, 10 deletions(-)

Reviewed-by: Silvan Jegen <s.jegen@gmail.com>


>=20
> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index ccc4032fb2b0..7ce6be0a8dee 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
> @@ -667,16 +667,6 @@ struct joycon_ctlr {
>   * These helpers are most useful early during the HID probe or in conjun=
ction
>   * with the capability helpers below.
>   */
> -static inline bool joycon_device_is_left_joycon(struct joycon_ctlr *ctlr=
)
> -{
> -	return ctlr->hdev->product =3D=3D USB_DEVICE_ID_NINTENDO_JOYCONL;
> -}
> -
> -static inline bool joycon_device_is_right_joycon(struct joycon_ctlr *ctl=
r)
> -{
> -	return ctlr->hdev->product =3D=3D USB_DEVICE_ID_NINTENDO_JOYCONR;
> -}
> -
>  static inline bool joycon_device_is_procon(struct joycon_ctlr *ctlr)
>  {
>  	return ctlr->hdev->product =3D=3D USB_DEVICE_ID_NINTENDO_PROCON;



