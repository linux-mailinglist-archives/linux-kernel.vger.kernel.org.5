Return-Path: <linux-kernel+bounces-64562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7AE85404D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF06B2827FE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 23:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9846312F;
	Tue, 13 Feb 2024 23:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zy7Yt7Ro"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389A362160;
	Tue, 13 Feb 2024 23:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707867997; cv=none; b=cRHfY0rlkFl1RmB14u3DlK3bgvjBf7oDBGx4oGa/E1tFcApuVq8PJ4xHGOYsrXwOUmFWi6C/SJlr0smXZ/HM2qw6C1MN0PFLfGfN4oxejuLejjX/89qort/cDVz3gmuY1nC5P7xzD6Sac/Ky42oAz4uQ2FAc89d48T8v04KplSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707867997; c=relaxed/simple;
	bh=eXW509IpoIxVG4spuImSGkWb97Ejw1GnKstmwiIBaOs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=puvlvbS1icnFF7Ih4/RV99p8zVZ88lmm0rsOO1Xz/ranooqhvwnCG85ZM+4Wl7Sjt6bCUikDZcWtGpeQrJDfFvh+mS+nqi+aCVX5w9ckCAaXijp5vizkWue7vPD4qKlHpKvC+SgtpN2VFI1J0/QptJCrPF544uUepIEhhSUL4/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zy7Yt7Ro; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5d8ddbac4fbso4274447a12.0;
        Tue, 13 Feb 2024 15:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707867994; x=1708472794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Y0qMZ0nrbVy37Y2FDCLo3vG8NlDCzXNPpgVoE/GIAF4=;
        b=Zy7Yt7RoCasb3sNdNgc9QaZcOZOGs8C4nlmzpfXn7kbok4udYr3VQemuqkULX+/N7W
         S09pL1zOl35AKGZUod3WLydIdptbimpeOwhlp8GgTSFZFOdFwA8xiF+tMsjosQvKhLUd
         NDzrxSXXBUb3/cdSsM78ouQrvzUcWwROC7MK03jGZoxn9B8CdowyW83huUb5uU9pfvgb
         gat54kYrlc0jJ/LjMS83jyYgXcaKMJ3G+nkB4yhl+zzZcijwF7+48XyTWbCHsrUHe7wJ
         YCZVtiBMswk73vaJFHPZMyapjCAGH4Qe6EuPqxPv0RTINECAFsIQtgxmui62udzQJ3Ca
         gy4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707867994; x=1708472794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0qMZ0nrbVy37Y2FDCLo3vG8NlDCzXNPpgVoE/GIAF4=;
        b=ooSqy/251b055P2FweaMmIKgcjtxwGmb40XWb30wYS02e84Oer3MU8zXXvxVShCNyR
         yTgWZYTzCL9hkN2kcwvOtfaUj1k1Xb4uIbgWTtgpOGbflkb0ZqX48wm5b2H2DQD2w/71
         rNMPSJaeNmyxERmIZ+T8e+V2+HfIjBQuyh+REKqTJkDGgxzcgUf1nY3OCKOg9oEEvFO0
         vIvUyCl8zlpfN5rc1FOX6Edm9oTEHlQpyEEl1awJ26WixIDnYotsgrHURmQbVU8FCxhD
         zW2bCekPAJg8q5CE9A2NPYPYON46ms6wacpctqgHxvdLeS2LHN+6hCrDMNuaYjVO/83z
         dNPg==
X-Forwarded-Encrypted: i=1; AJvYcCW1ZUL1cSVvCRMAysP32MaJbdGKWzviXmCMNCKjTc6lzw4Ji4z/iQ1RW3QX+kowYGrKfhZvqnwmGgBS9FVvxxsHrFD2JG9MhEy1mvQf7iCShkzIyxdUC/8rR1R1n26tQDJjnHamcxRfnr4w
X-Gm-Message-State: AOJu0YzQEa0lrgVl8yRuBDxynXxuleYdmH5l5JvmLxKZEB+4FGHkfqwm
	quF2HFpuQPiNl61XrXeoGkkGqXh1idHbBxpBQ3mvCOfiJsaDRkFg
X-Google-Smtp-Source: AGHT+IHAfeC+EMKl0f7Hf5/ws+tXFhzAHvg1yzRbxMLDM3xOaOVhhSRquqILMNfzACnQzNn2d2mCjw==
X-Received: by 2002:a05:6a20:c78c:b0:19e:9a97:cb12 with SMTP id hk12-20020a056a20c78c00b0019e9a97cb12mr1069227pzb.54.1707867994400;
        Tue, 13 Feb 2024 15:46:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV1OZHNSApLabiLUWqVK2dewixlUKdn05ckmgnjatwWggZb1EDoWiFzdUUDHdrBHFyUpi0IEWXdu1/FzVR8SaJkdrfmdbfbdU+W9FnH5LOfP9OnCaEQkMffX2mbzWiceWZ9uFObtuUyC14a0bhlwmCFH9fGamggdG6abSAKmMe7VXoWUo7Q7cZ58dwHjq/ppcd6qWmBaFTKj6O44Ey9XSWSWdzIEv3IbGvV
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v11-20020a056a00148b00b006e0334e3dd9sm7864447pfu.76.2024.02.13.15.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 15:46:33 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Helge Deller <deller@gmx.de>
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH] parisc: Fix csum_ipv6_magic on 64-bit systems
Date: Tue, 13 Feb 2024 15:46:31 -0800
Message-Id: <20240213234631.940055-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hppa 64-bit systems calculates the IPv6 checksum using 64-bit add
operations. The last add folds protocol and length fields into the 64-bit
result. While unlikely, this operation can overflow. The overflow can be
triggered with a code sequence such as the following.

	/* try to trigger massive overflows */
	memset(tmp_buf, 0xff, sizeof(struct in6_addr));
	csum_result = csum_ipv6_magic((struct in6_addr *)tmp_buf,
				      (struct in6_addr *)tmp_buf,
				      0xffff, 0xff, 0xffffffff);

Fix the problem by adding any overflows from the final add operation into
the calculated checksum. Fortunately, we can do this without additional
cost by replacing the add operation used to fold the checksum into 32 bit
with "add,dc" to add in the missing carry.

Cc: Charlie Jenkins <charlie@rivosinc.com>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
This patch does not completely fix the problems with csum_ipv6_magic seen
when running 64-bit parisc images with the C3700 emulation in qemu. That
is due to unaligned 64-bit load operations which (presumably as part of
unaligned trap handling) generate bad carry flags. It is unknown if that
is a problem with the qemu emulation or with the Linux kernel, so it is not
addressed here.

 arch/parisc/include/asm/checksum.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/parisc/include/asm/checksum.h b/arch/parisc/include/asm/checksum.h
index e619e67440db..c949aa20fa16 100644
--- a/arch/parisc/include/asm/checksum.h
+++ b/arch/parisc/include/asm/checksum.h
@@ -137,8 +137,8 @@ static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 "	add,dc		%3, %0, %0\n"  /* fold in proto+len | carry bit */
 "	extrd,u		%0, 31, 32, %4\n"/* copy upper half down */
 "	depdi		0, 31, 32, %0\n"/* clear upper half */
-"	add		%4, %0, %0\n"	/* fold into 32-bits */
-"	addc		0, %0, %0\n"	/* add carry */
+"	add,dc		%4, %0, %0\n"	/* fold into 32-bits, plus carry */
+"	addc		0, %0, %0\n"	/* add final carry */
 
 #else
 
-- 
2.39.2


