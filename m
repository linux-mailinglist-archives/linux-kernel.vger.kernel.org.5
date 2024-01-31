Return-Path: <linux-kernel+bounces-47004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 597998447D2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D68A81F2445E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2559C374DE;
	Wed, 31 Jan 2024 19:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wC4EDloc"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC4CE38DC8
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 19:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706728370; cv=none; b=dNKHK7jKhZ3NGe7AxlPKfr9iBfxr7D0Ztq2f4LjlZBPG0Gu6RFpMTIxXGr2wGX6RuEy+8dyOK3Mo1QIQINgGH6YkbJqH/kL5EqIrxInZ/xKrnc53pOH2HcaYW9dWh/c0QOX7leSCq1LF5Q2G6MVHWa6ncs18cB+U90zhXllPd78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706728370; c=relaxed/simple;
	bh=vhN5lp2BqQRiTO9vKNu52FfXD7GOpYx3siRJcFp6+UU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bI95YhkV+AWARq5I5hrVX+CgwQ5xCKNf4OEhv3EpnZ6KPma2Niex64Qze0UFdyquDeI0//zAJsHjaM0PaSYRvAhZg3Lj7KrwnxFVdpSRRMd0oQmaXcRZomdRQAJrXr1I76rT1hbYObnL2B8KCdtwWRnILjqJH95WqPiXOK1Fsag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wC4EDloc; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40ef9382752so7635e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 11:12:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706728367; x=1707333167; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhN5lp2BqQRiTO9vKNu52FfXD7GOpYx3siRJcFp6+UU=;
        b=wC4EDlocjDdk5e8+D6HmxM4QbqN7GPZD1deUiKRhJRF0U4zywG+SEsJQ7NSIL1ag1d
         Va5UCaRPJftfaIOuAVDhbJZDYeycyuQxfTOkjLObq7KovMoAyFQwoXiw0pvHGiRehfXA
         Rq6IG003u+c2FlldeDZSMOfo+XbpWPsgCO43amoKwUN/CWMvFsab2F4gvrVqzeF+t9jc
         ADcNIJx0PqqlMvlPg3FLE3xjJTTHhSnBXa82Xew51r3XmwbGD2NRQ4x8XyiXwigDg5T3
         jor8c6b+uDMHyLbCUPqAEgU3HzhVnLtieAv6N5ICs/cxH6fEMvDZXj8/NS2ptdNdF/xJ
         Bl7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706728367; x=1707333167;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vhN5lp2BqQRiTO9vKNu52FfXD7GOpYx3siRJcFp6+UU=;
        b=GZIwty/J7Fai+MaBabIXopZc50X9zDcMbhgXobxH7d443gGhlLDP+BmWt8072cm6Rd
         NbL3K5KwiD9K3rJqTnERLBybzZ/90D4g7xKZw9I5znMt709M3aBtJCFF0mMzItd7Pch/
         FbSE0qtItcx1X+bM6YxvgTN3zd3w75c8WKieFy9lx+022YcornDta5Y6T1H4k8mqIGHc
         kegHB4dgJGHChFZTj2JC1jqXawR501q9wdlgWZ3PYZWALny5RrOucu4/7kPTE/aSdm7r
         eNUAP0dcG+vQk3IcyCIbhGhYn0PotNDoscd9YVkvbMC84h6u0m9Pq/D5gItX5SrLpjAr
         /aNA==
X-Gm-Message-State: AOJu0YyHMm8inDo2rPW/+fsyqx+SncxZ1lKvG5Dg9ShxIeYvHQx2juUq
	/NeSkkwoYZ+oqf+L/a7H+H0qV/Hv5wVlDw35TfFvnQ+N1dQAZXNs/y7otZgtgFC7eGz2im3GU8e
	TKJttssGbTIu5SD3p2LGtweMwY1P5E4vXO0QIGngecYGKkWWH
X-Google-Smtp-Source: AGHT+IEVyUi4ClrEHWbOLHxzZZwz3mlYx6R6mQimxw7H0BPUSD8fbUalGhAOhuneYk0UeMo1183N1YkrZEWj21qlyYA=
X-Received: by 2002:a05:600c:3d09:b0:40f:b642:1919 with SMTP id
 bh9-20020a05600c3d0900b0040fb6421919mr20632wmb.5.1706728366828; Wed, 31 Jan
 2024 11:12:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AS4PR04MB9715AECEB559CC8B637D67638A7C2@AS4PR04MB9715.eurprd04.prod.outlook.com>
In-Reply-To: <AS4PR04MB9715AECEB559CC8B637D67638A7C2@AS4PR04MB9715.eurprd04.prod.outlook.com>
From: John Stultz <jstultz@google.com>
Date: Wed, 31 Jan 2024 11:12:34 -0800
Message-ID: <CANDhNCoh3O=Ds_oLkGer7KKVUW4Zdf_vDdDmyJFVKhDSGU5c-g@mail.gmail.com>
Subject: Re: Setting real-time clock below monotonic clock
To: Joseph Beckenbach <Joseph.Beckenbach@se.com>
Cc: "tglx@linutronix.de" <tglx@linutronix.de>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 10:48=E2=80=AFAM Joseph Beckenbach
<Joseph.Beckenbach@se.com> wrote:
>
> We have observed that we are not able to set the realtime clock=E2=80=99s=
 time value below the monotonic clock=E2=80=99s time value in the Linux ker=
nel.
>

Indeed. That behavior was intentional.

>
> We have a situation where we will try to set the realtime clock time to a=
 very low value (close to January 1, 1970) and below the monotonic clock va=
lue. In this situation, it does not matter what the date is, but we need th=
e time to be synchronized across multiple devices (using generalized Precis=
ion Time Protocol or gPTP) for our application. It=E2=80=99s possible this =
synchronized time might be a low value (close to 1970) because the gPTP mas=
ter starts its time from January 1, 1970 when it is booted, and when this g=
PTP master is booted after the gPTP slave, the master=E2=80=99s time is lar=
ger than the slave=E2=80=99s monotonic clock (which also starts from 0 when=
 it is booted). When the slave tries to adjust its clock to match the maste=
r, we get an error.
>

I appreciate there may be many constraints here, but it feels like the
device you're trying to sync to, reporting its time as close to Jan 1
1970 is misconfigured.
So I'm not sure it's reasonable to expect the kernel to support that case.

Is there some different perspective I'm missing, though?

>
> Currently, we are planning to use a workaround where we keep track of a k=
nown offset between the =E2=80=9Csynchronized=E2=80=9D time which is 1970 a=
nd the =E2=80=9Creal time=E2=80=9D such as 2024. Since the time only jumps =
once at the beginning of sync and should not change by more than a second a=
fterwards, we think this will work for now.
>

It seems if the device you're syncing to would start its configured
time from date even slightly closer to now (start with 1980!), it
would also avoid the problem?

>
> We currently do not want to spend time pushing for a change in the Linux =
kernel. But I wanted to at least report this use case we have and the issue=
 we are having because of this behavior in the Linux kernel.
>

I'm sorry I don't have a better response for you here, but I
appreciate you sending out the mail. It's nice to have more folks
working on time/time sync interacting on the list.

thanks
-john

