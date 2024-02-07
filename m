Return-Path: <linux-kernel+bounces-56465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9426384CA7F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5109329152B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8965C5F7;
	Wed,  7 Feb 2024 12:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="MPgOiRSk"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9E55BAC4
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 12:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707307677; cv=none; b=Hh6ZAy7MtIwTepOShPkBStBAIcidDLiPS4mj871fvz8Y03UZ8pb5qOP7RjM9wpGu8hDHhGQcJujUwM9cT8FE+dEAGXdiISKpBE8UxlP3Y5ODKNujGETwekLTa02OvUYbpgAi1NHcQJYWtm8OuxMyCvEwWOTQJLVZpx0SO29JgDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707307677; c=relaxed/simple;
	bh=NYw9l+bXoPskg73dqQ5BlVMt8LzWUzBTvky6tqXSly0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BiFtDhI5mOoK7Z46h4CeHRG6K71g46BQMHqDmDru5KbCTr/yyrmnPOrW0tKyTzCo72Skh7r1OR5SSmt/F23hl/4fWYShRykmDh8puErKh+rvCbd8HZzZ8SScVxe3d1MTKBGyHIifE9dg39z1uqNKmgX3ZsKdD8alP6D7/1b4VBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=MPgOiRSk; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-337d05b8942so486447f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 04:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707307673; x=1707912473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8pXU065R8j0WF5WsKAZv+XgZqzc/5yTJ5Xq8oCQ9So=;
        b=MPgOiRSkTxmMLIeoko5HPtqgXpR5EcuKIVNP4+5uTIioZRbFY06ZxbTL2FDv+XuKK/
         50HY8Gy7PIHLPAbJA277y1yOgczGQiM/bkVVu9sXkwUqHHATu/FYuXfxE3A2OlDxxDcJ
         +HuQemuEgfoKapU0eP7KXuIGrzUb6az75MOfkk1Fm8fVTPc/y+iUMTremd04WLE5gBO/
         w3/y+wkKx1n8HNw91esOFVPGaVmMb/hLQU9Hy/W8JrQ+4995Y0+CYwwA0Dt8cFVE1uNi
         Sh9Ct5JPv6L+kQ2MrR0l7vxJFQsHC9bjuh4sXjv2URkviN1jQfps5u/zBoBeuShwoO95
         t8bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707307673; x=1707912473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8pXU065R8j0WF5WsKAZv+XgZqzc/5yTJ5Xq8oCQ9So=;
        b=LEBazlPDvZTuZ4K6cFg3jfMS2L87/jZV+ISZIxc07egDAJjXnTPMv1ewVOONEXj6WH
         IGnxrwKTq+KFDRbEFrE/KsqXA2CSpx9ZwEhU8BaoVcNHmrK2Jht7LB+nfq1ikjPQlt+v
         TBdNlhpHOfrQUtrDgmWMF+wSN9bv10Ffob35VRpX2nDVv6MhI0xtGI+g8xdoJA4EeG2z
         tKwS5le6kAUkHQ7sjsoGlMnYV2ArW9kCrLpyUQ6MrNGQnXrTQuHHHoHzyAb3ilasagSU
         /hz6YMxWSxqxnFxfTc8fFuXW2i1JAbsINT5QQGI4rMnSr4l16Otd6Qb+8kn9i6QB2Xh0
         xf1Q==
X-Gm-Message-State: AOJu0Ywxo3iZz/iTSRSzP5VXNjh7bQzB3ABJDRHAXzaACm08GJFGbgOt
	YSoG1KLpfVH2O626AHqHYxY9KLEBFwLnkrp8pB5g5Bh/YtNRAvAuShbmT9zgQeg=
X-Google-Smtp-Source: AGHT+IHxhsBj13/V9713emnkJKi2bOGNaaDEBPlWNWQmdBgqtYS9PzrOzm9JfR48AlCgTsbNpdXxiw==
X-Received: by 2002:adf:dd8b:0:b0:33b:305c:9de7 with SMTP id x11-20020adfdd8b000000b0033b305c9de7mr3456728wrl.50.1707307673633;
        Wed, 07 Feb 2024 04:07:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWTTQoQujoKD98K5RDcZ0QGCdCrcWsry8yyFZx96BpOOKCmgr5/QWLzRYTIE723RDA3tCxQaXoLt9BPkzheSBP7xK6rU5eUntOlOnuw+zm5cOsuL5pDJJqal4IooyFN/COmqcwuVOEwtk8a9vbqBuIIiUSa/KdURaKXvDGg8xLB7ABVyNXtADifd0qLXzrP00HdYyEwfIOFL6OX+Rw3JHzcLci1oOoDnxC1GzGO5Qc0TeuLH0aijoNFP3P5LoBdtMnBUhreNJqaafIuOUmR1acQmeD2uYNqZPLXD6y/7pfuiIKifjZtiIkuYBI+d72OYInUGNa95xb6V7U=
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.114])
        by smtp.gmail.com with ESMTPSA id f2-20020a5d50c2000000b0033b4db744e5sm1363957wrt.12.2024.02.07.04.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 04:07:53 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next 2/5] net: ravb: Keep the reverse order of operations in ravb_close()
Date: Wed,  7 Feb 2024 14:07:30 +0200
Message-Id: <20240207120733.1746920-3-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240207120733.1746920-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240207120733.1746920-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Keep the reverse order of operations in ravb_close() when compared with
ravb_open(). This is the recommended configuration sequence.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
---

Changes since [2]:
- none

Changes in v3 of [2]:
- fixed typos in patch description
- collected tags

Changes in v2 of [2]:
- none; this patch is new

[2] https://lore.kernel.org/all/20240105082339.1468817-1-claudiu.beznea.uj@bp.renesas.com/


 drivers/net/ethernet/renesas/ravb_main.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index e235342e0827..0f38e127ad45 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2228,6 +2228,14 @@ static int ravb_close(struct net_device *ndev)
 	ravb_write(ndev, 0, RIC2);
 	ravb_write(ndev, 0, TIC);
 
+	/* PHY disconnect */
+	if (ndev->phydev) {
+		phy_stop(ndev->phydev);
+		phy_disconnect(ndev->phydev);
+		if (of_phy_is_fixed_link(np))
+			of_phy_deregister_fixed_link(np);
+	}
+
 	/* Stop PTP Clock driver */
 	if (info->gptp || info->ccc_gac)
 		ravb_ptp_stop(ndev);
@@ -2246,14 +2254,6 @@ static int ravb_close(struct net_device *ndev)
 		}
 	}
 
-	/* PHY disconnect */
-	if (ndev->phydev) {
-		phy_stop(ndev->phydev);
-		phy_disconnect(ndev->phydev);
-		if (of_phy_is_fixed_link(np))
-			of_phy_deregister_fixed_link(np);
-	}
-
 	cancel_work_sync(&priv->work);
 
 	if (info->nc_queues)
-- 
2.39.2


