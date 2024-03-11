Return-Path: <linux-kernel+bounces-99533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 400A68789A9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 719F31C20C34
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E6F5730D;
	Mon, 11 Mar 2024 20:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQNI7zWP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DB056B7E;
	Mon, 11 Mar 2024 20:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710189959; cv=none; b=IZxWL5Uqc5dWsjt2u8dGCeZ9JIdsjp9oeoYNQNhJlKukXc4Qz15YJurfg97PZQP2TYVdl/aaV7Jfl4zX3Px3FRAEvbNLEZ0++7cojkm7KvYRpauhEWsu2ueYzLMts7BZ9vk3kx4761Rplu6zRaBY09BJY4ZrqICxlWg34M6KhFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710189959; c=relaxed/simple;
	bh=LO88k+dd/BebwXvUzvdC1iypWVc1Mb6U9juVYlKD5Nk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KTYBoIdyiEsq+fHvBrIgXAG8aWxN9TOzRFvP3XO2ZEIEv/jNhzGGsVlC0I/brVhxZ/aJMjADYbPUlFIETsQZOSfITiK5QQFHQkVMEkldmd++rFecR8rIYejFS1R7v6EvlVO/tEevSL2I1R3QF/Q1XgxHip5z0XYKr3lPDdU0eSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQNI7zWP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78B2C43609;
	Mon, 11 Mar 2024 20:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710189959;
	bh=LO88k+dd/BebwXvUzvdC1iypWVc1Mb6U9juVYlKD5Nk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uQNI7zWPftUXcAfchepbgu8pxGBdbSEAdCcgL0ZjBDDyDymzJz0oEGIjl1OL+4pOt
	 vUUdgM/UGEUp+bWCp1PrYYONwHar+psVszUNLtPUFGicKlMIC14alMAomTeoLBXq4d
	 XRX42K0XQUw+pfrz7kvEdLVuEeV3Ro1H5LszW9h9yE52XzWosaYdLX41fQc16Rm/7U
	 9vWI5p8uNYo+yyJbbQn9XLalmRiILMwr+Y+u9ct79phKv9T9KKMbBHoMZLtdJsYsdX
	 Nm02cMdyHt7eixGAwW9mDAePdrQmDJY0NEfiaDstr/nBbSy7p+j7D6ofARR9C4OLZ9
	 wEqqUEnKRvp4A==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: honggyu.kim@sk.com,
	hyeongtak.ji@sk.com,
	kernel_team@skhynix.com,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 3/4] mm/damon: add DAMOS filter type YOUNG
Date: Mon, 11 Mar 2024 13:45:44 -0700
Message-Id: <20240311204545.47097-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240311204545.47097-1-sj@kernel.org>
References: <20240311204545.47097-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define yet another DAMOS filter type, YOUNG.  Like anon and memcg, the
type of filter will be applied to each page in the memory region, and
check if the page is accessed since the last check.

Note that this commit is only defining the type.  Implementation of it
should be made on DAMON operations sets.  A couple of commits for the
implementation on 'paddr' DAMON operations set will follow.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h    | 2 ++
 mm/damon/sysfs-schemes.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 886d07294f4e..f7da65e1ac04 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -297,6 +297,7 @@ struct damos_stat {
  * enum damos_filter_type - Type of memory for &struct damos_filter
  * @DAMOS_FILTER_TYPE_ANON:	Anonymous pages.
  * @DAMOS_FILTER_TYPE_MEMCG:	Specific memcg's pages.
+ * @DAMOS_FILTER_TYPE_YOUNG:	Recently accessed pages.
  * @DAMOS_FILTER_TYPE_ADDR:	Address range.
  * @DAMOS_FILTER_TYPE_TARGET:	Data Access Monitoring target.
  * @NR_DAMOS_FILTER_TYPES:	Number of filter types.
@@ -315,6 +316,7 @@ struct damos_stat {
 enum damos_filter_type {
 	DAMOS_FILTER_TYPE_ANON,
 	DAMOS_FILTER_TYPE_MEMCG,
+	DAMOS_FILTER_TYPE_YOUNG,
 	DAMOS_FILTER_TYPE_ADDR,
 	DAMOS_FILTER_TYPE_TARGET,
 	NR_DAMOS_FILTER_TYPES,
diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 53a90ac678fb..bea5bc52846a 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -343,6 +343,7 @@ static struct damon_sysfs_scheme_filter *damon_sysfs_scheme_filter_alloc(void)
 static const char * const damon_sysfs_scheme_filter_type_strs[] = {
 	"anon",
 	"memcg",
+	"young",
 	"addr",
 	"target",
 };
-- 
2.39.2


