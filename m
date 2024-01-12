Return-Path: <linux-kernel+bounces-24969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 062E382C567
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 19:28:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0555EB216C4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CC125624;
	Fri, 12 Jan 2024 18:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YlhyInO8"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE271AAC5
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 18:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705084079; x=1736620079;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=esm7T4hjM8QAkRTfzrz5TRd+KgY+XxGQvjLSsmczK0Q=;
  b=YlhyInO8Icx4nC02QE/+4bbAlRRHDjXSIN3RALxU0wc46FuKATfH4Siu
   CAKFDPu1ziQxCIHIRMLtNIBmbHj6ngnMAz9uHpq6CWFmgGwFFtLKs3rHP
   +2tWuWV8foImfr+nwcNvRF4pnNyAoztjOfcg13gE1msGMY9H9HrlS73JU
   b5s+tW2G7F7QIEKk6XjEf812ffKJEpWO1tqzha9YnXpeOAhV7I6GqvIxb
   jK/LmptjpfYZVW3p+jVrJTO9MCcc2CpkkfApwPI+JhVeYvMPbQNgy7BLN
   ApLmfUlNxvRxbA0GER5UE4suq12u4qfAAMmUwkcucMAc2j8cMMbZ3QpJP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10951"; a="20727411"
X-IronPort-AV: E=Sophos;i="6.04,190,1695711600"; 
   d="scan'208";a="20727411"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 10:27:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,190,1695711600"; 
   d="scan'208";a="31478061"
Received: from jarteaga-mobl1.amr.corp.intel.com (HELO [10.212.169.181]) ([10.212.169.181])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2024 10:27:57 -0800
Message-ID: <1bd6ee64a600daad58866ce684b591d39879c470.camel@linux.intel.com>
Subject: Re: [PATCH v3 3/7] padata: dispatch works on different nodes
From: Tim Chen <tim.c.chen@linux.intel.com>
To: Gang Li <gang.li@linux.dev>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Mike
 Kravetz <mike.kravetz@oracle.com>, David Rientjes <rientjes@google.com>, 
 linux-kernel@vger.kernel.org, ligang.bdlg@bytedance.com, David Hildenbrand
 <david@redhat.com>, Muchun Song <muchun.song@linux.dev>
Date: Fri, 12 Jan 2024 10:27:56 -0800
In-Reply-To: <feaf7851-f924-48f4-b16a-2fa5efdb28cf@linux.dev>
References: <20240102131249.76622-1-gang.li@linux.dev>
	 <20240102131249.76622-4-gang.li@linux.dev>
	 <1d9074955618ea0b4b155701f7c1b8b18a43fa8d.camel@linux.intel.com>
	 <feaf7851-f924-48f4-b16a-2fa5efdb28cf@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-01-12 at 15:09 +0800, Gang Li wrote:
