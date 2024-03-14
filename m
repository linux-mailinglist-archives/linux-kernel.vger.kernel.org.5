Return-Path: <linux-kernel+bounces-103003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CAB87B9A2
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C55711C22176
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAA76BFC9;
	Thu, 14 Mar 2024 08:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="XVBKt2ai"
Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EBBEEC4
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 08:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710406103; cv=none; b=D3ihg8KVxvBzL4mCxMc7aikz27wWLNpFtqNdQvEZpTVP8Cp2n59OwmMsNwFTtHIxeVarJaAgJzR5kNaw94HLHd0sN33oxyOOBV2eEngwhAHEOX1rdWQbOdh9A/F66j3pAgKHi/4kpmI8ARQhlpqqvr2vrKUQ6MadkrcssuJUVyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710406103; c=relaxed/simple;
	bh=MMdcS9PHTtB1A8gshHcCMqjx6OfA/c8Jji6swSg/N6A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sOU3h2ZVsoMUnYyUQ9XBZ7f6wtd0a/u0/G/Y2oc6ezKf6R8bD93xqE4usF35h/FM7KltLBb4P9ld4avNMut9opmeFymGdQWsEdyn4w19C5MNyN4yQDt2d14B/+KpseqMN1EB/RkKAUaFX2isd9P2vrBqjTruZbob076I4mpslpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=XVBKt2ai; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710406101; x=1741942101;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MMdcS9PHTtB1A8gshHcCMqjx6OfA/c8Jji6swSg/N6A=;
  b=XVBKt2aicz3U65yuSSXMVSy0D9wMtihvdgSOU4/tInh10Knp/gN/UF1N
   PaUkptTfmmoJwQW2iQ0FxnDPtGMcDmAqCLR22I3xAth7MCNWYOCjeRQU+
   lsui04ewSBMFEWzMez0ChFJ5iYJCQGtKYifILrsItUNnT4iawgpW8rmP2
   fZn28Ocnjy8/cDEBXUVNkXSks9sQUjsryRExKR8XJaltCqetiVbxra7Sv
   7lzhmSw4iqtTaE/C86QtcuvPbp6C9SCgE/sEVHjLz0NsvSnX+0aDWh5p8
   WPt/1j9/BmWPXkZdEbLTH/ijq3jvpqx2AQ0mm38z3s0GpiDEDkQgxPozh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="131563521"
X-IronPort-AV: E=Sophos;i="6.07,124,1708354800"; 
   d="scan'208";a="131563521"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 17:47:09 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id F060D275FA
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 17:47:06 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 3074BD3F01
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 17:47:06 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id A91616895D
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 17:47:05 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id BDBAC1A006B;
	Thu, 14 Mar 2024 16:47:04 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Jeremy Kerr <jk@ozlabs.org>,
	Joel Stanley <joel@jms.id.au>,
	Alistar Popple <alistair@popple.id.au>,
	Eddie James <eajames@linux.ibm.com>,
	linux-fsi@lists.ozlabs.org
Subject: [PATCH v2] fsi: Convert sprintf/snprintf to sysfs_emit
Date: Thu, 14 Mar 2024 16:46:56 +0800
Message-Id: <20240314084656.1322057-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28250.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28250.006
X-TMASE-Result: 10--4.735400-10.000000
X-TMASE-MatchedRID: st9CF01730Y4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfDqO6/8R69QE8U
	roFNOGp7a6aAZTOwtJmRloiW1Kgftd2ZdKe8BPbS7pujb8urdzZBHuVYxc8DW3hh5KUdlgWiKqF
	q1hn3Eb3d+/nM3Koh0iaTw03n/wYO38rWKQkiws65x7uAXGEprcE5XPQnBzGXq8KsbROd9VSArq
	oIZrVn15fzUkBpc072hKK/bK+QypCR9GF2J2xqMxRFJJyf5BJe3QfwsVk0UbvqwGfCk7KUs2S0w
	8rP2t3p6smvKwXUmDz24c33NcG6BmA5T/19m4CaVsKKNygcOcFJrCNy7ijKN7mf1qldocYB+Opf
	yvCj64ILkzL/P/0IKyHJp2UYVccqxOB8J0pRLhyJxKSZiwBX6QtRTXOqKmFVftwZ3X11IV0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Per filesystems/sysfs.rst, show() should only use sysfs_emit()
or sysfs_emit_at() when formatting the value to be returned to user space.

coccinelle complains that there are still a couple of functions that use
snprintf(). Convert them to sysfs_emit().

sprintf() will be converted as weel if they have.

Generally, this patch is generated by
make coccicheck M=<path/to/file> MODE=patch \
COCCI=scripts/coccinelle/api/device_attr_show.cocci

No functional change intended

CC: Jeremy Kerr <jk@ozlabs.org>
CC: Joel Stanley <joel@jms.id.au>
CC: Alistar Popple <alistair@popple.id.au>
CC: Eddie James <eajames@linux.ibm.com>
CC: linux-fsi@lists.ozlabs.org
Reviewed-by: Eddie James <eajames@linux.ibm.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/fsi/fsi-master-ast-cf.c | 4 ++--
 drivers/fsi/fsi-master-gpio.c   | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/fsi/fsi-master-ast-cf.c b/drivers/fsi/fsi-master-ast-cf.c
index 812dfa9a9140..c6a5c38c206f 100644
--- a/drivers/fsi/fsi-master-ast-cf.c
+++ b/drivers/fsi/fsi-master-ast-cf.c
@@ -1083,8 +1083,8 @@ static ssize_t external_mode_show(struct device *dev,
 {
 	struct fsi_master_acf *master = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE - 1, "%u\n",
-			master->external_mode ? 1 : 0);
+	return sysfs_emit(buf, "%u\n",
+			  master->external_mode ? 1 : 0);
 }
 
 static ssize_t external_mode_store(struct device *dev,
diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
index ed03da4f2447..13710b4f2f86 100644
--- a/drivers/fsi/fsi-master-gpio.c
+++ b/drivers/fsi/fsi-master-gpio.c
@@ -718,8 +718,8 @@ static ssize_t external_mode_show(struct device *dev,
 {
 	struct fsi_master_gpio *master = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE - 1, "%u\n",
-			master->external_mode ? 1 : 0);
+	return sysfs_emit(buf, "%u\n",
+			  master->external_mode ? 1 : 0);
 }
 
 static ssize_t external_mode_store(struct device *dev,
-- 
2.29.2


