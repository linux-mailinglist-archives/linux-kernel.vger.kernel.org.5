Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375737ED1FA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 21:26:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbjKOU0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 15:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235683AbjKOU0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 15:26:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A501A3;
        Wed, 15 Nov 2023 12:26:05 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47D5C433C7;
        Wed, 15 Nov 2023 20:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700079965;
        bh=SOtNdL3JNKTm9VZJNKO/kZNG8OS7jX2bdSzi5ufh4lE=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=SEcG3JwWR9EHg0HanBYt9kAKoVhebzyuN8a5B/Bnjnx2gmbTSqlc5Sr68shkiBImV
         sHG41zk7Gtm7zoich93lUtwe4S6ME5fuKaEjIWg2/qCAjo2iq2xKZQA47SlfgO1Syi
         crxwNUMZRnkMvkofc/G22ogt0s2I3wDWaECpJXr9d8iguwvtXthk35q/KuJT5I+3Hg
         AcwMLM4Jdljot9Ty9Yqdo3dq3TLQUSJrrGaNwcmyFObPNdzaalds/F1UriqeBBIGyi
         uESZrM65RXUZ1BzIZIRq2UpYhBd8/4V7S/ZYoNCb8zBOGn9ZfmQGfXI7gFjqUwVmsE
         rNzWEH0zXxUJQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 15 Nov 2023 22:25:59 +0200
Message-Id: <CWZO1RHFPIS6.P82WIOYW54YP@kernel.org>
Subject: Re: [PATCH v6 01/12] cgroup/misc: Add per resource callbacks for
 CSS events
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Haitao Huang" <haitao.huang@linux.intel.com>,
        <dave.hansen@linux.intel.com>, <tj@kernel.org>, <mkoutny@suse.com>,
        <linux-kernel@vger.kernel.org>, <linux-sgx@vger.kernel.org>,
        <x86@kernel.org>, <cgroups@vger.kernel.org>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
        <sohil.mehta@intel.com>
Cc:     <zhiquan1.li@intel.com>, <kristen@linux.intel.com>,
        <seanjc@google.com>, <zhanb@microsoft.com>,
        <anakrish@microsoft.com>, <mikko.ylinen@linux.intel.com>,
        <yangjie@microsoft.com>
X-Mailer: aerc 0.15.2
References: <20231030182013.40086-1-haitao.huang@linux.intel.com>
 <20231030182013.40086-2-haitao.huang@linux.intel.com>
In-Reply-To: <20231030182013.40086-2-haitao.huang@linux.intel.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Oct 30, 2023 at 8:20 PM EET, Haitao Huang wrote:
> From: Kristen Carlson Accardi <kristen@linux.intel.com>
>
> The misc cgroup controller (subsystem) currently does not perform
> resource type specific action for Cgroups Subsystem State (CSS) events:
> the 'css_alloc' event when a cgroup is created and the 'css_free' event
> when a cgroup is destroyed.
>
> Define callbacks for those events and allow resource providers to
> register the callbacks per resource type as needed. This will be
> utilized later by the EPC misc cgroup support implemented in the SGX
> driver.
>
> Also add per resource type private data for those callbacks to store and
> access resource specific data.
>
> Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> Co-developed-by: Haitao Huang <haitao.huang@linux.intel.com>
> Signed-off-by: Haitao Huang <haitao.huang@linux.intel.com>
> ---
> V6:
> - Create ops struct for per resource callbacks (Jarkko)
> - Drop max_write callback (Dave, Michal)
> - Style fixes (Kai)
> ---
>  include/linux/misc_cgroup.h | 14 ++++++++++++++
>  kernel/cgroup/misc.c        | 27 ++++++++++++++++++++++++---
>  2 files changed, 38 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/misc_cgroup.h b/include/linux/misc_cgroup.h
> index e799b1f8d05b..5dc509c27c3d 100644
> --- a/include/linux/misc_cgroup.h
> +++ b/include/linux/misc_cgroup.h
> @@ -27,16 +27,30 @@ struct misc_cg;
> =20
>  #include <linux/cgroup.h>
> =20
> +/**
> + * struct misc_operations_struct: per resource callback ops.
> + * @alloc: invoked for resource specific initialization when cgroup is a=
llocated.
> + * @free: invoked for resource specific cleanup when cgroup is deallocat=
ed.
> + */
> +struct misc_operations_struct {
> +	int (*alloc)(struct misc_cg *cg);
> +	void (*free)(struct misc_cg *cg);
> +};

