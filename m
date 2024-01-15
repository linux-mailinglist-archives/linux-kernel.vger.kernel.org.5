Return-Path: <linux-kernel+bounces-26356-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D3B82DEFA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 19:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DE0B2834C9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8181E182BE;
	Mon, 15 Jan 2024 18:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="SZBZngzm"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8327B1863E;
	Mon, 15 Jan 2024 18:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705342640; x=1705947440; i=erick.archer@gmx.com;
	bh=vIOTPgNBydSqKCJCF1Y+JqsAan+pT9TC0MylL9uW2R0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=SZBZngzmcE79+RU29xAXD5HwuZCh3qMwSour3m5zDk4uewVeaKodI2gao7uoBbea
	 acofFyGAfCxq4uIhwmLxC2PBPqJGNR7NHntU6LjUEnDLtInPcixI0k33SDWs1RdZc
	 W4JdogS8GYwHjZJBZcCCM5X3gbZMh/Up/1qy3XCJRSCSpoDOthd1W+fejpJH8A46u
	 JMtZuP6DlpmvNsP/yEmFAKkKcE6h0F/V9t8dIWUPOxDwEgG+XYL1qMutBNvH75Cbn
	 zhiit5CN1u6xoWx+JtqVZy6CEI25tieLYJVAjWEmeXK+u2os7mw6VPOYyo0BYjlgs
	 ebAfHlwOYrh1CZr+mg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.157.194.183]) by mail.gmx.net
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MhlKs-1qulTT3wJc-00dk5q; Mon, 15 Jan 2024 19:17:20 +0100
From: Erick Archer <erick.archer@gmx.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Erick Archer <erick.archer@gmx.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2] eventfs: Use kcalloc() instead of kzalloc()
Date: Mon, 15 Jan 2024 19:16:58 +0100
Message-Id: <20240115181658.4562-1-erick.archer@gmx.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0g1HcZkBjgXbdwH65/z58cKfoG4eUSOlTy25Nx06xre/KJiWz4m
 SkPbpl8fGlc4UQ18ujM97F85F9hLPqeA2rmTQVOdDPLmgvPVXEW1+wNQghH23fXjERqJgn8
 5+0mZwbu/iR2h9imQ5RadyEP5N7gCOamNmJflA7sQTdjSJNCULkcOre6u+k6EUGN0ctsMvF
 NGLVPUEJAccHJyXBkloCQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VxCX+FbTuiU=;wa/Qu/GPbrz8jMjfxFIdVgsNWZl
 PxHOAK6x+m+be9+s4+J1CKTt3/gvAAtZusqrYKVLAwKKm1Tqd5wk/7jm6HAVRHQYGjrCCZp+j
 fo+CeafPcQ+uQFCbuZHJbHxuESYX9IKw/OBOY4jwarZBdSFcAH7mlpmlaCAExWqTyFhHeBpYv
 NYE9lRDSrAHDajnxZNJOaP2BiuN8YCZWjeAKxDS8H5wWLz7ueE6Z9aqnHOzXZm3pex2gpnWDh
 hD2oCNXd9WIDMrkppIbG7ut6y4u5X1dWZWXAfRxnbCDG7onwZT12SCWJvY5cw6OZ6bTsiRs5P
 Qr9p0StE0I4MtJOPvHnYsK/1XE/vvAF32pOGssQMIogxDV187555ry2EWoYHTIa8BOtTCClTe
 /aM/bUfbUUnJUBTOq1+U6lgRXW6f3Hd9ojET5h6ht7VXcpQ7/Tn6XaPPa97qy/fJ96+CUWhUU
 r3DsZISn79iXPvjLv5vHrD8T3SAcikgdN72hZN7pEfmFjxjY1JcgQiacCFcrmkJazQcoCmrcH
 JsenuGsEKgI0KZ+kbEKsOqo6prl6FW8inPOCi3QokB5WYGGuFIzug9v9GQi9l/sv5HBjJHUuf
 /BWcZsMlgOkKk1WOIlqPuoMoU2cXPraaRnoOIh8Vw4k77UdYNPaKB3TyOug6BBKYu3trhhYDE
 4p/RcrUGXC+2zSa9h2rY0Cw17ArTOUkFy/Xo2ByPIv+lQhojXLtoDFkJtJxDe6tQrpmYi5W1v
 5AMtnvkw7wTBC49m9mlX/5ox8LT0pHwIItNprhmg+IkaB/VLDtjWSF3MpPyaeLSesf3BCDCxU
 8ZhdlqjjmJBrx7JkBPRVq6mR8/5bBndmifJyNZ8l2Qy5jIwBCTPOEJ+wQSiBAxBeg13rBgBYa
 FjZ4mULJPtQrUHS5KldLCD74/9bESBW+VCLqiq0nt2HlwbRwRg/Ikj1Mi+fr4UPzDjH+yi8Gr
 7p/I7Q==

As noted in the "Deprecated Interfaces, Language Features, Attributes,
and Conventions" documentation [1], size calculations (especially
multiplication) should not be performed in memory allocator (or similar)
function arguments due to the risk of them overflowing. This could lead
to values wrapping around and a smaller allocation being made than the
caller was expecting. Using those allocations could lead to linear
overflows of heap memory and other misbehaviors.

So, use the purpose specific kcalloc() function instead of the argument
size * count in the kzalloc() function.

[1] https://www.kernel.org/doc/html/next/process/deprecated.html#open-code=
d-arithmetic-in-allocator-arguments

Link: https://github.com/KSPP/linux/issues/162
Signed-off-by: Erick Archer <erick.archer@gmx.com>
=2D--
Changes in v2:
- Update the commit message to better explain the changes (Mark Rutland)

Previous versions:
v1: https://lore.kernel.org/linux-hardening/20240114105340.5746-1-erick.ar=
cher@gmx.com/
=2D--
 fs/tracefs/event_inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index fdff53d5a1f8..f8196289692c 100644
=2D-- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -93,7 +93,7 @@ static int eventfs_set_attr(struct mnt_idmap *idmap, str=
uct dentry *dentry,
 	/* Preallocate the children mode array if necessary */
 	if (!(dentry->d_inode->i_mode & S_IFDIR)) {
 		if (!ei->entry_attrs) {
-			ei->entry_attrs =3D kzalloc(sizeof(*ei->entry_attrs) * ei->nr_entries,
+			ei->entry_attrs =3D kcalloc(ei->nr_entries, sizeof(*ei->entry_attrs),
 						  GFP_NOFS);
 			if (!ei->entry_attrs) {
 				ret =3D -ENOMEM;
@@ -874,7 +874,7 @@ struct eventfs_inode *eventfs_create_dir(const char *n=
ame, struct eventfs_inode
 	}

 	if (size) {
-		ei->d_children =3D kzalloc(sizeof(*ei->d_children) * size, GFP_KERNEL);
+		ei->d_children =3D kcalloc(size, sizeof(*ei->d_children), GFP_KERNEL);
 		if (!ei->d_children) {
 			kfree_const(ei->name);
 			kfree(ei);
@@ -941,7 +941,7 @@ struct eventfs_inode *eventfs_create_events_dir(const =
char *name, struct dentry
 		goto fail;

 	if (size) {
-		ei->d_children =3D kzalloc(sizeof(*ei->d_children) * size, GFP_KERNEL);
+		ei->d_children =3D kcalloc(size, sizeof(*ei->d_children), GFP_KERNEL);
 		if (!ei->d_children)
 			goto fail;
 	}
=2D-
2.25.1


