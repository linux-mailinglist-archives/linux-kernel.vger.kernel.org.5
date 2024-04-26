Return-Path: <linux-kernel+bounces-160244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0208B3AD6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D325C1C233BF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35DBA171644;
	Fri, 26 Apr 2024 15:10:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF1717166E
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144235; cv=none; b=bX4k+ohdcIgb+K+7L9DZrGY58QneLkNWuWKmsi4RuBPOOMjRGcnqEHWot3BKKqP8X6HpOWNq89IpU1aTR3irp2P+Bf9jft6FVZVHUv8GX7S2PXVXLuDwTfSVo0aohQj9N/P6f8fwQKjIEft399qk3SQU0UVUp3k6Pu7/PqTaMRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144235; c=relaxed/simple;
	bh=YXzv6BIFhmVbewGmDyJE9WdD4nU/nqy4oI/DvekPYS0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=X7h0+DGTs/kmb5M6sqr06+nxlRPt/On23DvgvISgWKYt1+4sOWLsz+Y3/dTCt7mOIdbOw4e5eCgaaVXLd+iAREbIcPfBX4TCXKHvDezWGqEOSZ3S40ubcFYxIagYFO6LAsH1vHk/qqG1TGwqk4okPLe8yk7L++fJVTneEozoVQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5BAD168F;
	Fri, 26 Apr 2024 08:11:01 -0700 (PDT)
Received: from e133380.cambridge.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F0E0B3F73F;
	Fri, 26 Apr 2024 08:10:30 -0700 (PDT)
From: Dave Martin <Dave.Martin@arm.com>
To: x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: James Morse <james.morse@arm.com>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>,
	Babu Moger <Babu.Moger@amd.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com,
	lcherian@marvell.com,
	bobo.shaobowang@huawei.com,
	"Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>,
	baolin.wang@linux.alibaba.com,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	Peter Newman <peternewman@google.com>,
	dfustini@baylibre.com,
	amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: [PATCH v2 26/35] x86/resctrl: Describe resctrl's bitmap size assumptions
Date: Fri, 26 Apr 2024 16:08:55 +0100
Message-Id: <20240426150904.8854-26-Dave.Martin@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240426150904.8854-1-Dave.Martin@arm.com>
References: <20240426150537.8094-1-Dave.Martin@arm.com>
 <20240426150904.8854-1-Dave.Martin@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Morse <james.morse@arm.com>

resctrl operates on configuration bitmaps and a bitmap of allocated
CLOSID, both are stored in a u32.

MPAM supports configuration/portion bitmaps and PARTIDs larger
than will fit in a u32.

Add some preprocessor values that make it clear why MPAM clamps
some of these values. This will make it easier to find code related
to these values if this resctrl behaviour ever changes.

Signed-off-by: James Morse <james.morse@arm.com>
---
 include/linux/resctrl.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
index be004dc2ec79..329f68db38e1 100644
--- a/include/linux/resctrl.h
+++ b/include/linux/resctrl.h
@@ -26,6 +26,17 @@ int proc_resctrl_show(struct seq_file *m,
 /* max value for struct rdt_domain's mbps_val */
 #define MBA_MAX_MBPS   U32_MAX
 
+/*
+ * Resctrl uses a u32 as a closid bitmap. The maximum closid is 32.
+ */
+#define RESCTRL_MAX_CLOSID		32
+
+/*
+ * Resctrl uses u32 to hold the user-space config. The maximum bitmap size is
+ * 32.
+ */
+#define RESCTRL_MAX_CBM			32
+
 /**
  * struct pseudo_lock_region - pseudo-lock region information
  * @s:			Resctrl schema for the resource to which this
-- 
2.34.1


