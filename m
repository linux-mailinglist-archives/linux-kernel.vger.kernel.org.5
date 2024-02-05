Return-Path: <linux-kernel+bounces-52576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B918499D5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 766011C20997
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2F41D525;
	Mon,  5 Feb 2024 12:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeEkOPAo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEB61BDD9;
	Mon,  5 Feb 2024 12:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134974; cv=none; b=OhS4X3pp3w7TsXsPc8DVVxNNq9wSZmniK6KCFi4navZyLtKTxLTEJnD8Glqyj0YdpTUgfji4W2/70xX40rKW/lNYMODHHoHcbQ4eI5RbWdLbgBoHCNY3daundtn9NO0HpUYBV669xs2HIEKWZ4VTpKAreF4FTTrSoiC5kZyh+rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134974; c=relaxed/simple;
	bh=76bLnTFW8hOss6IF1pWTx33Eugtw/u1ls0YA9hmCWJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ca8Dkl/FhF3QKsk7zml+ZdrALFX534sntgNGbhR3zrqEjCzwDesYjMEFuBQ17CIMvAB6xl5MNic3thf+cUwE+JGVIi++6LOFc/Scua/Sy5XPvqF7mDoyOOWNua4MyXdpMiUGcEHNtq5fAZ6GnDLx17mitDNBnuRJwzNv8v4u5Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BeEkOPAo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 45979C433B1;
	Mon,  5 Feb 2024 12:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707134974;
	bh=76bLnTFW8hOss6IF1pWTx33Eugtw/u1ls0YA9hmCWJA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=BeEkOPAoDv3chM+cAnfF5sgZRJD+P+xxeL/K+BBHS5at2/1Gi2+l1bWs8aaYvPucf
	 XcoXBie0Jn+6ZWjon2DIURx5TZvYoGVQSG8d13zNY9HdU+rMJyAUDOehijidCe08s7
	 goBwyQh8IlalNMRGy8mubR47Se4m+W4BD1MEyxRrI6DG861k4xIiI0xyIZwCsHI+aC
	 kSYsjcquM/yFejppnINsiPz6ImRnpzE1JMqfdcoCZricpEO84Uuc7ePwsSH/UzpNtx
	 4Op3VGcVQO+8mpnEQ4CW0rNdz8ZZuvZOOtKxYPhSiXZSV0MpDrETq5mibcvy7wQAE7
	 s09GZ1V+VXGGg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2518FC4828D;
	Mon,  5 Feb 2024 12:09:34 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Mon, 05 Feb 2024 13:09:33 +0100
Subject: [PATCH v2 2/2] of: dynamic: flush devlinks workqueue before
 destroying the changeset
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240205-fix-device-links-overlays-v2-2-5344f8c79d57@analog.com>
References: <20240205-fix-device-links-overlays-v2-0-5344f8c79d57@analog.com>
In-Reply-To: <20240205-fix-device-links-overlays-v2-0-5344f8c79d57@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707134972; l=1506;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=YDuksPxVzpgUXsXtMiptrKAHNtqa9E4wT61h67KKExU=;
 b=+pR9xIxPkbxkT8MxATu4NfCBUJ+zzK6rP+cyMoqKYeDDvSxTJi8Gd3uvMlCO1CEC8rqyBMLCI
 WWMLTeb8A1LDHRH9Rh6EZ0RqMEszqHesQn9jA8kbQP8zEix/vgTjyD3
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


