Return-Path: <linux-kernel+bounces-145041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFCA8A4E9F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:12:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD709B2184F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20E469DFD;
	Mon, 15 Apr 2024 12:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yAWmEK2q"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDF169D2B
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713183062; cv=none; b=KyQZ24RdWn1hKy2T7rknL/PWNC343c4YQn8Fl/1to2HXexg5o7doORn5lbx2pOH30fpLOGMVlYWFMs3yobkWOYE3Jmp1+gRGBxvzjlkex9CHWnOgIIE2j1Xs+q5UgK5D8PkcsojLEbKs1CKurSYdqmD5OWvWmNvLyOP78jYGr3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713183062; c=relaxed/simple;
	bh=uZcPwUmPewYNTemFmRAkQ3TSjOKlDhuahQQ3LNghFA4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eBJ0Jg9i70iGS7CeF5XYQsY3dd37JDTaVgE85l4yApjR7SrJH4Gr7fr4839FlAb1iIwhrk1/uMypJoyaulCEv4XtYz6U9h1jtQZW9T9+oDF5EL8ATtMVDPVWvLXLhxFA0ZTyr4PSA9iK0HSex8E6ZWuRzz1weYrfC/WB+a9ka1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yAWmEK2q; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-516d0c004b1so4009152e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 05:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713183059; x=1713787859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZcPwUmPewYNTemFmRAkQ3TSjOKlDhuahQQ3LNghFA4=;
        b=yAWmEK2qZr9qTKpAjlHLCuayjYpVKGIZjYuP++ChFVkbzDHan4pJhIXER0SdhSOSBr
         43ww4DEWP2DdmtLx1NZYxqlXY3b1urqQnNFcma3hZgOwGnjqwGVVU00eQnFHN2Lz5ss0
         w4cf2cI1OrZlGPbOzbRbpq5NR5vZ/5E5yLzHDGrV7GmJqT3ky6vc+JLhQzaKN6nhDZfN
         5rc0gTvAQ3r3Zb5ZRtIk2meVRgZG09MEuQ9X+VpMVGr6ey7b4jzjCMl/mXq2LCPltCEV
         WTmYG9f99zSDGXXIDd4m/GBzbydrWdViW+tUlG4YpmtDeN1tweWuuWQuAIp0AqFqmpxA
         MPKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713183059; x=1713787859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uZcPwUmPewYNTemFmRAkQ3TSjOKlDhuahQQ3LNghFA4=;
        b=Q3lF9YU8j/9nqAGovWSk99h56/MgY8sLDOes0et9Wt2trsICHS2LeaUerChGAqHrXF
         6FKpD+AJ+jZXU0Rd8YVWZxYL/EU4oIoTbcK0u2aO1Rq8LHzre5wodnQW35fSEBKoZ71V
         TqjT+cyDds4fbzvWQB43uh2SaRl5ff3nYoN/QsQHM6Aw/ez4/nvCD+3w81ryLXbCDnbA
         XOo+Mwr99bQHVz/up+d8anmjyA7uE7DTPz7eX70d0Wt0GdAJ8knV8qMMqnsdgP+VYGJs
         i4/+zp+zd8Gwlt9x6hSqEj8F8eX4PcXymDqqxyh7EVOhSC6AhdFiYd5x034Hnygru81d
         hNHg==
X-Forwarded-Encrypted: i=1; AJvYcCUHq6o0uPu4XqwdQjAb6OPY260EPxLre2kLFZ76gd6w32A/k8hyV8mrBQnofig+INLyrDy+Ih5+pQC2rNP3g6AWRGbfxkZxppSUuuRi
X-Gm-Message-State: AOJu0YzpypLv0i7eZc/ZjBTSo0EToEBVgWxmfmHSUleVvcEBP3ft5Ryo
	TUCTa8wzLUQs4UrbcItiuSOD+WcqGWZLskFUkyotBiljIDS/+SYWnhEZaEh0aiul5HN/i33pWrL
	2x0mV86XhaIUr2EsqHDfj4H25kaVvKQ+UKjM+
X-Google-Smtp-Source: AGHT+IFIS5vV5+fToa/71J8ktxP//gnCn+SHgfCYm71FdcJtvt/AfqAk+5Ldztdy5+/O5cu5RHFbgRZ+wGaxQz993V8=
X-Received: by 2002:ac2:4c9c:0:b0:516:d18b:eaed with SMTP id
 d28-20020ac24c9c000000b00516d18beaedmr8334452lfl.30.1713183058739; Mon, 15
 Apr 2024 05:10:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE5UKNqufWZfKLAXLcpBYKQpJEVt6jPD4Xtr=Nesh34VkNOETg@mail.gmail.com>
 <81e1b870-37f9-4ef2-9a3d-87015f32546b@kl.wtf>
In-Reply-To: <81e1b870-37f9-4ef2-9a3d-87015f32546b@kl.wtf>
From: Radoslaw Biernacki <biernacki@google.com>
Date: Mon, 15 Apr 2024 14:10:41 +0200
Message-ID: <CAM4=RnJAe1wzi_+Nif0wiSeqC5GR6Aavz97mY7tm=hFu3mijhg@mail.gmail.com>
Subject: Re: [PATCH v2] HID: i2c-hid: wait for i2c touchpad deep-sleep to
 power-up transition
To: Kenny Levinsen <kl@kl.wtf>
Cc: lma@chromium.org, benjamin.tissoires@redhat.com, dianders@chromium.org, 
	dtor@chromium.org, hdegoede@redhat.com, jikos@kernel.org, 
	johan+linaro@kernel.org, johan@kernel.org, kai.heng.feng@canonical.com, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, mripard@kernel.org, 
	rad@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kenny,

> If the device can enter deep-sleep arbitrarily, then we presumably also
> have problems in i2c_hid_output_raw_report() and
> i2c_hid_get_raw_report() which could happen after the device has gone to
> sleep from inactivity. These places would also need EREMOTEIO retry logic=
.

It does not enter deep-sleep arbitrarily and therefore it is not a problem =
with
other communication patterns.
The design which was chosen back in the day, to save the battery power
is event based
instead of level based (some HW line). Therefore to avoid power leak
we need to request
low power state (to prevent power leak in case the kernel will not
boot up soon).

Basically we need to take out the device from deep state logic by message,
without knowing if the device is on the bus or it is on the bus but
not responding.

>
> All these places should have the same sleeping behavior as they are
> working around the same device glitch. I imagine the client ACK timeout
> is longer than your required 400=C2=B5s, in which case you don't need any
> sleep on retry at all, as is the case in the current i2c_hid_set_power()
> implementation.
>
> However, as we litter retry-code all over the place, Johan's suggestion
> about doing this in the I2C driver does become a bit more relevant...
>
> Best regards,
> Kenny Levinsen
>

