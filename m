Return-Path: <linux-kernel+bounces-139226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E896D8A0018
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89D211F28333
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C398417BB2D;
	Wed, 10 Apr 2024 18:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O6BdMVwY"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF4963E;
	Wed, 10 Apr 2024 18:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712775273; cv=none; b=gulFIRdLf4dxWDd9sc5yCkUcODrozfHlZn9C49S415Pw81dcE1agpW0kmqg4UZHTkGlCNvi/UhRZIEBy9r+YXUD2WxD2Rvf1ZFD+JPisX/TkyX86RH4AP5/t7XsUkuSz8jRfjYya2VoRm5vV7v5wv9eF43GL+IJ6zri9gVmqHjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712775273; c=relaxed/simple;
	bh=RH0CGcQudRQ007V38SiSJ7/a6bBa9HHc37Qr4ZBEku4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=WBpwTW7ofFZgtNPJhSIgBBNQHkjFBhhlNd4JqtNRhVWjAyugzFxMZAhJs3kI9lXR7Na3FTwl0FqYjrdRzezTvH+AolROoIr11BGOO2VadS3CtFABSX5nlZbZrP5eKGLOsZYcCElzS8qrrb9Y+QeWpMKTajk/fSo0OO/cI9yk6uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O6BdMVwY; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bbbc6e51d0so3015311b6e.3;
        Wed, 10 Apr 2024 11:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712775271; x=1713380071; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0xD9LsoG01n3s9+dlYoOVodKafjjk33yWzb85+W56js=;
        b=O6BdMVwYeFKS+EAO00v2p76wAvq7taFJxvXZ+mqfra/Ug9B3/a0Zxd6PJvNx9BaV24
         QpQQpnrJHVkV6FNkwtXpsWgSsxi3ZP/mmHZGnXZcj+YtmW+cqhFJMNm4q9Jhc5+LCxyb
         fVPWyCAIhrvCG7ndQWTj/Pzvcqx8pkGEyfAwbdRTOcugS+y6pd23qTlPI18VNmp8vOif
         E1FkDQPa6Dt1JiOHc3fDIjUZYS8k/Sn39w6Lu6ZJpe2Xpc6E6qYApROkGz6M0+E4iiub
         h95ZHsbg2f4NLUOOZ+gKrbTZ/gWQI1ujgrmgukWmGNv0SNqV2tOUVGf1YfsjNBK9IXi7
         54Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712775271; x=1713380071;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0xD9LsoG01n3s9+dlYoOVodKafjjk33yWzb85+W56js=;
        b=q8l7Du3Qdra8I7mzBnzIU0BGDtcw9HixsS2ryMOd88TOBxfLbNn0CDmVqJlq2t8EVw
         UBIn7eiFVZGEetarLm+xHNiuxvbN25GHoySfNQjweD4KWktJzq5VL9laiQ6O6sM+qTdE
         AELmvCinDSDIvGSEK4O3yJ+r0/fEpwGFgkXjg2R3QlzZRPF4sPqvtHSxDSBJksym8JeN
         jXADGSVAquJn/cLca9lIFRZNg8WoOrPn9y+ZzTMBXynfZAMN4JYiz16DGY/7qklJqxWT
         itkNu9X/PdBySWI9NfyoJwJw5NOB1gSEoHNvozjucB9GHAnkbh/FGQsMY7RBmuztnNAX
         FCRg==
X-Forwarded-Encrypted: i=1; AJvYcCXOyrTgIr2OvZeqQK9RF+FS3qFu1T01osAdjwwBtiyCPjL7Yv7ZIF1A1xPkSKTiVhW6UCTo43yy/7jbg4MAozdAuPc03IvsFhOt
X-Gm-Message-State: AOJu0Yw99QtGHSFodCNMHip97RjvGrYpMBxJiD5eZlrcSAkvwtq/TvGA
	5XDZiT1eFfmJXrrjw4l8OFh80+PJH3Riu5lezhCjq+P2x1mM/8UqVYTBrIC6U04Bog2V6xypX8t
	IliaGislZyiPSeKlM3f3WZOSxWJqVa0nci1o=
