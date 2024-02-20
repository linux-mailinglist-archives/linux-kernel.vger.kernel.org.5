Return-Path: <linux-kernel+bounces-73815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B842685CBF1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E97771C21BA0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EE7154C02;
	Tue, 20 Feb 2024 23:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="asdJXhIH"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893AB76C99;
	Tue, 20 Feb 2024 23:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708471191; cv=none; b=TpzspQV1F+6FL3wgNEDXYCQciO0qyE4YG5NWIzM9K7EP+WwcXUhGVrTrTa/YR+Gk4gwtUEnBb3Fvv47+qyhZiqKRj8bh/RpSaCgohEmT5eSva2UAi/7VmN0LSLhBV9bOf7SHYnGhsNHkpojkmT2UgauXH/SmZt9+aBPvnCj9gxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708471191; c=relaxed/simple;
	bh=j4AZpUs7iNUNOw3+U2CKct0moYYUgG7dyRsvoaQkXgA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MTawO+6P+FcvBR9La3BpMZvSuRFzICQUBFrt+b/ryagziKTAS1Ao81QnR8byC9dNvt8vpXlWuVNFg6HNOo+rWCSpy85FmEz4yHFyBuSwwQoA/JhyvzK2idpQo/GTzpKhRQyMdkzB13kSLNcPqLVYdj9zpooFQERITwWInO+UCPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=asdJXhIH; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-68f74007267so5838306d6.0;
        Tue, 20 Feb 2024 15:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708471188; x=1709075988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4AZpUs7iNUNOw3+U2CKct0moYYUgG7dyRsvoaQkXgA=;
        b=asdJXhIHFnzv3DoUezuHzTuXFT1z3s4/ZJIwDqb7lAMIm6gii7VpnHdSezzCzOTtWe
         z9vgSuTEGP1e4f8D8DIZV7x6dqz0WqWq4JpF/MYEJnSoeA1fjKIcR+GDrwqi3pcPc86U
         qNEpH4/yVNzApmIEwSnxxSZqYV26Y7LNXZsfN6cG0ngaTyrRHoZawch0lanrU3eoE86c
         kl9nNYMj62nDVbui3jsjMXGnQYLHf8gLGCJhlksS7yKVsde+jXEq3Xti9Ln/GRoZXke5
         hS7ApySaBKWDJ7bqvp07te6Y+7Mfo8HrelKqIq03q/NWoqCH3gwNvSIfK0/xUiRUTq3Q
         veXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708471188; x=1709075988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j4AZpUs7iNUNOw3+U2CKct0moYYUgG7dyRsvoaQkXgA=;
        b=gyzZrHyFuNzWHk0uVYywuHexO4PUpMcWJwhBONZWU2wmDfwHm+baAb/JXdqr+XxOLl
         AhBlbNP0bUf/+iIvYf7AaJQWh16fxTLNfNXJZkpZZCQBiaW3FMjeHIPSE0L03Jl/9ovg
         FFjP7ZXFGZqUfxnNDkWLj7V1ivRHihIo8lDHph1ycxNFtnfaKmKrrNR6pb1/S40kovVq
         Z1kBUiqhxeiVFjAS7NPlW7d/M51Uya+BIQ4SCG+ALs8EVm78a9VrsHIxrBk/poJVPPii
         Fnk9VJAm/dpmHI9/Bp8TQ9C8OyqTAPWocBxY/p4GMEcIg4/GL2tsMMEL7J/ZZnCCr63s
         TJcw==
X-Forwarded-Encrypted: i=1; AJvYcCUIZ5cAiq3ZxvpufUggc9GYgC8DZv4pLDloZh5Zgb9i13KvuDScOd40SFaljAFEdqiIcrnOmBLymPDEClGAGZ81nbKHnJzlC1eBPeVcrPXbgTkI8D5dwq4OLKA1PpEy5qMqk11v77s1B2ctnTeDztecovDxuNF+/6/OFuKbOgcFoh/Oi7Rdx5wSC4dokMm7GPLDPeCn1jtpK4c5ksuw
X-Gm-Message-State: AOJu0YyvwSJT/ch1+mLz2dXOIqJfPAuKqMeCDkNTj0AwifR7Nq0m6IBY
	M9unY9HQFNtzqp+APPUiujYeGMZm1AsSwpUXtSvijfSXtAUHg8qNASRwYPk2/1Vm9DT9eapiEjI
	yV/I7n3U/EY9z7RG0w3TXqqDQB40=
