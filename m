Return-Path: <linux-kernel+bounces-104866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F1287D4C3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18B481F23991
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D355537E9;
	Fri, 15 Mar 2024 19:59:31 +0000 (UTC)
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED9F5336A;
	Fri, 15 Mar 2024 19:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.63.66.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710532770; cv=none; b=N+hjjk2J735f+kFwj0mIbv/NWFNEULdQt7uVGvP+uXfP7jNuJQpiJebh9x+Xnqtle6kBfUqpRXrRr4qzAaMEjYn4DGKwlHN/RjGILDWeqKG3ZJvCoG55APXzz1XcXcrjd5rGLqszQdoqy+dbD0oQ4IpHVBrg78G6KnbjHQh4FVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710532770; c=relaxed/simple;
	bh=oUmhpF7xElrNNw84e7vQKqO0uKdLUyu+P4YirT7F+JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=malDPbQVC/DdLyHrPTOvuHXC0d3geWyc5/Tfssgw2ZMgrQgw74/83oX8HBhvCF7KoUrR/gCCuEywAV0N4Vztkr/AMx2LSVcZjjKi/u4GI8RfHryCM+M8WFXzOeeUSjk66qMdAMMpI3K1Du+8dhqu2M0LrShfMTWUXOE8LiH96PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com; spf=pass smtp.mailfrom=hallyn.com; arc=none smtp.client-ip=178.63.66.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hallyn.com
Received: from serge-l-PF3DENS3 (unknown [72.163.2.238])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: serge)
	by mail.hallyn.com (Postfix) with ESMTPSA id 8AAB0888;
	Fri, 15 Mar 2024 14:59:21 -0500 (CDT)
Date: Fri, 15 Mar 2024 14:59:19 -0500
From: Serge Hallyn <serge@hallyn.com>
To: Christian =?iso-8859-1?Q?G=F6ttsche?= <cgzones@googlemail.com>
Cc: linux-security-module@vger.kernel.org, linux-block@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	John Johansen <john.johansen@canonical.com>,
	James Morris <jmorris@namei.org>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Christian Brauner <brauner@kernel.org>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Khadija Kamran <kamrankhadijadj@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	apparmor@lists.ubuntu.com, selinux@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH 01/10] capability: introduce new capable flag
 CAP_OPT_NOAUDIT_ONDENY
Message-ID: <ZfSol9llgsKWj1p9@serge-l-PF3DENS3>
References: <20240315113828.258005-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240315113828.258005-1-cgzones@googlemail.com>

On Fri, Mar 15, 2024 at 12:37:22PM +0100, Christian Göttsche wrote:
> Introduce a new capable flag, CAP_OPT_NOAUDIT_ONDENY, to not generate
> an audit event if the requested capability is not granted.  This will be
> used in a new capable_any() functionality to reduce the number of
> necessary capable calls.
> 
> Handle the flag accordingly in AppArmor and SELinux.
> 
> CC: linux-block@vger.kernel.org
> Suggested-by: Paul Moore <paul@paul-moore.com>
> Signed-off-by: Christian Göttsche <cgzones@googlemail.com>

Thanks.

Reviewed-by: Serge Hallyn <serge@hallyn.com>

> ---
> v5:
>    rename flag to CAP_OPT_NOAUDIT_ONDENY, suggested by Serge:
>      https://lore.kernel.org/all/20230606190013.GA640488@mail.hallyn.com/
> ---
>  include/linux/security.h       |  2 ++
>  security/apparmor/capability.c |  8 +++++---
>  security/selinux/hooks.c       | 14 ++++++++------
>  3 files changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 41a8f667bdfa..c60cae78ff8b 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -70,6 +70,8 @@ struct lsm_ctx;
>  #define CAP_OPT_NOAUDIT BIT(1)
>  /* If capable is being called by a setid function */
>  #define CAP_OPT_INSETID BIT(2)
> +/* If capable should audit the security request for authorized requests only */
> +#define CAP_OPT_NOAUDIT_ONDENY BIT(3)
>  
>  /* LSM Agnostic defines for security_sb_set_mnt_opts() flags */
>  #define SECURITY_LSM_NATIVE_LABELS	1
> diff --git a/security/apparmor/capability.c b/security/apparmor/capability.c
> index 9934df16c843..08c9c9a0fc19 100644
> --- a/security/apparmor/capability.c
> +++ b/security/apparmor/capability.c
> @@ -108,7 +108,8 @@ static int audit_caps(struct apparmor_audit_data *ad, struct aa_profile *profile
>   * profile_capable - test if profile allows use of capability @cap
>   * @profile: profile being enforced    (NOT NULL, NOT unconfined)
>   * @cap: capability to test if allowed
> - * @opts: CAP_OPT_NOAUDIT bit determines whether audit record is generated
> + * @opts: CAP_OPT_NOAUDIT/CAP_OPT_NOAUDIT_ONDENY bit determines whether audit
> + *	record is generated
>   * @ad: audit data (MAY BE NULL indicating no auditing)
>   *
>   * Returns: 0 if allowed else -EPERM
> @@ -126,7 +127,7 @@ static int profile_capable(struct aa_profile *profile, int cap,
>  	else
>  		error = -EPERM;
>  
> -	if (opts & CAP_OPT_NOAUDIT) {
> +	if ((opts & CAP_OPT_NOAUDIT) || ((opts & CAP_OPT_NOAUDIT_ONDENY) && error)) {
>  		if (!COMPLAIN_MODE(profile))
>  			return error;
>  		/* audit the cap request in complain mode but note that it
> @@ -143,7 +144,8 @@ static int profile_capable(struct aa_profile *profile, int cap,
>   * @subj_cred: cred we are testing capability against
>   * @label: label being tested for capability (NOT NULL)
>   * @cap: capability to be tested
> - * @opts: CAP_OPT_NOAUDIT bit determines whether audit record is generated
> + * @opts: CAP_OPT_NOAUDIT/CAP_OPT_NOAUDIT_ONDENY bit determines whether audit
> + *	record is generated
>   *
>   * Look up capability in profile capability set.
>   *
> diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> index 3448454c82d0..1a2c7c1a89be 100644
> --- a/security/selinux/hooks.c
> +++ b/security/selinux/hooks.c
> @@ -1624,7 +1624,7 @@ static int cred_has_capability(const struct cred *cred,
>  	u16 sclass;
>  	u32 sid = cred_sid(cred);
>  	u32 av = CAP_TO_MASK(cap);
> -	int rc;
> +	int rc, rc2;
>  
>  	ad.type = LSM_AUDIT_DATA_CAP;
>  	ad.u.cap = cap;
> @@ -1643,11 +1643,13 @@ static int cred_has_capability(const struct cred *cred,
>  	}
>  
>  	rc = avc_has_perm_noaudit(sid, sid, sclass, av, 0, &avd);
> -	if (!(opts & CAP_OPT_NOAUDIT)) {
> -		int rc2 = avc_audit(sid, sid, sclass, av, &avd, rc, &ad);
> -		if (rc2)
> -			return rc2;
> -	}
> +	if ((opts & CAP_OPT_NOAUDIT) || ((opts & CAP_OPT_NOAUDIT_ONDENY) && rc))
> +		return rc;
> +
> +	rc2 = avc_audit(sid, sid, sclass, av, &avd, rc, &ad);
> +	if (rc2)
> +		return rc2;
> +
>  	return rc;
>  }
>  
> -- 
> 2.43.0
> 
> 

