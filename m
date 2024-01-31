Return-Path: <linux-kernel+bounces-47215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FBA844A9A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E51A1C2228B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A7739AFC;
	Wed, 31 Jan 2024 21:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YWKswDPH"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0355F39AC3
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 21:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706738251; cv=none; b=dvI45yp2MOq7ind2VBI5ku64i0oQaXf3QvPeo01XS+o9ImXB5/Uh+yECto1DNqy1D5JRpyYNX8PvxmN6NTY6SqfPhRTSWe4rzf8QIaycyzGFe33JFklJ4JrsIzXadZ6LH7W/DwLjA954bQdnq3+nvZnTZ+anGcynGZQNYw60y60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706738251; c=relaxed/simple;
	bh=gC0lXf7I3SZcZiIxOmuaTz2uCZpWqFRp2MIZZXqsmkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=I2zT+1HM1jhEllJkBYkpXsajri/KC6xT1D+DBX/uj+GrywsZG+rwpIxl5iJ3uADOSqLgOwbjxZzkqbedb2TgKw+psUYnhPDOotUxnfsyStQbdWge2Uqr4EEeJSu2CBTuFrjvpjPX39PxA1NC1WMRKy+rZGgSpCvi0JkA9bEhDPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YWKswDPH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706738247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O5fW+pR0Od9wClLuo3WHp1P1SzDvmkG9A4Voix2JXDE=;
	b=YWKswDPHHk9FPRSX7dJuXuJNaXeLfNKyqC+dFm8txpGZzNvnt4dXh/CcHpRGaaRRjqNJqz
	fGHGCPXJ+ZhnB/ZILjaj7pZQ6BfzSpjr7q6+i1UV4KtfvFDFn7JzomWvfIROwo5HxmsMSD
	Y+YnAIC+KpkO71gvq93PwVzOij8CY8E=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-ysbqdaHYMD6D5-ckay1BDg-1; Wed, 31 Jan 2024 16:57:25 -0500
X-MC-Unique: ysbqdaHYMD6D5-ckay1BDg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33afc5a3f40so76658f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 13:57:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706738244; x=1707343044;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5fW+pR0Od9wClLuo3WHp1P1SzDvmkG9A4Voix2JXDE=;
        b=l5Bs+SQp/XVyONzd7YI2FnGmPQxSYYyBUKc9Z/q2aAoai3LLpL165Q9Ypsmxjkhg/r
         qsVz/jcJTPOOJioY2karX7sYEvhrRdAFig5+eLChANIFPZ+wtSdYK0NrTSKJJ79fmP35
         TmtvlJ1fl0AM/CB+3JwINqLW7aUVwOzbL7hI4qqqlL/0K+AINNcivq4pvcbpil9vMRw1
         4Ys0sv09+ibGa7VCEmtn5d4ZijxWgVKpjUwfN9e1zo/GXrm+URbTHx95SD4WqK4Qrrmr
         sME2rkZIajHkT/pwJPibphaPPpJJ4lqbWuS7GIa/B7Aowua0RJ36t5nxfRJCtwNXAvId
         DGTw==
X-Gm-Message-State: AOJu0Yy7Mg5/TbSIxdNxM14oL7CjHoEWBwJoMjTQsZOj07/ufatdwee5
	RF/eOLDJnvb6AZtbzAEyeEdOp6HERThmeafu7FO/k+Tvdn5o8EOnbDZ0uvhErLkVxO9Twu61f3a
	shL44x0ElpIzeLSMj8sRTPfeKW07g5bsZ77FY6TefzTWc8uS/lBtbHBvqY/spc9UmHzKJ3RNLMs
	jMJeqFp67a8OsFPrPY+pb0cFO5WtCit3VMkSlnQLXl7v4U
X-Received: by 2002:adf:f98d:0:b0:33b:998:3643 with SMTP id f13-20020adff98d000000b0033b09983643mr248807wrr.34.1706738244227;
        Wed, 31 Jan 2024 13:57:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEvq6Klk32tuusUbUXszcqh0e5W5OiGe4KfWf4z08Djrb6F1s6ICn5hYUcrjCqeJicorPvnA82CO8a4mLBNIjY=
X-Received: by 2002:adf:f98d:0:b0:33b:998:3643 with SMTP id
 f13-20020adff98d000000b0033b09983643mr248789wrr.34.1706738243932; Wed, 31 Jan
 2024 13:57:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <170663397812.1314437.1686905275956809283@demetrius>
In-Reply-To: <170663397812.1314437.1686905275956809283@demetrius>
From: Clark Williams <williams@redhat.com>
Date: Wed, 31 Jan 2024 21:57:12 +0000
Message-ID: <CAMLffL_XZqBwoq8WivEyAU46TrTas+x4h5n4H=fFRq3ODWmEpw@mail.gmail.com>
Subject: Re: [ANNOUNCE] 6.1.75-rt23
To: LKML <linux-kernel@vger.kernel.org>, 
	linux-rt-users <linux-rt-users@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>, John Kacur <jkacur@redhat.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Daniel Wagner <daniel.wagner@suse.com>, 
	Tom Zanussi <tom.zanussi@linux.intel.com>, Clark Williams <williams@redhat.com>, 
	Pavel Machek <pavel@denx.de>, Joseph Salisbury <joseph.salisbury@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Wow, that'll teach me to do two releases back to back. I fat fingered
my release announcement for 6.6 and did the 6.1 instead.

Sorry for the noise, the v6.6.14 announce will be out shortly

Clark

On Tue, Jan 30, 2024 at 5:00=E2=80=AFPM Clark Williams <williams@redhat.com=
> wrote:
>
> Hello RT-list!
>
> I'm pleased to announce the 6.1.75-rt23 stable release.
>
> You can get this release via the git tree at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git
>
>   branch: v6.1-rt
>   Head SHA1: feaccee7987b202020fb8e13d33a793930a55045
>
> Or to build 6.1.75-rt23 directly, the following patches should be applied=
:
>
>   https://www.kernel.org/pub/linux/kernel/v6.x/linux-6.1.tar.xz
>
>   https://www.kernel.org/pub/linux/kernel/v6.x/patch-6.1.75.xz
>
>   https://www.kernel.org/pub/linux/kernel/projects/rt/6.1/patch-6.1.75-rt=
23.patch.xz
>
>
> Enjoy!
> Clark
>


