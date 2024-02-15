Return-Path: <linux-kernel+bounces-66714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA76856092
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:02:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDAB81F247F4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44F9128806;
	Thu, 15 Feb 2024 10:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vm9wgtZz"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B66912F367
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 10:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707994227; cv=none; b=fcAG5gHHcuxoN+olLD2UcqhJhgHVdb/h4HuFKJyNoqCMc7s/EfuCAmX88x9Ax2G70p0DCOKpcaAMtjEBggG20LDmG8iko8tnW/w2g2dqqgkjSBJ+Rl6acwgSl5KBMQTmJY33KTxpNaAwu/yGH/3YhuChSu1YMkvNK1rIixSGxms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707994227; c=relaxed/simple;
	bh=qMYEWneeTS1e+IMgvbdElteGWUWNf/LO/YAa5yYNKbk=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=tvK98sDVDk9ZxzdB9Cc0+9Kla3GD7GqLMm24G5scRwUPjmQvImLT+Megk3RWG8kPYswG5GuIaPtJV+Mb0+X5H9scmzfkKEiGU15PIpj02ys51m3OkLtHVhV4XffuY8n1aPJigZoWhsmenY2uFe8c1jxV6/lN90grdXXVt2cOfxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Vm9wgtZz; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain; charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707994222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tDrgJC7hzHurmZ2XnlYtAZDoBfMM4U/XsubK9yFFoCo=;
	b=Vm9wgtZzKYFyuphTro/pr6m6ImxEcuFX8SzrfmEdR+feYaOKmgKKECxQGgT9bJW4r6pZup
	eydUOoFabVf9XQeh1ayo4PdPDH2Gf/rzyEZT4MWldGjqa8jZwVDAIZg9QTGVulWBHGuZ9e
	1z/zZ/u+0jZlbvLzPbozgmThbZqveu8=
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v1 1/2] padata: downgrade padata_do_multithreaded to serial execution for non-SMP
Date: Thu, 15 Feb 2024 18:49:46 +0800
Message-Id: <05F7392A-FCC9-48E3-92B3-3A43A9D0C987@linux.dev>
References: <146c8a41-8864-4cff-80ce-173812441844@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Daniel Jordan <daniel.m.jordan@oracle.com>, Jane Chu <jane.chu@oracle.com>,
 "Paul E . McKenney" <paulmck@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, kernel test robot <lkp@intel.com>,
 Gang Li <ligang.bdlg@bytedance.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
In-Reply-To: <146c8a41-8864-4cff-80ce-173812441844@linux.dev>
To: Gang Li <gang.li@linux.dev>
X-Migadu-Flow: FLOW_OUT



> On Feb 13, 2024, at 23:15, Gang Li <gang.li@linux.dev> wrote:
>=20
> =EF=BB=BF
>=20
>> On 2024/2/13 22:52, Muchun Song wrote:
>>> On 2024/2/13 19:13, Gang Li wrote:
>>> Randy Dunlap and kernel test robot reported a warning:
>>>=20
>>> ```
>>> WARNING: unmet direct dependencies detected for PADATA
>>>    Depends on [n]: SMP [=3Dn]
>>>    Selected by [y]:
>>>    - HUGETLBFS [=3Dy] && (X86 [=3Dy] || SPARC64 || ARCH_SUPPORTS_HUGETLB=
FS [=3Dn] || BROKEN [=3Dn]) && (SYSFS [=3Dy] || SYSCTL [=3Dn])
>>> ```
>>>=20
>>> hugetlb parallelization depends on PADATA, and PADATA depends on SMP.
>>>=20
>>> PADATA consists of two distinct functionality: One part is
>>> padata_do_multithreaded which disregards order and simply divides
>>> tasks into several groups for parallel execution. Hugetlb
>>> init parallelization depends on padata_do_multithreaded.
>>>=20
>>> The other part is composed of a set of APIs that, while handling data in=

