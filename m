Return-Path: <linux-kernel+bounces-51315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7069084894F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 23:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9983DB25B6F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 22:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D344960256;
	Sat,  3 Feb 2024 22:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="J/uH5NKt"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D0517BCD
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 22:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706999120; cv=none; b=RdCRyKjCivXzJyIRqLm+w56VzzqcNWZDuYsXA9ct0SZwchgsvGonzCyNNKdAb77enbXDvqN3JDLFMEt4bBu9r2Yp02HwtCnyVq/tL6xZr/4ALZ0tjhqf+qpefnx7ccagnmE+ZibTn3Ml9Uh+aSw1C5f/30gw9TQfeV+T9dmVJkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706999120; c=relaxed/simple;
	bh=SfIYK1su40Btbzwh9h/WPttvVQMpLhlqw0vBaWGjdhM=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=OQt6uBJmYfrqv+2uVYZ9Ajk4XRpH+3L/HEh9AvG3sCWF6m8vcqPnw7RotkSMd96J+Gv8p4IBZjSyohPVXhbwgxy81r/U7sXXfwTk0qfwlelUUbhkNK7UOyBcVWoJmxRV2XZAQAp6HldujUfXt1HTQ6XkcacdhqBf/C+UU9yjXro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=J/uH5NKt; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-68c3a14c6e7so15720896d6.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 14:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1706999115; x=1707603915; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eYMBgL8MVRc+c8Obik/r6XMkhyTvtmEMtGv6GQz3E8M=;
        b=J/uH5NKt6e8BtJe+WzEKhJtKx0JwSMzdUT2qgVJMYAe9ULoNn8HtagAZDriTrETaSk
         yFhO5z+rdza1UElV6MzsQaM/dVXNBddjPclQHpmeTQYwOv+e/uVF2qV1A7AG/Ns/ncGk
         YvXNKTvF2Ox08/AmTd4RGR28Qhf7eU6ICQanjTiG+EzzE6eraAgBGMyEDPw5vgWB6z0K
         IaNqyTFieWPm5GbE6SOj5Eby/eCtfcLNX0XJNL7QLO1uq7VLvAUIj0kj6r+1D5MO07kH
         yoalB0h+4y3D4E6FwS5w5hw+23nx/uC6LqtJefUiaU2tfD4U8DRhWnSHc6eG7rDQmrsW
         +1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706999115; x=1707603915;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eYMBgL8MVRc+c8Obik/r6XMkhyTvtmEMtGv6GQz3E8M=;
        b=YBhOy4hC4DmaChGX1IJ0Ix5tXl0U/9uKm+u4bqR384T2IoM+HT+M3bKKds/I1MOA75
         lHskq3eJa4LPMEL4lLWch8yDiBXf4EcWk5WU+WoE3eTXlRexsU6zg8ynE5/8AfVgzcxc
         uAktDwQUArsBkv9iktJvjCL3gYMYFuZIyHTx/8ujauQ4JxK+yKR/huuwlZUwJ9OgfjVq
         YGeKUVKpsetmfRrt0jZz09B0iM2e4N8YBSNabYa7zsnaZoFZleb8KgINXump01GFEdoS
         457uyUf7EEhFW9K02BG0Rrrl9dQfcTRKktR+2xLVP67BJpXraxMUBQXH+zTRUpyem69u
         wIIw==
X-Gm-Message-State: AOJu0YyHq7gxMPEcqiJ0M9pvHBcMBKUYqUAf/XqffcncKQC7kz3kux48
	77YYCTbs69LsoFtGbEx0e1pFgj9EYj2scik2Pa4W7tA+RhpFeTaqlKPvbAn8MQ==
