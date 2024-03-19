Return-Path: <linux-kernel+bounces-107994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D281880497
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:18:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C28211F24444
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E952E2D638;
	Tue, 19 Mar 2024 18:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A1AD1nhm"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D3A2C6AE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 18:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710872330; cv=none; b=G+mNzSruD7GqvCN+Qp7E1useaaibphTGlBhBKZ3OwUcfjS3unO/LcGWHRtyml6EvOJnjHRsKx+ii2tIibbzRBNHbCoF7d+LEv0lowvHbNV9uyuYVNxGkmFZdreWSJ2P73VGytoY1OWpkMcHYfOYP0RYganxmpMyte5HkSLSmm34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710872330; c=relaxed/simple;
	bh=hSQlxmu0JQGOLCccDVMeGRvCXoBcKwvCRhFdCa7EKfQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aIjAMaOLJGUr9ID0Sak0/m6LLX+pOeDKvUC+nTMPpSoODficjGo1EX0yqa7WFwZiTuSMmQXIYUKxR/zAJu8cHXCHsZj4GE1cbywFFBrdtP9dnxY8TptMQFwrugRqllYASQRWMwsKvwJu1KG/j7/aOWTf9YWTTmqXHMkOogi93Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A1AD1nhm; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dde24ec08cso7639415ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 11:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710872328; x=1711477128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ttsLf8/Vv4XSDgXwOmjeIFqmOGIaA6d4xvoGx5K3xuw=;
        b=A1AD1nhmTxwuJDBDCpVIY5Gb33roud97t7f0+h74S+DaMh/Cs/2qBH/UTf/41bAZUa
         Znxn1z/iRDLGEA1LDwruBIm3JPdj3rBC6gRgY760C/E06Ybrtq14h4H2n4cKhXippjCc
         qlLYOOcsnXj0hsXRcvCzdp2cxvijpWEiewpewY68vExu365bK0j7vL4BOF6yiuxPhBY+
         P3vEfmC5ppfW0asIfYRk6DuOUNLCDOJt4ggM8gEqsN3KIi1qmEMR4O5EI1r4wAt3HGEN
         MbLF4qcTtYdJUGc85C/u6dq9ZukwfUv4/9rg7edytKxvf8ccr5EEmnp5KKm5gDll5xmq
         7fCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710872328; x=1711477128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ttsLf8/Vv4XSDgXwOmjeIFqmOGIaA6d4xvoGx5K3xuw=;
        b=kSDd4D52huDXU84XDiQkoz/s+omkqIq9XtmiuWYb614kHOZf8oJXvMxzfiIsffMXTu
         jeXQlXqRqDlXc9TAMZ1AP+u+h8h5bRY6kE0XBycUnmBJGHFwAKv5HWYeX72IlisXxHNR
         KKTXw1JTt7BJvic7VTtRF/nYB/ZEYC/oNIiPmRGAtoA0MYIwNYnODWiGqLPbjzMg0LM7
         7mF6VL2U7yJcaYSw7qDQjd7QC7uyjJFBbjbH3/zNvAikPzhJMN/AG6xq0wxk2XuNR3E3
         NYTe0hJODFGzNIJjLXneCV4XmUitCQhWooWOmqhj9csScBtCPYZ/RO3bV3qGC/hdrZcj
         Axgg==
X-Forwarded-Encrypted: i=1; AJvYcCWF14M+pYwmu5oj3j52gzW5bm/PC85CpTeygr9UNYTikwBf7wB/dURLz3z2m01HCek0/289ab1dtqEahY2hWrPxffNQz7bbS8Y0ctsP
X-Gm-Message-State: AOJu0YyPXsa1CchzMcBEmoqBTwGJCtyCvf6xvHhe4LN15TqD1hogQ7hi
	W7gXEPCaN4AlT+gmOxCivZ98WgdB0oMEo9ax5Vwtc0+uFcHoj1mrBZee4VBbec8=
X-Google-Smtp-Source: AGHT+IHdWSDyGQAgjTBQUrEny3k9F7nqWA36dWJEPS2flyYlHH6hN4GRg4Y09QU5dBjkGxccVy7gQQ==
X-Received: by 2002:a17:902:e5c9:b0:1dd:db2a:62a7 with SMTP id u9-20020a170902e5c900b001dddb2a62a7mr3230063plf.3.1710872328228;
        Tue, 19 Mar 2024 11:18:48 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f55100b001dd6f305a81sm4306166plf.293.2024.03.19.11.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 11:18:47 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: msakai@redhat.com,
	akpm@linux-foundation.org
Cc: dm-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	jserv@ccns.ncku.edu.tw,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH] MAINTAINERS: Remove incorrect M: tag for dm-devel@lists.linux.dev
Date: Wed, 20 Mar 2024 02:18:42 +0800
Message-Id: <20240319181842.249547-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dm-devel@lists.linux.dev mailing list should only be listed under
the L: (List) tag in the MAINTAINERS file. However, it was incorrectly
listed under both L: and M: (Maintainers) tags, which is not accurate.
Remove the M: tag for dm-devel@lists.linux.dev in the MAINTAINERS file
to reflect the correct categorization.

Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 82896c3e0559..e0a4e0def090 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6172,7 +6172,6 @@ F:	include/uapi/linux/dm-*.h
 
 DEVICE-MAPPER VDO TARGET
 M:	Matthew Sakai <msakai@redhat.com>
-M:	dm-devel@lists.linux.dev
 L:	dm-devel@lists.linux.dev
 S:	Maintained
 F:	Documentation/admin-guide/device-mapper/vdo*.rst
-- 
2.34.1


