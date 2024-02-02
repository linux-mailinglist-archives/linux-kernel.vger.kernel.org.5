Return-Path: <linux-kernel+bounces-50065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1471A8473E0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 17:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3E71286339
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D234148FFB;
	Fri,  2 Feb 2024 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OzARufdB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CADE1482E3;
	Fri,  2 Feb 2024 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889516; cv=none; b=mxygVc23mrNxy1blwmc/4JYwFRPLR6YWdbcKufGd/Xp2hVZdpwRG6JMoHsRfaHRwKtChGq+OpRLls8k3E/U40FZI0r3a/ZS5xSY7fgMqyntu3DS3sGLtAMUBlSvxWDr78n2kzODhoyUUkJBfR43bXjheEH/grb9C3NuPoruMPUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889516; c=relaxed/simple;
	bh=QxttmJ6wH6mvkJitGwDubEDFOUUd2Xr4fYtG01w5re4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WONbj9olxerMc9dvNFdNkDvnv5vqbsbp1+zQ5gVOl4b88YUOUSIhdQfiHCmWsdAsVOiw1/dSbFjoCoU7vE3clarlJNKfDnO5r3nFtqdZYwVyQtI68YgzUka8lDf7DSYvfdpmmqZausQseG3FEWdnYrSVTunzey2OazMw5y5ql2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OzARufdB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC86C43394;
	Fri,  2 Feb 2024 15:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706889516;
	bh=QxttmJ6wH6mvkJitGwDubEDFOUUd2Xr4fYtG01w5re4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OzARufdBT5hsokUprAZCTDzxdWpGu+Zgr8rkMV6VpJTEoyd7K0Zj0EDWoTyH/8ksw
	 NWxctv98n7HaGkAbYF3bVksUklaPM/Pj9n3MZsApGSnB300SB10Y+nGQFuv8DssnFB
	 XIrA72wAAr/x0BZokXdPHoas20PqgAbG4SUBDbC9UdApGxyDW49W86hhotLQ9hFE25
	 0pPy1VpIoGOVORHKWrL2si/hI/MsHWQo69+lKaY283REIWZptn97kKBRYJQasiSbRi
	 Dis1SEEwDJ4eabvi9qyTEh4N1/DeIyxc1hqes+Ddm63hGEgJGuUzI8cKX1xejrVm7a
	 Y27KPWi15K/Qw==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 05/27] kconfig: remove unneeded sym_find() call in conf_parse()
Date: Sat,  3 Feb 2024 00:58:03 +0900
Message-Id: <20240202155825.314567-6-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240202155825.314567-1-masahiroy@kernel.org>
References: <20240202155825.314567-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sym_find("n") is equivalent to &symbol_no.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/parser.y | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kconfig/parser.y b/scripts/kconfig/parser.y
index 5ab2e3f7ca33..625224973c51 100644
--- a/scripts/kconfig/parser.y
+++ b/scripts/kconfig/parser.y
@@ -494,7 +494,7 @@ void conf_parse(const char *name)
 	if (yynerrs)
 		exit(1);
 	if (!modules_sym)
-		modules_sym = sym_find( "n" );
+		modules_sym = &symbol_no;
 
 	if (!menu_has_prompt(&rootmenu)) {
 		current_entry = &rootmenu;
-- 
2.40.1


