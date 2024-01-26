Return-Path: <linux-kernel+bounces-39567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 452B283D2EF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 04:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0191128EF65
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 03:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA519AD31;
	Fri, 26 Jan 2024 03:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fx4W/qtB"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7399AD27
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 03:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706239580; cv=none; b=hSWLMIcXhbCRjQu1/+CJWykfA2EsAJZaJQL3azsvS2yaH9ENw80tgrLnmSX3TupN7DRX4FPqPiNihqRB8/EwtSK4jSh38WSMQ4ZY6b2+Uz8noKJlhInSuzI8j8MlrOYfaGBlcFWP57baO2IgkohUazg1U4hEG8HkFJ6lvWskJaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706239580; c=relaxed/simple;
	bh=tW4Nm4V9d5kZXh08ibLVf2N825lFsc+pZupZK2MIKW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkocuIw49aXBp/mQEHAADsG1n0KqHWb53lJA4omyGK7RxjBcqPnDW8d+lfjbDe8PGdyr9O16WsOigAPhbY7yi+ZY+qMbhe7XdCD6WzRwqRF/bfN6bYjozK4DviWuWvUnxhU9wHq/1lDS7wg4SY4nXUnPfkNmF2E1IIMmtgScbKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Fx4W/qtB; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d75ea3a9b6so42150515ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 19:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706239578; x=1706844378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jyTAA0Yise+07ysJFEZh9UL4F2WjZvgNafE+3erLkY=;
        b=Fx4W/qtBLEqDSYre+z/VU5Hr+gxYUXDVLAtM7qyr22jetDWO9W54Z6hExcvwCF2L5S
         xckI5mBYYpGv8WVmF76kj9MEfAKIu/ZpZTYB5fqdDitW5bqImm11QypqQ1+brVy0NIyN
         58i5ymjXvPYReICc7zzRHLoyioC91MpG5LNks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706239578; x=1706844378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3jyTAA0Yise+07ysJFEZh9UL4F2WjZvgNafE+3erLkY=;
        b=N00c7D4DbJloErgGf1kQjbUhnY3lpPxcCbhsYTP+k6Z5eHw0edgqCZvZbQ+nf/YcWu
         MpBnefqEJyRgp8AeePmkV6A1GlYTV+plRrq4c59phc9DQyEU/9/4XBEER+/DYyHF/Rk3
         jRofzQAX/PicJjlLvVRCR8QRubiydmWZeTW1MSllSNtBKsI36X0sBoYLft8dbSBkKMMP
         MSxh+y2pfad29QYJtXBZELz5P59n+u5ZwrnpLnNcZFt5KvgMFJcWAFuFBc8JvJsab1aU
         7rBuoNTTGHAS8VfBmmWPB/pRcXmHQHDs2YnwyheE67P6Cu34fOEEDNHsWWuZWSC1UFEq
         +wLw==
X-Gm-Message-State: AOJu0YwUBjoa7dz8LlIzkYHf+AOT4nf80yDOTiuKKMkLJObmBRAPLHIX
	QawjgINMIqNPFA4EHhejrAb4fhwtp8YYLnENpBYDBpJdNeKLAMdSvXd85dCuFUeRbMhvHuIrTCU
	=
X-Google-Smtp-Source: AGHT+IGS1o6SNKbTQYJU+qYLOMbAf0ANP7+Yayqquxbg3aPg8iboXRe+7m+NQiLxPk7hXuxwZ0TJUQ==
X-Received: by 2002:a17:903:2592:b0:1d7:204a:f7fe with SMTP id jb18-20020a170903259200b001d7204af7femr683927plb.61.1706239578064;
        Thu, 25 Jan 2024 19:26:18 -0800 (PST)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:c4a9:6453:1d67:60e8])
        by smtp.gmail.com with ESMTPSA id jh19-20020a170903329300b001d7724c24besm219266plb.9.2024.01.25.19.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 19:26:17 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiexun Wang <wangjiexun@tinylab.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] mm/madvise: don't forget to leave lazy MMU mode in madvise_cold_or_pageout_pte_range()
Date: Fri, 26 Jan 2024 12:25:48 +0900
Message-ID: <20240126032608.355899-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20230921174101.8e6271422a857af5414ce0a0@linux-foundation.org>
References: <20230921174101.8e6271422a857af5414ce0a0@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We need to leave lazy MMU mode before unlocking.

Fixes: b2f557a21bc8 ("mm/madvise: add cond_resched() in madvise_cold_or_pageout_pte_range()")
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
---
 mm/madvise.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/madvise.c b/mm/madvise.c
index 0f222d464254..127f0c7b69ac 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -451,6 +451,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		if (++batch_count == SWAP_CLUSTER_MAX) {
 			batch_count = 0;
 			if (need_resched()) {
+				arch_leave_lazy_mmu_mode();
 				pte_unmap_unlock(start_pte, ptl);
 				cond_resched();
 				goto restart;
-- 
2.43.0.429.g432eaa2c6b-goog


