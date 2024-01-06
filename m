Return-Path: <linux-kernel+bounces-18482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C89825E3E
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 06:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBEEF1C23BF0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 05:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98C82914;
	Sat,  6 Jan 2024 05:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oq33Yq4E"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F8B1FAA;
	Sat,  6 Jan 2024 05:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=MJ0H78UHHZfBubPdCEmrW7qODFgKoeU0EZzyOmoW/vM=; b=oq33Yq4ElkA+BHqzwYqustEj4b
	tqa5TEvg+HA8uQtsytTTiYzigHB2ANGce+l3Rl201FUkzEYnxDkIZ0o6RFgJM7pktQmQTnstlUg0L
	Cci+hCd20/am6dv0Y84tS9NAv60fKtb/sGyt+N8xI2eeB5Q4UBMfXdf5BF55uL13MVrr1TvJ3hhCg
	oY1bZ5E6m14cHIje0TT21Dc97QemBwpPBpuuWiGQKDElzU5LqWfVem4ePQ+GCe45h6lT0riNbBq+C
	vtkC3rp2bhDtk0G2ayvGzUNPjTrGW1eRYoQlAnmEGWzohxzxOfsiA44ERqqaeDg+td6aavdIb+sup
	m2Skevdw==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rLyoU-000kGv-0R;
	Sat, 06 Jan 2024 05:01:38 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: [PATCH] doc-guide: kernel-doc: tell about object-like macros
Date: Fri,  5 Jan 2024 21:01:37 -0800
Message-ID: <20240106050137.6445-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 2014 kernel-doc has supported describing object-like macros
macros but it is not documented anywhere. I should have required
some documentation for it when I merged the patch. :(

There are currently only 3 uses of this (all in DRM headers, in
include/drm/*.h). There have recently been a few other attempts
at using kernel-doc for object-like macros, but they didn't use the
"define" keyword and I mistakenly told them that kernel-doc does
not support such documentation.  :( again.

Add object-like kernel-doc documentation now so that more may know
about it and use it.

Fixes: cbb4d3e6510b ("scripts/kernel-doc: handle object-like macros")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/doc-guide/kernel-doc.rst |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff -- a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -341,6 +341,27 @@ Typedefs with function prototypes can al
    */
    typedef void (*type_name)(struct v4l2_ctrl *arg1, void *arg2);
 
+Object-like macro documentation
+-------------------------------
+
+Object-like macros are distinct from function-like macros. They are
+differentiated by whether the macro name is immediately followed by a
+left parenthesis ('(') for function-like macros or not followed by one
+for object-like macros.
+
+Function-like macros are handled like functions by ``scripts/kernel-doc``.
+They may have a parameter list. Object-like macros have do not have a
+parameter list.
+
+The general format of an object-like macro kernel-doc comment is::
+
+  /**
+   * define object_name - Brief description.
+   *
+   * Description of the object.
+   */
+
+
 Highlights and cross-references
 -------------------------------
 

