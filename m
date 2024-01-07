Return-Path: <linux-kernel+bounces-18755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE2F826299
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 02:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4CFB1C20DCD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 01:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B96FA15B2;
	Sun,  7 Jan 2024 01:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yGrCQ/6Y"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0757137F;
	Sun,  7 Jan 2024 01:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=dCyDGSEioYdeunZdzZB63ylJy1g1gtQtPEDXYg17y5k=; b=yGrCQ/6YuI72KR9g8WruJKwNfU
	nZphzMlcefoLZ3wj56NJM+8tbynOoIvZC+vyyVrNVI5XfYznrZ5YQOtWV7BLhPlbTemIRquQtEpui
	251EeFXwCTVZ7VTrLknyY6+IadTA8Z28oZHlGiCQ2jz/WN6Zg4VhV7eqr4971ENWWUNztCPz1LxFN
	F/kPsjl+ma0mb4qmPC14huP1wN3AlnwU1eWrvTmyjoccVjd7TWDHb7ShFfwVnZHvu2M24yX/YJYqD
	QErk65d2EiXG6MjdFuXi88EMYLPT36oFXmGC0428FIgwFlae27VFQhboPRden9ttXgW1j5oP83VrG
	DCxux4GA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rMHtQ-002A6e-2r;
	Sun, 07 Jan 2024 01:24:00 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: [PATCH v2] doc-guide: kernel-doc: tell about object-like macros
Date: Sat,  6 Jan 2024 17:24:00 -0800
Message-ID: <20240107012400.32587-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 2014 kernel-doc has supported describing object-like macros
but it is not documented anywhere. I should have required some
documentation for it when I merged the patch. :(

There are currently only 3 uses of this (all in DRM headers, in
include/drm/*.h).

Add object-like macro kernel-doc documentation now so that more may
know about it and use it.

Fixes: cbb4d3e6510b ("scripts/kernel-doc: handle object-like macros")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
v2: Previous attempts to use kernel-doc were for data definitions,
    not macros, so remove that comment.
    Remove a duplicate word in the patch description.
    Add examples.

 Documentation/doc-guide/kernel-doc.rst |   45 +++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff -- a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -341,6 +341,51 @@ Typedefs with function prototypes can al
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
+Example::
+
+  /**
+   * define MAX_ERRNO - maximum errno value that is supported
+   *
+   * Kernel pointers have redundant information, so we can use a
+   * scheme where we can return either an error code or a normal
+   * pointer with the same return value.
+   */
+  #define MAX_ERRNO	4095
+
+Example::
+
+  /**
+   * define DRM_GEM_VRAM_PLANE_HELPER_FUNCS - \
+   *	Initializes struct drm_plane_helper_funcs for VRAM handling
+   *
+   * This macro initializes struct drm_plane_helper_funcs to use the
+   * respective helper functions.
+   */
+  #define DRM_GEM_VRAM_PLANE_HELPER_FUNCS \
+	.prepare_fb = drm_gem_vram_plane_helper_prepare_fb, \
+	.cleanup_fb = drm_gem_vram_plane_helper_cleanup_fb
+
+
 Highlights and cross-references
 -------------------------------
 

