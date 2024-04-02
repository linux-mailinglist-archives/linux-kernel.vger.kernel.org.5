Return-Path: <linux-kernel+bounces-127246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A808948BB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 03:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD0D3283078
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E77D111A3;
	Tue,  2 Apr 2024 01:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OrP8/rnX"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB63C8C7
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 01:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712021208; cv=none; b=j/9pLkFEt3lQYmoIxFvpfIulUpsn1Ex4gjzs+SZ/KS7KkBLgCYqXNC0DOF36VTmmA3qJfdmU2jNXlBbyJBDYlUCDhpzUsN3LOQKNRRwRGcascQD3G1lAS3FyBKQAh+n9mrQPhkdseO+/9iLHWpaDDQH35mNLTS/YVc1SM2s3CTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712021208; c=relaxed/simple;
	bh=on1DTucxi+oZ7uA+/tuc2JFdOMihBYrKc7BS0Yuaah8=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=IzCQqJ+xq2PXqRIzG+IzbjcK9t9D9iU9gRvfDla262X9+8IptoKuWyxDPHaH+jAkLE0rwf9WzA8hiyAZGZM5CHmn2E+eer2bGMnLhLA8ssZQapvb0COgC9n6HgU+7XMbvatOkqVBxdSJt1rlnYqEVEkdMlum8HuF5IVzQYp1w3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OrP8/rnX; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-789d76ad270so314778685a.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 18:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1712021204; x=1712626004; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=r3UwGQo4fjb6e9Uc1vYlrwHawSdoHoBapjW5e3tdQI0=;
        b=OrP8/rnXjTi2ZkK2NNbsfPATFYSdmMrEQZwhwQhZn12DCwe+B+uU4xKcZkUAhTWiXc
         3tpxeqgUJogj61bZatj23q9rDBnmaHUlN7WPNUOqtm0MJAGu6pyVXsv950DCp5w58Wp2
         uCrNw6QXCXEDp6XSdOA/dyTFXhOqt5c8rFkIIMPe+PvaqgKdhy4RHOeju5Tj/uZvvbB+
         nCR4/jHMPcX8lejP3oac/zp1Ix28rAtRXL2w/mUp5vjwsqMzVmAoC7UVQ26PE1GSvye5
         jiKKuUq1MICYgGHcxplB8dA8daRTtNgiS+dA9nHzKzF1dnS4ugFUTn4XV0HhqOqFtPoL
         4QnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712021204; x=1712626004;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r3UwGQo4fjb6e9Uc1vYlrwHawSdoHoBapjW5e3tdQI0=;
        b=XliYDt8XeeZ8i+QrBQQ/o6/+axo9h+nB9FZ8hM03u6jBABG+8t+QLrul0BPuRQto/d
         gdztobmH00mCKmLWPulebCvH+jzI+JWlaHhDTrUeyL0Vd6j9uBRt7/Zk5LHGHN38kD6F
         PeQ+dTAXMP72EUCTzi1/1Dpgztv55fLb0zBR69CLQKTkTfEWXtqiDAD/WIZTySsqW07J
         SSkJN4yV9NRLrv6cDmJehLexJAgMTGxzwEFA6XFDabyugsYRyxy16uOCXGDWKXzSyEfq
         Ct720xCmLJOe1u2y5MFLH37q3XMy6DieijH/I4WI0U6H2ezLXlF/JJnVgV9yiBBKHbOQ
         rXvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTm/pz3mxCKwXN78Q4YzxMtH9z6+T0RjuHoqYCff1Gp0VJhSA4LonS6CGjS4/bS0YNyPvW14Gwvy/Ev4cA2xMPifQgYotBdvkjHNbx
X-Gm-Message-State: AOJu0Yz0+b8+BP0XdRk2NJWzcKNsWpo7joXJMnRa/QD3dQENXgCZMDak
	YvY9g8DjXU0+NaGXnOz42iXUCF07vVlya92prSrE45zS9XNnd0M6E4me0ymEhQ==
X-Google-Smtp-Source: AGHT+IHJe1aPG6if70/ZKi0HtKa/VaKR4VeKOS31gZ6VStcQ8DQS8RbXeLV8BenYe/7AyYHzGtdy2w==
X-Received: by 2002:a05:620a:36de:b0:788:2190:d293 with SMTP id cz30-20020a05620a36de00b007882190d293mr11802511qkb.40.1712021204202;
        Mon, 01 Apr 2024 18:26:44 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id h29-20020a05620a21dd00b00789f57cadc5sm3910599qka.10.2024.04.01.18.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 18:26:43 -0700 (PDT)
Date: Mon, 01 Apr 2024 21:26:43 -0400
Message-ID: <31cf8af8b467e22d30bbb71a7ed58ced@paul-moore.com>
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
Subject: Re: [PATCH v16 13/20] dm verity: consume root hash digest and  signature data via LSM hook
References: <1711657047-10526-14-git-send-email-wufan@linux.microsoft.com>
In-Reply-To: <1711657047-10526-14-git-send-email-wufan@linux.microsoft.com>

