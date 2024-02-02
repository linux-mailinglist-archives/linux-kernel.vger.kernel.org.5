Return-Path: <linux-kernel+bounces-49823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7BD84700F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 13:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE8DC1F23789
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5A11419A2;
	Fri,  2 Feb 2024 12:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XS91VSIV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550BC140764;
	Fri,  2 Feb 2024 12:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706876302; cv=none; b=GEWkAn/ijUwfmfQeKl3ZP01nUIq7U96qToITqv+PiiAnHd0DiOXB2hXB9BglQ1HXorkayKVtYG12sfr/9InVjSE/6xvF4c4X8F+2lTGxjqMUOKRyKitId3V+zdUznUqxeqUhBfHuHPfJV6ohAQ9nbV4YK6FBVdT6n7XqHkUTkFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706876302; c=relaxed/simple;
	bh=76bLnTFW8hOss6IF1pWTx33Eugtw/u1ls0YA9hmCWJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RaBj+9p5EhKXqYkWGDnfEaYTD/2+l3/BYtI1FZifJdXaJj1J1YYcKibATilsSWg/VHcr9xWsp0Kz7ltXxfMZTFVMSUbrdj5Yo9hEu5ecYHJlM/hkWqLfF4532Mw3XbpF9/ki9+bt98rXyOerQQ7RXtx4f5Ty+wg7D5PgLQ+NQKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XS91VSIV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3AF3C433B1;
	Fri,  2 Feb 2024 12:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706876302;
	bh=76bLnTFW8hOss6IF1pWTx33Eugtw/u1ls0YA9hmCWJA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=XS91VSIVxeAq9Ho4N5W/CiepsN+55y/voO+51FzBqNFFbP9eddOWk7W6ktq2lZ+5+
	 Pp0SCqzYLiPKNdI7j8wf4UTAgc+S/J77Bf0hDS8RQUZIKOiGV42lZ/TSG/z3izPhiw
	 uadBuCu+CYz0jxWTcNNaLyHahwT4fQIIZoa13E89CF0alxGxlDm9OnM8UNq7f9Rjek
	 h9ijT1J7Plz98HwyqNFlcPgrk0NsBdGoyW7P+0lQVSU9Xd6UN/QjgprS0ogBFwSiIF
	 B27mAYOf3/XH8EuxXnITW/F37jIQXjp2wa0gl7QQYfVGUG1/J2+hazmBU/m34qfYQr
	 SilZ8SUdPBhVQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61A8C47DB3;
	Fri,  2 Feb 2024 12:18:21 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Fri, 02 Feb 2024 13:18:17 +0100
Subject: [PATCH 2/2] of: dynamic: flush devlinks workqueue before
 destroying the changeset
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240202-fix-device-links-overlays-v1-2-f9fd1404c8e2@analog.com>
References: <20240202-fix-device-links-overlays-v1-0-f9fd1404c8e2@analog.com>
In-Reply-To: <20240202-fix-device-links-overlays-v1-0-f9fd1404c8e2@analog.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Frank Rowand <frowand.list@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Daniel Scally <djrscally@gmail.com>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706876300; l=1506;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=YDuksPxVzpgUXsXtMiptrKAHNtqa9E4wT61h67KKExU=;
 b=ZZzDh6w2p09vAdpaA/tKnsT3Ui0/BIBnmAmI6LdOVcWud7O6pG7mMOAa9At/XeR3mGQi7zAsu
 0e7xJAbQW2cCDWx1T2sT1C8IFd2yKgLf/WrOHH3wwaavzpt33PL6veD
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received:
 by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>

From: Nuno Sa <nuno.sa@analog.com>

Device links will drop their supplier + consumer refcounts
asynchronously. That means that the refcount of the of_node attached to
these devices will also be dropped asynchronously and so we cannot
guarantee the DT overlay assumption that the of_node refcount must be 1 in
__of_changeset_entry_destroy().

Given the above, call the new fwnode_links_flush_queue() helper to flush
the devlink workqueue so we can be sure that all links are dropped before
doing the proper checks.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/of/dynamic.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
index 3bf27052832f..b7153c72c9c9 100644
--- a/drivers/of/dynamic.c
+++ b/drivers/of/dynamic.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/string.h>
 #include <linux/proc_fs.h>
+#include <linux/fwnode.h>
 
 #include "of_private.h"
 
@@ -518,6 +519,13 @@ EXPORT_SYMBOL(of_changeset_create_node);
 
 static void __of_changeset_entry_destroy(struct of_changeset_entry *ce)
 {
+	/*
+	 * device links drop their device references (and hence their of_node
+	 * references) asynchronously on a dedicated workqueue. Hence we need
+	 * to flush it to make sure everything is done before doing the below
+	 * checks.
+	 */
+	fwnode_links_flush_queue();
 	if (ce->action == OF_RECONFIG_ATTACH_NODE &&
 	    of_node_check_flag(ce->np, OF_OVERLAY)) {
 		if (kref_read(&ce->np->kobj.kref) > 1) {

-- 
2.43.0


