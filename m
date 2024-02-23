Return-Path: <linux-kernel+bounces-77594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A718C8607E0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 312AA1F24D36
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 00:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C52F98F56;
	Fri, 23 Feb 2024 00:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0Ftgx/2j"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D598BF3
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 00:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708649723; cv=none; b=pyrzGbAdvwLEJqkVPsEAPRs01wJW4gFdhIBQ65TKi8eRg3KWSi8aLnCwavlYdzA1MUj6anybY45BXf+0CYNLvRyjZbsFLxh9W+1PFwrfYIsNSCZ3k1ovZW5Wa8i9EUDVfcutR5ANYGIY9+ulxD0bCWZKnorl5HSudozAjPHGHb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708649723; c=relaxed/simple;
	bh=5kjCp8j/UQEpPhPqZWoKio2bsh6Z8YRqEl1lcKCoPdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZ3qAIHkle2LIux+ZfN2D5Av4LBmi2rr/Bj14VRfmsmwcyZ2+2yhvLRkLoQ2SmfLZnG+H/oBrLJACCiBpmT6JNsEVC96902lNzGVmuDBkZ95cTttBYemfeUedEC2uW6Dd2d0+I5sC7a7uJ69fFZ2Z3m10fYdRCf2HWnsOcetYt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0Ftgx/2j; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5654ef0c61fso3141a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 16:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708649720; x=1709254520; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5kjCp8j/UQEpPhPqZWoKio2bsh6Z8YRqEl1lcKCoPdM=;
        b=0Ftgx/2jAFs04UxEh55RSEQCbOQYfOXPpZTAhrY2DGFhqhETq42A+CE6HvWHBKJbTe
         dAT+uLVXYG9UrNJpKlQMahTp+5S7jRgTsFGXnQv6Lf7pPjsPPE/VOIp4bULka5ouu5wo
         Q2OOmRTOgEeVX5IbV6FTxBDqgylzo/O0pbC/K+WEKRFpUbQ1pfsOXwlogcOkVXKMfcF2
         09WytAvYD3dZJEIXtaIopop66K6mzQTzn327r2FwaTYBpxPgDoutg2Y7IaNmeBXaoeko
         l8x5+mI98EEfN/8R/3T/rFEuTrNAZJ4eshxkDUXNUnVt1xwDe2Nd5DMcEZTAt7uEFLro
         OkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708649720; x=1709254520;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5kjCp8j/UQEpPhPqZWoKio2bsh6Z8YRqEl1lcKCoPdM=;
        b=GxUeh1rPqa1/bibPY3FW/sNUpMwznJhh7u6tUCZd2fyU6Rh0q5wuVgOFLfpA5L7c9K
         Sg7luchX/Zuel/6X5ZQBxfNpmzn726As4gFYSFgirXBvQ8CAKgSjQG93Gnp56zUJIojR
         ht33UTC8YFCKVgY7VH/TQQiNcU7K62T3OEWJPncCch5pUE2wd6zGmy7nuyX2mDPRILLU
         JJUgJ286ZVly5QESLhALDYPp7FBiJO2VUG1+wAMk9mRUKDxrSW3XbEi7wbExafY9LTbP
         tNz3ucNjHtq4AUg0LSGVDcDsnJEpa0QQproEZmq2lvGRCSXo9bmVu1zKSiUrJO3wLD6f
         ln1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVpNzlUGbHKxV6AweuP1wLZrvzOH61HD0fu0hkL1IX5Dk0VeAaft4QJersgvn0Eo6AyeXMsi75f6pqM+v8SkVkrUWREyB20/Re7p4he
X-Gm-Message-State: AOJu0YwXn3X5nSaacE/3AMyMZBw6BN5iBImTopJuRl1OGkZ9BwAUvol7
	VbvNqs+DinrH6t/vnWxyVKYZwmrhrYokjpXGd883k2rU0Xf5BZIDnmMptuY3JMmTZvI2I9MfTi0
	K6ORgykDnCMVUYbeyYC6CLO4Ts5ztUd+JAzIK
X-Google-Smtp-Source: AGHT+IEKSApiDsDWT52bIXThzJBemkvAMEQc57fMaQvv1LlerrWc1/VvLi6QB1yxU0wGVvPjeIBszr5d077cJ68wngU=
X-Received: by 2002:a50:a408:0:b0:565:123a:ccec with SMTP id
 u8-20020a50a408000000b00565123accecmr419373edb.3.1708649719604; Thu, 22 Feb
 2024 16:55:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220161002.2983334-1-andriy.shevchenko@linux.intel.com>
 <CAGETcx8hzYzjKWPz4ACgS=XrVXqg46QHB4hTpP5bDTY9=WFK+Q@mail.gmail.com>
 <ZdXxNFB8bMMFPoki@smile.fi.intel.com> <ZdXxYjYsBQybbilQ@smile.fi.intel.com>
In-Reply-To: <ZdXxYjYsBQybbilQ@smile.fi.intel.com>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 22 Feb 2024 16:54:39 -0800
Message-ID: <CAGETcx9akN315asPP=e8xieHqs7gKXvHP-BwRxD=vCBuhh8_Jw@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] driver core: Move fw_devlink stuff to where it belongs
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 4:49=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Feb 21, 2024 at 02:48:52PM +0200, Andy Shevchenko wrote:
> > On Tue, Feb 20, 2024 at 06:08:56PM -0800, Saravana Kannan wrote:
> > > On Tue, Feb 20, 2024 at 8:10=E2=80=AFAM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > A few APIs that belong specifically to the fw_devlink APIs
> > > > - are exposed to others without need
> > > > - prevents device property code to be cleaned up in the future
> > > >
> > > > Resolve this mess by moving fw_devlink code to where it belongs
> > > > and hide from others.
>
> ...
>
> > > The rest of the functions here are related to parents and children of
> > > a fwnode. So, why is this function considered to be in the wrong
> > > place?
> >
> > When devlink was added it made a few fields in struct fwnode_handle.
> > These fields have no common grounds with device properties. In particul=
ar
> > struct device pointer is solely for devlinks and shouldn't be used with
> > them. Hence this patch. TL;DR: they semantically do _not_ belong to
> > the device property APIs.

But fwnode_is_ancestor_of() uses none of those new fields and seems
like a very reasonable API to provide. I understand if you want to
make the "device link only" argument for fwnode_get_next_parent_dev().

> On top of that for the 4+ years no new users appeared, so exporting them =
was
> a clear mistake. Hence Fixes tags.

We have plenty of APIs in .h files (not the same as export to modules)
-- that have only 1 user. And even some with no users. You don't move
a string function out of lib/string.c just because there's only one
user of that function. We put functions in C files that make sense.

I think Fixes is a bit of an overkill. It's not a bug. Fixes get
propagated to LTS. This is certainly not LTS worthy. I'm not going to
NACK or push back on this patch for these reasons, but just letting
you know that you come off as unreasonably grumpy when you do these
things even for fwnode_is_ancestor_of() :)

-Saravana

