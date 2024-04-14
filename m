Return-Path: <linux-kernel+bounces-144095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6CA8A41BC
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 12:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A0E32819FB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 10:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DA628DBC;
	Sun, 14 Apr 2024 10:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="iFO39+bA"
Received: from msa.smtpout.orange.fr (smtp-80.smtpout.orange.fr [80.12.242.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B6423775;
	Sun, 14 Apr 2024 10:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713089434; cv=none; b=KPNr+vhKxihIdSLEQpzeR3AH/tsxnZ724XPehWScfUcZFdCCeTH0WcZm/bQNcsg5+7lTNvFAZu94AOsWU+JT1sDvc693jd1fODn/o5WA+rC57rl6kZEdPgFoWJfZtOApeBdS1sMLN7N5ZmkDYf6UIrXI0Hu/NLfc0n+j4idUM3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713089434; c=relaxed/simple;
	bh=8shkptN6BCt6VyCJqH6fotDYGKiXVOHoVHr094r3IlE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=olTyBQVmxOAwQ0KL/IeBH/dPQB7LTu2VpeiK9REZ+gYqfA0WE/hlZedF4uvO51ygHhYWGYtEAgig2AvFOLvf1yBmHTAJHIVYDa14MKbVJvKhpeaHuwB2S7Y/qqrhMIcplU9YjtRhBlqKxlCIckfs3hYV0ErrsFiZLYoXqPmMX0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=iFO39+bA; arc=none smtp.client-ip=80.12.242.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id vwoZrbF702kxovwoZrX7vy; Sun, 14 Apr 2024 12:10:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1713089424;
	bh=JwLrWQ+V5JuU/PLiTy+zRyUXX9xaPMJzcCI5wAz3CRc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=iFO39+bArTVOqkraSMJLyXXB+phwVyx3RNPYv1yXT5h1lwM0Rc15fS8FMz5/OMW39
	 3Ok5W0wmvBIZZqPoFwp1sACM+YdnTz0CGFFh2usHN3d4ITRtX1yfbtgHrRYORRCkG6
	 QVnu9g3IzRys4TpTtTB9137n85Uc3PiGLBwFmDTLEVO67PuDMxWBgOwac8Nt6cSrRa
	 mK4qHdcdR7puoMq79wpYbFbXYWuWnDUpC2uOo+NKvC2Rt9uBCxUHTM+jLmkrVAPDlm
	 Azwgj3eS27YaeCGbQNfRK8OUIbSzJr3KaE0Pdqk6s3kJEiHnNL3Cr0EiUm6ThEB2UG
	 tzWIvie1aAbwg==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 14 Apr 2024 12:10:24 +0200
X-ME-IP: 86.243.17.157
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: akpm@linux-foundation.org,
	Rodolfo Giometti <giometti@enneenne.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH RESEND] pps: Remove usage of the deprecated ida_simple_xx() API
Date: Sun, 14 Apr 2024 12:10:17 +0200
Message-ID: <9f681747d446b874952a892491387d79ffe565a9.1713089394.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

This is less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch has been sent about 3 months ago [1].
A gentle reminder has been sent 1 month later [2].

Neither one got any reply.

So, I'm adding Andrew Morton in To:, in order to help in the merge process.

Context:
=======
All patches to remove the ida_simple API have been sent.
Matthew Wilcox seems happy with the on going work. (see [3])

Based on next-20240412
$git grep ida_simple_get | wc -l
25

Based on next-20240220
$git grep ida_simple_get | wc -l
36

https://elixir.bootlin.com/linux/v6.8-rc3/A/ident/ida_simple_get
50

https://elixir.bootlin.com/linux/v6.7.4/A/ident/ida_simple_get
81

Thanks
CJ

[1]: https://lore.kernel.org/all/5065a9fe3101dcb7ee0a79bde0ec84de03c637ec.1702230047.git.christophe.jaillet@wanadoo.fr/
[2]: https://lore.kernel.org/all/9bfe4d6b-d289-40bc-b9fa-bd34c08e6e03@wanadoo.fr/
[3]: https://lore.kernel.org/all/ZaqruGVz734zjxrZ@casper.infradead.org/
---
 drivers/pps/clients/pps_parport.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pps/clients/pps_parport.c b/drivers/pps/clients/pps_parport.c
index 42f93d4c6ee3..af972cdc04b5 100644
--- a/drivers/pps/clients/pps_parport.c
+++ b/drivers/pps/clients/pps_parport.c
@@ -148,7 +148,7 @@ static void parport_attach(struct parport *port)
 		return;
 	}
 
-	index = ida_simple_get(&pps_client_index, 0, 0, GFP_KERNEL);
+	index = ida_alloc(&pps_client_index, GFP_KERNEL);
 	memset(&pps_client_cb, 0, sizeof(pps_client_cb));
 	pps_client_cb.private = device;
 	pps_client_cb.irq_func = parport_irq;
@@ -188,7 +188,7 @@ static void parport_attach(struct parport *port)
 err_unregister_dev:
 	parport_unregister_device(device->pardev);
 err_free:
-	ida_simple_remove(&pps_client_index, index);
+	ida_free(&pps_client_index, index);
 	kfree(device);
 }
 
@@ -208,7 +208,7 @@ static void parport_detach(struct parport *port)
 	pps_unregister_source(device->pps);
 	parport_release(pardev);
 	parport_unregister_device(pardev);
-	ida_simple_remove(&pps_client_index, device->index);
+	ida_free(&pps_client_index, device->index);
 	kfree(device);
 }
 
-- 
2.44.0


