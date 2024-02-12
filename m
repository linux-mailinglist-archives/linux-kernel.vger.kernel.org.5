Return-Path: <linux-kernel+bounces-62305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0C2851E54
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1F261C2298F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFCDA4CB22;
	Mon, 12 Feb 2024 20:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="QytN18AT"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA254C61B
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 20:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707768278; cv=none; b=RX75WYMqAKW5jvKuTHimZTN9qY7jvwZTkZBpE2k7NmsTMfr9QGMVlR1UqbcX4kHTDFdAw2WDNp3AQsmu/Q9SUv+3V5YCh29JJyFudYu1FAjXngMWsvMgX5mrYM1QaOLt3frK53lvN6c9FXxfwgOJ5zq1dOxLa/jGyoNtbCGFn0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707768278; c=relaxed/simple;
	bh=0dAO+EHiuSLBj8m4VZ3xVszabZA/PMRk3GFVh4R9llo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g37q9ErbNa82ncK5zOmRG9wyQc0C0vMLOUbsCvcpYoYPHtbnYFFCbBXzT68tETmrB0YSmdUV+fmOuCmdTDCfSGPdWLDzLtGfshNsu5dnySjTRxXAXE+/mp+QmSOhUsllEUAPz597eGDKBugHtIzCW17gDJ5mZYUhu+fRreEoHKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=QytN18AT; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5d8b519e438so135993a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 12:04:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707768276; x=1708373076;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WXWSV+y18LZ5HLeeHfMaArrF2sqw5eZ12bKConVfkds=;
        b=XuaMI+w7me3rwPeUgOuhopzg1+xYHF/ZeMw2H7CC5KidCNpshI4X7EhYKYAAdSvdIl
         y388OKKXbN2cAfvxE4Ks1bEKrtV77MpRJ0fS3TBLCZ3lfSwWCzKA5gK9MknaWAYD5Iug
         WVF3TGZYPBTNrAaLe3X/eB2Ujs+5uriYwCeRGIBGQa03j7hid8lnxaXLIElkusA0VCWP
         PU5iwplImv6zP6wjRVFlTV00BMnHaydoNVdkwOPBTOwqQGTFG13yfZYsYUoh2lAU4gnk
         6jECtgcLCTGpJv18WPf6qA+Bq7tV+S9DbQpES8IDhUfzqY8UC5Jakjma5ORaWb+Dh7yE
         9drw==
X-Forwarded-Encrypted: i=1; AJvYcCWp9jVyzoA9EADGtNVoboGEmOsnE6R0Ga+jnxC180V/RjNjB109nkdh2HmTa+pPbeQIf9uh2csdOBxnWFhNkzEsHi9+Jq5yl54yXsXw
X-Gm-Message-State: AOJu0Yx9GGqTVH1GOgJYhTLyyR9r8ZdLQlMlGQUNYdLk5iPeeKQ3bUk8
	BZvpXQ8nG58kOr3hEnJX5Ctxh20+2n9LHX9zMkEBtYedueLiWaoQ
X-Google-Smtp-Source: AGHT+IGMrjwNl1612w0C9k06Puy+10fyLLKUAUNnYXIv9184Riy86C1Og1UKfJZoYAUrTM+Lkplx8w==
X-Received: by 2002:a17:903:230b:b0:1d9:40f3:ada8 with SMTP id d11-20020a170903230b00b001d940f3ada8mr8856086plh.3.1707768275779;
        Mon, 12 Feb 2024 12:04:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUDHjxpA0uU3XGvuzhI5SZIquSVLx1zmfFKybGvheSex+hPZy/JzWjZ7CTiIwYLPLehe0po1yJVJC+qBzUb596l742Nkw3KRlh3qazWfWfyUohTv9MGhO+dbyCHa6MnzupDF6nm3JvKh8Ci7crYGe3QSBM9XUHC0Ni5r37pSz/LNHUA3EQt803b9wkUQIPqiPvg1Gul5BTtJgS/Gk4Ub1tbfT/py/ThCrx4v5Z+2eQY1nWr4mA8taDd8P1h6mHV+AkpU960x3GjVIntAmC1
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id ld16-20020a170902fad000b001d70c6d40f3sm704783plb.237.2024.02.12.12.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 12:04:35 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707768274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WXWSV+y18LZ5HLeeHfMaArrF2sqw5eZ12bKConVfkds=;
	b=QytN18ATL8fKnUEP2ncuOPGuiXEIsGGbkVZ6wJhrjBcmLZmNTLs/hIJyiHTWkr2hyZt81s
	5pmTK4iknYS51FMajxkKa9HQcswI1uO6at9zJuVR5N0bJdVftvWgO7WGc7qn/sLtcz8YlC
	TNtn0/iQBImF0B25aCCBWx+X1mWYvGkw3qWmK1wqvnfVigcPUaXdi/1Dmx/9BO+Yz8Q3l4
	Y6nRPb7hLuw7QM6ufoFBTuvf/mKGotBW07erL1H3JFiQeJJrPrGGAvAfVxnHrUvYn5qjg4
	GU7VoCVqIAdhsppoD9KXGJe1gB8mog4q3L/WD2HAgAZ/R1LjhWZa0PRJM+AAew==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Mon, 12 Feb 2024 17:05:01 -0300
