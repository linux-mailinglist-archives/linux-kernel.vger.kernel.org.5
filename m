Return-Path: <linux-kernel+bounces-157983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5488B19C8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89EC42856E3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8326374FB;
	Thu, 25 Apr 2024 03:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TZra8rhA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7D01AACB;
	Thu, 25 Apr 2024 03:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714017410; cv=none; b=MlQwOIFGnaGbRUI8eaeVycDlM41X8HG2L+tSdK1S+I+YtcZ9JtTaj4ZrvkpFYtb0N1x7hhc8e5WCUUx+2m6/JI92ltJ6mjfqSUqI2+zI2+FBJXHDITHNZXH5Zchjr4DGkeXu/7J3Y8DUUn8P+3yUmhwiGOsiNJIL3Ogn4SMOKG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714017410; c=relaxed/simple;
	bh=xbvsl7p/tNI3FsAriBnf2RoEGr8k3R2uelHe67Dhz9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ST/8KRxCEF0rYilvPXBHzOCS3yLE1/Xc0wAfjgk4ykieGW8cdwpL/lSVPEtFEA3O1WAweGI5Xh97RmG1K0xEravThpS98xW5aM6MAxF+uxcITnliHq7ZvMXQ14vPjy3Pa8bmuqEoHNl0gpOdCGUT8oYq1X/bZDlWG4XyZ7u6oNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TZra8rhA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE01AC113CC;
	Thu, 25 Apr 2024 03:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714017409;
	bh=xbvsl7p/tNI3FsAriBnf2RoEGr8k3R2uelHe67Dhz9o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TZra8rhAGO4C6E2iOW3rX/yd1YzAQbNgxnEMcEnXuyHAXwubnXPoZrPbUSD33Fu9J
	 SxCM6i6yNtp0Gon16iAdINv7SG0lYFFTTwqw3OcfVSawRcWpbBIcnenmRTQdYMY2zN
	 3Vjp42P8iLlstsam2vyZCnqHhxfhrZxWKFNTc3vpcuGvd+RCxQYUh9ckvfJOuJaUY0
	 B5Dh12B+u/WvV4RA4obddHQ761gBea8YlSd95x/iENRuz26pdL+DALTCqc2EkE/6Zm
	 KPD6Qe07CbTXQKGn+phST2tqBUgSWVTPjUSRotLn4LtgX65Q7AZ1h5c5X5Q879qrtY
	 L0I9gmI/S5f6g==
Date: Wed, 24 Apr 2024 20:56:47 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Fan Wu <wufan@linux.microsoft.com>
Cc: corbet@lwn.net, zohar@linux.ibm.com, jmorris@namei.org,
	serge@hallyn.com, tytso@mit.edu, axboe@kernel.dk, agk@redhat.com,
	snitzer@kernel.org, eparis@redhat.com, paul@paul-moore.com,
	linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org, fsverity@lists.linux.dev,
	linux-block@vger.kernel.org, dm-devel@lists.linux.dev,
	audit@vger.kernel.org, linux-kernel@vger.kernel.org,
	Deven Bowers <deven.desai@linux.microsoft.com>
Subject: Re: [PATCH v17 13/21] dm verity: consume root hash digest and expose
 signature data via LSM hook
Message-ID: <20240425035647.GC1401@sol.localdomain>
References: <1712969764-31039-1-git-send-email-wufan@linux.microsoft.com>
 <1712969764-31039-14-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1712969764-31039-14-git-send-email-wufan@linux.microsoft.com>

On Fri, Apr 12, 2024 at 05:55:56PM -0700, Fan Wu wrote:
> dm verity: consume root hash digest and expose signature data via LSM hook

As in the fsverity patch, nothing is being "consumed" here.  This patch adds a
supplier, not a consumer.  I think you mean something like: expose root digest
and signature to LSMs.

> diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
> index bb5da66da4c1..fbb83c6fd99c 100644
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
> +#ifdef CONFIG_SECURITY
> +
> +static int verity_init_sig(struct dm_verity *v, const void *sig,
> +			   size_t sig_size)
> +{
> +	v->sig_size = sig_size;
> +	v->root_digest_sig = kmemdup(sig, v->sig_size, GFP_KERNEL);
> +	if (!v->root_digest)
> +		return -ENOMEM;

root_digest_sig, not root_digest

> +#ifdef CONFIG_SECURITY
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
> +				       LSM_INT_DMVERITY_SIG_VALID,
> +				       v->root_digest_sig,
> +				       v->sig_size);

The signature is only checked if CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG=y, whereas
this code is built whenever CONFIG_SECURITY=y.

So this seems like the same issue that has turned up elsewhere in the IPE
patchset, where IPE is (apparently) happy with any signature, even one that
hasn't been checked...

> diff --git a/drivers/md/dm-verity.h b/drivers/md/dm-verity.h
> index 20b1bcf03474..89e862f0cdf6 100644
> --- a/drivers/md/dm-verity.h
> +++ b/drivers/md/dm-verity.h
> @@ -43,6 +43,9 @@ struct dm_verity {
>  	u8 *root_digest;	/* digest of the root block */
>  	u8 *salt;		/* salt: its size is salt_size */
>  	u8 *zero_digest;	/* digest for a zero block */
> +#ifdef CONFIG_SECURITY
> +	u8 *root_digest_sig;	/* digest signature of the root block */
> +#endif /* CONFIG_SECURITY */

No, it's not a signature of the root block, at least not directly.  It's a
signature of the root digest (the digest of the root block).

> diff --git a/include/linux/dm-verity.h b/include/linux/dm-verity.h
> new file mode 100644
> index 000000000000..a799a8043d85
> --- /dev/null
> +++ b/include/linux/dm-verity.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _LINUX_DM_VERITY_H
> +#define _LINUX_DM_VERITY_H
> +
> +struct dm_verity_digest {
> +	const char *alg;
> +	const u8 *digest;
> +	size_t digest_len;
> +};
> +
> +#endif /* _LINUX_DM_VERITY_H */
> diff --git a/include/linux/security.h b/include/linux/security.h
> index ac0985641611..9e46b13a356c 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -84,7 +84,8 @@ enum lsm_event {
>  };
>  
>  enum lsm_integrity_type {
> -	__LSM_INT_MAX
> +	LSM_INT_DMVERITY_SIG_VALID,
> +	LSM_INT_DMVERITY_ROOTHASH,
>  };

Shouldn't struct dm_verity_digest be defined next to LSM_INT_DMVERITY_ROOTHASH?
It's the struct that's associated with it.

It seems weird to create a brand new header <linux/dm-verity.h> that just
contains this one LSM related definition, when there's already a header for the
LSM definitions that even includes the related value LSM_INT_DMVERITY_ROOTHASH.

- Eric

