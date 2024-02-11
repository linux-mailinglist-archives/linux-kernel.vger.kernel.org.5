Return-Path: <linux-kernel+bounces-60641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 504328507F3
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 07:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F80C1C233BF
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 06:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF62B17542;
	Sun, 11 Feb 2024 06:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uBM1d/oh"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DB3168A8;
	Sun, 11 Feb 2024 06:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707632678; cv=none; b=tCS5Hq4Wg9/V1urY6WUq9l2NsEFyckc3S3mLOMYjiwzZAMxNyJmhuhv/3Mat5CPhBAOhvPAnazwt/ymr0RZmzSnoiQYPmhR4O5QwAULAgn5PAxbu8Ehotda89+QXFp3WfCkNfd027Vmv7r0+OfjHZuarR4Lb9qWABvz7QeE4C48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707632678; c=relaxed/simple;
	bh=+TrLYy5AwqdeTtpC+LsvU5GZLUqJuRLQoaEknBAH7PE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lR1WupF5DFBBup9qcFaZs0YSZxvvAIjkxcptWYa3sIwWKzfX3F6S+JwEVO7rGXFinp57SrcuiIZsAtkEUqT/yltA0Km4ZMQzgy5q8RKslm2FpwPUCB2yN3stsy4Tm2Xc68BjzHCzzzQXDcKUZZJ8y+P7WP0mBqRVMaG9hBgszx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uBM1d/oh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=RDiM/MvnYaGZ/zoyP+kqI6CbVgG9JJwnDMdv6wBtCkQ=; b=uBM1d/ohYqdzMcHAnRoL6QOtHR
	fCaX68gai2F0jDr45Ed5CZQtw0qWgv58yfZSPfCb/Kqssz6PjHRqnzPfO4asSHzNednnsfrJIXoUQ
	8lnmSYTXj0HWXLd8hBCyiIROLyLJve0sxaapgO7Y3VjKmPCNiuDtMwGmrAngGVjxnUwpZZ2FHXEk3
	zHp6CVXfGx+s7Cen5qmtWe2MSDDvyqZoeqgoqI5Gr2zhOHOvd7sNJUKmri91ZTrhYBbtiOwTiBDgm
	ih5vVpauDipzF3a8vNuQubPDr61sm5z5l9ATqGHPaB5eBVcG6EsyuwL8KxT4+P2dLZMS4pmQ4CuXk
	Qqw7Lmxw==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZ3GV-00000002PAU-2EdR;
	Sun, 11 Feb 2024 06:24:35 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-sgx@vger.kernel.org,
	x86@kernel.org,
	Kai Huang <kai.huang@intel.com>
Subject: [PATCH v2] x86/sgx: fix kernel-doc comment misuse
Date: Sat, 10 Feb 2024 22:24:34 -0800
Message-ID: <20240211062434.16351-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't use "/**" for a non-kernel-doc comment. This prevents a warning
from scripts/kernel-doc:

main.c:740: warning: expecting prototype for A section metric is concatenated in a way that @low bits 12(). Prototype was for sgx_calc_section_metric() instead

Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-sgx@vger.kernel.org
Cc: x86@kernel.org
Reviewed-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: add Rev-by: Kai Huang

 arch/x86/kernel/cpu/sgx/main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/arch/x86/kernel/cpu/sgx/main.c b/arch/x86/kernel/cpu/sgx/main.c
--- a/arch/x86/kernel/cpu/sgx/main.c
+++ b/arch/x86/kernel/cpu/sgx/main.c
@@ -731,7 +731,7 @@ out:
 	return 0;
 }
 
-/**
+/*
  * A section metric is concatenated in a way that @low bits 12-31 define the
  * bits 12-31 of the metric and @high bits 0-19 define the bits 32-51 of the
  * metric.

