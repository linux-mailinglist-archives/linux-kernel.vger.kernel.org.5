Return-Path: <linux-kernel+bounces-29474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0914830ECE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 386571C2221F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 21:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC152563C;
	Wed, 17 Jan 2024 21:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3sIgyPcK"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83962562E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 21:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705528346; cv=none; b=EGEaOM36WkReZ6Mezy6fztNPa8O8r6lnjR/TRANYS+9KRZbc0d05oLDAFrF6PWoY9uALJNTt5u0m1pcwQTrAGz73O99FQ1gaA3qvCcUUsKnQM9NcApUIA7xxBp8fnQTKMkVMmqVkVkuA6HbIOY9rEuGTqtQUN55EKJIc91gS6cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705528346; c=relaxed/simple;
	bh=IvStd2xTfDq5Oo+gHa6tUQKtis3gXAShwVPWtd0rtEA=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=k0HhMwFkcsZXUfDzDB3vEhRnEzuyd9KNE/lcmzCQW7KBUNkQ1UMcixlOdsdt9+TaxrbHyXpAtdvUpVT60/wJRU1UlBHtH8W6eHztmZXHMKmpyYeNgF/mcfmCa35/uJsBXT+JwO7MVrmFukevNZApUZRdzND1BaWDuAr1YmjbwiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3sIgyPcK; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e4afe9ea7so65975e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 13:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705528343; x=1706133143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgsNp3I1GyR8LKSkgpTGCtUknvU84IXVbgB3bgHNMiQ=;
        b=3sIgyPcKFiATnmCr4gLRw1tq9VSn2IP+qZK919eCenod9UkRtlC5P56zGLkxpaCV+a
         GyNUCuklAVdomTHdJ8fueFCo37kmFcgyDZqVZO3dm8e+pvp6/aUSG1GQMIlttfzzARrA
         Zgonf58FuhDNAhZvSjarE/i2wJEFF+8BSaoLnSxa0HK9aX6wkhD/UVLOYYAkvFHImCRq
         7qkjjNHLB4U4ruo4AFbfzvnF8hDU4cEFbRREvWav+eb/jPfQzgP9JN765yd2l/IlP5LU
         FfFMBdV46pE12wViyfc8np1rRHiOCWv4qnmvigpt2L4P0smNF0AkL6KF8vwqBbnJUYg9
         EgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705528343; x=1706133143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgsNp3I1GyR8LKSkgpTGCtUknvU84IXVbgB3bgHNMiQ=;
        b=vyNIIhFdjUnOkES/TPGoZIQHzk0GTc/gPaI5j55prwOsRlaIwEaCrpPQuNZdXPgPHs
         sYoOTuOOdS2IK+jLP4JLRP6ZR/h3TB/c96WwjcQ/YItVziltXO7y6xhxD8Iah8IywQMB
         6FJ+kV5WGY5bIDuf5qT7+dPaXRzhn2mff+OPQxY/xEKqq3kePFxAgHP7O4wBE99FIE/k
         xXqcpiq0q3QRmvqMfqG4+6VWjyABGDGlM3xqbEwEnBhFZyhFtQXvTzXF2H/2tHW4aQMu
         zsOteJMlrc9lHs3t57KkolLY/Dznj6xAEw2DeREiUdI7vYfQgFOdCzOTqQ1ly5kkMjCy
         Pc3g==
X-Gm-Message-State: AOJu0YxG1fW+pd5jQE0aKvNwOkZ2WERJmKUulzPpwNsiYPuMMCdhLDIL
	Lxdzgj7Vry31brL1mnUWQId/goSqfkEXHR/Klz7cV9M8cgFtuDyslVA/+b5M8ZtmeDrMj6EVjNN
	7BeHMm6CCq3sh2IUd+umRZ9L6lS4MSTJy+qNK