X-Google-Smtp-Source: AGHT+IFonCheK9ok4vSWJlZhijrFa0a0OwwetL207sTElMhHj+g0ohLs2URRe9XQtpkgkwCWh7FbGQ==
X-Received: by 2002:ad4:4ea1:0:b0:68c:92cb:31d1 with SMTP id ed1-20020ad44ea1000000b0068c92cb31d1mr3563850qvb.22.1706999115350;
        Sat, 03 Feb 2024 14:25:15 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVeTtSs7m2zq+X4vVccPH0Lh0uJFawcGHKNxhIksdLH3uIcDXBjnU7CFZiYLkws0aqU9yqs6KO/2dF1WPwe2mbE/wIR2jKgeYsdvQi4Cgh5cFbpr2u0pHh1j58dsGoxmrtS2VKy1TQhsd6MdZr+m0otcAq69IGsJncSYNzGlDj9ZarrbPqTmvGQzB5ttBfL9Ek9JteSJYEzdhm9NHXzIve6Lbu9X3oHaaxVEVMG9utY7OFCe1bBV2NcNtCrM53YTVBPkfW1guTVLmXV+O/Ih1o8LXBK8GWk4ltLYvN2K5aEgItmvB6FAEBYmn8CkIdY1pipwUSx6J3E5DB+NjVK++DJMplUINL2OdXHKM4sK0yZLj/OatW/uGk4ubWqf01+KC2pRcUlLF8uuaILJ2AUB8Cq+ar1NAExM2V2ydZ+XVPaBc1CDcWSv2y0JvX1mZLpReRfzWMx9tgBB+E3ScOyb439LZGVLJSksqIrns9bU1VYIb8MWW8TxRRYgQ0XHoq1bBqW9B+UrEXYzDwM2QV5R+9HQDTxYl8GbPSOj59Ps6o5YUnEpd3OqqVFIh03bXVpcDgihZ3LJSXzj830Oj5popwCoaGM24jW07UMSEaIWKdR4wJLx1gTnt2T
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id pc5-20020a056214488500b0068c968c3b33sm637500qvb.20.2024.02.03.14.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Feb 2024 14:25:14 -0800 (PST)
Date: Sat, 03 Feb 2024 17:25:14 -0500
Message-ID: <f57cb0772ff39a00ec578e178e1b8c38@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Fan Wu <wufan@linux.microsoft.com>, corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com, tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org, eparis@redhat.com
Cc: linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org, dm-devel@lists.linux.dev, audit@vger.kernel.org, linux-kernel@vger.kernel.org, Fan Wu <wufan@linux.microsoft.com>, Deven Bowers <deven.desai@linux.microsoft.com>
Subject: Re: [PATCH RFC v12 17/20] ipe: enable support for fs-verity as a trust  provider
References: <1706654228-17180-18-git-send-email-wufan@linux.microsoft.com>
In-Reply-To: <1706654228-17180-18-git-send-email-wufan@linux.microsoft.com>

