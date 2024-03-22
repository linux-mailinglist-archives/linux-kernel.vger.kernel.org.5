Return-Path: <linux-kernel+bounces-111412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643FF886BF2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966E51C21405
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1FE3FE4B;
	Fri, 22 Mar 2024 12:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZZVnn2Aw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB3A3E487
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 12:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711109903; cv=none; b=UzlnSFumL0SbMgTlQtuNnRVXtNnCXIfHgVAULOyU/L+aIPqm747t52Mhge2g0Rh8OWtA2CrMVHufIQ79+R7c1RM1lTITLpiapaVulv75JNZaA9XaykQjwphERjrLKQdHL6nt3764rZPM53dyX0Cfoe6C61F0hlwe10E+9y8Irs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711109903; c=relaxed/simple;
	bh=cFzbq/vR3wjLyPnVzSNACHfajl6wKiU0qxPP1Ge4LHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J7DbrVV3OCNSWycYKcvg23wpFcR44tc5smk7BnhjG5N6VVgT9kUIHK57g4dJFAouHyQaqQwiZxzTT6Ovq62dRyujNHrb5AjUcyuoaKK62BgOP4BfWi3OydljFDqoO7pm6bjeDkHVYzmYujIT1iVNhmWC1N9ttEUF2gMh8UWkYGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZZVnn2Aw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711109900;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=waYE6IAkKbEZT6TTM98L8WXVOpvsZ5+twv6JwCR9/88=;
	b=ZZVnn2AwIs/ASU/0fAVR+4FJfzasmcmCon/qo16O8qInm7MS29FYZHS7K7ZIEicR4gFQg3
	m1rxZI9y7ZX3ti4XbB0pF6hN8BDDTn1Ov/Y711DGPvVzfzPqi4LB/oAt2IqPEmDBOKS7Cd
	eacXeypIajhJolkyXuRp1DvMq/w20X8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-8ZlMNcwMNlGGpS_bN16llw-1; Fri, 22 Mar 2024 08:18:17 -0400
X-MC-Unique: 8ZlMNcwMNlGGpS_bN16llw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9D833891E69;
	Fri, 22 Mar 2024 12:18:16 +0000 (UTC)
Received: from kaapi.redhat.com (unknown [10.67.24.5])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C792492BD0;
	Fri, 22 Mar 2024 12:18:12 +0000 (UTC)
From: Prasad Pandit <ppandit@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prasad Pandit <pjp@fedoraproject.org>
Subject: [PATCH] ftrace: fix FTRACE_RECORD_RECURSION_SIZE Kconfig entry
Date: Fri, 22 Mar 2024 17:48:01 +0530
Message-ID: <20240322121801.1803948-1-ppandit@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

From: Prasad Pandit <pjp@fedoraproject.org>

Fix FTRACE_RECORD_RECURSION_SIZE entry, replace tab with
a space character. It helps Kconfig parsers to read file
without error.

Fixes: 773c16705058 ("ftrace: Add recording of functions that caused recursion")
Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
---
 kernel/trace/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 61c541c36596..47345bf1d4a9 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -965,7 +965,7 @@ config FTRACE_RECORD_RECURSION
 
 config FTRACE_RECORD_RECURSION_SIZE
 	int "Max number of recursed functions to record"
-	default	128
+	default 128
 	depends on FTRACE_RECORD_RECURSION
 	help
 	  This defines the limit of number of functions that can be
-- 
2.44.0


