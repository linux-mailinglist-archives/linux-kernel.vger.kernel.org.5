Return-Path: <linux-kernel+bounces-96272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC1B387598C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 22:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A60262884CC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 21:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5495513B79B;
	Thu,  7 Mar 2024 21:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6/UN6Dd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971F318B1B;
	Thu,  7 Mar 2024 21:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709847769; cv=none; b=n6nQFSqSWE3qWCI6j5379xIlgX2QKkH3so93ppt6yaP0twnzFQoGSIJU/nTt1nbZz25VhhvH7EJ8TMTv/4uLOApLn7ApCWax1eBHlX9E26Cw1atDEPLSOK5eNi7BAl0+5iqK7kYMAZNZCBuPmGiY91ob5yU7dx/UAQP70IWFdGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709847769; c=relaxed/simple;
	bh=8XuCVPF590rPxYXu7ldG9ZXSXyPh8TaCqTdhQ8IANrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvJf1DQRYNmD2FFYdAMQldYEvl2ULMIi/fWPK/wWr8/Hn9icxWolJuG4txE1D6dYrPuSrQhPlW/5k8jJ5nvo/QxqngYvsp9XLnUaT+j39hnocdhtHD3PDiE1UhseXBF8WLK5KIIXNcOWUYRj0Y6euyIPJF4Y0PTtgIxd1fHArjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6/UN6Dd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5321C433F1;
	Thu,  7 Mar 2024 21:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709847769;
	bh=8XuCVPF590rPxYXu7ldG9ZXSXyPh8TaCqTdhQ8IANrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h6/UN6DdfOsJsNGmfnzXYMCgBGPlJvcjNckhZgIRgoh2u07kuVeRK/HYaRxWJcpWy
	 lyR8w5F12v8+Qos5W7JU1+EtXyXU2y03etFcD6m0HA7t46l/QB+ALkTCpSlS/f3Kt3
	 NIcSPG2I8WfQb276HDQ52lhfDvRVzN6IP+Np0wglKRKiqnBwHRY1yoLbQlv7TlXI79
	 2QBhmf0httu9RA9NaggO8HlkmkCF3k/8X1b9Gx5RUKUqK+GYs7JPrz2h7S8nyd3h3s
	 C+01rVNmlNzRBJ4SHRrOgy1xcU9AVQj7mFfqhpd7RxR5Dyv1du5+O+am+MdFDhod50
	 2po77yHPtX6zg==
Date: Thu, 7 Mar 2024 15:42:45 -0600
From: Rob Herring <robh@kernel.org>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: mpe@ellerman.id.au, linux-integrity@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	jarkko@kernel.org, rnsastry@linux.ibm.com, peterhuewe@gmx.de,
	viparash@in.ibm.com
Subject: Re: [PATCH 0/2] Preserve TPM log across kexec
Message-ID: <20240307214245.GA3110385-robh@kernel.org>
References: <20240306155511.974517-1-stefanb@linux.ibm.com>
 <b6f74cd0-d1c8-4a6f-a05d-364595c5b079@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6f74cd0-d1c8-4a6f-a05d-364595c5b079@linux.ibm.com>

On Wed, Mar 06, 2024 at 11:08:20AM -0500, Stefan Berger wrote:
> 
> 
> On 3/6/24 10:55, Stefan Berger wrote:
> > This series resolves an issue on PowerVM and KVM on Power where the memory
> > the TPM log was held in may become inaccessible or corrupted after a kexec
> > soft reboot. The solution on these two platforms is to store the whole log
> > in the device tree because the device tree is preserved across a kexec with
> > either of the two kexec syscalls.
> > 
> FYI: This was the previous attempt that didn't work with the older kexec
> syscall: https://lore.kernel.org/lkml/4afde78d-e138-9eee-50e0-dbd32f4dcfe0@linux.ibm.com/T/#m158630d214837e41858b03d4b025e6f96cb8f251

Doesn't everyone else still need that? Is powerpc the only ones that 
care about the old kexec syscall?

Rob

