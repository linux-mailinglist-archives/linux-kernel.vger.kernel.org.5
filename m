Return-Path: <linux-kernel+bounces-131707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E07A0898AEF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BA821C20B8E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E99C12FB09;
	Thu,  4 Apr 2024 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cPWZ1G4Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B4F12E1C7;
	Thu,  4 Apr 2024 15:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243872; cv=none; b=dwS2zdA2StQMunTujZvvaWgKtW0FzWqiSmVEGjCq3YWDqScZQFGMYL7kIIyY+4W/5i/Ior+fDXp1E33Y9H5JDE59+4OaLRn/e6xAf5V1KOC8E4Qsf0PJ3qe2RogemIw5EiDr99Vq869gIpb5BXhQFZHG33bh+QEYejsvltacihY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243872; c=relaxed/simple;
	bh=oKle+crpUH9O0OZWLH+Ub8gSc881pJVWxmfhgsu2NjE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gVbcKZvrm+rmiC9GkarLLpEAAzoaajiTUG1lMC6nBfeGyiLZuWLdf6iKopOkWRAbrL5AemCFgJaGW8/0WI1PkoDcwmX+o53e1t5lIOW6noufoetbOsQ+sR3gGZtXrEXBB6crg5NST79nyEd5cBEXpca48LXAh00SlOyYw439dWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cPWZ1G4Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2785FC433F1;
	Thu,  4 Apr 2024 15:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712243872;
	bh=oKle+crpUH9O0OZWLH+Ub8gSc881pJVWxmfhgsu2NjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cPWZ1G4ZXitGB2sYVLYOPxTDlMrOSYqJbDKZ+FcZt3U/8NYeW4Kz6OFKQASRO8p2Y
	 UF3NbopfNGf7QXF1952iELj4MmR/zo7Vn7aZKjgPvgxxIlTp+qmAK+0y7Ohvdtg/uq
	 B+5IYydfR1NDYJEcJyaLUGJ0q4nx4vsQ2zH35PmThB+Shnbh8InW+9fCZmIqthVLN3
	 wAwHD0g4jWhrUSdx7k0PJ74NFvqIo7vnX33OWmWwWiWs8l/SoMeu03SzAX6hGToDDh
	 9leooX1kxgSXVD0PoFcHjLH5nZigg1d+A8/klXQ25bj4IeZ9n8PP5CAGcDGnrFXpEb
	 urIaUsTU1ybSw==
From: Arnd Bergmann <arnd@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kbuild@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Jani Nikula <jani.nikula@intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] kbuild: turn on -Wrestrict by default
Date: Thu,  4 Apr 2024 17:16:56 +0200
Message-Id: <20240404151713.3493098-4-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240404151713.3493098-1-arnd@kernel.org>
References: <20240404151713.3493098-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

All known -Wrestrict warnings are addressed now, so don't disable the warning
any more.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 scripts/Makefile.extrawarn | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index 17b00d85f6aa..fbe4d7144860 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -97,7 +97,6 @@ else
 # Suppress them by using -Wno... except for W=1.
 KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
 KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
-KBUILD_CFLAGS += $(call cc-disable-warning, restrict)
 KBUILD_CFLAGS += $(call cc-disable-warning, packed-not-aligned)
 KBUILD_CFLAGS += $(call cc-disable-warning, format-overflow)
 KBUILD_CFLAGS += $(call cc-disable-warning, format-truncation)
-- 
2.39.2


