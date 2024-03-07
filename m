Return-Path: <linux-kernel+bounces-94898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A59FA874674
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:00:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D76901C22E63
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 03:00:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4AA171A4;
	Thu,  7 Mar 2024 03:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gr9yFIso"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB67107A9;
	Thu,  7 Mar 2024 03:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709780421; cv=none; b=UkRuRgzdYbw8asoirC4K4VNxyYdmu1sCXefoQIQgm2//BzF8Yg2WFcXhkZ4hJIHFEKsK9uorvSAk/Eb25iDkJ1qnUSZC00oUgGL1WraVYLrhXmC3tdmsp1USVx3xfFjyGOdFxeOAhANZCL11oanaL44HuGCw3efvVl3Dnm/F2Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709780421; c=relaxed/simple;
	bh=T4Zlt0HI2JO9pfzPw6anb118M3jARiv+TpO7SVPb1+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u3JxvpEOsVzk5o5q2kUg+mFbCs68sUSeobZx0KUbFdSk8On4C9juCqaZozd+BVSGq28Fh6leJsF+Tzfe0r9m4n6dlow34l4DoxdE1gwNjJCeR/79OE3J+MKhpH5Ib3tZKMDhm8X29Hy7s/2qnayk+Z17aqjgaDpgIvWaE0cZO68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gr9yFIso; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFA2C433A6;
	Thu,  7 Mar 2024 03:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709780420;
	bh=T4Zlt0HI2JO9pfzPw6anb118M3jARiv+TpO7SVPb1+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gr9yFIsoRpLje3SvSmfKYtWNR0uF3miMXc3LPHKsQdFSm9I+Tm4opJXvrkVMMmD3a
	 jLeGpR1MNiipgS8Fs1hljL1UEMO0+qd9APCsbYJjrn0vZbc3dGYayyBIyW4qw++Q+f
	 FJIxtv3yoBl4sUqUdis8IjJkjkkUm2xKA9Xr/eGFcN/S8cIiuRVBeWm636Z3k6qigh
	 aMetigmopMzSlpeWgw3m1T481zUJtpufmVO0T2zISAyN/1SRgZUWDXOyKpgzLiNE30
	 hqoEhcnBLYXzqzwYIeHdQOGTb9wQAQI64t7ETWJVBakfeE4XdXny8xIed3YHH5t28n
	 lfVc8S8ugzlNQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	honggyu.kim@sk.com,
	hyeongtak.ji@sk.com,
	kernel_team@skhynix.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/3] mm/damon/paddr: support DAMOS filter type YOUNG
Date: Wed,  6 Mar 2024 19:00:13 -0800
Message-Id: <20240307030013.47041-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240307030013.47041-1-sj@kernel.org>
References: <20240307030013.47041-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMOS filter of type YOUNG is defined, but not yet implemented by any
DAMON operations set.  Add the implementation to the DAMON operations
set for the physical address space, paddr.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index deee0fdf2e5b..52e4be7351cc 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -209,6 +209,9 @@ static bool __damos_pa_filter_out(struct damos_filter *filter,
 			matched = filter->memcg_id == mem_cgroup_id(memcg);
 		rcu_read_unlock();
 		break;
+	case DAMOS_FILTER_TYPE_YOUNG:
+		matched = damon_folio_young(folio);
+		break;
 	default:
 		break;
 	}
-- 
2.39.2


