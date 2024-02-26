Return-Path: <linux-kernel+bounces-81029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C4E866F38
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEC2E288007
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24BC812BEB4;
	Mon, 26 Feb 2024 09:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R12ayGvb"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15E8129A74
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 09:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708938934; cv=none; b=JfSXG7h3Mu8idv59cJ0GsxQWby0zkv7qiReGajjgTyby1yWC/yJbL8UhVM3oqmFYy9UDPLHmgGvDg3ttDmQcP2AEq8QnMxLIwrHB63LlDawtBzkrJSd5RbT6Hglx1a01AzOhcnos+7d3Z6BJkMhLJC7uq4pgtL6crEjob7dBvfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708938934; c=relaxed/simple;
	bh=QF9YeSn2bc4tYDCafTxeVXBSQs58EaDIiH/nuRQ20NI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Np2vIPdnuGEl2E9/otz6Ad3hzYsib8L3kJ0SLpbz1pWA3YnjEBuLwgv0JCcHC4usYWU+wJGlb5MXKkrOe5XrKl+k/2r0ooD/Qy8pcrsDnd30IE31Gg/eufpQuAUYDwE+soW3nBTBBYDhh1lzz74bLoAYHdwmoJ+8c3+bNk1t+N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R12ayGvb; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-564e4477b7cso11382a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 01:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708938931; x=1709543731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3PpUbqhc+g7vhrTDiU7KzbrIeL60wiFB52dzsG8i29k=;
        b=R12ayGvbH08lYqy3CtK2M4FJOtfyDrXmDiUE4Vr12v4+XBR8Q7NAQqpSGLfwCzLvzu
         6wZ/0CrFVpw6I59RqzAIimZkZIEWyvwloh7cJ9uzKzzJIXrJbCkGuHQAhW/N4PndBKh+
         wh1EuusR1wpcWq6LqTf92jVqu1ZjqCP3iEos4QN3Ho2PvtAGPHcQsnzOfNmyNiTkvVRG
         LP0h4OIG8X/ox1qJl9+vy/TT4/PEXsj45rH4UYOTDmH/qaRrZU7anMSeIRHvsFrwHv/N
         oxAoCC09Ejkl2GnTAqRFtzHpt4Y++Q8IF9GYWlGJSKETX197PQedgwCAdPBmiTLc9wr7
         7FzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708938931; x=1709543731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3PpUbqhc+g7vhrTDiU7KzbrIeL60wiFB52dzsG8i29k=;
        b=KkHx7MiT0/0ZIX9ErvO2fAPDXCGnBcsc5ta5Dzt9DBUcgzjKaumXeZEq77JLdMB6U8
         b2KClkCfhT7qkMMYDC8N3O5UyR8/V+TW7mw8M0QmYjEV26Z6YbcoWByI2XUsaWyOaBNF
         rG2ZHc7mjrrG3KaeDn9OQ4s4gSxo4Ca0exZ9F4AbSc21pJQ4dZR9b7ixOgVHICYbz9Zu
         m8NnLOZQV32d2VAL9xor3JDyrnMnIRkRGwY9yUqG64DUJgAWx9yAKJQWdl+zWtdDYAYT
         +uSPABpNr41W6m65wAmmcm7iKN/IxLK+TrD7OP39lSP8oKlkN9t4iGJdg+bXNGGkYTtW
         ZtIw==
X-Forwarded-Encrypted: i=1; AJvYcCUKCuPTWPw50zzjRQXNB3AJW0030vDXYg7m6qPvzVTwYl7X24//LDwZrDxUF5d7qqswYUfTz7A1d9upKreBTyU4grsHO8FmgTkhb4fB
X-Gm-Message-State: AOJu0YyXNg08dKPE4ZtgJEfCa54uPeQmEglnyAPmkcCH80pcb751ty6m
	yyHCsEAx2UXqgtUTmKETHPPsQSRoMQEdQc1mpWLfeqefY30ksrpsR0pp9JLxwnz3lrcBZ7y5aMN
	dUZMeYmnuMx1Z6arLJSBXa7TdurZrxdQr1inn
X-Google-Smtp-Source: AGHT+IFYC4cdUdD58nWD8MZNjN7IfTcOlMWs2ezscub4EPb/vnrtmbhgho8MUB/aoZHnXQk3kNcCtBi9wQrZP9SgN40=
X-Received: by 2002:a50:c30a:0:b0:566:306:22b7 with SMTP id
 a10-20020a50c30a000000b00566030622b7mr49949edb.1.1708938930851; Mon, 26 Feb
 2024 01:15:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223143833.1509961-1-guanyulin@google.com> <Zdi3UWWRfKw1N_Jn@smile.fi.intel.com>
In-Reply-To: <Zdi3UWWRfKw1N_Jn@smile.fi.intel.com>
From: Guan-Yu Lin <guanyulin@google.com>
Date: Mon, 26 Feb 2024 17:15:00 +0800
Message-ID: <CAOuDEK1KbZ9=W3ffWN-h_AAhbB9RqJvKsnF4G9qus3o2wkk=3w@mail.gmail.com>
Subject: Re: [PATCH v3] PM / core: conditionally skip system pm in
 device/driver model
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: rafael@kernel.org, pavel@ucw.cz, len.brown@intel.com, 
	gregkh@linuxfoundation.org, petr.tesarik.ext@huawei.com, 
	rdunlap@infradead.org, james@equiv.tech, broonie@kernel.org, 
	james.clark@arm.com, masahiroy@kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 11:18=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Feb 23, 2024 at 02:38:29PM +0000, Guan-Yu Lin wrote:
> > In systems with a main processor and a co-processor, asynchronous
> > controller management can lead to conflicts.  One example is the main
> > processor attempting to suspend a device while the co-processor is
> > actively using it. To address this, we introduce a new sysfs entry
> > called "conditional_skip". This entry allows the system to selectively
> > skip certain device power management state transitions. To use this
> > feature, set the value in "conditional_skip" to indicate the type of
> > state transition you want to avoid.  Please review /Documentation/ABI/
> > testing/sysfs-devices-power for more detailed information.
>
> ...
>
> > +static ssize_t conditional_skip_store(struct device *dev,
> > +                                   struct device_attribute *attr,
> > +                                   const char *buf, size_t n)
> > +{
>
> > +     int ret;
>
> > +     if (kstrtoint(buf, 0, &ret))
>
> Why is it int? It seems like flags, should not be unsigned as u32 or so?
>

The ".event" member in struct pm_message is an int, but the values
assigned to it are used like bit flags (e.g. PM_EVENT_FREEZE=3D0x1,
PM_EVENT_SUSPEND=3D0x2, PM_EVENT_HIBERNATE=3D0x4). Is this an intentional
design choice? We might need to change the design accordingly.

> > +             return -EINVAL;
>
> Do not shadow the real error code without justification.
>

Thanks for suggesting the desired implementation. I'll refactor it in
the next version.

> > +     ret &=3D (PM_EVENT_FREEZE|PM_EVENT_SUSPEND|PM_EVENT_HIBERNATE);
> > +
> > +     dev->power.conditional_skip_pm =3D ret;
> > +
> > +     return n;
> > +}
>
> > +
>
> Redundant blank line.
>

Thanks for the heads-up.

> > +static DEVICE_ATTR_RW(conditional_skip);
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

