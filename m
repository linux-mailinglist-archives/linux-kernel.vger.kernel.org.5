Return-Path: <linux-kernel+bounces-111470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6CB886CC4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:22:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4DFAB2283E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B6C46439;
	Fri, 22 Mar 2024 13:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBXGK0Q2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396D145BFC
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 13:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711113759; cv=none; b=TAFvxWqaoEtC99uiVlBF8ngaCoBO2naIWEKUXPKYxUXmsMXVktK/8N06VkaO48EAjuITa0HYTEleNuvvwGioFaVXcTLNVYDqhgO0V/cXToXbDdpyQcVZp+1KogpGoVirIKFqVCjYBjx+2bfniP4JCUACcozsn9uk3ElmiLhkijw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711113759; c=relaxed/simple;
	bh=oJI7OJGcHiSzlfANKgkCEdv5ZGh29jwQrc+H/qiL9IQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nTCXSIX3E5NQ3P3vzgeWwhg8GAkZKq5M6viY41exGoOsB0u8VjeXtGYiJft9m9CD4QC8YqUuPi9ju0DCvPAIsirF9Zjyteuh9Kk+kQqV3MwS5WGFZxcS8OLjVv2cW+TXB5LDdylWYLpVFYMquUWjeAvZ+Od7WIngGJSjQGklKkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBXGK0Q2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1B8C43394;
	Fri, 22 Mar 2024 13:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711113758;
	bh=oJI7OJGcHiSzlfANKgkCEdv5ZGh29jwQrc+H/qiL9IQ=;
	h=From:To:Cc:Subject:Date:From;
	b=lBXGK0Q2Ctsjinyfmzj1l8tqQHHZ4lfJYq9ma24BoOthsrGk5Zkjt0rTYh9sXQxu1
	 jkFHJSEt5FjywE8VBOZ3JqlA03MsqefVZekrh4rnY3rz8dkXe/RTrOqnG/BNEMggkP
	 iAQfMnvDKJKFrVgdDW/b499janzVEuKYhDt28u6LX4KHsM9Yu2rynUbDURobRHYYP7
	 A0TCoi+0gSxOkBe3hqPSYSiRnfq8dL1k/oIy4bjhI6ZPJjbOIkbLXVklt9SFle/ZdK
	 c8NRyyJJnwswi7zBACWKmrnzqVCJvawYDVFE7BSKR890hhWrGBs45+jXOpzP2nZTEe
	 GTAyzj6HvHasQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Jan Harkes <jaharkes@cs.cmu.edu>,
	coda@cs.cmu.edu
Cc: Arnd Bergmann <arnd@arndb.de>,
	codalist@coda.cs.cmu.edu,
	linux-kernel@vger.kernel.org
Subject: [PATCH] coda: avoid Wunused-but-set-variable warning
Date: Fri, 22 Mar 2024 14:22:26 +0100
Message-Id: <20240322132234.906977-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The UPARG() macro implicitly sets the outp variable, but a lot of the
callers never actually use the results instead, causing a W=1 warning:

fs/coda/upcall.c:115:27: error: variable 'outp' set but not used [-Werror,-Wunused-but-set-variable]
  115 |         union outputArgs *outp;
      |                           ^

Add a cast to void to shut up that warning for callers that don't
care bout the output.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/coda/upcall.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/coda/upcall.c b/fs/coda/upcall.c
index cd6a3721f6f6..b7451fdef14d 100644
--- a/fs/coda/upcall.c
+++ b/fs/coda/upcall.c
@@ -63,6 +63,7 @@ do {\
 	inp = (union inputArgs *)alloc_upcall(op, insize); \
         if (IS_ERR(inp)) { return PTR_ERR(inp); }\
         outp = (union outputArgs *)(inp); \
+	(void)outp; \
         outsize = insize; \
 } while (0)
 
-- 
2.39.2


