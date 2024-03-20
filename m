Return-Path: <linux-kernel+bounces-109118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A34308814DA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B503281EC2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EB752F78;
	Wed, 20 Mar 2024 15:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EKvZhIK5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F2842044
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 15:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710949659; cv=none; b=d8XMEn6g48HJae74/mfA6BK18ATfpvUudAc53b2uaw71vUzNkvm2eAXngKDEzY6msmZtnjFwL8hYFHH0+15K/v9IATtlg0S0MzIC9Yk2mEBq7OSs6SoEuvgpx8XKE/nzu/h62ulQ4vRYlInupbG/eF2WkmlIkvEHhfNqYa6FHFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710949659; c=relaxed/simple;
	bh=mUoJODB1lmpv16ZURDDCEe7Bc4tasw9LwAOQ/nPQyj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6t0Sa6aMWqbfT6NPkGz7MpuoZWYeLdROrO0u+B3iT8uuMJJ1fNHV1NBjknZ0weYqgViCkUXjdDk4+jnjROgUWbwR80WsdA49S8Rgz1gLxqmkE08fYSRjC2grx8TRKt6BI9T86bPnPYEJZDAQxsPAFuGHUe3BVyYxaOneass13w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EKvZhIK5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83B1EC433C7;
	Wed, 20 Mar 2024 15:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710949658;
	bh=mUoJODB1lmpv16ZURDDCEe7Bc4tasw9LwAOQ/nPQyj0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EKvZhIK50g+QVMysknChhxWDMvb+JMELxCLyxo/ElvdaJIYtX+YHwAyujhnbayAIB
	 dOEWCAMmSBrTTFyCqS6JXvqdzJpSne+L8VThzMsdqOtL9jAJsbL6e+13D8SocaQ6e3
	 lzoyAmnIhURiIkTB/94YgbTwIBDkEBrbybf8oU/TxEmRd2oi03vRVDaZ1tX4tZF07L
	 iIQ+8HeiF6LEjdem+Bv+ZnfJawlx/WgUAuuGuR1gtUyFLrDxkTSz5Ot76QSEtr7qm9
	 ZcVjITj8CLOfGNgWHbB11piSLuN6RuWxTBJ8u/i//g63Xi2FU/wD+3ggW375WtNHmj
	 0age3Ui/fr+HQ==
Date: Wed, 20 Mar 2024 15:47:34 +0000
From: Lee Jones <lee@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: CVE-2024-26628: drm/amdkfd: Fix lock dependency warning
Message-ID: <20240320154734.GU1522089@google.com>
References: <2024030649-CVE-2024-26628-f6ce@gregkh>
 <Zerheyn-4rB5kySt@tiehlicka>
 <20240314110938.GM1522089@google.com>
 <ZfsBpal_29lihveI@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZfsBpal_29lihveI@tiehlicka>

On Wed, 20 Mar 2024, Michal Hocko wrote:

> On Thu 14-03-24 11:09:38, Lee Jones wrote:
> > On Fri, 08 Mar 2024, Michal Hocko wrote:
> > 
> > > On Wed 06-03-24 06:46:11, Greg KH wrote:
> > > [...]
> > > >  Possible unsafe locking scenario:
> > > > 
> > > >        CPU0                    CPU1
> > > >        ----                    ----
> > > >   lock(&svms->lock);
> > > >                                lock(&mm->mmap_lock);
> > > >                                lock(&svms->lock);
> > > >   lock((work_completion)(&svm_bo->eviction_work));
> > > > 
> > > > I believe this cannot really lead to a deadlock in practice, because
> > > > svm_range_evict_svm_bo_worker only takes the mmap_read_lock if the BO
> > > > refcount is non-0. That means it's impossible that svm_range_bo_release
> > > > is running concurrently. However, there is no good way to annotate this.
> > > 
> > > OK, so is this even a bug (not to mention a security/weakness)?
> > 
> > Looks like the patch fixes a warning which can crash some kernels.  So
> > the CVE appears to be fixing that, rather than the impossible deadlock.
> 
> Are you talking about lockdep warning or anything else?

Anything that triggers a BUG() or a WARN() (as per the splat in the
commit message).  Many in-field kernels are configured to panic on
BUG()s and WARN()s, thus triggering them are presently considered local
DoS and attract CVE status.

-- 
Lee Jones [李琼斯]

