Return-Path: <linux-kernel+bounces-108222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A801F8807FD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E7062842C0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF51D60262;
	Tue, 19 Mar 2024 23:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eelzPzGL"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D54C5FB91
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 23:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710889244; cv=none; b=X5UH3ii8QY33hfNjNU7rqI/TmvP4jPep2eF9ZkEAwssTHVdjjQHKBJyKmnRvwkC+nxyj+8r+KxTXnWptSevVpSjS9XYWWYT/x2P/EnohbBLCXaetfnW6iysLgb9zSxSOrbUnPDokvUfWA8ywfCBxt3zcT3tjNpzz5U5UJYPmXf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710889244; c=relaxed/simple;
	bh=QZfv3icIZ4/CHhSSd6nbOzwCM9N27jDWNszmTRrZFDg=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=nqMn+O3WZAiewdkkz+E52n+NHsb3e3mx62i6bh4jv6eHkUWFf4tS31BYHM/FwyYtJ8SQucehyZtOdw43oi6wv3H41PniV0yUCDWe15jztOhmNYLPdsuAX87Uf51CmFd9tuCzjgHZqiZWiQNivtt8EzEDrBIXjTnzFUfVmF0FgME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eelzPzGL; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-78a01a3012aso183695285a.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710889240; x=1711494040; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zcXhR188v6exmS7H92imlEAx9k7OrrEpyfgcmj4MXK8=;
        b=eelzPzGLkjfwA6FpWGZMyLpzBdczbjpojkCHOs78511Hz9cc0SNLk4pa99vGtN7bEk
         xMv+fXB5gkPrDvMVH7o6bZ7snmB30gmsYYAba9Vj7/xXVnITSf1u27G9xk9vpztjyXFH
         ME5yKwKJRsMuwT+M0sahV48r9bBuVZpk6Ralt9PJNj8WUbYzEX43B3TDf3TvSTzMx1Ww
         2Cl7A3g20zSEb7FjSnFs+ztZ284zh60xUccvYi2saDbMRmLiygFgya9oAH1hp34ct5R/
         WUrrP1/FT/11qaXZsejFDgYea5D4jBrlhHds1/dpOCCXOS0JMTiMapQ0gROZmZJ/CO2O
         Ud3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710889240; x=1711494040;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zcXhR188v6exmS7H92imlEAx9k7OrrEpyfgcmj4MXK8=;
        b=EZfkbs8OOsy72ym0h+k8y6mzYGt49a3OMxpXd9MdCrkjgV6sJ8OzDlvAu7buFr1fV0
         uzLdHVjWyZ664Ji6HOVqLAwfRruNlSFn1qhtt5MRm0QEpLvkcmpL6fnJnYgl2NAvoc5F
         pVDvwBLXeGDCM24Ztng8uLmO62R0W0blcOGKNI2IoM6RrQ5LQbzX7wiBM7MzYxP5aYx4
         lfJTipHVI0jBj73PuEBUR1wP7W/jzWDaFKCaVXzOblbvxA4Yn6Esox3nr/yiA6NZfvJ0
         1dp+KdpdHKE3FeDHhASz0MGzT014QEk6SnLKZTrVeNDFt0woWSY2UnRXsXFSCzNSFHEd
         M/LA==
X-Forwarded-Encrypted: i=1; AJvYcCUczIWZqh/08iTwerbvIDHwdUVFWNUJtTWNE0hyYm/GHTdDg6WZtE+XB7rUSR4llDEPFpheXLkXr3Nax1niCrP3HJ6gYgSWWZA0RxPl
X-Gm-Message-State: AOJu0Yz6+l4k1eS/OKRnM9wjOdgLTT2AfOv6SPa0EYZpmO8uvLqyvvGK
	rWHtfgvtVHo+0nWXOlcESAG5bGsqo7SHU/1YvlrLL3UmIfT1dyneMRu2RJ08ew==
X-Google-Smtp-Source: AGHT+IHzQEvbTybFxdOOiTqUl7ym4mHT4Zq9uXRmXAzKRWe5gmEcs6zFJSlc05jkl1alZKpFPU/CEg==
X-Received: by 2002:a05:620a:5cca:b0:789:ebd1:445a with SMTP id xr10-20020a05620a5cca00b00789ebd1445amr11360295qkn.42.1710889239710;
        Tue, 19 Mar 2024 16:00:39 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id bp10-20020a05620a458a00b00789e8860ef7sm4208014qkb.121.2024.03.19.16.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 16:00:39 -0700 (PDT)
