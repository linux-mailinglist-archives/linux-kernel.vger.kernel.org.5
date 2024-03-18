Return-Path: <linux-kernel+bounces-106681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A5F87F1E1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 519D91C2159F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1D559B59;
	Mon, 18 Mar 2024 21:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6mYY4Nm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675B659B4E;
	Mon, 18 Mar 2024 21:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710796498; cv=none; b=TwhvIcBqD+LMGtqMhAHAwSVX6kz3TIAQJEMBAyFJ1s+Q6fCUEMNzUsHIuw46OniV2vfRs5UL/7orG7VHrSMOUu/zsfwVyOL0GpHL2mosgnCsqiFnLyTkeEmks/cIznX/xNQqA8RhuDHfxOpi8Oc0RIZqhg9Pl/9bN8qlyAViZ/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710796498; c=relaxed/simple;
	bh=dT47TVgOTPKMkNIrXZZ7cGODl1lIY1Bwb2ulxlmyVo8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=aaKBofctJ6FLjyGYCIdEjk9nFoLm8QQcA8BWLDkQZ7UpyKT6XpoezWCT2GRQJu8Xx4a/AUM7hjkAmxQZ5+FSzVXwUNZIhKyGcwlYqXMlJFIPGb0VLdik6SiiFcsQ+9xjlPRddAoC77LIFrdltei8vwbKYhN62Jg9JiZYcCX9EJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6mYY4Nm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C29A7C433C7;
	Mon, 18 Mar 2024 21:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710796497;
	bh=dT47TVgOTPKMkNIrXZZ7cGODl1lIY1Bwb2ulxlmyVo8=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Y6mYY4NmSOP+mQ243jXwyuYmEjYopUw2L3P56+V/XFiwOLnxajBWvmIP0otOHhjid
	 X3B3Jodt2vqiLZqI8FYyeVWc4lPrw068V45QG+VnDCKP9QGTv5jZMSKA40Hjf11dmT
	 uP5spm11HuTbJYHmRW68yTphqC2ku92yjKQKIUG799YrADEpOBPKjEwSDW+XNPjvhF
	 cFsspuK40R5XrZZB16D90siku0HYQAPykaJVk4effyprDECmv1gc8dy5j3e/9MDuBF
	 LEYNvDPcrGcfRE9dRkfHe7QglMrabvSMHZ8OVNGgZEbs/+/cah5K0W7HtDQXtoFvSw
	 q8PaPAAI6UHTg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 Mar 2024 23:14:55 +0200
Message-Id: <CZX6QS05JAHA.M82GVT11TIQC@kernel.org>
Cc: "Eric Biggers" <ebiggers@kernel.org>, <keyrings@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] keys: update key quotas in key_put()
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Luis Henriques" <luis.henriques@linux.dev>, "David Howells"
 <dhowells@redhat.com>
X-Mailer: aerc 0.15.2
References: <20240130101344.28936-1-lhenriques@suse.de>
 <3007646.1707134664@warthog.procyon.org.uk> <87il33f24c.fsf@suse.de>
 <87msr2qpd9.fsf@brahms.olymp>
In-Reply-To: <87msr2qpd9.fsf@brahms.olymp>

On Wed Mar 13, 2024 at 2:37 PM EET, Luis Henriques wrote:
> Luis Henriques <lhenriques@suse.de> writes:
>
> > David Howells <dhowells@redhat.com> writes:
> >
> >> Luis Henriques <lhenriques@suse.de> wrote:
> >>
> >>> Delaying key quotas update when key's refcount reaches 0 in key_put()=
 has
> >>> been causing some issues in fscrypt testing, specifically in fstest
> >>> generic/581.  This commit fixes this test flakiness by dealing with t=
he
> >>> quotas immediately, and leaving all the other clean-ups to the key ga=
rbage
> >>> collector.
> >>
> >> Okay, I'll accept this.
> >>
> >
> > That's awesome, thanks a lot David.  And, as Eric requested, I'll send =
out
> > shortly a follow-up fscrypt-specific patch, which will make generic/581
> > fstest finally pass.
>
> Ping.  Looks like this fell through the cracks...?
>
> I took a quick look at some git trees ('jarkko' and 'dhowells') but
> couldn't see this patch anywhere.
>
> Cheers,

My bad! I'll pick this up now.

BR, Jarkko

