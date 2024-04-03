Return-Path: <linux-kernel+bounces-129045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1C98963BF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA6A6285671
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 05:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF164779D;
	Wed,  3 Apr 2024 05:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FzeEsPLR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA9B17997;
	Wed,  3 Apr 2024 05:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712120574; cv=none; b=WoJmkHE6a9BFZr55Z1yDKdPX8BMy6d1G8nXwpyNAizZOiYxrU+QWJ/1NEI2wJ8+44qkWBEDD7YxwFkBmqfydTHR8SIThNE7TZ+0/nH7+U1MJJbyaAagh4jRyTQpwbGL6SMtcSw7j1T4Q+QhJwWvAIpzf79TzF+I7/lLBf+szvwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712120574; c=relaxed/simple;
	bh=2/EZE/fqM7rihgoveOtBWFcjc/baKHO1PSwzHE8G7pI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1v7KDckGHDUG/nmQQuKQ9IuMdgMS5zHuLcPjx4IpIBPC3gLeaRFmKIuvWAJ4idmMJOzPshSk1g/UVkElqyN4Xuq0lA/zTH5GhMOYSkWgTiswEmMpr3AKGdCWBk6BVd5zdv1jH3eYdyWJ3mPwYpx5858M0Q3y0ixG/i9Spbu+fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FzeEsPLR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE58C433C7;
	Wed,  3 Apr 2024 05:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712120573;
	bh=2/EZE/fqM7rihgoveOtBWFcjc/baKHO1PSwzHE8G7pI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FzeEsPLRQAOk6nAJZOzfUVRUqL5geuLfeb18kcrV9MjUceB6XAQZjcIdUuPSBxrOY
	 yPberXlvyeONEkyn3Jjnum/VwFEpiVybx92xdNIJsd2ogM04BAKkPingFDrTgmw9H3
	 uZuNcCNiZkK47ku6nVB8jtuvI+H5ZWZi9R9tbXdEEGCbxwswJ0YIA7SNKTOG2qURBJ
	 zH/d3sF98I1TGg+r6IN88Z/nGGYGWG21Nm0kw5lboTl+wPb+L8DWRNmC07ebNcBIGg
	 dUhYRG0DCJliiZuRQses+zCCoV5H7Yt8cDK4/zYjzmy3ei5U4AbFLVFMUdsA+sHreN
	 TcCOECUiistiA==
Date: Tue, 2 Apr 2024 22:02:51 -0700
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
Subject: Re: [PATCH v16 16/20] fsverity: consume fsverity built-in signatures
 via LSM hook
Message-ID: <20240403050251.GJ2576@sol.localdomain>
References: <1711657047-10526-1-git-send-email-wufan@linux.microsoft.com>
 <1711657047-10526-17-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1711657047-10526-17-git-send-email-wufan@linux.microsoft.com>

On Thu, Mar 28, 2024 at 01:17:23PM -0700, Fan Wu wrote:
> fsverity: consume fsverity built-in signatures via LSM hook

Nothing is being "consumed" in this patch.  I think you might mean something
like "expose verified fsverity built-in signatures to LSMs".

> It enables a policy enforcement layer within LSMs for fsverity, offering
> granular control over the usage of authenticity claims. For instance, a policy
> could be established to permit the execution of all files with built-in
> fsverity signatures while restricting kernel module loading to specified
> hashes.

No, this patch does not enable "restricting kernel module loading to specified
hashes."  That can be done without this patch.

> The introduction of a security_inode_setintegrity() hook call within
> fsverity's workflow ensures that the verified built-in signature of a file
> is stored in the inode's LSM blobs.

No, it doesn't.  As I said on v15, this is not what IPE actually uses it for.

Also, even if IPE did cache the built-in signature in i_security, the mere fact
that it's cached would say nothing about what it's actually used for.

> diff --git a/Documentation/filesystems/fsverity.rst b/Documentation/filesystems/fsverity.rst
> index 13e4b18e5dbb..e13cf10211c8 100644
> --- a/Documentation/filesystems/fsverity.rst
> +++ b/Documentation/filesystems/fsverity.rst
> @@ -86,6 +86,19 @@ authenticating fs-verity file hashes include:
>    signature in their "security.ima" extended attribute, as controlled
>    by the IMA policy.  For more information, see the IMA documentation.
>  
> +- Integrity Policy Enforcement (IPE).  IPE supports enforcing access
> +  control decisions based on immutable security properties of files,
> +  including those protected by fs-verity's built-in signatures.
> +  "IPE policy" specifically allows for the authorization of fs-verity
> +  files using properties such as ``fsverity_digest`` for identifying
> +  files by their verity digest, and ``fsverity_signature`` to validate
> +  files signed with fs-verity's built-in signature mechanism.

Maybe leave out the "such as" above, since fsverity_digest and
fsverity_signature are all the IPE properties related to fs-verity.

> +  This integration enhances security by ensuring the integrity and
> +  authenticity of files on a per-file basis, leveraging fs-verity's
> +  robust protection capabilities in conjunction with IPE's policy-driven
> +  access control.

This reads a bit like a marketing blurb and feels a bit out of place, especially
when it comes right after the paragraph about IMA which didn't include a similar
sentence even though the exact same sentence would apply to IMA too.  Maybe just
leave this sentence out.

> @@ -457,7 +470,10 @@ Enabling this option adds the following:
>     On success, the ioctl persists the signature alongside the Merkle
>     tree.  Then, any time the file is opened, the kernel verifies the
>     file's actual digest against this signature, using the certificates
> -   in the ".fs-verity" keyring.
> +   in the ".fs-verity" keyring. This verification happens as long as the
> +   file's signature exists, regardless of the state of the sysctl variable
> +   "fs.verity.require_signatures" described in the next item. The IPE LSM
> +   relies on this behavior to save verified signatures into LSM blobs.

No, IPE doesn't do that.

- Eric

