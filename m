Return-Path: <linux-kernel+bounces-167603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE44D8BABCE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79B971F22D9A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E6A15252A;
	Fri,  3 May 2024 11:45:33 +0000 (UTC)
Received: from sxb1plsmtpa01-16.prod.sxb1.secureserver.net (sxb1plsmtpa01-16.prod.sxb1.secureserver.net [188.121.53.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59C4C2E9
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 11:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714736733; cv=none; b=j0OEHajU4YCVSMQS7i4VWBwnaGz3sodwTs0L/z2zz69GUgGd+4Llmx4UQI5QUcV4EjtYYZMCuqsbXK/Zs6FQEz/hKjo4WHBC3TJeEWZ6s5meZ8PuQShCl3SWjg3/1Yos4zySx3exC6MHKwlAeGWzcNZNlSlHBeiw2ZqtdSAUuRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714736733; c=relaxed/simple;
	bh=rJO+5Tco0kQuR3XfHDUrQjWSLzQoah3amsobRRbC3wk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Mm4XF7/DvV1lssiTem6e5u1fNxrpCsiBsoobV8jtdvF/0ymzNHC184TsyZiTCAJylmRg6rkB8aqTbaKy5A+tFJnRULq1bfV7uVg/5CbD3yLmpkskx6UmfYJ/jxNce0c1wb07REpFCJQH6ndIcG6ZgWJSHmpjvOl4mntcqubx3b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exordes.com; spf=pass smtp.mailfrom=exordes.com; arc=none smtp.client-ip=188.121.53.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exordes.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exordes.com
Received: from exordes.com ([87.92.66.153])
	by :SMTPAUTH: with ESMTPSA
	id 2rJYsBkACnpx02rJbsRacx; Fri, 03 May 2024 04:43:00 -0700
X-CMAE-Analysis: v=2.4 cv=P7HxhTAu c=1 sm=1 tr=0 ts=6634cdc5
 a=13ZijDARommhillvnyM9pA==:117 a=13ZijDARommhillvnyM9pA==:17 a=eCYXQZmkAAAA:8
 a=yasIzMgEaC0_WTIPdd8A:9 a=77AlN4CNbnqoG63BkLSu:22
X-SECURESERVER-ACCT: dai.lu@exordes.com
From: Lu Dai <dai.lu@exordes.com>
To: npiggin@gmail.com,
	christophe.leroy@csgroup.eu,
	naveen.n.rao@linux.ibm.com
Cc: Lu Dai <dai.lu@exordes.com>,
	mpe@ellerman.id.au,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	javier.carrasco.cruz@gmail.com,
	shuah@kernel.org
Subject: [PATCH] tty: hvc: hvc_opal: eliminate uses of of_node_put()
Date: Fri,  3 May 2024 14:43:30 +0300
Message-Id: <20240503114330.221764-1-dai.lu@exordes.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfGFLoAN7m+wK5DQwW5rMwK7zWeDspUOif9J3EvUOXg5V/16O/NGMl1iQkVENAVe5aTQiL7KS/A/fbUS994+hSiJW+OmWqAV/m9+WeYpNkcYrLJHA5qLC
 sHd66kpLKgdCO8eVVQIYsSFmvgWklhZ+TChh+61taxAUleY5YSRIaoKkPW7nqKKbytBsXQJXnVheHEPmBKyhNN/RglwE9qFL7DASNxF5fFOmoPEDpnXylQOs
 0WinVufDb9e2mx96aowrVT+IBwu4oaRozz4FGIW2BrR2yzxYiVs/DUpprBSJ9fBOcfidcqlVnEvAmCSyOChbKdkIRxoEsDrt7Fhr+wzHU4BKgPQxAO/YfA3I
 pmEKEdz++gJHDroru0UckXBWoGQ+HQRnjRSNsrNwsAJhR/zp+vG4+TEil+5q5EyepdfBUNurXcwQ9xrOAsHEnJpXiOY1xsmfSYZdd6/T+evrWZ4+dZ7j2RqB
 DTyp47hI6L2TwN696onBajOhZpzQZ9qJ60aeAUmTqGyZHqfXWK0lsyv+/I0LRJ2KLIVmhCDNWS2WXrdBkMRx0dEWbXeyaxmywQRcKRFidjPwdRMNHl9r7SQ8
 +V4=

Make use of the __free() cleanup handler to automatically free nodes
when they get out of scope.

Removes the need for a 'goto' as an effect.

Signed-off-by: Lu Dai <dai.lu@exordes.com>
---
 drivers/tty/hvc/hvc_opal.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/hvc/hvc_opal.c b/drivers/tty/hvc/hvc_opal.c
index 095c33ad10f8..67e90fa993a3 100644
--- a/drivers/tty/hvc/hvc_opal.c
+++ b/drivers/tty/hvc/hvc_opal.c
@@ -327,14 +327,14 @@ static void udbg_init_opal_common(void)
 
 void __init hvc_opal_init_early(void)
 {
-	struct device_node *stdout_node = of_node_get(of_stdout);
+	struct device_node *stdout_node __free(device_node) = of_node_get(of_stdout);
 	const __be32 *termno;
 	const struct hv_ops *ops;
 	u32 index;
 
 	/* If the console wasn't in /chosen, try /ibm,opal */
 	if (!stdout_node) {
-		struct device_node *opal, *np;
+		struct device_node *opal __free(device_node), *np;
 
 		/* Current OPAL takeover doesn't provide the stdout
 		 * path, so we hard wire it
@@ -356,7 +356,6 @@ void __init hvc_opal_init_early(void)
 				break;
 			}
 		}
-		of_node_put(opal);
 	}
 	if (!stdout_node)
 		return;
@@ -382,13 +381,11 @@ void __init hvc_opal_init_early(void)
 		hvsilib_establish(&hvc_opal_boot_priv.hvsi);
 		pr_devel("hvc_opal: Found HVSI console\n");
 	} else
-		goto out;
+		return;
 	hvc_opal_boot_termno = index;
 	udbg_init_opal_common();
 	add_preferred_console("hvc", index, NULL);
 	hvc_instantiate(index, index, ops);
-out:
-	of_node_put(stdout_node);
 }
 
 #ifdef CONFIG_PPC_EARLY_DEBUG_OPAL_RAW
-- 
2.39.2


