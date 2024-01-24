Return-Path: <linux-kernel+bounces-36435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DF183A0AE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:45:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86B531F2884F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE8CC2D9;
	Wed, 24 Jan 2024 04:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bw8f1dlQ"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB96E541;
	Wed, 24 Jan 2024 04:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706071507; cv=none; b=Ag5UTmiEa9mbhPN65qK+2QDyRuqNHKcFW6jCguLPDmBOiz3kXygL5eOMcCv6BxC7qimiUCRCMKIanJeyWe23G7D7s7+1nP7qsPEvectctDa9KThPhfiBPp1UAE9wiCLE811F8VOfKnsYdoLhBwl7sjc+OqsHBtwXouVtT9HjvjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706071507; c=relaxed/simple;
	bh=HG2CE0slLM+zfM9cl3xfZIFM34z86iPxIyEAtAZxsKc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VURvb+pE3co51uvhe9BFjpocoEuEXe4LvdFrHVR/k2bdWosFbv2IVJgqLripySsyXEBqSTPqDxIAIM5JiQbUAFDfpBQWeFY4SZInq53E9vL2wimbF7CQCFKHI9a4cWM+VYFeZvuMRrOqc2LDeaWU8aj3Yl3lABT/Cjf0vapDG2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bw8f1dlQ; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6ddeb015ec6so3606456a34.0;
        Tue, 23 Jan 2024 20:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706071505; x=1706676305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gGgSbSJDivepBAQscRWXv1w+9CizaCLGjHSR1PUV2ww=;
        b=bw8f1dlQ42TeFxuL/ObmaTN8pzL9THyllWnqawKyED+OvQKEYccuVs40OJvb5CfYem
         iRFuE9jn4XMp3svE4JP+U+89v6O3D7rELlCQSmYUilFu93nHG+yYdhLyYCzcswjd+5u/
         J7NH7/ZhZ7KQ9MSoTqMLkAdORRb65+eFk38gf0LvEEE9VcLLA6pCONkn0uu3lz9wzFqW
         AGt8bxFrQhUTsyIQhxfQMQlhFFypPtG/HvjhrEQ1FOTSM9SW91YQP8y7tD4Dag4gjGRy
         oB0SuasNBQD9kALpsdkG/Bs5e1zK3qREyeam498Yf/mN8dt/CMIe71X5InXT5IiWFA1/
         VF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706071505; x=1706676305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gGgSbSJDivepBAQscRWXv1w+9CizaCLGjHSR1PUV2ww=;
        b=sqvfBZp/unWjQjbWSUucqpFhAepOFq3RPqV5dFe6ILgk2id4zuKi4g6VjeBNOYC7yR
         Rn9DabMWWjMCDw57DYYxmXMRp5rDvdrZXmue+gPqn64agu8TOp6JLzkM4v6u/CBK4+W0
         j/aEsXfahSU4qfWdUUyITZN40k73eDQflgh8iNENXZIrCsH3L7I5q5XC231cmCb+iuQz
         OU/p6s2W1dyIKJjP0FwGY7/yhy7MVicGwGT1kZuXSYO1l7Jsc67WhlmfBFTkqn5pDE5w
         KCdRxzG865wNq6kIuti7i1h9tYu4foE8ilq9ZYgYoooRSmuxt/xflvWoGzdctFsq2rBF
         RFBw==
X-Gm-Message-State: AOJu0YzVupuO/AxKTGBVkOAMQJ/M0t7Dzp/P45THxjlpHMvSl7AFjjFk
	NKRnYRsmwLjcLtA29MKAwkXoJpqzGKKDRSDsI87+QChS2FEUgRJ+
X-Google-Smtp-Source: AGHT+IEpVgByW/QWlzRTnlLOnwTOi9AodCnQDVVf7rrk+L4l0By3Z2Y/vxoE0HDz8cq1CZw5wDN3+Q==
X-Received: by 2002:a9d:6a90:0:b0:6db:ffa2:f1fa with SMTP id l16-20020a9d6a90000000b006dbffa2f1famr1066109otq.14.1706071505037;
        Tue, 23 Jan 2024 20:45:05 -0800 (PST)
Received: from my-computer.uh.edu ([129.7.0.38])
        by smtp.googlemail.com with ESMTPSA id bn11-20020a0568300c8b00b006ce28044207sm2442078otb.58.2024.01.23.20.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 20:45:04 -0800 (PST)
From: Andrew Ballance <andrewjballance@gmail.com>
To: mchehab@kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Ballance <andrewjballance@gmail.com>
Subject: [PATCH] docs: sphinx-pre-install fix-noto-sans-cjk on fedora
Date: Tue, 23 Jan 2024 22:39:18 -0600
Message-ID: <20240124043918.31771-1-andrewjballance@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fedora 38 and later changed the directory and package name that
provides NotoSansCJK-Regular.ttc. this adds the new search path and
suggests the correct package if on fedora 38 or later.

Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
---
 scripts/sphinx-pre-install | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/scripts/sphinx-pre-install b/scripts/sphinx-pre-install
index 25aefbb35377..948f284bfc8b 100755
--- a/scripts/sphinx-pre-install
+++ b/scripts/sphinx-pre-install
@@ -421,6 +421,7 @@ sub give_redhat_hints()
 	#
 	my $old = 0;
 	my $rel;
+	my $noto_sans_redhat = "google-noto-sans-cjk-ttc-fonts";
 	$rel = $1 if ($system_release =~ /release\s+(\d+)/);
 
 	if (!($system_release =~ /Fedora/)) {
@@ -438,6 +439,9 @@ sub give_redhat_hints()
 		if ($rel && $rel < 26) {
 			$old = 1;
 		}
+		if ($rel && $rel >= 38) {
+			$noto_sans_redhat = "google-noto-sans-cjk-fonts";
+		}
 	}
 	if (!$rel) {
 		printf("Couldn't identify release number\n");
@@ -446,8 +450,9 @@ sub give_redhat_hints()
 	}
 
 	if ($pdf) {
-		check_missing_file(["/usr/share/fonts/google-noto-cjk/NotoSansCJK-Regular.ttc"],
-				   "google-noto-sans-cjk-ttc-fonts", 2);
+		check_missing_file(["/usr/share/fonts/google-noto-cjk/NotoSansCJK-Regular.ttc",
+				    "/usr/share/fonts/google-noto-sans-cjk-fonts/NotoSansCJK-Regular.ttc"],
+				   $noto_sans_redhat, 2);
 	}
 
 	check_rpm_missing(\@fedora26_opt_pkgs, 2) if ($pdf && !$old);
-- 
2.43.0


