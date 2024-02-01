Return-Path: <linux-kernel+bounces-47979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F06AE84559A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FBB41F21974
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9C515B990;
	Thu,  1 Feb 2024 10:37:55 +0000 (UTC)
Received: from outbound-smtp13.blacknight.com (outbound-smtp13.blacknight.com [46.22.139.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEEB440E
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 10:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.22.139.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706783875; cv=none; b=fYIx3BI50x65OiRKW4yzb1EoB8nZVTYeaEPbMvZu5TC6PsUh2hhp3OP4hkoGtnEJ0Zs1jmzuDoy4bOasg0YbsLKaXee4rxK2nvU0eBj1QvZ6WUry96MVjlRuvY7OkhqeKJI9Htaa4RrPLtIks22uMPiXpusqlZWc1S/BqeoExds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706783875; c=relaxed/simple;
	bh=Exr2BwZvsh3y5wM6YrZoLn/QOAjN5a+Z82NaFBeOZs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzDgDeerQuAERfwJrPYMcTVUMWQT2wZ5G84rh3LgdR+9tZWrBc9+p9/GinX2RrrHWW0BC2LPwQ4eUJclsl35mpYC/4+F+yEZgv4+kVOv770NpPWmVsph75hSsap4E5urxySxT/WQDG0Rxiq0JlgbiMb/RbMV9a9j3MJgbGfInm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net; spf=pass smtp.mailfrom=techsingularity.net; arc=none smtp.client-ip=46.22.139.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
	by outbound-smtp13.blacknight.com (Postfix) with ESMTPS id B107F1C3DE2
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 10:30:11 +0000 (GMT)
Received: (qmail 1080 invoked from network); 1 Feb 2024 10:30:11 -0000
Received: from unknown (HELO mail.blacknight.com) (mgorman@techsingularity.net@[81.17.254.19])
  by 81.17.254.26 with ESMTPA; 1 Feb 2024 10:30:11 -0000
Date: Thu, 1 Feb 2024 10:30:09 +0000
From: Mel Gorman <mgorman@techsingularity.net>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: compaction: update the cc->nr_migratepages when
 allocating or freeing the freepages
Message-ID: <20240201103009.jycolrj7t3axtlgd@techsingularity.net>
References: <afcd9377351c259df7a25a388a4a0d5862b986f4.1705928395.git.baolin.wang@linux.alibaba.com>
 <0773058df022fa701b78f9a6dfe3c501a1a77351.1705928395.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <0773058df022fa701b78f9a6dfe3c501a1a77351.1705928395.git.baolin.wang@linux.alibaba.com>

On Mon, Jan 22, 2024 at 09:01:54PM +0800, Baolin Wang wrote:
> Currently we will use 'cc->nr_freepages >= cc->nr_migratepages' comparison
> to ensure that enough freepages are isolated in isolate_freepages(), however
> it just decreases the cc->nr_freepages without updating cc->nr_migratepages
> in compaction_alloc(), which will waste more CPU cycles and cause too many
> freepages to be isolated.
> 
> So we should also update the cc->nr_migratepages when allocating or freeing
> the freepages to avoid isolating excess freepages. And I can see fewer free
> pages are scanned and isolated when running thpcompact on my Arm64 server:
>                                        k6.7         k6.7_patched
> Ops Compaction pages isolated      120692036.00   118160797.00
> Ops Compaction migrate scanned     131210329.00   154093268.00
> Ops Compaction free scanned       1090587971.00  1080632536.00
> Ops Compact scan efficiency               12.03          14.26
> 
> Moreover, I did not see an obvious latency improvements, this is likely because
> isolating freepages is not the bottleneck in the thpcompact test case.
>                               k6.7                  k6.7_patched
> Amean     fault-both-1      1089.76 (   0.00%)     1080.16 *   0.88%*
> Amean     fault-both-3      1616.48 (   0.00%)     1636.65 *  -1.25%*
> Amean     fault-both-5      2266.66 (   0.00%)     2219.20 *   2.09%*
> Amean     fault-both-7      2909.84 (   0.00%)     2801.90 *   3.71%*
> Amean     fault-both-12     4861.26 (   0.00%)     4733.25 *   2.63%*
> Amean     fault-both-18     7351.11 (   0.00%)     6950.51 *   5.45%*
> Amean     fault-both-24     9059.30 (   0.00%)     9159.99 *  -1.11%*
> Amean     fault-both-30    10685.68 (   0.00%)    11399.02 *  -6.68%*
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs

