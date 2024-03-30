Return-Path: <linux-kernel+bounces-126113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A76889325C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6379FB21E7D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE989148846;
	Sun, 31 Mar 2024 16:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="C0B2YKox"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5F5145B0E;
	Sun, 31 Mar 2024 16:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711900949; cv=fail; b=eqYwRq0SPdymxkhnx1hdG11gTwIh+nLkO1325Dx5Avm90sKfvw1JIAffmAqH5I9y4ojRPxGyeTCFrZevfbOgGzwQxXjaCG7xlUEw4REp6VNUCozaQhnN1VEqKsLELXaNF/DCzKx9gy2zF+UtqgEoaRzf0D0atObeLQPsiL9ItRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711900949; c=relaxed/simple;
	bh=x2hTAIw5it61iaDhIP8yLgeY+tHv0C2nNMk1Ca0GTnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJ+RnZq2XmPlDqBr8B+vCMYiORQAGyFJVfbCZTW/N6NPIbfGth5V7Mp/EIdN2ngKFqdMS4bA5fnsvGHLXTFhUTLqTn6XE9OWk8HizsLTzvhAKhWpefGvYz/5iPDgSzeo8zIOjrXyN0zVAxdhB2rsC7E8AQ/Tka42o1r9BAGb3c4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=fail smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=C0B2YKox; arc=none smtp.client-ip=65.109.113.108; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=alien8.de
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id D9C9A208C6;
	Sun, 31 Mar 2024 18:02:24 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QjxZjgdh6ZWm; Sun, 31 Mar 2024 18:02:23 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 4A5BE208C2;
	Sun, 31 Mar 2024 18:02:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 4A5BE208C2
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 3DBE1800055;
	Sun, 31 Mar 2024 18:02:23 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:02:23 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 15:52:45 +0000
X-sender: <linux-kernel+bounces-125904-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com>
 ORCPT=rfc822;steffen.klassert@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAPDFCS25BAlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9ye
	TogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoArV1rGbMv3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAYgAKAFIAAADkigAABQBkAA8AAwAAAEh1Yg==
X-Source: SMTP:Default MBX-ESSEN-01
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 12221
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.48.161; helo=sy.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125904-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com DE70A2025D
Authentication-Results: b.mx.secunet.com;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="C0B2YKox"
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711838917; cv=none; b=RLbMv7/rszEl7x6SX3kGFBqlG+P4O43vEUFFX26tfHpFzW+YHPuUvbNYHT1nhFoC80geNcoEApsB1McQPoFZZ6Vx+X0KAroYd3td/C2nzT1SZRM37Bz50LNerd5AM8b/ldFS0Uv07Ebfc3Ed6560QhYY72dWDu1gBpeldl3DjaY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711838917; c=relaxed/simple;
	bh=x2hTAIw5it61iaDhIP8yLgeY+tHv0C2nNMk1Ca0GTnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhCUY64wjcZGFSNltxdegfzQbxixyad7oYMDvbdjlLvUhY+VE4J1oURXz8ISbWeu0pBQrxVwPmw0CqoAnG/mphxWOUvocWnoY3BHa5Q8CDJMOiP1RcTNCvLYRvLDb4Hk4Whf+Z5eAhUZadZKSZvEwH4Lr6FPqiNHsgb19y4EvA4=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=C0B2YKox; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711838908; bh=9He/xRJ3v1u5Z/fITkbp2xLhYx5Y0tXLgjuKhvKMsHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C0B2YKoxK1y3PYW43Chdq5mJeOFhirD6NP6dbju5AEK9Q876El3ARoFjadR+R2Q/1
	 89K1Bp8z6LmkQa8oXhp+A/nNmfMVyqIJm/to9+pj1i/gM9wk/TRa6oDh4wosyAjTVH
	 4DnqjknF57hz5VqWMiWzuGXkHrkH+4gw4iMfIoZ6RqdEIeCDZk0BzRjPigpMIl6NSs
	 lG92b6F7arVuA/Tpj7+6CP3czW/dMfebWYQUicO2DTWcnDa10Eya9dyLlSDJeK/p0E
	 8qpCzxfESUfxvZKjNSCfwA/JGrOVsjh5c70Wpk4Z4WYB774iippJ3N8VzsjSZjFAir
	 5Gbco9xSEl4m3UIjxmCufTVKp3hpSN56jIwAzOwU8xhEXwV2EswkZX8sxlXYkNCNe0
	 ZwX6C5/9r7A0fsEGd61Mwz1cwDD3fo6t4EUcj/si19tMwJMANKqvmgGcd/1yZABbpx
	 gK6wOUcl9v3AnxIkQ5MFIfDpJQEbEQ/Vx7GJ9tE1XcWz/AG9ohzS+eU30EYwlCg8Oc
	 V9K/xGOaEaBrId64WcEUaXYrgfZ0Zwpt0z4ZKHuD+C6TqVGDm33RIy8WXCcb7NvKIj
	 1khLtDeURwC1+PlWLhuAVDTqvZ+q2Xac85zP1mPlukjQZmFOugxfRm2mbJC4Mx5H+N
	 GUfpNItMcM+uPznZWEa5bD5Y=
Date: Sat, 30 Mar 2024 23:48:10 +0100
From: Borislav Petkov <bp@alien8.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	LKML <linux-kernel@vger.kernel.org>, kasan-dev@googlegroups.com,
	David Kaplan <David.Kaplan@amd.com>
Subject: Re: [PATCH] kbuild: Disable KCSAN for autogenerated *.mod.c
 intermediaries
Message-ID: <20240330224810.GBZgiWqnW1JZvwzOdK@fat_crate.local>
References: <0851a207-7143-417e-be31-8bf2b3afb57d@molgen.mpg.de>
 <47e032a0-c9a0-4639-867b-cb3d67076eaf@suse.com>
 <20240326155247.GJZgLvT_AZi3XPPpBM@fat_crate.local>
 <80582244-8c1c-4eb4-8881-db68a1428817@suse.com>
 <20240326191211.GKZgMeC21uxi7H16o_@fat_crate.local>
 <CANpmjNOcKzEvLHoGGeL-boWDHJobwfwyVxUqMq2kWeka3N4tXA@mail.gmail.com>
 <20240326202548.GLZgMvTGpPfQcs2cQ_@fat_crate.local>
 <CAK7LNASkpxRQHn2HqRbc01CCFK=U0DV607Bbr9QA9xDYhjcwyA@mail.gmail.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CAK7LNASkpxRQHn2HqRbc01CCFK=U0DV607Bbr9QA9xDYhjcwyA@mail.gmail.com>
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Sun, Mar 31, 2024 at 07:32:30AM +0900, Masahiro Yamada wrote:
> I applied.
> 
> I fixed the typo "the the" and replaced Link: with Closes:
> to address the following checkpatch warnings:

Thanks!

> Instead of filter-out, you could add
> KCSAN_SANITIZE := n
> to scripts/Makefile.modfinal because
> it is the reason why KCSAN_SANITIZE exists.
> 
> But, that is not a big deal.
> GCOV flag is also filtered away instead of
> GCOV_PROFILE := n

Ah, that would've been more readable, yap.
 
> I will probably use a different approach later.

Right.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette


