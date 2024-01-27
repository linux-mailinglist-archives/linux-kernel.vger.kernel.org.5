Return-Path: <linux-kernel+bounces-41403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A24983F036
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 22:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A21CB284895
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 21:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D917F1B275;
	Sat, 27 Jan 2024 21:27:37 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F105418EA8
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 21:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706390857; cv=none; b=szz0eGJUodBQ5BbLzeUreRvj1CFxqfOaAHD21mPxHxNyrVZfg/iAveDF/1Lm0COyNkfKLlT/mQK5vMwV9QFTvWJbRCV+TaapXHYp5Xazl4cNSctT74aBkEcrQ1a4C+xvRUdK/jDQR4LfePcSeKRamb0Je84jhVlCXmMO36SzrmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706390857; c=relaxed/simple;
	bh=9KwBhvtglN+6x4oYF2Z8Be3dzjV+mgnD23CoYh9dLSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UzvNiMk4BTeTAgQulEiHkdooG5d99S49t1ZR6vqLXQLbqWR/LhtGLJUCnI5LzfYJUgRcEAIdeLE82YD7Bnk/Q5+N5PtUglETmbGYTwDP1C+H7sHmrfbd0AOJUZ7wHGsqI8WPwUaEdHlt7SYOuCQD/CoYLMA+pFEodFbd40oKsYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 40RLRS8Y014852;
	Sat, 27 Jan 2024 22:27:28 +0100
Date: Sat, 27 Jan 2024 22:27:28 +0100
From: Willy Tarreau <w@1wt.eu>
To: David Laight <David.Laight@ACULAB.COM>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Rodrigo Campos <rodrigo@sdfg.com.ar>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/1] tools/nolibc/string: export strlen()
Message-ID: <20240127212728.GA14846@1wt.eu>
References: <20240126142411.22972-1-rodrigo@sdfg.com.ar>
 <9abed5e3-cd61-474e-bb16-13243709f5c5@t-8ch.de>
 <20240127162400.GA14079@1wt.eu>
 <512849f3c22e4f4688c20fabe017c903@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <512849f3c22e4f4688c20fabe017c903@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sat, Jan 27, 2024 at 09:23:01PM +0000, David Laight wrote:
> ..
> > Yes, once we have the proof that the compiler may produce such a call, it
> > can also happen in whatever user code so we need to export the function,
> > there's no other solution.
> 
> Does that mean that it you try to implement strlen() in C
> gcc will generate a recursive call?

Yes, that's exactly what happened the first time with strlen() itself!

> I guess an 'asm volatile("");' in the loop fix it.

That's how we fixed it for strlen(). The problem I'm having with
addressing it this way is that as long as the compiler will decide
to emit calls to strlen() which was not explicitly referenced in
the code, it will still be missing and will continue to fail. Thus
the safest solution is to make sure strlen() remains accessible in
case the compiler decides to make use of it.

Willy

