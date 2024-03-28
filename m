Return-Path: <linux-kernel+bounces-123629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27341890BF2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92B50B258C7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E3C13AA23;
	Thu, 28 Mar 2024 20:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTOECzv/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F2512F385;
	Thu, 28 Mar 2024 20:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658970; cv=none; b=He3irxTyMO5MPHcsvw/Q9+M1n6zHAa6USN5HKSa+Dip1zSGwv+VjciD7xGgKlpX46wnI1Dp+CRzLb/2Ob/0BcOCcF4PtjEJZNnhuMMqo0ZL3PdHIC87/WdXUSQUHNDa3+MrbXBH1es2Kzv5QNuOuI9XeIP9+FUjxJNJzgELYYH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658970; c=relaxed/simple;
	bh=3XCMYkBoPq+Idec9DAdMOiIFbT5SeMUB/mlilzXLUWc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=BYWeYBRkvkREDsSX7iQRInSJF7FogM4ScvDHqg/b+96g72T3zYCsUrRed5E9PIf3LnkORVYia9aduwFHFA2eHVLH6RgEludsttyQiBq2W2UIL2GVZ+rMDVzRhG0U80ssrNjf4VmAWQwmii8BrAF+VERSP5/PkarzGbrL4BIC9Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTOECzv/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED608C433C7;
	Thu, 28 Mar 2024 20:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711658970;
	bh=3XCMYkBoPq+Idec9DAdMOiIFbT5SeMUB/mlilzXLUWc=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=bTOECzv/yf0h6rScIKYBe0I8AjSUM5shZNlXeItcF4aAaYsC4mWjd/EZ7t4lpuebD
	 RsUqXkYo89zrkJQzmK7yr+Jdkfj2F9q4zKHo4JwwFjujLJiltFtCCrDde041g9RWiL
	 c8cFnFVKhx9IZqspbIuJClC2UcTi0uunh7vb894Vo7y7bX8fqZaDf5YXjVtsxQhpBw
	 ogON2hGHCYWpoMGiFGfoSIbBKX5gdQ+iYtY5e/fAanEZkm5ElbYy7DzOcOe5oZ2LYA
	 zxSak7P6qMYl52azITVkbiaBsvT5VMuvhh/CV8ec8qjTucu8LDiPms5LYSRoSJNHVd
	 9n281ruKCwDIQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 28 Mar 2024 22:49:24 +0200
Message-Id: <D05OGOTS265U.1AKOJIR5TQJBF@kernel.org>
Cc: <linux-doc@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <fsverity@lists.linux.dev>,
 <linux-block@vger.kernel.org>, <dm-devel@lists.linux.dev>,
 <audit@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Deven Bowers"
 <deven.desai@linux.microsoft.com>
Subject: Re: [PATCH v16 03/20] ipe: add evaluation loop
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Fan Wu" <wufan@linux.microsoft.com>, <corbet@lwn.net>,
 <zohar@linux.ibm.com>, <jmorris@namei.org>, <serge@hallyn.com>,
 <tytso@mit.edu>, <ebiggers@kernel.org>, <axboe@kernel.dk>,
 <agk@redhat.com>, <snitzer@kernel.org>, <eparis@redhat.com>,
 <paul@paul-moore.com>
X-Mailer: aerc 0.17.0
References: <1711657047-10526-1-git-send-email-wufan@linux.microsoft.com>
 <1711657047-10526-4-git-send-email-wufan@linux.microsoft.com>
In-Reply-To: <1711657047-10526-4-git-send-email-wufan@linux.microsoft.com>

