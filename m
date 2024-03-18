Return-Path: <linux-kernel+bounces-106715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E74387F255
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1B6BB21776
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA3E5A4C9;
	Mon, 18 Mar 2024 21:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="G+cV+Zud"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3075A0FA
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 21:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710797893; cv=none; b=pdjFk+cqZ+uXPkoY6EtWdmFwRMRZJjLfnR47BNa9sP71CshQPnFZOpHvkUt30vtGBg1y5ok4Rs10By+eSdeinMHpafXwDAMLkKZOs/2qA2SpM2iUJgt5tc83Np+qp/hAKlICr9UVL7kumcweBv2SegI0Zunfm/x3BVRwIAQkBZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710797893; c=relaxed/simple;
	bh=EfBl7JuECHz7HlqxR5vRgZJaunMWQ9dYHiogpv1qmMo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ahmHlhzgaPaO2hvoxOeLGFkstRcZZEk2xFm7dBt2Zgfd9JC+2W/Vfg1p4P/XMp4eGW7WiaJACbOA6Yb5Ydka7W9Ha+sQVMemK3A5pr5+eqcYdDzJexmZALkW2zHDe6ICTTSOw4sy0tjxm8IRBsSSkfZceHoY6BGbk4fVR/UaD54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=G+cV+Zud; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710797889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=P0SOW6+g0gbF8DU5iHpH960YQxkLq5Ws1it0zmKAALc=;
	b=G+cV+ZudHb99EOjOkEyYkRbNweyknEYF0BiWBTEx7dWWxiblPSPAh7duJ2+LHdgItIbn6M
	TAd6gKys5aTGgPyteoXBTcyCivHuPdyRatBMpeppVL3fuT+nIq2C3aM1Vj9bFCGAR47Aj3
	uRzT77InOc8li8Ta6WbMvqIAxG4VjYM=
From: Luis Henriques <luis.henriques@linux.dev>
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: "David Howells" <dhowells@redhat.com>,  "Eric Biggers"
 <ebiggers@kernel.org>,  <keyrings@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] keys: update key quotas in key_put()
In-Reply-To: <CZX6QS05JAHA.M82GVT11TIQC@kernel.org> (Jarkko Sakkinen's message
	of "Mon, 18 Mar 2024 23:14:55 +0200")
References: <20240130101344.28936-1-lhenriques@suse.de>
	<3007646.1707134664@warthog.procyon.org.uk> <87il33f24c.fsf@suse.de>
	<87msr2qpd9.fsf@brahms.olymp> <CZX6QS05JAHA.M82GVT11TIQC@kernel.org>
Date: Mon, 18 Mar 2024 21:38:05 +0000
Message-ID: <87plvr9q6a.fsf@camandro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

"Jarkko Sakkinen" <jarkko@kernel.org> writes:

> On Wed Mar 13, 2024 at 2:37 PM EET, Luis Henriques wrote:
>> Luis Henriques <lhenriques@suse.de> writes:
>>
>> > David Howells <dhowells@redhat.com> writes:
>> >
>> >> Luis Henriques <lhenriques@suse.de> wrote:
>> >>
>> >>> Delaying key quotas update when key's refcount reaches 0 in key_put() has
>> >>> been causing some issues in fscrypt testing, specifically in fstest
>> >>> generic/581.  This commit fixes this test flakiness by dealing with the
>> >>> quotas immediately, and leaving all the other clean-ups to the key garbage
>> >>> collector.
>> >>
>> >> Okay, I'll accept this.
>> >>
>> >
>> > That's awesome, thanks a lot David.  And, as Eric requested, I'll send out
>> > shortly a follow-up fscrypt-specific patch, which will make generic/581
>> > fstest finally pass.
>>
>> Ping.  Looks like this fell through the cracks...?
>>
>> I took a quick look at some git trees ('jarkko' and 'dhowells') but
>> couldn't see this patch anywhere.
>>
>> Cheers,
>
> My bad! I'll pick this up now.

Awesome, thanks a lot Jarkko.

Cheers,
-- 
Luis

