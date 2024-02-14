Return-Path: <linux-kernel+bounces-64626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E17C2854101
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 02:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B54A9B2360C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20006443D;
	Wed, 14 Feb 2024 01:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kaidmu5M"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97F57E2
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 01:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707872993; cv=none; b=gpKTRXXL3OLhF197OdBmQZPlB7SPhBEXe6fhVdxHFXZzMAt3KlODBXODRw6i/jBY5yNRYmWwtWDmwp2cmIPxMA2fmQeLacM8uO1iPLtMKAajKFnFAKFPuJw3rN7T0656vGBmm0d9fkxefTSNCrkMcN8aTZ6bHq1LnBYQlOnYWps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707872993; c=relaxed/simple;
	bh=0++dCt5M+qrC+v7l1aP0aX+LFZP9kiitQYr/pwq70xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hfZKowCCvi7ahSqpeSI94vRl10IkywyVB1xLGaABvYE4gNdefiGhO8iomhFMqdbl7axKSIg/Mvi8qv8CYgJupneXiGaQjkzA6M9IzoowN6mhvg6mKBQS/cSiwckYR0JS9gxm521dDHeTkJg3xA6MSuRzlpu99bqG3t8G5VmspG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kaidmu5M; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5cdf76cde78so3880309a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707872991; x=1708477791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ySw3Cfl6z732P4TVdG3DLSaryHos4nnJoKBVe6EUUAI=;
        b=kaidmu5MxkGYyBRJ/5tAyXQ+sHStJ2RN+OTZ6XcENx9HokUcAGRQyG82vHZ+j9HWID
         FFC8UrK1ZCvvajGzWp4SieqwVnO/IJQZahVNY+PD1feiH8oTYsKmuQNSmA698J2z1jK7
         5liZc5jJtFPh3diYvWrTZINYnIEN4wzI1u1zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707872991; x=1708477791;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ySw3Cfl6z732P4TVdG3DLSaryHos4nnJoKBVe6EUUAI=;
        b=Drv4tTsGIjUjfAvdybJFI50yylbujw24b/cYQHhSWgdZ1Li1Luosfd9afGhJbAhEfQ
         Gz+Tv3N6ipA+CtJk1yZIzIz6Uyrgx8Rjb0GV2NfNjGiGGmh0STqs4OB0YprN5lN+nPM0
         MWKB+XfC/rzWBN0oRL85QfE3i1S3ueMH8uK0Op+jqofa1Ds043/sjFA6c8mgnBE/K/x4
         4Or0DKVWAXS0QKZ+8KtGVzQL+IBrkG1+6gnTQHf+bISOV1FrpGUpdVApt/EK7jy6gfZR
         wACB6ljXTE+KtroFtBUUxHb95u5ljyUVofkBwVqLkFsKd//SHxEwW3HF55Ut992XCIiA
         jZtg==
X-Forwarded-Encrypted: i=1; AJvYcCV/VrM5SEk23wU1k4RHxw8zxpDaEbrYdSiwdDBBvNSlVDkYdUpVoW4SXNgmjXdzCVOJbZ3Uu2qGJayXC8PpwqOtgvoBXa0PP7neooCz
X-Gm-Message-State: AOJu0YwP/tyILG85o5Px2LF8ALGOwjLOpIx9SqGHMX3ETVWvltPmYlXU
	v5bOP2mApSGT9gIJSuNq0CXOhfQmNgvKxHQ4Xntxv4jM7NR4F8ogxKsSHkmu4g==
X-Google-Smtp-Source: AGHT+IG7FNeQRxjlB3Lep4iTRHs1fKy5fZqrJmPqxB8tuFX5rYKAsrvyT0TnrPV5XvF/6hNpR2iUrQ==
X-Received: by 2002:a05:6a20:9597:b0:19e:a25e:a7f5 with SMTP id iu23-20020a056a20959700b0019ea25ea7f5mr1606402pzb.46.1707872991047;
        Tue, 13 Feb 2024 17:09:51 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id sw16-20020a17090b2c9000b00296a23e407csm157804pjb.7.2024.02.13.17.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 17:09:50 -0800 (PST)
