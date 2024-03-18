Return-Path: <linux-kernel+bounces-106711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A64287F24E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25824282100
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:37:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2E159166;
	Mon, 18 Mar 2024 21:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1qbdz15"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFF35916A;
	Mon, 18 Mar 2024 21:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710797842; cv=none; b=hajyRotYzdRPvtzQ3hSeSg/aGJ+s4M3g+qE3YKQKQi/9/5IECo6roWxImLr7VE9jxAlHl7ji38FMmvbx1kNrGfPijDe51z/lq3+sov5jpPft6nfbQWiQqPjA3nBGNaNTowtsk80pH4z/BU2uK/QBji76SbS/Da3ZAwi8Olg+8qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710797842; c=relaxed/simple;
	bh=SvaOnFgW0tsPznMqpMKS2aKw473436fJjW5Zu1XAxAI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Bt7tIPfl6U0fsbyr39GZiJqKywYkB86MPtSum8t14oSzl30USb+FTobN9vb9mVwP8I3vY3/jS40xNySBsSxak4rUBbS5rBCDzR2IkoxkY/sY3wpIkUvfSpQyErc0W4ldoUZnrrR9Dxg5dglbRGjv+GfihT1vFlEVjUmSHufX514=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1qbdz15; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51763C433C7;
	Mon, 18 Mar 2024 21:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710797842;
	bh=SvaOnFgW0tsPznMqpMKS2aKw473436fJjW5Zu1XAxAI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=F1qbdz15k8HSHRv2GE44mK/DlWxD1RQYo4kKknAZFbaC7MM8Rq/UzZdom/QanY3fd
	 suOvPRd7TEGH5wvx0TwkJhU3H82papd7GMOyYXvDMDewHHSIZ9WLIKMNptW+VKrzDy
	 WiMhPdoyjtyi3j39+dXa9qF9z7olynnthSNih17Ys5MbeMqTSv5LjZjYGmpYIBlrbh
	 JCMGx/Gg+DcrT2ok7T7S2PU4lM5rzw4mD7YV9ljzEY0+oN/2sJgRyn9jQtjxGYlh+N
	 9NOkaKqNoA9FExpUCdb2idyVeqGrvgkRng2+I9CLaahrhjznU0R+1jx+aySInNO78G
	 ZP8PaMVrmxBxw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 Mar 2024 23:37:19 +0200
Message-Id: <CZX77XLG67HZ.UAU4NUQO27JP@kernel.org>
Cc: "Eric Biggers" <ebiggers@kernel.org>, <keyrings@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] keys: update key quotas in key_put()
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Luis Henriques"
 <luis.henriques@linux.dev>, "David Howells" <dhowells@redhat.com>
X-Mailer: aerc 0.15.2
References: <20240130101344.28936-1-lhenriques@suse.de>
 <3007646.1707134664@warthog.procyon.org.uk> <87il33f24c.fsf@suse.de>
 <87msr2qpd9.fsf@brahms.olymp> <CZX6QS05JAHA.M82GVT11TIQC@kernel.org>
In-Reply-To: <CZX6QS05JAHA.M82GVT11TIQC@kernel.org>

On Mon Mar 18, 2024 at 11:14 PM EET, Jarkko Sakkinen wrote:
> On Wed Mar 13, 2024 at 2:37 PM EET, Luis Henriques wrote:
> > Luis Henriques <lhenriques@suse.de> writes:
> >
> > > David Howells <dhowells@redhat.com> writes:
> > >
> > >> Luis Henriques <lhenriques@suse.de> wrote:
> > >>
> > >>> Delaying key quotas update when key's refcount reaches 0 in key_put=
() has
> > >>> been causing some issues in fscrypt testing, specifically in fstest
> > >>> generic/581.  This commit fixes this test flakiness by dealing with=
 the
> > >>> quotas immediately, and leaving all the other clean-ups to the key =
garbage
> > >>> collector.
> > >>
> > >> Okay, I'll accept this.
> > >>
> > >
> > > That's awesome, thanks a lot David.  And, as Eric requested, I'll sen=
d out
> > > shortly a follow-up fscrypt-specific patch, which will make generic/5=
81
> > > fstest finally pass.
> >
> > Ping.  Looks like this fell through the cracks...?
> >
> > I took a quick look at some git trees ('jarkko' and 'dhowells') but
> > couldn't see this patch anywhere.
> >
> > Cheers,
>
> My bad! I'll pick this up now.

I applied it.

Only for completeness sake I mention that I tuned the 2nd paragraph so
that lines do no exceed 75 characters :-) Otherwise, I did not modify
the commit.

I'll schedule this to a PR after rc1 is out (just to see if there is
something else that needs to be picked before that).

BR, Jarkko

