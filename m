Return-Path: <linux-kernel+bounces-123027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB26890132
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC4B4292152
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C7412F38C;
	Thu, 28 Mar 2024 14:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="po1GlDL4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D24C28366;
	Thu, 28 Mar 2024 14:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634837; cv=none; b=sOUaQ5mIiK4lfslE2lFGb7DJznUTmmZak13W1g9YQBkNhMsMuZxlqarE4hltmmgiCdsbDHFhLCd/47sxHRx6/ZhglokGrEh15ptItcGKQ0vMjMR7t8sDcP82JkQCVsH8f9M11iXiG5MjIuh+iKBL4WPidZ5BcLmp2IIN104Bh5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634837; c=relaxed/simple;
	bh=HAK2CRZwQz9hSqo3RZk2zl/QdK5mJmPz2eF7SrmBSfU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BPywXUya1X1ftf+XPnG3iCHZE2QzqE3X6KYWFfTkv6xtyrjc0z57sNN3s7C4dNpbrpF5aGfepIPGIXqx7BvZqp3JYUunVy5R57oMCxXO/GgfuAn9e5bmyD28knSAdNLjOTyRbEednI3g39TwyklG2sZjxDeK6kHvcCXI+AQ4+MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=po1GlDL4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A43C43399;
	Thu, 28 Mar 2024 14:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711634836;
	bh=HAK2CRZwQz9hSqo3RZk2zl/QdK5mJmPz2eF7SrmBSfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=po1GlDL4BbHjc1L9zFfUcQEr8mgmdeH/RcK6z5TgS/NX1m8CA9rc2CF+P3Lyvmywx
	 9zHfxrISxzkmJcv81Ssn0x+Lfak+mST+xzo7kcLFC6JYIc7lJ4R0uH9+xP0kVuV7Wk
	 gnC0KMVl5J04w34840nQ+lsnHqswfuMWlJlNU7j3AJgnLOXJ+i0siWEkg62rWTh7uH
	 St6xby7eNX13n+EoqOKSUxJw/n6vXnAHie1A6DrXrN3yWHMmTaCzYeofwyRmt1FXAP
	 Ee8FZxq//C3nSls9IZVsRSb4JQHYSVahcd0fKz0Xw3F/RHpoIHA0kX4GtmIdTRhGCT
	 IC6H9IyfPGw8Q==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kernel@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	linux-kbuild@vger.kernel.org
Subject: [PATCH 11/11] kbuild: enable -Wstringop-truncation globally
Date: Thu, 28 Mar 2024 15:04:55 +0100
Message-Id: <20240328140512.4148825-12-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240328140512.4148825-1-arnd@kernel.org>
References: <20240328140512.4148825-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The remaining warnings of this type have been addressed, so it can
now be enabled by default, rather than only for W=1.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 scripts/Makefile.extrawarn | 1 -
 1 file changed, 1 deletion(-)

diff --git a/scripts/Makefile.extrawarn b/scripts/Makefile.extrawarn
index aa1c716c4812..5a25f133d0e9 100644
--- a/scripts/Makefile.extrawarn
+++ b/scripts/Makefile.extrawarn
@@ -102,7 +102,6 @@ KBUILD_CFLAGS += $(call cc-disable-warning, format-overflow)
 ifdef CONFIG_CC_IS_GCC
 KBUILD_CFLAGS += $(call cc-disable-warning, format-truncation)
 endif
-KBUILD_CFLAGS += $(call cc-disable-warning, stringop-truncation)
 
 KBUILD_CFLAGS += -Wno-override-init # alias for -Wno-initializer-overrides in clang
 
-- 
2.39.2


