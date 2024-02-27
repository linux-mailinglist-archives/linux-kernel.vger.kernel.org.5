Return-Path: <linux-kernel+bounces-83980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B99F586A0E5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 746D32879FF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0DE14D44A;
	Tue, 27 Feb 2024 20:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m1SvBTmr"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2F04DA0C;
	Tue, 27 Feb 2024 20:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709066038; cv=none; b=W+bUeq2C/+tjmmxpgQa60f9pjk+pymmObhEnZ0xy+SAL/6RfuB0/imjO0OHISCN6hCBIHmnH2odqr93WBMwfSDAZjzAM7zIAruT0I/NGuBOzOtg5UUd+e96XOVU1i95Lk7vydiS5FuYP4USNLBSDYqFMn4mRkUq6Sl2jk+75Ca8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709066038; c=relaxed/simple;
	bh=vd+TyTSWQWOfYY26tKvy0OG6e8JjBYLWstVKW/u4Ebg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BaGwKBkugnUnvCrqp9iyO4ky+CJZziZSnX+QSouos8z55hwhb2cETsO9j0zEWAkRyhWGU9wmJTW0YVZyH2OTMDsZpJmGboVYuEW+bbrSQ0YsiJzGMtOOfDBNNvTKvQRNRQLqi+As4lfcPhYrfeQfMIq0HRMMGGCvFitzdusQ9pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m1SvBTmr; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1db6e0996ceso35312495ad.2;
        Tue, 27 Feb 2024 12:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709066036; x=1709670836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=VmNpj3QbyAWLz70sR9q5u6BAhTl239U+KB2ZQ1R5C38=;
        b=m1SvBTmrWjETUJdQBwe55tCx7SZEhVWLaoqq1GORDMN2zkuH8ZO+mdmzKyoq+Z/1gP
         OAXc7DZ1XwAI8NoUzB0jSBKm2i5PZiEJUvLGUWkAYxkqu4DyWgTNqfDEP/e9rsWxYgBu
         VIBF//wHva/LmDYPRA71/qE5lcj9PL27AeRoNPZJpmPXWa1kQLpAqVsGyUkPUbV/eXk4
         1PjJ6WzEmXpqlj1rJqSatXVtmS0hZe0KZT8lh1FYSkX7SpQy/I1wmrpDOvRef/YSndRN
         T3RIpDAn43cv+UmpoCGa6vAf9to1FWOQRSAiWBaejqVb77wLxfm3/Kizr7G3DdFsG2Ri
         OVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709066036; x=1709670836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VmNpj3QbyAWLz70sR9q5u6BAhTl239U+KB2ZQ1R5C38=;
        b=HGXy6Vw10TfKPydiDqJ0EXPQxO13lOGBa8OcH9afZXrdc9A3WyBMoBU0tFYdD/hQjy
         QkcoULwZhDML8vYa18BVdcY5oNBCFEk6rRSS5HQDcX7kK10m/Wvbz+XjVAI1YzHKW8Ov
         nog4mnIyG4BwaeEm5z1nJ5LsE5EKiggu9+YgAdZvOPQOwiRJoM7mWO5dmMpvgrnrol7I
         00K5SnKuWBW0BfkheQbuSPGb00yf0XvAeJLViJxEQVKuMmEK9s+KJ7Rs6Bt/OOSStYmO
         qB2qxNUtMbsjQNGFBozobASeXBx1DjKQPHXKEw63JOmVQ1gSTinF6fJUjil+/LO19PIM
         GAvg==
X-Forwarded-Encrypted: i=1; AJvYcCWRVOqa80taZ1bOSWZLfZXX8kMJxajaIu8ZWp8t9+AsUWN8SNYbg1ipmTiCP/UVQ9vWllFZzl2tg+5sMO5siubhtWzkGI8sW3QhGRib+SXOi/34kivjChX/OvviopotMQ9sE8h0B6S0/fgP
X-Gm-Message-State: AOJu0Yw6Wp7r0sB/BskdR5raMjocx6+Nq7OR8o44q34wtDbZ0qTeK+/L
	pGBIrOq0krG7GsYD5O/ECZzVVHaw/60DNT2ZZ1i7BfAy10rzPu1b
X-Google-Smtp-Source: AGHT+IHRyQVYnAty4uYr78Sk5lXdwaAQLFd/+Pa3xQZ2mePuvue4g9fzI/EOjzMI21x9zCB4vhQCeA==
X-Received: by 2002:a17:902:f688:b0:1dc:3d5:bdcc with SMTP id l8-20020a170902f68800b001dc03d5bdccmr13443056plg.42.1709066035823;
        Tue, 27 Feb 2024 12:33:55 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w23-20020a1709027b9700b001db5241804csm1941363pll.20.2024.02.27.12.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 12:33:55 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Helge Deller <deller@gmx.de>
Cc: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2] parisc: Strip upper 32 bit of sum in csum_ipv6_magic for 64-bit builds
Date: Tue, 27 Feb 2024 12:33:51 -0800
Message-Id: <20240227203351.3445929-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IPv6 checksum tests with unaligned addresses on 64-bit builds result
in unexpected failures.

Expected expected == csum_result, but
    expected == 46591 (0xb5ff)
    csum_result == 46381 (0xb52d)
with alignment offset 1

Oddly enough, the problem disappeared after adding test code into
the beginning of csum_ipv6_magic().

As it turns out, the 'sum' parameter of csum_ipv6_magic() is declared as
__wsum, which is a 32-bit variable. However, it is treated as 64-bit
variable in the 64-bit assembler code. Tests showed that the upper 32 bit
of the register used to pass the variable are _not_ cleared when entering
the function. This can result in checksum calculation errors.

Clearing the upper 32 bit of 'sum' as first operation in the assembler
code fixes the problem.

Acked-by: Helge Deller <deller@gmx.de>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Updated subject, clarified that the problem only affects 64-bit builds,
    added Helge's Acked-by: tag.

 arch/parisc/include/asm/checksum.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/parisc/include/asm/checksum.h b/arch/parisc/include/asm/checksum.h
index c949aa20fa16..2aceebcd695c 100644
--- a/arch/parisc/include/asm/checksum.h
+++ b/arch/parisc/include/asm/checksum.h
@@ -126,6 +126,7 @@ static __inline__ __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
 	** Try to keep 4 registers with "live" values ahead of the ALU.
 	*/
 
+"	depdi		0, 31, 32, %0\n"/* clear upper half of incoming checksum */
 "	ldd,ma		8(%1), %4\n"	/* get 1st saddr word */
 "	ldd,ma		8(%2), %5\n"	/* get 1st daddr word */
 "	add		%4, %0, %0\n"
-- 
2.39.2


