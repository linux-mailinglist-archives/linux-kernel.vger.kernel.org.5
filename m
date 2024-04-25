Return-Path: <linux-kernel+bounces-158882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68ED88B2632
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E87061F244A2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 16:19:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F5214D2A2;
	Thu, 25 Apr 2024 16:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iR18/QXa"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CF714C5BA
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 16:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714061974; cv=none; b=G50qIAwQMELgs/o/sXP5fFwfBB8+/c+T5ZapgbP25VhL635OiFX2/z0/njQvpYhb5dVEvWvRVsYgR1R7XHTzf+HBahdzpEThoR+XM7jq7d9Qp9XVdazOtTq9BMDysLg1Gi1z/Ix+93cnHoN6hXNNjgAOo4HtgUOHk9PemASMkeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714061974; c=relaxed/simple;
	bh=YMGGIiyahPr1ihVzKAGciOXoi6jScO2RrOFohqSxbog=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HMLi1L6kaKxFkjU3R3fcj+evR7fVVxfBJuoGIN6GCt6WGtpmlF8HloI/+GUNq4wsZt58LJb2IejlCbYzziL9MJuHk3ZfvdM7Z0MByOWyWSe7qwLjXE+ow3xhfjxGjaOAkYPsCRtonHtiZTiH3h3PIpqzD6XkVf8VuUwnvixidI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iR18/QXa; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78ecd752a7cso76899485a.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714061971; x=1714666771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMGGIiyahPr1ihVzKAGciOXoi6jScO2RrOFohqSxbog=;
        b=iR18/QXatk7X9rQRIAZIzNYR0/bbLm5lRfWjD7zv6VIb3zigTChIpTafga4cwPp9Eh
         cBAkMD4/z0s6kgU77wMSQ2HizFsURrNNHUE5PBsEMfhP36QY0/WjfVHElamfPGaInbjS
         eB7DNYVvQABmHU5cK7+kLyIHEBREzXXb4sbec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714061971; x=1714666771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMGGIiyahPr1ihVzKAGciOXoi6jScO2RrOFohqSxbog=;
        b=s9DIEmzg0XKd5ksDEsWi995hsNHdcYmGart+BYyXV2V3n+4HuNqrHNF+SR07jTEakD
         bGO6ijgkCwMPbSZGO1eeiNOYVCaIPCzKYSeQ0Cj0jFIq6oSBZJHPNNWZ1Mku124QPYQx
         qhF68UtrRiRjwF03Gy5pMIZYNSOuInqxyLRq0BE5Eo0hozsDzqqnINOEd1oeuUHxBS3o
         74RpliuSpLuh1498VHeUtnRRvpWDYeNGOKwpVDTCJjT3SgatiRVNKX35MNedwDz7bOYz
         gXGBjOyFK8blWCIomSsLlVnrv0Pvfgs4ffsspjBE8Qrty7QKsp+1eEW1x1MFdfJDBTHA
         9Pbw==
X-Forwarded-Encrypted: i=1; AJvYcCU1h93C2d0JlnVXkGNAzdTTQ0QMfo+7rjRK3t3aQo8NqvLhIOq9SCXzTkhV7S+28aV+eyM5Tn/ERYiEluul18M/sjZ2vPF9GfSDtoxf
X-Gm-Message-State: AOJu0YyD8QIaBljk7E/Q4tjKqZ+sQfTFQs/28QiIMmIXsGkUrd8LWIq6
	pDWybVlb0Stn6FtiuR2/2ulHQVqZCKPcKDwaAQzG2Oo1arWMv4p5W14IukNK3zL5bBapBWJznkU
	=
X-Google-Smtp-Source: AGHT+IHOn4xoDYP/uj8AqTPn5Vjaw3w3V4hbfXuZrhCcNtyW1sl++xbJKlk7O+Xac3u4loHhtc2Emw==
X-Received: by 2002:a05:620a:147b:b0:78e:ea6c:bd1a with SMTP id j27-20020a05620a147b00b0078eea6cbd1amr50155qkl.1.1714061971006;
        Thu, 25 Apr 2024 09:19:31 -0700 (PDT)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id q24-20020a05620a0c9800b0078d677e72f3sm7170797qki.118.2024.04.25.09.19.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 09:19:29 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-43989e6ca42so401371cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 09:19:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVsiouamWx8UrPkHMZbvkkkWIbPjTZHgtcBrUFXYnXT6KveBLpgusnb/0YQrfNKLn7+UIrp2Dl5BbyyUwzGAHXHhfJKEkC63xcxoLEW
X-Received: by 2002:a05:622a:1825:b0:43a:5f02:bbe2 with SMTP id
 t37-20020a05622a182500b0043a5f02bbe2mr125019qtc.24.1714061968946; Thu, 25 Apr
 2024 09:19:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416091509.19995-1-johan+linaro@kernel.org>
 <CAD=FV=UBHvz2S5bd8eso030-E=rhbAypz_BnO-vmB1vNo+4Uvw@mail.gmail.com>
 <Zid6lfQMlDp3HQ67@hovoldconsulting.com> <CAD=FV=XoBwYmYGTdFNYMtJRnm6VAGf+-wq-ODVkxQqN3XeVHBw@mail.gmail.com>
 <ZioW9IDT7B4sas4l@hovoldconsulting.com> <CAD=FV=X5DGd9E40rve7bV7Z1bZx+oO0OzjsygEGQz-tJ=XbKBg@mail.gmail.com>
 <ZiqBQ3r3gRk2HBir@hovoldconsulting.com>
In-Reply-To: <ZiqBQ3r3gRk2HBir@hovoldconsulting.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 25 Apr 2024 09:19:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UXHWUfg-Gh0u3PG67O5fHLhWqhGPQFQjZMmEYt3Pw-Wg@mail.gmail.com>
Message-ID: <CAD=FV=UXHWUfg-Gh0u3PG67O5fHLhWqhGPQFQjZMmEYt3Pw-Wg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: fix invalid device address check
To: Johan Hovold <johan@kernel.org>
Cc: Janaki Ramaiah Thota <quic_janathot@quicinc.com>, Johan Hovold <johan+linaro@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Matthias Kaehlcke <mka@chromium.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Stephen Boyd <swboyd@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 25, 2024 at 9:13=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Thu, Apr 25, 2024 at 11:22:50PM +0800, Doug Anderson wrote:
>
> > Quick question. I haven't spent lots of time digging into the
> > Bluetooth subsystem, but it seems like if the device tree property is
> > there it should take precedence anyway, shouldn't it? In other words:
> > if we think there is built-in storage for the MAC address but we also
> > see a device tree property then we need to decide which of the two we
> > are going to use. Are there any instances where there's a bogus DT
> > property and we want the built-in storage to override it?
>
> I guess we could decide to implement something like that, but note that
> a devicetree may have an all-zero address defined by default which the
> boot firmware may or may not fill in.
>
> So we can't just use the presence of the address property as an
> indication that the device has an address, but we could of course parse
> it and see if it's non-zero first. (Actually, I think this bit about
> checking for a non-zero address is already implemented.)

This would make me feel safer. Given that you've now found that the
MAC address is in the firmware, I worry that someone will update the
firmware and change the default and we'll forget to update here.
_Hopefully_ someone would notice before pushing the firmware out to
the world, but it still seems like a more fragile solution than just
seeing that there's a perfectly valid BT address in the device tree
and using that.


> Note however that we still need to determine when the controller address
> is invalid for the common case where there is no devicetree property and
> user space needs to provide an address before the controller can be used.

Fair enough.

-Doug

