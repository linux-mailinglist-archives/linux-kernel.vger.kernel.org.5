Return-Path: <linux-kernel+bounces-157976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6AF8B19A8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:42:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 382A41C21456
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 03:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D73374F1;
	Thu, 25 Apr 2024 03:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oiiz9zVQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379A7249F9;
	Thu, 25 Apr 2024 03:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714016556; cv=none; b=gYaORCZD5/vNf5n4MIRcXOUHWM9V0O6/Z9pgL72DQ/xFt3jOrKS/vGMAASJBCIpMZvS9tsx0gcLTZSIRD2FuExeG4+Dd+/luYAgVufELlBp0ot6BIUHYfEiuppchfm7c86KcQ3vupTjlLYg0CeWMwtj++tT3u3j9d0jt7uaPXlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714016556; c=relaxed/simple;
	bh=meGItb0gYvU6XxtF1MngGAZWQ+39zegqnIascrO7roQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwOgf+3QQ1QscZ7PQMbEhfSBMVP98umiRPpQUKG00QhKETJ7QmCmkb5V5Ze6Zz4cMhizRAEb32mnfpYLy9K+H7Z3wYssamzboH63DtIUrB35m6y+Y5h8YihjXXD6+mweBDa9UKb2jrpZrVA6YeRzH5oTDi4n06cRD3+ssFw4Vhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oiiz9zVQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B926C113CE;
	Thu, 25 Apr 2024 03:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714016555;
	bh=meGItb0gYvU6XxtF1MngGAZWQ+39zegqnIascrO7roQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Oiiz9zVQNbAlp33I8T93khpL3VupBBWMtSQiwaM3Uucc2N0y+hHdyFVIrSLSjbaAK
	 pO3PhhVEVJuaxwt9zAToR4gWEZBI3gdFOImUsFtpwsjyJUBk1+b+jD4KBXkiaXpeZw
	 zjcCkFf2+D5wB9cj9mBf1G58Ke03FafRDraxMb0iZhSj2IEsItVz72U9HIAPzEJw+f
	 FVSu79CQbNKesa5KbI7rXP1kDOnPZt+qTTC3hHMQZd9RnT0vM6lS4CHz6snOjQ0Pxo
	 HywsHZf7COFo0jgNonuzWQ6iR+Y+yr2JDKSgLqI1I+rdQdY6ruL6yywXGe/+nDlU0d
	 aw75d72jfXQ4g==
Date: Wed, 24 Apr 2024 20:42:33 -0700
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
Subject: Re: [PATCH v17 17/21] ipe: enable support for fs-verity as a trust
 provider
Message-ID: <20240425034233.GB1401@sol.localdomain>
References: <1712969764-31039-1-git-send-email-wufan@linux.microsoft.com>
 <1712969764-31039-18-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1712969764-31039-18-git-send-email-wufan@linux.microsoft.com>

On Fri, Apr 12, 2024 at 05:56:00PM -0700, Fan Wu wrote:
> +config IPE_PROP_FS_VERITY
> +	bool "Enable property for fs-verity files"
> +	depends on FS_VERITY && FS_VERITY_BUILTIN_SIGNATURES
> +	help
> +	  This option enables the usage of properties "fsverity_signature"
> +	  and "fsverity_digest". These properties evaluate to TRUE when
> +	  a file is fsverity enabled and has a valid builtin signature
> +	  whose signing cert is in the .fs-verity keyring or its
> +	  digest matches the supplied value in the policy.
> +
> +	  if unsure, answer Y.

Does this really need to depend on FS_VERITY_BUILTIN_SIGNATURES?  That's needed
for fsverity_signature to work, but fsverity_digest would work without it.

I'd prefer if people had the option of only turning on
FS_VERITY_BUILTIN_SIGNATURES if they really need it.

- Eric

