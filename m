Return-Path: <linux-kernel+bounces-80325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDE3862D72
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 23:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8DEFB20D73
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 22:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F1C1BC27;
	Sun, 25 Feb 2024 22:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KeI0lqHd"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF559450
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 22:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708901076; cv=none; b=JxkRnxx8RtWrwyzKpOSybF2eSPCjDgPVjtqPMZnLvjZORu0bcCMKOWcv5cii7+8IHHXYRWzEcfVcmLPljlyL7d3vsczH8T4WD7+SIIrHL6BerReOTH67L9XUbsyOdGnzYidNfJqCynNo0w2T4B/DIMEV9Z7sRt+Clszkxw4ZHAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708901076; c=relaxed/simple;
	bh=CMbmXeuO+ZAo9+pqU+ehEhduz98X4OUe0etETdS/qP0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sMCg3KU/f/I0XULZ68pA06CzxIp5zLHiXZ2xdGsS4Cx62NV9SqKXnx8u11+sSfkRQc9sExGlkbqkNA+v6nTCX4sgti+s5JaaaEaPvPnnparF3AXSj3hPycDzogjpasvO24oV9NaxHOqbVeBIwEmCoIDKPWh6/nNvN3Snobdq0+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KeI0lqHd; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708901075; x=1740437075;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CMbmXeuO+ZAo9+pqU+ehEhduz98X4OUe0etETdS/qP0=;
  b=KeI0lqHdweAp6BFbpwtcL7SqDciFMlk6Mk3dzRokKNTvwF9oVrUl6PDT
   JO24YG73obU/nID/EocEviDA3AX3CWi7vBf3JxuhR0G23V7S1XWlouUcV
   Hs2EjghUL2WTnP4F3oXIWVDgcxhnr2w4JN5EpB2nF5ZPxKkQhi/IKsUS5
   ZNeuWzcmM+jgQDcbQ/67fI9IiUT7LYOwC0I5R0ZqWneGtzQqAO3/D9Okb
   UFxdX2tM/u/jtglwIhiUXJ3vA/Rz3s9m8XI8qqY2jGrd0/FAyOznX1O+v
   n/Yc/oAoJquD3QMJAIIt/uICVDzbpJYR7KKuC7VkVx8LEy6v0+7zszTT0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10995"; a="6958781"
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6958781"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 14:44:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,185,1705392000"; 
   d="scan'208";a="6824026"
Received: from skuppusw-desk2.jf.intel.com ([10.165.154.101])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2024 14:44:34 -0800
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	x86@kernel.org
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xiaoyao Li <xiaoyao.li@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: [PATCH v3] virt: tdx-guest: Handle GetQuote request error code
Date: Sun, 25 Feb 2024 22:42:44 +0000
Message-Id: <20240225224244.2072245-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tdx-guest driver marshals quote requests via hypercall to have a
quoting enclave sign attestation evidence about the current state of
the TD. There are 2 possible failures, a transport failure (failure
to communicate with the quoting agent) and payload failure (a failed
quote). The driver only checks the former, update it to consider the
latter payload errors as well.

Fixes: f4738f56d1dc ("virt: tdx-guest: Add Quote generation support using TSM_REPORTS")
Reported-by: Xiaoyao Li <xiaoyao.li@intel.com>
Closes: https://lore.kernel.org/linux-coco/6bdf569c-684a-4459-af7c-4430691804eb@linux.intel.com/T/#u
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Xiaoyao Li <xiaoyao.li@intel.com>
Acked-by: Kai Huang <kai.huang@intel.com>
---

Changes since v2:
 * Updated the commit log (Dan)
 * Removed pr_err message.

Changes since v1:
 * Updated the commit log (Kirill)

 drivers/virt/coco/tdx-guest/tdx-guest.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
index 1253bf76b570..c39f0007958d 100644
--- a/drivers/virt/coco/tdx-guest/tdx-guest.c
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -228,6 +228,11 @@ static int tdx_report_new(struct tsm_report *report, void *data)
 		goto done;
 	}
 
+	if (quote_buf->status != GET_QUOTE_SUCCESS) {
+		ret = -EIO;
+		goto done;
+	}
+
 	buf = kvmemdup(quote_buf->data, quote_buf->out_len, GFP_KERNEL);
 	if (!buf) {
 		ret = -ENOMEM;
-- 
2.25.1


