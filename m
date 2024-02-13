Return-Path: <linux-kernel+bounces-63939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 545A9853698
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5D6F1F24F30
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268442C695;
	Tue, 13 Feb 2024 16:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nzMkqDRU"
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5489025565
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 16:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707843084; cv=none; b=iju5Vbr4YJqgD/eUVcQw62nmhkKm65J3LlkPGKHRHlgQ5Uzag6HaobPrr4K55lNYE6pZl1oh6nWQhPX8+xOteBp2B8dNKxMtYQtzEDedCd4Lp6EuKRKahXop1ayzjX7FNAVCMqCcXM9iBYF+SE4PUydDih2Cv0z++6zpf5s0DoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707843084; c=relaxed/simple;
	bh=kl7ymghwoEm5fD1aXGSjAnJFh0kINLOOXi5jM40r5aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JXXhP1oM8hxCyoUD5cpuvjxKTU5VJeycHFKnQBY29hoHW1+dq+18zTzcmm3mPZpv32kW8s7A6GXlJgE89fUBc+ppzQYk0hg7MtxmsygJ0BQmlnR3OuSUjfUtkwUjpgVX1G1nQxJ9NtEMCVw0H0+GALygVhNX9VwE/FaWVfvJ/gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nzMkqDRU; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 13 Feb 2024 16:51:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707843080;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=E+a8il656wm0JNzy2XZ2whgFkgYGy3mjL1DXh5soG1M=;
	b=nzMkqDRU7++7XpYRT6myB0KFUTXU8HbtM7x7fHvME6+8jN1MOBq0WYcuhXR+N3AN/q3TMQ
	cPMI15KvdQT7jxXBwqTPjA9SGQ6QZxcPeWRIQmd5G3IC8nEE//IW38C5yea3gtmEGxhKj5
	kthep06gyAyeELiwUsqhVRffxI7r6bw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Sebastian Ene <sebastianene@google.com>
Cc: catalin.marinas@arm.com, gshan@redhat.com, james.morse@arm.com,
	mark.rutland@arm.com, maz@kernel.org, rananta@google.com,
	ricarkol@google.com, ryan.roberts@arm.com, shahuang@redhat.com,
	suzuki.poulose@arm.com, will@kernel.org, yuzenghui@huawei.com,
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kernel-team@android.com,
	vdonnefort@google.com
Subject: Re: [PATCH v5 3/4] KVM: arm64: Register ptdump with debugfs on guest
 creation
Message-ID: <ZcueAGbQISkxaTNR@linux.dev>
References: <20240207144832.1017815-2-sebastianene@google.com>
 <20240207144832.1017815-5-sebastianene@google.com>
 <Zcq-NGa-Gd9rVVgF@linux.dev>
 <Zcub87FwaVPkCXQE@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zcub87FwaVPkCXQE@google.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 13, 2024 at 04:42:27PM +0000, Sebastian Ene wrote:
> On Tue, Feb 13, 2024 at 12:56:20AM +0000, Oliver Upton wrote:
> > On Wed, Feb 07, 2024 at 02:48:32PM +0000, Sebastian Ene wrote:

[...]

> > > +static int kvm_ptdump_guest_open(struct inode *inode, struct file *file)
> > > +{
> > > +	return single_open(file, kvm_ptdump_guest_show, inode->i_private);
> > > +}
> > > +
> > 
> > Shouldn't we take a reference on the KVM struct at open to avoid UAF?
> > 
> > 	struct kvm *kvm = inode->i_private;
> > 
> > 	if (!kvm_get_kvm_safe(kvm))
> > 		return -ENOENT;
> > 
> > Then you can do a put on it at close().
> > 
> 
> Thanks, I though that the kvm_destroy_vm_debugfs will keep spinning if
> there are opened paths to the debugfs entry, but I guess nothing prevents
> that from happening and the kvm struct can be removed behind our back.

kvm_destroy_vm() will get called after the last put() on a kvm struct,
so all debugfs files should be closed too if we're consistent about
this.

-- 
Thanks,
Oliver

