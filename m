Return-Path: <linux-kernel+bounces-5314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E650818954
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35960286C9D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23FA1BDE5;
	Tue, 19 Dec 2023 14:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Em1vznRo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C08F1BDD4;
	Tue, 19 Dec 2023 14:06:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A358C433C8;
	Tue, 19 Dec 2023 14:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702994784;
	bh=PJXSkoeYpe+bnJfmI13XMEa+S3LzbVn+UJHe6Z1cCwE=;
	h=From:To:Cc:Subject:Date:From;
	b=Em1vznRoZ4k7ykAlEpnzX2gaz93hRwOojzeAVtgTL1J/2szeLXm6SVVIZBsx368Nu
	 r7h30nf4YJyfACpuU+8Yz7WtmmOyzKZx4jJjVDWwL88GZRNccf4jQtqD8WzEtfLrM3
	 zYpPxi5t/eQ0H46e12lS0zMCJMs+keE0Fl1sIT3o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org
Subject: [PATCH] maple: make maple_bus_type static and const
Date: Tue, 19 Dec 2023 15:06:19 +0100
Message-ID: <2023121918-rejoicing-frostlike-d976@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 53
X-Developer-Signature: v=1; a=openpgp-sha256; l=1719; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=PJXSkoeYpe+bnJfmI13XMEa+S3LzbVn+UJHe6Z1cCwE=; b=owGbwMvMwCRo6H6F97bub03G02pJDKmNi6NkpvyqYNE5Zl3w4cfrqRd3C6TPS5T8kv/+iSS7y pPpHmp/O2JZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAiOzYyLFhUwpnoNp8rIMNH U//z259ibRMfXWGYn9nw23L5/q1bmncfzpi6ccJunQtu/AA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

There is no need to export maple_bus_type as no one uses it outside of
maple.c, so make it static, AND make it const as it can be read-only as
no one modifies it.

Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-sh@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/sh/maple/maple.c | 4 ++--
 include/linux/maple.h    | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
index e05473c5c267..16018009a5a6 100644
--- a/drivers/sh/maple/maple.c
+++ b/drivers/sh/maple/maple.c
@@ -59,6 +59,7 @@ struct maple_device_specify {
 static bool checked[MAPLE_PORTS];
 static bool empty[MAPLE_PORTS];
 static struct maple_device *baseunits[MAPLE_PORTS];
+static const struct bus_type maple_bus_type;
 
 /**
  * maple_driver_register - register a maple driver
@@ -773,11 +774,10 @@ static struct maple_driver maple_unsupported_device = {
 /*
  * maple_bus_type - core maple bus structure
  */
-struct bus_type maple_bus_type = {
+static const struct bus_type maple_bus_type = {
 	.name = "maple",
 	.match = maple_match_bus_driver,
 };
-EXPORT_SYMBOL_GPL(maple_bus_type);
 
 static struct device maple_bus = {
 	.init_name = "maple",
diff --git a/include/linux/maple.h b/include/linux/maple.h
index 9b140272ee16..9aae44efcfd4 100644
--- a/include/linux/maple.h
+++ b/include/linux/maple.h
@@ -5,7 +5,6 @@
 #include <mach/maple.h>
 
 struct device;
-extern struct bus_type maple_bus_type;
 
 /* Maple Bus command and response codes */
 enum maple_code {
-- 
2.43.0


