Return-Path: <linux-kernel+bounces-103000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4447487B99C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 763771C212EB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190B86BFCE;
	Thu, 14 Mar 2024 08:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="d8evgziB"
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCE36BFBA;
	Thu, 14 Mar 2024 08:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.61.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710406046; cv=none; b=rROxpfQoM/XF0HGQKOR9k8jufvXk/h7sIKMMuBq63jg9E9rSyRFhJ3TFPM65IFW1Xj5SbplYt0lRXKcqRh0G+x7E06KTV6T4fZBMl6MEaeXu+/IfM6q9CZWY64R7Vqd1kE41PZyGZL9q4LZWQ3Qb+9VdCsD+i0DTk0x5kUB+pdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710406046; c=relaxed/simple;
	bh=gGWn3mJJ9//foGhzo+3DZQDoFfejY38eJYOl4hXpaPE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FoJx+pT/293VUXzIdW32IcHv9QGg7LxaG6cipw3ZFX1NirzpLvMrnAg9syrWgh4QEkZdzlBGbbZ0ctjBPJU/UiCwv+JVpZ0DwpG0pRMyEHu9ed7c8vOR1KJGWX/phYqvXYsQ+fzY/R+1Ci+5ddH32FlI7bIPzDcOW53kWEM9n60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=d8evgziB; arc=none smtp.client-ip=139.138.61.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1710406042; x=1741942042;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gGWn3mJJ9//foGhzo+3DZQDoFfejY38eJYOl4hXpaPE=;
  b=d8evgziBxRREljQ54t0SlhKgIbHDZEKNvcIsY2isxqG88CbQekfHLeVD
   1juIF9hz84szkoTDJJxNMv0SNyVl+dgkGZGFrnWUAaNDFKj0kAD2hmL3O
   T/x3bbtXefTCxyDEMtgEaA3jkuFpgQIwv8fGS1VyQ47K2ociMLAndc0U5
   9qfUtYJGV54SgMqvKQSOJFUtrG47uPs1DWxfVIeyHAXxWkQJ5q8sqes8A
   VdJ3h71pRCv9cCMk2tRBTLkauoVkaBxWOUIN9pC8rut4mUETMuqFQSuOS
   I9bvHBtmUJT9ORapRUHj99Hgacly4l6aMuK5HZxg9colHJmynXozMMTOu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="140239806"
X-IronPort-AV: E=Sophos;i="6.07,124,1708354800"; 
   d="scan'208";a="140239806"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 17:46:10 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id A5526F0FC5;
	Thu, 14 Mar 2024 17:46:08 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
	by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id CA48BC520E;
	Thu, 14 Mar 2024 17:46:07 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 230566895D;
	Thu, 14 Mar 2024 17:46:07 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 890DF1A006B;
	Thu, 14 Mar 2024 16:46:06 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-crypto@vger.kernel.org
Subject: [PATCH] hwrng: core: Convert sprintf/snprintf to sysfs_emit
Date: Thu, 14 Mar 2024 16:45:59 +0800
Message-Id: <20240314084559.1321951-1-lizhijian@fujitsu.com>
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
X-TMASE-Result: 10--5.801500-10.000000
X-TMASE-MatchedRID: ebEStOsB1eE4ibokZ3+Q0CoiRKlBVkYIBXngI6jFvpfDqO6/8R69QE8U
	roFNOGp7a6aAZTOwtJmRloiW1Kgftd2ZdKe8BPbSleLXPzO3VNH0swHSFcVJ6C99T+uJIleRfDo
	fTpsyCK+KztDhRgoFQW4suX2uLJTkj56IjTnLR+lO5y1KmK5bJRSLgSFq3Tnj31GU/N5W5BD+y9
	1WXLvD2XP+9mhbDjvthKK/bK+QypCR9GF2J2xqMxRFJJyf5BJeZVXUb4KTaXv6C0ePs7A07cNbT
	FVOzjU8Qwlgq3zGvE/GtGPM+O9THGFiNemrkjMpfRLemXXHCzw=
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

CC: Olivia Mackall <olivia@selenic.com>
CC: Herbert Xu <herbert@gondor.apana.org.au>
CC: linux-crypto@vger.kernel.org
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
Split them per subsystem so that the maintainer can review it easily
[1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
---
 drivers/char/hw_random/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
index a3bbdd6e60fc..f5c71a617a99 100644
--- a/drivers/char/hw_random/core.c
+++ b/drivers/char/hw_random/core.c
@@ -382,7 +382,7 @@ static ssize_t rng_current_show(struct device *dev,
 	if (IS_ERR(rng))
 		return PTR_ERR(rng);
 
-	ret = snprintf(buf, PAGE_SIZE, "%s\n", rng ? rng->name : "none");
+	ret = sysfs_emit(buf, "%s\n", rng ? rng->name : "none");
 	put_rng(rng);
 
 	return ret;
-- 
2.29.2


