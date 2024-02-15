Return-Path: <linux-kernel+bounces-66535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05010855E09
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9929D1F21477
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEB918045;
	Thu, 15 Feb 2024 09:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UieDUjTI"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB53217BC4;
	Thu, 15 Feb 2024 09:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989233; cv=none; b=dSUJDV1vUVeCgiMNzKbzK412hahCsMtCBFSSW5Y4C1XRzxSz4PuZD0qMkzcASgVtoclJmNltg0emCH8fCTk1g/i7CeR9LABO7e9dQgWRqmgNWnkLeKmbjZp4XGYXerQKQsOKoNjQZLQRCVUjAfeZYdaWuFjVdxpWPkQhG5BmS4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989233; c=relaxed/simple;
	bh=LRQBpeMvzZRQfMCsOVQ7ufZKVewgbToqGM+AZlaC194=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GoeccqPK2MXTUGp6ZyGZrnDVsH7+HUpLjIuqI60z1zq304OKRv+I9bj2g4B9lao1iagh6LEgkhWFT4pKkV0IV99Xf8pQUQ584AD9eKM/n3s/jJPpH7M6FxGg6kHN8HbYWe+rWxKWTegH2QCebh+Wq5LgLlv96f0hFedFhU0o0Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UieDUjTI; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d751bc0c15so6180665ad.2;
        Thu, 15 Feb 2024 01:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707989231; x=1708594031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2k3gIo/M5uDVIvhy4OiNcjz9A7CEfotDP9LhZ8c61hs=;
        b=UieDUjTIpjXVCsHqTFl2RUX3lwrUqx3FOraYNREiCdQj5crAdOwQjTdAd+afohDqbz
         0PlPQENdJcWiMnQAvomsCH3kEFSNzKlltyKgGBr7DbozjqHphW3kl4Qn1LYsoqACUUci
         8BHNTwGhn7z3mJ8+yemM5QBAb4ZKJMKsOuf1cou+EUdJBqoxdMSqTZUfyIBp/Wvg9phd
         M2ZCiHCi9aU/4fbvwlIIFxLa3bpzIT8By3NeDOVQGC0Q5ZEgxetAsVhK5wQcu75APquU
         Y9JMBf3xqYNjIY7U7bNsM3keu6k216w3lCd3LaISfGdjZXs6NOcTOlnJIHNsBA4/t8CL
         NE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707989231; x=1708594031;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2k3gIo/M5uDVIvhy4OiNcjz9A7CEfotDP9LhZ8c61hs=;
        b=Y7zu0nOC6501HF5qw0zyA9Z59YCXcHxYppHq0Unv3LgcAaCNCDUu26ELyl3Yqh9TwQ
         vVVRsA0W5FzpFSNAL2HGy03AfgM3ktOJdxK8C5RDZMFfVrKyPbCx4L7mGpP5nS5rNu7w
         a2zz3MT2z+co0Q1W0anWoLoizxD8Aj3zxoRhMmxGRl81rtE6nxtXLsvMYOZ7ggXxNkEx
         wS6c0FeCCRvJ1fRrzezzJdnob7oUvs4VQjucHdpRn+/EeL20HBShFH15PYdk85u4HQyg
         8nT7WJmJxdRDbHDHAnsqmkT7ih0nPZDlPiorrO4OcYQvqUM/yh8UCT/YB2SvyRWAccZ0
         VCJg==
X-Forwarded-Encrypted: i=1; AJvYcCV5BOTahTEZmyrq1+uVqwy/mvjcqhOpBVEGol1zYILFmMyAAhR89wgCLnb8L5B0IQFeQrpQRmihsH/+KhjHYdlxbeoGALZanuEKPKSd
X-Gm-Message-State: AOJu0YxtvdvEbb4iLwSy058wgZVn/qLpOpIgdrR1iLaaTV0XIci7Jkju
	xOg/Pk1MM4THHy3AQVmDVeE5eqYgRLWh/lf0GKgQDYQFsdmx5jdV
X-Google-Smtp-Source: AGHT+IH1wPjdsQS82Ni7Ry3G1e3B70VzyJYxjtd6WLjsZNkzjVbahpZ6wMFrZrzNB+VXaohb6vVWbQ==
X-Received: by 2002:a17:902:ce01:b0:1db:96d3:3608 with SMTP id k1-20020a170902ce0100b001db96d33608mr134275plg.2.1707989230953;
        Thu, 15 Feb 2024 01:27:10 -0800 (PST)
Received: from pairface.. ([111.18.198.117])
        by smtp.gmail.com with ESMTPSA id j2-20020a170902758200b001d93a85ae13sm798871pll.309.2024.02.15.01.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 01:27:10 -0800 (PST)
From: Pairman Guo <pairmanxlr@gmail.com>
To: mingo@redhat.com,
	namhyung@kernel.org
Cc: linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pairman Guo <pairmanxlr@gmail.com>
Subject: [PATCH] Perf: Use fallthrough pseudo-keyword
Date: Thu, 15 Feb 2024 17:26:59 +0800
Message-ID: <20240215092659.148946-1-pairmanxlr@gmail.com>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi maintainers,

There is a usage of ``/* fall thru */`` in a switch statement in
hist_browser__handle_hotkey() that have long been untouched.
This patch replaced it with the better and proper pseudo-keyword
``fallthrough;``.

Please merge if it is the case. Thank you in advance.

Signed-off-by: Pairman Guo <pairmanxlr@gmail.com>
---
 tools/perf/ui/browsers/hists.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 0c02b3a8e..aed835946 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -732,7 +732,7 @@ static int hist_browser__handle_hotkey(struct hist_browser *browser, bool warn_l
 	case '+':
 		if (hist_browser__toggle_fold(browser))
 			break;
-		/* fall thru */
+		fallthrough;
 	default:
 		return -1;
 	}
-- 
2.43.1


