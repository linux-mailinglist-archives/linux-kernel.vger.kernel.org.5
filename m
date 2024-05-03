Return-Path: <linux-kernel+bounces-168166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3649D8BB4A4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 22:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62808B22E89
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 20:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34383158D9D;
	Fri,  3 May 2024 20:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NzJCjyfO"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F8B155321
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 20:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714767390; cv=none; b=F5sVMAXgsQtq7E56yV7S5P50z9Q2tM0S6MZUxIdCwxUPVkkIqvJWAVnC3+h8xbi6dvb/is7AxBP0tn56cses1rjb1fOzAoaUIzRdf2v78pCPo82Y1vwB4kQLhDMREycKWF7UV9H15BeLQ1UH49cwZQih8chsa1YVo1y7Z2UsjQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714767390; c=relaxed/simple;
	bh=pf+pNFxmMm1HFvn7js6D1XqSBUysWOw89rU+1scNx50=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ExIMYCTNSbT7R5q6iNTfEnULz/nxcSwmdItes66wzOAsFxIstb1b7pnLt93gvwu86PLpqGjkudYFaEhYt+B3eCLGj31mSI+u1yh/eiuHjlm0l35NaXJcX55XhUEHE5R4Mjqc8pfXnT495Mqqu4DtpMuo8zH8FkImzhOV67yZ3FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NzJCjyfO; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5dca1efad59so35515a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 13:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714767387; x=1715372187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NjXuBsA7zZ0oIxrlLeiGnoyK8wpbBUktncdxO0iL2YE=;
        b=NzJCjyfOflwbz9Z3Hp6sa2Ei3LrQrl0eEOMtuvg5lOnbLtM4zte7OjQ/W33RCI3QwK
         vg9hzdHLWRPC6zIG2NIv26mUMUgWlaD9a1F4qtgBT6fbIZzt+c/fHYfGo4kxAsZHXFAB
         2K1hVBIZ4nRbifi6uRXe8ZIfC/rXalGCtyF1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714767387; x=1715372187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NjXuBsA7zZ0oIxrlLeiGnoyK8wpbBUktncdxO0iL2YE=;
        b=KcE53soUx48BG2gs0dDWKQd4VJ2jXYk9bj5TSndvXODt1SvaIfhX5iApCMpb5Gt+V2
         UN1ruDmuBntnC9G9xPMZgvx4y7LzBOeADMxzpGpUL/F2fu/Tdp7K02PE5rxOqLGtSl53
         Q4MpiB8MHvhZ6SesjyIKLXRyVxrKgEDlAx8kWDN8NQqtQaySNpv/JVRLZ+bhpo7ASPkF
         GUKdneslZSiyFBCgVgolDNF1/D4xQWfr2eST3JQrg1S2JSoGXcuCvv0/+ImymflgcnBW
         fUBXzW2u1okAnc8vhs2evIC/lJ+WADFWImsHDii96AbJj29iUK7SdUE6hwaPU1tE6n99
         LsSw==
X-Forwarded-Encrypted: i=1; AJvYcCWylMrAk46cjE9cmUsj3+pMI60sxpXn7FaKK7CTeMRR70n37hsfp9DYDwlJ+or2OCIGJdcyaCecYJpZcPvk+oWdCJFxvtdVwSxlKXYb
X-Gm-Message-State: AOJu0YxkDINti3S4q9OiGeK6EzYa9qiRMArryRmyXJg8K3al3+MRQnbN
	3pIOrOaF8xpGDyF1DzzBCmRVFJhLDgxPlQ3TsFAaViqY5BIMK0gPDb+btDE+mg==
X-Google-Smtp-Source: AGHT+IEAqfDwqCSvcN8OuGiJ0swOLO/fi75RqAG5LMAhNjNj16WfYkFbQ5AiOphfNtiKx6xIeY4mqQ==
X-Received: by 2002:a17:90b:886:b0:2b1:3cc7:ae83 with SMTP id bj6-20020a17090b088600b002b13cc7ae83mr3668935pjb.32.1714767387520;
        Fri, 03 May 2024 13:16:27 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gc19-20020a17090b311300b002b05e390c59sm3545286pjb.27.2024.05.03.13.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 13:16:27 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jens Axboe <axboe@kernel.dk>,
	Jann Horn <jannh@google.com>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] fs: WARN when f_count resurrection is attempted
Date: Fri,  3 May 2024 13:16:25 -0700
Message-Id: <20240503201620.work.651-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1386; i=keescook@chromium.org;
 h=from:subject:message-id; bh=pf+pNFxmMm1HFvn7js6D1XqSBUysWOw89rU+1scNx50=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmNUYZ53nnbAADcogtkELI+D9ycJdn+pb9aefol
 66UgNHNLRaJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZjVGGQAKCRCJcvTf3G3A
 JszHD/9djHZkCfUTJG1NBb3v6t6W29SB91Q2iuAlm76cE5d6kGsEagP3JkHy5CVPK+fB+YXCFAj
 3aDVoCAdyYlyA115UlUtIiPsA8u6bXNHzFHhPTqcPg6FwlpDiXHQ9Z0UifMo60EwUbulmSwNe5c
 ZgUTI5sWBFE64w4Ypz/qXYH+Q78dMwMwDP5PmkO8dQAxRVJc2PYxJ+g9CEKdKuq4Bm1SH21Ea+U
 Zs2uWdofnwqQvLVsl82EVnl/RPoYX1AJX4mtPDpMgL/n49+BUT88pTa2w0GIalXNsY0os9rfBBJ
 i6qNMChvDdenE3QpeMxmWLNlAdCA4dFYwnuqfVlb2Je8/4u6mXalIZiaUDVCpHqFBXuXjvnfW7I
 F9Cz9Ah80rLXmRNijfTMsB0u93V0diOciv/914qmiaukoJiAzOCNqoMncV/9dfLpsURf08oOy26
 yneYGRMD9FgEGxGvUPPR6Vw79tTtwB3/d6oIv0b9RzffmukU5v6qUP2MiAjSjcNmECVVuXsEbQt
 MmNztwez3USCFAZS2SY3Msz2alKSzLAmMJDYKmd/L4EZWZEplt7xOKc6rDjOiCVUD0C2HtlfICe
 46Kb98XHn1ZjswhLT2hykrtD2eVBkS7UGoSMKDxwM5fkmgXlhvFC3RY0njUjpOSM9JQq+b2Uc1X
 Wx/OMIJ EUHtkgQA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

It should never happen that get_file() is called on a file with
f_count equal to zero. If this happens, a use-after-free condition
has happened[1], and we need to attempt a best-effort reporting of
the situation to help find the root cause more easily. Additionally,
this serves as a data corruption indicator that system owners using
warn_limit or panic_on_warn would like to have detected.

Link: https://lore.kernel.org/lkml/7c41cf3c-2a71-4dbb-8f34-0337890906fc@gmail.com/ [1]
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Jann Horn <jannh@google.com>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
---
 include/linux/fs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 00fc429b0af0..fa9ea5390f33 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1038,7 +1038,8 @@ struct file_handle {
 
 static inline struct file *get_file(struct file *f)
 {
-	atomic_long_inc(&f->f_count);
+	long prior = atomic_long_fetch_inc_relaxed(&f->f_count);
+	WARN_ONCE(!prior, "struct file::f_count incremented from zero; use-after-free condition present!\n");
 	return f;
 }
 
-- 
2.34.1


