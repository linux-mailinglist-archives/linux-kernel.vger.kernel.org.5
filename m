Return-Path: <linux-kernel+bounces-161069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E70A8B46B1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 16:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2CC2281BB0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 14:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA07BA5E;
	Sat, 27 Apr 2024 14:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f3L+sKIf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB07063B9;
	Sat, 27 Apr 2024 14:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714229711; cv=none; b=bOmW9Y4EQrW48sHvm/jqP76LeFh2/z2qpEwxPfnoUkEBGWY7NbcPFH0eUylWjCjSZBfZt26ARiOgIUtFoGbWSNEVCOZ48GSUQ75QtFCz4ue3DrTSsdRuwcS/5zvKiIhfWQ2c0oCxtwvuSbQhsNUDDET/0YmuozzHs6UbqoX4sG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714229711; c=relaxed/simple;
	bh=GY5y1LwEXug5OjsvS3sjYPBnC0ItFxQPdIM67CZ1NL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kudqfa6m+yC5aG9VwpqYaSrKEgIKOUySzQTrwnrDFX+FOTXKqWFlE2pwVTGxXQTxRzw9oZEb9qCHK8BARlmKPu0mfquoHQ9G6xgZGHGLD2XsHoLPlJqUvsdoL8Frl+jqp2wm+2fs8LZTp1RtM9/8aVCQalD6Manu9XfP4O+PQgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f3L+sKIf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337AAC2BD11;
	Sat, 27 Apr 2024 14:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714229711;
	bh=GY5y1LwEXug5OjsvS3sjYPBnC0ItFxQPdIM67CZ1NL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f3L+sKIfX885hrWFH+zy+OLPdyhzTCXNMXZQa2HW2xKVhZhyAuODZaSKWEiM9hRe6
	 +6Se/U+Q3FiKIiIi41F9eAxan9HaPQXalbKCGG31hSDGeml8yEN6N9XfIFnEDgMuLi
	 UWsj4XtCQcFPf1Vksu+/Vik2t/wHSoBgNV6Q+LY9MxvmIzG7mQIth3vrR/whjlcZcU
	 lPy3vqmDkFW3xzL2M4Wfn3lrA7DmzgEUEuhBYXUuwYDwsz5qdaLeow3tnuaThi3SpL
	 bM3ULpCNPV03vXiaF6So5f0oIeLbJZDlJqVnac82kahogh1Vhtv4kLg4YS8hLE2lZs
	 yNFNZKzbxZqKg==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2 2/4] kbuild: do not add $(srctree) or $(objtree) to header search paths
Date: Sat, 27 Apr 2024 23:55:00 +0900
Message-Id: <20240427145502.2804311-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240427145502.2804311-1-masahiroy@kernel.org>
References: <20240427145502.2804311-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scripts/Makefile.lib is included not only from scripts/Makefile.build
but also from scripts/Makefile.{vmlinux,modfinal} for building generated
C files.

In scripts/Makefile.{vmlinux,modfinal}, $(obj) and $(src) are empty.

Therefore, the header include paths:

    -I $(srctree)/$(src) -I $(objtree)/$(obj)

.. become meaningless code:

    -I $(srctree)/ -I $(objtree)/

Add these paths only when 'obj' and 'src' are defined.

Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202404170634.BlqTaYA0-lkp@intel.com/
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
 - New patch to address the build error reported by 0day bot

 scripts/Makefile.lib | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index d1d51e38b55d..e67f066c0cea 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -213,9 +213,9 @@ endif
 # $(objtree)/$(obj) for including generated headers from checkin source files
 ifeq ($(KBUILD_EXTMOD),)
 ifdef building_out_of_srctree
-_c_flags   += -I $(srctree)/$(src) -I $(objtree)/$(obj)
-_a_flags   += -I $(srctree)/$(src) -I $(objtree)/$(obj)
-_cpp_flags += -I $(srctree)/$(src) -I $(objtree)/$(obj)
+_c_flags   += $(addprefix -I $(srctree)/,$(src)) $(addprefix -I $(objtree)/,$(obj))
+_a_flags   += $(addprefix -I $(srctree)/,$(src)) $(addprefix -I $(objtree)/,$(obj))
+_cpp_flags += $(addprefix -I $(srctree)/,$(src)) $(addprefix -I $(objtree)/,$(obj))
 endif
 endif
 
-- 
2.40.1


