Return-Path: <linux-kernel+bounces-167718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8DE8BADF6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02A491F22437
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBCB8153BE4;
	Fri,  3 May 2024 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="cvx0cKi+"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8B5153BC9;
	Fri,  3 May 2024 13:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714743876; cv=none; b=WYPKFgGOOZnPqd1GT9m8T8GsjoOUCYo+bSEdiAL3fCF8V+AED9dGUcY+7DcHspP/ZCZMXweBH2AWimD7rUA2MZJbRFgmT3KQ9y25Itps0Z7KL3bMRGq+XWEJWKnaH3/QSyO9pllPfnrT1+aQIiKRmDBitfI8p2Oj/QF8GV7mkSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714743876; c=relaxed/simple;
	bh=5+w0EO0csO5S2boUJzwf6vkebCqsTwn1sGI9xWIoSyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YApFiZ8nqcbvrXmt6US9dx/NUh8FQrE56uZRPc0t3ZgJWbt/THe/dFrj9h0dlWo7idzLv0kGTI/IHio9Ry395O4ucyNZVZyZDxIIogL11FlDwY/Bqb9UsqzWxMM1xVc4jno2Qv4o+jqhn+pvaxhTmoXB73eFElRgiKqXIFUaxbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=cvx0cKi+; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1714743868;
	bh=5+w0EO0csO5S2boUJzwf6vkebCqsTwn1sGI9xWIoSyU=;
	h=From:Date:Subject:To:Cc:From;
	b=cvx0cKi+VKcX0P2kD76tfscHjmwGbHpA4KQCUWGGS7kexQOinNr+6YxZaF69PgIxS
	 +SKjMSczqersGVWZbhPVPlyRkEjADqD3qv2RFtKL9z/9x+oyiLA+/MJ0XvLUe3hiUP
	 GlovuEA0OKfel9xvFOvBPlQnp9Bt00azA7VEDUWM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 03 May 2024 15:44:09 +0200
Subject: [PATCH] stackleak: don't modify ctl_table argument
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240503-sysctl-const-stackleak-v1-1-603fecb19170@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIACjqNGYC/x3MSwqAMAwA0atI1gbqH7yKuKgxalCqNEUU8e4Wl
 28x84CyF1Zokwc8n6Kyu4gsTYAW62ZGGaMhN3lpKlOg3kphQ9qdBtRgad3YrmingutmoLoaDMT
 48DzJ9Y+7/n0/87RKS2gAAAA=
To: Kees Cook <keescook@chromium.org>, 
 Alexander Popov <alex.popov@linux.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Joel Granados <j.granados@samsung.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714743866; l=2040;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=5+w0EO0csO5S2boUJzwf6vkebCqsTwn1sGI9xWIoSyU=;
 b=fBMwaLymZDWl5ESfaeFhtKSN21HcxU3lGdUMe7amXumuUxJ8R3pU98RUVKAHdADhkqwTzqqOE
 6Q4w5KGOAnzAMGUTgSYojEJjABmbZbji4viqFCO8IPS7Tc5/H9auPlR
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Sysctl handlers are not supposed to modify the ctl_table passed to them.
Adapt the logic to work with a temporary
variable, similar to how it is done in other parts of the kernel.

This is also a prerequisite to enforce the immutability of the argument
through the callbacks prototy.

Fixes: 964c9dff0091 ("stackleak: Allow runtime disabling of kernel stack erasing")
Cc: stable@vger.kernel.org
Acked-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
This was split out of my sysctl-const-handler series [0].

As that series will take some more time, submit the patch on its own,
as it is a generic bugfix that is valuable on its own.
And I can get it out of my books.

Changelog in contrast to the patch in the series:
* Reword commit message to remove strong relation to the constification
* Cc stable

[0] https://lore.kernel.org/lkml/20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net/

Cc: Joel Granados <j.granados@samsung.com>
---
 kernel/stackleak.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/stackleak.c b/kernel/stackleak.c
index 34c9d81eea94..b292e5ca0b7d 100644
--- a/kernel/stackleak.c
+++ b/kernel/stackleak.c
@@ -27,10 +27,11 @@ static int stack_erasing_sysctl(struct ctl_table *table, int write,
 	int ret = 0;
 	int state = !static_branch_unlikely(&stack_erasing_bypass);
 	int prev_state = state;
+	struct ctl_table tmp = *table;
 
-	table->data = &state;
-	table->maxlen = sizeof(int);
-	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+	tmp.data = &state;
+	tmp.maxlen = sizeof(int);
+	ret = proc_dointvec_minmax(&tmp, write, buffer, lenp, ppos);
 	state = !!state;
 	if (ret || !write || state == prev_state)
 		return ret;

---
base-commit: f03359bca01bf4372cf2c118cd9a987a5951b1c8
change-id: 20240503-sysctl-const-stackleak-af3e67bc65b0

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


