Return-Path: <linux-kernel+bounces-109186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 672C78815E5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98AF81C21F8C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5428A69DEF;
	Wed, 20 Mar 2024 16:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="trlNMbDm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9697A628
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 16:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710953491; cv=none; b=Hna/oKLOG/eGT38YhvCezhYJ3h9L4Mm3jqx9CJ4NYsgS8dAceFYdPm6q56Yh20FYrKQz3eUuxmHmbr+ZZcTrprdXU9yOUbhUL282TN1r1PqFyquwK+mO6reWuMu+pGQkfaBJ5LgevWfSytPg8Gvz/0p4V4bL2SgjPTuL7wJF43A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710953491; c=relaxed/simple;
	bh=k3T/uNTIK394HGKNsWzz5m5WSLviK3mIcygBQu5unSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jprkGdIxXWeBthEQdDhTYj9hbqpk4PLokWa23obH0cjz0YAeo/Ssffym5qTK7+AHsDkqCMoz5470w7zYevprXeNmKja+ZbNE6An4mvUrhP6K28wAfixTzQ7DbcHKnuUpQ4DZccCL+c5xsMYMKEDdN7Za6BEly3qU/xSGwA88L10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=trlNMbDm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDFE1C433F1;
	Wed, 20 Mar 2024 16:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710953491;
	bh=k3T/uNTIK394HGKNsWzz5m5WSLviK3mIcygBQu5unSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=trlNMbDm31J1SCQWMEI+ulyAPL40MOeiddWj5UINKfpaBaYk+ZKLTJa4iupAyMix3
	 Cwt+4Sg4OGvFZfy623wDwEWMSzZ6P+X1flbGP2z+wXmt86axw78Zu42/E9uTQiaZ1V
	 luEkoB6YRQW+VbOlF3ZuUCAmIuOVHuwC9wuAdUDXSIp7djhUtLHbbaBiKCrH2HpnP0
	 lT6u4dhshOhdSnJK0EVwoSORhr5bPiDofv6TQjnwNNcf2Pgkid/Nsxe/hzRlR6U3OK
	 vcaF25SayuKKURNj8CAmXsGcu63H/Li2BwZEgkSWt/ItSrkgUYmEO98bxvkkYtl/qF
	 /afJ38WUrBQBw==
Date: Wed, 20 Mar 2024 16:51:27 +0000
From: Lee Jones <lee@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Felix Kuehling <felix.kuehling@amd.com>
Subject: Re: CVE-2024-26628: drm/amdkfd: Fix lock dependency warning
Message-ID: <20240320165127.GV1522089@google.com>
References: <2024030649-CVE-2024-26628-f6ce@gregkh>
 <Zerheyn-4rB5kySt@tiehlicka>
 <20240314110938.GM1522089@google.com>
 <ZfsBpal_29lihveI@tiehlicka>
 <20240320154734.GU1522089@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240320154734.GU1522089@google.com>

On Wed, 20 Mar 2024, Lee Jones wrote:

> On Wed, 20 Mar 2024, Michal Hocko wrote:
> 
> > On Thu 14-03-24 11:09:38, Lee Jones wrote:
> > > On Fri, 08 Mar 2024, Michal Hocko wrote:
> > > 
> > > > On Wed 06-03-24 06:46:11, Greg KH wrote:
> > > > [...]
> > > > >  Possible unsafe locking scenario:
> > > > > 
> > > > >        CPU0                    CPU1
> > > > >        ----                    ----
> > > > >   lock(&svms->lock);
> > > > >                                lock(&mm->mmap_lock);
> > > > >                                lock(&svms->lock);
> > > > >   lock((work_completion)(&svm_bo->eviction_work));
> > > > > 
> > > > > I believe this cannot really lead to a deadlock in practice, because
> > > > > svm_range_evict_svm_bo_worker only takes the mmap_read_lock if the BO
> > > > > refcount is non-0. That means it's impossible that svm_range_bo_release
> > > > > is running concurrently. However, there is no good way to annotate this.
> > > > 
> > > > OK, so is this even a bug (not to mention a security/weakness)?
> > > 
> > > Looks like the patch fixes a warning which can crash some kernels.  So
> > > the CVE appears to be fixing that, rather than the impossible deadlock.
> > 
> > Are you talking about lockdep warning or anything else?
> 
> Anything that triggers a BUG() or a WARN() (as per the splat in the
> commit message).  Many in-field kernels are configured to panic on
> BUG()s and WARN()s, thus triggering them are presently considered local
> DoS and attract CVE status.

We have discussed this internally and agree with your thinking.

The splat in the circular lockdep detection code appears to be generated
using some stacked pr_warn() calls, rather than a WARN().

Thus, CVE-2024-26628 has now been rejected.

  https://lore.kernel.org/all/20240320164818.3778843-2-lee@kernel.org/

Thank you for your input Michal.

-- 
Lee Jones [李琼斯]