Date: Tue, 19 Mar 2024 19:00:38 -0400
Message-ID: <fd1c5f7f7c7fe7125e70788149e08cd4@paul-moore.com>
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
Cc: linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, fsverity@lists.linux.dev, linux-block@vger.kernel.org, dm-devel@lists.linux.dev, audit@vger.kernel.org, linux-kernel@vger.kernel.org, Fan Wu <wufan@linux.microsoft.com>
Subject: Re: [PATCH RFC v15 16/21] security: add security_inode_setintegrity()  hook
References: <1710560151-28904-17-git-send-email-wufan@linux.microsoft.com>
In-Reply-To: <1710560151-28904-17-git-send-email-wufan@linux.microsoft.com>

On Mar 15, 2024 Fan Wu <wufan@linux.microsoft.com> wrote:
> 
> This patch introduces a new hook to save inode's integrity
> data. For example, for fsverity enabled files, LSMs can use this hook to save
> the verified fsverity builtin signature into the inode's security blob,
> and LSMs can make access decisions based on the data inside the signature,
> like the signer certificate.
> 
> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> 
> --
> v1-v14:
>   + Not present
> 
> v15:
>   + Introduced
> 
> ---
>  include/linux/lsm_hook_defs.h |  3 +++
>  include/linux/security.h      | 10 ++++++++++
>  security/security.c           | 28 ++++++++++++++++++++++++++++
>  3 files changed, 41 insertions(+)
> 
> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
> index 6808ae763913..c88587fc3691 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -177,6 +177,9 @@ LSM_HOOK(int, 0, inode_listsecurity, struct inode *inode, char *buffer,
>  LSM_HOOK(void, LSM_RET_VOID, inode_getsecid, struct inode *inode, u32 *secid)
>  LSM_HOOK(int, 0, inode_copy_up, struct dentry *src, struct cred **new)
>  LSM_HOOK(int, -EOPNOTSUPP, inode_copy_up_xattr, const char *name)
> +LSM_HOOK(int, 0, inode_setintegrity, struct inode *inode,
> +	 enum lsm_intgr_type type, const void *value, size_t size)
> +
>  LSM_HOOK(int, 0, kernfs_init_security, struct kernfs_node *kn_dir,
>  	 struct kernfs_node *kn)
>  LSM_HOOK(int, 0, file_permission, struct file *file, int mask)
> diff --git a/include/linux/security.h b/include/linux/security.h
> index 60b40b523d57..0885866b261e 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -405,6 +405,9 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
>  void security_inode_getsecid(struct inode *inode, u32 *secid);
>  int security_inode_copy_up(struct dentry *src, struct cred **new);
>  int security_inode_copy_up_xattr(const char *name);
> +int security_inode_setintegrity(struct inode *inode,
> +				enum lsm_intgr_type type, const void *value,
> +				size_t size);
>  int security_kernfs_init_security(struct kernfs_node *kn_dir,
>  				  struct kernfs_node *kn);
>  int security_file_permission(struct file *file, int mask);
> @@ -1021,6 +1024,13 @@ static inline int security_inode_copy_up(struct dentry *src, struct cred **new)
>  	return 0;
>  }
>  
> +static inline int security_inode_setintegrity(struct inode *inode,
> +					      enum lsm_intgr_type, type,
> +					      const void *value, size_t size)
> +{
> +	return 0;
> +}
> +
>  static inline int security_kernfs_init_security(struct kernfs_node *kn_dir,
>  						struct kernfs_node *kn)
>  {
> diff --git a/security/security.c b/security/security.c
> index 8d88529ac904..c5d426d084ab 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -2681,6 +2681,34 @@ int security_inode_copy_up_xattr(const char *name)
>  }
>  EXPORT_SYMBOL(security_inode_copy_up_xattr);
>  
> +/**
> + * security_inode_setintegrity() - Set the inode's integrity data
> + * @inode: inode
> + * @type: type of integrity, e.g. hash digest, signature, etc
> + * @value: the integrity value
> + * @size: size of the integrity value
> + *
> + * Register a verified integrity measurement of a inode with the LSM.
> + *
> + * Return: Returns 0 on success, negative values on failure.
> + */
> +int security_inode_setintegrity(struct inode *inode,
> +				enum lsm_intgr_type type, const void *value,
> +				size_t size)
> +{
> +	int rc = 0;
> +	struct security_hook_list *p;
> +
> +	hlist_for_each_entry(p, &security_hook_heads.inode_setintegrity, list) {
> +		rc = p->hook.inode_setintegrity(inode, type, value, size);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return LSM_RET_DEFAULT(inode_setintegrity);
> +}
> +EXPORT_SYMBOL(security_inode_setintegrity);

Same as the block device variant of this hook, we should convert this
to use the call_int_hook() macro unless there is a strong reason to
leave it open coded.

>  /**
>   * security_kernfs_init_security() - Init LSM context for a kernfs node
>   * @kn_dir: parent kernfs node
> -- 
> 2.44.0

--
paul-moore.com

