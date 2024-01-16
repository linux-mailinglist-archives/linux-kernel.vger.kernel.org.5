Return-Path: <linux-kernel+bounces-27716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B515682F4B1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBC4C1C23609
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4A81D52C;
	Tue, 16 Jan 2024 18:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b="A2JerUBr"
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A0E1D526
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 18:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnuweeb.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.81.211.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705431140; cv=none; b=IXlrq+AdcychhJLTSDTkCM0+6jam6+RE2NePpQO7nCNvUW3+6tpUxzHyOFLjNwHvRufMln+tSLIrbt1Yui/2AjnXIwzfUP/RdgQD+OprBObi3khYG/pxRMC23raTkWBm4HAJcJ2sidYH5EmetPjcbb5YYCzWwXUL764t+8KxXgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705431140; c=relaxed/simple;
	bh=Dr51axhWhT3nOG6228AY6k9XqDQO8bY2Qt8EbICnJhE=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Bpl; b=dRvWQ/1F6yvI6IEK6KMfT855BQq5e0YaJqMNAVAadlwknBy+0CRy1kauVU1VKv42EJ0apLJm2xgUhVTvOgFuktRAyykQ69PogjSsGQPWxkXqV0KXYaCQCTpw2ee/A2RqMIEugPAq6pMOT6Scb0PpauHQbf9fHC+2c75XDbBdq6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b=A2JerUBr; arc=none smtp.client-ip=51.81.211.47
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
	s=default; t=1705431133;
	bh=Dr51axhWhT3nOG6228AY6k9XqDQO8bY2Qt8EbICnJhE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A2JerUBrJFxMgov4tcg5OvoR9vZWkfjhSCjgOhxe7qut7uR8mZe54GT0ZIn1eawqw
	 nUiXs4aEu/hIY1QzbbFGRaPQKQ8ntIDKNfwJdTkLNmBoc5UBB6NihZhKyGlGhqpQK7
	 gueJ5cycE2tiFTH1dvYAwGDQV3fnY4dwxwHZug4kgKq/+P9G7fZ+GognuoJZlnan88
	 sNaI+mH/yWjJzGrBLgWdmI3sONJwsU9PhyJTUDiwX9SLpeL18BtUbbNT65imlfckzu
	 t4kj5VKNWuZJHBtJh5979ks8+1dafC5XuR1lmOVxyhVTbomV7N0Ai1mbFxytqymAya
	 JemxhIaO7QM2w==
Received: from biznet-home.integral.gnuweeb.org (unknown [182.253.126.189])
	by gnuweeb.org (Postfix) with ESMTPSA id 0C9D124C3A2;
	Wed, 17 Jan 2024 01:52:10 +0700 (WIB)
Date: Wed, 17 Jan 2024 01:52:06 +0700
From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
To: Charles Mirabile <cmirabil@redhat.com>
Cc: linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH] nolibc/stdlib: Improve `getauxval(3)` implementation
Message-ID: <ZabQVvpZ4e7hTwcb@biznet-home.integral.gnuweeb.org>
References: <20240116181147.2230944-1-cmirabil@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116181147.2230944-1-cmirabil@redhat.com>
X-Bpl: hUx9VaHkTWcLO7S8CQCslj6OzqBx2hfLChRz45nPESx5VSB/xuJQVOKOB1zSXE3yc9ntP27bV1M1

On Tue, Jan 16, 2024 at 01:11:47PM -0500, Charles Mirabile wrote:
> At least on x86-64, the ABI only specifies that one more long will be
> present with value 0 (type AT_NULL) after the pairs of auxv entries.
> Whether or not it has a corresponding value is unspecified. This value is
> present on linux, but there is no reason to check it as simply seeing an
> auxv entry whose type value is AT_NULL should be enough.

Yeah, I agree with that. I just read the ABI and confirmed that the
'a_un' member is ignored when the type is `AT_NULL`. Let's stop relying
on an unspecified value.

For others who want to check, see page 37 and 38:
https://gitlab.com/x86-psABIs/x86-64-ABI/-/wikis/uploads/221b09355dd540efcbe61b783b6c0ece/x86-64-psABI-2023-09-26.pdf

> This is a matter of taste, but I think processing the data in a structured
> way by coercing it into an array of type value pairs, using multiple
> return style, and a for loop with a clear exit condition is more readable
> than the existing infinite loop with multiple exit points and a return
> value variable.

Ok. It's more readable using your way. One thing that bothers me a bit
is type of 'a_type'. On page 37, the ABI defines the auxv type-val pair
as:

  typedef struct
  {
    int a_type;
    union {
      long a_val;
      void *a_ptr;
      void (*a_fnc)();
    } a_un;
  } auxv_t;

Assuming the arch is x86-64 Linux. Note that 'a_type' is an 'int' which
is 4 bytes in size, but we use 'unsigned long' instead of 'int' to
represent it. However, since 'a_un' needs to be 8 bytes aligned, the
compiler will put a 4 bytes padding between 'a_type' and 'a_un', so it
ends up just fine (on x86-64).

What do you think about other architectures? Will it potentially be
misinterpreted?

I tried to compare it in my head for i386, but it also ends up just
fine. I don't know other architectures.

> I also added a call to set errno to ENOENT when the entry is not found as
> glibc does which allows programs to disambiguate between the case of an
> auxv that is not present, and one that is, but with value zero.

Good catch!

-- 
Ammar Faizi


