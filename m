Return-Path: <linux-kernel+bounces-34003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B17D8371CD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B002E1C2A25C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC515C912;
	Mon, 22 Jan 2024 18:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IuB9HuEB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2827D5C8E7
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 18:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705949178; cv=none; b=lUaMlDcg/KkMUbPCiLyv0TWz6966RoiKHK5AKRHYORrfKROacckvOiG2D+9gHsiIweySoEN5Qac8T4T9GwvPKcvAIifZTbD51CpitmObRY6uftjdsFM7qlobZCavk3ByMlxvrpFhNaNxd/ZCU1kaLCHjDcc8FdtTdE+wMoKeKa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705949178; c=relaxed/simple;
	bh=lwHcE6C75LYyexBkvNLU1jyUyNNxt7s+6RxQN71P8CA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HGZucqd9lR62Bem9jp8SBRJjOiZ5xjmikBazsNBuSZSTwa3GyppbnDdqmCHsinC3zsaltJp28w41sYSrrh3/Vq3b77/o1MlekA+U3Fjksqq07wQhcLlU7M1Iu6BrkoJN38CPi0Lg8eaXHguU98gaKEa1U66sqM+e1LjmACI/40o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IuB9HuEB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705949176;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9k/EegaiCDxQTsPJYM7AgRXIenTX4Qdv+pyOcBo0/BE=;
	b=IuB9HuEBS4rRHCPWKgRQdeAdDrjcfQg17DmV9JI+OMud3EMfqWUzQgKoXU6l8Lzi0NUbmT
	AYnhKziQKnp2J9h5J8I8UccVJazN92Gbr4xzsAd8RDE9w+NYR8g6vUiLqEe5o06xdW+s45
	HTkCWAx3ZKCOui9maRO6EwGEpzRMJgc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-ysjZvPqyM5ijBPTkPlwEKA-1; Mon, 22 Jan 2024 13:46:14 -0500
X-MC-Unique: ysjZvPqyM5ijBPTkPlwEKA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-33921b95da8so2113638f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 10:46:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705949173; x=1706553973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9k/EegaiCDxQTsPJYM7AgRXIenTX4Qdv+pyOcBo0/BE=;
        b=i+XS3xwoHMoGDeUc5DjSUmrk/Hdl8zzZtMQpULDlWxII1y8VTmbwbHa3BboWC0tSyQ
         4VLXG+rW2Shbw5ttDJmYc2Lh2BTS+3Yh8/dIGoQAP4Yd9QcP0fimFLNIhlE26yXpL+VK
         LO3sc0SsB93owtIkzaPE3wawwUy0w8wZ4AT84O8pOAIupuolfCaywEsSys2O3dJfk9pF
         pm49pvoaHv1h2Af8qbf3ZnCFsl9qxb3xFLBvhtF+b2FpCHGtiuM/61S8TYPfdp9L5Fn7
         dxac52ESmy60JdXuZanckSBXcOSN4GUvJz+aK0VzOjg4Gy8876o1u9IlmZbTKVEijGoV
         rbsA==
X-Gm-Message-State: AOJu0YwbZmO9/aCtrex5ch3/PYszZ4kLxBNCARwQS2RWR+1XCUZbeQXZ
	XPFx0klh7k14vZJVAqeiPBL27vyBuVDOjY1uB5VcEHCMsilvn1klbCV0/7MGXqdPTzMrStnhvFg
	57ohbvpwuPtF1q58jnTjCAAN0wKfZLJwYebLJwRkpP6ZzzBFk6pujXDxvwRvG7w==
X-Received: by 2002:a05:600c:6a12:b0:40e:5b66:f4db with SMTP id jj18-20020a05600c6a1200b0040e5b66f4dbmr2605029wmb.88.1705949173072;
        Mon, 22 Jan 2024 10:46:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH8W84MVbr8pmJwkEKsKLqPzJvH24XUfb+11MPuqGlBCQFQ9TMC0d1DOvhygMO74Bh8s7Iw3A==
X-Received: by 2002:a05:600c:6a12:b0:40e:5b66:f4db with SMTP id jj18-20020a05600c6a1200b0040e5b66f4dbmr2605024wmb.88.1705949172795;
        Mon, 22 Jan 2024 10:46:12 -0800 (PST)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id l6-20020a7bc346000000b0040d81ca11casm38940253wmj.28.2024.01.22.10.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 10:46:12 -0800 (PST)
From: Danilo Krummrich <dakr@redhat.com>
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH] rust: str: add to_ascii_{upper,lower}case() to CString
Date: Mon, 22 Jan 2024 19:45:57 +0100
Message-ID: <20240122184608.11863-1-dakr@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add functions to convert a CString to upper- / lowercase assuming all
characters are ASCII encoded.

Signed-off-by: Danilo Krummrich <dakr@redhat.com>
---
 rust/kernel/str.rs | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 7d848b83add4..d21151d89861 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -581,6 +581,16 @@ pub fn try_from_fmt(args: fmt::Arguments<'_>) -> Result<Self, Error> {
         // exist in the buffer.
         Ok(Self { buf })
     }
+
+    /// Converts the whole CString to lowercase.
+    pub fn to_ascii_lowercase(&mut self) {
+        self.buf.make_ascii_lowercase();
+    }
+
+    /// Converts the whole CString to uppercase.
+    pub fn to_ascii_uppercase(&mut self) {
+        self.buf.make_ascii_uppercase();
+    }
 }
 
 impl Deref for CString {

base-commit: 610347effc2ecb5ededf5037e82240b151f883ab
-- 
2.43.0