On Mar 28, 2024 Fan Wu <wufan@linux.microsoft.com> wrote:
> 
> dm-verity provides a strong guarantee of a block device's integrity. As
> a generic way to check the integrity of a block device, it provides
> those integrity guarantees to its higher layers, including the filesystem
> level.
> 
> An LSM that control access to a resource on the system based on the
> available integrity claims can use this transitive property of
> dm-verity, by querying the underlying block_device of a particular
> file.
> 
> The digest and signature information need to be stored in the block
> device to fulfill the next requirement of authorization via LSM policy.
> This will enable the LSM to perform revocation of devices that are still
> mounted, prohibiting execution of files that are no longer authorized
> by the LSM in question.
> 
> This patch adds two security hook calls in dm-verity to save the
> dm-verity roothash and the roothash signature to the block device's
> LSM blobs. The hook calls are depended on CONFIG_IPE_PROP_DM_VERITY,
> which will be introduced in the next commit.
> 
> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> ---
> v2:
>   + No Changes
> 
> v3:
>   + No changes
> 
> v4:
>   + No changes
> 
> v5:
>   + No changes
> 
> v6:
>   + Fix an improper cleanup that can result in
>     a leak
> 
> v7:
>   + Squash patch 08/12, 10/12 to [11/16]
>   + Use part0 for block_device, to retrieve the block_device, when
>     calling security_bdev_setsecurity
> 
> v8:
>   + Undo squash of 08/12, 10/12 - separating drivers/md/ from
>     security/ & block/
>   + Use common-audit function for dmverity_signature.
>   + Change implementation for storing the dm-verity digest to use the
>     newly introduced dm_verity_digest structure introduced in patch
>     14/20.
>   + Create new structure, dm_verity_digest, containing digest algorithm,
>     size, and digest itself to pass to the LSM layer. V7 was missing the
>     algorithm.
>   + Create an associated public header containing this new structure and
>     the key values for the LSM hook, specific to dm-verity.
>   + Additional information added to commit, discussing the layering of
>     the changes and how the information passed will be used.
> 
> v9:
>   + No changes
> 
> v10:
>   + No changes
> 
> v11:
>   + Add an optional field to save signature
>   + Move the security hook call to the new finalize hook
> 
> v12:
>   + No changes
> 
> v13:
>   + No changes
> 
> v14:
>   + Correct code format
>   + Remove unnecessary header and switch to dm_disk()
> 
> v15:
>   + Refactor security_bdev_setsecurity() to security_bdev_setintegrity()
>   + Remove unnecessary headers
> 
> v16:
>   + Use kmemdup to duplicate signature
>   + clean up lsm blob data in error case
> ---
>  drivers/md/dm-verity-target.c | 83 +++++++++++++++++++++++++++++++++++
>  drivers/md/dm-verity.h        |  6 +++
>  include/linux/dm-verity.h     | 12 +++++
>  include/linux/security.h      |  3 +-
>  4 files changed, 103 insertions(+), 1 deletion(-)
>  create mode 100644 include/linux/dm-verity.h
> 
> diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
> index bb5da66da4c1..e2b0657b09f9 100644
> --- a/drivers/md/dm-verity-target.c
> +++ b/drivers/md/dm-verity-target.c
> @@ -22,6 +22,8 @@
>  #include <linux/scatterlist.h>
>  #include <linux/string.h>
>  #include <linux/jump_label.h>
> +#include <linux/security.h>
> +#include <linux/dm-verity.h>
>  
>  #define DM_MSG_PREFIX			"verity"
>  
> @@ -1017,6 +1019,38 @@ static void verity_io_hints(struct dm_target *ti, struct queue_limits *limits)
>  	blk_limits_io_min(limits, limits->logical_block_size);
>  }
>  
> +#ifdef CONFIG_IPE_PROP_DM_VERITY
> +
> +static int verity_init_sig(struct dm_verity *v, const void *sig,
> +			   size_t sig_size)
> +{
> +	v->sig_size = sig_size;
> +	v->root_digest_sig = kmemdup(sig, v->sig_size, GFP_KERNEL);
> +	if (!v->root_digest)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +static void verity_free_sig(struct dm_verity *v)
> +{
> +	kfree(v->root_digest_sig);
> +}
> +
> +#else
> +
> +static inline int verity_init_sig(struct dm_verity *v, const void *sig,
> +				  size_t sig_size)
> +{
> +	return 0;
> +}
> +
> +static inline void verity_free_sig(struct dm_verity *v)
> +{
> +}
> +
> +#endif /* CONFIG_IPE_PROP_DM_VERITY */

Please see my comments from the v15 patchset where I talked about using
CONFIG_SECURITY instead of CONFIG_IPE_PROP_DM_VERITY.

> @@ -1584,6 +1626,44 @@ int dm_verity_get_root_digest(struct dm_target *ti, u8 **root_digest, unsigned i
>  	return 0;
>  }
>  
> +#ifdef CONFIG_IPE_PROP_DM_VERITY
> +
> +static int verity_finalize(struct dm_target *ti)
> +{
> +	struct block_device *bdev;
> +	struct dm_verity_digest root_digest;
> +	struct dm_verity *v;
> +	int r;
> +
> +	v = ti->private;
> +	bdev = dm_disk(dm_table_get_md(ti->table))->part0;
> +	root_digest.digest = v->root_digest;
> +	root_digest.digest_len = v->digest_size;
> +	root_digest.alg = v->alg_name;
> +
> +	r = security_bdev_setintegrity(bdev, LSM_INT_DMVERITY_ROOTHASH, &root_digest,
> +				       sizeof(root_digest));
> +	if (r)
> +		return r;
> +
> +	r = security_bdev_setintegrity(bdev,
> +				       LSM_INT_DMVERITY_SIG,
> +				       v->root_digest_sig,
> +				       v->sig_size);
> +	if (r)
> +		goto bad;
> +
> +	return 0;
> +
> +bad:
> +
> +	security_bdev_setintegrity(bdev, LSM_INT_DMVERITY_ROOTHASH, NULL, 0);
> +
> +	return r;

Nitpicky, but you really don't need to use as much vertical whitespace
here:

  err:
    security_bdev_setintegrity(...);
    return r;

> +}

--
paul-moore.com

