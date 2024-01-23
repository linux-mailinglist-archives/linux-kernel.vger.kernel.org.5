Return-Path: <linux-kernel+bounces-34469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4E7837CAD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CF861C28C2A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624B11482F0;
	Tue, 23 Jan 2024 00:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="S01NyATJ"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246FB1474A3
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969717; cv=none; b=fSQFeEBiClmmyfP6idk/EFFCE0bBiDj3Q7MC2evJNRIB/TRaV2DF0lSz+UYU92BdGD1PjQasykH7sqBAKSiTxAa81YJRWKDs02IO2SA5nEaPbYY6BLdA98f1fNv5VtG4zHkQR2tCSZ7BwoKAfIk52CS96qGnerqVQX9yXN3+WSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969717; c=relaxed/simple;
	bh=+WA9Ct7l0slkMBBzNWpIPaSatsWk1P15wygbjb7RsC4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dBhLfZ6xTdTXvlYZU1uyb9R3YEKGFxTEFZOgs2q4oVJEpxgT13B2o/wxsk+myAvBXC8vf5UTE9CjxCm80GycwePXf0zEco86J/u84mU6RlHjcMbR+xDEPyv1NksePPVIJb6c/rMUB4wGVWJ3M8RPYlZvE8SB/x0aWbAiMsjoVRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=S01NyATJ; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1d70b0e521eso27261995ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705969714; x=1706574514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iepksXH/P2CFRPbU7KRUTTSDHuc6hLdiCJiseIVsFEY=;
        b=S01NyATJigLb2mLJpyjE33kRdf85I3Wf/nPkxVh7yDLUDdybZJ7AWdJ5I9kgEXJpV3
         kVaxs2UfcoKXhMM4OinqBGg+lc7hYcnBfMfbKB5hMjpHnOalQbZSw+NYIeGPJaZZjeAz
         C4nPU/miZEAGTjkPeWiYBj8UHpwiYe+PtrzKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969714; x=1706574514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iepksXH/P2CFRPbU7KRUTTSDHuc6hLdiCJiseIVsFEY=;
        b=M5Gf35ZEApK9RHNVvNfG8Hoa+zZsEcryMsb7TV2788Cd6M7px8FFOTKj7ouo5RzB4x
         iDg1pT9nJZzkJ0WtSyImhncnOFI0lgPsXZ7wOdDz6Y7U3fkQZHWQwMYzDH12cesB52c/
         0Rcx7/Q7oOqAtm3c468AWzPBqN2f/8PSTw5jAU3rDHuek0VhrKH1LocJFsaPYkS1kb/c
         YxrSneSDWPyaEf6/wjpjtS64JwO17MI8X2+QqE0MZXgZ19NJlFsx4aQjM7satbtNCmcQ
         GGtDeY8IN/BLKHa7SGtpnFwGxR6QyTI7sv3d3cfhT9vdCz7kql9THbblb7X3kZt3egfz
         SmTA==
X-Gm-Message-State: AOJu0Yznh8sHSxEBhR6MsNSLzJfV+Iz176hoRsM3BY8Rj6JeTixx+Zra
	4nlEHpqR9RBWBuAsoHqNT5JcfE6lPeRP5yimMTxMy4fd3AXJiwA4Cq1K0fDm9Q==
X-Google-Smtp-Source: AGHT+IHzJfASWaHfc51wxjaPWnFJN6LIKQPulmtu7uPPGg4rctyOF85aFxL98jV7B3g96+HViVRi3Q==
X-Received: by 2002:a17:902:bf43:b0:1d6:f240:91eb with SMTP id u3-20020a170902bf4300b001d6f24091ebmr4675643pls.105.1705969714532;
        Mon, 22 Jan 2024 16:28:34 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jv13-20020a170903058d00b001d72bd542d7sm4491222plb.139.2024.01.22.16.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:28:25 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Jonathan Corbet <corbet@lwn.net>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Bill Wendling <morbo@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 04/82] docs: deprecated.rst: deprecate open-coded arithmetic wrap-around
