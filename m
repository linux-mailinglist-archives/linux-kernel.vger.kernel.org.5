Return-Path: <linux-kernel+bounces-46022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C28F184396D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:43:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3820F1F23229
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9766869D21;
	Wed, 31 Jan 2024 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="m0W6mpSA"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EF066B5F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690515; cv=none; b=PJxX6koJ8bTSBbZg1mv68pMyO7MMn1dXql2pGSpJLVqbBY2HclZQJtifk6Q/egeNqGGsbtfKwgGcu0FlX1z4vrXMTJMe38bCQDMqoW3zIm4B8BdqhIWBKZaXSaXSmiPi2U2zlFqelqwnprArOEJ1yEzGmN7CiRS8tSSO8YRI3Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690515; c=relaxed/simple;
	bh=dklOpKsyY20gACcIKy4CcTI5WliooZ2yY0L9WV+xUdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qqD4DeZmE0u6iECo8Kn0Q3cnLsjMABqXUd6PpfwoGjujZTqSKB+fQJZ6UMTYolZiH07vy50nWi0qltZXE3a35VQDjPu9oPa/TnEI+TzbEwcpSQ7DGnpFuljr2awg8T/vo1YSGaK2SpRPHAZoWdHTQU8yeInV7TpviBOE3YIOyQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=m0W6mpSA; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55eee4a042eso4196446a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 00:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706690511; x=1707295311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJFy8U7M4bryV96Zq0jRThjn9Ebbq49lbecxpcNk9ss=;
        b=m0W6mpSAbEY1ButKbtsIumfUuDxjn0xYXCZNY6+zbpuDLKLoEM/OSCCpYJSey0e4+t
         SYSRYlKK15UcKLOM6/YBEsrj2rTSEiIOmHJcXJdAphJMNK0NFsD4YzTmZf5JJ9U/hU97
         KiK0Ts6GHBnvQDDGdyExxVJ043zMcuT954tn6e7LT02Ik+b34wYKmix/rTV1E/0IQBsJ
         i0lf8jX2JTfwHrBDFiWZ3VhST6j3nGGD4fonaUybymQKS/q7XDjCPLqL2LpXhyXo3f0A
         PmOSy/v9ceQZ8JyfjSTZG5dqxKpuL2I4oyjxKXPFN/Ns0PzAh2PGFTzq+koyHUB/LTPj
         eUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706690511; x=1707295311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJFy8U7M4bryV96Zq0jRThjn9Ebbq49lbecxpcNk9ss=;
        b=bbUMxrIx1V+mh7+XidTvtUOeRSaIUlvOd/+/iscfHS64MT/R2pdgjuYOFCbgJBeECs
         9KMj++/qNt0ZHXPOxYRjrNM2Wgrh967Yy4iz88nsxSPVzVyE80ljLQ+RSWeAcMWRKLAJ
         QwGliblQMhakDdxwRK3QovwYlAMSHy+hvrM2LeE7B14dF3ucR34N6asxKCbd27qJ1meK
         YTTG+y64cdt2+74NZVEpKLojpuL3jjfKsHtsBBC6YDmWqSUuUyX0LyxVCynk8sRnGvtz
         KZrp9ucOs4NEL4trQcXfbhln3NuIzonrjQ3qfvMlh3iWzTVnWd8XqL4pf/RPALrm4dNb
         XtyA==
X-Gm-Message-State: AOJu0YzB0+SHshtem3r6kFqZ+W7Y5BNms/fmSdK7M8EgC8eZluxZveIv
	Z+UkJWsMULqx1kr/jNyR6v2ZaDZa903mgxrllHLhtTVzijU4fTQqWg4MYAw7Wmw=
