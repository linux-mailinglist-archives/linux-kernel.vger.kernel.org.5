Return-Path: <linux-kernel+bounces-50061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2492A8473D5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAD9E1F293F0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4AD1482FB;
	Fri,  2 Feb 2024 15:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NpuPqRlk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE5C1482E3;
	Fri,  2 Feb 2024 15:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706889513; cv=none; b=AxcEewD3rokcQkAwVQfzhPogE7TbmhgEWMMfHISJ5EntoiMu3342eBcoQRt4sn5Ba02jsR1feh71ORLF8jqAmefDh7Gx51+34cvBHFMmH+ACgyRBr+nYkP5DxCvmiT3HYxWmAs3/u34du6SNkIUJCXqrPA2blqMYcf62XuoV7Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706889513; c=relaxed/simple;
	bh=iLMWYG9L/UfAHJBH+yDa8fL9Z1alCW8nTVuRLWkFGEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WjYCTjxD1AeVcetxnhD7toIsUiLAcLmmeA7s9i395WgDyQhLIo6vvGiul90mhljtXLLv8/A+dxovVkGsHkgTk2iofpNJqE6M+Ds31qcxyu/znJvLLkvw9PtxAmpJ0GK0YQhR7KyemTmwazfWKxk9wLINPSQs+sZOE3imf3hrLaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NpuPqRlk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 061D0C433C7;
	Fri,  2 Feb 2024 15:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706889512;
	bh=iLMWYG9L/UfAHJBH+yDa8fL9Z1alCW8nTVuRLWkFGEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NpuPqRlkvGyBwYgYUT16rib5rySaETzs/nqVuIY5CKa0/laJ4lhuboWHFRZt9MFy5
	 dCj9jM44SzStc7QpKiMe1vsKJOn/fc6S7Rs6V2BuVOxJH0M6KroAPtk/5ZZlhCQuEe
	 nzwmDRMCvvdFcp8NbwV2qQyep08nevb+637wq2lH6LsBgA/lXgdSwozcjLVUWJPf3d
	 qa4ABjM8q4MswOH+92fwi/aqmgatahYy2VEE3tHNvYC5xk0feDEAdcbw0WlQ3HeWOM
	 ZXv/ZhGaVwVoSZDSIx+WXX+h0AsiXh2OdCIJTmSRP7cyd07LMQKiVQDLKv0Y5Q9BRS
	 0Lfj81ou4IaoQ==
From: Masahiro Yamada <masahiroy@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 02/27] kconfig: fix off-by-one in zconf_error()
Date: Sat,  3 Feb 2024 00:58:00 +0900
Message-Id: <20240202155825.314567-3-masahiroy@kernel.org>
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

yyerror() reports the line number of the next line.

This +1 adjustment was introduced more than 20 years ago [1]. At that
time, the line number was decremented then incremented back and forth.

The line number management was refactored in a more maintainable way.
Such compensation is no longer needed.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/?id=d4f8a4530eb07a1385fd17b0e62a7dce97486f49

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/kconfig/parser.y | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/kconfig/parser.y b/scripts/kconfig/parser.y
index 2af7ce4e1531..5ab2e3f7ca33 100644
--- a/scripts/kconfig/parser.y
+++ b/scripts/kconfig/parser.y
@@ -557,7 +557,7 @@ static void zconf_error(const char *err, ...)
 
 static void yyerror(const char *err)
 {
-	fprintf(stderr, "%s:%d: %s\n", zconf_curname(), zconf_lineno() + 1, err);
+	fprintf(stderr, "%s:%d: %s\n", zconf_curname(), zconf_lineno(), err);
 }
 
 static void print_quoted_string(FILE *out, const char *str)
-- 
2.40.1


