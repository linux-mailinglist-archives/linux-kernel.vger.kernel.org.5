Return-Path: <linux-kernel+bounces-22688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE6D82A19E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73559B260A7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E50B4EB28;
	Wed, 10 Jan 2024 19:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3fJXjHd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56BB4E1BA;
	Wed, 10 Jan 2024 19:55:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7E5C433C7;
	Wed, 10 Jan 2024 19:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704916530;
	bh=KwO40mF2TaGoN9OywGDTZ0ebE2f6XtctCT+Z4+jxzak=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=U3fJXjHdIbN5pHeqJe99LWZstSLQomhmaZKWvn8P4G9sF0cCXE+MEV/W3mUYiEzhI
	 +R5ZoG/uPY2cUchRVtyDdPQVpwi9uNj/sWgmJ1y3bwS1ycrTfK66BjmN48RniJrpK5
	 XTWrQCDXo9wUjHBOFJIsLPJepaqkqlYl8Lj9xiu8yGYiO3UzOLYbLfH6PSC+6cjxR/
	 s9gltdJ523USV1DL0Ily/xIyv9G6aMHgIFALMQSVt899aCyVXZUuS2+/CRKTaELt+D
	 uasHmHF9U8uY4QdKzdepD8N5yL+3GTm6htCVv/ePcjhzO416aJUjuOvLB0wVWbrzmb
	 oHp31IMyt04jg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Jan 2024 21:55:24 +0200
Message-Id: <CYBAGUN08GGW.1WHQOHZ7XUHL9@suppilovahvero>
To: "Haitao Huang" <haitao.huang@linux.intel.com>,
 <dave.hansen@linux.intel.com>, <tj@kernel.org>, <mkoutny@suse.com>,
 <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
 <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
 <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
 <sohil.mehta@intel.com>
Cc: <zhiquan1.li@intel.com>, <kristen@linux.intel.com>, <seanjc@google.com>,
 <zhanb@microsoft.com>, <anakrish@microsoft.com>,
 <mikko.ylinen@linux.intel.com>, <yangjie@microsoft.com>
Subject: Re: [PATCH v6 01/12] cgroup/misc: Add per resource callbacks for
 CSS events
From: "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.15.2
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
 <20231030182013.40086-2-haitao.huang@linux.intel.com>
 <CWZO1RHFPIS6.P82WIOYW54YP@kernel.org>
 <op.2g9gcoz5wjvjmi@hhuan26-mobl.amr.corp.intel.com>
In-Reply-To: <op.2g9gcoz5wjvjmi@hhuan26-mobl.amr.corp.intel.com>

