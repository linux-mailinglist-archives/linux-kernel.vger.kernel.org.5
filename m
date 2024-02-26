Return-Path: <linux-kernel+bounces-81993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E71867D7D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B0231C2338F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D89613AA3D;
	Mon, 26 Feb 2024 16:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bZmB41bu"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F4212FB28;
	Mon, 26 Feb 2024 16:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966533; cv=none; b=Q1sr9BzQ16KbeRqosfHT5lximpjFA8RoS6Xmj05WM5LT8cE8MOBttcHeoiH7IQ+TY8COsaA0JmDrfoAxR9e9orT8DkikMx+kxnV0xHcg7dVPKnhzHQqNa31iI3M/kbYJnXepTJfcMWE1IZpnS6GT2HpWUXuJLXK00g7RVqbHrJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966533; c=relaxed/simple;
	bh=BJdX+dwkJG0erLF5KJUdvylWO68GXGEtp2ZkUTRBKEs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFrqH/GyeYolKjmb846PIUJOddh9YX257CJacpMKBkh5lxFQXrO/DAaD7sPRdsO0LkEaCnvreg5GTHoQVwl6R0jMJg/ch9zhkXEQ0f5si3MMh7keaXgUnDucthiwW+QVUnzVhJtycvyQpN0bxJOCL2h6xmawhggEeTpAY8Am+Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bZmB41bu; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708966532; x=1740502532;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BJdX+dwkJG0erLF5KJUdvylWO68GXGEtp2ZkUTRBKEs=;
  b=bZmB41bu44mhNlprPEGSFqpXg5rIbiKkUQhV8wrfA7w/Y+xWDpCHCpbl
   1HpOS3y1JlXzZzvGny5N/iuBp2UcEhX7mPmjoyEtIkEx1KNVXDIuZrU6G
   3qf59Wb3VRoIbkfL7SpAeqEUiH+OqpFRtx3eaIlJpLPbcLPXUmCDDM9jq
   AH5hy+ndJ8mWM5oiGw4D186hTY2o0mCkZGlBxN+/Y6NTX+YzWdAYbRkhl
   VFtghxPJpbkGchVATl3io67ZKAPcrAH4uN4Mvk1ICmWEiToQ+2EUQqtP4
   fH9/ypIRnmeAGdqNP7waQOrKrbWr3ENiYwsdoDN2jOk28+O0rLj8mOI9Q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="7045372"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="7045372"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 08:55:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="6874410"
Received: from dcai-bmc-sherry-1.sh.intel.com ([10.239.138.57])
  by fmviesa008.fm.intel.com with ESMTP; 26 Feb 2024 08:55:28 -0800
From: Haiyue Wang <haiyue.wang@intel.com>
To: netdev@vger.kernel.org,
	lixiaoyan@google.com
Cc: Haiyue Wang <haiyue.wang@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v2] Documentations: correct net_cachelines title for struct inet_sock
Date: Tue, 27 Feb 2024 00:57:46 +0800
Message-ID: <20240226165821.4062854-1-haiyue.wang@intel.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240223120215.2300560-1-haiyue.wang@intel.com>
References: <20240223120215.2300560-1-haiyue.wang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's 'inet_sock' fast path usage breakdown, not 'inet_connection_sock',
correct it.

Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
---
v2: Adjust the title length to the markup lines.
---
 Documentation/networking/net_cachelines/inet_sock.rst | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/net_cachelines/inet_sock.rst b/Documentation/networking/net_cachelines/inet_sock.rst
index a2babd0d7954..595d7ef5fc8b 100644
--- a/Documentation/networking/net_cachelines/inet_sock.rst
+++ b/Documentation/networking/net_cachelines/inet_sock.rst
@@ -1,9 +1,9 @@
 .. SPDX-License-Identifier: GPL-2.0
 .. Copyright (C) 2023 Google LLC
 
-=====================================================
-inet_connection_sock struct fast path usage breakdown
-=====================================================
+==========================================
+inet_sock struct fast path usage breakdown
+==========================================
 
 Type                    Name                  fastpath_tx_access  fastpath_rx_access  comment
 ..struct                ..inet_sock                                                     
-- 
2.43.2


