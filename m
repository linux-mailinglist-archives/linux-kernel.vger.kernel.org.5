Return-Path: <linux-kernel+bounces-45320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6A1842E79
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 22:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53CF01C22832
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 21:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC02178B4A;
	Tue, 30 Jan 2024 21:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lj/C+z8i"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20570762EC;
	Tue, 30 Jan 2024 21:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706648856; cv=none; b=mhtFxnWOhOXGbZLndI1pHRoQNxeoyDcnmITHNz1mRziPlljFCTcGXjz9o8hMt15mqDgi2/dvEwvcvhcleifeWcP8IC1eC4wG63nUGhWWwvRiNOZWuTfUMZGskuVD6pgBhIc7CP5TeLX1WTM+MeVZEpNM8Kt7ZL1mck4DkJnL1fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706648856; c=relaxed/simple;
	bh=Mdhg44Qjztr1CKpivR9/YQvJuZ4oCAobol6ImAw4F00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WSRjo0cvF+TDlwKg/wA0K752vCYOISgLoEF3xHh86+2xGLdi3eIhUIyCRMjoyBgvJsYqTn0Okkcl6CCi2NImGPipqxLvwlLmhFgRj9TfI+y8nvF0IapIS99S0WISy6YJGmFf6XGbVof5bUM+R5gO3sAP8qoEpb81r9N546QOXSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lj/C+z8i; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5100ed2b33dso7419171e87.0;
        Tue, 30 Jan 2024 13:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706648853; x=1707253653; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mdhg44Qjztr1CKpivR9/YQvJuZ4oCAobol6ImAw4F00=;
        b=Lj/C+z8ipP0Z5sHpVrcQ44vlYYPQujAR1CeKCtvMhmkM26qPFGHZze3szBHNmc2+z+
         zO/U9nM6DHtdHgjqjhwrNORv8dSGofM/snJhNwKdIe6sMvDT3JMYeuz/HBS/Hbt6Eb0X
         KeFX+/Ut7mmU4izidyO97MJjEqIpR/GHWyArJGcGvHWAGqv/EdEUOIqAp/ssjqX6U+9g
         fYQXifEB72lKMrOukKTwS88rJkSS/+XlKblWvt8Fi5Mc73E9Ugb1pyw1f0Kl7202X+d5
         MmP7q9mB5mdzv1oN2HqeFHwgorzrkfeIAj72byL5z9MJBn79WkSOUQB3+etVPqHBq0U7
         UfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706648853; x=1707253653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mdhg44Qjztr1CKpivR9/YQvJuZ4oCAobol6ImAw4F00=;
        b=iR5BzbC1tBdDSz1blqmnqDsejvQ+Pg95Hp0bfAasGIcL8VPapoIOhdDWudc5bFMhiN
         iFti6xrJAbFVh1AD0YTddFTeQkoWVBP5mf+cZs2t/VSpHC+l7qNpT8VrKoB540GUNBIq
         VMr3jrjL6KVbGOVvBeF9d5twwtlCYDSHfCDQo1AooINhpA3PKoJJGzGS78eVYClQvTvP
         ybiFwGE7ML8EP87dXuM0nVdh+XzHnuybwKMGoYTyxzKfTRn4ogH1vrQO+AhhIXBy7qUJ
         2E8WJ+UuK/KLbIyfJL0buyIA8DpIVkmq1cwsCwZqCAw2TmD3qbJardUoscITK0A4Qdqt
         WR5A==
X-Gm-Message-State: AOJu0Yy0lzWkR9WjsRPfpV8pPuKo/cuqyY9hqfGjCAR2KkOi5FixyPiW
	+NDGa3XXmzDQGOFghNFlhxIUtBlr81XM7Dmfdkzyfk0eYMU4INg2Si1p4PnBGBN71wgncDR8Jqt
	4FAfNBGKrB2BtTDdGHzQMzwCuMbQ=
X-Google-Smtp-Source: AGHT+IG/NNfOBuC+bRUZNf/fg8JPc+cFNXVBFM7r/LlBjJ7UtHGJ+l5lVCXl9+nDwtMNpF1H7F6fRX5NPhXF6OhuZLo=
X-Received: by 2002:a05:6512:2209:b0:50e:8137:9a13 with SMTP id
 h9-20020a056512220900b0050e81379a13mr8439646lfu.66.1706648852871; Tue, 30 Jan
 2024 13:07:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115144538.12018-1-max@enpas.org> <20240115144538.12018-8-max@enpas.org>
 <CAEc3jaBU3M0Zce2pdFvdBSG50a7Ky=GY4gLO3dkYdDrkYtiO0Q@mail.gmail.com> <e107b202-5843-41a7-b61e-68dd92128176@enpas.org>
