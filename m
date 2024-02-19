Return-Path: <linux-kernel+bounces-71965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F21EE85AD24
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFD9A281A91
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D10535D1;
	Mon, 19 Feb 2024 20:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="sWS1Ua1F"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3399E51037
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 20:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708374445; cv=none; b=KuxqjgI+jIuS09C5zuumMfrWHjRDCS8ji31rXzhK9avAmf1HeKfPtbX5/h9Gf7Ad3pU5FpjMXom7baji3Ci+l9HUo9Aw81rup50Ju4q1HY2GdEEwlxbfqR5miRxfUl74ULGzFItvt/HdeWxlNethqzE7nKSYf07/SlmthJEezXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708374445; c=relaxed/simple;
	bh=EA5jBFUYpIY/y4RMC8tQE5p9Mv3S3wcaYM7/mxK/iFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ot5zDQLprkV9VOnno6bhNjQ6Xov6DVKvIbCqdqUWsZvqY8bezukWr4MyNXqZ1GqoNmLhyVCJQwMSa2qr2frU+8czcHWKpdhVi31Dry8IrBH5+EwqSsFY2y99ydSQQ1BlOo9cBbM/DUAiLfFUPNDVF+gYrSC1ZGzuxmz65dS3gTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=sWS1Ua1F; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1708373975;
	bh=EA5jBFUYpIY/y4RMC8tQE5p9Mv3S3wcaYM7/mxK/iFY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sWS1Ua1F1EpI89I8bH9VwCpXymaYW4QZKGvh29/bHpv2aoUukVXZ16fbpBGD1Pblr
	 53ytfLuiV1AUOVT3wFuV5Mjg8slJbqQ5u97+OGgqFSB6T/F+YDcjymRjogKjF/+kw6
	 yrm5THllBEwE72fshIHfOuFLk1FNtJO+hVvrKyrQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 19 Feb 2024 21:19:24 +0100
Subject: [PATCH v3 3/3] scripts: check-sysctl-docs: handle per-namespace
 sysctls
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240219-sysctl-check-v3-3-6940d5ff747b@weissschuh.net>
References: <20240219-sysctl-check-v3-0-6940d5ff747b@weissschuh.net>
In-Reply-To: <20240219-sysctl-check-v3-0-6940d5ff747b@weissschuh.net>
To: Luis Chamberlain <mcgrof@kernel.org>, 
 Joel Granados <j.granados@samsung.com>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708373973; l=1552;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=EA5jBFUYpIY/y4RMC8tQE5p9Mv3S3wcaYM7/mxK/iFY=;
 b=eqXM5vpp2Z6p7wWyuD0lxi8xux1yT5tWJwNIXFitZlx8OW+WZmaowTUkFYiMKUtjEWW5ew8J5
 qMQ3BLPJheaDvJTE53ulheeOYVZpBA6XGvKeHtWsyr/CnNI+RhMKuxb
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Some sysctl tables are registered for each namespace.
(Like in ipc/ipc_sysctl.c)
These need special handling to track the variable assignments.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 scripts/check-sysctl-docs | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/scripts/check-sysctl-docs b/scripts/check-sysctl-docs
index 739afd766708..20274c63e745 100755
--- a/scripts/check-sysctl-docs
+++ b/scripts/check-sysctl-docs
@@ -93,6 +93,7 @@ BEGINFILE {
     delete entries
     curtable = ""
     curentry = ""
+    delete vars
     if (debug) print "Processing file " FILENAME
 }
 
@@ -105,6 +106,7 @@ BEGINFILE {
 /^};$/ {
     curtable = ""
     curentry = ""
+    delete vars
 }
 
 curtable && /\.procname[\t ]*=[\t ]*".+"/ {
@@ -125,6 +127,24 @@ curtable && /\.procname[\t ]*=[\t ]*".+"/ {
     }
 }
 
+/kmemdup.*/ {
+    match($0, /([^ \t]+) *= *kmemdup\(([^,]+) *,/, names)
+    if (debug) print "Found variable " names[1] " for table " names[2]
+    if (names[2] in entries) {
+        vars[names[1]] = names[2]
+    }
+}
+
+/__register_sysctl_table.*/ {
+    match($0, /__register_sysctl_table\([^,]+, *"([^"]+)" *, *([^,]+)/, tables)
+    if (debug) print "Registering variable table " tables[2] " at " tables[1]
+    if (tables[1] == table && tables[2] in vars) {
+        for (entry in entries[vars[tables[2]]]) {
+            printentry(entry)
+        }
+    }
+}
+
 END {
     for (entry in documented) {
 	if (!seen[entry]) {

-- 
2.43.2


