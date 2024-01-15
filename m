Return-Path: <linux-kernel+bounces-25866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 116BB82D6F4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 11:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 271D71C21608
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 10:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C66F9D3;
	Mon, 15 Jan 2024 10:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SITVhrct"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F722BAF8
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 10:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705313572; x=1736849572;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=MEptrc0fT+8LksarjLhrGDoVU7ynwzFrpAwX1CpyhrM=;
  b=SITVhrctcssEHP9cN+G/XXQ+/QH6E6AYEJVoGRrVXyf/Qa4p5msug2d0
   UZd+SXCcTDLXi9/vXjGOWSOvWIYX68xpgrrR2CKLbh5kkwfqU8Vi9e6p+
   v7l12GDgmIpALbkZNbVHld/TvZEP+IZy9FY7SsJFo2yf+/tqpWadFBEvq
   omxGsciAKT5d3RGQjwx0Yp5a9RkIR2tbv/QYDzzRxYueKBkxX49mL0E4g
   G1RvTANQ38u+Xas8sPXQVSUQ/5LXJZh9q4ZvDHLrh/P8KN4izNR8X7gjZ
   HFTKVD1qcC3wI9dyPlieDxs9znrNu7KH72kGcZLc1wPUejMpCk8paD/te
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="403343256"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="scan'208";a="403343256"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 02:12:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="853957004"
X-IronPort-AV: E=Sophos;i="6.04,196,1695711600"; 
   d="scan'208";a="853957004"
Received: from jeroenke-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.55.160])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2024 02:12:42 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
	id 93EE910A58F; Mon, 15 Jan 2024 13:12:39 +0300 (+03)
Date: Mon, 15 Jan 2024 13:12:39 +0300
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Kevin Loughlin <kevinloughlin@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
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
	Hou Wenlong <houwenlong.hwl@antgroup.com>,
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
	Michael Roth <michael.roth@amd.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-coco@lists.linux.dev,
	Ashish Kalra <ashish.kalra@amd.com>,
	Andi Kleen <ak@linux.intel.com>, Adam Dunlap <acdunlap@google.com>,
	Peter Gonda <pgonda@google.com>, Jacob Xu <jacobhxu@google.com>,
	Sidharth Telang <sidtelang@google.com>
Subject: Re: [RFC PATCH v2] x86/sev: enforce RIP-relative accesses in early
 SEV/SME code
Message-ID: <20240115101239.nab725vuazvutgw6@box.shutemov.name>
References: <ZZ7YuEexYSaZYmLK@tassilo>
 <20240111223650.3502633-1-kevinloughlin@google.com>
 <20240112121725.3amxlumpifhagamb@box>
 <CAGdbjmLeyPhYfjVHPRa8LgNYjt9-rOPiyCodHoQOkEh9iQhjBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGdbjmLeyPhYfjVHPRa8LgNYjt9-rOPiyCodHoQOkEh9iQhjBg@mail.gmail.com>

On Fri, Jan 12, 2024 at 10:29:36AM -0800, Kevin Loughlin wrote:
> On Fri, Jan 12, 2024 at 4:17 AM Kirill A. Shutemov
> <kirill.shutemov@linux.intel.com> wrote:
> >
> > Can we replace existing fixup_pointer() (and other fixup_*()) with the new
> > thing? I don't think we need two confusing things for the same function.
> 
> Per my tests, yes we can; I replaced the fixup_*() functions with
> GET_RIP_RELATIVE_PTR()/PTR_TO_RIP_RELATIVE_PTR(), and guests with and
> without SEV, SEV-ES, and SEV-SNP all successfully booted under both
> clang and gcc builds.

Okay good.

BTW, do we need both macros? Caller can do &var, right?

If we are okay with single macro, maybe rename it to RIP_RELATIVE_PTR().

One other thing: I see you sprinkle casts to for every use of the macros.
But why? void* can cast to any other pointer without explicit casting.

> I have a slight preference for sending that as a
> separate follow-up commit, but please let me know if you feel
> differently. Thanks.

I'm okay with a separate patch in the same patchset.

> 
> > Also, is there any reason why GET_RIP_RELATIVE_PTR() and
> > PTR_TO_RIP_RELATIVE_PTR() have to be macros? Inline functions would be
> > cleaner.
> 
> I used macros because we need to use both the global variable itself
> and the global variable's string name (obtained via #var in the macro)
> in the inline assembly. As a secondary reason, the macro also avoids
> the need to provide separate functions for each type of variable for
> which we'd like to get RIP-relative pointers (ex: u64, unsigned int,
> unsigned long, etc.).

If we do it only on pointers, wouldn't void * -> void * be enough?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

