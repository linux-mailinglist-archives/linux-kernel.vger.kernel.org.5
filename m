Return-Path: <linux-kernel+bounces-66876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A55BA8562F5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7FEE1C22406
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B452A12E1E4;
	Thu, 15 Feb 2024 12:18:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CE112DDAD
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 12:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707999495; cv=none; b=HrZP4g6EJ7WVN4k5RyeN/XYz9YsKAYO9eFVnUgpavpGyNLJRHAWSx9w1wK6xrDMSgMTkzbpiz/+hzEFoNoLjaCurdYqpzy2Pd+69aEzPcQwQW9Y7rwHBFnUAAwMsjlmqJoku+fzXhgd/F9jdqS2z545bk4tNo0YL6YWco2aZgRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707999495; c=relaxed/simple;
	bh=OdZO9g+9FSaWD9oyiiwTscd6V8RMai4lWO4CUR6mAuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GBDtxR6JYI29Sx5ggmr9PcOQxzC/uVseZiZ0BpsglFkJxzRRev2UpVipyI5HPLZBMyzPfV/8kWb88nuoefeENn2rfRI90ud1V9nYtrkVZk9hfZSIavmfsggc5X9u879txXngj7ouCASdMf4+Yas12z8Kj+XvcXw48Dn4vMnlkXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A35301FB;
	Thu, 15 Feb 2024 04:18:54 -0800 (PST)
Received: from e125769.cambridge.arm.com (e125769.cambridge.arm.com [10.1.196.26])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07C203F766;
	Thu, 15 Feb 2024 04:18:11 -0800 (PST)
From: Ryan Roberts <ryan.roberts@arm.com>
To: David Hildenbrand <david@redhat.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Muchun Song <muchun.song@linux.dev>
Cc: Ryan Roberts <ryan.roberts@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 4/4] arm64/mm: Override ptep_get_lockless_norecency()
Date: Thu, 15 Feb 2024 12:17:56 +0000
Message-Id: <20240215121756.2734131-5-ryan.roberts@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240215121756.2734131-1-ryan.roberts@arm.com>
References: <20240215121756.2734131-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Override ptep_get_lockless_norecency() when CONFIG_ARM64_CONTPTE is
enabled. Because this API doesn't require the access and dirty bits to
be accurate, for the contpte case, we can avoid reading all ptes in the
contpte block to collect those bits, in contrast to ptep_get_lockless().

Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
---
 arch/arm64/include/asm/pgtable.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index 401087e8a43d..c0e4ccf74714 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -1287,6 +1287,12 @@ static inline pte_t ptep_get_lockless(pte_t *ptep)
 	return contpte_ptep_get_lockless(ptep);
 }

+#define ptep_get_lockless_norecency ptep_get_lockless_norecency
+static inline pte_t ptep_get_lockless_norecency(pte_t *ptep)
+{
+	return __ptep_get(ptep);
+}
+
 static inline void set_pte(pte_t *ptep, pte_t pte)
 {
 	/*
--
2.25.1


