Return-Path: <linux-kernel+bounces-27720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DC382F4BF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EACD1F24EAA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0501CF9B;
	Tue, 16 Jan 2024 18:58:26 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16051CF98
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 18:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705431505; cv=none; b=X5TFq0IO893hJTpl1yCzSW5NWxf4T5CHQJx1/ne1aztRqEwitj4M2USa85dUS6vWKj7wAWLOSBhOIIfpRZn4WPE0Tv1Ne4a9L3eNu4F1caQIfSOGMNCw1+1u3dd4pdw3OIAFNdpJxHI5DZA46UKZokyz7u8k/Gs86+tZ9F1HyLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705431505; c=relaxed/simple;
	bh=GP9zCdJgB+0cVy92N/SgrGbcC/S8rUkIXk9cPs6+VFI=;
	h=Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=kxkBIfT57O/aiip7EsxF5MNr0pLbOQdwhjJE6fSrvQ1pLwSDJYqQUVJfnTQ95jiPjYO/NoBwkp5GvU2fxtP3eynMOQXYa4H86kmciYqVzd7iTmvcmuFhXoqLBB0fbSTDPKKvzN3w8SYEOTbKqzq3XkbmZPiwvSmq0FBtBO/S20I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
Received: (from willy@localhost)
	by mail.home.local (8.17.1/8.17.1/Submit) id 40GIw9Xu020056;
	Tue, 16 Jan 2024 19:58:09 +0100
Date: Tue, 16 Jan 2024 19:58:09 +0100
From: Willy Tarreau <w@1wt.eu>
To: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc: Charles Mirabile <cmirabil@redhat.com>, linux-kernel@vger.kernel.org,
        Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH] nolibc/stdlib: Improve `getauxval(3)` implementation
Message-ID: <ZabRwdcgU/H8i5Ja@1wt.eu>
References: <20240116181147.2230944-1-cmirabil@redhat.com>
 <ZabQVvpZ4e7hTwcb@biznet-home.integral.gnuweeb.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZabQVvpZ4e7hTwcb@biznet-home.integral.gnuweeb.org>

On Wed, Jan 17, 2024 at 01:52:06AM +0700, Ammar Faizi wrote:
> On Tue, Jan 16, 2024 at 01:11:47PM -0500, Charles Mirabile wrote:
> > At least on x86-64, the ABI only specifies that one more long will be
> > present with value 0 (type AT_NULL) after the pairs of auxv entries.
> > Whether or not it has a corresponding value is unspecified. This value is
> > present on linux, but there is no reason to check it as simply seeing an
> > auxv entry whose type value is AT_NULL should be enough.
> 
> Yeah, I agree with that. I just read the ABI and confirmed that the
> 'a_un' member is ignored when the type is `AT_NULL`. Let's stop relying
> on an unspecified value.
> 
> For others who want to check, see page 37 and 38:
> https://gitlab.com/x86-psABIs/x86-64-ABI/-/wikis/uploads/221b09355dd540efcbe61b783b6c0ece/x86-64-psABI-2023-09-26.pdf
> 
> > This is a matter of taste, but I think processing the data in a structured
> > way by coercing it into an array of type value pairs, using multiple
> > return style, and a for loop with a clear exit condition is more readable
> > than the existing infinite loop with multiple exit points and a return
> > value variable.
> 
> Ok. It's more readable using your way. One thing that bothers me a bit
> is type of 'a_type'. On page 37, the ABI defines the auxv type-val pair
> as:
> 
>   typedef struct
>   {
>     int a_type;
>     union {
>       long a_val;
>       void *a_ptr;
>       void (*a_fnc)();
>     } a_un;
>   } auxv_t;
> 
> Assuming the arch is x86-64 Linux. Note that 'a_type' is an 'int' which
> is 4 bytes in size, but we use 'unsigned long' instead of 'int' to
> represent it. However, since 'a_un' needs to be 8 bytes aligned, the
> compiler will put a 4 bytes padding between 'a_type' and 'a_un', so it
> ends up just fine (on x86-64).
> 
> What do you think about other architectures? Will it potentially be
> misinterpreted?

Indeed, it would fail on a 64-bit big endian architecture. Let's
just declare the local variable the same way as it is in the spec,
it will be much cleaner and more reliable.

Thanks,
Willy

