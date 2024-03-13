Return-Path: <linux-kernel+bounces-101118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE3387A2A5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 06:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7400EB21EA0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 05:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0BD12E51;
	Wed, 13 Mar 2024 05:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P+S77Cbv"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443FB1170D
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 05:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710307552; cv=none; b=gNhXzj0FTqwlomxFJudzmyc+aerItLWk9LiKmL98REobhqvQHRoDUizUiXKfAxAvk41ERGZXFsRz4JVsampU2qKMeWbhtzP9yh7fsMp9iD1ZKGq5CGIgumFx1ecv8UEx6+JHjM/IWaZh6wyCOr0xgPdW2xbPxsWu0bTe30rmwzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710307552; c=relaxed/simple;
	bh=U082R9f8QHQikkj8wyoDNjs8Q6Vy8eSEziBlE2TaBhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AG8lfJgC9uoGA9Jto0he3JNdBXebbcm+ICrHfPaalgp+4LXahJEFvBVdyctLWUHlRJgAniq4+oDhx7O+Es9tAqzNZTGovU+Zkzc7SiMWfUfPHDTYtLW4vzVwXqp7tUJu+oY3ZIF1t/VxsrZhQv1InPDjyokNVgPUZc4tRKJfR6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P+S77Cbv; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 12 Mar 2024 22:25:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1710307548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NomWHFCSkpM8sEFTgc7adym5XzSbOJbpoSf/LX/csZo=;
	b=P+S77Cbvb0JhiNYlZXDUJUSYMP3TsgkpGiEpqktrF95FzZmXHWLhLANGdbwC9wncQg736t
	FM/sbsxwdCfaaDvZj4GqpFf1tbp4nbZOcYBsvErat+rKvrpliwqeLHoEqccyiu94HH0VgU
	EOrbbdDhO8z4QCMVfnJG8r2iFLwHf2w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: cheung wall <zzqq0103.hey@gmail.com>
Cc: Marc Zyngier <maz@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: WARNING in kvm_age_gfn
Message-ID: <ZfE41uSsTUmbtl6A@thinky-boi>
References: <CAKHoSAurcujiErjTeWM+ZGkSVVOj3zQu2ED5rZsSLq-+FXb1qQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKHoSAurcujiErjTeWM+ZGkSVVOj3zQu2ED5rZsSLq-+FXb1qQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

Hi,

On Wed, Mar 13, 2024 at 01:02:10PM +0800, cheung wall wrote:
> Hello,
> 
> when using Syzkaller to fuzz the latest Linux Kernel arm64 version,
> the following crash

First, thank you. Glad to see folks are fuzzing KVM/arm64 now.

> was triggered on:
> 
> HEAD commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a  (tag: v6.7)

In order for these sorts of bug reports to be actionable, they really
need to be against a close-to-upstream tree. 6.8 is out now, and 6.9-rc1
is right around the corner.

Having said that, I think there might be an issue or two with your bot
because...

> git tree: upstream
> 
> console output: https://pastebin.com/raw/3NCyqPUn
> 
> kernel config: https://pastebin.com/raw/mXEg4abU
> 
> C reproducer: https://pastebin.com/raw/N0gEqk5x

This reproducer doesn't work on upstream (tested kvmarm-6.9 tag), and

> WARNING: CPU: 0 PID: 711 at arch/arm64/kvm/mmu.c:1592
> kvm_age_gfn+0x64/0xdc
> data/embfuzz/emblinux/linux-4a61839152cc3e9e00ac059d73a28d148d622b30/arch/arm64/kvm/mmu.c:1592

The SHA1 in this path is suspiciously the same as 6.1.61. Are you
certain the bot is working on the correct tree? Nevertheless, I think
the WARN and associated bug were addressed in commit df6556adf27b
("KVM: arm64: Correctly handle page aging notifiers for unaligned
memslot").

Last thing -- I'm guessing your syzkaller runs will dredge up quite a bit
of low-hanging bugs given how little exposure this code has had. Could
you please aggregate the first batch of reports and send as a single
series of email? Makes it much easier to keep track of.

-- 
Thanks,
Oliver

