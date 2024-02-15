Return-Path: <linux-kernel+bounces-67464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F18EF856BE3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2250B1C235B1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493781384AE;
	Thu, 15 Feb 2024 18:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fI9XVUtL"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5B81369A5
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 18:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708020126; cv=none; b=bSe5lb5ZpGwmPVjQ9Qvd6K4AABIrdLMQ2zmUG4l9ErXMMbL/HA1eDyuhuul8MnOvpcZwst8IRBUS5vyj8m8EBER7IXLu712EL8Hbdb/c5W1pBmEg+RlgIZ/TiWCKz8OpUd8rSAfRHK7yLPXFN3cXCjoNve2ged+tOnMQxPsO/hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708020126; c=relaxed/simple;
	bh=uliD4n1/D3aYvE1jB8oAraADRLxzqurg0yvqaiBpYyc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sdE3dUXD0ZFt6TYFmQJsg9V9GPCIhRVK/HBK18QsDHg5SN/qOV0vgVuWM++gllIBLpDwF5FBg0iJwBZJIo3gnFMd37ChhQh2exinRTwk4mR3Yn6noURdjzKYAIBx5PwjO4TiZeKkS6Uzhcz8hZ/yzaqC/6BaIWEsZQymawO7TxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fI9XVUtL; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e10303de41so1228641b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 10:02:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708020124; x=1708624924; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9htNDVcJiQzKBjSTYnGyY/LGt51cX11VDgmsH2O6NIU=;
        b=fI9XVUtLHV4PLwM46rcBOY2J07r4hWRoTCzAHUskP7VItLsCm7zd9SxTj7X1DsFrya
         IDPp8GwVsjl4qsKXJbpQBhkDZ44vO/Ok8GGwpOwutT+nn6To5LLrkawVAZtXIOygqFyZ
         GyGk58n7EOAYQQg6WwcwV5mbNYbSdUkcyXCeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708020124; x=1708624924;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9htNDVcJiQzKBjSTYnGyY/LGt51cX11VDgmsH2O6NIU=;
        b=B9Xa4REZ1CXxvNhQWtubhkFJ4iLtUCVUKUIBIfHbRymL4xYHCVYlYYG/Oddd3/oPNV
         iPkgFcBianWqowwXJc0qjgUx4zBSZfNr3asy97/FWw4fA+HeTVLIXVLwMuqOorUrbEjk
         q2j1knGKGXAXD0IKfwSOm1OtcU3xeYsrtpy7X+hauNl6+spw8WBzL5eNwyhgoAHYZhEY
         4DXmsG6uHKEZ5EREL7Fp5mYFU5jNNMfKDTcG51ujtRL2nm3rWoDksrKrzkcUfJSGJ7yD
         OGO2xHKftJaYXofn5ofWjLuT+RmFvUq83H0yOeUlrRRBacY2feN1KSQFBhqWBx8GEu2a
         hpIA==
X-Forwarded-Encrypted: i=1; AJvYcCU3CUIs0rtNuDSyVty3+eyu9kkU8LmuucjU0+4+z64ptE7tk+vZNgKmf0g/vRSqhrnJUJoWdVUsEXnmgJAlv19SjRmsE48Nh25WlgMI
X-Gm-Message-State: AOJu0YwSTBYI/9vhOdmQlghq4Jp0a8YtaUGHhSYYwthzdZtqSLHwz4dV
	WJcgIbb1PvRKuKxuCB9yoVB11x/RPMzxUPICBZj6eSsdJPhGNwnflZ2+flt7UQ==
X-Google-Smtp-Source: AGHT+IHqmlfDgzHmfq808+OGy+E529SMfmtYCg6JCBKR9EW/8sR8n1FqiSo9zyXjhuvT95+6WhRsVg==
X-Received: by 2002:a05:6a20:9f45:b0:19e:488f:692d with SMTP id ml5-20020a056a209f4500b0019e488f692dmr2663398pzb.7.1708020123955;
        Thu, 15 Feb 2024 10:02:03 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bn15-20020a056a00324f00b006dddd5cc47csm1618230pfb.157.2024.02.15.10.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 10:02:03 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: Kees Cook <keescook@chromium.org>,
	Jani Nikula <jani.nikula@intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	cocci@inria.fr,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] cocci: Add rules to find str_plural() replacements
