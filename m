Return-Path: <linux-kernel+bounces-55547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D355C84BDF9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 20:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E139B23223
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 19:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FF914AB0;
	Tue,  6 Feb 2024 19:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="brZyxFnm"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCDB14A99
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 19:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707246838; cv=none; b=CuuDBuvpY+Guc3hB3PlVMki6ZR+Ij0BeoDfR3GPFvQbaOvMMPTzOYMgT88IxbDNDJ1+WiE7LY+aeaaFSbgm9bxCmPMWr8BXvIkRnCDZEyJ15VRJ5/jWCcO6SXUG9b3LgHLXojA62Br25aXRLIvXX4AhPoOMxzCcAbZq6iySytpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707246838; c=relaxed/simple;
	bh=6G6ZaiQOAG1EiZ/LN91XKqV9xnlFhE0QAEZQeos/4Yg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=p6w0jwshqf5M5ek4CA4gajd+/p5dy0aNmcH7LhGVlHoeyxSx5Orj8n06wP6wrcKQ/NKefmtNFHuIJKJCziBoVfy+hJm9SAYwXNN7Ya8ikHKbcABPEIXE4R5SoI+M2PWbiMFSH5K6zs7ck0EaYdK35vXFK1zsa91EDplUiDRYyI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=brZyxFnm; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-783f49812aeso230006085a.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 11:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707246836; x=1707851636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fZojKhB9fYKfMspFBwwk8hmljyIuozOLErYmthRAITg=;
        b=brZyxFnmMpA/OJLuW5dUbOqoBRskxDm+f4L7xB3rGzIx+KfwbYcyOczOsbFmUBIl7p
         y1FD5XyeR9tfE+nZ+mvV3i3aLYagUswO3N7qtO5Z/e0J4H+ur69dDQfq0flNYwD7sRSp
         +sH+TI4iP5nAg7LOfz6uDrwMAr6lEo6klW8RVAISKGT/75dJHQ+6nrIsyjbh4/yvmK6t
         xLmRBp009QHDqrbYTj2lNiYTYp5Qij6Ch9v0C810zbhkwgOgm/1reJt5gfJUk42yr+Fh
         313xpraR174OOM4ewg7knHZIWs5SFUUSHjdxZ/IuZQZZehHjcEn8a+Pit7q/bd0gqIay
         ykHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707246836; x=1707851636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fZojKhB9fYKfMspFBwwk8hmljyIuozOLErYmthRAITg=;
        b=cwdacTu4JLBo8Wz4JSeIS/d+obF1CNg/1pBOuUdjAK/YnyvIwtFgb1Up6JULYIdKI9
         m4KEbwE0PWxkDV3CRpdmw91lYiH/iQNYQCXf7fqRWNOPpSNw9QmI7LeHrLDqyJ0+Q2ut
         Wxn8PVso9hsmukAaXTmEvwmhX5OivL71fffViJmk1c8rFRRYaXqDrqHRrTQP0Mvc4smC
         4MfBYtHvxBIfVHo6oW6tW5lZhy4dnl/7L9OA9gWuWNrdQTc42MEqsR5TEwQ4WZ4N5LM5
         ETMeLpDNLQkP3xUncsv+LzPGHe/6wr4n9HNMKcvndX2mfI+Jh1yotemMJoSyWdONw6VN
         2sdw==
X-Gm-Message-State: AOJu0YylD2cgzVX92o+azds688A2TubN1cbwwMe7XHVuA5sceuxatXZP
	z9x4DM2LyN7D9SpX9UmKn6avmjBwyvEaTQjVxO7bLN24C+br76rr
X-Google-Smtp-Source: AGHT+IE5/J7s4JCxpAmfcSJcYhOoCD+F7wm5PS5M5Xcb6nmWdF5ypcGcNLvSVEVlv2D0PgXg2+7u8Q==
X-Received: by 2002:a05:620a:491a:b0:783:936d:7397 with SMTP id vy26-20020a05620a491a00b00783936d7397mr3268772qkn.23.1707246836079;
        Tue, 06 Feb 2024 11:13:56 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX2is+O3QYnrbaupcv+qA7hli8+D1smBDDvmy7FORbMFw3J/rZzVVpXeeAUEzczKZUWAJfUBZotG6RfGMg1SrkCNEFeS0PHTZZiJPFhGKNjlrbuNTLbT8L7uHjOb2dPVlyoLQ7KyJBge4beGGxe+JrnhiQ6P0bOh1OcyysD4pPHUTWW7YL973GsWG3XIbexpLNRh2HcO2URxLvCZnxVBv47UiLql0+KPQ==
Received: from localhost (fwdproxy-nao-007.fbsv.net. [2a03:2880:23ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id p23-20020a05620a22f700b007858f8eafdfsm784314qki.55.2024.02.06.11.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 11:13:55 -0800 (PST)
From: Nhat Pham <nphamcs@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	chengming.zhou@linux.dev,
	yosryahmed@google.com,
	linux-mm@kvack.org,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm/swap_state: update zswap LRU's protection range with the folio locked (fix)
Date: Tue,  6 Feb 2024 11:13:55 -0800
Message-Id: <20240206191355.83755-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240206180855.3987204-1-nphamcs@gmail.com>
References: <20240206180855.3987204-1-nphamcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The if (folio) checks inside zswap_folio_swapin() is no longer needed.

Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
Signed-off-by: Nhat Pham <nphamcs@gmail.com>
---
 mm/zswap.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 8c548f73d52e..e91e3f10a5c8 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -826,11 +826,9 @@ void zswap_folio_swapin(struct folio *folio)
 {
 	struct lruvec *lruvec;
 
-	if (folio) {
-		VM_WARN_ON_ONCE(!folio_test_locked(folio));
-		lruvec = folio_lruvec(folio);
-		atomic_long_inc(&lruvec->zswap_lruvec_state.nr_zswap_protected);
-	}
+	VM_WARN_ON_ONCE(!folio_test_locked(folio));
+	lruvec = folio_lruvec(folio);
+	atomic_long_inc(&lruvec->zswap_lruvec_state.nr_zswap_protected);
 }
 
 void zswap_memcg_offline_cleanup(struct mem_cgroup *memcg)
-- 
2.39.3