>>> an out-of-order parallel manner, can eventually return the data with
>>> ordered sequence. Currently Only `crypto/pcrypt.c` use them.
>>>=20
>>> All users of PADATA of non-SMP case currently only use
>>> padata_do_multithreaded. It is easy to implement a serial one in
>>> include/linux/padata.h. And it is not necessary to implement another
>>> functionality unless the only user of crypto/pcrypt.c does not depend on=

>>> SMP in the future.
>>>=20
>>> Fixes: a2cefb08be66 ("hugetlb: have CONFIG_HUGETLBFS select CONFIG_PADAT=
A")
>>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
>>> Closes: https://lore.kernel.org/lkml/ec5dc528-2c3c-4444-9e88-d2c48395b43=
3@infradead.org/
>>> Reported-by: kernel test robot <lkp@intel.com>
>>> Closes: https://lore.kernel.org/oe-kbuild-all/202402020454.6EPkP1hi-lkp@=
intel.com/
>>> Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
>>> ---
>>>   fs/Kconfig             |  2 +-
>>>   include/linux/padata.h | 13 +++++++++----
>>>   2 files changed, 10 insertions(+), 5 deletions(-)
>>>=20
>>> diff --git a/fs/Kconfig b/fs/Kconfig
>>> index 4a51331f172e5..7963939592d70 100644
>>> --- a/fs/Kconfig
>>> +++ b/fs/Kconfig
>>> @@ -261,7 +261,7 @@ menuconfig HUGETLBFS
>>>       depends on X86 || SPARC64 || ARCH_SUPPORTS_HUGETLBFS || BROKEN
>>>       depends on (SYSFS || SYSCTL)
>>>       select MEMFD_CREATE
>>> -    select PADATA
>>> +    select PADATA if SMP
>> I'd like to drop this dependence since HugeTLB does not depend
>> on PADATA anymore. If some users take care about the kernel
>> image size, it also can disable PADATA individually.
>=20
> Only CRYPTO_PCRYPT, HUGETLBFS and DEFERRED_STRUCT_PAGE_INIT select
> PADATA. If drop this dependence, hugetlb init parallelization may not
> work at all.

Oh, right. In this case, maybe current choice is better.

>=20
> Maybe we can set PADATA enabled on default?
>=20
>>>       help
>>>         hugetlbfs is a filesystem backing for HugeTLB pages, based on
>>>         ramfs. For architectures that support it, say Y here and read
>>> diff --git a/include/linux/padata.h b/include/linux/padata.h
>>> index 8f418711351bc..7b84eb7d73e7f 100644
>>> --- a/include/linux/padata.h
>>> +++ b/include/linux/padata.h
>>> @@ -180,10 +180,6 @@ struct padata_instance {
>>>   #ifdef CONFIG_PADATA
>>>   extern void __init padata_init(void);
>>> -#else
>>> -static inline void __init padata_init(void) {}
>>> -#endif
>>> -
>>>   extern struct padata_instance *padata_alloc(const char *name);
>>>   extern void padata_free(struct padata_instance *pinst);
>>>   extern struct padata_shell *padata_alloc_shell(struct padata_instance *=
pinst);
>>> @@ -194,4 +190,13 @@ extern void padata_do_serial(struct padata_priv *pa=
data);
>>>   extern void __init padata_do_multithreaded(struct padata_mt_job *job);=

>>>   extern int padata_set_cpumask(struct padata_instance *pinst, int cpuma=
sk_type,
>>>                     cpumask_var_t cpumask);
>>> +#else
>>> +static inline void __init padata_init(void) {}
>>> +static inline void __init padata_do_multithreaded(struct padata_mt_job *=
job)
>>> +{
>>> +    if (job->size)
>> I think we could drop this check, at least now there is no users will
>> pass a zero of ->size to this function, and even if someone does in the
>> future, I think it is really a corner case, it is unnecessary to optimize=

>> it and ->thread_fn is supporsed to handle case of zero size if it dose
>> pass a zero size.
>> Thanks.
>>> +        job->thread_fn(job->start, job->start + job->size, job->fn_arg)=
;
>>> +}
>>> +#endif
>>> +
>>>   #endif

