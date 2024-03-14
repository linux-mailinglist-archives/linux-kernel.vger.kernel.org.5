Return-Path: <linux-kernel+bounces-103091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFE287BAE6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:04:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7D0E1F24A92
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF1E6DCE3;
	Thu, 14 Mar 2024 10:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="QKv1H+JN"
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBE46BFB5
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 10:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710410664; cv=none; b=IvsEWydC6Rlce3a5a1Cs+gPEoe36tfUs4yZg8HWJgS229sfTTP30y/Dyu2nkqn62VpNE8gtA4KNN2E/nqz927UnuIU+I5yWc6GJ4z7sfUVzg40ucWwtEKX56gHmuJ3JOqn/Yp7Jb5N5GgKUpjlWGd40D2m/TKrvo1Nb4oY66vQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710410664; c=relaxed/simple;
	bh=AFhsiaSN1eedmSccQpHaGcchUo0RMHyh4duqmQyuRlA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RTluTWifGl2IwYSQOYfdoqPQDWzycep6JTodww38RS9rU0196ww074hLP7qXbqbLYv8CWI18lA6/Ocrz7rpyRhmKD8ua7sOgrjo8cIu1ocNlNPr/vG8UWl9wUtMG0RYIgDzclM1L6e2FNwcobGq2KZYHsY0UUQEKUEHeJ/259TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=QKv1H+JN; arc=none smtp.client-ip=207.54.90.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710410662; x=1741946662;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AFhsiaSN1eedmSccQpHaGcchUo0RMHyh4duqmQyuRlA=;
  b=QKv1H+JNxrW2oN7SNayuouXwo/zuDQwT3KrDw7HJQyRw0OMKwAhoTaFY
   JQLn8XI4ep5cR8YTA16i+mdcnmxFA1QFEbfM64k4TSD+8mYJHBKwwKt5N
   FL6sUvNCGlg8SkVv5TmeCJvJtLTuFBMiQKbliG2g4uayse3epPV8U6fvr
   NqY5SkDB0iLHNzTqtdqwETCcZ2/xPvwMdPhFGxmo4hMJBLqjUaw999Xea
   qFOcpNiJomW9iKYyEMUeecu1W0D8X1SrQ4EOAnJ18CcJCWm8L3BW8fq0G
   Lygbwki3heY6hXyq4A2LphTiDU4ha5R54ywhBAruusqmB6epatWqqT29R
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="152241877"
X-IronPort-AV: E=Sophos;i="6.07,125,1708354800"; 
   d="scan'208";a="152241877"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 19:04:19 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
	by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 5E437D772F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 19:04:17 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 8B640DCCAD
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 19:04:16 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 2044B20099547
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 19:04:16 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id B30D11A006D;
	Thu, 14 Mar 2024 18:04:15 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 2/2] clockevents: Convert sprintf/snprintf to sysfs_emit
Date: Thu, 14 Mar 2024 18:04:02 +0800
Message-Id: <20240314100402.1326582-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240314100402.1326582-1-lizhijian@fujitsu.com>
References: <20240314100402.1326582-1-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--6.201400-10.000000
X-TMASE-MatchedRID: e6WPXQD7Ri84ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfDqO6/8R69QE8U
	roFNOGp7a6aAZTOwtJmRloiW1Kgftd2ZdKe8BPbS/sUSFaCjTLxN8rmPQRlvK7oFQ8GRC1Prs1w
	waYBQLgs9/vFVBxxqgB0XJlVTsEsboYY7KoErjW8ReM8i8p3vgEyQ5fRSh2656hUULKzHRgQLm6
	NncNkETaGvCFqoKSwTgDLqnrRlXrbIDt27MLDp0t0H8LFZNFG7bkV4e2xSge7btc58sZd4JWtX0
	+U6nf33BNN/GR02l6mieABoRFLqcl8I4oUq5Vga
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

CC: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 kernel/time/clockevents.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index a7ca458cdd9c..60a6484831b1 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -677,7 +677,7 @@ static ssize_t current_device_show(struct device *dev,
 	raw_spin_lock_irq(&clockevents_lock);
 	td = tick_get_tick_dev(dev);
 	if (td && td->evtdev)
-		count = snprintf(buf, PAGE_SIZE, "%s\n", td->evtdev->name);
+		count = sysfs_emit(buf, "%s\n", td->evtdev->name);
 	raw_spin_unlock_irq(&clockevents_lock);
 	return count;
 }
-- 
2.29.2


