Return-Path: <linux-kernel+bounces-28472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C30082FEF9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 03:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35CA9287F07
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 02:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533A71864;
	Wed, 17 Jan 2024 02:52:33 +0000 (UTC)
Received: from out0-216.mail.aliyun.com (out0-216.mail.aliyun.com [140.205.0.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1F54416
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 02:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705459952; cv=none; b=QVsYB6yqE69WDCoANrg6+rmjuLXBR2WaDFzOjqlv+/VnMnkM80LtGPNkVQEV98HjpVs1ozfNEC88N4NzsxMJ7dE6qJ+KUNypTkNm+3VXUq72Pe6rBNggq/DbQfpMdX/wyPHOMHRWD6hqLsW72P0QjSpR2sZNqX9pjShk3lQd/uQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705459952; c=relaxed/simple;
	bh=f2vOvPOp7ODqJoWpEW+g6YZ4ClQrHu8xwoToqzW/ISo=;
	h=X-Alimail-AntiSpam:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:User-Agent; b=kBETXzHd0YhfO9glyzrmmH+IaKQVqO6dJsQDO5htiCUHkxTR+ek/C9I8IukTSEf/xk2kayNnz1qzvK7N6OmKuihd2pgCtBiP64ijWS/niLMVLgDwOTcY0GAbqD+/6UsaXAn+8IOUYtGUHKt6Zc/jQfmaBcPMDSBgueg1zIzSkHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; arc=none smtp.client-ip=140.205.0.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018047212;MF=houwenlong.hwl@antgroup.com;NM=1;PH=DS;RN=44;SR=0;TI=SMTPD_---.W8.S.yY_1705459622;
Received: from localhost(mailfrom:houwenlong.hwl@antgroup.com fp:SMTPD_---.W8.S.yY_1705459622)
          by smtp.aliyun-inc.com;
          Wed, 17 Jan 2024 10:47:04 +0800
Date: Wed, 17 Jan 2024 10:47:02 +0800
From: "Hou Wenlong" <houwenlong.hwl@antgroup.com>
To: Kevin Loughlin <kevinloughlin@google.com>
Cc: Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Michael Kelley <mikelley@microsoft.com>,
	Pankaj Gupta <pankaj.gupta@amd.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Arnd Bergmann <arnd@arndb.de>,
	Steve Rutherford <srutherford@google.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Yuntao Wang <ytcoode@gmail.com>,
	Wang Jinchao <wangjinchao@xfusion.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Brian Gerst <brgerst@gmail.com>, Hugh Dickins <hughd@google.com>,
	Ard Biesheuvel <ardb@kernel.org>, Joerg Roedel <jroedel@suse.de>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	Brijesh Singh <brijesh.singh@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	linux-coco@lists.linux.dev, Ashish Kalra <ashish.kalra@amd.com>,
	Andi Kleen <ak@linux.intel.com>, Adam Dunlap <acdunlap@google.com>,
	Peter Gonda <pgonda@google.com>, Jacob Xu <jacobhxu@google.com>,
	Sidharth Telang <sidtelang@google.com>
Subject: Re: [RFC PATCH v2] x86/sev: enforce RIP-relative accesses in early
 SEV/SME code
Message-ID: <20240117024702.GA112065@k08j02272.eu95sqa>
References: <ZZ7YuEexYSaZYmLK@tassilo>
 <20240111223650.3502633-1-kevinloughlin@google.com>
 <20240115204634.GHZaWZqsVyU_fvn_RW@fat_crate.local>
 <CAGdbjm+fMBnkKDVFpf-fAEbYxTUWR0od2JzTTbEMoPVS3J_Faw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGdbjm+fMBnkKDVFpf-fAEbYxTUWR0od2JzTTbEMoPVS3J_Faw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Wed, Jan 17, 2024 at 08:07:49AM +0800, Kevin Loughlin wrote:
> On Mon, Jan 15, 2024 at 12:47 PM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Thu, Jan 11, 2024 at 10:36:50PM +0000, Kevin Loughlin wrote:
> > > SEV/SME code can execute prior to page table fixups for kernel
> > > relocation. However, as with global variables accessed in
> > > __startup_64(), the compiler is not required to generate RIP-relative
> > > accesses for SEV/SME global variables, causing certain flavors of SEV
> > > hosts and guests built with clang to crash during boot.
> >
> > So, about that. If I understand my gcc toolchain folks correctly:
> >
> > mcmodel=kernel - everything fits into the high 31 bit of the address
> > space
> >
> > -fPIE/PIC - position independent
> >
> > And supplied both don't make a whole lotta of sense: if you're building
> > position-independent, then mcmodel=kernel would be overridden by the
> > first.
> >
> > I have no clue why clang enabled it...
> >
> > So, *actually* the proper fix here should be not to add this "fixed_up"
> > gunk everywhere but remove mcmodel=kernel from the build and simply do
> > -fPIE/PIC.
> 
> I believe that the key distinction is that using mcmodel=kernel (upper
> 2 GB of address space) or the similar mcmodel=small (lower 2 GB) means
> the compiler *can* use RIP-relative addressing for globals (because
> everything is within +/- 2GB of RIP) but is not *required* to do so.
> In contrast, fPIE/fPIC *requires* relative addressing but does not
> necessarily require a specific 2 GB placement range. Altogether, I do
> think there are use cases for both options individually. I can't think
> of a reason why gcc wouldn't be able to support mcmodel=kernel in
> conjunction with fPIE off the top of my head, but I admittedly haven't
> looked into it; I simply observed that the combination is not
> currently supported.
> 
> RE: compiling the whole x86-64 kernel with fPIE/fPIC, I believe the
> required changes would be very extensive (see "[PATCH RFC 00/43]
> x86/pie: Make kernel image's virtual address flexible" at
> https://lore.kernel.org/lkml/cover.1682673542.git.houwenlong.hwl@antgroup.com/).

FYI I have sent a small patchset[0] that attempts to build the head code
(head64.c and mem_encrypt_identity.c) as PIE. However, there are still a
few functions that are called by the head code but are not in these two
files.

[0] https://lore.kernel.org/lkml/cover.1689130310.git.houwenlong.hwl@antgroup.com

