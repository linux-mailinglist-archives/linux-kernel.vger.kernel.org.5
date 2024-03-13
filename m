Return-Path: <linux-kernel+bounces-101480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80EAB87A7AA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CCD12836E6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822194416;
	Wed, 13 Mar 2024 12:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fInGw5xX"
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD383A59
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 12:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710333464; cv=none; b=aeh4mg8V3arS7cYn9TKJmbYemK/jAvF8NWycLyE5tHLrNjTDgDXDgWhIIQ69apn2FrUuKEtXNXf76fUTQPJgEIr2Axze2NoH3jq41o6mCe1lVlF38J2E01m+02iJ/MjPFZPtzq87GVRthWKexbf2PyeG04ShvD/qigzQD37it+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710333464; c=relaxed/simple;
	bh=cJmBnz6k0xIESxKWJRuBLNMa0QNfz2uY9clGq3EDUVQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Cmq4k/2OsIq9jGp4B6SmYwLcTMmfM5l9tHbEuUxDLskdkwk4GNDqDJ8FwvshdmMoyYdP3aU6iDDC5OL6Hs0DRsncZV5vkJYJ8hcKmDHGI4KP6bTJqr0iaSuGq5YuTmf8Ancpj7bYa10pLJiIQ18ipOxNMiDZldyEFFygTtXtQrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fInGw5xX; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710333460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bipwNNYQZsUwmH59oT8QYK6cVW89ev95iLM0rdBUuqM=;
	b=fInGw5xXVTRYJ1qjuUcNkBZiJMycCkBRBhXx9nLHcUrmkIyYQAXiWt77q/o2jE7/HsKtfU
	zxAk8ChyOT0lSOrc22twwnsNf9opCDC1P33gcN2WBxo/2zBgcTP88YEsPxr1EsH5o9nJVl
	UvC7Yq0BAY5XTja+ceTh3rsLC3Aogvo=
From: Luis Henriques <luis.henriques@linux.dev>
To: David Howells <dhowells@redhat.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>,  Eric Biggers
 <ebiggers@kernel.org>,  keyrings@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] keys: update key quotas in key_put()
In-Reply-To: <87il33f24c.fsf@suse.de> (Luis Henriques's message of "Mon, 05
	Feb 2024 13:54:11 +0000")
References: <20240130101344.28936-1-lhenriques@suse.de>
	<3007646.1707134664@warthog.procyon.org.uk> <87il33f24c.fsf@suse.de>
Date: Wed, 13 Mar 2024 12:37:38 +0000
Message-ID: <87msr2qpd9.fsf@brahms.olymp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Luis Henriques <lhenriques@suse.de> writes:

> David Howells <dhowells@redhat.com> writes:
>
>> Luis Henriques <lhenriques@suse.de> wrote:
>>
>>> Delaying key quotas update when key's refcount reaches 0 in key_put() h=
as
>>> been causing some issues in fscrypt testing, specifically in fstest
>>> generic/581.  This commit fixes this test flakiness by dealing with the
>>> quotas immediately, and leaving all the other clean-ups to the key garb=
age
>>> collector.
>>
>> Okay, I'll accept this.
>>
>
> That's awesome, thanks a lot David.  And, as Eric requested, I'll send out
> shortly a follow-up fscrypt-specific patch, which will make generic/581
> fstest finally pass.

Ping.  Looks like this fell through the cracks...?

I took a quick look at some git trees ('jarkko' and 'dhowells') but
couldn't see this patch anywhere.

Cheers,
--=20
Lu=C3=ADs

