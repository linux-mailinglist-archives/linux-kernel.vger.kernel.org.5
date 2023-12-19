Return-Path: <linux-kernel+bounces-5811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3B8818FC7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 183871C21222
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE3C37D2F;
	Tue, 19 Dec 2023 18:28:46 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8515637D1A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 18:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFepS-0003v1-II; Tue, 19 Dec 2023 19:28:30 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFepH-0004q5-9I; Tue, 19 Dec 2023 19:28:20 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rFepI-000ERh-2q; Tue, 19 Dec 2023 19:28:20 +0100
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Boyd <sboyd@kernel.org>,
	Petr Mladek <pmladek@suse.com>,
	Kees Cook <keescook@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Marco Elver <elver@google.com>,
	linux-kernel@vger.kernel.org,
	kernel@pengutronix.de
Subject: [PATCH] lib: Add note about process exit message for DEBUG_STACK_USAGE
Date: Tue, 19 Dec 2023 19:28:09 +0100
Message-ID: <20231219182808.210284-2-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=950; i=u.kleine-koenig@pengutronix.de; h=from:subject; bh=fe37acVhtHyJr122fBh9gFX3aE010DiPd5McETtsGXY=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBlgeC5ie0fCEOBIJZkzOvTO7zoN+GaSJcgV6cHQ CCpjOwQZJmJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZYHguQAKCRCPgPtYfRL+ TnJ+B/0Vknig4k6cd3X+bWQGTkAyGVmOwlQuS3Td0MRMREYoLNm23IcNByDktH87YHHKEHqaR8M gFKHYAq05N1oojCgmp8peO45HdLPFnzNpQRvyihyWwyL3B07sS/WAx0I+fkTQA48n5XhFfpop7K D6credUBv1Y8Txfs9MwbsBs+1vqqOVHN7EtqlS52sE9/0f7YyFJ3n+0cdFgS1iXVsiO6H/9K5/V 9dS5sYHWbpEBLA55OtNvrGHkb0+k86zAcYLmP4nnNQNoVWD8IONDgIa+PizwW7braSi7LJVzxhY K6fkUx13opSekTSixCQOe0sPuVHmBL5uuRhgRBRyq4rA5ItP
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

DEBUG_STACK_USAGE doesn't only have an influence on the output of
sysrq-T and sysrq-P, it also enables a message at process exit. See
check_stack_usage() in kernel/exit.c where this is implemented.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 lib/Kconfig.debug | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1642a6d58be4..97ce28f4d154 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -763,6 +763,8 @@ config DEBUG_STACK_USAGE
 	help
 	  Enables the display of the minimum amount of free stack which each
 	  task has ever had available in the sysrq-T and sysrq-P debug output.
+	  Also emits a message to dmesg when a process exits if that process
+	  used more stack space than previously exiting processes.
 
 	  This option will slow down process creation somewhat.
 

base-commit: aa4db8324c4d0e67aa4670356df4e9fae14b4d37
-- 
2.42.0