Maybe just misc_operations, or even misc_ops?

> +
>  /**
>   * struct misc_res: Per cgroup per misc type resource
>   * @max: Maximum limit on the resource.
>   * @usage: Current usage of the resource.
>   * @events: Number of times, the resource limit exceeded.
> + * @priv: resource specific data.
> + * @misc_ops: resource specific operations.
>   */
>  struct misc_res {
>  	u64 max;
>  	atomic64_t usage;
>  	atomic64_t events;
> +	void *priv;

priv is the wrong patch, it just confuses the overall picture heere.
please move it to 04/12. Let's deal with the callbacks here.

> +	const struct misc_operations_struct *misc_ops;
>  };

misc_ops would be at least consistent with this, as misc_res also has an
acronym.

> =20
>  /**
> diff --git a/kernel/cgroup/misc.c b/kernel/cgroup/misc.c
> index 79a3717a5803..d971ede44ebf 100644
> --- a/kernel/cgroup/misc.c
> +++ b/kernel/cgroup/misc.c
> @@ -383,23 +383,37 @@ static struct cftype misc_cg_files[] =3D {
>  static struct cgroup_subsys_state *
>  misc_cg_alloc(struct cgroup_subsys_state *parent_css)
>  {
> +	struct misc_cg *parent_cg, *cg;
>  	enum misc_res_type i;
> -	struct misc_cg *cg;
> +	int ret;
> =20
>  	if (!parent_css) {
> -		cg =3D &root_cg;
> +		parent_cg =3D cg =3D &root_cg;
>  	} else {
>  		cg =3D kzalloc(sizeof(*cg), GFP_KERNEL);
>  		if (!cg)
>  			return ERR_PTR(-ENOMEM);
> +		parent_cg =3D css_misc(parent_css);
>  	}
> =20
>  	for (i =3D 0; i < MISC_CG_RES_TYPES; i++) {
>  		WRITE_ONCE(cg->res[i].max, MAX_NUM);
>  		atomic64_set(&cg->res[i].usage, 0);
> +		if (parent_cg->res[i].misc_ops && parent_cg->res[i].misc_ops->alloc) {
> +			ret =3D parent_cg->res[i].misc_ops->alloc(cg);
> +			if (ret)
> +				goto alloc_err;

The patch set only has a use case for both operations defined - any
partial combinations should never be allowed.

To enforce this invariant you could create a set of operations (written
out of top of my head):

static int misc_res_init(struct misc_res *res, struct misc_ops *ops)
{
	if (!misc_ops->alloc) {
		pr_err("%s: alloc missing\n", __func__);
		return -EINVAL;
	}

	if (!misc_ops->free) {
		pr_err("%s: free missing\n", __func__);
		return -EINVAL;
	}

	res->misc_ops =3D misc_ops;
	return 0;
}

static inline int misc_res_alloc(struct misc_cg *cg, struct misc_res *res)
{
	int ret;

	if (!res->misc_ops)
		return 0;
=09
	return res->misc_ops->alloc(cg);
}

static inline void misc_res_free(struct misc_cg *cg, struct misc_res *res)
{
	int ret;

	if (!res->misc_ops)
		return 0;
=09
	return res->misc_ops->alloc(cg);
}

Now if anything has misc_ops, it will also always have *both* callback,
and nothing half-baked gets in.

The above loops would be then:

	for (i =3D 0; i < MISC_CG_RES_TYPES; i++) {
		WRITE_ONCE(cg->res[i].max, MAX_NUM);
		atomic64_set(&cg->res[i].usage, 0);
		ret =3D misc_res_alloc(&parent_cg->res[i]);
		if (ret)
			goto alloc_err;

Cleaner and better guards for state consistency. In 04/12 you need to
then call misc_res_init() instead of direct assignment.

BR, Jarkko
