Return-Path: <linux-kernel+bounces-139785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 140B18A07AD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 461EC1C23F2C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534C813C9D9;
	Thu, 11 Apr 2024 05:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="wAdfv5h4"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C9A13C80D;
	Thu, 11 Apr 2024 05:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712813115; cv=none; b=SKzcDZ/olQGaeoeNm1FEc85tvQGuPQ8QR8hHqNRwRPqXxS2PGy0iWMngNJUF6APsGsOcFgVP0nCT2CUmv4eJdyrLT6rZAHeLA8GLHST9vmp/0afWLfb2LLCR6pfKHaQ1YRwWPK/xU6Pqh472TFzrJXbcq5M9tBEUCaCH6lhK8zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712813115; c=relaxed/simple;
	bh=sNAXyqsSuHrCeMOimsRpDYHdQcIoN+DWdb6lG2wJqRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WJkP0LcBp12/j9L6awwCZZsDVBI4zoGoIv0onEXn+ESPtxuHoHgbZfeE7tNE4LYybSwneq8MH9vVERRQteLq/CKet2RCDzGLWzotIW6xWjoBb470Fy3AGd7Weel8JnQW1yZPmx6Be+Rdu7sJ8dRHDWbBM7WWnqjG3IWcwFkyHzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=wAdfv5h4; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=Ht6r23rX2r/4EDSCXcsVWGaAvN/0q3Ud/iZTDrOynSI=; t=1712813112;
	x=1713245112; b=wAdfv5h4GE9TNnGf2jMwvnqhWyf70uq+gSWyviIThvSPiTOI46qERLoSnG0Tn
	jJAEkrDlS9g2Oc17L9n6z6huW6DYO93PMSRQHRrHoCVuOd9rAz4rGRoEOWQbGH9iiiVx93xRfzMZn
	8o6Sya4kFS9m0L3UmnGAJdRqH0Ak4cxYJa41VGop/vmopxiYlkAdD/vSnGheIR8ez9GMlW3YpKxGX
	kISijQM1c58RhpnUjIOpQ6HO1TVjF8B2sc/zCVZxUlh1ADKRRxoDJJkFCWNFCnGsXTVZAoOSzQ8eq
	23x1VVU5t5UODclZJDCmhq0H3uBMbPymu6NG+tAw2WkMbXCV/w==;
Received: from ip4d148da6.dynamic.kabel-deutschland.de ([77.20.141.166] helo=truhe.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	id 1rumvr-0000rh-2s; Thu, 11 Apr 2024 07:25:07 +0200
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	stable@vger.kernel.org,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/4] docs: stable-kernel-rules: reduce redundancy
Date: Thu, 11 Apr 2024 07:25:03 +0200
Message-ID: <d64757f57823449c99261b167ba0b3b1b8dfcc75.1712812895.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1712812895.git.linux@leemhuis.info>
References: <cover.1712812895.git.linux@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1712813112;8245af4a;
X-HE-SMSGID: 1rumvr-0000rh-2s

Explain the general concept once in the intro to keep things somewhat
shorter in the individual points.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/process/stable-kernel-rules.rst | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
index 41f1e07abfdfa7..7bb16d42a51833 100644
--- a/Documentation/process/stable-kernel-rules.rst
+++ b/Documentation/process/stable-kernel-rules.rst
@@ -79,10 +79,9 @@ stable tree without anything else needing to be done by the author or
 subsystem maintainer.
 
 To sent additional instructions to the stable team, use a shell-style inline
-comment:
+comment to pass arbitrary or predefined notes:
 
- * To specify any additional patch prerequisites for cherry picking use the
-   following format in the sign-off area:
+ * Specify any additional patch prerequisites for cherry picking:
 
    .. code-block:: none
 
@@ -101,8 +100,7 @@ comment:
      git cherry-pick fd21073
      git cherry-pick <this commit>
 
- * For patches that may have kernel version prerequisites specify them using
-   the following format in the sign-off area:
+ * Point out kernel version prerequisites:
 
    .. code-block:: none
 
@@ -119,14 +117,13 @@ comment:
    Note, such tagging is unnecessary if the stable team can derive the
    appropriate versions from Fixes: tags.
 
- * To delay pick up of patches, use the following format:
+ * Delay pick up of patches:
 
    .. code-block:: none
 
      Cc: <stable@vger.kernel.org> # after 4 weeks in mainline
 
- * For any other requests, just add a note to the stable tag. This for example
-   can be used to point out known problems:
+ * Point out known problems:
 
    .. code-block:: none
 
-- 
2.44.0


