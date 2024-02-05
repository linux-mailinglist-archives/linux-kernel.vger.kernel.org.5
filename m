Return-Path: <linux-kernel+bounces-52154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 973888494A4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53DAA285E4F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 07:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2660B111BD;
	Mon,  5 Feb 2024 07:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SaVhPHd+"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E3A11197
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 07:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707118704; cv=none; b=SpyHQESzeLsms5HyalfnILQyBuWVaHYiIRoao93q//SK9UCR2x4tEH3GiY3UxA5DV1476QTNBq1aw/PxAB6NKjlJ5R34/D6cEIs//lTbX8BwVR2kIiyam9ekfaVHE1UBzksfZEmzpb3IoUinhqgIb/oC9yQmw9HnfDDjykeOovw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707118704; c=relaxed/simple;
	bh=3ykGuccNmwNLXvXzWGl4HZuTSZlZ//GMIUf98M7Yi6Y=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YQxqp9vS2JjarT3Kl4bS+BU+hvDDWsZ0loycZCIm5ywr7WYQW9l5DB0//CP2X7H3miwwfBm0EdL9hnuwAFXkFMzkXeQ/8LCS+3GsqXCGJIfqUf8jJiYcMlpVPIuxtUcYu5FPPoezs3aLSHS0gTPzYLwIpa9xcSnxpbxvmdVCvVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SaVhPHd+; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707118699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fQHXh2wfg2SeD35wizx70HuV8TPVTxbGPSiKIsEbGWw=;
	b=SaVhPHd+A0iYtfyl+XLII5d7yMV/0gsZJz1/JcqJJgqxF6LpvlU72ceo0g0LmRNEGMCiLV
	xdb+9afoW1fhGIPWD9MRGBq/UXBRHsyD0bWufCO/nLjWnNsenKyWrHs/fsaiZU7xMPNduw
	xyOkIRzTZ8G0Wbprolv8MRqnwHdf/4c=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH 1/1] hugetlb: fix CONFIG_PADATA dependency for non-SMP
 system
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <828f990c-11af-42ad-a030-a66dde97a7f2@linux.dev>
Date: Mon, 5 Feb 2024 15:37:41 +0800
Cc: Gang Li <ligang.bdlg@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org,
 Randy Dunlap <rdunlap@infradead.org>,
 kernel test robot <lkp@intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7472563F-5C2D-4DCB-ACD6-F86D7A18BDF2@linux.dev>
References: <20240204072525.1986626-1-gang.li@linux.dev>
 <f05f658a-78fa-45cd-ad07-11d87b824702@linux.dev>
 <a749cb06-9495-40fc-9192-b019b48eca92@linux.dev>
 <828f990c-11af-42ad-a030-a66dde97a7f2@linux.dev>
To: Gang Li <gang.li@linux.dev>
X-Migadu-Flow: FLOW_OUT



> On Feb 5, 2024, at 14:55, Gang Li <gang.li@linux.dev> wrote:
>=20
>=20
> On 2024/2/4 15:48, Gang Li wrote:
>> On 2024/2/4 15:44, Muchun Song wrote:
>>> I don't think it is a clear way to fix this. If someone want to
>>> use PADATA in a non-SMP system, he should be carefully to handle
>>> the non-SMP case himself. I think the better way is to make PADATA
>>> handle the non-SMP case, I think it should be easy for it, which
>>> could just call ->thread_fn() many times instead of creating many
>>> threads in the non-SMP case.
>>>=20
>>> Thanks.
>>>=20
>> Sounds good, I'll take a look at padata and send a new patch.
>=20
> 1. delete the dependency on SMP
>=20
> PADATA only depends on workqueue and completion. It works well with =
!SMP
> currently but has no performance benefits. What we can do is make =
PADATA
> handle the non-SMP case more elegantly.
>=20
> PADATA has two parts: "Running Multithreaded Jobs" and "Running
> Serialized Jobs".
>=20
> "Running Multithreaded Jobs", which hugetlb parallelization relies on
> can be easily deparallelize through this patch:
>=20
> ```
> @@ -495,7 +495,7 @@ void __init padata_do_multithreaded(struct =
padata_mt_job *job)
>       nworks =3D max(job->size / max(job->min_chunk, job->align), =
1ul);
>       nworks =3D min(nworks, job->max_threads);
>=20
> -      if (nworks =3D=3D 1) {
> +      if (nworks =3D=3D 1 || !IS_ENABLED(CONFIG_SMP)) {
>               /* Single thread, no coordination needed, cut to the =
chase. */
>               job->thread_fn(job->start, job->start + job->size, =
job->fn_arg);
>               return;
> ```
>=20
> However, "Running Serialized Jobs" is more challenging due to its
> various workers queuing each other, making it more complex than =
"Running
> Multithreaded Jobs." I am currently in the process of deciphering the
> code.

Actually, I did not get it. Why the above code cannot work? The above
code already make it serialized in one call, right? What do I miss here?

Thanks.

>=20
> To eliminate kconfig warnings, other methods could be considered:
>=20
> 2. Split hugetlb parallelization into a separate kconfig.
> 3. Wrap hugetlb parallelization with SMP or PADATA macros (already =
ruled out).
> 4. Split PADATA into PADATA_SERIALIZED and PADATA_MULTITHREADED (too =
heavy).
>=20
> Anyway, this is only FYI. I will continue exploring how to =
deparallelize
> "Running Serialized Jobs."


