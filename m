Return-Path: <linux-kernel+bounces-38116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B0983BB18
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 08:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 544AB1F26D0F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 07:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597DD17579;
	Thu, 25 Jan 2024 07:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=winehq.org header.i=@winehq.org header.b="rjA9eI3W"
Received: from winehq.org (winehq.org [4.4.81.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6BB17727;
	Thu, 25 Jan 2024 07:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.4.81.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706169450; cv=none; b=Damsyt2RfCMlbXVQvA/mgoJIAPt9QC0cPefkD8ZI9sh3xOQQx0B+jMQ77geQ3S/tVKGk3saWklZCZxg1I4Mn9dZ4hSQFjhjAGFV6SN8jSl2XMirKkvrAa3+JtGZfiOp9CXBYu6Za+A+ynEElX5USevVExHG4jou93PvdrPmkMLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706169450; c=relaxed/simple;
	bh=BG4b1dwAC0O5niSsIyr5Wwdb38kT2Xjz5+5JU87Krng=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ffMODFNrUH4VWmJDTpOqOc4vVzwfmySCtgiD1PO341pXAeSmdckkD0vv9RNMF6YcC6sVhT+FfV2WvvwWe5UxkEfIKGDF0UhfoINCSCsgIJwgnRG8WR1On2IfuwUkOE10RwQ7gyLsGy+/ih3OQyUXrI1N8oSYYivf438GNdWPppc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=winehq.org; spf=pass smtp.mailfrom=winehq.org; dkim=pass (2048-bit key) header.d=winehq.org header.i=@winehq.org header.b=rjA9eI3W; arc=none smtp.client-ip=4.4.81.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=winehq.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=winehq.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=winehq.org;
	s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=Q4cMmITwA1uV9qSgRwQNyCfyNufbMRwq/yk11gxwcNs=; b=rjA9eI3WSXF89DvI/3xWF4yrxB
	Z1p1KTHr71ogp+269uo0lbKOU51bN3EHBFNlIIBQEAP7dVhdDFnVEfuwgV0vVe0LRmB/Am0vOd2gc
	TE0xVwlQMputrnXPbI4uDAUglmBINHZbGqPolV46KjJwK0TZqD771AKC5WlGRSvbwkzQMcxBElKDp
	cJz7tWVHp/2cFFk+Fw63XS5wkq7LgG79azB9aU9AtAaxdSrNowW4hGpQHD6yepg5fBuhA9weDeGxY
	vuG90pMtdHAFgVqdG14fDNvGiHpUoFnudxeJzYNkAzKsfz7MxB3X8ULv4eLqi2CmJ2nndZKifBTvy
	L9joL4ZA==;
Received: from xdsl-188-154-165-39.adslplus.ch ([188.154.165.39] helo=wine)
	by winehq.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <julliard@winehq.org>)
	id 1rSuMf-00A7IL-VV; Thu, 25 Jan 2024 01:41:35 -0600
Received: from julliard by wine with local (Exim 4.97)
	(envelope-from <julliard@winehq.org>)
	id 1rSuMe-000000007Cb-0i9z;
	Thu, 25 Jan 2024 08:41:32 +0100
From: Alexandre Julliard <julliard@winehq.org>
To: Elizabeth Figura <zfigura@codeweavers.com>
Cc: Andy Lutomirski <luto@kernel.org>,  Arnd Bergmann <arnd@arndb.de>,  Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,  linux-kernel@vger.kernel.org,
  linux-api@vger.kernel.org,  wine-devel@winehq.org,  =?utf-8?Q?Andr=C3=A9?=
 Almeida
 <andrealmeid@igalia.com>,  Wolfram Sang <wsa@kernel.org>,  Arkadiusz Hiler
 <ahiler@codeweavers.com>,  Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 1/9] ntsync: Introduce the ntsync driver and
 character device.
In-Reply-To: <5907233.BlLQTPImNI@camazotz> (Elizabeth Figura's message of
	"Wed, 24 Jan 2024 16:56:23 -0600")