Subject: [PATCH v2 3/5] powerpc: mpic: make mpic_subsys const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-bus_cleanup-powerpc2-v2-3-8441b3f77827@marliere.net>
References: <20240212-bus_cleanup-powerpc2-v2-0-8441b3f77827@marliere.net>
In-Reply-To: <20240212-bus_cleanup-powerpc2-v2-0-8441b3f77827@marliere.net>
To: Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1352; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=0dAO+EHiuSLBj8m4VZ3xVszabZA/PMRk3GFVh4R9llo=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlynnutnni9XUVE9ggMNrQa0bFx3O0p8SdcpMnT
 bc4vf6TJT2JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZcp57gAKCRDJC4p8Y4ZY
 pjVVD/4nYBGZn22+WZU78auZCxMYQWDaHW9MiL8IaAxdjcjFLzfkLKAjb5ss+BIQ7Mqu11gKx+K
 VXEWgxDmIbpAuJpsxSlljamuz00Mjf0+Dx6tP5CyVBLesDUyE0DgAYa+5fGQpLj3QpDhZsMuWz8
 LyRMpA7WcmmOf8p0hGvx4V4qq7qa2KFWitkKeIwaOdNVI6syzYPkvNhjkR1Wci9jjHk7Kde4cfo
 zos7RaoLqbd0DgIc1CPIKOeOtF2xQdCMcn91M7vKvXLgzsDfrJ9x2SjeHHOKMRTkaCjwq8nzPyi
 mbfv7xaccaEFdhjzOSB/FLCf5SNgHyHOiESuhqOdjj66yvtw+5YZfBOyrfpculJ2lOO5H9mzlib
 l1MGtq0uOA8WMrVi71TYlX2NutQBmqoWCaZHknJigYm6zMrtk8LOc/v7rPBiy5o3oO6XF4lhO/d
 IqHkqluyASaq+luXDw1jqu+Fl69wepx6Hv2UDSi3CXohCaz7BUwdqs6Y6AkMS+a0Sa2Llr1cvex
 ypVfDu6UKs09/okvR2aFne7wcvtEQXpWxLkueA6PFSzpxyJLcgXr6WHPf/2xGZMATf/p+eCxeU1
 GdmUtxO0L2sPy7cHh/6f0KnRFGVg4a7cHWOSp++wKy3vmODpIydvixJrk4y4OqGrWriPzFG3Kr1
 VkRPilS+S4Yn7Ww==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit d492cc2573a0 ("driver core: device.h: make struct
bus_type a const *"), the driver core can properly handle constant
struct bus_type, move the mpic_subsys variable to be a constant
structure as well, placing it into read-only memory which can not be
modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 arch/powerpc/include/asm/mpic.h | 2 +-
 arch/powerpc/sysdev/mpic.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/mpic.h b/arch/powerpc/include/asm/mpic.h
index 58353c5bd3fb..0c03a98986cd 100644
--- a/arch/powerpc/include/asm/mpic.h
+++ b/arch/powerpc/include/asm/mpic.h
@@ -336,7 +336,7 @@ struct mpic
 #endif
 };
 
-extern struct bus_type mpic_subsys;
+extern const struct bus_type mpic_subsys;
 
 /*
  * MPIC flags (passed to mpic_alloc)
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index dabbdd356664..d94cf36b0f65 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -49,7 +49,7 @@
 #define DBG(fmt...)
 #endif
 
-struct bus_type mpic_subsys = {
+const struct bus_type mpic_subsys = {
 	.name = "mpic",
 	.dev_name = "mpic",
 };

-- 
2.43.0


