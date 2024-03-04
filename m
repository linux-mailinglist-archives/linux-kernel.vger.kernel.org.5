Return-Path: <linux-kernel+bounces-90478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFAF86FFCD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:08:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D20151F258CE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA9C38FBC;
	Mon,  4 Mar 2024 11:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="RLZ20rvC"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08F3383B4
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 11:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709550494; cv=none; b=tIgiDeekAKXYMZ/hkXYxJUEUFJfUuiqverSUYxOKbyqneIbEvE3P7guUghlFaizQ65h3EIBNUy5MK546yKfJxbj2ZjbDewYHoIPOXTD+nWlD1TnA6Cze7ns0zzbb/Lx7rapnRa7XY5qeHESOeLufkrroaAekuxoCRu6t3uXjJNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709550494; c=relaxed/simple;
	bh=7ULQRPHFiQc0UrVTa9FvxBoC23iVoMzPSvJSRq+b56g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u72w9ekzzl1LNq4jt5TZvCyZimGkXrCqs2e1ykI5qRUJYRVGC5b5KDsjmft/3pZbM9/tHXlHe/Vxq/7tRx6XkLMJhYLN5LLiE3LrIMAPECQLq3ecwxl7ls9OC0fjpM7FXqqrL9N4t4FduWMZtVfc4A/t2M79KwxUuOgB/k+VqFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=RLZ20rvC; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-55b5a37acb6so1700840a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 03:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1709550492; x=1710155292; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KtIXFJcfM5neAeyBfBxq1hZ3fmqqVOtLZ2hkhXv5tMY=;
        b=RLZ20rvCN3D3IW3YTK8+pckgkstPyLiZUbk/cl4TIxdG713AAZLObcWoz4XnRDElj0
         GTUMA/fanW/HnBvYIKRIwnQ/HCFm6Tsqo8cN74YgtgbVGc+GHUNLsZDajxy765ZbpbZ3
         tEqJMH2WZAWVwrpwARYu0W6FnO2ML3A6n+kf5IYt1v4jLqXgewXIY9YMTRoNJRUPf0N9
         b7hJjVyQBgz0dsEIzqnNtaL+SxGgps1HG80x8Qury5gA3xDmo+dB16iqj73qg3CsgbJA
         e0xFvG0ltS0XntXE4h9ezAKTr4ZGPxPyauGTD6CbjJlxHzCNXdmHet358QWE4nOitGxA
         nXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709550492; x=1710155292;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KtIXFJcfM5neAeyBfBxq1hZ3fmqqVOtLZ2hkhXv5tMY=;
        b=M4bL6Yk6nH4uyTE+aM5wP+IsiZJXolh6rSBIgj5J13DcblmZ15de5RwmxN9PlhUlAh
         rFubW8AYiB5KHn9X7s1k+NYZaNPZG9u8LX2jsbZthlL3CA0nNpsRGsbyZ4zv2UVKdpfT
         5UT0OQiVM6Uvi8nsZUK8lwJdKzTUWvYVwSbNkxUMnW5kg/yUdFFwKwsRlBn/UlO/9bq1
         j0THDuZroopRSAKpiLfgaPC6gEGEHb3tyJXNFuvm4mVofPujumFHl4YznatcsR9Zsh8+
         h1JEPcUZ2mU3Z2TtXBKEZEDUbPjl2ZWWf3d9S4HlKD6SPWw8SwlvM6D10wxCdJ3te0+u
         hNuA==
X-Forwarded-Encrypted: i=1; AJvYcCWat6UU1PBv/KShjLv12Tg7iF21pQIiWpaUP5V8su1G9bP1c5//LW1nl+bJTW7iiqdtb8w1YLhbN9AMVrjL3QDigEqwjoIuMlwyUCIr
X-Gm-Message-State: AOJu0Yye9DTPHxjqz9XqRVx/y0bujtLJ/pIFDdAqhol5KIPOyzFZ4+5n
	EiUupR8j1n5uiMYKSFbYokALdDHgyRc2smQEiu2eAVqDiTYkml19DIS/FYNyQ8I=
X-Google-Smtp-Source: AGHT+IHFdup7gqVcwPWUuP5Df16ockl+ZC0JJEHwoOQgPVW2YrofdTAkF/kgzYWVAY+1V3T3ucMfEQ==
X-Received: by 2002:a17:90b:1908:b0:29b:309b:a200 with SMTP id mp8-20020a17090b190800b0029b309ba200mr5173828pjb.3.1709550492018;
        Mon, 04 Mar 2024 03:08:12 -0800 (PST)
Received: from C02DW0BEMD6R.bytedance.net ([203.208.167.154])
        by smtp.gmail.com with ESMTPSA id y5-20020a17090aca8500b0029b59bf77b4sm587410pjt.42.2024.03.04.03.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 03:08:11 -0800 (PST)
From: Qi Zheng <zhengqi.arch@bytedance.com>
To: akpm@linux-foundation.org,
	vishal.moola@gmail.com,
	hughd@google.com,
	david@redhat.com,
	rppt@kernel.org,
	willy@infradead.org,
	muchun.song@linux.dev
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: [PATCH 1/3] mm: pgtable: correct the wrong comment about ptdesc->__page_flags
Date: Mon,  4 Mar 2024 19:07:18 +0800
Message-Id: <cc42d5915fd98fd802f920de243f535efcfe01db.1709541697.git.zhengqi.arch@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <cover.1709541697.git.zhengqi.arch@bytedance.com>
References: <cover.1709541697.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 32cc0b7c9d50 ("powerpc: add pte_free_defer() for pgtables
sharing page") introduced the use of PageActive flag to page table
fragments tracking, so the ptdesc->__page_flags is not unused, so
correct the wrong comment.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
---
 include/linux/mm_types.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index a7223ba3ea1e..5ea77969daae 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -419,7 +419,7 @@ FOLIO_MATCH(compound_head, _head_2a);
 
 /**
  * struct ptdesc -    Memory descriptor for page tables.
- * @__page_flags:     Same as page flags. Unused for page tables.
+ * @__page_flags:     Same as page flags. Powerpc only.
  * @pt_rcu_head:      For freeing page table pages.
  * @pt_list:          List of used page tables. Used for s390 and x86.
  * @_pt_pad_1:        Padding that aliases with page's compound head.
-- 
2.30.2