In-Reply-To: <e107b202-5843-41a7-b61e-68dd92128176@enpas.org>
From: Roderick Colenbrander <thunderbird2k@gmail.com>
Date: Tue, 30 Jan 2024 13:07:20 -0800
Message-ID: <CAEc3jaCifoWW3ZXHvySSfgwhVm1AffYe=z7HRP9RjmYyu53w7Q@mail.gmail.com>
Subject: Re: [PATCH v1 7/7] HID: playstation: DS4: Add VID/PID for SZ-MYPOWER controllers
To: Max Staudt <max@enpas.org>
Cc: Roderick Colenbrander <roderick.colenbrander@sony.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 27, 2024 at 3:16=E2=80=AFAM Max Staudt <max@enpas.org> wrote:
>
> On 1/25/24 10:03, Roderick Colenbrander wrote:
> > I'm not familiar with this device, but if it indeed works. Then I'm
> > okay with it.
>
> Thanks!
>
>
> I've just tried this patch on real hardware again, and there's a tradeoff=
 here - it improves the situation for one 7545:0104 controller, and worsens=
 it for another.
>
> Up to you, and if you don't want to think about it, then let's shelve thi=
s patch :)
>
>
>
> Details follow, if you're curious.
>
>
> I have two controllers with VID/PID 7545:0104, and they're both very quir=
ky multi-emulation devices. One is shaped like a PS4 controller, the other =
like a hybrid between a PS4 and a Switch controller. Since these controller=
s exhibit all of the USB related quirks in this series, I've kept them as r=
eproducers. Other controllers that passed through my hands only had a subse=
t of the quirks.
>
> Up until now, both controllers worked with hid-sony as PS3 controllers. W=
ith this patch, the PS4 controller gains LED support and fine-grained contr=
ol of the weak rumble motor. The "Switch (?) controller" on the other hand =
errors out, becomes 0079:181c, and loses the Home key and the accelerometer=
 This is a user facing change, and the question is how much we really care=
 about these controllers.
>
>
>
> More details, if you're still reading:
>
>
> Both are "multi-purpose" controllers, appearing as PS4/PS3/Switch/other c=
ontrollers in sequence. They advertise themselves as one USB device, and if=
 there is no driver sending whatever init sequence they expect, they discon=
nect and try emulating a different controller.
>
> The PS4 controller has rumble and an RGB LED, and this patch series impro=
ves its functionality. It cannot emulate a Switch controller.
>
> The Switch (?) controller has no rumble and four multicolour player LEDs,=
 but it adds Switch compatibility including accelerometer and gyro.
>
>
> For the PS4 mode, which is the first that they try, and which would unify=
 most functions, they use 7545:0104 instead of cloning a DS4 VID/PID. So I =
took a guess and found that it works fine with hid-playstation if I add the=
 VID/PID and the init quirks in patches 2/3/4. Well, to be precise, I've on=
ly made the DS4 shaped one work in PS4 mode, the Switch controller isn't ha=
ppy and errors out, see below.
>
>
> On the PS4 controller, this makes the RGB LED work, rumble works, but the=
 gyro and touchpad don't send HID updates. The touchpad can click though, s=
o maybe the controller I have has a hardware defect.
>
> The Switch (?) controller is where things get weird. It disconnects, even=
 though it is initialised by hid-playstation, and transitions into a generi=
c controller with VID/PID 0079:181c. This mode is *not* on the list of emul=
ations it usually tries. It's as if the "unfinished" PS4 initialisation tra=
nsitions it into a hidden fifth emulation mode. In this mode, the home key =
does not send any HID event, and there are no accelerometer updates that hi=
d-sony would receive in PS3 mode.
>
>
> So, with this patch, the PS4 controller works better on Linux, while the =
Switch controller works worse. Both were seen as PS3 controllers up until n=
ow. I see no way to discern them at driver probe time.
>
> Any preference on what to do...?
>
>
>
> Max
>

Hmpf, euhm euhm I'm not entirely sure what makes sense. From the
sounds of it are somewhat broken devices (buggy firmwares on them) or
perhaps one of your controllers (the one with not working touch) is
perhaps broken.

Some of the patches like handling report id 0x1 (minimal) won't hurt,
the LED fixes won't either. It makes it easier to add more devices. I
wonder if we have fully have enough data.

Need to think a bit...

Roderick

