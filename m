Return-Path: <linux-kernel+bounces-82026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B94D4867DE5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA7E91C22724
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E6A12FF6E;
	Mon, 26 Feb 2024 17:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ly1WuY+c"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD7F12C800;
	Mon, 26 Feb 2024 17:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708967410; cv=none; b=kpSn/yE2Li6fayGGqAa6Bj1lTBSvhHBIpLhOCpKNdrq2N2nAm/mmD/bWL97GKWzzY2ojIJe6YDzi9qFccaEd5A307aAz0Z6n/HbI6bBh3vx6xxOdl6ThU0NhzugfZUY3GzXxtLG9YUcpPk3S9QUybb5wI4m8yC04CIcAKb9VvGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708967410; c=relaxed/simple;
	bh=xT4hap9IvpjLgMP/HHzHVUba5+EIi7T8RgyP7aSJiOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ht1YAURVzS6ugRL5PEyYXY22fj5uqbhB4YkU71Lki7UWD1xQJvSiS6ge/yEXHe5TYA6kcU3pSOopTGB2oZgFAM843Ur3WVAyVnS7ZeyD9KjPHhhLG6lpkxoUcLZM+3JRsU2jcpqHdLaa0wYSPPJMHihXVDe2BHa1EO08KxYCRps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ly1WuY+c; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708967409; x=1740503409;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xT4hap9IvpjLgMP/HHzHVUba5+EIi7T8RgyP7aSJiOk=;
  b=Ly1WuY+cOvZ4viIMXAKS95RncyFy3Xcg6V9ADtMrhFo71VFL4aT8Pzpw
   JmeLIH0aKjw42I18iLCbLgjRXrIcZyUh+uVhJTJ3EAaTKbaWSV5ukj+se
   eiYqS7Otsi8aCZl/V/pWZhpOY3wPx9wMQH58v310n5qHam/twr/m4x5YR
   +cR6syRm3dZl+UW76gyPZEDVVCcKzmjnCLsMuiMvT2c4aUjdO+SZlKjgf
   S7s17d80VBKf4aFAoYS+fP7Roxs62F7eLJKKFQcRNnT90TCXpoDDcziDh
   WyST4qI9yqdTgeJSo0Gkt4GDyFr0EfOvxxC8OTMCkjs3SkCWlG8miUnan
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3426882"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="3426882"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 09:10:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="6606452"
Received: from dcai-bmc-sherry-1.sh.intel.com ([10.239.138.57])
  by fmviesa007.fm.intel.com with ESMTP; 26 Feb 2024 09:10:05 -0800
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
Subject: [PATCH net v3] Documentations: correct net_cachelines title for struct inet_sock
Date: Tue, 27 Feb 2024 01:09:16 +0800
Message-ID: <20240226171254.4066289-1-haiyue.wang@intel.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The fast path usage breakdown describes the detail for 'inet_sock', fix
the markup title.

Signed-off-by: Haiyue Wang <haiyue.wang@intel.com>
---
v3:
  - Update the git commit message.
  - Stop using the git '--in-reply-to' to reply.

v2: https://lore.kernel.org/netdev/20240226165821.4062854-1-haiyue.wang@intel.com/
   - Adjust the title length to the markup lines.

v1: https://lore.kernel.org/netdev/20240223120215.2300560-1-haiyue.wang@intel.com/
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


