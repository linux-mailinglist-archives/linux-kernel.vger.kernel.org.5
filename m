Return-Path: <linux-kernel+bounces-159100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD4F8B2971
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDBEF1F222AA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A982B152DF1;
	Thu, 25 Apr 2024 20:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ecpjr+/a"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BB9152DE6
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 20:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714075734; cv=none; b=bb9LPqK29MLlb9idtWPYqWALIyizJyLCijzksRoFo36FvtJ1Qe6qVKhDhFbd14b+8mc4OCSzQC7c1gFfAnLhOsywbMeav2DWc6Koib+7CDnEY8xijV9ALCFZsa0ShvlZTQcQVcQqyeSPYNoaVfiOJeA6nxtBXh1dBNMHCHyaCmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714075734; c=relaxed/simple;
	bh=uumuIMYEYOvPVXZFk/3WBGzdtoFi6HEW+Cg848oMGpo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HYAWxfxu+rxbNktptOOzIjPty7WJejt469HSZG+JvAlyS60GloQsUOPkZrNzDVgBKfLpfhcwpoWDRgTHXdwDbHPaZExiGfya1azo5e2dL9KxFIAsReM6wdeurxvQ/n6aQC+2BUOieCOJLtp41ZkYR7cLeagdNFGQofballoRDR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ecpjr+/a; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6f2f6142d64so1368271b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 13:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714075733; x=1714680533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qy9dTrTP2OsIqwtd1vO3NsTWFfZryD1eD3WzbdxI4A4=;
        b=ecpjr+/aNif9fZ2fb3VoECN/5SPIQ43A99EL9sPG3OMt61sIZpl1lY95UXo4goRLFu
         cXXGgHQ6lMkEWqgl/SNQ9y/fxzyArTeDrs7+e9QwIsf5rRq1OxOB8iwfSxIRWJBn2BNw
         RL9YvLVrM/CdPeaT3f2/oMm3N1PiV+D9xg/Pw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714075733; x=1714680533;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qy9dTrTP2OsIqwtd1vO3NsTWFfZryD1eD3WzbdxI4A4=;
        b=eY8TPCvd1VCxMiP4RHxxd5I/rhw9ry5ySaDkPznmKaLOKqc0gLVCYniB5+UEm6fuIJ
         Gvw7a/68pB+CFO4L90laALVd1AfU5evON3dgcQNhdtDsmtu+O94BYGGh34ErFa6Zzs+1
         gl8JP2cR1W/SYX7p2QNBTB+wjHSePE6rI4pOtU90BjJbgtHhQDEx8xT9ig+edc7NWaF1
         eetezHo0zTW9NIwKwjUjCjKFr76MqKP+AGqL7wZEmlPIFztgX5D4UotbElXV/ZptNk5z
         WclQjLxy7q5O9K5+cOiCmgye/aOOnHU5dvQ5723S5PIcUcKtlvh6NY10cq9D+gOY7y19
         1wCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVEfYXAuKbRHxoN5i4LrH3XQtxf3xvA7tgJuIKGiQVUicIF8tpoE4IVMhh3MfidYb3kxOYwQDuN7evc98b4Clffa6ySm+5rvRLBJMY
X-Gm-Message-State: AOJu0YySSXF19uNpQJw+UDq5C44WD9RZJb/yALF7UBcDtmLCgjX4DprQ
	GRhlcgK26aK7nrzo3g721ktk0xigakeu3c+DrvMnrkbBKB8cleBlc7nHJiUryg==
X-Google-Smtp-Source: AGHT+IFmImq/jNB3gD8qNUpJdps7KncEBA/kJcWPP8UMkwjlmNBRr6ooOcKlnOdjQA//knsljrd39g==
X-Received: by 2002:a05:6a21:7885:b0:1ad:89e:21b5 with SMTP id bf5-20020a056a21788500b001ad089e21b5mr988185pzc.15.1714075732929;
        Thu, 25 Apr 2024 13:08:52 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g4-20020aa79f04000000b006e7324d32bbsm13530499pfr.122.2024.04.25.13.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 13:08:52 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] alloc_tag: Tighten file permissions on /proc/allocinfo
Date: Thu, 25 Apr 2024 13:08:50 -0700
Message-Id: <20240425200844.work.184-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1105; i=keescook@chromium.org;
 h=from:subject:message-id; bh=uumuIMYEYOvPVXZFk/3WBGzdtoFi6HEW+Cg848oMGpo=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmKrhSukER5dI6JK2ZE0ZAaG3eDSZ2FZgsQIemT
 23PMDlr6nOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZiq4UgAKCRCJcvTf3G3A
 JoyyD/9vYCxON+r+gp9NzoIETQ6HOBwagR6aIfo8Sz0qme5nDn4C4GMI/4yFyvqny7W6MYEfe3p
 BYKx7kN60yCg2lPwlRzGifnRo1d1njWkmJxd3bw4Vb7oOG1FBTy9y8rHR/B7fhIdrISNQOEfatK
 F/1L1suXoqYMop/8SmrxFvv5vwGqZWQN8l9quAI3ut2RpjKAq4s94S6iSHUonWZFfinxW20po89
 OVRSGGtpLe2o1txNJAaRnjCjlJHQ28Vmd67LzqLOTAjGPExvFeVl4YwXtDIHCDzgS+E9FHQvbeL
 gbdJxZ8XxqznvlHtgTkDpwITrpj2ujH9zQ6tBC5oURp23exix85eC3JKWXnuV4xLTBCjXUhER4b
 el4b/FbscJGd0X8k0l56NtP5fLypgmZw6tKs6KRT3t1eKWbmUjAG3PMyzw6WwSToXU3XOERTwAj
 u7h3T35RGClj6ySgfpa1yHXpNuRmUBlOsVdCjawkZ6VPB13H9OfzwRkn00iySnd/agD7zszDgBg
 f9IOeoCyBtR+hK76+QxFlJd5D5fmCTZa3iMyWOUgzH6bWK68+qKIYawDKTPm9VzkRE+7cy9NaeE
 arpvhoenbCoCwDs4v1qmdEMVAxHEI7AbI8BZQTG3+N/RCbbAC0+eryQFvR+kShgCdpg85f9NcW7
 cfpZR39 Z6QG8tbg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The /proc/allocinfo file exposes a tremendous about of information about
kernel build details, memory allocations (obviously), and potentially
even image layout (due to ordering). As this is intended to be consumed
by system owners (like /proc/slabinfo), use the same file permissions as
there: 0400.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
---
 lib/alloc_tag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/alloc_tag.c b/lib/alloc_tag.c
index 26af9982ddc4..531dbe2f5456 100644
--- a/lib/alloc_tag.c
+++ b/lib/alloc_tag.c
@@ -129,7 +129,7 @@ size_t alloc_tag_top_users(struct codetag_bytes *tags, size_t count, bool can_sl
 
 static void __init procfs_init(void)
 {
-	proc_create_seq("allocinfo", 0444, NULL, &allocinfo_seq_op);
+	proc_create_seq("allocinfo", 0400, NULL, &allocinfo_seq_op);
 }
 
 static bool alloc_tag_module_unload(struct codetag_type *cttype,
-- 
2.34.1