Date: Thu, 15 Feb 2024 10:02:00 -0800
Message-Id: <20240215180156.work.548-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1931; i=keescook@chromium.org;
 h=from:subject:message-id; bh=uliD4n1/D3aYvE1jB8oAraADRLxzqurg0yvqaiBpYyc=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlzlGYk98jTaHEW82NrfdAFv/Sm9zc9XykYhgrd
 LkYJRfIhZCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZc5RmAAKCRCJcvTf3G3A
 JnXaD/41Hvrpe6G5m2Hso2TQfzI332o8bu9AlSB1QVt9jUwDBVCfnIFGFx5YFH5S8whoGDwuzyH
 MzXyuJL6Wo0ElgrYoBFBBvbfR6hgq3/lUDWkFuns3+2djQnP0Y0y1zZEkzZL66aqbonYN96vXSU
 WP1MB3V3CSsHvYEhPJ8vbc/xgvNyt+fSjTRxTHdYfpd2s1YSelUcSNeEortrV0wqrdlaTQ1EPJo
 apDHtx3+ni6xq0KzZWdYV2cWCPR8LMQzNegMQ/gLJmdawEpLug6sTDESuMQcE4S2wra8u1esN6L
 ehxOV68auUh1RqpkienD+hfKX4xK2xexnCe7Lqlbu+ypCLT5wQMH4jqaugdu8/J04sbrmLFdY3y
 hB6b/u/JPVj7dgtej8NLvFNGKo67KL7c8IJui6d21ed57DNinZJX3A2DG0HG816qs2Bqq4AwFvA
 zbnL4pXXJwBbV9daOx7FuO0XitRwnubNbujsxRppJdiYEmbvbEHTILk5Fpt56urdhntiff5wLpE
 Bslc7M8miajcquF3kzkAKCg6NwnkdPDrblq//TD3aUa5UEcLx8LD/tdZOswH5TvhZYVyTPslHHH
 Zyxqv4EMNa3CmadSGR/SsA8qmcLLiEuMq0ncOfflwJCqTlpzIloclD52cvMzEDe8qiYh/Rw7/g8
 FYtvlMm as3cldQg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Add rules for finding places where str_plural() can be used. This
currently finds:
 54 files changed, 62 insertions(+), 61 deletions(-)

Co-developed-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Signed-off-by: Michal Wajdeczko <michal.wajdeczko@intel.com>
Link: https://lore.kernel.org/all/fc1b25a8-6381-47c2-831c-ab6b8201a82b@intel.com/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Nicolas Palix <nicolas.palix@imag.fr>
Cc: cocci@inria.fr

Since ()s are deduplicated by Coccinelle I removed the duplicate rules,
wrapped the final rules in ()s to catch those cases, and added a "!= 1"
case.
---
 scripts/coccinelle/api/str_plural.cocci | 41 +++++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 scripts/coccinelle/api/str_plural.cocci

diff --git a/scripts/coccinelle/api/str_plural.cocci b/scripts/coccinelle/api/str_plural.cocci
new file mode 100644
index 000000000000..c28cb6f7b803
--- /dev/null
+++ b/scripts/coccinelle/api/str_plural.cocci
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Find places to use string_choices.h's str_plural() helper.
+//
+// Confidence: Medium
+virtual patch
+virtual context
+virtual report
+
+@depends on patch@
+expression E;
+@@
+(
+-	((E == 1) ? "" : "s")
++	str_plural(E)
+|
+-	((E != 1) ? "s" : "")
++	str_plural(E)
+|
+-	((E > 1) ? "s" : "")
++	str_plural(E)
+)
+
+@r depends on !patch exists@
+expression E;
+position P;
+@@
+(
+*	((E@P == 1) ? "" : "s")
+|
+*	((E@P != 1) ? "s" : "")
+|
+*	((E@P > 1) ? "s" : "")
+)
+
+@script:python depends on report@
+p << r.P;
+e << r.E;
+@@
+
+coccilib.report.print_report(p[0], "opportunity for str_plural(%s)" % e)
+
-- 
2.34.1