X-Google-Smtp-Source: AGHT+IFzn2cqcJVegdHH0Ndtyd3UPoZJjLO/IIhkvUc33AmEqXh30mM2e8NZ5Y+R3eqS39+r9T+ZvNbMEDfJEufgufs=
X-Received: by 2002:a05:6808:18f:b0:3c6:be9:f4f9 with SMTP id
 w15-20020a056808018f00b003c60be9f4f9mr2438849oic.28.1712775270737; Wed, 10
 Apr 2024 11:54:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: arlr <carl.rosdahl05@gmail.com>
Date: Wed, 10 Apr 2024 22:54:18 +0200
Message-ID: <CAGfdVaw_TU__+XJQyOSHncGFziE206c7=UVbfjvPHnq14xOVjg@mail.gmail.com>
Subject: [PATCH] uapi: add missing const qualifier to cast in some byteorder functions
To: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add missing const qualifiers to cast in __{le,be}{16,32,64}_to_cpup.

Signed-off-by: Carl Rosdahl <carl.rosdahl05@gmail.com>
---
reduced testcase (on exported headers):
$ cc -c -o /dev/null -Wcast-qual -xc usr/include/linux/byteorder/big_endian.h
$ cc -c -o /dev/null -Wcast-qual -xc usr/include/linux/byteorder/little_endian.h

diff --git a/include/uapi/linux/byteorder/big_endian.h
b/include/uapi/linux/byteorder/big_endian.h
index 80aa5c41a763..e59ec4f8bd92 100644
--- a/include/uapi/linux/byteorder/big_endian.h
+++ b/include/uapi/linux/byteorder/big_endian.h
@@ -48,7 +48,7 @@ static __always_inline __le64 __cpu_to_le64p(const __u64 *p)
 }
 static __always_inline __u64 __le64_to_cpup(const __le64 *p)
 {
-    return __swab64p((__u64 *)p);
+    return __swab64p((const __u64 *)p);
 }
 static __always_inline __le32 __cpu_to_le32p(const __u32 *p)
 {
@@ -56,7 +56,7 @@ static __always_inline __le32 __cpu_to_le32p(const __u32 *p)
 }
 static __always_inline __u32 __le32_to_cpup(const __le32 *p)
 {
-    return __swab32p((__u32 *)p);
+    return __swab32p((const __u32 *)p);
 }
 static __always_inline __le16 __cpu_to_le16p(const __u16 *p)
 {
@@ -64,7 +64,7 @@ static __always_inline __le16 __cpu_to_le16p(const __u16 *p)
 }
 static __always_inline __u16 __le16_to_cpup(const __le16 *p)
 {
-    return __swab16p((__u16 *)p);
+    return __swab16p((const __u16 *)p);
 }
 static __always_inline __be64 __cpu_to_be64p(const __u64 *p)
 {
diff --git a/include/uapi/linux/byteorder/little_endian.h
b/include/uapi/linux/byteorder/little_endian.h
index cd98982e7523..65204e600fbf 100644
--- a/include/uapi/linux/byteorder/little_endian.h
+++ b/include/uapi/linux/byteorder/little_endian.h
@@ -72,7 +72,7 @@ static __always_inline __be64 __cpu_to_be64p(const __u64 *p)
 }
 static __always_inline __u64 __be64_to_cpup(const __be64 *p)
 {
-    return __swab64p((__u64 *)p);
+    return __swab64p((const __u64 *)p);
 }
 static __always_inline __be32 __cpu_to_be32p(const __u32 *p)
 {
@@ -80,7 +80,7 @@ static __always_inline __be32 __cpu_to_be32p(const __u32 *p)
 }
 static __always_inline __u32 __be32_to_cpup(const __be32 *p)
 {
-    return __swab32p((__u32 *)p);
+    return __swab32p((const __u32 *)p);
 }
 static __always_inline __be16 __cpu_to_be16p(const __u16 *p)
 {
@@ -88,7 +88,7 @@ static __always_inline __be16 __cpu_to_be16p(const __u16 *p)
 }
 static __always_inline __u16 __be16_to_cpup(const __be16 *p)
 {
-    return __swab16p((__u16 *)p);
+    return __swab16p((const __u16 *)p);
 }
 #define __cpu_to_le64s(x) do { (void)(x); } while (0)
 #define __le64_to_cpus(x) do { (void)(x); } while (0)

