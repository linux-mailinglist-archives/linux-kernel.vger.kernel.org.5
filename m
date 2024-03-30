Return-Path: <linux-kernel+bounces-125652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81AD5892A36
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 10:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E371128358A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 09:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0085C29424;
	Sat, 30 Mar 2024 09:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VX6X73Wm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3D71EF1E;
	Sat, 30 Mar 2024 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711792677; cv=none; b=ebUj+mGUCc9TZTW+w8WOGg4rFz/jG/ZDSQV7VXxYq9CUjjipaVbpoXQ05dnwVIWSix4jfnjYPsCGoBOtl+Sup9kK9WGL/1SalaUdSnfumg1DgV7reDU3VPRMpp4roFOf6bPAPw4uAgcCUBQ3uBySB4D+X/lmap7chvHNKanlUt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711792677; c=relaxed/simple;
	bh=xijoPd3AjErmRPkXatkTO/Hnlh2T7fYc4IsuaGUg97Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XMmQbdIweMuiuhWfnTkBMAVcTcG/ILEURB/wQbTcmKH/FCwfm16TaWbH2tvDIFJg0teuE49uKWDhnr6tdl4awmjXxVNR074UC/BQmBeV+8/7nnbYvD3bUA2gmyaCu1CLLXySJYE0TV6KQBah34AEercggKV1a27I+XmXK01Yy8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VX6X73Wm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ECB63C43394;
	Sat, 30 Mar 2024 09:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711792677;
	bh=xijoPd3AjErmRPkXatkTO/Hnlh2T7fYc4IsuaGUg97Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=VX6X73WmM/T3D19mA1XNhd0bzQBGg5LEGq3J1S774zbSWnjIRrI2WYdgxxs1qpTzv
	 6vDXDmzry6xE3YdMnku8kxykz3ZyilCpQxR4Xx376TSEFtn5la02YsCfvKCGGVvaIA
	 OZmbZGBMdxtWu3agFHdGG1QkD7kNemEzSkDLmJXKauI0A/BKCTgdL6POHeFTP+TEKh
	 5j6E8nooQVom3lJjbO4bREKv/va3oqOLgKyZ2v/iJOSbqVO9eRNVXf8jeiQ2ARlFOG
	 U1ip3sVQjnEkPckT7q0Jlele40Qqgu42m5F235ZY/sgb/tbbeILr6XcM0oWl6T698g
	 wy9AliYhNjHIw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DE3CD1288;
	Sat, 30 Mar 2024 09:57:56 +0000 (UTC)
From: Sam Ravnborg via B4 Relay <devnull+sam.ravnborg.org@kernel.org>
Date: Sat, 30 Mar 2024 10:57:38 +0100
Subject: [PATCH 02/10] sparc64: Fix prototype warnings in traps_64.c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240330-sparc64-warnings-v1-2-37201023ee2f@ravnborg.org>
References: <20240330-sparc64-warnings-v1-0-37201023ee2f@ravnborg.org>
In-Reply-To: <20240330-sparc64-warnings-v1-0-37201023ee2f@ravnborg.org>
To: Andreas Larsson <andreas@gaisler.com>, 
 "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Cc: Nick Bowler <nbowler@draconx.ca>, linux-kernel@vger.kernel.org, 
 Arnd Bergmann <arnd@arndb.de>, Sam Ravnborg <sam@ravnborg.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711792675; l=2153;
 i=sam@ravnborg.org; s=20230107; h=from:subject:message-id;
 bh=x35RxU+Vu3bnerMBWt77mDb+LYsbUbJuDZXBkLmdqBE=;
 b=sJOxVCwvgkeOscu8VipEE3bBj95LtQd0tKjvKMM3RSrFFjm6lQa4M09UYF9bg4ZRp+h4+v/1sLSl
 XuOHO41RB5PDevDu/UuWE4KoSaaO+G/8s6ha2E+Sj/4ogWGYVRbQ
X-Developer-Key: i=sam@ravnborg.org; a=ed25519;
 pk=R0+pqV7BRYOAeOIGkyOrSNke7arx5y3LkEuNi37YEyU=
X-Endpoint-Received: by B4 Relay for sam@ravnborg.org/20230107 with
 auth_id=22
X-Original-From: Sam Ravnborg <sam@ravnborg.org>
Reply-To: sam@ravnborg.org

From: Sam Ravnborg <sam@ravnborg.org>

Fix the following warnings:
arch/sparc/kernel/traps_64.c:253:6: warning: no previous prototype for ‘is_no_fault_exception’
arch/sparc/kernel/traps_64.c:2035:6: warning: no previous prototype for ‘do_mcd_err’
rch/sparc/kernel/traps_64.c:2153:6: warning: no previous prototype for ‘sun4v_nonresum_error_user_handled’

In all cases make the function static as there were no users outside
traps_64.c

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: "David S. Miller" <davem@davemloft.net>
---
 arch/sparc/kernel/traps_64.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index dd048023bff5..28cb0d66ab40 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -250,7 +250,7 @@ void sun4v_insn_access_exception_tl1(struct pt_regs *regs, unsigned long addr, u
 	sun4v_insn_access_exception(regs, addr, type_ctx);
 }
 
-bool is_no_fault_exception(struct pt_regs *regs)
+static bool is_no_fault_exception(struct pt_regs *regs)
 {
 	unsigned char asi;
 	u32 insn;
@@ -2032,7 +2032,7 @@ static void sun4v_log_error(struct pt_regs *regs, struct sun4v_error_entry *ent,
 /* Handle memory corruption detected error which is vectored in
  * through resumable error trap.
  */
-void do_mcd_err(struct pt_regs *regs, struct sun4v_error_entry ent)
+static void do_mcd_err(struct pt_regs *regs, struct sun4v_error_entry ent)
 {
 	if (notify_die(DIE_TRAP, "MCD error", regs, 0, 0x34,
 		       SIGSEGV) == NOTIFY_STOP)
@@ -2150,9 +2150,9 @@ static unsigned long sun4v_get_vaddr(struct pt_regs *regs)
 /* Attempt to handle non-resumable errors generated from userspace.
  * Returns true if the signal was handled, false otherwise.
  */
-bool sun4v_nonresum_error_user_handled(struct pt_regs *regs,
-				  struct sun4v_error_entry *ent) {
-
+static bool sun4v_nonresum_error_user_handled(struct pt_regs *regs,
+					      struct sun4v_error_entry *ent)
+{
 	unsigned int attrs = ent->err_attrs;
 
 	if (attrs & SUN4V_ERR_ATTRS_MEMORY) {

-- 
2.34.1



