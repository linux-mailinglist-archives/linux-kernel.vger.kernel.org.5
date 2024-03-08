Return-Path: <linux-kernel+bounces-96539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF27875DBF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 06:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B86028216F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 05:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B22E364BA;
	Fri,  8 Mar 2024 05:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuLIWdKA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3994364A1
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 05:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709876513; cv=none; b=WmtR/EoRXNlOrkaMqygBh+6WqCPdvFkY7j279H3Kmrbzxo/miL5t3me4zrW6Ko24E5X+9vRRbMHnld6qA8b+A4J7U8xatQ1ankOE9AjRj+If2W5nOauCSuCEhkUgrx63jUqwG8oYvfVgs12qF8/YEWaqI27YNpAFlMDl3OcK9BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709876513; c=relaxed/simple;
	bh=YY0ngKqwHmUqwvnA4WlChAL0cHrU5iop01IV/D1Icmc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=W9rJt2757GJJ3amASE6c9YQJKO9JrJjPElrJdK6uGXVrBlmmfUPekalH+DpD9P6JeMtzNpDJNxpskb6SM8TygmJ68Z9YeONJOBLa57KYRgc8wFm4LlqboC2yttWeYzSnMCTqWWMiC8JHSAJ4cunjI5hG6LQjtruSm4/Z/xqbxx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuLIWdKA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E151C433F1;
	Fri,  8 Mar 2024 05:41:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709876512;
	bh=YY0ngKqwHmUqwvnA4WlChAL0cHrU5iop01IV/D1Icmc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UuLIWdKAa8zcUN4HxBW5lzHPWCaFYsn58FHrIoGLj/7/DMtt6jCMmU0U66+zJuuGY
	 OIb6ziXVPUicx7PTbInbOpwtIBqb16dTeW9VrUBrs+IeXRYnrioU8uqKcGoNI+pC8i
	 NtJpGokO7satK5ho8IeDspYk6JGSqWoPSwQvMR8ACoiJ2F+eKvliE9rAU4/HnEENmE
	 seGpCfM6KjIw7mQCmQvi4ldvItCMx6A0rezbjKl5LhnvPtbBrULReLMtQ1NjJysczo
	 /VsWDTKIrMHu+8rpvmA62LTwmNo/oUYhny2xDpQizg6oPmpG1R6oBaMDPgFKQrvlcQ
	 bP32jzuMPpAww==
Date: Fri, 8 Mar 2024 14:41:46 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andrew Morton <akpm@linux-foundation.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bootconfig: do not put quotes on cmdline items unless
 necessary
Message-Id: <20240308144146.7875c1a3092846111c6ca690@kernel.org>
In-Reply-To: <40914a69-d4b7-4fdd-bc58-cf9b28271ac3@rasmusvillemoes.dk>
References: <20240306122452.1664709-1-linux@rasmusvillemoes.dk>
	<20240306124211.b490ea3c2372d89cff8c287c@linux-foundation.org>
	<e1075345-ea35-4b39-a158-a0d165314a14@rasmusvillemoes.dk>
	<40914a69-d4b7-4fdd-bc58-cf9b28271ac3@rasmusvillemoes.dk>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Mar 2024 09:18:17 +0100
Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:

> On 07/03/2024 09.10, Rasmus Villemoes wrote:
> 
> >>> +static int has_space(const char *v)
> >>> +{
> >>> +	for (; *v; v++)
> >>> +		if (isspace(*v))
> >>> +			return 1;
> >>> +	return 0;
> >>> +}
> >>
> >> Do we already have something which does this?
> > 
> > Well, 'value[strcspn(value, " \t\r\n")] ? "\"" : ""' would be a
> > oneliner, but not particularly readable. Also that list of characters
> > doesn't necessarily match isspace(), see below.
> 
> I didn't look close enough. We do have strpbrk(), so strpbrk(value, "
> \t\r\n") ? .. : .. , but that still leaves the question of just what set
> of characters to search for. But there's no harm in just making it "
> \t\n\v\f\r\xa0" except it requires a comment saying "these are precisely
> the isspace() characters in the kernel's ctype".

I think strpbrk(" \t\r\n") is good enough. Some may not work in cmdline
but as you said, since next_arg()@lib/cmdline.c uses isspace() to separate
the argument, it is better to use the same rule.

Thank you,

> 
> Rasmus
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

