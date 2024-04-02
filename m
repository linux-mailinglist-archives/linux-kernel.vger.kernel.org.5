Return-Path: <linux-kernel+bounces-127245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E698948AE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 03:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1821E1C219CE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9D2DDA9;
	Tue,  2 Apr 2024 01:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Wk/I++s7"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BEB8BEC
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 01:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712021206; cv=none; b=nRhiniukTbVIx2gEquYKh4ZWMr8FQmaABsYIGIHBFF/qsfHdIOUmKMmVYmwCyHyAT8JxR43VBu8DWJy8FVTEWsyn5qxt+KnTveYDrAJPaRqr+7vGzeDMfAJylibkmNF3QjxcxqZqdIqjz2FN3iyXruWR+SROUWVtlArQiSBhHv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712021206; c=relaxed/simple;
	bh=aVxgl65qe63F9RG61q5/c/8ucEYTRdx9vtPoLeH3Y2k=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=lMHT4BJKGQ+Uj8AfEk/c/LATNdzdiFeNzIhLDLFO1KO4TW+sZ8WgnswWWfjuIgN6RgtRvMjPfoR8vPRATivMfQw3atj/LZkh9ySN7zWCSdOdnBIbp/6RnrMbft4fNpADF6hH0rhp4OSM6c/b0Fl0poEOg0NAIDEqAO5pbu9fop8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Wk/I++s7; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-789dbd9a6f1so335280185a.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 18:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1712021203; x=1712626003; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R2O8HEb1FethHT20zhCThThb/BGPO8YtMtgX7GfGVZI=;
        b=Wk/I++s7wtaQ/2FeEcZ38+tZpZp1W1jPudHa22FhK2Udi6xUU0Le9ilyyu2e5ca56f
         sZTeM6lKEGBaGNN6qmjKv/gxRA/e9dyIusCcDaQecnFRRuaPBnOTM1f6AwUwx42CHzxJ
         y9F1LJdJWwMi5lAOcrviZfuMxaFFZkTMFcasPSWmm2+EP1815JEJYvnWVIHaMIutXqC+
         V+LO/zNlbCsDVTxq9eWDgi3zYUXBfHSstT9HigmwXnzVYxh8lZioolkSoZsEojV1wGGX
         cmR7yfv2ajFGhqAr2iC9CZNS/dUs0WQY07vlVDXKGDxd2tqQb6v89ncIc/NNvWJcyByx
         FYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712021203; x=1712626003;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R2O8HEb1FethHT20zhCThThb/BGPO8YtMtgX7GfGVZI=;
        b=prEjaQWQFfg8HX0nNQOn2nUDMqFukV/nESaAnP3dWVpSxFiOxzfyJvdJKFH4NYZs1P
         p4vdUoh1rrlqoA30ILuwBgB/5DKgPVzR2WC6CPMbCy+DidL3vKqRDoewOE/YuYXtEGjO
         JUOR+OJm+E9qitGGxckT34BpHfajpLqb4izIRVXrOHmq4tG3Jt592FNgJCTWbKKdqIum
         Q2mPa67L3SiQVE9nTA7c7J82LnMEMrPEbzMv8KJq5e6JYM6BszNYUapihd49JlOwY9UA
         fBHQOPZX6GRRmBvu+ioxOOmrbbbQlBYQn0lfF8mrNoo3DtDbGtHATFC6ArcRVaDJcsJC
         u8FA==
X-Forwarded-Encrypted: i=1; AJvYcCXGZkj2IRKqhnwanhzrCu+3g0xxZJwPx7nAcY5a6EH1mVwt5RQVCGTliTVvOhsQS3mg85Oy0toPLcF8JT4eI1h8CYiVqC6AGUV7hJP2
X-Gm-Message-State: AOJu0Yz0J0hxFFtGyAvsHT2hYVcGjrF68D50gNFfNLmIE2ws8nr7R8K2
	6lXJXObWZj6H20oBJihW52T1CnTmeCsrnlK+JOv8mOKXIm5qYouP6wxVSreDIw==
X-Google-Smtp-Source: AGHT+IE++PDnPsCAN5ZlJzJBCsY9VL8rWCNTNagzE8bvtbG+6yPqmGk0WcKC3DLF/KWvtXLzI6otLg==
X-Received: by 2002:ad4:404f:0:b0:699:1026:c0a4 with SMTP id r15-20020ad4404f000000b006991026c0a4mr2755001qvp.38.1712021202974;
        Mon, 01 Apr 2024 18:26:42 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id fn3-20020ad45d63000000b00696934de5f7sm4964016qvb.62.2024.04.01.18.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 18:26:42 -0700 (PDT)
