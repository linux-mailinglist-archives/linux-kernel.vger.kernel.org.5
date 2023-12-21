Return-Path: <linux-kernel+bounces-9119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 553AE81C0D7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 23:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87DFC1C22B85
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 22:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F39877F23;
	Thu, 21 Dec 2023 22:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qYnlUlF9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC06476095;
	Thu, 21 Dec 2023 22:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5jl+j8VoAJ0TH+y6nII30+cXSo3AkwWFgfdB0n28bjc=; b=qYnlUlF9BEORe4ao7JNQ8ooRm/
	BYv+/cuY5/1MvnSoiroxHyPmtjI2F7ExzVRIYu7ww7EjxClT8aX+Qj5WDVaNblw1bwNrPMW/FaO1M
	24Q5U4h9VsQIvZ4BXfRmFkdI3DfRBzbjqAUf98ykniHwcdaVE1/8E4j0jG/I0qKPBYoiN15aQVdfv
	tAQcX1rd4eVHcX6e8jpR5gY+eUPFdYG8yiVuIKXfqxgXCVQCmYNSjxSJQKkyamoh36G9LxKrMykZx
	AUaftO04oM+7cMFrhxxVsvjhGEOFFOMFEJ5EAjVbU/s1/NfjDBMcUEFTCmLnybtiMPPQl2W+lZzSj
	Zk0R0WWA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rGRIO-006J3l-2k; Thu, 21 Dec 2023 22:13:36 +0000
Date: Thu, 21 Dec 2023 22:13:36 +0000
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [linux-next:master] [mm] bbcbf2a3f0: kernel_BUG_at_mm/memory.c
Message-ID: <ZYS4kKr5gyszanRv@casper.infradead.org>
References: <202312192319.fa8f5709-oliver.sang@intel.com>
 <20231220141135.cb4241442b657104f0aeae34@linux-foundation.org>
 <ZYQgGmYNfF8j4JqL@xsang-OptiPlex-9020>
 <e0e7d631-0af4-46fc-b606-78de07ebb88a@redhat.com>
 <20231221135833.92b8b2a97b28ad0545977f6c@linux-foundation.org>
 <6a8f2110-fa91-4c10-9eae-88315309a6e3@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a8f2110-fa91-4c10-9eae-88315309a6e3@redhat.com>

On Thu, Dec 21, 2023 at 11:07:21PM +0100, David Hildenbrand wrote:
> Subject: [PATCH] Fixup: mm: convert ksm_might_need_to_copy() to work on folios
> 
> We must only adjust the page if the folio changed. Otherwise, if we
> had a large folio in the swapcache and the folio didn't change, we'd
> suddenly change the page to-be-mapped.

Heh, I was expecting you to be done for the day ;-)