On Jan 30, 2024 Fan Wu <wufan@linux.microsoft.com> wrote:
> 
> Enable IPE policy authors to indicate trust for a singular fsverity
> file, identified by the digest information, through "fsverity_digest"
> and all files using fsverity's builtin signatures via
> "fsverity_signature".
> 
> This enables file-level integrity claims to be expressed in IPE,
> allowing individual files to be authorized, giving some flexibility
> for policy authors. Such file-level claims are important to be expressed
> for enforcing the integrity of packages, as well as address some of the
> scalability issues in a sole dm-verity based solution (# of loop back
> devices, etc).
> 
> This solution cannot be done in userspace as the minimum threat that
> IPE should mitigate is an attacker downloads malicious payload with
> all required dependencies. These dependencies can lack the userspace
> check, bypassing the protection entirely. A similar attack succeeds if
> the userspace component is replaced with a version that does not
> perform the check. As a result, this can only be done in the common
> entry point - the kernel.
> 
> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> ---
> v1-v6:
>   + Not present
> 
> v7:
>   Introduced
> 
> v8:
>   * Undo squash of 08/12, 10/12 - separating drivers/md/ from security/
>   * Use common-audit function for fsverity_signature.
>   + Change fsverity implementation to use fsverity_get_digest
>   + prevent unnecessary copy of fs-verity signature data, instead
>     just check for presence of signature data.
>   + Remove free_inode_security hook, as the digest is now acquired
>     at runtime instead of via LSM blob.
> 
> v9:
>   + Adapt to the new parser
> 
> v10:
>   + Update the fsverity get digest call
> 
> v11:
>   + No changes
> 
> v12:
>   + Fix audit format
>   + Simplify property evaluation
> ---
>  security/ipe/Kconfig         |  13 +++++
>  security/ipe/audit.c         |  25 ++++++++
>  security/ipe/eval.c          | 108 ++++++++++++++++++++++++++++++++++-
>  security/ipe/eval.h          |  10 ++++
>  security/ipe/hooks.c         |  30 ++++++++++
>  security/ipe/hooks.h         |   7 +++
>  security/ipe/ipe.c           |  13 +++++
>  security/ipe/ipe.h           |   3 +
>  security/ipe/policy.h        |   3 +
>  security/ipe/policy_parser.c |   8 +++
>  10 files changed, 219 insertions(+), 1 deletion(-)
> 
> diff --git a/security/ipe/Kconfig b/security/ipe/Kconfig
> index 7afb1ce0cb99..9dd5c4769d79 100644
> --- a/security/ipe/Kconfig
> +++ b/security/ipe/Kconfig
> @@ -30,6 +30,19 @@ config IPE_PROP_DM_VERITY
>  	  that was mounted with a signed root-hash or the volume's
>  	  root hash matches the supplied value in the policy.
>  
> +	  If unsure, answer Y.
> +
> +config IPE_PROP_FS_VERITY
> +	bool "Enable property for fs-verity files"
> +	depends on FS_VERITY && FS_VERITY_BUILTIN_SIGNATURES
> +	help
> +	  This option enables the usage of properties "fsverity_signature"
> +	  and "fsverity_digest". These properties evaluates to TRUE when
> +	  a file is fsverity enabled and with a signed digest or its
> +	  diegst matches the supplied value in the policy.
> +
> +	  if unsure, answer Y.
> +
>  endmenu
>  
>  endif
> diff --git a/security/ipe/audit.c b/security/ipe/audit.c
> index a4ad8e888df0..7e3372be3214 100644
> --- a/security/ipe/audit.c
> +++ b/security/ipe/audit.c
> @@ -60,6 +60,11 @@ static const char *const audit_prop_names[__IPE_PROP_MAX] = {
>  	"dmverity_signature=FALSE",
>  	"dmverity_signature=TRUE",
>  #endif /* CONFIG_IPE_PROP_DM_VERITY */
> +#ifdef CONFIG_IPE_PROP_FS_VERITY
> +	"fsverity_digest=",
> +	"fsverity_signature=FALSE",
> +	"fsverity_signature=TRUE",
> +#endif /* CONFIG_IPE_PROP_FS_VERITY */
>  };
>  
>  #ifdef CONFIG_IPE_PROP_DM_VERITY
> @@ -79,6 +84,23 @@ static void audit_dmv_roothash(struct audit_buffer *ab, const void *rh)
>  }
>  #endif /* CONFIG_IPE_PROP_DM_VERITY */
>  
> +#ifdef CONFIG_IPE_PROP_FS_VERITY
> +/**
> + * audit_fsv_digest - audit a digest of a fsverity file.
> + * @ab: Supplies a pointer to the audit_buffer to append to.
> + * @d: Supplies a pointer to the digest structure.
> + */
> +static void audit_fsv_digest(struct audit_buffer *ab, const void *d)
> +{
> +	audit_log_format(ab, "%s", audit_prop_names[IPE_PROP_FSV_DIGEST]);
> +	ipe_digest_audit(ab, d);
> +}
> +#else
> +static void audit_fsv_digest(struct audit_buffer *ab, const void *d)
> +{
> +}
> +#endif /* CONFIG_IPE_PROP_FS_VERITY */

The related dm-verify comments also apply here.

--
paul-moore.com

