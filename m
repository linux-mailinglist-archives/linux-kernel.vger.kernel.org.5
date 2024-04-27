Return-Path: <linux-kernel+bounces-161085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F808B46DA
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 17:33:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 035E31C20D9E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 15:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2A7C139;
	Sat, 27 Apr 2024 15:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlQZIIEh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9B2A932;
	Sat, 27 Apr 2024 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714232013; cv=none; b=e3iXABdgWUL3fQlPcSjixXKKeYDhq7Elh2dT8uk5eIFd9LjnFnjINgjRsAnWAjwXTPiWgFxV+6wIuDLCERqQC5O2xILlxetOevirCXzrmpYVSajz4JH+3I7R49JvPj+/EBmhpPG9AUQpOXu2m2reajRpnyZVFBFUVOX3HljxsYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714232013; c=relaxed/simple;
	bh=jis9A0nmEXRJtTHmqsYDqwuGGz0M6XYyghzH44yRljU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ep/atknRGBNliZy85IaE3bGJWi/MzT8CBM3tzaDuqbdymfs2rBnfPSbWCJco/dERxY8S+23a4eA618ryKIRWuMGVIcCIiVxGMxX24AiYaLC41iQHL/uCTgYw2xFZ1S1TJ9NbyMnl4pgFIHYSLBjcfGIo5TTndZMS81taUNnTCHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlQZIIEh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E12C113CE;
	Sat, 27 Apr 2024 15:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714232012;
	bh=jis9A0nmEXRJtTHmqsYDqwuGGz0M6XYyghzH44yRljU=;
	h=From:To:Cc:Subject:Date:From;
	b=FlQZIIEhoTqZOPwuWIATaW+Ti5v2owJct11qc8CguI5t9rQuNTo4piCEN71oz4qju
	 x17O5bc4S3gX2IK+QNiBgJLdchJZWKTpPB5njCbQTM6CwQEMSH6byfviE18GPSEBuO
	 xsQ1mGCMnmJbqALP+Eu7c0T+jjqXI5auTWtNd8Xihs70MrmTXk34ZfUDui768WItOm
	 c178Cwx25Qa9VSycYQH4LICKoPtBcLnUK7ktYaLPJ7omQ5H/mEqsoBbS4rToTp4w3N
	 VP6ThqorfdpevulU0wvMsPnWWqYBZXrKTEHghZXND4Gxu4Ly3GDTS414seFWxk6GBR
	 DE6pUXJtQYMnQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 1/2] kbuild: remove redundant $(wildcard ) for rm-files
Date: Sun, 28 Apr 2024 00:32:52 +0900
Message-Id: <20240427153253.2809911-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The $(wildcard ) is called in quiet_cmd_rmfiles.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index a1c19979e13e..62557fabfee5 100644
--- a/Makefile
+++ b/Makefile
@@ -1512,7 +1512,7 @@ clean: archclean vmlinuxclean resolve_btfids_clean
 
 # mrproper - Delete all generated files, including .config
 #
-mrproper: rm-files := $(wildcard $(MRPROPER_FILES))
+mrproper: rm-files := $(MRPROPER_FILES)
 mrproper-dirs      := $(addprefix _mrproper_,scripts)
 
 PHONY += $(mrproper-dirs) mrproper
-- 
2.40.1


