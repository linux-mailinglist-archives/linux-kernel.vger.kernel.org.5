Return-Path: <linux-kernel+bounces-22580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A72C829FF7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECB1F1F2A6CC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83BB4D5A4;
	Wed, 10 Jan 2024 17:58:20 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667DB4D584;
	Wed, 10 Jan 2024 17:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8156C43399;
	Wed, 10 Jan 2024 17:58:17 +0000 (UTC)
Date: Wed, 10 Jan 2024 17:58:15 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Ido Schimmel <idosch@idosch.org>, joro@8bytes.org, will@kernel.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	zhangzekun11@huawei.com, john.g.garry@oracle.com,
	dheerajkumar.srivastava@amd.com, jsnitsel@redhat.com
Subject: Re: [PATCH v3 0/2] iommu/iova: Make the rcache depot properly
 flexible
Message-ID: <ZZ7atzgT6_kOvWnJ@arm.com>
References: <cover.1694535580.git.robin.murphy@arm.com>
 <ZY1osaGLyT-sdKE8@shredder>
 <c9cf02b5-7add-46ea-8db1-46fdce191c1c@arm.com>
 <ZZ2AqZT4dD-s01q9@shredder>
 <ab22c439-e7da-49b5-b20b-856daf376c02@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ab22c439-e7da-49b5-b20b-856daf376c02@arm.com>

On Wed, Jan 10, 2024 at 12:48:06PM +0000, Robin Murphy wrote:
> On 2024-01-09 5:21 pm, Ido Schimmel wrote:
> > On Mon, Jan 08, 2024 at 05:35:26PM +0000, Robin Murphy wrote:
> > > Hmm, we've got what looks to be a set of magazines forming a plausible depot
> > > list (or at least the tail end of one):
> > > 
> > > ffff8881411f9000 -> ffff8881261c1000
> > > 
> > > ffff8881261c1000 -> ffff88812be26400
> > > 
> > > ffff88812be26400 -> ffff8188392ec000
> > > 
> > > ffff8188392ec000 -> ffff8881a5301000
> > > 
> > > ffff8881a5301000 -> NULL
> > > 
> > > which I guess has somehow become detached from its rcache->depot without
> > > being freed properly? However I'm struggling to see any conceivable way that
> > > could happen which wouldn't already be more severely broken in other ways as
> > > well (i.e. either general memory corruption or someone somehow still trying
> > > to use the IOVA domain while it's being torn down).
> > 
> > The machine is running a debug kernel that among other things has KASAN
> > enabled, but there are no traces in the kernel log so there is no memory
> > corruption that I'm aware of.
> > 
> > > Out of curiosity, does reverting just patch #2 alone make a difference?
> > 
> > Will try and let you know.
> > 
> > > And is your workload doing anything "interesting" in relation to IOVA
> > > domain lifetimes, like creating and destroying SR-IOV virtual
> > > functions, changing IOMMU domain types via sysfs, or using that
> > > horrible vdpa thing, or are you seeing this purely from regular driver
> > > DMA API usage?
> > 
> > The machine is running networking related tests, but it is not using
> > SR-IOV, VMs or VDPA so there shouldn't be anything "interesting" as far
> > as IOMMU is concerned.
> > 
> > The two networking drivers on the machine are "igb" for the management
> > port and "mlxsw" for the data ports (the machine is a physical switch).
> > I believe the DMA API usage in the latter is quite basic and I don't
> > recall any DMA related problems with this driver since it was first
> > accepted upstream in 2015.
> 
> Thanks for the clarifications, that seems to rule out all the most
> confusingly impossible scenarios, at least.
> 
> The best explanation I've managed to come up with is a false-positive race
> dependent on the order in which kmemleak scans the relevant objects. Say we
> have the list as depot -> A -> B -> C; the rcache object is scanned and sees
> the pointer to magazine A, but then A is popped *before* kmemleak scans it,
> such that when it is then scanned, its "next" pointer has already been
> wiped, thus kmemleak never observes any reference to B, so it appears that B
> and (transitively) C are "leaked".

Transient false positives are possible, especially as the code doesn't
use a double-linked list (for the latter, kmemleak does checksumming and
detects the prev/next change, defers the reporting until the object
becomes stable). That said, if a new scan is forced (echo scan >
/sys/kernel/debug/kmemleak), are the same objects still listed as leaks?
If yes, they may not be transient.

If it is indeed transient, I think a better fix than kmemleak_not_leak()
is to add a new API, something like kmemleak_mark_transient() which
resets the checksum, skips the object reporting for one scan.

-- 
Catalin

