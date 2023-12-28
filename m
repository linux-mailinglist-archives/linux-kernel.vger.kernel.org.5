Return-Path: <linux-kernel+bounces-12676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8566681F8C6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 14:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 256EEB237BC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 13:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94C28475;
	Thu, 28 Dec 2023 13:19:06 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BA18464;
	Thu, 28 Dec 2023 13:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6dbd87b706aso1104928a34.0;
        Thu, 28 Dec 2023 05:19:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703769544; x=1704374344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQv2RIGJtc8YAdnoO1f20QZUdNA/cAou6jd52Lqn6S0=;
        b=NxIKpD+FY8twuQdK/JkArGJ2BVcSo54HH3F+gYRlor6IOlHG1DxSkaAvaHwwTb00eS
         vmxBfIv989bd6dmVbT4KQkrjwdKhg5TvRXVKd/XOw0xTqYmqFN1mB5jWtxbbdMaEGt/k
         MbEHKLd5Yn5OqdWZEIZvow0z/iCPRuHOM2pj0QeG4Q3Xscy7noM9l68v4V0dv+52OfmV
         BMYMl2A8vL6xkHVcVq/X+VDJ3cS1FSZJoVEwopxjhpXg94TKPAoLhzhpkvgsExGHUnG8
         8CFef2OlxvJwM3JFFVVZo+XuFwzwKvLaNgA0lPwvdc+qj5HLG+aAVguRtcCXVpK8HXto
         YfDA==
X-Gm-Message-State: AOJu0Yzt7hJcLC0miAqZSXPFyttdktoVo09XgVF14PI4Dk/EBh/qVzCb
	zXrDfFChFGtnUTiyEGopjaoFzx+NJQ5mdrkNQNo=
X-Google-Smtp-Source: AGHT+IH6v1Lorb0OKgIClSO5t5j5iEDzKApi54kYgEDifp/BGJIs4gcjnjlQSe8cPOyv/D6GpWc1QD0fkow5Tr93JnE=
X-Received: by 2002:a05:6820:2e01:b0:594:35b4:8a with SMTP id
 ec1-20020a0568202e0100b0059435b4008amr13751279oob.0.1703769544039; Thu, 28
 Dec 2023 05:19:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2330034.ElGaqSPkdT@kreacher>
In-Reply-To: <2330034.ElGaqSPkdT@kreacher>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 28 Dec 2023 14:18:52 +0100
Message-ID: <CAJZ5v0i=SOyxRF4vV-WZJ-dRD8PZiyFLC7h+trtuhQ_eKLF0jw@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] ACPI: OSL/EC: Use spin locks without disabling interrupts
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Zhang Rui <rui.zhang@intel.com>, 
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
	Michal Wilczynski <michal.wilczynski@intel.com>, Hans de Goede <hdegoede@redhat.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Daniel Drake <drake@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 12:34=E2=80=AFPM Rafael J. Wysocki <rjw@rjwysocki.n=
et> wrote:
>
> Hi Everyone,
>
> After
>
> https://patchwork.kernel.org/project/linux-acpi/patch/5745568.DvuYhMxLoT@=
kreacher/
>
> the SCI interrupt handler is threaded, so ACPICA spin locks can be used w=
ithout
> disabling interrupts, because they cannot be acquired from a hardirq hand=
ler
> running on the same CPU as any code already holding the spin lock.  This =
patch
> [1/3] removes disabling interrupts from acpi_os_acquire_lock() and update=
s
> acpi_os_release_lock() accordingly.
>
> Patch [2/2] uses the observation that if acpi_handle_interrupt() can run
> in a threaded interrupt handler in the GPE case, it can also run in a thr=
eaded
> interrupt handler in the dedicated IRQ case, so it makes the EC driver us=
e a
> threaded handler for the dedicated EC interrupt.
>
> Patch [3/3], in analogy with patch [1/3], uses the observation that after=
 patch
> [2/2] all of the EC code runs in thread context, so it need not disable
> interrupts on the local CPU before acquiring a spin lock, so the EC drive=
r is
> updated to operate its spin lock without disabling interrupts.

I don't see any objections to these patches, so queuing them up for 6.8.

Thanks!

