Return-Path: <linux-kernel+bounces-106139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 538B887E9C1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC8F2282387
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E873B79C;
	Mon, 18 Mar 2024 13:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Amb6Km8x"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72877381C5;
	Mon, 18 Mar 2024 13:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710767058; cv=none; b=GSU2GVVEt2hhmb4eN5d9OtOhsJwb8iRh/8N3bLnXUO94SGWQGlIJlx/KmeJqypTJUbFGXR++A3g+YCtZr3WWp9e17QTVl3erZ/Mtf1kq+S7L2bNxKXKCRCr73bWI4tdzB3XfRU30Q+7XuKCNR7nwWUZXSLUHYX6P5/qEgrGcjdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710767058; c=relaxed/simple;
	bh=iIs+cbLa7AHztJVkWHe+vnPyRdgwFNA0Lqe5a5IwRa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aeqlu2R+gVbPYQOhsfwSpZh+c5+SYfRcR0AelSrf/37jN/PsHS6v6uylBacXmlMijsiPHMUb6x49vh7N5uAl7i7oPsQxI+zO96pCVZo7i6vgv6N5+5gC09/DMixBGJAwTgst98V0QW69STMUGfcd+YH3jS46T8BVn3qo4QZRtms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Amb6Km8x; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710767056; x=1742303056;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iIs+cbLa7AHztJVkWHe+vnPyRdgwFNA0Lqe5a5IwRa0=;
  b=Amb6Km8xI3D/TcLjyjwY8FdyJlPjqcGGd5qgyA/ir28TiE/5YS+/njgk
   10M+5NTcTjIDCVwpxOnipJ0bSi55szr3SctfjX5p1ZCG6vsR0RwZKIOs+
   aGCfbWyRugz9xGSQjIjZ7m1VsaZ7zh1TDMjxa9BVHnAEkR5tnk2oXsgAY
   mN9/AEFMv7pVUI1S/MPneN3AOwdCg2yzhUIbNxxRWTtAGRFHRIVAJ8pOp
   k3a+sSbfGhkXaoW6jeZR2F9iL2z/Y9xmtDUk6gJwWYen1x4Szotsq/TrP
   fwjt09leZPwQZz+XiM3GbtboHYp1GpEssGPew6648K8s9X3VuP6lpsSjs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="5707142"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="5707142"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 06:04:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="44392867"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa002.jf.intel.com with ESMTP; 18 Mar 2024 06:04:13 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: linux-hardening@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Marco Elver <elver@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC kspp-next 1/3] compiler_types: add Endianness-dependent __counted_by_{le,be}
Date: Mon, 18 Mar 2024 14:03:52 +0100
Message-ID: <20240318130354.2713265-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318130354.2713265-1-aleksander.lobakin@intel.com>
References: <20240318130354.2713265-1-aleksander.lobakin@intel.com>
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
anything, introduce __counted_by_{le,be} defined depending on platform's
Endianness to either __counted_by() when applicable or noop otherwise.
Maybe it would be a good idea to introduce such attributes on compiler
level if possible, but for now let's stop on what we have.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/compiler_types.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 3e64ec0f7ac8..9506efbf2b8c 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -242,6 +242,17 @@ struct ftrace_likely_data {
  */
 #define noinline_for_stack noinline
 
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
 /*
  * Sanitizer helper attributes: Because using __always_inline and
  * __no_sanitize_* conflict, provide helper attributes that will either expand
-- 
2.44.0


