Return-Path: <linux-kernel+bounces-34507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6DE837DC6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09CB11F26EA9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A5A5FDB9;
	Tue, 23 Jan 2024 00:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iol/av7l"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BA25F568
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970164; cv=none; b=K3cLS2BPhWkNb2bSDlWtYmBQhnJ7aWcz/sPLRvniy3Ef01YdrWbBnP40QuKGX8epjf0RpgnYgXMyNA6VRmqB65UW+g+/N6RI6VR4oB1mJkYib9RDB0ulOE6nOx5qJne0eYFJXS9CIPPG7V3A63X7Kqpi5YRMgkIZrdGfHI1We5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970164; c=relaxed/simple;
	bh=8xMicWCCIGnY5GKvzZPD3ZX2aaa2K5PDmR+v+tHiKy4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nffQwYeZzkmgjQOIhTIJ2AaiQ2J9m0YzWYUJ7dmume0W+gsSG0H2OyZWiT/M4fzbR7Hsg4evR7zAmbgNV9M0StailQ0cpMEGhmAtIUwGQAHWDyrVOtr5jlGy1qifTf6Ufe/LVH8bVt5f/oHbi9rKxgLqq9087n7VEguXW42DGW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iol/av7l; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d74dce86f7so13027095ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:36:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970163; x=1706574963; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plGxjteRa5N+fIhm76KZZ2X9yyNuyI4/ZE1C443mi7c=;
        b=iol/av7lTNSJjvBCqOOz0QA6pCamcIl1/RioLK+JF0rNm8+WSH/v5lLylOgfCScnqV
         tL5+juGrtfzTK+o2JruIp2ymCCCwISJRNB4Wy0Ocuej2H2ok1eu35of9YxOYNTViBqIR
         y/0H/1W6pLQ4ODlpnsa/TaOcq8NBoMwjjyW8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970163; x=1706574963;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=plGxjteRa5N+fIhm76KZZ2X9yyNuyI4/ZE1C443mi7c=;
        b=SoImPb6AS8jTHru3nteOJQ7dSNAm4JWrCNEgoLx7zE4guX0p6lGjnyX8I9/PZ1Jhdp
         +iwTXvB2eeqH7bEAzuTaAvDMQGM3W/zetuoQH8mXM0JG+Hrah2uZSSM2BhwIJJiLplsO
         XLFS/XGxt6/pMhFj2J+mbb16QmYm/Sr22jbgvS4HJCa49wXtip8c8mVqU18H8W9UuLNY
         iLGsnx5o+3knQZco1Z/KhzdblCOk6wCS/IGbfdocTSd2Bt6sdM85y81KzJTliP45AfUH
         a4n+Y0+PImGsH36c0Vqbn1ZxJPun8WdIuqRuVA/tGYvZkG6cicguioKxBMuTbZRj+Ptm
         Tx7Q==
X-Gm-Message-State: AOJu0YwE8cnMl+QK8b2WA8fWn31PSGgH5Purx/Z5hpfWgAPa2GmtTnIz
	Nv/cs7vQeEOLUS4aWWR0JxBL0TpN5ovSOq9QYGWEcImM9nnPo0pk5wRGUJFZEQ==
X-Google-Smtp-Source: AGHT+IFKRKBK9VkrLk8Gvj2KGY6rQijWePcBEXl1QP0qD1UcdfCZ3HnRfHtBDMtyo6SzfYFYbeiiuA==
X-Received: by 2002:a17:902:b10e:b0:1d7:244e:906e with SMTP id q14-20020a170902b10e00b001d7244e906emr4823001plr.68.1705970162892;
        Mon, 22 Jan 2024 16:36:02 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u2-20020a17090341c200b001d4593a2e8fsm7733952ple.83.2024.01.22.16.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:35:59 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Vineet Gupta <vgupta@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"dean.yang_cp" <yangdianqing@yulong.com>,
	Song Liu <song@kernel.org>,
	Yihao Han <hanyihao@vivo.com>,
	linux-snps-arc@lists.infradead.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 74/82] ARC: dw2 unwind: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:49 -0800
