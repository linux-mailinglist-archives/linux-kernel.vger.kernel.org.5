Return-Path: <linux-kernel+bounces-76667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDB685FAB8
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C7681C25D90
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF72014C584;
	Thu, 22 Feb 2024 14:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qg/JjqKp"
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5B914C5AF
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 14:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708610708; cv=none; b=XnVte5m/zxhnlxgpp8OI0FFo9rE4ZD951vtdNoW5VBHIbhJ6ivm//9hnzUWNZl0o1cpZO38ZYXvz5zYGETaj/cWPdR6K6cREc0i4k/iDZjorVKr0WAhlsd/iSfZ9zlzI7gS47eumDeXj07R/0agZaTxmr/Ww0gH2jtHyjxK1MoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708610708; c=relaxed/simple;
	bh=R5MnQwc9t4v2E0fp8qGfSsi085XwCBGRqhTGk/VczIo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ESO/7zax262KNBGzZ7VtwWk1XICtKULFYHW2J5b3y0KdmNJwPZA28vPM9Yy+iMjVXXzGu7mEp5SkGbCLBrgOh2BBI0cSEmPat4X24upnFDPlnd8/JWdKPDBhQqoL3Z1+PJlk+yinJVimOPBgoKANMhRw04x9OLbkeGs3bBkrDCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qg/JjqKp; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708610704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gKGGJ4keOOfrl00iluvEDQ3Ty93zFU24V1EYV5CxVyE=;
	b=qg/JjqKph94W1a8idl0Ardw/d1tXM/odKpkHBNYeJX6L3C8F1p+YAZQ9skiGNuOx7apSHg
	P50H5nQcpGnKjLptZs0X/vUJxmxyGb2wQzDUgVbKsnbaaN5OpGF0RgSBPk7VaTYu7ry88z
	y+/WrwgLKTRUrw1khfweAOXlhe62gqo=
From: Gang Li <gang.li@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>,
	David Rientjes <rientjes@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Jane Chu <jane.chu@oracle.com>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ligang.bdlg@bytedance.com,
	Gang Li <gang.li@linux.dev>
Subject: [PATCH v6 6/8] hugetlb: have CONFIG_HUGETLBFS select CONFIG_PADATA
Date: Thu, 22 Feb 2024 22:04:19 +0800
Message-Id: <20240222140422.393911-7-gang.li@linux.dev>
In-Reply-To: <20240222140422.393911-1-gang.li@linux.dev>
References: <20240222140422.393911-1-gang.li@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Allow hugetlb use padata_do_multithreaded for parallel initialization.
Select CONFIG_PADATA in this case.

Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
Tested-by: David Rientjes <rientjes@google.com>
Reviewed-by: Muchun Song <muchun.song@linux.dev>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
---
 fs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/Kconfig b/fs/Kconfig
index 89fdbefd1075f..c0b9599bf8e3a 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -262,6 +262,7 @@ menuconfig HUGETLBFS
 	depends on X86 || SPARC64 || ARCH_SUPPORTS_HUGETLBFS || BROKEN
 	depends on (SYSFS || SYSCTL)
 	select MEMFD_CREATE
+	select PADATA if SMP
 	help
 	  hugetlbfs is a filesystem backing for HugeTLB pages, based on
 	  ramfs. For architectures that support it, say Y here and read
-- 
2.20.1


