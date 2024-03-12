Return-Path: <linux-kernel+bounces-100118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EAE879200
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FF5C2842AF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C1379B67;
	Tue, 12 Mar 2024 10:26:20 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548F478669
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 10:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710239179; cv=none; b=C9WqN9zjVyD2bfK+DGCnnQz/4DT5hGnlkRVoliCK5+HgHptl/EAGhu8+1IYN7mL716szPy6gX2euyoo6RSkUYKmbIXlEKa+eRbNOXZrnFJDW+It3pYe81PuX/pGyf3aYQkt35x1JTKPSS8MJbq6QoOKXFCH1QMzD6IYN31OgzCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710239179; c=relaxed/simple;
	bh=HD+ZxE6ZvPbaPpxNsrQp6Iu8cFzIf+/HcvFLAb/rjHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpjdrhrjdSv1kAEW8zNSmt0j1Lu+koDuEpbxQRme5i/pMng4bSGTGqQWuOgjLs5FT5UReX95NaSGDAiwxWu1+9dKRO5qwd4nA1SgHZBud+3hwDfhKY10nQwJSsmIP68IwSlRfBbSEs21jHGifeZ1s70YwNytLpC7KzTwT04Jrn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 028831007;
	Tue, 12 Mar 2024 03:26:55 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F05C3F73F;
	Tue, 12 Mar 2024 03:26:15 -0700 (PDT)
Date: Tue, 12 Mar 2024 10:26:09 +0000
From: Joey Gouly <joey.gouly@arm.com>
To: David Hildenbrand <david@redhat.com>
Cc: Shivansh Vij <shivanshvij@outlook.com>, shivanshvij@loopholelabs.io,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	James Houghton <jthoughton@google.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Peter Collingbourne <pcc@google.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/mm: adds soft dirty page tracking
Message-ID: <20240312102609.GA1631865@e124191.cambridge.arm.com>
References: <MW4PR12MB687563EFB56373E8D55DDEABB92B2@MW4PR12MB6875.namprd12.prod.outlook.com>
 <ff65f353-6aa6-46a0-94fe-892e7b950d35@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff65f353-6aa6-46a0-94fe-892e7b950d35@redhat.com>

On Tue, Mar 12, 2024 at 09:22:25AM +0100, David Hildenbrand wrote:
> On 12.03.24 02:16, Shivansh Vij wrote:
> 
> Hi,
> 
> > Checkpoint-Restore in Userspace (CRIU) needs to be able
> > to track a memory page's changes if we want to enable
> > pre-dumping, which is important for live migrations.
> > 
> > The PTE_DIRTY bit (defined in pgtable-prot.h) is already
> > used to track software dirty pages, and the PTE_WRITE and
> > PTE_READ bits are used to track hardware dirty pages.
> > 
> > This patch enables full soft dirty page tracking
> > (including swap PTE support) for arm64 systems, and is
> > based very closely on the x86 implementation.
> > 
> > It is based on an unfinished patch by
> > Bin Lu (bin.lu@arm.com) from 2017
> > (https://patchwork.kernel.org/project/linux-arm-kernel/patch/1512029649-61312-1-git-send-email-bin.lu@arm.com/),
> > but has been updated for newer 6.x kernels as well as
> > tested on various 5.x kernels.
> 
> There has also been more recently:
> 
> https://lore.kernel.org/lkml/20230703135526.930004-1-npache@redhat.com/#r
> 
> I recall that we are short on SW PTE bits:
> 
> "
> So if you need software dirty, it can only be done with another software
> PTE bit. The problem is that we are short of such bits (only one left if
> we move PTE_PROT_NONE to a different location). The userfaultfd people
> also want such bit.
> 
> Personally I'd reuse the four PBHA bits but I keep hearing that they may
> be used with some out of tree patches.
> "
> 
> https://lore.kernel.org/lkml/ZLQIaSMI74KpqsQQ@arm.com/
> 

I have some patches on the list (Permission Overlay) that also uses bit 60

	series: https://lore.kernel.org/linux-arm-kernel/20231124163510.1835740-1-joey.gouly@arm.com/
	commit: https://lore.kernel.org/linux-arm-kernel/20231124163510.1835740-9-joey.gouly@arm.com/

I will be sending out a v4 of that in several weeks.

Thanks,
Joey