Date: Mon, 01 Apr 2024 21:26:42 -0400
Message-ID: <18dfbc23f04422e88993a13ff15b6229@paul-moore.com>
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
Cc: linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, fsverity@lists.linux.dev, linux-block@vger.kernel.org, dm-devel@lists.linux.dev, audit@vger.kernel.org, linux-kernel@vger.kernel.org, Deven Bowers <deven.desai@linux.microsoft.com>, Fan Wu <wufan@linux.microsoft.com>
Subject: Re: [PATCH v16 11/20] block|security: add LSM blob to block_device
References: <1711657047-10526-12-git-send-email-wufan@linux.microsoft.com>
In-Reply-To: <1711657047-10526-12-git-send-email-wufan@linux.microsoft.com>

On Mar 28, 2024 Fan Wu <wufan@linux.microsoft.com> wrote:
> 
> Some block devices have valuable security properties that is only
> accessible during the creation time.

You should mention the new hook in the subject line, something like
the following: "block,lsm: add LSM blob and new LSM hook for block
devices".

> For example, when creating a dm-verity block device, the dm-verity's
> roothash and roothash signature, which are extreme important security
> metadata, are passed to the kernel. However, the roothash will be saved
> privately in dm-verity, which prevents the security subsystem to easily
> access that information. Worse, in the current implementation the
> roothash signature will be discarded after the verification, making it
> impossible to utilize the roothash signature by the security subsystem.
> 
> With this patch, an LSM blob is added to the block_device structure.
> This enables the security subsystem to store security-sensitive data
> related to block devices within the security blob. For example, LSM can
> use the new LSM blob to save the roothash signature of a dm-verity,
> and LSM can make access decision based on the data inside the signature,
> like the signer certificate.
> 
> The implementation follows the same approach used for security blobs in
> other structures like struct file, struct inode, and struct superblock.
> The initialization of the security blob occurs after the creation of the
> struct block_device, performed by the security subsystem. Similarly, the
> security blob is freed by the security subsystem before the struct
> block_device is deallocated or freed.
> 
> This patch also introduces a new hook to save block device's integrity
> data. For example, for dm-verity, LSMs can use this hook to save
> the roothash signature of a dm-verity into the security blob,
> and LSMs can make access decisions based on the data inside
> the signature, like the signer certificate.
> 
> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> ---
> v2:
>   + No Changes
> 
> v3:
>   + Minor style changes from checkpatch --strict
> 
> v4:
>   + No Changes
> 
> v5:
>   + Allow multiple callers to call security_bdev_setsecurity
> 
> v6:
>   + Simplify security_bdev_setsecurity break condition
> 
> v7:
>   + Squash all dm-verity related patches to two patches,
>     the additions to dm-verity/fs, and the consumption of
>     the additions.
> 
> v8:
>   + Split dm-verity related patches squashed in v7 to 3 commits based on
>     topic:
>       + New LSM hook
>       + Consumption of hook outside LSM
>       + Consumption of hook inside LSM.
> 
>   + change return of security_bdev_alloc / security_bdev_setsecurity
>     to LSM_RET_DEFAULT instead of 0.
> 
>   + Change return code to -EOPNOTSUPP, bring inline with other
>     setsecurity hooks.
> 
> v9:
>   + Add Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
>   + Remove unlikely when calling LSM hook
>   + Make the security field dependent on CONFIG_SECURITY
> 
> v10:
>   + No changes
> 
> v11:
>   + No changes
> 
> v12:
>   + No changes
> 
> v13:
>   + No changes
> 
> v14:
>   + No changes
> 
> v15:
>   + Drop security_bdev_setsecurity() for new hook
>     security_bdev_setintegrity() in the next commit
>   + Update call_int_hook() for 260017f
> 
> v16:
>   + Drop Reviewed-by tag for the new changes
>   + Squash the security_bdev_setintegrity() into this commit
>   + Rename enum from lsm_intgr_type to lsm_integrity_type
>   + Switch to use call_int_hook() for bdev_setintegrity()
>   + Correct comment
>   + Fix return in security_bdev_alloc()
> ---
>  block/bdev.c                  |  7 +++
>  include/linux/blk_types.h     |  3 ++
>  include/linux/lsm_hook_defs.h |  5 ++
>  include/linux/lsm_hooks.h     |  1 +
>  include/linux/security.h      | 26 ++++++++++
>  security/security.c           | 89 +++++++++++++++++++++++++++++++++++
>  6 files changed, 131 insertions(+)



> diff --git a/include/linux/security.h b/include/linux/security.h
> index f35af7b6cfba..8e646189740e 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -1483,6 +1492,23 @@ static inline int lsm_fill_user_ctx(struct lsm_ctx __user *uctx,
>  {
>  	return -EOPNOTSUPP;
>  }
> +
> +static inline int security_bdev_alloc(struct block_device *bdev)
> +{
> +	return 0;
> +}
> +
> +static inline void security_bdev_free(struct block_device *bdev)
> +{
> +}
> +
> +static inline int security_bdev_setintegrity(struct block_device *bdev,
> +					     enum lsm_integrity_type, type,

I'm sure by now you've seen the reports about the errant comma ...

> +					     const void *value, size_t size)
> +{
> +	return 0;
> +}
> +
>  #endif	/* CONFIG_SECURITY */

--
paul-moore.com

