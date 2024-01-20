Return-Path: <linux-kernel+bounces-31927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0059833681
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 22:33:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48516B219CC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 21:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103C314278;
	Sat, 20 Jan 2024 21:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkKzrtQK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AA312E69
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 21:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705786424; cv=none; b=b1XMLIgI5CwVVVt0Znq96o9PNaN8ZSD8cViuDbMSchbQQvrFdYfyH4k/L/0vHmMoVRYOSstZSLxF7zSpxFZWIFLZYd99cDMJO4FlQ2Rteb82ZE9J8vR1zgo9YlJ+4GZ/ZEJfC15A7hvSGWhDY+WvMZ5d4Z5po/1pOVyNAjmFBvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705786424; c=relaxed/simple;
	bh=ggK882gPcvFDbkLHIJzDPNuG5aqZmqVFz9H9u19MILY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EgRyeYyd7SJvDcBoBo+i2EA3I9rZO+AYfuldOTApGLwhCAazJOnSDPrEiPJTzV0h46zaZfehAtkPVGk4tPK0wpinS70V64wxkRcup3o+NFr4PiVrxUShWrzn0yXlqqcIhYnKVxgV+W+t7TYBvNqTqyLHP0gkgh5ccgoPuhIovdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkKzrtQK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86040C433F1;
	Sat, 20 Jan 2024 21:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705786423;
	bh=ggK882gPcvFDbkLHIJzDPNuG5aqZmqVFz9H9u19MILY=;
	h=From:To:Cc:Subject:Date:From;
	b=XkKzrtQKGts2brCMmCZ5q/1ZCSjfXbAirPlxQTSwPxe6qmbN2steOWoMR4p9y3UdP
	 LXOjz1dpAhLP+ZCe2lGm+SCqaZw0ru3FZn3KXLeKvumzOIfX3TZGLQJbwDZNpT+aJf
	 zPvPm3w1712JBE/t+sBC8m1a5ZYNMezNVrlTGgHSpbYZ+nibs5WOgBU80WOA8cFy7i
	 0inlxtT0T3JBx90zpNz4p8nNlXKv8sI3ugocmyez//3n4b5IVmUHFntaF2MclIa2l/
	 u2g6upW94BVJO7qgT3QiSLORsIK0bDvrghj2ztyHor7ZbCECVOoKLhlbglVGLgVtqq
	 mqz8g9cusUPfw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Al Viro <viro@zeniv.linux.org.uk>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] riscv: remove unneeded #include <asm-generic/export.h>
Date: Sun, 21 Jan 2024 06:33:11 +0900
Message-Id: <20240120213312.3033528-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 62694797f56b ("use linux/export.h rather than
asm-generic/export.h") replaced deprecated <asm-generic/export.h>
inclusions.

Commit c2a658d41924 ("riscv: lib: vectorize copy_to_user/copy_from_user")
introduced a new instance of #include <asm-generic/export.h>.

arch/riscv/lib/uaccess_vector.S does not use EXPORT_SYMBOL, hence this
include directive is unneeded.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

I CC'ed Al Viro in case he attempts to replace <asm-generic/export.h>
with <linux/export.h> again.

Commit 62694797f56b was suboptimal because arch/riscv/kernel/mcount-dyn.S
does not use EXPORT_SYMBOL. Removing #include <asm-generic/export.h>
was correct.

I had submitted a patchset earlier, but it was not picked up:
 https://lore.kernel.org/all/20231126151739.1557369-1-masahiroy@kernel.org/


 arch/riscv/lib/uaccess_vector.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/riscv/lib/uaccess_vector.S b/arch/riscv/lib/uaccess_vector.S
index 51ab5588e9ff..7c45f26de4f7 100644
--- a/arch/riscv/lib/uaccess_vector.S
+++ b/arch/riscv/lib/uaccess_vector.S
@@ -1,7 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 
 #include <linux/linkage.h>
-#include <asm-generic/export.h>
 #include <asm/asm.h>
 #include <asm/asm-extable.h>
 #include <asm/csr.h>
-- 
2.40.1


