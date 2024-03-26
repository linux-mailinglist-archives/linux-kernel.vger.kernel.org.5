Return-Path: <linux-kernel+bounces-119488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4333C88C997
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8FAC3262C6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344471C68D;
	Tue, 26 Mar 2024 16:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GesR1+1j"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85C3A95B;
	Tue, 26 Mar 2024 16:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711471321; cv=none; b=QJJFUwTQ1tI8pSAqf/ErYDqaLNZ5bmUUWujBz1A/exAt3zffacgw/m5zqxoKubldHSewPgMCgGQ82e1YMThjoLL9oZaVIOpqjvNNuCvWyYyumYIj3pEEQrLFo4RK6Koylu1ayT8P0zj/hrSVqHf3r3/pcWtAeEpjLidqNOseHZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711471321; c=relaxed/simple;
	bh=WzwSFT39ppUt+G6VUM5qkC+LZ2l/47JC71a7MRgYP54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iqASJGzyuGYYdTFh1tTqvI0bw7RuYlRoxvK+3IIjL81sp6Y9EZBtnwIuNnnw2m9JUiMx+fUQ+4SRH45KU16b57RM9yif/Nwk8zUWovO6FSOoGtKy45kDkYn6z+LhbRHPOSYtfKkxq7Fs4MqZdJ0WMQljwHCa8Z9jZKj3tzp2BSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GesR1+1j; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711471320; x=1743007320;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WzwSFT39ppUt+G6VUM5qkC+LZ2l/47JC71a7MRgYP54=;
  b=GesR1+1jw0PXdwQJHLor6wD0Sx7gBgi/MHyRKmTLL/eH6tQTmOFld/Do
   0QpENyhDKn8dTBfVKc4ut1kx+/ahrAK+sEFca6gmH/Mb0xJ4WzrG5eepC
   5YMXvNGvvJZyzioklKTqBHCfSV7NB95hMz8W72cjX8kJ76ixgjxGD8wqd
   qcFRvjO5Bb2N2ErjzLBwoQE6AhCLDeXSOQLejePio9oGwnuLN+O6/lRO+
   ANx0HPrO3E4yoyqKba6EqHWrA73wuCFrKn8EbGtj/Brrf7kO3VZjrUn/3
   3Sf/7ppWYV1dGlSylqVyBDbMN9yQ0Uu7GSxcvXGNhdL2CS40KBKXuvKqS
   g==;
X-CSE-ConnectionGUID: YH9nSiARRIC7ZANllyn51w==
X-CSE-MsgGUID: BvJ2qqq1TTyWC1zMpc1UzQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11025"; a="24023305"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="24023305"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 09:41:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="20667393"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa003.jf.intel.com with ESMTP; 26 Mar 2024 09:41:45 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Simon Horman <horms@kernel.org>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/3] compiler_types: add Endianness-dependent __counted_by_{le,be}
Date: Tue, 26 Mar 2024 17:41:14 +0100
Message-ID: <20240326164116.645718-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240326164116.645718-1-aleksander.lobakin@intel.com>
References: <20240326164116.645718-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some structures contain flexible arrays at the end and the counter for
them, but the counter has explicit Endianness and thus __counted_by()
can't be used directly.

To increase test coverage for potential problems without breaking
anything, introduce __counted_by_{le,be}() defined depending on
platform's Endianness to either __counted_by() when applicable or noop
otherwise.
Maybe it would be a good idea to introduce such attributes on compiler
level if possible, but for now let's stop on what we have.

Acked-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 Documentation/conf.py          |  2 ++
 scripts/kernel-doc             |  1 +
 include/linux/compiler_types.h | 11 +++++++++++
 3 files changed, 14 insertions(+)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index d148f3e8dd57..0c2205d536b3 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -75,6 +75,8 @@ if major >= 3:
             "__rcu",
             "__user",
             "__force",
+            "__counted_by_le",
+            "__counted_by_be",
 
             # include/linux/compiler_attributes.h:
             "__alias",
diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 967f1abb0edb..1474e95dbe4f 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -1143,6 +1143,7 @@ sub dump_struct($$) {
         $members =~ s/\s*$attribute/ /gi;
         $members =~ s/\s*__aligned\s*\([^;]*\)/ /gos;
         $members =~ s/\s*__counted_by\s*\([^;]*\)/ /gos;
+        $members =~ s/\s*__counted_by_(le|be)\s*\([^;]*\)/ /gos;
         $members =~ s/\s*__packed\s*/ /gos;
         $members =~ s/\s*CRYPTO_MINALIGN_ATTR/ /gos;
         $members =~ s/\s*____cacheline_aligned_in_smp/ /gos;
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 2abaa3a825a9..a29ba6ef1e27 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -282,6 +282,17 @@ struct ftrace_likely_data {
 #define __no_sanitize_or_inline __always_inline
 #endif
 
+/*
+ * Apply __counted_by() when the Endianness matches to increase test coverage.
+ */
+#ifdef __LITTLE_ENDIAN
+#define __counted_by_le(member)	__counted_by(member)
+#define __counted_by_be(member)
+#else
+#define __counted_by_le(member)
+#define __counted_by_be(member)	__counted_by(member)
+#endif
+
 /* Do not trap wrapping arithmetic within an annotated function. */
 #ifdef CONFIG_UBSAN_SIGNED_WRAP
 # define __signed_wrap __attribute__((no_sanitize("signed-integer-overflow")))
-- 
2.44.0


