Return-Path: <linux-kernel+bounces-157991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF1A88B19E5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C387288309
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 04:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E67F2D60A;
	Thu, 25 Apr 2024 04:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fr6BdhPG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBFD381D1;
	Thu, 25 Apr 2024 04:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714018807; cv=none; b=Ho3oIwpTATrOzFl0wfy2MnaP1bXgyaID4v5iZUjke7nSfMvV+SuUMC/MqO+CRauxTnCzXsHpM9zRVTi4vcO2a3FI59WtIWpwZJg2SIMLgv9S6JUQL8wZHBgBPOE/iP1284UfgopDpaBJP0B2XL11tsjFGD0pP2GlddcW8Zp7uHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714018807; c=relaxed/simple;
	bh=6Q5z/VuefyBz5xlrVI2RtNv+VDFHR+jrmgQLbhi7Vxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Shmnsfw4hk3dYi/57PKRoQYdx/cJb9fhhXYW2LHakSCU+Tqg3eFKtI2PF0LdRm4LvufhNBg10FkjxOOh6qeuAKgZtSpAoFMGvKReEqWyvkarLbDCkGnNamSPQ3rsFXmZE9Rvt6VopeANfarStXhHCzxoRiqpUPC2cqk3sCYD5Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fr6BdhPG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE4AC113CC;
	Thu, 25 Apr 2024 04:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714018806;
	bh=6Q5z/VuefyBz5xlrVI2RtNv+VDFHR+jrmgQLbhi7Vxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fr6BdhPGjWVRWdhum3Su32wXdT5XXfFp2wqD0TDmhui0+Jmu/IinfMBMqB3i/iyL5
	 yojAKkxx7zb0W+WqCXhdGoZcwIxUZAY/nkp7eiwn8eKu7a4qpLxb/CzC5355yFQJ/X
	 tjAektB6zSy7ig5ovTT1b4e1zzkRoupzXGIcaZTLZs5yo+89+j8SP+mZO2pJCw2s9l
	 K+n8XbLEEwm8nt83T6ei6l1A0H+W6eVsCQj8NO+arq/Nzj/GIG/H6Gy0IGNc+0HI9d
	 DUI3G+UCdPY/DftGIM3bHSGTjA1RjSYgYYd0AsQjD2CeKNQMb9CaD6WxKbpIhlBvwH
	 wkUAvSDzuaKjA==
Date: Wed, 24 Apr 2024 21:20:04 -0700
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
Message-ID: <20240425042004.GE1401@sol.localdomain>
References: <1712969764-31039-1-git-send-email-wufan@linux.microsoft.com>
 <1712969764-31039-18-git-send-email-wufan@linux.microsoft.com>
 <20240425034233.GB1401@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425034233.GB1401@sol.localdomain>

On Wed, Apr 24, 2024 at 08:42:33PM -0700, Eric Biggers wrote:
> On Fri, Apr 12, 2024 at 05:56:00PM -0700, Fan Wu wrote:
> > +config IPE_PROP_FS_VERITY
> > +	bool "Enable property for fs-verity files"
> > +	depends on FS_VERITY && FS_VERITY_BUILTIN_SIGNATURES
> > +	help
> > +	  This option enables the usage of properties "fsverity_signature"
> > +	  and "fsverity_digest". These properties evaluate to TRUE when
> > +	  a file is fsverity enabled and has a valid builtin signature
> > +	  whose signing cert is in the .fs-verity keyring or its
> > +	  digest matches the supplied value in the policy.
> > +
> > +	  if unsure, answer Y.
> 
> Does this really need to depend on FS_VERITY_BUILTIN_SIGNATURES?  That's needed
> for fsverity_signature to work, but fsverity_digest would work without it.
> 
> I'd prefer if people had the option of only turning on
> FS_VERITY_BUILTIN_SIGNATURES if they really need it.
> 

I see that IPE_PROP_DM_VERITY is auto-selected when
DM_VERITY && DM_VERITY_VERIFY_ROOTHASH_SIG.  That differs from
IPE_PROP_FS_VERITY.  Should they really differ in this way?

Would it perhaps make more sense to not have the IPE_PROP_DM_VERITY and
IPE_PROP_FS_VERITY kconfig options at all, and instead just support the
corresponding IPE properties when the underlying kconfig options are enabled
(and SECURITY_IPE is also enabled)?

    DM_VERITY => dmverity_roothash
    DM_VERITY_VERIFY_ROOTHASH_SIG => dmverity_signature
    FS_VERITY => fsverity_digest
    FS_VERITY_BUILTIN_SIGNATURES => fsverity_signature

That would keep the number of kconfig options down, while also not forcing
people to enable the signature support in dm-verity and fsverity if they'd like
to use digests only.

- Eric

