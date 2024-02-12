Return-Path: <linux-kernel+bounces-61094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 623EF850D31
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 05:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85D861C2222B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 04:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0305396;
	Mon, 12 Feb 2024 04:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gl/KlI5n"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27623A40
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 04:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707712254; cv=none; b=CZqcn/KTXtpgy7kbkQta3hND488Vhow+BMMUfqGETxWPqJpW8DsNQ8alEUwnK6/1S2DRLPfNO34WLo+34JffQfKRz7+hQLyuDofGxr+NFqR1DrDzJZq8KsvXeAttB/DY5YQY/NjlMMBIGhIjDKag5WH6xx4Qgg6u3rxZBggJI9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707712254; c=relaxed/simple;
	bh=YSvKvmqEH+pVNVxrm0dlMM6NLTmQqj/EZLloUBRAxic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IFF3bVyzMFy5fvt4bGtGvqfuwqE4MCxupmPDlIEgYnhv/KsKv61AkGkl+hm4petPBqiKbggSgiyy0hKWGJa8gWPzmzUx71BUp9CvgYPiofJrPH7M2lA1jd8hGSkFqwPVYb3CHScNajhLY29fDHruM60cZHYAzA/R6HKorg+jDo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gl/KlI5n; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=K9RNZrjlQWEBnvc1kEhCFcqKAhg1GOG9b2dv8n13vIE=; b=gl/KlI5nmtzS0gxwXS2PXLNk8s
	hCIopXrAr1Bn92aRSCpT6M4p14Rw/iLW5XP1cD+YBYS8qY8cWexT8n7JdQyxthsKNlJfCl6MUBxb4
	6TqjxdVGk5Av/CPHvcT1kL3NT7NBpwjMf4ewVe/EpyqDcgot5AVqEqm+lBcpww7d+SUmR28yNOHIs
	Mt4hoJ/fDkO28Rg+p5frMlz90ijfdj6C9z6ZyhNwTnHd6wJy7ScyP+jOm+/18Ynw4JuijQB+++FGH
	a5Ugux0odmu0kLIhSgAT1qoIWG7ib/wGJ/z8oXFMbggKIre1QjMelGflIsf4wf4d55gL+qxCQqCnx
	o7fJEIog==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZNxy-00000004J3s-364K;
	Mon, 12 Feb 2024 04:30:50 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Li Yang <leoyang.li@nxp.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Frank Li <Frank.Li@nxp.com>,
	Guanhua Gao <guanhua.gao@nxp.com>,
	Roy Pledge <Roy.Pledge@nxp.com>
Subject: [PATCH v2 RESEND] soc: fsl: fix kernel-doc warnings and typos
Date: Sun, 11 Feb 2024 20:30:50 -0800
Message-ID: <20240212043050.28964-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct spelling of "list".

Fix a kernel-doc warning by describing the nested structure completely:

include/soc/fsl/dpaa2-fd.h:52: warning: Function parameter or member 'simple' not described in 'dpaa2_fd'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Li Yang <leoyang.li@nxp.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Guanhua Gao <guanhua.gao@nxp.com>
Cc: Roy Pledge <Roy.Pledge@nxp.com>
---
v2:  update Cc: list, rebase

 include/soc/fsl/dpaa2-fd.h |   19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff -- a/include/soc/fsl/dpaa2-fd.h b/include/soc/fsl/dpaa2-fd.h
--- a/include/soc/fsl/dpaa2-fd.h
+++ b/include/soc/fsl/dpaa2-fd.h
@@ -25,14 +25,15 @@
 
 /**
  * struct dpaa2_fd - Struct describing FDs
- * @words:         for easier/faster copying the whole FD structure
- * @addr:          address in the FD
- * @len:           length in the FD
- * @bpid:          buffer pool ID
- * @format_offset: format, offset, and short-length fields
- * @frc:           frame context
- * @ctrl:          control bits...including dd, sc, va, err, etc
- * @flc:           flow context address
+ * @words:                for easier/faster copying the whole FD structure
+ * @simple:               struct for the FD fields
+ * @simple.addr:          address in the FD
+ * @simple.len:           length in the FD
+ * @simple.bpid:          buffer pool ID
+ * @simple.format_offset: format, offset, and short-length fields
+ * @simple.frc:           frame context
+ * @simple.ctrl:          control bits...including dd, sc, va, err, etc
+ * @simple.flc:           flow context address
  *
  * This structure represents the basic Frame Descriptor used in the system.
  */
@@ -497,7 +498,7 @@ static inline void dpaa2_fl_set_addr(str
  * dpaa2_fl_get_frc() - Get the frame context in the FLE
  * @fle: the given frame list entry
  *
- * Return the frame context field in the frame lsit entry.
+ * Return the frame context field in the frame list entry.
  */
 static inline u32 dpaa2_fl_get_frc(const struct dpaa2_fl_entry *fle)
 {