> On 2024/1/12 01:50, Tim Chen wrote:
> > On Tue, 2024-01-02 at 21:12 +0800, Gang Li wrote:
> > > When a group of tasks that access different nodes are scheduled on th=
e
> > > same node, they may encounter bandwidth bottlenecks and access latenc=
y.
> > >=20
> > > Thus, numa_aware flag is introduced here, allowing tasks to be
> > > distributed across different nodes to fully utilize the advantage of
> > > multi-node systems.
> > >=20
> > > Signed-off-by: Gang Li <gang.li@linux.dev>
> > > ---
> > >   include/linux/padata.h | 3 +++
> > >   kernel/padata.c        | 8 ++++++--
> > >   mm/mm_init.c           | 1 +
> > >   3 files changed, 10 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/include/linux/padata.h b/include/linux/padata.h
> > > index 495b16b6b4d72..f79ccd50e7f40 100644
> > > --- a/include/linux/padata.h
> > > +++ b/include/linux/padata.h
> > > @@ -137,6 +137,8 @@ struct padata_shell {
> > >    *             appropriate for one worker thread to do at once.
> > >    * @max_threads: Max threads to use for the job, actual number may =
be less
> > >    *               depending on task size and minimum chunk size.
> > > + * @numa_aware: Dispatch jobs to different nodes. If a node only has=
 memory but
> > > + *              no CPU, dispatch its jobs to a random CPU.
> > >    */
> > >   struct padata_mt_job {
> > >   	void (*thread_fn)(unsigned long start, unsigned long end, void *ar=
g);
> > > @@ -146,6 +148,7 @@ struct padata_mt_job {
> > >   	unsigned long		align;
> > >   	unsigned long		min_chunk;
> > >   	int			max_threads;
> > > +	bool			numa_aware;
> > >   };
> > >  =20
> > >   /**
> > > diff --git a/kernel/padata.c b/kernel/padata.c
> > > index 179fb1518070c..1c2b3a337479e 100644
> > > --- a/kernel/padata.c
> > > +++ b/kernel/padata.c
> > > @@ -485,7 +485,7 @@ void __init padata_do_multithreaded(struct padata=
_mt_job *job)
> > >   	struct padata_work my_work, *pw;
> > >   	struct padata_mt_job_state ps;
> > >   	LIST_HEAD(works);
> > > -	int nworks;
> > > +	int nworks, nid =3D 0;
> >=20
> > If we always start from 0, we may be biased towards the low numbered no=
de,
> > and not use high numbered nodes at all.  Suggest you do
> > static nid =3D 0;
> >=20
>=20
> When we use `static`, if there are multiple parallel calls to
> `padata_do_multithreaded`, it may result in an uneven distribution of
> tasks for each padata_do_multithreaded.
>=20
> We can make the following modifications to address this issue.
>=20
> ```
> diff --git a/kernel/padata.c b/kernel/padata.c
> index 1c2b3a337479e..925e48df6dd8d 100644
> --- a/kernel/padata.c
> +++ b/kernel/padata.c
> @@ -485,7 +485,8 @@ void __init padata_do_multithreaded(struct=20
> padata_mt_job *job)
>          struct padata_work my_work, *pw;
>          struct padata_mt_job_state ps;
>          LIST_HEAD(works);
> -       int nworks, nid =3D 0;
> +       int nworks, nid;
> +       static volatile int global_nid =3D 0;
>=20
>          if (job->size =3D=3D 0)
>                  return;
> @@ -516,12 +517,15 @@ void __init padata_do_multithreaded(struct=20
> padata_mt_job *job)
>          ps.chunk_size =3D max(ps.chunk_size, job->min_chunk);
>          ps.chunk_size =3D roundup(ps.chunk_size, job->align);
>=20
> +       nid =3D global_nid;
>          list_for_each_entry(pw, &works, pw_list)
> -               if (job->numa_aware)
> -                       queue_work_node((++nid % num_node_state(N_MEMORY)=
),
> -                                       system_unbound_wq, &pw->pw_work);
> -               else
> +               if (job->numa_aware) {
> +                       queue_work_node(nid, system_unbound_wq,=20
> &pw->pw_work);
> +                       nid =3D next_node(nid, node_states[N_CPU]);
> +               } else
>                          queue_work(system_unbound_wq, &pw->pw_work);
> +       if (job->numa_aware)
> +               global_nid =3D nid;

Thinking more about it, there could still be multiple threads working
at the same time with stale global_nid.  We should probably do a compare
exchange of global_nid with new nid only if the global nid was unchanged.
Otherwise we should go to the next node with the changed global nid before
we queue the job.

Tim

>=20
>          /* Use the current thread, which saves starting a workqueue=20
> worker. */
>          padata_work_init(&my_work, padata_mt_helper, &ps,=20
> PADATA_WORK_ONSTACK);
> ```
>=20
>=20
> > >  =20
> > >   	if (job->size =3D=3D 0)
> > >   		return;
> > > @@ -517,7 +517,11 @@ void __init padata_do_multithreaded(struct padat=
a_mt_job *job)
> > >   	ps.chunk_size =3D roundup(ps.chunk_size, job->align);
> > >  =20
> > >   	list_for_each_entry(pw, &works, pw_list)
> > > -		queue_work(system_unbound_wq, &pw->pw_work);
> > > +		if (job->numa_aware)
> > > +			queue_work_node((++nid % num_node_state(N_MEMORY)),
> > > +					system_unbound_wq, &pw->pw_work);
> >=20
> > I think we should use nid =3D next_node(nid, node_states[N_CPU]) instea=
d of
> > ++nid % num_node_state(N_MEMORY).  You are picking the next node with C=
PU
> > to handle the job.
> >=20
> > Tim
> >=20
>=20
> I agree.


