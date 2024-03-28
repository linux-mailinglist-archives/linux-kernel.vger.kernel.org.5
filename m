Return-Path: <linux-kernel+bounces-122815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E320A88FDC7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98E431F27EB4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1687A7E105;
	Thu, 28 Mar 2024 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=alpinelinux.org header.i=@alpinelinux.org header.b="dpXOQPKD"
Received: from gbr-app-1.alpinelinux.org (gbr-app-1.alpinelinux.org [213.219.36.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E19AB4A18;
	Thu, 28 Mar 2024 11:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.219.36.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711624205; cv=none; b=QnRCdd1lTAHODB6IWyYeBvBCmJghvnZdg9NFSrKCr0xTKzDpbkGqan8hTDbhSqRPnghmd73In/UAeAdsCp5NcgMrQKCxdIk50MrseO4kB0ojYKV6ozl5+dYPd0n4eXfI9JuqhIa310nvd+AmxFKlM5Blav76njJGYkr3rRc15CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711624205; c=relaxed/simple;
	bh=YPtwI/73XQMq5pLXmdBDn594QE8iR58OHaXvHludfN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GGXmaIclnMpHTdCZ1EZmsrO4S9Vs8j6nyVFfaYVYY6EMBBaJWrr12aMgtsAaYo7cds5gOVtXEVs4emrcysAMJyrWVmdCsTFFbJxY2jzMYtQ5KAT9IQ8JV6JRzBefa2X5w9TJYxBbwObL5xqHugtJ0vZDBacbrsgjUQwwQw107VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpinelinux.org; spf=pass smtp.mailfrom=alpinelinux.org; dkim=pass (1024-bit key) header.d=alpinelinux.org header.i=@alpinelinux.org header.b=dpXOQPKD; arc=none smtp.client-ip=213.219.36.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpinelinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpinelinux.org
Received: from ncopa-desktop.lan (ti0056a400-4037.bb.online.no [85.167.238.210])
	(Authenticated sender: ncopa@alpinelinux.org)
	by gbr-app-1.alpinelinux.org (Postfix) with ESMTPSA id AE80B226016;
	Thu, 28 Mar 2024 11:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alpinelinux.org;
	s=smtp; t=1711623671;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=e3J+7uknz3z0s1JqJlEsccjqrrENP/4M0ZqplTq5eJU=;
	b=dpXOQPKDkCmrGhqGtBgCQrWFj4n4hd60kAQwPK9oWxZK4nzVZv0Ek02vCFVsu0sUavFj3B
	iWRCjOFoqF/LdParHOH5uf+yZe0QieCKFmxpW5EvuwS+Mx/skL0HWDUBjNQXooQuXATPq5
	2h/gQTWy8YdnnRV12Jzob3ZYqBmIRLI=
From: Natanael Copa <ncopa@alpinelinux.org>
To: bpf@vger.kernel.org
Cc: Natanael Copa <ncopa@alpinelinux.org>,
	stable@vger.kernel.org,
	Viktor Malik <vmalik@redhat.com>,
	Daniel Xu <dxu@dxuuu.xyz>,
	Alexei Starovoitov <ast@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tools/resolve_btfids: fix build with musl libc
Date: Thu, 28 Mar 2024 11:59:13 +0100
Message-ID: <20240328110103.28734-1-ncopa@alpinelinux.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include the header that defines u32.

Fixes: 9707ac4fe2f5 ("tools/resolve_btfids: Refactor set sorting with types from btf_ids.h")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218647
Cc: stable@vger.kernel.org
Signed-off-by: Natanael Copa <ncopa@alpinelinux.org>
---
This fixes build of 6.6.23 and 6.1.83 kernels for Alpine Linux, which
uses musl libc. I assume that GNU libc indirecly pulls in linux/types.h.

 tools/include/linux/btf_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/include/linux/btf_ids.h b/tools/include/linux/btf_ids.h
index 72535f00572f..72ea363d434d 100644
--- a/tools/include/linux/btf_ids.h
+++ b/tools/include/linux/btf_ids.h
@@ -3,6 +3,8 @@
 #ifndef _LINUX_BTF_IDS_H
 #define _LINUX_BTF_IDS_H
 
+#include <linux/types.h> /* for u32 */
+
 struct btf_id_set {
 	u32 cnt;
 	u32 ids[];
-- 
2.44.0