X-Google-Smtp-Source: AGHT+IEjpv76xho9RIPvXy4nuNt63b8j9OdHAk+UiuVJdba+peVWPGHxPnwtg0NTkMnxiWXXWBec0vFbBgxMqviuurQ=
X-Received: by 2002:a05:600c:310b:b0:40e:61cf:af91 with SMTP id
 g11-20020a05600c310b00b0040e61cfaf91mr197767wmo.7.1705528342730; Wed, 17 Jan
 2024 13:52:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231227180306.6319-1-johan+linaro@kernel.org>
 <ZZ15c1HUQIH2cY5o@google.com> <ZZ1-ehpU-g6i9Qem@hovoldconsulting.com>
 <ZZ2IOQEekFffJoHQ@google.com> <ZZ5RVpL88XNbgKIy@hovoldconsulting.com>
In-Reply-To: <ZZ5RVpL88XNbgKIy@hovoldconsulting.com>
From: Doug Anderson <dianders@google.com>
Date: Wed, 17 Jan 2024 13:52:08 -0800
Message-ID: <CAD=FV=W61ZHYJADiR1CYgS-aNisDR4KoEA3RW2_8kW3KUd1g5g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: fix device-address endianness
To: Johan Hovold <johan@kernel.org>
Cc: Matthias Kaehlcke <mka@chromium.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bjorn Andersson <quic_bjorande@quicinc.com>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-bluetooth@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Balakrishna Godavarthi <quic_bgodavar@quicinc.com>, 
	Stephen Boyd <swboyd@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jan 10, 2024 at 12:12=E2=80=AFAM Johan Hovold <johan@kernel.org> wr=
ote:
>
> > > So the first question is whether there actually is any boot firmware =
out
> > > there which passes the BD_ADDR in reverse order?
> >
> > Yes, (at least) the boot firmware for sc7180-trogdor devices.
> >
> > hexdump -C /proc/device-tree/soc\@0/geniqup\@8c0000/serial\@88c000/blue=
tooth/local-bd-address
> > 00000000  8c fd f0 40 15 dc
>
> Indeed, this should have been LE order.

In case it adds any extra data points, we also do similar with the
WiFi MAC address and it also seems to be big endian.

lazor-rev9 /proc/device-tree/soc@0/wifi@18800000 # hexdump -C local-mac-add=
ress
00000000  8c fd f0 3e 3e 86                                 |...>>.|
00000006

lazor-rev9 /proc/device-tree/soc@0/wifi@18800000 # ifconfig wlan0 | grep et=
her
        ether 8c:fd:f0:3e:3e:86  txqueuelen 1000  (Ethernet)


> > hciconfig
> > hci0:   Type: Primary  Bus: UART
> >         BD Address: 8C:FD:F0:40:15:DC  ACL MTU: 1024:8  SCO MTU: 240:8
> >         UP RUNNING
> >         RX bytes:1700 acl:0 sco:0 events:95 errors:0
> >         TX bytes:128949 acl:0 sco:0 commands:578 errors:0
>
> And any user space tool overriding the address would currently need to
> provide the address in reverse order on Qualcomm platforms like this
> one (e.g. if generating the address for privacy reasons).
>
> > > > I suggest adding a quirk like 'local-bd-address-msb-quirk' or
> > > > 'qcom,local-bd-address-msb-quirk' to make sure existing devices kee=
p
> > > > working properly.
> > >
> > > I don't think that would work. If this is something that we really ne=
ed
> > > to handle, then there's probably no way around introducing new
> > > compatible strings for boot firmware that isn't broken while maintain=
ing
> > > the current broken behaviour with respect to 'local-bd-address' for s=
ome
> > > of the current ones.
> >
> > I think it should work for sc7180-trogdor. For these devices the device=
 tree
> > is bundled with the kernel image and can be updated. That might not be =
true
> > for other devices though.
>
> Thanks for confirming.
>
> I'm still hoping we can get away with not having to add quirks to
> Bluetooth core for broken Qualcomm boot firmware. Let's see if anyone
> knows of a use case that makes that impossible to avoid.
>
> Johan

