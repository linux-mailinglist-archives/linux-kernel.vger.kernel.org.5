Return-Path: <linux-kernel+bounces-23948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB0982B452
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 18:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D071A1C23CBB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 17:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D0FE52F78;
	Thu, 11 Jan 2024 17:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cuYCn8OR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8AC3A1BE
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 17:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704995423; x=1736531423;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=k37B20/6MiGVylaiB+EuK9zFx7XSlnopblGDxK8CxTQ=;
  b=cuYCn8ORz0b0fEgyyZ6pAMqAcpc9glbVoC/OtGihn8anvfQgwch3RIQN
   3V7Ll/SPnmm43GJEaMwerkC8tjmct8iz0hBdLUyczEIEiwUdMH5hmdudp
   aqivxl1O6EQSdhNh3wmWOsfMzcyAbpBSopsK+4loNC4XH7z04yKjGR9z/
   PN33wPfLPI5X1CqL/kS50MCBIPTr0lR8Sj8bHoQNDBhP3D2RIPF8+7b02
   8ZFlUwqRQ2k5ixhtBe4oyoxH+d26jR9i/b/9CGWCQz5UUl76rpQ/7Oa/B
   Q/0/O/vQOrp/4FFrT3izvewxkBzwuJosd4Y0P7e1GY4YJSpeley7uqU56
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="5658678"
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="5658678"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 09:50:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,186,1695711600"; 
   d="scan'208";a="24710421"
Received: from ldrake1-mobl3.amr.corp.intel.com (HELO [10.212.168.169]) ([10.212.168.169])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 09:50:21 -0800
Message-ID: <1d9074955618ea0b4b155701f7c1b8b18a43fa8d.camel@linux.intel.com>
Subject: Re: [PATCH v3 3/7] padata: dispatch works on different nodes
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Gang Li <gang.li@linux.dev>, David Hildenbrand <david@redhat.com>, David
 Rientjes <rientjes@google.com>, Mike Kravetz <mike.kravetz@oracle.com>,
 Muchun Song <muchun.song@linux.dev>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 ligang.bdlg@bytedance.com
Date: Thu, 11 Jan 2024 09:50:20 -0800
In-Reply-To: <20240102131249.76622-4-gang.li@linux.dev>
References: <20240102131249.76622-1-gang.li@linux.dev>
	 <20240102131249.76622-4-gang.li@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-01-02 at 21:12 +0800, Gang Li wrote:
> When a group of tasks that access different nodes are scheduled on the
> same node, they may encounter bandwidth bottlenecks and access latency.
>=20
> Thus, numa_aware flag is introduced here, allowing tasks to be
> distributed across different nodes to fully utilize the advantage of
> multi-node systems.
>=20
> Signed-off-by: Gang Li <gang.li@linux.dev>
> ---
>  include/linux/padata.h | 3 +++
>  kernel/padata.c        | 8 ++++++--
>  mm/mm_init.c           | 1 +
>  3 files changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/padata.h b/include/linux/padata.h
> index 495b16b6b4d72..f79ccd50e7f40 100644
> --- a/include/linux/padata.h
> +++ b/include/linux/padata.h
> @@ -137,6 +137,8 @@ struct padata_shell {
>   *             appropriate for one worker thread to do at once.
>   * @max_threads: Max threads to use for the job, actual number may be le=
ss
>   *               depending on task size and minimum chunk size.
> + * @numa_aware: Dispatch jobs to different nodes. If a node only has mem=
ory but
> + *              no CPU, dispatch its jobs to a random CPU.
>   */
>  struct padata_mt_job {
>  	void (*thread_fn)(unsigned long start, unsigned long end, void *arg);
> @@ -146,6 +148,7 @@ struct padata_mt_job {
>  	unsigned long		align;
>  	unsigned long		min_chunk;
>  	int			max_threads;
> +	bool			numa_aware;
>  };
> =20
>  /**
> diff --git a/kernel/padata.c b/kernel/padata.c
> index 179fb1518070c..1c2b3a337479e 100644
> --- a/kernel/padata.c
> +++ b/kernel/padata.c
> @@ -485,7 +485,7 @@ void __init padata_do_multithreaded(struct padata_mt_=
job *job)
>  	struct padata_work my_work, *pw;
>  	struct padata_mt_job_state ps;
>  	LIST_HEAD(works);
> -	int nworks;
> +	int nworks, nid =3D 0;

If we always start from 0, we may be biased towards the low numbered node,
and not use high numbered nodes at all.  Suggest you do
static nid =3D 0; =20

> =20
>  	if (job->size =3D=3D 0)
>  		return;
> @@ -517,7 +517,11 @@ void __init padata_do_multithreaded(struct padata_mt=
_job *job)
>  	ps.chunk_size =3D roundup(ps.chunk_size, job->align);
> =20
>  	list_for_each_entry(pw, &works, pw_list)
> -		queue_work(system_unbound_wq, &pw->pw_work);
> +		if (job->numa_aware)
> +			queue_work_node((++nid % num_node_state(N_MEMORY)),
> +					system_unbound_wq, &pw->pw_work);

I think we should use nid =3D next_node(nid, node_states[N_CPU]) instead of
++nid % num_node_state(N_MEMORY).  You are picking the next node with CPU
to handle the job.

Tim

> +		else
> +			queue_work(system_unbound_wq, &pw->pw_work);
> =20
>  	/* Use the current thread, which saves starting a workqueue worker. */
>  	padata_work_init(&my_work, padata_mt_helper, &ps, PADATA_WORK_ONSTACK);
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 89dc29f1e6c6f..59fcffddf65a3 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -2225,6 +2225,7 @@ static int __init deferred_init_memmap(void *data)
>  			.align       =3D PAGES_PER_SECTION,
>  			.min_chunk   =3D PAGES_PER_SECTION,
>  			.max_threads =3D max_threads,
> +			.numa_aware  =3D false,
>  		};
> =20
>  		padata_do_multithreaded(&job);


