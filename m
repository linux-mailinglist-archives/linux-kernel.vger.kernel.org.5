Return-Path: <linux-kernel+bounces-52061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085ED849393
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A62D1C21BB4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 05:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B417210A25;
	Mon,  5 Feb 2024 05:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3gbwRWgI"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5A610A01
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 05:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707112433; cv=none; b=WKPOKeCX5gsxPH3heOyqDwPbOVPmN3/BWi0t1QmxztfisXSYxGLpfK/yt8OU1ms7Idj11joB0aDJ+bhddTFWVgbHliDRNhuiqry19wkpB6MDkWlCYg9y6TILVaNMXh27scZF5BAc+EENCyV/mD8Pz5wfF4i5DbOQ0zJy2o1aX8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707112433; c=relaxed/simple;
	bh=YSvKvmqEH+pVNVxrm0dlMM6NLTmQqj/EZLloUBRAxic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qbPk82cB+tU7RPu/tmHksrEFp6hXwoCyT4d6PR6Ay4rTKtJSiUHnhjKn7quHGLfpW9LBveax3H03SA9IGP6GQAm/DqTHjqXVAJl5OkV6V5uI+Kn6h72Wx7qW/Gjq80r1pnaTQxxhGim9j1OwWgIgpAW9Hqsiv7mbN4kPtV21k8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=3gbwRWgI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=K9RNZrjlQWEBnvc1kEhCFcqKAhg1GOG9b2dv8n13vIE=; b=3gbwRWgI6vBQV07poLQVaQXKqx
	Cs2QM95NNyVID6ZGdXJUGi2qIzIgkmsr6cwVue2X/IL8PR3ILVWkoyEdDmjxdIqj289ib0mBagW3u
	yrQugMLgO4eVaqlL8n6osORKDO896bXULua+Ywt0W0Fk+IoiGfQA5YOzackEk0ypHjmKw3tcuCZkl
	V10vZc3ENQOjVlONDfsGT/EfgJzeOAqtfHzug3PRMW/TEzFg1p0ioCd7brMXdN37m0VYUNPyDcfSZ
	fSS8yYjFZ4Oi/B3NvThKDzVcHvG7dy1AYR2iQqfM6MyVhDr3TYXrLElXpUVUfrvwSnrJNqH1JcyKF
	b5HCADHg==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rWrvS-000000027ZI-2M0H;
	Mon, 05 Feb 2024 05:53:50 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Li Yang <leoyang.li@nxp.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	Frank Li <Frank.Li@nxp.com>,
	Guanhua Gao <guanhua.gao@nxp.com>,
	Roy Pledge <Roy.Pledge@nxp.com>
Subject: [PATCH v2] soc: fsl: fix kernel-doc warnings and typos
Date: Sun,  4 Feb 2024 21:53:49 -0800
Message-ID: <20240205055349.24410-1-rdunlap@infradead.org>
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

