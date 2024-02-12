Return-Path: <linux-kernel+bounces-61589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C2E8513FB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:01:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81068B229F5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7120A3A1AE;
	Mon, 12 Feb 2024 13:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HG/13fVu"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A7B3A1A2
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707742899; cv=none; b=PnM0S+Ja9jWtd581RItFsZrI0trsi36GzFI+SdBVopJf+tePO+latVdo5Q8m6VkfbdEWKfVWdIxCFJVvHN91ysKSyjbcuYHvJnCZUqsye9FOSQLaDV17VUTjtlGMDzyfMVIVZmRa4W+qj7JdYtU3QfeqYbZsc6WHDh3wb7POrSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707742899; c=relaxed/simple;
	bh=OEgOfFbBWtYOo4zoZjGOmPqaBaNBxeMwq2pAbEbCgeA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZUvI1Kr+fQuwnKykBBYnKw2BgONPbvKoiB4spCunMVDABxWLcfQYTaFFNc7nVSTM13SfXf01MlRdbcb2NKIFPRzunE14tf8cxWR2iClg9PdpYLrLIeHH39U8XRmX8QeRSQUtWPck+PFlIiiluQNjEwc3ozFdoa6zWgb0+YoAC+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HG/13fVu; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc74ac7d015so4300711276.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 05:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707742897; x=1708347697; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pdujWWnO8d2IohPiw763CkbnCFmrIW28np/fZXta7cg=;
        b=HG/13fVuF9jR74rWV+ReW4NcEyZvAtID0zs9CUmZPgAuR6gMHKLlUDOCbLWEjRg5ql
         IgG8hdXSUwGL1Lc9qSlVcXbLlYY4dF/HGDWf9k+0yC78lwg7V6DOM24lsXe9ifnVtnM7
         4Rnb3McrVDYj8Ptu8BMvKLKqBRZhfwpICYOjFi2E2yMicqW1Yh4q2h73ratj2n7Zrrio
         QgNzaixTAFCHN80wTP/3G+RHofIKbM4un+104l12CL5OnSMl2kjwlXSvc6YSglBqkgVd
         Pk4Gavf/50Hk9qPRlxaGZWXkGgrz6lKz76PctYCvL0aFusejQOeQ1mDUudk4ox7iCCiv
         su6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707742897; x=1708347697;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pdujWWnO8d2IohPiw763CkbnCFmrIW28np/fZXta7cg=;
        b=OS+/mspFxBquFDwkDpwweu/Cf0MGONVCe5iyEc6x/8tocGZLJ1C3gFfFjFbhyvxgmX
         wBvs8fTx1saaT/QQsI4mQqVqZedY7Tm/ky5H2VsY6IfGTxlqhemwiRGgiYyGz+m1YdxW
         XYJsFWZFNIBjYPWrR5KZ8yabATvdUp8gU1f7Hqcug0XPGvemsj2ejPIwI9xLrulnjtay
         fVcgkzzGPxGJi2KOGWo+ZsklJ7d+PRdE/tQdLVCDVUCkOLj/z9WIaVdCv9p8Bt/A/u8b
         +WxVJJ0rbSUf1TY30xJr9iKNxuxXVmXj/Qed8qszuipLM0iWEeKUzISQ8V6dyjE3aCim
         cYLw==
X-Forwarded-Encrypted: i=1; AJvYcCVU9V+7DqZgax43F/Z03x2Q+tjZ/PVx8+jhp3wvV9As8N6MwRZ3wfAdWQYSf0y+MsmOcVgargeMdpE9O0FwvEmgOyxCS8/aYUKP4rcj
X-Gm-Message-State: AOJu0YxeLd0SLKbm7uC+Yp2aYw+7GvdDh9hG0OyUOrHyA3R/ACJXbR70
	S6LcwjVBL94E7/i+Geu8iOlxf1b3puNt+/cf4yiJsr3IaIS09zLxQjL9Tw3go3tLZUCIbqOSmg=
	=
X-Google-Smtp-Source: AGHT+IHYW5UG9oX+HgucYE1vnEAn3ElMO2Bfe6CkqTfCKXg6CbgSRaRP8kEIytUkLEyn4AtvAwJnUriFyg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:d6c8:d450:ebb5:bf7b])
 (user=elver job=sendgmr) by 2002:a05:6902:188e:b0:dc6:b768:2994 with SMTP id
 cj14-20020a056902188e00b00dc6b7682994mr196715ybb.0.1707742897343; Mon, 12 Feb
 2024 05:01:37 -0800 (PST)
Date: Mon, 12 Feb 2024 14:01:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240212130116.997627-1-elver@google.com>
Subject: [PATCH] hardening: Enable KFENCE in the hardening config
From: Marco Elver <elver@google.com>
To: elver@google.com, Kees Cook <keescook@chromium.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>, 
	Alexander Potapenko <glider@google.com>, kasan-dev@googlegroups.com, 
	Matthieu Baerts <matttbe@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"

KFENCE is not a security mitigation mechanism (due to sampling), but has
the performance characteristics of unintrusive hardening techniques.
When used at scale, however, it improves overall security by allowing
kernel developers to detect heap memory-safety bugs cheaply.

Link: https://lkml.kernel.org/r/79B9A832-B3DE-4229-9D87-748B2CFB7D12@kernel.org
Cc: Matthieu Baerts <matttbe@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/configs/hardening.config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/configs/hardening.config b/kernel/configs/hardening.config
index 95a400f042b1..79c865bfb116 100644
--- a/kernel/configs/hardening.config
+++ b/kernel/configs/hardening.config
@@ -46,6 +46,9 @@ CONFIG_UBSAN_BOUNDS=y
 # CONFIG_UBSAN_ALIGNMENT
 CONFIG_UBSAN_SANITIZE_ALL=y
 
+# Sampling-based heap out-of-bounds and use-after-free detection.
+CONFIG_KFENCE=y
+
 # Linked list integrity checking.
 CONFIG_LIST_HARDENED=y
 
-- 
2.43.0.687.g38aa6559b0-goog


