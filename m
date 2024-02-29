Return-Path: <linux-kernel+bounces-87185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D8F86D0D3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:37:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 046841C2179B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D00C7828D;
	Thu, 29 Feb 2024 17:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fB+l7Dtw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 272257828A
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 17:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709228191; cv=none; b=ZT+1kS0QZVK4MRyYZRGRXTFAX9iL4p2D+eNKSqssP9PFVf9poM4xhXkUFl7APdUzmDis11Nvpu2Wjl8BD0GYWgcpv4waNz0uLCo6r/JuUZlwmJjNGLjFyjFkSL2FN0nhOO0Ab1WsmOClNIWsUUBa7vVBnOg1DLa6stUb5mcfZV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709228191; c=relaxed/simple;
	bh=Nfy+FvhiVO6FRr4RGFIgCjBGC56X8Ck24EWdzRnn+CA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-type; b=cpn+RNcG2b0GiV9p+qa42CqnHXV3iDQYvNBzI+xBExvTNlLGkXoCXSrXfNPGcN7qcgo/l+hFCCskBggByytqAabCNnXX0b2KHqD5CTNYWOw+ELprjpPwSCcKIdZ4MgsGLxZUGnUVmJGfn1bzTATAPZaHajStCc8IcTGqIWOd4eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fB+l7Dtw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709228189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8NCFY5/xqwqZ+BzOYm6QBuVWVdJZDIeZ/gZcGzEqZ/8=;
	b=fB+l7DtwHuxqvbKXkzdZ/O45ea4GwhPX3XeG4SK/sUAWl1ljqcdaPG6NRvlUBq/GkSESSd
	tm0l1FVtggYXQavXulHSavkZxHBBQS+l6IsxHfXXnA4aUVKvFFB2gK5A/tuKX+0oM5PY0B
	3enVrGbDGuqTCOr7UKfExfZrVHEbDM4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-FaAciST9MoWocjVqHzlTlg-1; Thu,
 29 Feb 2024 12:36:25 -0500
X-MC-Unique: FaAciST9MoWocjVqHzlTlg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C8701C0CCA5;
	Thu, 29 Feb 2024 17:36:25 +0000 (UTC)
Received: from rules.brq.redhat.com (unknown [10.45.242.24])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7C6B220229A4;
	Thu, 29 Feb 2024 17:36:23 +0000 (UTC)
From: Vladis Dronov <vdronov@redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>
Cc: Nicolai Stange <nstange@suse.de>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vladis Dronov <vdronov@redhat.com>
Subject: [PATCH] crypto: tcrypt - add ffdhe2048(dh) test
Date: Thu, 29 Feb 2024 18:36:03 +0100
Message-ID: <20240229173603.10258-1-vdronov@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Commit 7dce59819750 ("crypto: dh - implement ffdheXYZ(dh) templates")
implemented the said templates. Add ffdhe2048(dh) test as it is the
fastest one. This is a requirement for the FIPS certification.

Signed-off-by: Vladis Dronov <vdronov@redhat.com>
---
 crypto/tcrypt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/crypto/tcrypt.c b/crypto/tcrypt.c
index ea4d1cea9c06..8aea416f6480 100644
--- a/crypto/tcrypt.c
+++ b/crypto/tcrypt.c
@@ -1851,6 +1851,9 @@ static int do_test(const char *alg, u32 type, u32 mask, int m, u32 num_mb)
 		ret = min(ret, tcrypt_test("cbc(aria)"));
 		ret = min(ret, tcrypt_test("ctr(aria)"));
 		break;
+	case 193:
+		ret = min(ret, tcrypt_test("ffdhe2048(dh)"));
+		break;
 	case 200:
 		test_cipher_speed("ecb(aes)", ENCRYPT, sec, NULL, 0,
 				speed_template_16_24_32);
-- 
2.43.2