X-Google-Smtp-Source: AGHT+IHul4OILIaDxbopgzMq6EJx+ujTxObFmE8uaf6iDVoivEW5FCjWHMGKN9JeHQe0LoLwdJOkRg==
X-Received: by 2002:aa7:d897:0:b0:55f:28cd:bb42 with SMTP id u23-20020aa7d897000000b0055f28cdbb42mr592294edq.10.1706690511422;
        Wed, 31 Jan 2024 00:41:51 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV8slgI9Hwzsyh94xWW4P4Yqr9iv4C0VIpCYRduKf57Dtl4RRbiTtpnkv2ZwxvT68F6trj1TctScQGC1SDmZO6no2g/DwBJ2h16HKx9o5OceLICxeOWdL98irFE+qSvM9yn49kozVT0Vcu/aYBtFjGuF1RE6TH1OUrsgh+RJ+6HRBlCzeQTvx0AOv8U62lFdyz6cxiFddW3NIZonD2nPUddsaTMbfvHIJgH4fEnLkv0v+UxJSc72bK7SfdvaR9ciMdq5K+ZNu4fiXZLQV1J1ikakBeTy3sC9c8M7UD4qskc0n3ixJRdXWLNbtwgVRH6lvUJESHfyulsO1X3KnAgOKsY2rYIk1GitSOLyyI2hInYPK4T4oMggNp/6uaMn/OaAcFbTvtS1eFQp62WRD979AjzRPzPudN3VhT1ndqz+dHuNuW3mD0=
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.87])
        by smtp.gmail.com with ESMTPSA id cq16-20020a056402221000b0055f02661ae2sm2863630edb.78.2024.01.31.00.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 00:41:51 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: s.shtylyov@omp.ru,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH net-next v5 04/15] net: ravb: Switch to SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() and pm_ptr()
Date: Wed, 31 Jan 2024 10:41:22 +0200
Message-Id: <20240131084133.1671440-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131084133.1671440-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240131084133.1671440-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

SET_SYSTEM_SLEEP_PM_OPS() and SET_RUNTIME_PM_OPS() are deprecated now
and require __maybe_unused protection against unused function warnings.
The usage of pm_ptr() and SYSTEM_SLEEP_PM_OPS()/RUNTIME_PM_OPS() allows
the compiler to see the functions, thus suppressing the warning. Thus
drop the __maybe_unused markings.

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v5:
- none

Changes in v4:
- none

Changes in v3:
- none

Changes in v2:
- collected tags

 drivers/net/ethernet/renesas/ravb_main.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index fd431f1a0b98..7ced5db04f75 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -2971,7 +2971,7 @@ static int ravb_wol_restore(struct net_device *ndev)
 	return disable_irq_wake(priv->emac_irq);
 }
 
-static int __maybe_unused ravb_suspend(struct device *dev)
+static int ravb_suspend(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct ravb_private *priv = netdev_priv(ndev);
@@ -2993,7 +2993,7 @@ static int __maybe_unused ravb_suspend(struct device *dev)
 	return ret;
 }
 
-static int __maybe_unused ravb_resume(struct device *dev)
+static int ravb_resume(struct device *dev)
 {
 	struct net_device *ndev = dev_get_drvdata(dev);
 	struct ravb_private *priv = netdev_priv(ndev);
@@ -3052,7 +3052,7 @@ static int __maybe_unused ravb_resume(struct device *dev)
 	return ret;
 }
 
-static int __maybe_unused ravb_runtime_nop(struct device *dev)
+static int ravb_runtime_nop(struct device *dev)
 {
 	/* Runtime PM callback shared between ->runtime_suspend()
 	 * and ->runtime_resume(). Simply returns success.
@@ -3065,8 +3065,8 @@ static int __maybe_unused ravb_runtime_nop(struct device *dev)
 }
 
 static const struct dev_pm_ops ravb_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(ravb_suspend, ravb_resume)
-	SET_RUNTIME_PM_OPS(ravb_runtime_nop, ravb_runtime_nop, NULL)
+	SYSTEM_SLEEP_PM_OPS(ravb_suspend, ravb_resume)
+	RUNTIME_PM_OPS(ravb_runtime_nop, ravb_runtime_nop, NULL)
 };
 
 static struct platform_driver ravb_driver = {
@@ -3074,7 +3074,7 @@ static struct platform_driver ravb_driver = {
 	.remove_new	= ravb_remove,
 	.driver = {
 		.name	= "ravb",
-		.pm	= &ravb_dev_pm_ops,
+		.pm	= pm_ptr(&ravb_dev_pm_ops),
 		.of_match_table = ravb_match_table,
 	},
 };
-- 
2.39.2


