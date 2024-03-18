Return-Path: <linux-kernel+bounces-105601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E5A87E13E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 01:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 331FA1C20DDB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 00:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADB3125CA;
	Mon, 18 Mar 2024 00:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="AvS44cfC"
Received: from sonic304-28.consmr.mail.ne1.yahoo.com (sonic304-28.consmr.mail.ne1.yahoo.com [66.163.191.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3457E546
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 00:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.191.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710721772; cv=none; b=aDER5U97slGwrDCl3miLIubzStwoEqCWc1XqcqRYJhCIljMPTYbaOfO+OKQ6kATJlBVSUsIQ7Em9EbpicKU6sKUL0GvdopIBF8MDS5cj5ha8iq3TnnhqqinF+uS4MplnhOOMM0/7Kl8howqdZ2oCKd4p2K8G+yfCAEDrpPIlOAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710721772; c=relaxed/simple;
	bh=XDO8/d0iz2V7sZELfeXZrkyddM4LNSpiyQLIYgDR2lU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MHYq7BY858LnuJCQAfT74Ez9rc/GlQ1Il4edm7ONKdhsh81u9EHKwP/oXoD8iy/FJiniEH7bZzJORSsxL4df/X5KHdTkH8PtPNvpo+5vt/5/KthyuEGMgxXOtDPaA2AoyE8PT3wdG1g+/Z7R7N01f7hUpvXK1Q6mSGf20lJrE+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=AvS44cfC; arc=none smtp.client-ip=66.163.191.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710721762; bh=ur7+Dkhuv0fZsBGL1hE8C24/tID4EaLfwPGhqZvAJgY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=AvS44cfChNQDHKTVOFAQfgNG/A8vna6dU8MYOobY0i7HWjfsR5ZMJglv9F0HU5ocfGpqL+AphJoq0uEjrJ4calYHiMv5L/ViYpBMf+MVOH2RaCEL9D/GKBinNvbavW/A/gaieH+ncH+oZRzSL+0+mRztn/10xVg90HNGRzx4P/Dj4bZEte5eVQxA+DdQu3cWOFAmx71BOMG2r53m/1MDGp9vlIxJESSrGkbuuaXk8F8vo6yci/4rb6dbgGFS8Uz+qMYV2h0Rsq8itRFfIXtujyLXNQ6tiSEoH3/byld8U9bz7RpGCt8hZeUjELNsRzxrm8VDCavJ9n1YQg1mmOuR3Q==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1710721762; bh=7OGIpH70jZ/hB8P3wZb0f6KkrqJ6y5lJnl9p6axDTmd=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=SHqSvTJ9C5caI+YU7dNEocpRu3399l41rC85PBn/yVVdmx5//RmRtJHAmH+WDFE4v0eUPMl2OMRkOs962kgJV1u/3XsG/P6Ns8qN9SMPi2n8gAQVwVqd5PZZPBkXKxjGuwthR2XUbdQ9oMWXiRpzPmx0CIWg/6xLd56o62RR5mNGyKmHefDX19CLRMdoV9BL3zuiLYUgmLOC43PrvSkYRbzPlf5y9Misk2txdlTV63uYNH0BD+qS7CCKWguaHrXApaJqqUQwWhiM/y2v3K24hssAEO6PMfZUwovnAZvQZZAmNCPX5iHKva7Tcp3AbqLWsxl23uj7tgEoSMY2+K0hjw==
X-YMail-OSG: waeWX9kVM1kChxFe64VzLjBz9sv1R5rKfCT4V4ptBO_lda.ol45fdlkGTy4P.OF
 R_XhFht3m6K3UV48QOjt6dEAoCP.Dj9OPDxGhOjGduy9aIb6VqvOlnhfrExAiCgx_dNwGbqV6nHI
 Lg8w0pp30_Y6lJ2VeONHYhP8Cook_pd3dQhO46cazukTHlIZMIk15fbyUbvYFe4W7i98cPs7T7Kp
 cxvt19FBYl4zpq5N5p0xYuGo6nsTm__jR68eAhbVlqJ_RNMUP2aEHYCLWU9JHeP7Z7Yj2KPiVC4E
 YCCOyK7Qrx9ZAPAW4luxpPVE7YBStWoYIIa6vocGCvAoFzjL9egXHHZkxfpIokU_Am7IszUpIpQp
 Oyiu50lSC69OZEHQe_uWJfx80CFNOtnvcKAe0GhH3AJmHVZDuLPp4RFvBm3RKmJ2VZ4fik5jX1u8
 5t5BU8twOWTH0efac3HItgKZoiar2ppGdGZNWVAaJjOlLxuqOa_.fAPfFtHAjTxxCOm.xfJ38HNL
 vD4SQBkPEUAqL2Odddm0ueAY9TXmRtMhnCNOxxGNSITMsUuXjDqPL89Vrw98NCWB2vvzu7AQjxtj
 iVwb6tLBm9dxPmA6qga92Zmpy0z3U5O442u0174wwkDp3cLJ5EmXIyMOiOU8g1fdxrfXbuv7PSTn
 O9ktdwD4Rfhasl0eVEd.voxNeKM9y8qKFQOSH2wfTRPbSBPwgDcx_GT_Xner9ucrxHL8kdHWFH8p
 lj8vOAL5m.nld3q4ttrbE5o5V.H84Q9OWWqo9g39AKO5iJ3Mxb_7WcczrAUZFBFRqoSaVeFkdoFt
 iIcpr2FXyIuXbv89Z2CB8u6uGaybvpS5r723teOZR8_E0jTu8xmvTSI4AjMHm6CVmjOGCJKsxXlr
 r.K2rSYi1v2HSBbkjXdZabje1U5FyHx11Xmawf4dbCuioxWl97Yz6yGSanhTK137dZCkD5o8RESa
 CgzvSt7EpaETOB97_BX.FgDjMzm.A8oldcjPgExI5YTvU1j.fQXrw5iKq2Lo_RLSvG2q.lr0D2zN
 iWB5HBS3mdB5joadSS7EskB7sxTu6utUh83PGP3nFm0gwJ8fM63MkCMJ7r4_MHTJvhmEpZ5FWjjf
 kMrSPcs0imyt22ooV5TS7GEv1CiNbDCpCSdATLTkJ04tIwLGzK0bDPlK_ZiVXsYK3QNrilg8AwxF
 ePr9PsjzID5nxknkl_ym.LH6m03Rm_s8gzWejnPxmFUQ4a48UIUip2NRQSviAZLSUFfh_PgtbA_r
 4lYWGYuwZbH48x8Qr.iXy5FKJq4I_UcCcXVHtrJ9S010mewL4EO0svvggqnL24MDjXRr0C497XWR
 F31dag4KTXx0jmixitgWWH4vSbh3644OV6PmwDkiBKQTKuF.o5JOzDP05z0HkOGsKQuRCz8yoDkV
 YdpROOgrKpgLr8JN2YI5eTf84JKZx9gDPu0BZ61oPHK7q9AYkX59I5ll1AoXKPUfp0m6XReh6t6g
 XZph7HyV8E0.IAF5LelBFRJMRrcUwcYPaQRf2k1jfvHGYSAAmQVfbY8U1SFnpHhzsSpzwoSIFJuX
 WnXZ5kKxYqJBjasw6diSqxtjEGwdOVVNk52wUoFtfGSC5qIvJIEagVpxqRhsIbj3jPxi2f.qRpwY
 bqMqGXwoIP12aACemy5DL5ZcrTelzxdnird.IwcF9BDiznxtD28xRqSME3l8VLxRN9T_coOVIhYT
 4NVfsF8AJtP9QP319kQBIilJsFJLDG7Eb9fdaWW8RG.LEdZWSrEihSND.FwYdt_bUG5ClNCUHxFx
 QeCS1t3zl7F6MiBKPyx2Z5nlufBfrTjVyqFafmNERLWYFT2r.mlSrfvRbnvQ0fLwbShFs1xpMuVU
 cW3vSrTLj3ayjOOAL2F7KDmFOJ_lEmVgSa.cpFXttipQPRsgeeyzkZJB_yE6vDrApYbYheIF5sPz
 1efZ2e_rLD9dHgNLFUSdEKu4OjB8odHU6tJpATafJwMmLb_LGrme2uX2cBg_kGhCdaPp.tJWOmLv
 e5FRdNMFANZYjUFIXRPLeIhs4eal7j4jwY1GcUDorn2t8UB0jlN1_PNFrk1o93yRiPV5bhDylEgJ
 1fLlExIQyyI0x0f_Vull_IWVjNfyIUC1qwA3gyWcSD6WvDpmEGwejsw4MP7oWNC0xP.vE3wPAeGk
 gsWyOU1OfqXuoPuKaCFOAWtb.pQqspU7GjJ_61IhRL7lLGIoCP.InxJfhPChgU4wkKbzTjWu7L8D
 KpqzGwiJKwRR9vU2ds6GlhM5cW1pwm427KEqbEgVV9J8rM5mV6HA5st1YDa57qCg-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: 4dceb0cb-286e-4bb1-86ec-98cee84315d7
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Mon, 18 Mar 2024 00:29:22 +0000
Received: by hermes--production-gq1-5c57879fdf-p26ct (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID a7bd0b665c9e1192bb72e35953a758c0;
          Mon, 18 Mar 2024 00:29:16 +0000 (UTC)
Message-ID: <43958767-32db-4c53-8408-8367cfc14d2f@schaufler-ca.com>
Date: Sun, 17 Mar 2024 17:29:14 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v15 05/21] initramfs|security: Add a security hook to
 do_populate_rootfs()
Content-Language: en-US
To: Fan Wu <wufan@linux.microsoft.com>, corbet@lwn.net, zohar@linux.ibm.com,
 jmorris@namei.org, serge@hallyn.com, tytso@mit.edu, ebiggers@kernel.org,
 axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org, eparis@redhat.com,
 paul@paul-moore.com
Cc: linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org, fsverity@lists.linux.dev,
 linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
 audit@vger.kernel.org, linux-kernel@vger.kernel.org,
 Casey Schaufler <casey@schaufler-ca.com>
References: <1710560151-28904-1-git-send-email-wufan@linux.microsoft.com>
 <1710560151-28904-6-git-send-email-wufan@linux.microsoft.com>
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <1710560151-28904-6-git-send-email-wufan@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.22129 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 3/15/2024 8:35 PM, Fan Wu wrote:
> This patch introduces a new hook to notify security system that the
> content of initramfs has been unpacked into the rootfs.
>
> Upon receiving this notification, the security system can activate
> a policy to allow only files that originated from the initramfs to
> execute or load into kernel during the early stages of booting.
>
> This approach is crucial for minimizing the attack surface by
> ensuring that only trusted files from the initramfs are operational
> in the critical boot phase.
>
> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
>
> ---
> v1-v11:
>   + Not present
>
> v12:
>   + Introduced
>
> v13:
>   + Rename the hook name to initramfs_populated()
>
> v14:
>   + No changes
>
> v15:
>   + No changes
> ---
>  include/linux/lsm_hook_defs.h |  2 ++
>  include/linux/security.h      |  8 ++++++++
>  init/initramfs.c              |  3 +++
>  security/security.c           | 10 ++++++++++
>  4 files changed, 23 insertions(+)
>
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 334e00efbde4..7db99ae75651 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -450,3 +450,5 @@ LSM_HOOK(int, 0, uring_override_creds, const struct cred *new)
>  LSM_HOOK(int, 0, uring_sqpoll, void)
>  LSM_HOOK(int, 0, uring_cmd, struct io_uring_cmd *ioucmd)
>  #endif /* CONFIG_IO_URING */
> +
> +LSM_HOOK(void, LSM_RET_VOID, initramfs_populated, void)

This is an awfully expensive way to set a flag. Adding a LSM hook list
isn't free. Isn't there a way to capture this state change through one of
the mount hooks?

> diff --git a/include/linux/security.h b/include/linux/security.h
> index 41a8f667bdfa..14fff542f2e3 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -2255,4 +2255,12 @@ static inline int security_uring_cmd(struct io_uring_cmd *ioucmd)
>  #endif /* CONFIG_SECURITY */
>  #endif /* CONFIG_IO_URING */
>  
> +#ifdef CONFIG_SECURITY
> +extern void security_initramfs_populated(void);
> +#else
> +static inline void security_initramfs_populated(void)
> +{
> +}
> +#endif /* CONFIG_SECURITY */
> +
>  #endif /* ! __LINUX_SECURITY_H */
> diff --git a/init/initramfs.c b/init/initramfs.c
> index da79760b8be3..cc9115117896 100644
> --- a/init/initramfs.c
> +++ b/init/initramfs.c
> @@ -17,6 +17,7 @@
>  #include <linux/namei.h>
>  #include <linux/init_syscalls.h>
>  #include <linux/umh.h>
> +#include <linux/security.h>
>  
>  #include "do_mounts.h"
>  
> @@ -719,6 +720,8 @@ static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
>  #endif
>  	}
>  
> +	security_initramfs_populated();
> +
>  done:
>  	/*
>  	 * If the initrd region is overlapped with crashkernel reserved region,
> diff --git a/security/security.c b/security/security.c
> index 287bfac6b471..b10230c51c0b 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -5675,3 +5675,13 @@ int security_uring_cmd(struct io_uring_cmd *ioucmd)
>  	return call_int_hook(uring_cmd, ioucmd);
>  }
>  #endif /* CONFIG_IO_URING */
> +
> +/**
> + * security_initramfs_populated() - Notify LSMs that initramfs has been loaded
> + *
> + * Tells the LSMs the initramfs has been unpacked into the rootfs.
> + */
> +void security_initramfs_populated(void)
> +{
> +	call_void_hook(initramfs_populated);
> +}

