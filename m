Return-Path: <linux-kernel+bounces-78263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA3D8610E8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:59:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEE571C2201F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE09F7B3FD;
	Fri, 23 Feb 2024 11:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mved+hc+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B62563104;
	Fri, 23 Feb 2024 11:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708689572; cv=none; b=KjwbSR9FyW8sNkmwqm3MwApTourRmcM5wM8ribEr4WZZhDQbecBIisM65I0ks3Lq4/diGhhKIxwcJpHlJM61P4CE6wQ0nNYC6N2cXWH46wVmHizFKor29kq1EJNOKlrR1Z+s0/ikk6kJ6DqzKAkfDNPfncfHg/ZRZfevWu7EG1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708689572; c=relaxed/simple;
	bh=oMm655ys/B46CP9FIrHXGUDXS5DwJVpwtjBF8zVXPYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jw7pP/RD8B0GZ0FTTpdpYiTeRqYr+/VEAb7dSdzxR0p8rzjOXmnHLngQqzrAF8ekh56q/Uhf/KYJwdkFnkW9NyC7GyRT0QkFdg0A0e/W0QR+d1lR0wTRieDqT8SDdTe4vHViHztpxbLBSA4LIAADTTrH1I+ZGIfJ0M1Z/dc/Smg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mved+hc+; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708689570; x=1740225570;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oMm655ys/B46CP9FIrHXGUDXS5DwJVpwtjBF8zVXPYM=;
  b=mved+hc+igbQUMZWW9PkPsdRkKsbPKT3vP8N1mEOd9xP2+NPzMeNFG4J
   QbjcsjxXv04eiuKA4HKDQdso4z9E9eDw8K8OrP8GeYHhq0pEbGiHFbpMO
   1B/X9FgzqSDe5Mzruzbet7V0t3yXbgx/XzNwS1QEt93NcNY0LWc7Ci9Rs
   SwV7pATHH+rX/W6tgkOoJetvfTyaN9cz7hbM31Toh9IKjXxecD4vZ+uN7
   URO6+Tf50WwFPeO0assClssH+1yjvyGrN1XUxejX59jBUsVVLDIIrWDNB
   miw84JpxG5wZ+wWJnr5GrAOJZ1/NP5b8D713/942ce0gQ1zqBHLFCwT2u
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="3129511"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="3129511"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 03:59:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10547906"
Received: from dcai-bmc-sherry-1.sh.intel.com ([10.239.138.57])
  by fmviesa004.fm.intel.com with ESMTP; 23 Feb 2024 03:59:27 -0800
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
Subject: [PATCH net v1] Documentations: correct net_cachelines title for struct inet_sock
Date: Fri, 23 Feb 2024 20:02:12 +0800
Message-ID: <20240223120215.2300560-1-haiyue.wang@intel.com>
X-Mailer: git-send-email 2.43.2
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
 Documentation/networking/net_cachelines/inet_sock.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/networking/net_cachelines/inet_sock.rst b/Documentation/networking/net_cachelines/inet_sock.rst
index a2babd0d7954..868361b4792d 100644
--- a/Documentation/networking/net_cachelines/inet_sock.rst
+++ b/Documentation/networking/net_cachelines/inet_sock.rst
@@ -2,7 +2,7 @@
 .. Copyright (C) 2023 Google LLC
 
 =====================================================
-inet_connection_sock struct fast path usage breakdown
+inet_sock struct fast path usage breakdown
 =====================================================
 
 Type                    Name                  fastpath_tx_access  fastpath_rx_access  comment
-- 
2.43.2


