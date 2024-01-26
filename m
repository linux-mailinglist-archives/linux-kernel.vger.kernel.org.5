Return-Path: <linux-kernel+bounces-40750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B0483E545
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:23:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFA7FB20CB1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF84625563;
	Fri, 26 Jan 2024 22:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NiSqF0fM"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9521CD34
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307814; cv=none; b=drXO+5H+89u4d7I5inzCVNG3QJVGUPz8PfrF0IOsxm5lOD1/5gYtZP5DYueXnQ91H1GaovipkEtkYgOt9aFJrHuTMMcbw54uAPTitWy5LodPnj/gC5zikvnad0zSdLxCSpXHq3Doj5nfVpP67hE3De9inya0GkrgHVYR2NsZ8T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307814; c=relaxed/simple;
	bh=snNBb4ZA1iemTzKjgqNBLfmnTn5JS2jZunb5rdWoIpE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dpaRT37uRB+9OTfc9bgz1jZGpQDr+4KhrU0dJ+6gcwVHxHUA0TfxQr9J2hN28g+39+MmoBOFibnOKeVjbl+aicOtNHgIDzY2tfGdH8NfICgpsVS2YZkvGeYWoA2SHkFrx5WdcVMNfNFQnGTHQFm7i+iO/3SToktROZJfcAsh2UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NiSqF0fM; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706307813; x=1737843813;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=snNBb4ZA1iemTzKjgqNBLfmnTn5JS2jZunb5rdWoIpE=;
  b=NiSqF0fMMxdeha3qtS/1V3/oHiRMqu8EZ3Ov5jFwDaorSw1wCqm5eIid
   GqICkvP+mBbXOcJpelNCHSBFMLAb5ra5ZURkzYi8uPyuhoqdTj+zJS5H1
   pU60EpgMbOE+TSNhgRLSiPhwQhHIwit7NlMY4zsDdDlCnCHWvOuQeEFBw
   gMaGYREjoWRdg3Q7/KIfsRXBIKRcYFSWrJtNmaeOTWDOh+OTeBMMagBQ0
   FB8L/t5yMg6kfYy5rOLNKQwejphXuGwFgZgN9wp6cwEgpNh+GF7ZZSwEI
   3a5SmUlW0FmHwo7es2ik7DTIadO5gO5pqRwsfBJ70uH6Y2imltjAdKN2D
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9251528"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="9251528"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 14:23:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="906436829"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="906436829"
Received: from dlberger-mobl.amr.corp.intel.com (HELO [10.209.52.191]) ([10.209.52.191])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 14:23:31 -0800
Message-ID: <7379f03364a7291770f9622b91c4d84e26352b20.camel@linux.intel.com>
Subject: Re: [PATCH v5 3/7] padata: dispatch works on different nodes
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Gang Li <gang.li@linux.dev>, David Hildenbrand <david@redhat.com>, David
 Rientjes <rientjes@google.com>, Mike Kravetz <mike.kravetz@oracle.com>,
 Muchun Song <muchun.song@linux.dev>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 ligang.bdlg@bytedance.com
Date: Fri, 26 Jan 2024 14:23:30 -0800
In-Reply-To: <20240126152411.1238072-4-gang.li@linux.dev>
References: <20240126152411.1238072-1-gang.li@linux.dev>
	 <20240126152411.1238072-4-gang.li@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-01-26 at 23:24 +0800, Gang Li wrote:
> When a group of tasks that access different nodes are scheduled on the
> same node, they may encounter bandwidth bottlenecks and access latency.
>=20
> Thus, numa_aware flag is introduced here, allowing tasks to be
> distributed across different nodes to fully utilize the advantage of
> multi-node systems.
>=20
> Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
> Tested-by: David Rientjes <rientjes@google.com>
> Reviewed-by: Muchun Song <muchun.song@linux.dev>

Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>

> ---
>  include/linux/padata.h |  2 ++
>  kernel/padata.c        | 14 ++++++++++++--
>  mm/mm_init.c           |  1 +
>  3 files changed, 15 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/padata.h b/include/linux/padata.h
> index 495b16b6b4d72..8f418711351bc 100644
> --- a/include/linux/padata.h
> +++ b/include/linux/padata.h
> @@ -137,6 +137,7 @@ struct padata_shell {
>   *             appropriate for one worker thread to do at once.
>   * @max_threads: Max threads to use for the job, actual number may be le=
ss
>   *               depending on task size and minimum chunk size.
> + * @numa_aware: Distribute jobs to different nodes with CPU in a round r=
obin fashion.
>   */
>  struct padata_mt_job {
>  	void (*thread_fn)(unsigned long start, unsigned long end, void *arg);
> @@ -146,6 +147,7 @@ struct padata_mt_job {
>  	unsigned long		align;
>  	unsigned long		min_chunk;
>  	int			max_threads;
> +	bool			numa_aware;
>  };
> =20
>  /**
> diff --git a/kernel/padata.c b/kernel/padata.c
> index 179fb1518070c..e3f639ff16707 100644
> --- a/kernel/padata.c
> +++ b/kernel/padata.c
> @@ -485,7 +485,8 @@ void __init padata_do_multithreaded(struct padata_mt_=
job *job)
>  	struct padata_work my_work, *pw;
>  	struct padata_mt_job_state ps;
>  	LIST_HEAD(works);
> -	int nworks;
> +	int nworks, nid;
> +	static atomic_t last_used_nid __initdata;
> =20
>  	if (job->size =3D=3D 0)
>  		return;
> @@ -517,7 +518,16 @@ void __init padata_do_multithreaded(struct padata_mt=
_job *job)
>  	ps.chunk_size =3D roundup(ps.chunk_size, job->align);
> =20
>  	list_for_each_entry(pw, &works, pw_list)
> -		queue_work(system_unbound_wq, &pw->pw_work);
> +		if (job->numa_aware) {
> +			int old_node =3D atomic_read(&last_used_nid);
> +
> +			do {
> +				nid =3D next_node_in(old_node, node_states[N_CPU]);
> +			} while (!atomic_try_cmpxchg(&last_used_nid, &old_node, nid));
> +			queue_work_node(nid, system_unbound_wq, &pw->pw_work);
> +		} else {
> +			queue_work(system_unbound_wq, &pw->pw_work);
> +		}
> =20
>  	/* Use the current thread, which saves starting a workqueue worker. */
>  	padata_work_init(&my_work, padata_mt_helper, &ps, PADATA_WORK_ONSTACK);
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 2c19f5515e36c..549e76af8f82a 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -2231,6 +2231,7 @@ static int __init deferred_init_memmap(void *data)
>  			.align       =3D PAGES_PER_SECTION,
>  			.min_chunk   =3D PAGES_PER_SECTION,
>  			.max_threads =3D max_threads,
> +			.numa_aware  =3D false,
>  		};
> =20
>  		padata_do_multithreaded(&job);