References: <20240124004028.16826-1-zfigura@codeweavers.com>
	<20240124004028.16826-2-zfigura@codeweavers.com>
	<CALCETrU+Eb5CdkqfYK8JvOiPA7K-6Bfs4uEWiu-U9oH95XfvKw@mail.gmail.com>
	<5907233.BlLQTPImNI@camazotz>
Date: Thu, 25 Jan 2024 08:41:32 +0100
Message-ID: <87mssthnbn.fsf@wine>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -8.6
X-Spam-Report: Action: no action
 Symbol: FROM_HAS_DN(0.00)
 Symbol: FROM_EQ_ENVFROM(0.00)
 Symbol: RCVD_COUNT_TWO(0.00)
 Symbol: BAYES_HAM(-3.00)
 Symbol: TO_MATCH_ENVRCPT_ALL(0.00)
 Symbol: RCVD_TLS_LAST(0.00)
 Symbol: MID_RHS_NOT_FQDN(0.50)
 Symbol: MIME_GOOD(-0.10)
 Symbol: NEURAL_HAM(0.00)
 Symbol: RCPT_COUNT_SEVEN(0.00)
 Symbol: RCVD_VIA_SMTP_AUTH(0.00)
 Symbol: WHITELIST_SENDER_DOMAIN(-6.00)
 Symbol: ASN(0.00)
 Symbol: ARC_NA(0.00)
 Symbol: MIME_TRACE(0.00)
 Symbol: TO_DN_SOME(0.00)
 Message-ID: 87mssthnbn.fsf@wine

Elizabeth Figura <zfigura@codeweavers.com> writes:

> On Wednesday, 24 January 2024 15:26:15 CST Andy Lutomirski wrote:
>> On Tue, Jan 23, 2024 at 4:59=E2=80=AFPM Elizabeth Figura
>> <zfigura@codeweavers.com> wrote:
>> >
>> > ntsync uses a misc device as the simplest and least intrusive uAPI int=
erface.
>> >
>> > Each file description on the device represents an isolated NT instance=
, intended
>> > to correspond to a single NT virtual machine.
>>=20
>> If I understand this text right, and if I understood the code right,
>> you're saying that each open instance of the device represents an
>> entire universe of NT synchronization objects, and no security or
>> isolation is possible between those objects.  For single-process use,
>> this seems fine.  But fork() will be a bit odd (although NT doesn't
>> really believe in fork, so maybe this is fine).
>>=20
>> Except that NT has *named* semaphores and such.  And I'm pretty sure
>> I've written GUI programs that use named synchronization objects (IIRC
>> they were events, and this was a *very* common pattern, regularly
>> discussed in MSDN, usenet, etc) to detect whether another instance of
>> the program is running.  And this all works on real Windows because
>> sessions have sufficiently separated namespaces, and the security all
>> works out about as any other security on Windows, etc.  But
>> implementing *that* on top of this
>> file-description-plus-integer-equals-object will be fundamentally
>> quite subject to one buggy program completely clobbering someone
>> else's state.
>>=20
>> Would it make sense and scale appropriately for an NT synchronization
>> *object* to be a Linux open file description?  Then SCM_RIGHTS could
>> pass them around, an RPC server could manage *named* objects, and
>> they'd generally work just like other "Object Manager" objects like,
>> say, files.
>
> It's a sensible concern. I think when I discussed this with Alexandre
> Julliard (the Wine maintainer, CC'd) the conclusion was this wasn't
> something we were concerned about.
>
> While the current model *does* allow for processes to arbitrarily mess
> with each other, accidentally or not, I think we're not concerned with
> the scope of that than we are about implementing a whole scheduler in
> user space.

I may have misunderstood something in that dicussion then, because it
would definitely be a concern. It's OK for a process to be able to mess
up the state of any object that it has an NT handle to, but it shouldn't
be possible to mess up the state of unrelated objects in other processes
simply by passing the wrong integer id.

The concern is not so much about a malicious process going out of its
way to corrupt others, because it could do that through the NT API just
as well. But if a wayward pointer corrupts the client-side handle cache,
that shouldn't take down the entire session.

--=20
Alexandre Julliard
julliard@winehq.org

