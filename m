Return-Path: <linux-kernel+bounces-17765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE74782523A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3CF41C23038
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC492C69A;
	Fri,  5 Jan 2024 10:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mwgglcc5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABA22C684;
	Fri,  5 Jan 2024 10:38:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E2BC433C8;
	Fri,  5 Jan 2024 10:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704451092;
	bh=OeNLZYazvQWjMT8s39DgCPZmR0L9HSAfterjuD13S8A=;
	h=From:To:Cc:Subject:Date:From;
	b=Mwgglcc5wKWFQ1eLDBVMmLd6wLzpRqri9fKcqrcQIFzQ99GCfxQdzm5+/KrSFheQs
	 SZwv/gHc0pT6ZPDY1VhxiYV1CYRrsk9jC8O50dPB3ftQizNad+YqJ83ps+SSUNxHiH
	 aR5mEBLVInEg6bX+TjOa9BWqgvTMPBKt/VY3BDpE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	greybus-dev@lists.linaro.org,
	linux-staging@lists.linux.dev
Subject: [PATCH] staging: greybus: gbphy: make gbphy_bus_type const
Date: Fri,  5 Jan 2024 11:38:08 +0100
Message-ID: <2024010508-fossil-glove-c2c6@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 28
X-Developer-Signature: v=1; a=openpgp-sha256; l=1020; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=OeNLZYazvQWjMT8s39DgCPZmR0L9HSAfterjuD13S8A=; b=owGbwMvMwCRo6H6F97bub03G02pJDKnT7wgcmqS52b/j0LyFz2cesDrT7xIfumih1xllJYGp2 yborT5i3BHLwiDIxCArpsjyZRvP0f0VhxS9DG1Pw8xhZQIZwsDFKQATWc7NsGB74BMPFqPUr2Yb ngrsnDzvZOQc01aGOdyvIi+LXn7Ndfeot4XSFJMnV4ycGAE=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

Now that the driver core can properly handle constant struct bus_type,
move the gbphy_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Johan Hovold <johan@kernel.org>
Cc: Alex Elder <elder@kernel.org>
Cc: greybus-dev@lists.linaro.org
Cc: linux-staging@lists.linux.dev
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/greybus/gbphy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/greybus/gbphy.c b/drivers/staging/greybus/gbphy.c
index 6a7d8cf2a1eb..1c41b008ba39 100644
--- a/drivers/staging/greybus/gbphy.c
+++ b/drivers/staging/greybus/gbphy.c
@@ -182,7 +182,7 @@ static void gbphy_dev_remove(struct device *dev)
 	pm_runtime_dont_use_autosuspend(dev);
 }
 
-static struct bus_type gbphy_bus_type = {
+static const struct bus_type gbphy_bus_type = {
 	.name =		"gbphy",
 	.match =	gbphy_dev_match,
 	.probe =	gbphy_dev_probe,
-- 
2.43.0


