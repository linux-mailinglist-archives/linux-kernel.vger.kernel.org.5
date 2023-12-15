Return-Path: <linux-kernel+bounces-888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568A9814784
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3732B20C35
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40B72575D;
	Fri, 15 Dec 2023 12:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LdCHyro9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E366025567;
	Fri, 15 Dec 2023 12:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702641633; x=1734177633;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D/c9Qdb5ZlFeimez12GcL3qtIpIiLi2nprWm2ltOotY=;
  b=LdCHyro9eY1bb4Vj9iLiEEQzPoakinQ0RLniX899CAM2OZyg40DBYyIE
   mHaiC9y5Jjy/e5DgnZ6CxyJA4gBR3qzCebVapxHmLtAolRi/Rw+ja+OvL
   4yG3iWP5TnwI0Z2LMmdlI0B+7jR1ICEofbTNfzAGRJfQXQZtE71xXwQ0J
   5JxhvZ+GsqHcnhscfyGKu+sGuNuBQdcSNYdaX7JsUCf4ryMHdJU7or/s9
   3cR7h+qRSOkgbXurQy40G5ULeWpgSiuO1m5N9XoUYRo975MYnmBs2FRzV
   QaXNPHR7zHvMupoOBWa7zug0DxabJDzXvNzEWJC037ECIpz/mpmyVKq1N
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="380262426"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="380262426"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 04:00:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="898117173"
X-IronPort-AV: E=Sophos;i="6.04,278,1695711600"; 
   d="scan'208";a="898117173"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.Hitronhub.home) ([10.213.8.163])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 04:00:29 -0800
From: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To: Jonathan Corbet <corbet@lwn.net>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
	Kim Phillips <kim.phillips@amd.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Matthew Wilcox <willy@infradead.org>
Subject: [PATCH] Documentation/mm: Describe folios in physical_memory.rst
Date: Fri, 15 Dec 2023 13:00:12 +0100
Message-ID: <20231215120022.2010667-1-fabio.maria.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Documentation/mm/physical_memory.rst contains stubs and one of them is
an empty subsection about folios. Fill that stub with information that
describe what a folio is and why it was introduced.

This patch contains text written by Matthew Wilcox. The text comes from
his commit messages and from other sources. I just adaptet and included
it for the purposes of this patch. The patch contains also some lines
written by Jonathan Corbet in lwn.net. Thanks to both of them.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Fabio M. De Francesco <fabio.maria.de.francesco@linux.intel.com>
---
 Documentation/mm/physical_memory.rst | 31 +++++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/Documentation/mm/physical_memory.rst b/Documentation/mm/physical_memory.rst
index 531e73b003dd..5928a1795aab 100644
--- a/Documentation/mm/physical_memory.rst
+++ b/Documentation/mm/physical_memory.rst
@@ -357,9 +357,34 @@ Pages
 Folios
 ======
 
-.. admonition:: Stub
-
-   This section is incomplete. Please list and describe the appropriate fields.
+A folio is a physically, virtually and logically contiguous set of bytes.
+It is a power-of-two in size, and it is aligned to that same power-of-two.
+It is at least as large as %PAGE_SIZE. If it is in the page cache, it is
+at a file offset which is a multiple of that power-of-two. It may be
+mapped into userspace at an address which is at an arbitrary page offset,
+but its kernel virtual address is aligned to its size.
+
+As Matthew Wilcox explains in his introduction to folios, the need for
+`struct folio` arises mostly to address issues with the use of compound
+pages. It is often unclear whether a function operates on an individual
+page, or an entire compound page.
+
+"A function which has a `struct page` pointer argument might be
+expecting a head or base page and will BUG if given a tail page. It might
+work with any kind of page and operate on %PAGE_SIZE bytes. It might work
+with any kind of page and operate on page_size() bytes if given a head
+page but %PAGE_SIZE bytes if given a base or tail page. It might operate
+on page_size() bytes if passed a head or tail page. We have examples of
+all of these today.".
+
+A pointer to folio points to a page that is never a tail page. It
+represents an entire compound page. Therefore, there is no need to call
+compound_head() to get a pointer to the head. Folios has eliminted the
+need to unnecessary calls and has avoided bugs related to the misuse of
+pages passed to functions. Furthermore, the inline compound_head() makes
+the kernel bigger and slows things down.
+
+The folio APIs are described in the "Memory Management APIs" document.
 
 .. _initialization:
 
-- 
2.43.0


