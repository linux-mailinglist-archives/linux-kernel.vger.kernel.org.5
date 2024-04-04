Return-Path: <linux-kernel+bounces-131069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A62588982B0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08270B22FB1
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 08:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD745D8EB;
	Thu,  4 Apr 2024 08:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="Dn3azvWb"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF0F5DF23
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 08:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712217675; cv=none; b=RGGZNaqhX1G1kys7nsTIltlV02JLjgEoKuKGRhnGJT/CkA/rmSDrTb46h3dliedUrsckEZ3QYPtL0XodNCLmE67IdmgZExzdwUAt8JDqtFuy+PjTeHCVYtGHDCK4DI2W3UnDR0HFDQfbnS0523eiNeGve12ZrsP+cwk6O5FlrD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712217675; c=relaxed/simple;
	bh=QJ/GvWjb7OikBvvYJpHNtU5PYtM/0hhzpUz62Zhr5IU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yv/eWBOaofA9a/RQxHRXIBanSwKeeXeTeBIJhNpNeGr9XsG2avHXa9xU2EL0l0LMHbdi7+AYpjRnpuWLq4H+qQTPBvUpqYs8FLA6jgSYWD9dMLPoOg0lpLl73PMal+GVlNExNuyhTLufJS9q+2sgoS1YXkf2vA+F9YTwr5QaW9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=Dn3azvWb; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56bf6591865so939837a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 01:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1712217672; x=1712822472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xv8R3IrhUaaiihMPdgbzD/Fg2YiT2HLoLPB2jJluhQk=;
        b=Dn3azvWbj0P8Ck27vJgjnmhTFSKldKYdM4gZEB4thWRHTHO6NeRZJ8QpjFiSwKN20P
         Ek336C706THQwwpiJ6snnG36hcP1CRDS+QSX/ZRBYyAbYQHcON93ljL3cKO4Zu07O1jw
         yExQaHADM/ZRniVZCg+g4qnIWeGSSeIXktF1mnYyM7HwsyhFBAok8CxkGdkibShxWzCa
         KNiXs82OQillF6Vs8xtGxvyJvAj/KRdr3zaXoPWDiFkj1wVfqlbH+3DTDhNVNFJNtm1p
         G/ykNLfkhBuQ5IQfTpuOLaCa0rLSVLQzPcoSF3mHtf8tfXMOxAFB8IMZnDb2riUBnmqS
         fJjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712217672; x=1712822472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xv8R3IrhUaaiihMPdgbzD/Fg2YiT2HLoLPB2jJluhQk=;
        b=kAD91A03JYZ1uueW+K4ZhFRA+hLlLxTVS073T2Z0LkZCmFTE/ZI8PfWu6gz9UZCXf/
         wT7ln5DQ0ID1rwJs2R3HEFokP7ziYVGGoV261DgJa+gQqyAlon+dlcuat8hrEOuoVGQt
         GxcUcgxQuZJ2zuGKIlB/W1qunu5RTWuToqCbEnOQXb9gCjpctXguhY2yM2QXB/ILtme4
         5vB/A4mFrR4dttD24aO0T22oU7KKVBPZATm7PujB7MyCkRe4IXU9kfM3q1blVwEwz1Oa
         daxKLCvlToPW+wH1kOFrHw6L77XX7IunhwhVLiAW8RnXf/QomDkx7r8uSBRMSAyXrGST
         pZKw==
X-Forwarded-Encrypted: i=1; AJvYcCUFdfjP4Mea3jfVoX5H7Mv+5Iv3dpnaUbXe6J6iRZ9c2fuFHrYtoAdjbMZDuUSSWuEtO8Eyaa7guVePhF4Qk+N/BZYmxZRBT9oERBTS
X-Gm-Message-State: AOJu0YxS4Zgld+J5QP9/FoIGxyx69JKZqg8+29OlDHENBeZyQ3zweI2/
	vInWYZuv0ptX1M/zbyEaJbmnpFYt4pr6uobR3E46WwccUbn2LdYSAhA4dcgc6Ko=
X-Google-Smtp-Source: AGHT+IEQQDX7G43C5KmJflK3VEIWNWAS7ktsRAeYWb2ozLpk/ugg7MgwS4QMOHuKzIeKgxoa7JkVIg==
X-Received: by 2002:a50:c315:0:b0:56b:9ef8:f656 with SMTP id a21-20020a50c315000000b0056b9ef8f656mr1125320edb.7.1712217671985;
        Thu, 04 Apr 2024 01:01:11 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id k3-20020a056402340300b0056e06d5a301sm1681791edc.20.2024.04.04.01.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 01:01:11 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: jirislaby@kernel.org
Cc: chris@zankel.net,
	gregkh@linuxfoundation.org,
	jcmvbkbc@gmail.com,
	linux-kernel@vger.kernel.org,
	thorsten.blum@toblux.com
Subject: [PATCH v3] tty: xtensa/iss: Use min() to fix Coccinelle warning
Date: Thu,  4 Apr 2024 09:58:13 +0200
Message-ID: <20240404075811.6936-3-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <528c6824-287e-4be2-82f3-7fcdd254eb15@kernel.org>
References: <528c6824-287e-4be2-82f3-7fcdd254eb15@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Inline strlen() and use min() to fix the following Coccinelle/coccicheck
warning reported by minmax.cocci:

	WARNING opportunity for min()

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
Changes in v2:
- Use min() instead of umin() as suggested by Jiri Slaby

Changes in v3:
- Inline strlen() as suggested by Jiri Slaby
---
 arch/xtensa/platforms/iss/console.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/xtensa/platforms/iss/console.c b/arch/xtensa/platforms/iss/console.c
index 8896e691c051..abec44b687df 100644
--- a/arch/xtensa/platforms/iss/console.c
+++ b/arch/xtensa/platforms/iss/console.c
@@ -166,10 +166,8 @@ late_initcall(rs_init);
 
 static void iss_console_write(struct console *co, const char *s, unsigned count)
 {
-	if (s && *s != 0) {
-		int len = strlen(s);
-		simc_write(1, s, count < len ? count : len);
-	}
+	if (s && *s != 0)
+		simc_write(1, s, min(count, strlen(s)));
 }
 
 static struct tty_driver* iss_console_device(struct console *c, int *index)
-- 
2.44.0