Date: Mon, 22 Jan 2024 16:26:39 -0800
Message-Id: <20240123002814.1396804-4-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2640; i=keescook@chromium.org;
 h=from:subject; bh=+WA9Ct7l0slkMBBzNWpIPaSatsWk1P15wygbjb7RsC4=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgEcKz/IVh6AHW78ErpCaprSPaxdFMlZJU/p
 nEc33LkKJKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IBAAKCRCJcvTf3G3A
 JhDJD/4/hiDapZrRx3IUC8fORd2j7RQere5tpaqVjlU5VBEohjnZfgBrSaXLPJD3ittOSfiXpTV
 qwoChxq3tWBiw0rfSBAYOH5WTvj8crGO3YuggDjqh4H5lWZE77jcjns+LHN4vk56akzliSAXuZv
 VpJFUEbbPanlEo7ifJ9/ad7kPFB9q8vay7oT5hyuXlwp2drF/8gXQm+OisW84paPv9aM7FVgdSK
 BOXiuS6NzexkgeL8ppxZpxnGFruM8P5k0nKF6E+MskMuhJdeF7ZrwT9dFIeh2ZXUSNJ4k2Hxm9J
 hOaRQOVTLjPqkpfWOZKhvx4v908ITNUY0cicWNEJEXCDJzfpqMigkbIcLkrQ5xJk+7Mes5FAOdR
 fff5zKQdAT9bOjzhNoB8jjFopHoZ+gCVG4UoKKaHT2tx+gL2UnntgHBN8ErFZXqPzjO3vL48Vpy
 6zksiU8rnxZJOwYvYhiKE/0cxuoLBZh8MxA1OChyYAd+/1b2opzH1Xt/LXRZBz74jkFjCms7dpT
 U8+hjmblmd9nBpW3KwV3tVsXLztPgCXvBPZmoQp+0WaQPLGoqe0NE113GE6RGQyuaNN8QzmK3RK
 bPN3+gpjk7+hsX8K8CgR5LtYZJ0RCqkseGqMTmep+SuHpjigvNLo7eykHRtozTskavBta9U0tGc WLmj1ykhZxc4g5g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In pursuit of gaining full kernel instrumentation for signed[1],
unsigned[2], and pointer[3] arithmetic overflow, we need to replace
the handful of instances in the kernel where we intentionally depend on
arithmetic wrap-around. Document this goal and provide an example for
the most common code pattern, checking for simple overflow:

	if (VAR + OFFSET < VAR) ...

Link: https://github.com/KSPP/linux/issues/26 [1]
Link: https://github.com/KSPP/linux/issues/27 [2]
Link: https://github.com/KSPP/linux/issues/344 [3]
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Justin Stitt <justinstitt@google.com>
Cc: workflows@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/process/deprecated.rst | 32 ++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
index 1f7f3e6c9cda..270f3af13b86 100644
--- a/Documentation/process/deprecated.rst
+++ b/Documentation/process/deprecated.rst
@@ -109,6 +109,38 @@ For more details, also see array3_size() and flex_array_size(),
 as well as the related check_mul_overflow(), check_add_overflow(),
 check_sub_overflow(), and check_shl_overflow() family of functions.
 
+open-coded intentional arithmetic wrap-around
+---------------------------------------------
+Depending on arithmetic wrap-around without annotations means the
+kernel cannot distinguish between intentional wrap-around and accidental
+wrap-around (when using things like the overflow sanitizers).
+
+For example, where an addition is intended to wrap around::
+
+	magic = counter + rotation;
+
+please use the add_wrap() helper::
+
+	magic = add_wrap(counter, rotation);
+
+Another common code pattern in the kernel open coded testing for overflow
+by performing an overflow and looking for wrap-around::
+
+	if (var + offset < var) ...
+
+Instead, use either check_add_overflow() (when you want to use the
+resulting sum when it doesn't overflow) or add_would_overflow()::
+
+	if (add_would_overflow(var, offset)) ...
+
+In rare cases where helpers aren't available (e.g. in early boot code,
+etc) but overflow instrumentation still needs to be avoided, it can be
+replaced with a type max subtraction test instead::
+
+	int var;
+	...
+	if (INT_MAX - var < offset) ...
+
 simple_strtol(), simple_strtoll(), simple_strtoul(), simple_strtoull()
 ----------------------------------------------------------------------
 The simple_strtol(), simple_strtoll(),
-- 
2.34.1


