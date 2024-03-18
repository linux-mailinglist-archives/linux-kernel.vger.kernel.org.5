Return-Path: <linux-kernel+bounces-105707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCD487E318
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 06:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74E942823C6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 05:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D9D22087;
	Mon, 18 Mar 2024 05:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mt+mVyBY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F73210FF;
	Mon, 18 Mar 2024 05:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710739780; cv=none; b=OET7ifovzCmw8JhwUfF9MH1i6goPsl/S5iRc5eOr9VX4l/gu9cSwwGzN+gy+XToqaKbsiZGmAJMbX7qGn+2C+7MeNzX7PqNpWqyXN4SYbtNTU9sW2DzcqbD8o7Z7TNpLwlhjL5sChhWV1v3e5eU5fm79BmKYHcazNuhU214jfrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710739780; c=relaxed/simple;
	bh=UZEMiHuuRl4T/rlwId3DD2KlUw8pZnpS6f+pHVJWvHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PSnVDelKXF2VFe6KAlqIWhv5rax1gdDNUe82JkuUtTWCaVjby7e3vCg4VxDoSDY/dI8pCZ3Tn1nmTs5ppEJoaWyLPOnQEWtTfYZC3Dryc3wTDUt9RgGZWuP0SyYJQ/l7BA73w3394F6dYMRJHulgpPB5j+Nw1hCYYgdzBJJtgTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mt+mVyBY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59902C433F1;
	Mon, 18 Mar 2024 05:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710739780;
	bh=UZEMiHuuRl4T/rlwId3DD2KlUw8pZnpS6f+pHVJWvHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mt+mVyBY9VqzmlnYsbQgoqE1L0lhjQt0giYtNGO0La4C4M9+OIWYuqaTBo+FTBCI1
	 KCcBqLyogKBXTVhc8ksvAmWKIRMvSdWW9iBWnV6f04TJxsGLh1FogbBRVOrO/KTj6d
	 t0DyEpGehodliT+3nl6N8hUMzDMgk8RjbpLD/NomODDNyQw4TjorJK8E2rNYMNNFCZ
	 VAPWOjpymIdlXqRJwtkhFd5jBEGMc3HTGNO1JH35Yx0r1aV91Tq2hU8o2/ZsMVTbPe
	 nNoh+nyAswN3FzN3hyLPJWLkAnYshErkLaqHJbj43Sj/MApyDV8fH/cQs7cUeRxkzp
	 dtLNFVpkT3eDQ==
Date: Sun, 17 Mar 2024 22:29:37 -0700
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
Subject: Re: [RFC PATCH v15 17/21] fsverity: consume builtin signature via
 LSM hook
Message-ID: <20240318052937.GC63337@sol.localdomain>
References: <1710560151-28904-1-git-send-email-wufan@linux.microsoft.com>
 <1710560151-28904-18-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1710560151-28904-18-git-send-email-wufan@linux.microsoft.com>

