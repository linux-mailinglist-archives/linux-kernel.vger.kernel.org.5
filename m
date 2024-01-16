Return-Path: <linux-kernel+bounces-27661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD5482F3D1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A645287CD4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B95E1CD3F;
	Tue, 16 Jan 2024 18:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GLXwYIFP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD68C1CD2A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 18:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705428744; cv=none; b=Uv7AYD2meDj73+SHiP3KAcBMaSuHGJs6lKtQDaHenwR9HGk/e6DhlTtzrRl844M93QLZ1wKDjPnr3W3+oNZol9KsbdvCAe/rF0tlIi0fDjz1gTWpMllrcN39WtkW/pX47F39apReFLSFhI3hsbs/wXH/9fn3IAq7HnpvOrZjHeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705428744; c=relaxed/simple;
	bh=Y6BcPN6C0vM20TSEHpKXRm+HFeCEV83BLrODxyzHY28=;
	h=DKIM-Signature:Received:X-MC-Unique:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:
	 X-Scanned-By; b=IfjegZ6c0m2Fu1qVH7bBxseG/n9zkKr358VxzkNR9w5P1eDpL+Kr6UE+XpaFYrHjTjO+4qhPWXfzlZkEfI/+lXe4PJywbFWl5DUCi6utM62r5fLKDs4CT5tItVsQSK6QFNcv4T1EKLpVya/VISGovGWvwagQnwXY7GBNF9nacow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GLXwYIFP; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705428739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8c8I13Su6HTMW66B6BpT4d4txlCoy+2n6n8rpUT0geg=;
	b=GLXwYIFPFRaCDFdoftMbQgv++LsLBPtkr6n2qPUhKW5U+YSFnOvq/zHdeD3Fx5kZkDIEcR
	L4+5Q2maRZgPDLAXN+qhxZrtqnDvSyTCpUWgs56QQ2TScbI9y3d6vAZk2GM+M/snEAsJvX
	wktLuKNwn4LV3gLbrVDa1CcTsAtbrTk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-102-pEZk0p04PqOzbVZIyPPROA-1; Tue,
 16 Jan 2024 13:12:14 -0500
X-MC-Unique: pEZk0p04PqOzbVZIyPPROA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 46A32299E742;
	Tue, 16 Jan 2024 18:12:14 +0000 (UTC)
Received: from cmirabil.redhat.com (unknown [10.22.32.104])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 99A84492BC6;
	Tue, 16 Jan 2024 18:12:13 +0000 (UTC)
From: Charles Mirabile <cmirabil@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Charles Mirabile <cmirabil@redhat.com>,
	Willy Tarreau <w@1wt.eu>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Ammar Faizi <ammarfaizi2@gnuweeb.org>
Subject: [PATCH] nolibc/stdlib: Improve `getauxval(3)` implementation
Date: Tue, 16 Jan 2024 13:11:47 -0500
Message-ID: <20240116181147.2230944-1-cmirabil@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Previously the getauxval function checked for a doubly null entry (i.e.
one whose type and value both were 0) in the auxv array before exiting
the loop.

At least on x86-64, the ABI only specifies that one more long will be
present with value 0 (type AT_NULL) after the pairs of auxv entries.
Whether or not it has a corresponding value is unspecified. This value is
present on linux, but there is no reason to check it as simply seeing an
auxv entry whose type value is AT_NULL should be enough.

This is a matter of taste, but I think processing the data in a structured
way by coercing it into an array of type value pairs, using multiple
return style, and a for loop with a clear exit condition is more readable
than the existing infinite loop with multiple exit points and a return
value variable.

I also added a call to set errno to ENOENT when the entry is not found as
glibc does which allows programs to disambiguate between the case of an
auxv that is not present, and one that is, but with value zero.

Fixes: c61a078015f3 ("nolibc/stdlib: Implement `getauxval(3)` function")
Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
---
 tools/include/nolibc/stdlib.h | 34 +++++++++++++---------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/tools/include/nolibc/stdlib.h b/tools/include/nolibc/stdlib.h
index bacfd35c5156..47be99c5a539 100644
--- a/tools/include/nolibc/stdlib.h
+++ b/tools/include/nolibc/stdlib.h
@@ -104,27 +104,19 @@ char *getenv(const char *name)
 static __attribute__((unused))
 unsigned long getauxval(unsigned long type)
 {
-	const unsigned long *auxv = _auxv;
-	unsigned long ret;
-
-	if (!auxv)
-		return 0;
-
-	while (1) {
-		if (!auxv[0] && !auxv[1]) {
-			ret = 0;
-			break;
-		}
-
-		if (auxv[0] == type) {
-			ret = auxv[1];
-			break;
-		}
-
-		auxv += 2;
-	}
-
-	return ret;
+	const struct {
+		unsigned long type, val;
+	} *auxv = (void *)_auxv;
+
+	if (!auxv || !type)
+		goto out;
+
+	for (; auxv->type; ++auxv)
+		if (auxv->type == type)
+			return auxv->val;
+out:
+	SET_ERRNO(ENOENT);
+	return 0;
 }
 
 static __attribute__((unused))
-- 
2.41.0


