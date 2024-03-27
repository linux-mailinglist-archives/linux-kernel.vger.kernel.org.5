Return-Path: <linux-kernel+bounces-121418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B051688E7B8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:02:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E21CE1C2FBE0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DADC144D3C;
	Wed, 27 Mar 2024 14:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jMyx3sBU"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97E71448FF;
	Wed, 27 Mar 2024 14:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711549397; cv=none; b=aHZHEC2dbVSjbAxddz4g3Are8JiLllCWm1sJLwr/ZAxxya9dXJy0LoTy8mB1B4SJE+JY59JA+HtczCiIQxOxAmqm4LbT3TG3EcT0HLtCwh9nq6hz7lE9iWb+6CoGLx9ayUydHRD4yELAjK47vXzhvXLd7W2QpXtzXr+vY9zuB1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711549397; c=relaxed/simple;
	bh=7vqygDDKbWmFw/FAY/rPhdZQEFODtjXCpRmC6ygQulQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zzvbu23N0vj1ecdbwKZrIfp0VgApki4/kILa8Ah0cjTA/kaALx6pzzW8+liThIrkpAjvHa4AWd6g4Z4tr24ueOqEojc6D6nhNhY2JYX5Ybi9vZqNwxuVqHJx5CLuG5U2dPNRmoe8SC4Xi5OvlOI+zNWCM6jBLVrPUeOeILtQsLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jMyx3sBU; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711549395; x=1743085395;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7vqygDDKbWmFw/FAY/rPhdZQEFODtjXCpRmC6ygQulQ=;
  b=jMyx3sBU9+wa9TizPmIWAx2j3/sJ3hR3notAmROrGsB0dcaGE7Z3+Kcy
   +jjS67LkwiOe0ICP/Dsvnkpm71s42rRLA1EGshIuXs/WvUdNifgGhinHI
   xriB5pNQjlYDs5CB8Fr+rmZxDzqPdumsFMtVfz6sQM8r+nQ3Ng/SKPxCR
   PnjVT7JrLZu74RYoXdw5TO2eMUowpoFf04ZzynFOG69+P3gV8u+Zw9AQ9
   9GzbdfCgX0liwhIds75i47+PliAK+oW7f6bfBMvaFqonxqjxosBb8p0Rp
   yp0ns7s+ZljzelUFDfPXuiK/y59bcTeH+dDYkCsY3nJckPN93Phk4uTnj
   A==;
X-CSE-ConnectionGUID: OuZOBmLZSu+B6t2qrgE3oQ==
X-CSE-MsgGUID: UNFEn9dWR5GgMcWDXYIkTw==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6592530"
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="6592530"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 07:23:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,159,1708416000"; 
   d="scan'208";a="20973064"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa004.fm.intel.com with ESMTP; 27 Mar 2024 07:23:13 -0700
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
Subject: [PATCH net-next v2 1/3] compiler_types: add Endianness-dependent __counted_by_{le,be}
Date: Wed, 27 Mar 2024 15:22:39 +0100
Message-ID: <20240327142241.1745989-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327142241.1745989-1-aleksander.lobakin@intel.com>
References: <20240327142241.1745989-1-aleksander.lobakin@intel.com>
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
Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>
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


