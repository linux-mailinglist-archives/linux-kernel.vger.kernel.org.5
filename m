Return-Path: <linux-kernel+bounces-70274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1FF859577
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ED6D1C2148E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10DBEAFC;
	Sun, 18 Feb 2024 08:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="HbEJP312"
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F55DDC3
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 08:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708243338; cv=none; b=UllQTWCBRwiHLD/10OIhU7boZGK+WvX4g6duNKUOZLsxYJVM2uYlXnqL2rhT/0DfhSc6zKGyQ8/OqVAEecGE3RTlNMSFdTOuULDodva9wzW7Qv0IG6ezvbfTi+t0/t+D8FiR9r6ktt/a2ihArIlu1RNfstA6LcwqL4fsisp6S80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708243338; c=relaxed/simple;
	bh=C099CukdDdK4Elet3lQBVaWXzyWO02Fpp/gWK4Al8TA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Rd2eHAVJ2U3ixu/2i7MMOOOOs3QrrwM8f7y0rX4+xsTonUMOX6QANCT0v2fSqJ7fzPUhhmTO0vALtMTjQtNEsoXZ80/OINQGszZTLN4Eb5aivWCS0uuXeFPQjfQ8zPrVLlQj1fySHQqBdAXEnK4lElPUhDSPq0dgTiJzQQ+LP0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=HbEJP312; arc=none smtp.client-ip=207.54.90.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1708243335; x=1739779335;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=C099CukdDdK4Elet3lQBVaWXzyWO02Fpp/gWK4Al8TA=;
  b=HbEJP312LC1U8VoiXiXqc9CNf6cEapz8uSuY8uJdM4k4FOZ02952bnOU
   r2o9hJ0utDuxhigIwB+zHm6bEJSdHmM0Jx9XZHcOJWsOEYf2CNawteD1e
   BU9nh+aG/kDXB17tPhMsQDF3X7DwQ+S7/zl072dDeBrbi7ZcaI5mO7z5f
   OygQdpCHYj7IyyFPyeSGrxeVs9zuey9fP2WyhIH+9QHC64issXWz2Q9Xs
   dusxI12/1k9tbCPZiGL5eOlTH+xyiXCZi545XcRMdlRwm//rzwYhyOzHU
   qAke7IyVNeYA3zMwznEWJodbmNMz1HBqwcrFDht9qJVrRkjlidUzwms+O
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="149673458"
X-IronPort-AV: E=Sophos;i="6.06,168,1705330800"; 
   d="scan'208";a="149673458"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2024 17:01:02 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 2D69E8B010
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 17:01:00 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 78E01156B72
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 17:00:59 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id EC271200A7ECC
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 17:00:58 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 50BDC1A006B;
	Sun, 18 Feb 2024 16:00:58 +0800 (CST)
From: Li Zhijian <lizhijian@fujitsu.com>
To: linux-kernel@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	cocci@inria.fr
Subject: [PATCH v2] coccinelle: device_attr_show: Remove useless expression STR
Date: Sun, 18 Feb 2024 16:00:54 +0800
Message-Id: <20240218080054.719008-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28198.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28198.005
X-TMASE-Result: 10-2.432000-10.000000
X-TMASE-MatchedRID: Eg8aHm4JSTV0AdYYTJWxRBFbgtHjUWLy1QQ6Jx/fflaZtziFUn+D+VDO
	mRheGpIycW49dHXLWX0lMcFNu44sGzxz5tDhhD0GgvmNrsT46HLBOVz0Jwcxl6vCrG0TnfVUgK6
	qCGa1Z9cSkTIlq5S+sSqrdhRtfw3QHxPMjOKY7A/+HHE8LDNSg8RB0bsfrpPIcSqbxBgG0w4/hA
	kX/IXASA9botRp+teq3A0gn0KlYUGMMycvCFPy0ZyRFBZM4sMWFlxNpwo362U/Y5m9xdEIztO64
	0nFRv3qomUEc5R2CUhbjBuldNvkMkoq97WSHdFjfupJaud1uZCfRs6uIbkFVw==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Commit ff82e84e80fc ("coccinelle: device_attr_show: simplify patch case")
simplifies the patch case, as a result, STR is no longer needed.

This also helps to fix below coccicheck warning:
> warning: rp: metavariable STR not used in the - or context code

CC: Julia Lawall <Julia.Lawall@inria.fr>
CC: Nicolas Palix <nicolas.palix@imag.fr>
CC: cocci@inria.fr
Fixes: ff82e84e80fc ("coccinelle: device_attr_show: simplify patch case")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 scripts/coccinelle/api/device_attr_show.cocci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccinelle/api/device_attr_show.cocci b/scripts/coccinelle/api/device_attr_show.cocci
index 550d1d2fc02a..dfcf9304195f 100644
--- a/scripts/coccinelle/api/device_attr_show.cocci
+++ b/scripts/coccinelle/api/device_attr_show.cocci
@@ -28,7 +28,7 @@ ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
 
 @rp depends on patch@
 identifier show, dev, attr, buf;
-expression BUF, SZ, FORMAT, STR;
+expression BUF, SZ, FORMAT;
 @@
 
 ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
-- 
2.29.2


