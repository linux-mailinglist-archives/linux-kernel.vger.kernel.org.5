Return-Path: <linux-kernel+bounces-28933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 922398304D1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:58:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6B851C244ED
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402BC1DFD9;
	Wed, 17 Jan 2024 11:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XgK3j6CM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AC3C8DE
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 11:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705492677; cv=none; b=cLw8ChSYsIjj6YGs9wZe4kB6jQz0KVCZpe4VYtR1P9EKFjNdBZ2kqcmNjCjGXaX+VEGOGyUk44Rd2mS7n3IHVR6kjcEJRfwAlqKbLu2QqRyfgO6J1KCEx4CGa2NahnwsKXIgTK+5r3vgv1o3BWAq31q+f7IWe2D0+e+Bmm0UN4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705492677; c=relaxed/simple;
	bh=Wsoe+ZP17Ji6SIMMmNbK8iP9QaFv6vlqq9FHgkDDjQI=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 X-Google-Smtp-Source:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding; b=ReCMsbmtgaUoZq1dlVXfebK7RoqN+QZda8H+RwhYQVI6J+LyaoXgn4y0vu/miwdgi5PsbVRKHD1U+d7En3okSRNw09UCKBhaw8O6deKLkn9L9iCgLUUHtrfPQQ1ke7HbDEWfn6JHJc8hVGv4io0dta7bI1S5QCMOfNegcKpoLTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XgK3j6CM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705492674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rB12CkX8/Du4z+dsIJN6wEA4B/FKFwSZAxKwOo9HT/4=;
	b=XgK3j6CMUjqDK7sjJIou320im+Gr+4xN6zUTIj4LHXSRq2JrFTnfZvIMY1357N6e9TrnYg
	n3KByNa6qvT/49v18CDwUT/M9KQy+IvjWw0jmzOY5IYLh/1XxnXH+MgHHo3oFk9iHoHSFA
	spdjuL3semSCMMrPkwRGASq3qcHOWRc=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-yenW8rHpNeuIXZV7TRV7Ag-1; Wed, 17 Jan 2024 06:57:53 -0500
X-MC-Unique: yenW8rHpNeuIXZV7TRV7Ag-1
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-7d22d1e96f2so549636241.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 03:57:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705492672; x=1706097472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rB12CkX8/Du4z+dsIJN6wEA4B/FKFwSZAxKwOo9HT/4=;
        b=rGOzkpmZXWf9GZ5xHsMxOhLuwTms7D62mhfJoJTM/ERb8tt/SG7t7BCTVthcbgNX71
         4ruwGqF7ucBFWWliVb153echbkVFZX42kqs5PVV87MTZipM56zpcPbXLfVFUKbVAlh2/
         1ENUJ3KNB7bBAv0lqmXTMOHAeKN4YDrq45l8mKJDhYxnbEr9y/9MYJ9gJ/wfQX7ygstd
         SDtMuaPM3vSCv27e3wxanvyR021pDD9jDJGXYiSZ45EuM6Qt6PpMVRbB+6RfiKKULpjt
         rzSHqoLiExAdu7JiXojqM211aWSiSoawxXEkg0RL+/QYUzZxp8cR3nZkA0vPd1RAiW+F
         Gvsw==
X-Gm-Message-State: AOJu0YwsKwv78nkWQM7Zxy+6VaSrX9Fg2Gh+Jx/bUYNtduzpBDdCw9Tf
	qGi6dPO7/bLE12bIQRHFpGv7BUGlSt3OfRVbfWUCWNnc2LmJTZykYFhV7/3xx4h8X5a0axTVofA
	3hcy8Fswl+XbLiLOuXZyHS5nD+CQpyUX9L4qW5SRvqbVp5M1wlQpmOlnBnO0=
X-Received: by 2002:a05:6102:5492:b0:469:83e8:f54c with SMTP id bk18-20020a056102549200b0046983e8f54cmr380544vsb.28.1705492672561;
        Wed, 17 Jan 2024 03:57:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEb8DA0Bn8Czc1a7YUodaiOBolGjMmQIqFMDAZYGn6bUdaARIm8CQtIYrE/KQYgx5mpfkMGtL24LBlOaGewE0I=
X-Received: by 2002:a05:6102:5492:b0:469:83e8:f54c with SMTP id
 bk18-20020a056102549200b0046983e8f54cmr380540vsb.28.1705492672264; Wed, 17
 Jan 2024 03:57:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115102202.1321115-1-pbonzini@redhat.com> <2024011502-shoptalk-gurgling-61f5@gregkh>
 <CABgObfZ0gpw2-n2d5vyEjuCefOp+3TPyUuMvjScAbae2GKfO0A@mail.gmail.com>
 <2024011543-dropout-alienable-a9e9@gregkh> <2024011756-dosage-deviator-6e03@gregkh>
In-Reply-To: <2024011756-dosage-deviator-6e03@gregkh>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 17 Jan 2024 12:57:40 +0100
Message-ID: <CABgObfaiz94fCb2ULDhSE-dKBGnT+qE+pnf=O9+6OavpPTRScQ@mail.gmail.com>
Subject: Re: [PATCH stable] x86/microcode: do not cache microcode if it will
 not be used
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, x86@kernel.org, 
	Borislav Petkov <bp@suse.de>, Dave Hansen <dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 12:00=E2=80=AFPM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Mon, Jan 15, 2024 at 09:59:23PM +0100, Greg KH wrote:
> > On Mon, Jan 15, 2024 at 07:54:59PM +0100, Paolo Bonzini wrote:
> > > On Mon, Jan 15, 2024 at 7:35=E2=80=AFPM Greg KH <gregkh@linuxfoundati=
on.org> wrote:
> > > >
> > > > On Mon, Jan 15, 2024 at 11:22:02AM +0100, Paolo Bonzini wrote:
> > > > > [ Upstream commit a7939f01672034a58ad3fdbce69bb6c665ce0024 ]
> > > >
> > > > This really isn't this commit id, sorry.
> > >
> > > True, that's the point of the mainline kernel where the logic most
> > > closely resembles the patch. stable-kernel-rules.rst does not quite
> > > say what to do in this case.
> >
> > Ok, then just say, "this is not upstream" and the rest of your changelo=
g
> > is good.  I'll edit it up tomorrow and apply it, thanks.
>
> Ok, now queued up for 6.6.y, but what about older kernel versions?

6.6 is where I tested that it works, and I didn't want to put an old
kernel version in the "Cc" line, without even testing that a
non-upstream patch applies there.

The benefit would be absolutely marginal. People playing with Intel
TDX are not going to use old kernels (6.1 counts as old) anyway, for
example support for lazy acceptance of memory went into 6.5.

Paolo


