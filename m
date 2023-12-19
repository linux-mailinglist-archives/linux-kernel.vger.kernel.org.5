Return-Path: <linux-kernel+bounces-5442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E64E818AB6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D3CE1C24090
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC8E23778;
	Tue, 19 Dec 2023 14:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g1S8dD3q"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285AA225CE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 14:59:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11A8EC433C7;
	Tue, 19 Dec 2023 14:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702997978;
	bh=bKz5Q4Qy/sBsZu1LZlfLjyOnvOVPI9R51wTQNAhVVW4=;
	h=From:To:Cc:Subject:Date:From;
	b=g1S8dD3qjeXrguxIao5wJQiC+U9ZBZspHxIH1XFhQBZHR4tgqvbonfK2xp1CMLLl0
	 VhTQmFFO8yqbIfbZk8GVPkwDr0SW1uTqiXa7nXF2vwmOWyx8TcTcT1Pj3ZnLQVXDWt
	 3h9rVXYDyrtfkj+a4TmNUP7JsyTd+uGgU/eq3NtA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: o-takashi@sakamocchi.jp
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux1394-devel@lists.sourceforge.net
Subject: [PATCH] firewire: make fw_bus_type const
Date: Tue, 19 Dec 2023 15:59:32 +0100
Message-ID: <2023121931-skydiver-dodgy-d1bd@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 40
X-Developer-Signature: v=1; a=openpgp-sha256; l=1531; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=bKz5Q4Qy/sBsZu1LZlfLjyOnvOVPI9R51wTQNAhVVW4=; b=owGbwMvMwCRo6H6F97bub03G02pJDKmN6y+/b1uw/mhkQW3rDCHjeavYjFfvijMO/MrioMnDH jeV1/RvRywLgyATg6yYIsuXbTxH91ccUvQytD0NM4eVCWQIAxenAExkqxTD/OS8eN5LYmlc4XJl TMFvy18+Lz20iWHBuQ/CFd/3bbzycpIYC7dHepuPp1suAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

Now that the driver core can properly handle constant struct bus_type,
move the fw_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: linux1394-devel@lists.sourceforge.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firewire/core-device.c | 2 +-
 include/linux/firewire.h       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index aa597cda0d88..eeda7cc59e27 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -219,7 +219,7 @@ static int fw_unit_uevent(const struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 
-struct bus_type fw_bus_type = {
+const struct bus_type fw_bus_type = {
 	.name = "firewire",
 	.match = fw_unit_match,
 	.probe = fw_unit_probe,
diff --git a/include/linux/firewire.h b/include/linux/firewire.h
index bd3fc75d4f14..dd9f2d765e68 100644
--- a/include/linux/firewire.h
+++ b/include/linux/firewire.h
@@ -75,7 +75,7 @@ void fw_csr_iterator_init(struct fw_csr_iterator *ci, const u32 *p);
 int fw_csr_iterator_next(struct fw_csr_iterator *ci, int *key, int *value);
 int fw_csr_string(const u32 *directory, int key, char *buf, size_t size);
 
-extern struct bus_type fw_bus_type;
+extern const struct bus_type fw_bus_type;
 
 struct fw_card_driver;
 struct fw_node;
-- 
2.43.0


