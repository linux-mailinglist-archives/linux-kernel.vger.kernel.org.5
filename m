Return-Path: <linux-kernel+bounces-27469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF7782F0A3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:40:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B068B1C2333F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 14:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227E51BDE9;
	Tue, 16 Jan 2024 14:40:08 +0000 (UTC)
Received: from outbound-smtp01.blacknight.com (outbound-smtp01.blacknight.com [81.17.249.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024E31B941
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 14:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=techsingularity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=techsingularity.net
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
	by outbound-smtp01.blacknight.com (Postfix) with ESMTPS id 5E8D550147
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 14:31:04 +0000 (GMT)
Received: (qmail 3917 invoked from network); 16 Jan 2024 14:31:04 -0000
Received: from unknown (HELO mail.blacknight.com) (mgorman@techsingularity.net@[81.17.254.21])
  by 81.17.254.26 with ESMTPA; 16 Jan 2024 14:31:04 -0000
Date: Tue, 16 Jan 2024 14:31:02 +0000
From: Mel Gorman <mgorman@techsingularity.net>
To: Vern Hao <haoxing990@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Xin Hao <vernhao@tencent.com>
Subject: Re: [PATCH RFC v1 2/2] mm, pcp: add more detail info about high
 order page count
Message-ID: <20240116143102.i5e5bm5hslqxfvfr@techsingularity.net>
References: <20240115093437.87814-1-vernhao@tencent.com>
 <20240115093437.87814-3-vernhao@tencent.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20240115093437.87814-3-vernhao@tencent.com>

On Mon, Jan 15, 2024 at 05:34:36PM +0800, Vern Hao wrote:
> From: Xin Hao <vernhao@tencent.com>
> 
> With this patch, we can see the distribution of pages of different orders on
> each cpu, just like below.
> 	#cat /proc/zoneinfo
>     ....
>     cpu: 2
>               total_count: 14286
>                   order0 : 1260
>                   order1 : 13
>                   order2 : 42
>                   order3 : 4
>                   order4 : 0
>                   order5 : 0
>                   order6 : 0
>                   order7 : 0
>                   order8 : 0
>                   order9 : 25
>                   order10: 0
>                   order11: 0
>                   order12: 0
>               high:  14541
>               batch: 63
> 
> Signed-off-by: Xin Hao <vernhao@tencent.com>

I am not a major fan because increasing the size of a per-cpu structure for
debugging purposes incurs a cost for everyone while only a tiny minority
may care. There is a mild risk it would break existing parsers of that file
although maybe that's not a big deal. However, the same information could be
extracted by locking the pcp structures and counting the items per list. It
would increase the cost of reading zoneinfo but it's unlikely the file is
read at high frequency. If that was a concern, a separate proc file could be
used. Finally, the same information likely can be extracted via a systemtap
script, a BPF script (if it can get to the right symbols and locking, I
didn't check) or via a kernel probe. Even with that information, it's not
clear what meaningful action a user can take, so this is a developer-only
feature really with a cost incurred for everybody.

-- 
Mel Gorman
SUSE Labs

