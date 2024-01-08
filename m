Return-Path: <linux-kernel+bounces-19187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A14826982
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7911C21C10
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B36CBA57;
	Mon,  8 Jan 2024 08:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JrUqbAZj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B69B673
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 08:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704702533; x=1736238533;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=prSPQ9PpceItCYT5PtbjU8y4+s795odvXDIRVVIUCcg=;
  b=JrUqbAZj3I5oCL8ZwNwjsaQrkmci2QqGb25VBv8J9hg6/l24Fk/q5pb7
   17/yGQHH/e2X/E5GZ0cACxh0TPIz2gaaxBveRLEz+RdZleDIEJw0NFeJi
   cqPV9ZK86xYgFy9TOjNpfJVry7IY0z/EQvKSswbkNDldMuopIZD/N4oWy
   uN98ypMe6lnbZg5BN1c0sZXvkte28TYJXAbr2vTc+PzjerTn1/x0Zz5yo
   A3vYqwYrO+PYu31hR9Ok4rSfXm6H2h+P7qV4VuDA4wd+vD60wUaR7zYGz
   6+8/GlXt4xCnwEq5PiBwDZQ2uITpaDysD8VSr0a2FcR22oC8TEQ/D6djq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="377967276"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="377967276"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 00:28:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="924793054"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="924793054"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2024 00:28:49 -0800
From: "Huang, Ying" <ying.huang@intel.com>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org,  Kairui Song <kasong@tencent.com>,  Andrew Morton
 <akpm@linux-foundation.org>,  Chris Li <chrisl@kernel.org>,  Hugh Dickins
 <hughd@google.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Matthew Wilcox
 <willy@infradead.org>,  Michal Hocko <mhocko@suse.com>,  Yosry Ahmed
 <yosryahmed@google.com>,  David Hildenbrand <david@redhat.com>,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/9] mm/swap: handle swapcache lookup in swapin_entry
In-Reply-To: <20240102175338.62012-7-ryncsn@gmail.com> (Kairui Song's message
	of "Wed, 3 Jan 2024 01:53:35 +0800")
References: <20240102175338.62012-1-ryncsn@gmail.com>
	<20240102175338.62012-7-ryncsn@gmail.com>
Date: Mon, 08 Jan 2024 16:26:51 +0800
Message-ID: <87a5pg9qno.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Kairui Song <ryncsn@gmail.com> writes:

> From: Kairui Song <kasong@tencent.com>
>
> Since all callers of swapin_entry need to check the swap cache first, we
> can merge this common routine into swapin_entry, so it can be shared and
> optimized later.
>
> Also introduce a enum to better represent possible swap cache usage, and
> add some comments about it, make the usage of swap cache easier to
> understand.

I don't find any benefit to do this.  The code line number isn't
reduced.  The concept of swap cache isn't hided either.

--
Best Regards,
Huang, Ying


