Return-Path: <linux-kernel+bounces-107338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF5087FB37
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:55:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 999CC282C31
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BCD7D419;
	Tue, 19 Mar 2024 09:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKrLC7xz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702F57F478;
	Tue, 19 Mar 2024 09:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710842019; cv=none; b=G4UT9JNqM6tavv8W5EQgnarkcKXMJ1om3tD9e2njDO32zyWfQdIzE7S6puA+MM5GMWD+LDLizsVQEF2j2KfDPlOnTwz7h968t0GKn4FtNHMUZJVnRGlGaFZlg64hiB8yjhKsIQnZ7EutuYL7U4I0k2J2o1SjDBp08w3dk+I8Kj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710842019; c=relaxed/simple;
	bh=tJF+08Wovvyo19kq87yZF22HcvtylXgBS1IrMhly7rU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ril/tK4to1LeZxo3erETRYeKXPtzNxg8SwFtAENI134k7fhxlq89qmFM2AuInqWohsFUe7F0Wdgsx1yxxEUv89dK/xP17gFDNVPY4P9sCezfPH5gv67MGz4L6XWA39NaOJsXG9rRwiZ85wtDPTYNTcwz5ooYYfGVGIWoV85+95w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKrLC7xz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98082C433C7;
	Tue, 19 Mar 2024 09:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710842018;
	bh=tJF+08Wovvyo19kq87yZF22HcvtylXgBS1IrMhly7rU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aKrLC7xz2TJJmN/mIG3bxdvMRDPbIbOw7EiQNSbQ+B2bJMMpvGhl+O9iiaIZG1p0H
	 M4MHFCXbEbSQztibJAlK7G+iuRygXRDeXbVQnVrfLTLzMVCcNSnladHvnrDB8ZoE5C
	 v5wFcATQEeWyxZFrqtmvzsAzRGQh1AhXYmpB7Z5bE6MnofUCmxeDKrQ6odsimsgZKn
	 O45UprjL8scm9EhmMO9ns0ELcsN+/v4UUzdVP0hug1EzduLt4TWSG2OOBBf5D8QP+k
	 Bc9f55krPq6/YUFSqe3QhdyX7f300OtSMalVMnvCDZ7XLxYPvmAx8Kq07Dhoj73OAa
	 tdlQCVKRuH+TQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: linux-serial@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Stefani Seibold <stefani@seibold.net>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [RFT 05/15] kfifo: rename l to len_to_end in setup_sgl()
Date: Tue, 19 Mar 2024 10:53:05 +0100
Message-ID: <20240319095315.27624-7-jirislaby@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240319095315.27624-1-jirislaby@kernel.org>
References: <20240319095315.27624-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

So that one can make any sense of the name.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Stefani Seibold <stefani@seibold.net>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 lib/kfifo.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/kfifo.c b/lib/kfifo.c
index d5830960ab87..61e35550aea5 100644
--- a/lib/kfifo.c
+++ b/lib/kfifo.c
@@ -321,7 +321,7 @@ static unsigned int setup_sgl(struct __kfifo *fifo, struct scatterlist *sgl,
 {
 	unsigned int size = fifo->mask + 1;
 	unsigned int esize = fifo->esize;
-	unsigned int l;
+	unsigned int len_to_end;
 	unsigned int n;
 
 	off &= fifo->mask;
@@ -330,10 +330,10 @@ static unsigned int setup_sgl(struct __kfifo *fifo, struct scatterlist *sgl,
 		size *= esize;
 		len *= esize;
 	}
-	l = min(len, size - off);
+	len_to_end = min(len, size - off);
 
-	n = setup_sgl_buf(sgl, fifo->data + off, nents, l);
-	n += setup_sgl_buf(sgl + n, fifo->data, nents - n, len - l);
+	n = setup_sgl_buf(sgl, fifo->data + off, nents, len_to_end);
+	n += setup_sgl_buf(sgl + n, fifo->data, nents - n, len - len_to_end);
 
 	return n;
 }
-- 
2.44.0


