Return-Path: <linux-kernel+bounces-125664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2963892A4D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 11:09:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 968A81F22379
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 10:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2A64224DA;
	Sat, 30 Mar 2024 10:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJW8UhG0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44D21EEFD;
	Sat, 30 Mar 2024 10:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711793350; cv=none; b=GIbpUROEKAB+EctoU4+9cA6o9BHGTViai4Cwde+7sgo1hsr3eSPLzB3ZOvKkYfaW4fsTvHEVSCQr+b8h96fxgRgVM02YB1vfWAZQvGULgHlsXlNHe7xdKUQM/x4Bi5VsTZghxC3HHPQeYtdkdXUX143GpAQ/10F5NejXBcX/WBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711793350; c=relaxed/simple;
	bh=NYTN/T3sFt8BW831OqsqCIjX5a5sy44lv90K+k//640=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k2i/wyuM/7Zj7R10HkHucdiRkDOw3T8/12edfSm4gp8tes/V8rsEazbmrupw5r8rn2+VpCJQiG8G6T/qd0XlAu9iY8FoCCTQcciZD90DsJqCqyAL8gz35l5K3FtDAOE66kDS8eraoZuI4yKC6MQE0p2IaWI3dykJ1VfZgn9IHKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJW8UhG0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 827BBC433C7;
	Sat, 30 Mar 2024 10:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711793350;
	bh=NYTN/T3sFt8BW831OqsqCIjX5a5sy44lv90K+k//640=;
	h=From:To:Cc:Subject:Date:From;
	b=BJW8UhG0aL0oPdew8/H7f+Ndvpphpf0cOb46N16sK4ja/lTOdAznqBtZoLGRS3U+c
	 9lH7vUVDEX35hpBO6v08sJ3k2rMF/+Ld8oW5YXsDGkI5iGFjNhitCrZ2IDEy8G2DH5
	 b4esz2BC1EWMXDIhbCU29Zjw+0XZPTFFXj+TMyAqd6JbMPE4KnzQ8wZY6UOYj5wIet
	 Z10JmiyKGpjJA9IhzGQWrr0TcMAPddSudNI2ua0KoDsbrfDvFi8qcGyYHSUZCjHqb+
	 BHkp66AhFjLHn86ZQitdfNaGuK+caEc9p/abQ/hc0L0l7hzwv1yM43aoNDsD6Lakml
	 8XIxXbClrrU2g==
From: Masahiro Yamada <masahiroy@kernel.org>
To: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	linux-parisc@vger.kernel.org
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] parisc: vdso: remove dead code in vdso32/Makefile
Date: Sat, 30 Mar 2024 19:08:48 +0900
Message-Id: <20240330100849.426874-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit removes the unused build rule because 'obj-cvdso32' is
not defined.

If you add a C file into arch/parisc/kernel/vdso32/ in the future,
you can revert this change. The kernel does not keep code that
may or may not be used.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/parisc/kernel/vdso32/Makefile | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/parisc/kernel/vdso32/Makefile b/arch/parisc/kernel/vdso32/Makefile
index 4459a48d2303..e45d46bf46a2 100644
--- a/arch/parisc/kernel/vdso32/Makefile
+++ b/arch/parisc/kernel/vdso32/Makefile
@@ -26,23 +26,18 @@ $(obj)/vdso32_wrapper.o : $(obj)/vdso32.so FORCE
 
 # Force dependency (incbin is bad)
 # link rule for the .so file, .lds has to be first
-$(obj)/vdso32.so: $(src)/vdso32.lds $(obj-vdso32) $(obj-cvdso32) $(VDSO_LIBGCC) FORCE
+$(obj)/vdso32.so: $(src)/vdso32.lds $(obj-vdso32) $(VDSO_LIBGCC) FORCE
 	$(call if_changed,vdso32ld)
 
 # assembly rules for the .S files
 $(obj-vdso32): %.o: %.S FORCE
 	$(call if_changed_dep,vdso32as)
 
-$(obj-cvdso32): %.o: %.c FORCE
-	$(call if_changed_dep,vdso32cc)
-
 # actual build commands
 quiet_cmd_vdso32ld = VDSO32L $@
       cmd_vdso32ld = $(CROSS32CC) $(c_flags) -Wl,-T $(filter-out FORCE, $^) -o $@
 quiet_cmd_vdso32as = VDSO32A $@
       cmd_vdso32as = $(CROSS32CC) $(a_flags) -c -o $@ $<
-quiet_cmd_vdso32cc = VDSO32C $@
-      cmd_vdso32cc = $(CROSS32CC) $(c_flags) -c -fPIC -mno-fast-indirect-calls -o $@ $<
 
 # Generate VDSO offsets using helper script
 gen-vdsosym := $(srctree)/$(src)/gen_vdso_offsets.sh
-- 
2.40.1


