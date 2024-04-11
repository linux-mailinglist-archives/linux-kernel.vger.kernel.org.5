Return-Path: <linux-kernel+bounces-140571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 624EF8A1650
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:52:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 940731C21628
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 13:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D709814D6E4;
	Thu, 11 Apr 2024 13:52:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9BF14D43D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 13:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712843551; cv=none; b=bbYL+eC51Muqvj+A55KKCJQxO5zn6ylgnDQF5Uq5OfKCxtpG1mB97ASjm2Uet1cxSCaC8UgNtnAYBjSyZwJxanw+0cuoPOn+eXgbxCXGk9AYrK49TTLeMDX5WRiN/FYixYkTMWOXrbG85vyHnQGe135dQeNRh2r6RoDd6/Dx/to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712843551; c=relaxed/simple;
	bh=y72LVtDAXHaQJl7bjQox90EFvWv8Cf6agT5GLJGf4DI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBNPrDwx+9QNffOHNU3Wre1FmcWbBFcM9FVmCLYu8gDWkxyptQtPgZY9QRnw0TSrbrAZ9I8kRSBGRkq0QE78kR4omlMcu0Y6D22DSTCVqKSSnRuDiIGxRIRFWj3fwicpRa35BZ+/f+s97XHIfIj2n3iN8ngRdjk/QH3aTiCKdio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10B3D339;
	Thu, 11 Apr 2024 06:52:59 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B590B3F64C;
	Thu, 11 Apr 2024 06:52:26 -0700 (PDT)
Date: Thu, 11 Apr 2024 14:52:20 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: James Morse <james.morse@arm.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com, lcherian@marvell.com,
	bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
	dfustini@baylibre.com, amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: Re: [PATCH v1 00/31] x86/resctrl: Move the resctrl filesystem code
 to /fs/resctrl
Message-ID: <ZhfrFLMbjVLf+S5f@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321165106.31602-1-james.morse@arm.com>

On Thu, Mar 21, 2024 at 04:50:35PM +0000, James Morse wrote:
> Hello!
> 
> This is the final series that allows other architectures to implement resctrl.
> The last patch just moves the code, and its a bit of a monster. I don't expect
> that to get merged as part of this series - we should wait for it to make
> less impact on other series. It's included here to show what gets moved, and
> that structures/function-prototypes have the right visibility.
> 
> Otherwise this series renames functions and moves code around. With the
> exception of invalid configurations for the configurable-events, there should
> be no changes in behaviour caused by this series.
> 
> The driving pattern is to make things like struct rdtgroup private to resctrl.
> Features like pseudo-lock aren't going to work on arm64, the ability to disable
> it at compile time is added.
> 
> After this, I can start posting the MPAM driver to make use of resctrl on arm64.
> (What's MPAM? See the cover letter of the first series. [1])
> 
> This series is based on Linus' commit 23956900041d and can be retrieved from:
> https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git
> mpam/move_to_fs/v1
> 
> Sorry for the mid-merge window base, I'm away for a few weeks - this should
> rebase trivially onto rc1.
> 
> As ever - bugs welcome,
> Thanks,
> 
> James
> 
> [1] https://lore.kernel.org/lkml/20201030161120.227225-1-james.morse@arm.com/

[...]

Hi all,

I'm going to try to give a preliminary response to review feedback while
James is away, to help move this series forward.

Many thanks to those who have reviewed / commented so far!


Apologies for the slow-ish response from me: I'm still not that familiar
with this code, so I wanted to make sure I had broadly covered most of
the simpler comments before I started sending replies.

N.B.: where I say "Noted", I mean that I've stashed a fixup for James
to review when he gets back.  Most of these seem straightforward and
uncontroversial, but it's his code, so it will be up to him what
changes actually get incorporated in the respin.

Cheers
---Dave

