Return-Path: <linux-kernel+bounces-157973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A388B1996
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D85A1C21243
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43852BB01;
	Thu, 25 Apr 2024 03:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYJklTY1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C742F1CFAF;
	Thu, 25 Apr 2024 03:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714016186; cv=none; b=PqJOlXlW5JU7LwEdmhnR9XLbGon0cdOXJlzaW9n7RH/R0dHVBUkKJ+f7yzZb7nczEv4SKNJVhfIXxxeC6KKrRo8JyVZXub//1lpNkpK9Qp5j2tHdvQZZWGEK8pSsEsKOEe8iPfAPMUWHOB8RGeQtpWN7U2+++DcTU6QuIwa6HnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714016186; c=relaxed/simple;
	bh=GeWAMnfWagn1Kaadtthqg0oPmCZaNIn9vT7HkPbKuW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FgWIAJBlx3pA46NipQ8VHxJWGwJppHS78P2n8gNpjkK5UfxCR6xbvi5uPr4NnFWqmvoTOsrtYGNoRRMzM/thkx/bkip9V8OmyAeManhDtQfg9pGYmr5FQLR4K2m5yqgCa1ks8VWV5/pZA5TAz876SJTN93m1ArtlWLwy4b4wMHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYJklTY1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDCF6C113CC;
	Thu, 25 Apr 2024 03:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714016185;
	bh=GeWAMnfWagn1Kaadtthqg0oPmCZaNIn9vT7HkPbKuW4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DYJklTY1KH83ua4kI6LeO607GfBSbM2ev6VicCnIJrjSZSXEO/cSyCKjoFseMcV/f
	 XzRcOQDv1baecMnURNXN1yYWL6CAk/7ShUgjgbKo8hlIUqvwDii4EroS3Qpu+/6BLV
	 eNQBPFefTzuqC/BMjxpkI7w+rGCSbuekxbHMGgjUj5fP1BxuhuykvkoMiwNsg9+Km+
	 w+iNxj+e3U0TernKO8YnJtbf2/XxFbHw/3FlDaZHWncDGhXwlQ7wqpA9Ps0UZP1FjF
	 GdICSIxzjpaPOY7bd2GUVfRqfmci/0l7yFzmM+WP++La4EaxXB5+8mnjHQYK1dFZBC
	 N82rs9fbu01HA==
Date: Wed, 24 Apr 2024 20:36:23 -0700
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
Subject: Re: [PATCH v17 16/21] fsverity: expose verified fsverity built-in
 signatures to LSMs
Message-ID: <20240425033623.GA1401@sol.localdomain>
References: <1712969764-31039-1-git-send-email-wufan@linux.microsoft.com>
 <1712969764-31039-17-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1712969764-31039-17-git-send-email-wufan@linux.microsoft.com>

On Fri, Apr 12, 2024 at 05:55:59PM -0700, Fan Wu wrote:
> For instance, a policy could be established to permit the execution of all
> files with verified built-in fsverity signatures while restricting kernel
> module loading from specified fsverity files via fsverity digets.

"digets" => "digests"

> The introduction of a security_inode_setintegrity() hook call within
> fsverity's workflow ensures that the verified built-in signature of a file
> is exposed to LSMs, This enables LSMs to recognize and label fsverity files

"LSMs, This" => "LSMs. This"

> +#ifdef CONFIG_FS_VERITY_BUILTIN_SIGNATURES
> +static int fsverity_inode_setintegrity(struct inode *inode,
> +				       const struct fsverity_descriptor *desc)
> +{
> +	return security_inode_setintegrity(inode,
> +					   LSM_INT_FSVERITY_BUILTINSIG_VALID,
> +					   desc->signature,
> +					   le32_to_cpu(desc->sig_size));
> +}
> +#else
> +static inline int fsverity_inode_setintegrity(struct inode *inode,
> +					      const struct fsverity_descriptor *desc)
> +{
> +	return 0;
> +}
> +#endif /* CONFIG_FS_VERITY_BUILTIN_SIGNATURES */
[...]
> @@ -241,6 +259,10 @@ struct fsverity_info *fsverity_create_info(const struct inode *inode,
> 		}
> 	}
> 
> +	err = fsverity_inode_setintegrity(inode, desc);
> +	if (err)
> +		goto fail;
> +

Wouldn't it be much simpler to put the LSM call in fsverity_verify_signature()?
Then no #ifdef would be needed, and there would be no weird cases where the LSM
gets passed LSM_INT_FSVERITY_BUILTINSIG_VALID with an empty signature.

> diff --git a/fs/verity/signature.c b/fs/verity/signature.c
> index 90c07573dd77..fd60e9704e78 100644
> --- a/fs/verity/signature.c
> +++ b/fs/verity/signature.c
> @@ -41,7 +41,11 @@ static struct key *fsverity_keyring;
>   * @sig_size: size of signature in bytes, or 0 if no signature
>   *
>   * If the file includes a signature of its fs-verity file digest, verify it
> - * against the certificates in the fs-verity keyring.
> + * against the certificates in the fs-verity keyring. Note that signatures
> + * are verified regardless of the state of the 'fsverity_require_signatures'
> + * variable and the LSM subsystem relies on this behavior to help enforce
> + * file integrity policies. Please discuss changes with the LSM list
> + * (thank you!).
>   *
>   * Return: 0 on success (signature valid or not required); -errno on failure
>   */

.. and it would also make the above easier to understand if the LSM call were
to happen right in fsverity_verify_signature().

- Eric