Message-Id: <20240123002814.1396804-74-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1989; i=keescook@chromium.org;
 h=from:subject; bh=8xMicWCCIGnY5GKvzZPD3ZX2aaa2K5PDmR+v+tHiKy4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgLa43MyLCbPnS7rIKEr6C5f+3w+xjELlHCV
 wb92b59i9WJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ICwAKCRCJcvTf3G3A
 JrpAD/4xhn2HsV5zKKag0M7HS/9i28lHFY4IgZ7Sp/FXWqsjhJpe+6L8PIMzWEBAz92FxtyORdf
 VL+eitydi1OUF4wQn5MlkJ9CuYUuRkqygF2GNN2Yv1RxYn41vBvNCuYIauc6D5qu0qdxnnP6Md6
 84Wz30+PNpfqG+4iMSiroUyKG54Rs5mizS1WG6YfWtx3YbaH1cN9/tF3YP8GRKMwDUUaO0a+eAN
 KE4rFgsPGobQpzzmomeGjLNzFgA1quKNvV0vj4JNIex/9cb4WYPOVEYFoSmbC7GKjxW+Feoh6sk
 OvDSN1cF+uHp0J/HNlCu9234++OHS3O99H6uPHVYrJAff5v2Y8xQIZOHQexnwz+XpjOzwRTEaMg
 AaQwsD98zVWDntX4MOwBtxsAygM2tc6IF7b0qZdHQy3UdlFBRbUiOVa9hOnRJxYLVRxmfZofKAF
 FszP40YEw5lDzaprhTGytbpNvVCQmqppB3GhHMQrCBA6irAcVze8V7JWHb/QOfsXzW1dfZ+wm6b
 JqEyk+UA0/YDj29GWvTQ3Eyx1i2tZ6p1xL3sR0USkZszG+zbF2E1aaV1tNGWKi8AysZfjkgMMaP
 3hABbeKJFLwRLimh1GaqkDPDGG7vbdgQYbJVljd6TndE+Vys1auQJU6Hdc2dM0CmHHDf3UNBzRC hw1N/vlLdn0dvOw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In an effort to separate intentional arithmetic wrap-around from
unexpected wrap-around, we need to refactor places that depend on this
kind of math. One of the most common code patterns of this is:

	VAR + value < VAR

Notably, this is considered "undefined behavior" for signed and pointer
types, which the kernel works around by using the -fno-strict-overflow
option in the build[1] (which used to just be -fwrapv). Regardless, we
want to get the kernel source to the position where we can meaningfully
instrument arithmetic wrap-around conditions and catch them when they
are unexpected, regardless of whether they are signed[2], unsigned[3],
or pointer[4] types.

Refactor open-coded wrap-around addition test to use add_would_overflow().
This paves the way to enabling the wrap-around sanitizers in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Vineet Gupta <vgupta@kernel.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: "dean.yang_cp" <yangdianqing@yulong.com>
Cc: Song Liu <song@kernel.org>
Cc: Yihao Han <hanyihao@vivo.com>
Cc: linux-snps-arc@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/arc/kernel/unwind.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arc/kernel/unwind.c b/arch/arc/kernel/unwind.c
index 8924fa2a8f29..649b56204580 100644
--- a/arch/arc/kernel/unwind.c
+++ b/arch/arc/kernel/unwind.c
@@ -1278,7 +1278,7 @@ int arc_unwind(struct unwind_frame_info *frame)
 			if ((state.regs[i].value * state.dataAlign)
 			    % sizeof(unsigned long)
 			    || addr < startLoc
-			    || addr + sizeof(unsigned long) < addr
+			    || add_would_overflow(addr, sizeof(unsigned long))
 			    || addr + sizeof(unsigned long) > endLoc)
 					return -EIO;
 
-- 
2.34.1


