Return-Path: <linux-kernel+bounces-7835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C69D81AE08
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 05:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 283F7285F03
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3528BED;
	Thu, 21 Dec 2023 04:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l4/KW0+H"
X-Original-To: linux-kernel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C2079DC;
	Thu, 21 Dec 2023 04:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vjSvREHYlgRP4KPFfJJx3croJSE9ASfBYCOZeqoZmi0=; b=l4/KW0+HYaarxW8csL/nK0Qz/k
	k2VNtZdlbQD6jeaS4A1kS52xCWOWRDpLMoBLNQA+mDakkhij36vCRh88mTsumcPWW/RCU0Q4M25HN
	V7/oSjXGtMNjtlEoorDlWuzx+gV4qATD2E3R3n7d8ejDhcK6ohykPNdLAzi/F5LnJe0sVjKqqhxP8
	Dpns6X8kHeV/nTs+iwaWORyzsBcAZTpAE6idQyh4E1W/j7/f3b/XyR+p0zWU2RcQ3RFAxFOhT6dEW
	NECroiBcjlbT0B5LSyZqVEaMusADi9PQlcOUQ/+n8BBzZpzPpPBl03tIoNcAo9cPo6occiJgi0EH8
	mROxThQg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rGAi3-004evm-1e; Thu, 21 Dec 2023 04:30:59 +0000
Date: Thu, 21 Dec 2023 04:30:59 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Aithal, Srikanth" <sraithal@amd.com>
Cc: kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [linux-next:master] [mm] bbcbf2a3f0: kernel_BUG_at_mm/memory.c
Message-ID: <ZYO/g/Dg0+DN59Gq@casper.infradead.org>
References: <202312192319.fa8f5709-oliver.sang@intel.com>
 <2b7ae17e-0429-47ab-8101-00486ef9841e@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b7ae17e-0429-47ab-8101-00486ef9841e@amd.com>

On Thu, Dec 21, 2023 at 08:26:37AM +0530, Aithal, Srikanth wrote:
> Starting from next-20231214 until next-20231220 have noted regression where
> kernel hangs randomly while running virtualization tests [multiple
> start-shutdown and reboot] against AMD sev guest type, with below call
> trace:

This is an entirely different problem, already reported and fix sent
about 24 hours ago.

diff --git a/mm/swap_state.c b/mm/swap_state.c
index 793b5b9e4f96..8a3a8f1ab20a 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -894,6 +894,9 @@ struct page *swapin_readahead(swp_entry_t entry, gfp_t gfp_mask,
 		swap_vma_readahead(entry, gfp_mask, mpol, ilx, vmf) :
 		swap_cluster_readahead(entry, gfp_mask, mpol, ilx);
 	mpol_cond_put(mpol);
+
+	if (!folio)
+		return NULL;
 	return folio_file_page(folio, swp_offset(entry));
 }
 

