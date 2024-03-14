Return-Path: <linux-kernel+bounces-103533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C2487C0B9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EB871C21161
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FEE73175;
	Thu, 14 Mar 2024 15:55:45 +0000 (UTC)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B11E73165;
	Thu, 14 Mar 2024 15:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710431745; cv=none; b=Oiy78MdewDpsosvcpeBL1R1LvLTT5YqemT3OS5qPeuvHEhHCBH940TqiEwZR/5OSitYELi3pElSXmv/NmTbILpcjmprdYzDIj2ACnQCQ6liJrE+BxASyUWhvpAF7YQtD/cgfiTu2NnnThhwYKkXOFSI5uqhYxVqING+YoFo4qWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710431745; c=relaxed/simple;
	bh=yfhwJl3cDefDSYW2nZ14IXtUIYws5SiAxYO+fsXpqG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XhKIZVX2b4CMfjAQ4JRmkyzQkkqiD8iMJBjUoGKBmJrEhccqDByx7pt0Ds6zX15M3JJik+RCs4WEWl9bY3ktT8bMNMsXP35rumS87myuhJ/CTyaVS/VqCHCIwAwYPqhD2vhMaWNp/3HdUCa/CUM43EZjeNeMIdt5m/n7BsN1ug8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6e4de525a42so78735a34.1;
        Thu, 14 Mar 2024 08:55:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710431742; x=1711036542;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q8pCavAfgm3Ta3aBIUaxKjw7Rla9cIYxV3vEhFuCFfM=;
        b=ebhSnndnXhgWZg4VnVe19ecUOIsUjKPGs5MlAUJpC+/PW0k42qc5tAs9p8Jpwi+v/H
         cS+YCJlQo3oDC2a9PJ3zYL1FJMwmXcFcHS2XAGZ4AyuiexW5OeoXb5gsg61b+7zFemw1
         RT5yacLZXJo4mIzrXNWXN5l2bwCynn4JQMJyC7mxAr8ghknnLXf6PTAyhA200w+o2Ui2
         awpMflbY4Pmoq87+Cx0tgKlohN74N8YdV6Fv7LBkOgGagmy/LAXfRrui88si914ORZvy
         UwP8jPNeBo7JxP7Oej3I75EwGIDXU+ODtLku6BUm5OhT04TV9nZz/f5COiqKIezLFInI
         WIdQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2SNyNpQVcQJfU0MzOcwCttjblVJaUr5jGcTytE6qAWD1QmCyZi9lnGk7f3/4BvF+y/UYKF9mrtqMkWk7REVqdUYenD7kW+pkn5YMSgW31EZ9aKNKsYCDLWqCmnJ88IdEzQkQhqC+He9y3JMlzv9eglajPnr+hyruIYJ2cQOQ=
X-Gm-Message-State: AOJu0YzwT14H92Ej/1s7PiRLCiUccarhuWbJiBCggcgxVUxOWV5C+Jfr
	lZqM6fhWawtpoC4lgXbqDGra3+2qpZKhTvet2uaO21VK7CNZCgV6tenb/jKiyM7sxqeuw7+YMe3
	apYGYFvfVJIjQe68tKJ6tkLcgGlA=
X-Google-Smtp-Source: AGHT+IFqAGSZD95Nz66+dq6mo6VAvNwA6Yee6WwNGYx8Jr8X0i5a17RbXedTOdIq75kyMrVk04sogKb/MiRptHhTPh0=
X-Received: by 2002:a05:6870:82a4:b0:222:239e:bd04 with SMTP id
 q36-20020a05687082a400b00222239ebd04mr2205348oae.1.1710431742538; Thu, 14 Mar
 2024 08:55:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314142656.17699-1-anton@tuxera.com> <70261e2a-b87e-462e-964e-95a51ecde978@intel.com>
In-Reply-To: <70261e2a-b87e-462e-964e-95a51ecde978@intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 14 Mar 2024 16:55:31 +0100
Message-ID: <CAJZ5v0hdA2PUc8cmJtCNxW-nzHdWV+pxnTEeVu_7YHsHZTmFLw@mail.gmail.com>
Subject: Re: [PATCH] x86/pm: Fix false positive kmemleak report in msr_build_context().
To: Dave Hansen <dave.hansen@intel.com>
Cc: Anton Altaparmakov <anton@tuxera.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H . Peter Anvin" <hpa@zytor.com>, Chen Yu <yu.c.chen@intel.com>, 
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org, 
	Matthieu Baerts <matthieu.baerts@tessares.net>, 
	Mat Martineau <mathew.j.martineau@linux.intel.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Ingo Molnar <mingo@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 4:05=E2=80=AFPM Dave Hansen <dave.hansen@intel.com>=
 wrote:
>
> On 3/14/24 07:26, Anton Altaparmakov wrote:
> >  /* image of the saved processor state */
> >  struct saved_context {
> > -     /*
> > -      * On x86_32, all segment registers except gs are saved at kernel
> > -      * entry in pt_regs.
> > -      */
> > -     u16 gs;
> >       unsigned long cr0, cr2, cr3, cr4;
> >       u64 misc_enable;
> >       struct saved_msrs saved_msrs;
> > @@ -27,6 +22,11 @@ struct saved_context {
> >       unsigned long tr;
> >       unsigned long safety;
> >       unsigned long return_address;
> > +     /*
> > +      * On x86_32, all segment registers except gs are saved at kernel
> > +      * entry in pt_regs.
> > +      */
> > +     u16 gs;
> >       bool misc_enable_saved;
> >  } __attribute__((packed));
>
> Isn't this just kinda poking at the symptoms?  This seems to be
> basically the exact same bug as b0b592cf08, just with a different source
> of unaligned structure members.
>
> There's nothing to keep folks from reintroducing these kinds of issues
> and evidently no way to detect when they happen without lengthy reproduce=
rs.

This change is fine with me FWIW, but I agree that making it for
kmemleak reasons feels kind of misguided.