On Fri, Mar 15, 2024 at 08:35:47PM -0700, Fan Wu wrote:
> fsverity represents a mechanism to support both integrity and
> authenticity protection of a file, supporting both signed and unsigned
> digests.
> 
> An LSM which controls access to a resource based on authenticity and
> integrity of said resource, can then use this data to make an informed
> decision on the authorization (provided by the LSM's policy) of said
> claim.
> 
> This effectively allows the extension of a policy enforcement layer in
> LSM for fsverity, allowing for more granular control of how a
> particular authenticity claim can be used. For example, "all (built-in)
> signed fsverity files should be allowed to execute, but only these
> hashes are allowed to be loaded as kernel modules".
> 
> This enforcement must be done in kernel space, as a userspace only
> solution would fail a simple litmus test: Download a self-contained
> malicious binary that never touches the userspace stack. This
> binary would still be able to execute.
> 
> This patch introduces a new security_inode_setintegrity() hook call in
> fsverity to store the verified fsverity signature in the inode's LSM blobs.
> The hook call is executed after fsverity_verify_signature(), ensuring that
> the signature is verified against fsverity's keyring.
> 
> The last commit in this patch set will add a link to the IPE documentation in
> fsverity.rst.

There are multiple types of fsverity signatures.  Please make it clear which one
you're talking about ("fsverity builtin signatures").

> diff --git a/Documentation/filesystems/fsverity.rst b/Documentation/filesystems/fsverity.rst
> index 13e4b18e5dbb..708c79631f32 100644
> --- a/Documentation/filesystems/fsverity.rst
> +++ b/Documentation/filesystems/fsverity.rst
> @@ -461,7 +461,10 @@ Enabling this option adds the following:
>  
>  3. A new sysctl "fs.verity.require_signatures" is made available.
>     When set to 1, the kernel requires that all verity files have a
> -   correctly signed digest as described in (2).
> +   correctly signed digest as described in (2). Note that verification
> +   happens as long as the file's signature exists regardless of the state of
> +   "fs.verity.require_signatures", and the IPE LSM relies on this behavior
> +   to save verified signature into LSM blobs.

This probably should go in item (2) instead, as that already mentions the
behavior when opening a file.

>  The data that the signature as described in (2) must be a signature of
>  is the fs-verity file digest in the following format::
> @@ -481,7 +484,7 @@ be carefully considered before using them:
>  
>  - Builtin signature verification does *not* make the kernel enforce
>    that any files actually have fs-verity enabled.  Thus, it is not a
> -  complete authentication policy.  Currently, if it is used, the only
> +  complete authentication policy.  Currently, if it is used, one
>    way to complete the authentication policy is for trusted userspace
>    code to explicitly check whether files have fs-verity enabled with a
>    signature before they are accessed.  (With
> @@ -489,6 +492,11 @@ be carefully considered before using them:
>    enabled suffices.)  But, in this case the trusted userspace code
>    could just store the signature alongside the file and verify it
>    itself using a cryptographic library, instead of using this feature.
> +  Another approach is to utilize built-in signature verification in
> +  conjunction with the IPE LSM, which supports defining
> +  a kernel-enforced, system-wide authentication policy that allows only
> +  files with an fs-verity signature enabled to perform certain operations,
> +  such as execution. Note that IPE doesn't require fs.verity.require_signatures=1.

Make this a new paragraph.

Also, the acronym "IPE" should be spelled out somewhere.

IPE should be mentioned in the list in the "Use cases" section next to IMA, and
it can be spelled out there.

> +#ifdef CONFIG_FS_VERITY_BUILTIN_SIGNATURES
> +static int fsverity_inode_setintegrity(struct inode *inode,
> +				       const struct fsverity_descriptor *desc)
> +{
> +	return security_inode_setintegrity(inode, LSM_INTGR_FSV_SIG,
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
> +
>  /*
>   * Create a new fsverity_info from the given fsverity_descriptor (with optional
>   * appended builtin signature), and check the signature if present.  The
>   * fsverity_descriptor must have already undergone basic validation.
>   */
> -struct fsverity_info *fsverity_create_info(const struct inode *inode,
> +struct fsverity_info *fsverity_create_info(struct inode *inode,
>  					   struct fsverity_descriptor *desc)
>  {
>  	struct fsverity_info *vi;
> @@ -241,6 +258,11 @@ struct fsverity_info *fsverity_create_info(const struct inode *inode,
>  		}
>  	}
>  
> +	err = fsverity_inode_setintegrity(inode, desc);
> +
> +	if (err)
> +		goto fail;

Delete the blank line before 'if (err)'

> diff --git a/fs/verity/signature.c b/fs/verity/signature.c
> index 90c07573dd77..d4ed03a114e9 100644
> --- a/fs/verity/signature.c
> +++ b/fs/verity/signature.c
> @@ -41,7 +41,10 @@ static struct key *fsverity_keyring;
>   * @sig_size: size of signature in bytes, or 0 if no signature
>   *
>   * If the file includes a signature of its fs-verity file digest, verify it
> - * against the certificates in the fs-verity keyring.
> + * against the certificates in the fs-verity keyring. Note that verification
> + * happens as long as the file's signature exists regardless of the state of
> + * fsverity_require_signatures, and the IPE LSM relies on this behavior
> + * to save the verified file signature of the file into security blobs.

"save the verified file signature of the file into security blobs" isn't what
IPE actually does, though.  And even if it was, it would not explain why IPE
expects the signature to be verified.

> diff --git a/include/linux/security.h b/include/linux/security.h
> index 0885866b261e..edd12c0a673a 100644
> --- a/include/linux/security.h
> +++ b/include/linux/security.h
> @@ -86,6 +86,7 @@ enum lsm_event {
>  enum lsm_intgr_type {
>  	LSM_INTGR_DMV_SIG,
>  	LSM_INTGR_DMV_ROOTHASH,
> +	LSM_INTGR_FSV_SIG,
>  	__LSM_INTGR_MAX
>  };

These are hard to understand because they are abbreviated too much.  And again,
there are multiple type of fsverity signatures.  How about:

enum lsm_integrity_type {
	LSM_INTEGRITY_DM_VERITY_SIG,
	LSM_INTEGRITY_DM_VERITY_ROOT_HASH,
	LSM_INTEGRITY_FS_VERITY_BUILTIN_SIG,
	__LSM_INTEGRITY_MAX
};

- Eric