On Tue Jan 9, 2024 at 5:37 AM EET, Haitao Huang wrote:
> On Wed, 15 Nov 2023 14:25:59 -0600, Jarkko Sakkinen <jarkko@kernel.org> =
=20
> wrote:
>
> > On Mon Oct 30, 2023 at 8:20 PM EET, Haitao Huang wrote:
> >> From: Kristen Carlson Accardi <kristen@linux.intel.com>
> >>
> >> The misc cgroup controller (subsystem) currently does not perform
> >> resource type specific action for Cgroups Subsystem State (CSS) events=
:
> >> the 'css_alloc' event when a cgroup is created and the 'css_free' even=
t
> >> when a cgroup is destroyed.
> >>
> >> Define callbacks for those events and allow resource providers to
> >> register the callbacks per resource type as needed. This will be
> >> utilized later by the EPC misc cgroup support implemented in the SGX
> >> driver.
> >>
> >> Also add per resource type private data for those callbacks to store a=
nd
> >> access resource specific data.
> >>
> >> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> >> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
> >> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> >> ---
> >> V6:
> >> - Create ops struct for per resource callbacks (Jarkko)
> >> - Drop max_write callback (Dave, Michal)
> >> - Style fixes (Kai)
> >> ---
> >>  include/linux/misc_cgroup.h | 14 ++++++++++++++
> >>  kernel/cgroup/misc.c        | 27 ++++++++++++++++++++++++---
> >>  2 files changed, 38 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
> >> index e799b1f8d05b..5dc509c27c3d 100644
> >> --- a/include/linux/misc_cgroup.h
> >> +++ b/include/linux/misc_cgroup.h
> >> @@ -27,16 +27,30 @@ struct misc_cg;
> >>
> >>  #include <linux/cgroup.h>
> >>
> >> +/**
> >> + * struct misc_operations_struct: per resource callback ops.
> >> + * @alloc: invoked for resource specific initialization when cgroup i=
s =20
> >> allocated.
> >> + * @free: invoked for resource specific cleanup when cgroup is =20
> >> deallocated.
> >> + */
> >> +struct misc_operations_struct {
> >> +	int (*alloc)(struct misc_cg *cg);
> >> +	void (*free)(struct misc_cg *cg);
> >> +};
> >
> > Maybe just misc_operations, or even misc_ops?
> >
>
> With Michal's suggestion to make ops per-resource-type, I'll rename this =
=20
> misc_res_ops  (I was following vm_operations_struct as example)
>
> >> +
> >>  /**
> >>   * struct misc_res: Per cgroup per misc type resource
> >>   * @max: Maximum limit on the resource.
> >>   * @usage: Current usage of the resource.
> >>   * @events: Number of times, the resource limit exceeded.
> >> + * @priv: resource specific data.
> >> + * @misc_ops: resource specific operations.
> >>   */
> >>  struct misc_res {
> >>  	u64 max;
> >>  	atomic64_t usage;
> >>  	atomic64_t events;
> >> +	void *priv;
> >
> > priv is the wrong patch, it just confuses the overall picture heere.
> > please move it to 04/12. Let's deal with the callbacks here.
> >
>
> Ok
>
> >> +	const struct misc_operations_struct *misc_ops;
> >>  };
> >
> > misc_ops would be at least consistent with this, as misc_res also has a=
n
> > acronym.
> >
> >>
> >>  /**
> >> diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
> >> index 79a3717a5803..d971ede44ebf 100644
> >> --- a/kernel/cgroup/misc.c
> >> +++ b/kernel/cgroup/misc.c
> >> @@ -383,23 +383,37 @@ static struct cftype misc_cg_files[] =3D {
> >>  static struct cgroup_subsys_state *
> >>  misc_cg_alloc(struct cgroup_subsys_state *parent_css)
> >>  {
> >> +	struct misc_cg *parent_cg, *cg;
> >>  	enum misc_res_type i;
> >> -	struct misc_cg *cg;
> >> +	int ret;
> >>
> >>  	if (!parent_css) {
> >> -		cg =3D &root_cg;
> >> +		parent_cg =3D cg =3D &root_cg;
> >>  	} else {
> >>  		cg =3D kzalloc(sizeof(*cg), GFP_KERNEL);
> >>  		if (!cg)
> >>  			return ERR_PTR(-ENOMEM);
> >> +		parent_cg =3D css_misc(parent_css);
> >>  	}
> >>
> >>  	for (i =3D 0; i < MISC_CG_RES_TYPES; i++) {
> >>  		WRITE_ONCE(cg->res[i].max, MAX_NUM);
> >>  		atomic64_set(&cg->res[i].usage, 0);
> >> +		if (parent_cg->res[i].misc_ops && parent_cg->res[i].misc_ops->alloc=
) =20
> >> {
> >> +			ret =3D parent_cg->res[i].misc_ops->alloc(cg);
> >> +			if (ret)
> >> +				goto alloc_err;
> >
> > The patch set only has a use case for both operations defined - any
> > partial combinations should never be allowed.
> >
> > To enforce this invariant you could create a set of operations (written
> > out of top of my head):
> >
> > static int misc_res_init(struct misc_res *res, struct misc_ops *ops)
> > {
> > 	if (!misc_ops->alloc) {
> > 		pr_err("%s: alloc missing\n", __func__);
> > 		return -EINVAL;
> > 	}
> >
> > 	if (!misc_ops->free) {
> > 		pr_err("%s: free missing\n", __func__);
> > 		return -EINVAL;
> > 	}
> >
> > 	res->misc_ops =3D misc_ops;
> > 	return 0;
> > }
> >
> > static inline int misc_res_alloc(struct misc_cg *cg, struct misc_res =
=20
> > *res)
> > {
> > 	int ret;
> >
> > 	if (!res->misc_ops)
> > 		return 0;
> > =09
> > 	return res->misc_ops->alloc(cg);
> > }
> >
> > static inline void misc_res_free(struct misc_cg *cg, struct misc_res =
=20
> > *res)
> > {
> > 	int ret;
> >
> > 	if (!res->misc_ops)
> > 		return 0;
> > =09
> > 	return res->misc_ops->alloc(cg);
> > }
> >
> > Now if anything has misc_ops, it will also always have *both* callback,
> > and nothing half-baked gets in.
> >
> > The above loops would be then:
> >
> > 	for (i =3D 0; i < MISC_CG_RES_TYPES; i++) {
> > 		WRITE_ONCE(cg->res[i].max, MAX_NUM);
> > 		atomic64_set(&cg->res[i].usage, 0);
> > 		ret =3D misc_res_alloc(&parent_cg->res[i]);
> > 		if (ret)
> > 			goto alloc_err;
> >
> > Cleaner and better guards for state consistency. In 04/12 you need to
> > then call misc_res_init() instead of direct assignment.
> >
> > BR, Jarkko
>
> Will combine these with the use of a static operations array suggested by=
 =20
> Michal.

OK, great, thanks!

BR, Jarkko

