Return-Path: <linux-kernel+bounces-70585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B80985997A
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 22:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDA141F21692
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 21:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFEEE7317C;
	Sun, 18 Feb 2024 21:11:42 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000D2335CC
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 21:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708290702; cv=none; b=g2/3cGqEjYOskvNtqcF9YSz7FrYz0LjY0PhaurC4Ocb9SvlTuU+5GHf6WjSv6OHrcT7wyS0k5LRuT8iLxWbimVTBhEARBhRvaoNMSYBDwO7ffjRwdVUdGsRMwuiXbLtpidyp8PIkoCN8/+XL/BldZA3eUVSHMewRiY2GYr1hEvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708290702; c=relaxed/simple;
	bh=EJJdkkuqi1byswEBPTol8XA3l41lRaC7iCllVoF1exk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igtR9Q0hd3RlRA4xrtoyQDQOya76g5yHbcBsE8AQPNDvaGuelC1HuGFzZvSKgbCRrCeJSzRvAI+L7elj9o2ctRYM/v0yRQGR/rxejCDyziiGQIZwdQIuN/R3mS3MWbtb0O8s3KfUbWGjjQUNL93jzgfzvwGXZePe8IdUm2EDluk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 41ILBVtt005062;
	Sun, 18 Feb 2024 22:11:31 +0100
Date: Sun, 18 Feb 2024 22:11:31 +0100
From: Willy Tarreau <w@1wt.eu>
To: Rodrigo Campos <rodrigo@sdfg.com.ar>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] selftests/nolibc: Add tests for strlcat() and
 strlcpy()
Message-ID: <20240218211131.GA5056@1wt.eu>
References: <20240218195110.1386840-1-rodrigo@sdfg.com.ar>
 <20240218195110.1386840-5-rodrigo@sdfg.com.ar>
 <2e1378df-ce3d-4f72-bbd6-6ba7654016bc@sdfg.com.ar>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e1378df-ce3d-4f72-bbd6-6ba7654016bc@sdfg.com.ar>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Sun, Feb 18, 2024 at 05:39:03PM -0300, Rodrigo Campos wrote:
> On 2/18/24 16:51, Rodrigo Campos wrote:
> > diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> > index 6ba4f8275ac4..d373fc14706c 100644
> > --- a/tools/testing/selftests/nolibc/nolibc-test.c
> > +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> > @@ -600,6 +600,25 @@ int expect_strne(const char *expr, int llen, const char *cmp)
> >   /* declare tests based on line numbers. There must be exactly one test per line. */
> >   #define CASE_TEST(name) \
> > @@ -991,6 +1010,14 @@ int run_stdlib(int min, int max)
> >   	for (test = min; test >= 0 && test <= max; test++) {
> >   		int llen = 0; /* line length */
> > +		/* For functions that take a long buffer, like strlcat()
> 
> Ouch, I didn't leave a "/*\n" for this comment :(

No worries, if you want I'll address it myself, just let me know, no
need to respin a series for this.

Thanks!
Willy

