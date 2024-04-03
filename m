Return-Path: <linux-kernel+bounces-129050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CCD98963D7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 187FD286F12
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 05:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F29487B6;
	Wed,  3 Apr 2024 05:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="soGyJg5H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10621645;
	Wed,  3 Apr 2024 05:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712121034; cv=none; b=bUhjD2qiR7A0/SHq8RqHayu9F5rIFF4n1T0rVvbyp8jnCeplTPTUy8E0WJb7FM1GmcAZZh3qrTvwTE/WvEqQIodzrYbuqGxizFGcoT01H9UgqTIxSjdSzIfzfoZwdWRSGBm+s1hmIW6qH5WvTi3yRX47FtcVVZrBplAcFKimQxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712121034; c=relaxed/simple;
	bh=nfMida/fwtgf6d9g/VzEFa7bAK2MwKc03M85xVMKpXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pKymvtannxk9XJlgHLrOs8gdl87w/uFZUq2gsOAj5uujrkzrZYRF4W8VcOq2CBRL91HsfimzSDze5dLWxfsRlHGBVXZ5Qh9w7FldsO++ceKorPH1Onj4CNmfdok9CR53g7UznoIOVOP0ld2E1atQsnB1KeD6T/1X6jOOOB6LuGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=soGyJg5H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB17C433C7;
	Wed,  3 Apr 2024 05:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712121033;
	bh=nfMida/fwtgf6d9g/VzEFa7bAK2MwKc03M85xVMKpXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=soGyJg5HUoztDgHwRzno02g7VWNaNwjWE8EJzeGEFWvEqlVnOv95t66xg0dFWdDsm
	 XAyyRG+qzesHn2tUz00OrC8EBuSOOGB8YyksVmIn7+nywRPuIf+tkY3I0hVwccgAxB
	 LV88ts4IKuLJSsyu0WKfjKSGMvjPvCMN492RMBmIu4Q/8cJmNTiJJGiIVXkenEVkZ+
	 sCeBB21FhOWGjrmkCpF9fIG1wagU4e6GcznzodJOxTWZGajmhmZALzUfbeaXMCoGRK
	 gmK4lsXCF7oQ3Jggov2yJLLgeFfSirdE24WLJvYSx2shbC8HMygRJyjY0PKghRN881
	 OMWLkAXEj4jUA==
Date: Tue, 2 Apr 2024 22:10:31 -0700
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
Subject: Re: [PATCH v16 17/20] ipe: enable support for fs-verity as a trust
 provider
Message-ID: <20240403051031.GK2576@sol.localdomain>
References: <1711657047-10526-1-git-send-email-wufan@linux.microsoft.com>
 <1711657047-10526-18-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1711657047-10526-18-git-send-email-wufan@linux.microsoft.com>

On Thu, Mar 28, 2024 at 01:17:24PM -0700, Fan Wu wrote:
> Enable IPE policy authors to indicate trust for a singular fsverity
> file, identified by the digest information, through "fsverity_digest"
> and all files using fsverity's builtin signatures via
> "fsverity_signature".

Again, I'm pretty sure you actually care about all files with *valid* builtin
signatures, not simply all files with builtin signatures...

> +/**
> + * ipe_inode_setintegrity - save integrity data from a inode to IPE's LSM blob.
> + * @inode: The inode to source the security blob from.
> + * @type: Supplies the integrity type.
> + * @value: The value to be stored.
> + * @size: The size of @value.
> + *
> + * Saves fsverity signature into inode security blob
> + *
> + * Return:
> + * * 0	- OK
> + * * !0	- Error
> + */
> +int ipe_inode_setintegrity(struct inode *inode, enum lsm_integrity_type type,
> +			   const void *value, size_t size)
> +{
> +	struct ipe_inode *inode_sec = ipe_inode(inode);
> +
> +	if (type == LSM_INT_FSVERITY_BUILTINSIG) {
> +		inode_sec->fs_verity_signed = size > 0 && value;
> +		return 0;
> +	}
> +
> +	return 0;

This is the actual code, and it's *still* documented incorrectly.  No, it
doesn't "Save fsverity signature into inode security blob".  All it actually
does is save a flag saying that there was a valid signature.

The flag also should be called something like fsverity_sig_valid, indicating
that there is a builtin signature *and* it's valid.

- Eric