Date: Tue, 13 Feb 2024 17:09:49 -0800
From: Kees Cook <keescook@chromium.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: Re: linux-next: build failure after merge of the bcachefs tree
Message-ID: <202402131705.5C6517B9@keescook>
References: <20240212105456.65194f29@canb.auug.org.au>
 <202402131606.A70D5347F3@keescook>
 <u6z6hyxhpjecbaw5zhevsd4hco253ec2pobijidj5bsd5ojbrw@mbu2r4o67nad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <u6z6hyxhpjecbaw5zhevsd4hco253ec2pobijidj5bsd5ojbrw@mbu2r4o67nad>

On Tue, Feb 13, 2024 at 07:29:32PM -0500, Kent Overstreet wrote:
> On Tue, Feb 13, 2024 at 04:16:34PM -0800, Kees Cook wrote:
> > On Mon, Feb 12, 2024 at 10:54:56AM +1100, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > After merging the bcachefs tree, today's linux-next build (x86_64
> > > allmodconfig) failed like this:
> > > 
> > > ERROR: modpost: missing MODULE_LICENSE() in lib/thread_with_file.o
> > > ERROR: modpost: "stdio_redirect_vprintf" [fs/bcachefs/bcachefs.ko] undefined!
> > > ERROR: modpost: "thread_with_file_exit" [fs/bcachefs/bcachefs.ko] undefined!
> > > ERROR: modpost: "run_thread_with_stdio" [fs/bcachefs/bcachefs.ko] undefined!
> > > ERROR: modpost: "__darray_resize_slowpath" [fs/bcachefs/bcachefs.ko] undefined!
> > > ERROR: modpost: "stdio_redirect_readline" [fs/bcachefs/bcachefs.ko] undefined!
> > > ERROR: modpost: "run_thread_with_file" [fs/bcachefs/bcachefs.ko] undefined!
> > > ERROR: modpost: "__darray_resize_slowpath" [lib/thread_with_file.ko] undefined!
> > > 
> > > Caused by commit
> > > 
> > >   f894f9e5f0ad ("thread_with_file: Lift from bcachefs")
> > > 
> > > I have used the version of bcachefs from next-20240206 again.
> > 
> > I've mentioned this before, but this patch (and I assume others) was not
> > posted to any mailing list before it appeared in -next. This process
> > failure really needs to be fixed. Please post _everything_ going into
> > your tree to at least linux-bcachefs mailing list, and for things that
> > toss stuff into lib/ it really needs to go to lkml too and CCed to some
> > subset of people who have touched lib/Kconfig, etc last.
> 
> thread_wih_file definitely was; the patch moving it to lib/ might not
> have, I'd have to check.
> 
> We're having ongoing discussions among us fs developers about how to do
> patch review, and the emerging consensus seems to be that we actually
> don't want to spam the list with every patch (because not every patch is
> interesting!) - we don't want the human-to-human interaction to be
> drowned out on the list.

Then at least CC lkml. Sending to a mailing list isn't optional -- this
is required for Linux development. It's the basis for patch review, how
b4 operates, how tooling finds threads to respond to, etc. It has to go
_somewhere_ before it lands in -next. And using get_maintainers.pl is
the right thing for this -- it'll find the people to CC based on the
MAINTAINERS file, which means more than just file paths, there are "K:"
entries too (e.g. I am CCed on anything using seccomp). This really
needs to happen or you're going to be landing code that didn't get
reviewed fully.

> That doesn't mean we're not doing code review, though! We're
> experimenting with different workflows, there's different thoughts out
> there right now.

If that's true, I would expect to see some "Reviewed-by:" tags, which I
don't see on the patch I mentioned.

The netdev folks have a significantly higher through-put on patches, and
they check all these boxes. Their CI even verifies that emailed patches
are corrected CCed to all expected get_maintainers.pl output, runs
checkpatch, etc. Please please fix this process.

> Regarding CCing people who have touched lib/Kconfig - you sure that's
> the best way to get interested parties who'll do real review? I would
> think review from the people actively working with and using that code
> would be more valuable - that's Darrick, in this instance.

Eh, get_maintainers is usually fine. But adding something new in lib/
means more than fs people are going to be using/changing it, so get
their review early.

-Kees

-- 
Kees Cook