On Thu Mar 28, 2024 at 10:17 PM EET, Fan Wu wrote:
> From: Deven Bowers <deven.desai@linux.microsoft.com>
>
> IPE must have a centralized function to evaluate incoming callers
> against IPE's policy. This iteration of the policy for against the rules
> for that specific caller is known as the evaluation loop.
>
> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
>
> ---
> v2:
> + Split evaluation loop, access control hooks, and evaluation loop from p=
olicy parser and userspace interface to pass mailing list character limit
>
> v3:
> + Move ipe_load_properties to patch 04.
> + Remove useless 0-initializations Prefix extern variables with ipe_
> + Remove kernel module parameters, as these are exposed through sysctls.
> + Add more prose to the IPE base config option help text.
> + Use GFP_KERNEL for audit_log_start.
> + Remove unnecessary caching system.
> + Remove comments from headers
> + Use rcu_access_pointer for rcu-pointer null check
> + Remove usage of reqprot; use prot only.
> +Move policy load and activation audit event to 03/12
>
> v4:
> + Remove sysctls in favor of securityfs nodes
> + Re-add kernel module parameters, as these are now exposed through secur=
ityfs.
> + Refactor property audit loop to a separate function.
>
> v5:
> + fix minor grammatical errors
> + do not group rule by curly-brace in audit record,
> + reconstruct the exact rule.
>
> v6:
> + No changes
>
> v7:
> + Further split lsm creation into a separate commit from the evaluation l=
oop and audit system, for easier review.
> + Propagating changes to support the new ipe_context structure in the eva=
luation loop.
>
> v8:
> + Remove ipe_hook enumeration; hooks can be correlated via syscall record=
.
>
> v9:
> + Remove ipe_context related code and simplify the evaluation loop.
>
> v10:
> + Split eval part and boot_verified part
>
> v11:
> + Fix code style issues
>
> v12:
> + Correct an rcu_read_unlock usage
> + Add a WARN to unknown op during evaluation
>
> v13:
> + No changes
>
> v14:
> + No changes
>
> v15:
> + No changes
>
> v16:
> + No changes
> ---
>  security/ipe/Makefile |   1 +
>  security/ipe/eval.c   | 100 ++++++++++++++++++++++++++++++++++++++++++
>  security/ipe/eval.h   |  24 ++++++++++
>  3 files changed, 125 insertions(+)
>  create mode 100644 security/ipe/eval.c
>  create mode 100644 security/ipe/eval.h
>
> diff --git a/security/ipe/Makefile b/security/ipe/Makefile
> index c09aec4904f2..57fe922cf1fc 100644
> --- a/security/ipe/Makefile
> +++ b/security/ipe/Makefile
> @@ -6,6 +6,7 @@
>  #
> =20
>  obj-$(CONFIG_SECURITY_IPE) +=3D \
> +	eval.o \
>  	ipe.o \
>  	policy.o \
>  	policy_parser.o \
> diff --git a/security/ipe/eval.c b/security/ipe/eval.c
> new file mode 100644
> index 000000000000..af56815ed0fa
> --- /dev/null
> +++ b/security/ipe/eval.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) Microsoft Corporation. All rights reserved.
> + */
> +
> +#include <linux/fs.h>
> +#include <linux/types.h>
> +#include <linux/slab.h>
> +#include <linux/file.h>
> +#include <linux/sched.h>
> +#include <linux/rcupdate.h>
> +
> +#include "ipe.h"
> +#include "eval.h"
> +#include "policy.h"
> +
> +struct ipe_policy __rcu *ipe_active_policy;
> +
> +/**
> + * evaluate_property - Analyze @ctx against a property.
> + * @ctx: Supplies a pointer to the context to be evaluated.
> + * @p: Supplies a pointer to the property to be evaluated.
> + *
> + * Return:
> + * * true	- The current @ctx match the @p
> + * * false	- The current @ctx doesn't match the @p
> + */
> +static bool evaluate_property(const struct ipe_eval_ctx *const ctx,
> +			      struct ipe_prop *p)

What a descriptive name (not)

Also short descriptino tells absolute nothing relevant (as good as it
did not exist at all).

It would be also senseful to carry the prefix.


> +{
> +	return false;
> +}
> +
> +/**
> + * ipe_evaluate_event - Analyze @ctx against the current active policy.
> + * @ctx: Supplies a pointer to the context to be evaluated.
> + *
> + * This is the loop where all policy evaluation happens against IPE poli=
cy.
> + *
> + * Return:
> + * * 0		- OK
> + * * -EACCES	- @ctx did not pass evaluation.
> + * * !0		- Error
> + */
> +int ipe_evaluate_event(const struct ipe_eval_ctx *const ctx)
> +{
> +	bool match =3D false;
> +	enum ipe_action_type action;
> +	struct ipe_policy *pol =3D NULL;
> +	const struct ipe_rule *rule =3D NULL;
> +	const struct ipe_op_table *rules =3D NULL;
> +	struct ipe_prop *prop =3D NULL;
> +
> +	rcu_read_lock();
> +
> +	pol =3D rcu_dereference(ipe_active_policy);
> +	if (!pol) {
> +		rcu_read_unlock();
> +		return 0;
> +	}
> +
> +	if (ctx->op =3D=3D IPE_OP_INVALID) {
> +		if (pol->parsed->global_default_action =3D=3D IPE_ACTION_DENY) {
> +			rcu_read_unlock();
> +			return -EACCES;
> +		}
> +		if (pol->parsed->global_default_action =3D=3D IPE_ACTION_INVALID)
> +			WARN(1, "no default rule set for unknown op, ALLOW it");
> +		rcu_read_unlock();
> +		return 0;
> +	}
> +
> +	rules =3D &pol->parsed->rules[ctx->op];
> +
> +	list_for_each_entry(rule, &rules->rules, next) {
> +		match =3D true;
> +
> +		list_for_each_entry(prop, &rule->props, next) {
> +			match =3D evaluate_property(ctx, prop);
> +			if (!match)
> +				break;
> +		}
> +
> +		if (match)
> +			break;
> +	}
> +
> +	if (match)
> +		action =3D rule->action;
> +	else if (rules->default_action !=3D IPE_ACTION_INVALID)
> +		action =3D rules->default_action;
> +	else
> +		action =3D pol->parsed->global_default_action;
> +
> +	rcu_read_unlock();
> +	if (action =3D=3D IPE_ACTION_DENY)
> +		return -EACCES;
> +
> +	return 0;
> +}
> diff --git a/security/ipe/eval.h b/security/ipe/eval.h
> new file mode 100644
> index 000000000000..6b434515968f
> --- /dev/null
> +++ b/security/ipe/eval.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) Microsoft Corporation. All rights reserved.
> + */
> +
> +#ifndef _IPE_EVAL_H
> +#define _IPE_EVAL_H
> +
> +#include <linux/file.h>
> +#include <linux/types.h>
> +
> +#include "policy.h"
> +
> +extern struct ipe_policy __rcu *ipe_active_policy;
> +
> +struct ipe_eval_ctx {
> +	enum ipe_op_type op;
> +
> +	const struct file *file;
> +};
> +
> +int ipe_evaluate_event(const struct ipe_eval_ctx *const ctx);
> +
> +#endif /* _IPE_EVAL_H */

BR, Jarkko

