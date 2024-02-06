Return-Path: <linux-kernel+bounces-55489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA9B84BD52
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6B10B247AD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40EE51CF9A;
	Tue,  6 Feb 2024 18:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McVqnQj2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83ADA200AC;
	Tue,  6 Feb 2024 18:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707245072; cv=none; b=LhRs3fyw8QieIoVdsh0JPWWPdAuPn6pbqDlXtM0BH7j74ltlB3mxteHjs7Gn/4x085d1Vy0yMZGfMbKEmqTaQc+nGEoIhvQe4orGbrN2LWklkRXSdadOBsqGIGkan8m0P+yyz6nsqt23AB+QPSRwBdYmVTIA+DLwvg3CFFiOylA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707245072; c=relaxed/simple;
	bh=/LwfzEaBhm/92vOpLp6mT7VMsHzXGBh5BGuIoF2VfF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L0+xt5uIIIwntMQbRzcsI3sJggpDk/GGgPb3LAT3obD4+hMEZTYZ4Qc5Ja5U4z6ygii4EB6w8NdTb+xPI+/loyOxTdsekFpKrI56ZXit6lAetSmUOcl65m5y4k9GfjNS73SohHkTlas6jVOKkhCKXtwS+GLs4f4KgfGehi10gBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McVqnQj2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B75C4167E;
	Tue,  6 Feb 2024 18:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707245072;
	bh=/LwfzEaBhm/92vOpLp6mT7VMsHzXGBh5BGuIoF2VfF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=McVqnQj29spOlhBIlxA2o3rEq3DIAfsdefRmcLD/1rvBN75qDwiYuK3Ub01Zi/MaC
	 KoZIRiQSUWTmg+6dK39oGHJsrksfS20e974lyNA3T9cqMJHEVmydIS+QEOWlhSNGWF
	 rZGIF6oZicGoGgH8Zna/l6YgYztObs3p7dD104YqVddbFu8D9VYYTom0h/8FTu+3N2
	 FWLXcFpGs2tNRizjiEzuEGzCgS6UQJ4TLVfCaqH8OMNr1V7q4XXDFKsj7rK8hQHagB
	 I77nlKH/jCsw4VXwguAtbpPt3/ChhM192grQniJ5C6sI1qxZIXTwepRFIwsnIoadxt
	 d7F9Bk06Ps/rQ==
From: SeongJae Park <sj@kernel.org>
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	"Huang, Ying" <ying.huang@intel.com>,
	Chris Li <chrisl@kernel.org>,
	Minchan Kim <minchan@kernel.org>,
	Yu Zhao <yuzhao@google.com>,
	Barry Song <v-songbaohua@oppo.com>,
	SeongJae Park <sj@kernel.org>,
	Hugh Dickins <hughd@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Matthew Wilcox <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>,
	Yosry Ahmed <yosryahmed@google.com>,
	David Hildenbrand <david@redhat.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: Re: [PATCH v2] mm/swap: fix race when skipping swapcache
Date: Tue,  6 Feb 2024 10:44:29 -0800
Message-Id: <20240206184429.247502-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240206182559.32264-1-ryncsn@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kairui,

On Wed,  7 Feb 2024 02:25:59 +0800 Kairui Song <ryncsn@gmail.com> wrote:

> From: Kairui Song <kasong@tencent.com>
> 
[...]
> ---
> Update from V1:
> - Add some words on ZRAM case, it will discard swap content on swap_free so the race window is a bit different but cure is the same. [Barry Song]
> - Update comments make it cleaner [Huang, Ying]
> - Add a function place holder to fix CONFIG_SWAP=n built [SeongJae Park]

I confirm the build issue[1] that I reported yesterday is gone with this
version.  Thank you for fixing it!

[1] https://lore.kernel.org/linux-mm/20240206022409.202536-1-sj@kernel.org


Thanks,
SJ

[...]

