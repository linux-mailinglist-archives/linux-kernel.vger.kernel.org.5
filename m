Return-Path: <linux-kernel+bounces-11533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8185681E7C4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 14:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35361C21051
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 13:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7864F887;
	Tue, 26 Dec 2023 13:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FF9W5eoD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3D94F611;
	Tue, 26 Dec 2023 13:53:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C482AC433CA;
	Tue, 26 Dec 2023 13:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703598782;
	bh=Yf/hVKai4B6D9hPEEtKdrrl+YI82sgCF8wTLgHt9pu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FF9W5eoD+RTmcaGMUHt0CAUOkEsYUbbmUx8w7n/lVKh6ddtIVeEZt0obusP1CTZek
	 sJ3Q+wFhHbA/vVxU5DpdNwn7kS3CN0BD94l2va+qgGhvkCoKTOAcLXvehz+zjmQWEF
	 fHdS1zN+1RPHY9osh/y3yOb+xVH7lZnRJIRbUt3hsnRf6iDVtXmA6Jp8kwb1SaXERm
	 HRZfJWhyZ4tm8uzLlXLsKYC6TQME0c562eviHKIAqmkfaLVlMtCiH1RzB1b6XWysgh
	 dT5ukV8lBxq5mS6khHHxYIyKbXhDmcGL4OSu7LDIJCIvSEYMOp/iG/q9p5Q7Vhsk80
	 eJ8lgoieLWw+Q==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Ben Hutchings <ben@decadent.org.uk>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] kbuild: deb-pkg: allow to run debian/rules from output directory
Date: Tue, 26 Dec 2023 22:52:41 +0900
Message-Id: <20231226135243.1393780-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231226135243.1393780-1-masahiroy@kernel.org>
References: <20231226135243.1393780-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'make O=... deb-pkg' creates the debian directory in the output
directory. However, currently it is impossible to run debian/rules
created in the separate output directory.

This commit delays the $(srctree) expansion by escaping '$' and by
quating the entire command, making it possible to run debian/rules in
the output directory.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/package/debian/rules | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/package/debian/rules b/scripts/package/debian/rules
index 8f24a8e84bf2..6b2333e3cf96 100755
--- a/scripts/package/debian/rules
+++ b/scripts/package/debian/rules
@@ -19,7 +19,7 @@ binary: binary-arch binary-indep
 binary-indep: build-indep
 binary-arch: build-arch
 	$(MAKE) -f $(srctree)/Makefile $(make-opts) \
-	run-command KBUILD_RUN_COMMAND=+$(srctree)/scripts/package/builddeb
+	run-command KBUILD_RUN_COMMAND='+$${srctree}/scripts/package/builddeb'
 
 .PHONY: build build-indep build-arch
 build: build-arch build-indep
-- 
2.40.1


