Return-Path: <linux-kernel+bounces-142222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A884C8A2919
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ECAA286298
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F13ED50298;
	Fri, 12 Apr 2024 08:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CvhTx87m"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A99750281
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 08:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712909902; cv=none; b=os8qAjElrv6qv+t6n7k6WiNpU1T+TwDkYa5TvjORCThpKuzaZYshZSWSMPhLSKv2D+D6e4S4UQaEm4aWjW2tD+kvTlpeJImtyN5xmhRRn3tcPqGOR5BOClsxzYFuPhClQPE/A1Rj50ePRiHainrZ1Nimbda5qlQflEyuxbndE9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712909902; c=relaxed/simple;
	bh=O4sSaXp+ZDTJnVTQLLWMUtAcAU7KxZl+BWsdAjRQWok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AoxODEVeq0yjxn6f6GO+NzPoh1Y77xOYLvt08iSRJeqtxXdEFWjNQ03IX+HLg3yKW8WMlfb42Ot1drDSFnzQdtJ4C4kyeDmtLChT0r9IDSypFmMpeN0h9JgiESW3VrOIdCrmw3YRk3j2iqrfQZmO9aP3M0DkQZ6owL9NjfzL/S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CvhTx87m; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5aa2bd6f651so509824eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 01:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712909900; x=1713514700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yu+6WxodjHSBLVJ4vTIVXBoPSo2RTNoZ1skXMjVRPl8=;
        b=CvhTx87mqvefiiglmF3X2+3hYTPRY5sXcdoZAM5pwzbVUZlnPJO3zlI0ZSwk0+TnqT
         UWK6nxUTnamhRfcFukid9xgAGUdErdZR1W0HBGjbIq9kZd3eaDAYdZzGP2SpQP7C/uiZ
         ufes9LmSDltX1bSwZoYQ/naZR0H4Z2tFyrGJoOJiY8I9pTu/ot6xPEBQPFYEM5pIvaGQ
         lV5QZ8msGTyixOncL0svJ88X7rp/hhRWIZ6ZVqDgxsjPH0tLnkRD1SbYyGysUwsO8Hid
         TBjtOA0eTZ7rcoXPZLBQFi5qhqs96q7PXlz/lZv5Xn/IoZjK8IZZlVNMhrMRGw86xZa2
         boFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712909900; x=1713514700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yu+6WxodjHSBLVJ4vTIVXBoPSo2RTNoZ1skXMjVRPl8=;
        b=L3snzE1B5AOQXBUwRVKWw+UqhpZIVDcTuEQS+az/x/+5O3v6N2UI0owMI8bdGF1E6k
         ZjJOz6gIWQJ/CV5stgAhpknhRluOd29oqr27tMPAfhL6874k+nQ3nkTWQqE21yVLwkX/
         FgTqQ2Jy9S+VO7dtbbZ6n6IY2/EJwPxlfELBZjalObUhR0mUuoQ2HWj3i2646zdB537o
         5AvAs6QIagItkjCUU7ZqRCGnEnYB0WcCk8DDGaKKMpozNSxsQ4izomVeih+P2dg/ux+Q
         /2q0HZjbaSVxOWJxT0PVVkx2VJsOOuHF1wC/ZouDAfVfjxE70UwMlmOmaxEFyodbkn6A
         CHzw==
X-Forwarded-Encrypted: i=1; AJvYcCUckU7zUwG1UYCQWAi5UnZQueH3MGIiU+IBvPLgEd6wgVG0m4q85+v5Dgq0YonqUtsD18BiuRGbG/teMulXEFvnmyZLa5RWbU7T5uK0
X-Gm-Message-State: AOJu0YxjN+L+loCjQtF8Ug6VCUlNAFNT3ZuC3HI9ThrODqzoL4O+rL1y
	grddrDyE89kf9A6s/d7xQ2QouCT4UoLaXbSNTg7k8N6CnrqZEjbn
X-Google-Smtp-Source: AGHT+IHPMOMeaKbgliBIs0e3rosx5Q0nLFvvupxWwTmnqCoL/oPJAeUnRhfVTFd1ktSK6VSj5Z4a3g==
X-Received: by 2002:a05:6358:38d:b0:186:16ef:444 with SMTP id a13-20020a056358038d00b0018616ef0444mr2091677rwj.17.1712909900012;
        Fri, 12 Apr 2024 01:18:20 -0700 (PDT)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id i15-20020a63130f000000b005f43a5c4e7dsm2276393pgl.41.2024.04.12.01.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 01:18:19 -0700 (PDT)
From: Yuntao Wang <ytcoode@gmail.com>
To: mhiramat@kernel.org
Cc: akpm@linux-foundation.org,
	arnd@arndb.de,
	christophe.leroy@csgroup.eu,
	geert@linux-m68k.org,
	jpoimboe@kernel.org,
	kjlx@templeofstupid.com,
	linux-kernel@vger.kernel.org,
	ndesaulniers@google.com,
	peterz@infradead.org,
	rppt@kernel.org,
	tglx@linutronix.de,
	tj@kernel.org,
	ytcoode@gmail.com
Subject: [PATCH v2 2/2] init/main.c: Minor cleanup for the setup_command_line() function
Date: Fri, 12 Apr 2024 16:17:33 +0800
Message-ID: <20240412081733.35925-3-ytcoode@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412081733.35925-1-ytcoode@gmail.com>
References: <20240412141536.3f59fde391a6d28181562dbe@kernel.org>
 <20240412081733.35925-1-ytcoode@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is just a minor cleanup to make the code look a bit cleaner.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 init/main.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/init/main.c b/init/main.c
index 5dcf5274c09c..d6383e397e9f 100644
--- a/init/main.c
+++ b/init/main.c
@@ -630,11 +630,11 @@ static void __init setup_command_line(char *command_line)
 	if (extra_init_args)
 		ilen = strlen(extra_init_args) + 4; /* for " -- " */
 
-	len = xlen + strlen(boot_command_line) + 1;
+	len = xlen + strlen(boot_command_line) + ilen + 1;
 
-	saved_command_line = memblock_alloc(len + ilen, SMP_CACHE_BYTES);
+	saved_command_line = memblock_alloc(len, SMP_CACHE_BYTES);
 	if (!saved_command_line)
-		panic("%s: Failed to allocate %zu bytes\n", __func__, len + ilen);
+		panic("%s: Failed to allocate %zu bytes\n", __func__, len);
 
 	len = xlen + strlen(command_line) + 1;
 
-- 
2.44.0


