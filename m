Return-Path: <linux-kernel+bounces-141870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F188A246C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A18ACB21019
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2024517731;
	Fri, 12 Apr 2024 03:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M2bf9ob+"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3611010A24;
	Fri, 12 Apr 2024 03:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712892607; cv=none; b=YuKqs3sb02eSopjmNdfOtXduGX13jTu6uggUabV4Cv9iiqmuYwsWE4KBStAPpAY0/9cC0mxZ2ydQ29sKd3uJcowR6b/LjVw/IPUwvdkYNlfeMhHAQXFiQiThqoJwTQ5om9poIbH8QJWnUrN1kJjbPWljyBSlbpvHiQVD4RgyRbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712892607; c=relaxed/simple;
	bh=0FE7ZZ0q2OwnDOATxKqkxrKnMGTlyV/klncgByuwXfE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TFiBcb70GJHDqf2xefzOu0JJXtNWd/Vu2TD2ZSywzXwLseL3q4Bs/SusRylXgmYMZ5wAE9GvmhXjNuzsUS/J7UK/Y/aCTFDbX2pZaVYqUJojx+71+hTkpUZRZO2fwmXLA2nE85QWNGsLD2iyqJ1GImGXNevbDEmKEI8Ql27Qd5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M2bf9ob+; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5ce2aada130so361426a12.1;
        Thu, 11 Apr 2024 20:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712892605; x=1713497405; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MahGK5AhKSVTA/Sn1c+ldMSf99A3o38T7tu0F0YfQQk=;
        b=M2bf9ob+4BrHxun0MNbnUGFAR5vx+BWGiZEbExyJmr7oNu5cDNMEV5m7vjBolRW0no
         shsYSmxcwRxY8tcMPNjAjH21aTjyOnKtmgxr2pfIdzRdwPaUHkBJqvKY2v8CnPQNYSZz
         t1YprBh52q8uZcDQrwiEq+gdPmc7iz4v/jDfGqjlGwYfAXsjg1gzqcDG+j5TbsZTUwCg
         EYkjwK7TnCNcozB6OGbpKeXXH30z2+GUU1T2/VfL3q/LsIgz8nx36bul2O0ni0IsdKkq
         l5py6oh1zKIhMOHZo7x79dJABN/WoClUORYndH598a8BuY5Ff5EZKvztw4IyVZmgHjyJ
         GEeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712892605; x=1713497405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MahGK5AhKSVTA/Sn1c+ldMSf99A3o38T7tu0F0YfQQk=;
        b=V0z+8z5nie7ojLTqL+BbnlKu32fM0pSk4rB3aFnwO3DjkCqkjxR+FACDYFbJFPCbr5
         Mt7FS3cpIPxQLeCLNPsrm6vyycyZkwtJZoL6cLbb6corHEpcOXebBR2K2qDcp5bTkK/Y
         oPqx3kRl6YhAkhNzO740HhLokJVGaDDTMwP8d/1yuAfex0BdwKUf0M/f5efBaajHOFfQ
         G/DODS5XxEBYBKyNeVOV13o+3eFVflO2zvVGWioEpTKy1r2ylUkWeb8/MsUJ59eBzcKw
         U6EcmBe61F2+3ZKg8tAOu2UbLRBUmOT1/XcSO0MBH4teykBZYG9sP+OdDVX1nauG38hs
         jhtQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzFreG9Z94bsoSw+yW7BH/sOav8OJcqJdzO+hqGBlr51dEcyRaYnQZ6GgDEuGxwva+1g3TiC78QENaGI74CE7euTlZ3WrdxhPcgFFiWU1OKX+EFRdHjTwjBdF7FcDbuugxWZhG64WUOa5pmFbYc5h3
X-Gm-Message-State: AOJu0YzF8zbfDL/IEiAvtozhOdiR4ipRtdB7vTeZ5lroDcBH/qOxseNQ
	teJi/PrmgNavttSNUM2W6XoOcYU25g2CYxNzhEw1hLgex06oef2y
X-Google-Smtp-Source: AGHT+IG79Aswokc9JNZ0asQJOrImcIU14MDWRvfD7gvVqIWpEyW1OHU61mBS5rCnSSYUnOV7vF1JIA==
X-Received: by 2002:a17:90a:1c97:b0:2a2:4135:5310 with SMTP id t23-20020a17090a1c9700b002a241355310mr1324609pjt.12.1712892605368;
        Thu, 11 Apr 2024 20:30:05 -0700 (PDT)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id i20-20020a632214000000b005cd835182c5sm1782142pgi.79.2024.04.11.20.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 20:30:05 -0700 (PDT)
From: Yuntao Wang <ytcoode@gmail.com>
To: mhiramat@kernel.org
Cc: akpm@linux-foundation.org,
	arnd@arndb.de,
	changbin.du@huawei.com,
	christophe.leroy@csgroup.eu,
	geert@linux-m68k.org,
	jpoimboe@kernel.org,
	kjlx@templeofstupid.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	ndesaulniers@google.com,
	peterz@infradead.org,
	tglx@linutronix.de,
	tj@kernel.org,
	ytcoode@gmail.com
Subject: [PATCH v2] init/main.c: Remove redundant space from saved_command_line
Date: Fri, 12 Apr 2024 11:29:50 +0800
Message-ID: <20240412032950.12687-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412080839.c903a0058bd6594d31bc1d3e@kernel.org>
References: <20240412080839.c903a0058bd6594d31bc1d3e@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is a space at the end of extra_init_args. In the current logic,
copying extra_init_args to saved_command_line will cause extra spaces
in saved_command_line here or there. Remove the trailing space from
extra_init_args to make the string in saved_command_line look more perfect.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
v1 -> v2: Fix the issue using the method suggested by Masami

 init/main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/init/main.c b/init/main.c
index 881f6230ee59..0f03dd15e0e2 100644
--- a/init/main.c
+++ b/init/main.c
@@ -627,8 +627,10 @@ static void __init setup_command_line(char *command_line)
 
 	if (extra_command_line)
 		xlen = strlen(extra_command_line);
-	if (extra_init_args)
+	if (extra_init_args) {
+		extra_init_args = strim(extra_init_args); /* remove trailing space */
 		ilen = strlen(extra_init_args) + 4; /* for " -- " */
+	}
 
 	len = xlen + strlen(boot_command_line) + 1;
 
-- 
2.44.0