X-Google-Smtp-Source: AGHT+IHFIDEAmC8NEGxjsG4riq9Ba4dDJ0CvrcQgOH7NX1APlBIJUTnNK6zqQcTbZLzYlCVkQWftRFgHgYnfYkaZn9w=
X-Received: by 2002:a05:6214:500f:b0:68f:8b5a:3e6b with SMTP id
 jo15-20020a056214500f00b0068f8b5a3e6bmr4541836qvb.6.1708471188325; Tue, 20
 Feb 2024 15:19:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsNnUfCCYVSb_-j-a-cAdONu1r6Fe8p2OtQ5op_wskOfpw@mail.gmail.com>
 <Zb6D/5R8nNrxveAP@cae.in-ulm.de> <Zb/30qOGYAH4j6Mn@cae.in-ulm.de>
 <CABXGCsPu73D+JS9dpvzX78RktK2VOv_xT8vvuVaQ=B6zs2dMNQ@mail.gmail.com>
 <e7b96819-edf7-1f9f-7b01-e2e805c99b33@linux.intel.com> <CABXGCsPjW_Gr4fGBzYSkr_4tsn0fvuT72G-YJYXcb1a4kX=CQw@mail.gmail.com>
 <2d87509a-1515-520c-4b9e-bba4cd4fa2c6@linux.intel.com> <CABXGCsPdXqRG6v97KDGy+o59xc3ayaq3rLj267veC7YcKVp8ww@mail.gmail.com>
 <1126ed0a-bfc1-a752-1b5e-f1339d7a8aa5@linux.intel.com> <CABXGCsN5_O3iKDOyYxtsGTGDA6fw4962CjzXLSnOK3rscELq+Q@mail.gmail.com>
 <a026ecd8-6fba-017d-d673-0d0759a37ed8@linux.intel.com> <CABXGCsOgy8H4GGcNU1jRE+SzRqwnPeNuy_3xBukjwB-bPxeZrQ@mail.gmail.com>
In-Reply-To: <CABXGCsOgy8H4GGcNU1jRE+SzRqwnPeNuy_3xBukjwB-bPxeZrQ@mail.gmail.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Wed, 21 Feb 2024 04:19:37 +0500
Message-ID: <CABXGCsOd=E428ixUOw+msRpnaubgx5-cVU7TDXwRUCdrM5Oicw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_This_is_the_fourth_time_I=E2=80=99ve_tried_to_find_wha?=
	=?UTF-8?Q?t_led_to_the_regression_of_outgoing_network_speed_and_each_t?=
	=?UTF-8?Q?ime_I_find_the_merge_commit_8c94ccc7cd691472461448f98e2372c7?=
	=?UTF-8?Q?5849406c?=
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: "Christian A. Ehrhardt" <lk@c--e.de>, niklas.neronin@linux.intel.com, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, Greg KH <gregkh@linuxfoundation.org>, 
	linux-usb@vger.kernel.org, linux-x86_64@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 2:41=E2=80=AFPM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> I installed irqbalance daemon and nothing changed.
> So who is responsible for irq balancing?

Sorry for the noise. Can anyone give me an answer?
Who is responsible for distributing interrupts in Linux?
I spotted network performance regression and it turned out, this was
due to the network card getting other interrupt. It is a side effect
of commit 57e153dfd0e7a080373fe5853c5609443d97fa5a.
Installing irqbalance daemon did not help. Maybe someone experienced
such a problem?

--=20
Best Regards,
Mike Gavrilov.

