Return-Path: <linux-kernel+bounces-60252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D872850240
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 03:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A5451C23AA8
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 02:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C474F524A;
	Sat, 10 Feb 2024 02:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oFqhRojE"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8184C81
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 02:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707533177; cv=none; b=hDOD0eFZoDDCPg6XJUOV9oXF6SCca4mA4Ab4cr6B+6eubk+4TCKBo5ORVTr2lLK44TmxkMnudnO8dT7taoxpZjB20JC9jy3g4d0jAMHBjALb6ijBZllu9JWpn8JNpuFTxqFOy+SZQ5wgWbxJZB3mk7QUs/ToqoUjKn+WimAvppY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707533177; c=relaxed/simple;
	bh=t8R6ekevAs5LUra8NX8imgqzdPvZELgy7Sn2syntlWU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Cc:Date:
	 Message-Id:References:To; b=Ly69aC8tyOxxO2O+x0puwt50xz7aKRvD2hHUulZc9asAlsgy0PpLJJXrDYCO0nrwV+4D+/+boqJsU2KGcsxHA5leMvRpdASNrOkwnda1ukXYNSzPWGnSoNwNXr9cV5VLOS523R8gqDwzUkpslGCGCx/G0QOzXjmdXnMpxOxTb8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oFqhRojE; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707533172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t8R6ekevAs5LUra8NX8imgqzdPvZELgy7Sn2syntlWU=;
	b=oFqhRojEcCa+hyDQGgTk14lRssBFMFySGzTqvdSqSpeAhRiF5RHgRkzl84vpveesZuQ0ER
	uZzGGl5F5sbX6kGqfTizJMOSWmmYPcF97yHVZdHd2xc42IPl4RrPhCl9Zdu1UOHBq//N3U
	zrdsj8xHdrJS3blja0q0liYhiSuLp5A=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH 1/1] hugetlb: fix CONFIG_PADATA dependency for non-SMP system
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <86B96EE5-A51C-4F06-BB18-0B3B12DBCCEC@linux.dev>
Cc: Gang Li <ligang.bdlg@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Randy Dunlap <rdunlap@infradead.org>,
 kernel test robot <lkp@intel.com>
Date: Sat, 10 Feb 2024 10:45:35 +0800
Message-Id: <2B59E906-4CC9-4926-A893-4954587D3BCD@linux.dev>
References: <86B96EE5-A51C-4F06-BB18-0B3B12DBCCEC@linux.dev>
To: Gang Li <gang.li@linux.dev>, jane.chu@oracle.com,
 Daniel Jordan <daniel.m.jordan@oracle.com>, steffen.klassert@secunet.com
X-Migadu-Flow: FLOW_OUT


CC Jane, Daniel Jordan, Steffen as well in this thread.

> On Feb 8, 2024, at 10:39, Muchun Song <muchun.song@linux.dev> wrote:
> =EF=BB=BF
>=20
>> On Feb 5, 2024, at 16:08, Gang Li <gang.li@linux.dev> wrote:
>>=20
>> =EF=BB=BFOn 2024/2/5 15:37, Muchun Song wrote:
>>> Actually, I did not get it. Why the above code cannot work? The above
>>> code already make it serialized in one call, right? What do I miss here?=

>>> Thanks.
>>=20
>> PADATA consists of two distinct functionality:
>>=20
>> One part is `padata_do_multithreaded`, which disregards
>> order and simply divides tasks into several groups for parallel
>> execution. My patch use `padata_do_multithreaded`.
>=20
> OK. Since all users of PADATA of non-SMP case currently only use padata_do=
_multithreaded, it=E2=80=99s possible and easy to implement a variant of tha=
t in non-SMP case. It is not necessary to implement another functionality un=
less the only user of crypto/pcrypt.c does not depend on SMP in the future, a=
t least now it=E2=80=99s dependent on SMP.
>=20
> Thanks.
>=20
>>=20
>> The other part is composed of a set of APIs that, while handling data in
>> an out-of-order parallel manner, can eventually return the data with
>> ordered sequence. Only `crypto/pcrypt.c` use them. I guess these APIs
>> are designed specifically for `crypto/pcrypt.c`.
>> ```
>> padata_alloc
>> padata_alloc_shell
>> padata_do_parallel
>> padata_do_serial
>> padata_free_shell
>> padata_free
>> ```

