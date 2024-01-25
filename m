Return-Path: <linux-kernel+bounces-39118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF2D83CB09
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FE781C20BB0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B848C13664E;
	Thu, 25 Jan 2024 18:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXl3GIM/"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A56911339A3
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 18:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706207066; cv=none; b=q7STV2yWxHrpU6SbkG5mVTInwEKz9WoY4G1716g0o5QHdMu+d70OuHgiT8Sc+PLophHzj8KOGfs/7nxsdeIFEFwygaZZsjWft7EfN3nkU7tLRMMhmfC1uR5Bk7fBLAIdU1sgLJORNxFMrvccCcU5PFcys/vYG1EyE3Vbs6SVeTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706207066; c=relaxed/simple;
	bh=CnDhO4W6RhhnLUIQvYTJD8IqhmD1zLaX0PIGwd3eXqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CgMi3J0fh/GX7gfvrBRe245uK7ayIsFPSiYNJ9h6oVVHYjhFvhF3DHNQhc8w7gbrGdT7WyOev+DhRSrrcez7Qcwz0+EQlUKMWCw2BItNlYGFKFdU2Ayy9JGcSdlVBkDOtXWiBp/rZkQ0nzvu2pL10c46RHLLj/yt2nNgfDo2PvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXl3GIM/; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7831362c9bcso468549485a.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 10:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706207062; x=1706811862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QpjAVbS89bblqRKPmH6dCOipZUaPZaPPm0ofRTb7n/M=;
        b=EXl3GIM/iIIiyJBsxXmmRA4T93Rd0Ye1lrXiestHYTIbfkUOgjfrBk5gKSI2bCimJJ
         88HFsXVNBzmS0Nykism6g6wgznAcJ0+g3Ovwhs7Wd7q8l9whrlfeL8AR1PPCbaZROnGc
         RrujUjZRItmfa36CXHcgi94UiCWo4o0Oskq5n3TRjfnLfV2boKZMS9ZfLBow534islaD
         wgj9SRKs5vKqdB9/R4JGsdvfYcXovJF4T617ODCTtxmQSlxSffJzMITcmh5AJTTGfFMS
         lrmz8JguqSh8b1NWwSMNHLAw5u/6d/NfRivJIGZhcVd3FJvOTYAbPb7rfVI3wkWLc/JS
         KmOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706207062; x=1706811862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QpjAVbS89bblqRKPmH6dCOipZUaPZaPPm0ofRTb7n/M=;
        b=Z9oCZcT3ti6MuP3yijHT/8+QqxA55ywOlb7Prd8MjFq5QFEen1np4EzIzLy6bSiKT4
         beXzbiKHJDCpJ0dDTqIa/Xg1JcPe7sSXKVhdNAgGsnj7Z0zOmofJI3H8ECp+CDhazi0A
         WwTTIeYIWZgTNreKdOdigoBuCU1hqlk/rZgX+yCGGbEbGxCaGfR40+vNV2+pHcJaMyPx
         UykQnlk0lf0z+n+1PCkDUBkAX6+GpS8Rvf8rUksTZthKu5Q5s87TcWSv8fgNp/4QXtha
         LNJxqr0bX3OOZVhZtMvT/ZZ/DhtO1PW0RM67TTRG25Sn1VqywIjZHAteZS0U35o5TeDx
         WFJw==
X-Gm-Message-State: AOJu0YzcMYmxi27LcqnnisnyK/RJ3qa4mtT+IdcR36QaTGvEBbw7DhbD
	D68FCdETvVL7VzdWHkbtRUYzxARR2fT+P1V1B9w8H+g/q9EelP+EP2dDvkN/
X-Google-Smtp-Source: AGHT+IG0LMYny2GeC+0uxeMszMfSaq8oBpCcBsnVHzNd/o+SKpoPRIdqJIICsF7aEZ1b3Sn+Dudzbw==
X-Received: by 2002:a05:620a:390e:b0:783:26f3:939a with SMTP id qr14-20020a05620a390e00b0078326f3939amr119432qkn.119.1706207062569;
        Thu, 25 Jan 2024 10:24:22 -0800 (PST)
Received: from pm2-ws13.praxislan02.com (207-172-141-204.s8906.c3-0.slvr-cbr1.lnh-slvr.md.cable.rcncustomer.com. [207.172.141.204])
        by smtp.gmail.com with ESMTPSA id y9-20020a05620a44c900b007831f8c5aeasm5211694qkp.55.2024.01.25.10.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 10:24:22 -0800 (PST)
From: Jason Andryuk <jandryuk@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Jason Andryuk <jandryuk@gmail.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH] x86/mm/cpa-test: Correct length selection
Date: Thu, 25 Jan 2024 13:24:16 -0500
Message-ID: <20240125182417.51898-1-jandryuk@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The length of pages to modify corresponding to addr[i] is given in
len[i].  Remove the hard coded 1.

Signed-off-by: Jason Andryuk <jandryuk@gmail.com>
---
This is a typo, right?  The other cases use len[i].

 arch/x86/mm/pat/cpa-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pat/cpa-test.c b/arch/x86/mm/pat/cpa-test.c
index 3d2f7f0a6ed1..ad3c1feec990 100644
--- a/arch/x86/mm/pat/cpa-test.c
+++ b/arch/x86/mm/pat/cpa-test.c
@@ -183,7 +183,7 @@ static int pageattr_test(void)
 			break;
 
 		case 1:
-			err = change_page_attr_set(addrs, len[1], PAGE_CPA_TEST, 1);
+			err = change_page_attr_set(addrs, len[i], PAGE_CPA_TEST, 1);
 			break;
 
 		case 2:
-- 
2.43.0


