Return-Path: <linux-kernel+bounces-27724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9001E82F4C6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EFEA28548F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194CE1D52C;
	Tue, 16 Jan 2024 18:59:47 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D55B1D525
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 18:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705431586; cv=none; b=RRtq+thJylfROXO97yu4+9ioG8vPOc902ezD/TSVgsI4m0maIPVefdMySq76G1FBLIVtmYvqHswnl8Yxwa8NGDcjaA48X85XlWwifT7/MoMy+YQOos0UGkC8VfeY2jPXnDrtf8rQF0j3FO9nJbUHizuqVXJ2P4sLa65jqg5gdqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705431586; c=relaxed/simple;
	bh=jP3sejhrb6IEc/7ajYGJZqFr9VzJ4VBtRR3bsDSSObE=;
	h=Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=N12HOmagKrxsFGlGUZ72xm+SE/p9H6KuMH3mev0bLSVP9+W2eMVd5APPWIMDW7SYOG3bxeooU2RKn9HV9jua+uCoKxSBa+AU4Fk5GVLI6Ra0T1AnID0kWPZZJSqxSZEZvph54dv1aKhv7yw2OV6lE5yCfb5z/oRDUKF+fFFQpIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
Received: (from willy@localhost)
	by mail.home.local (8.17.1/8.17.1/Submit) id 40GIxdwM021066;
	Tue, 16 Jan 2024 19:59:39 +0100
Date: Tue, 16 Jan 2024 19:59:39 +0100
From: Willy Tarreau <w@1wt.eu>
To: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc: Charles Mirabile <cmirabil@redhat.com>, linux-kernel@vger.kernel.org,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH] nolibc/stdlib: Improve `getauxval(3)` implementation
Message-ID: <ZabSG4R45sC0s23d@1wt.eu>
References: <20240116181147.2230944-1-cmirabil@redhat.com>
 <ZabQVvpZ4e7hTwcb@biznet-home.integral.gnuweeb.org>
 <ZabRwdcgU/H8i5Ja@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZabRwdcgU/H8i5Ja@1wt.eu>

On Tue, Jan 16, 2024 at 07:58:09PM +0100, Willy Tarreau wrote:
> On Wed, Jan 17, 2024 at 01:52:06AM +0700, Ammar Faizi wrote:
> > On Tue, Jan 16, 2024 at 01:11:47PM -0500, Charles Mirabile wrote:
> > > At least on x86-64, the ABI only specifies that one more long will be
> > > present with value 0 (type AT_NULL) after the pairs of auxv entries.
> > > Whether or not it has a corresponding value is unspecified. This value is
> > > present on linux, but there is no reason to check it as simply seeing an
> > > auxv entry whose type value is AT_NULL should be enough.
> > 
> > Yeah, I agree with that. I just read the ABI and confirmed that the
> > 'a_un' member is ignored when the type is `AT_NULL`. Let's stop relying
> > on an unspecified value.
> > 
> > For others who want to check, see page 37 and 38:
> > https://gitlab.com/x86-psABIs/x86-64-ABI/-/wikis/uploads/221b09355dd540efcbe61b783b6c0ece/x86-64-psABI-2023-09-26.pdf
> > 
> > > This is a matter of taste, but I think processing the data in a structured
> > > way by coercing it into an array of type value pairs, using multiple
> > > return style, and a for loop with a clear exit condition is more readable
> > > than the existing infinite loop with multiple exit points and a return
> > > value variable.
> > 
> > Ok. It's more readable using your way. One thing that bothers me a bit
> > is type of 'a_type'. On page 37, the ABI defines the auxv type-val pair
> > as:
> > 
> >   typedef struct
> >   {
> >     int a_type;
> >     union {
> >       long a_val;
> >       void *a_ptr;
> >       void (*a_fnc)();
> >     } a_un;
> >   } auxv_t;
> > 
> > Assuming the arch is x86-64 Linux. Note that 'a_type' is an 'int' which
> > is 4 bytes in size, but we use 'unsigned long' instead of 'int' to
> > represent it. However, since 'a_un' needs to be 8 bytes aligned, the
> > compiler will put a 4 bytes padding between 'a_type' and 'a_un', so it
> > ends up just fine (on x86-64).
> > 
> > What do you think about other architectures? Will it potentially be
> > misinterpreted?
> 
> Indeed, it would fail on a 64-bit big endian architecture. Let's
> just declare the local variable the same way as it is in the spec,
> it will be much cleaner and more reliable.

With that said, if previous code used to work on such architectures,
maybe the definition above is only for x86_64 and differs on other
archs. Maybe it's really defined as two longs ?

Willy

