Return-Path: <linux-kernel+bounces-167004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B198BA348
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28C9E1C20863
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBAA324A08;
	Thu,  2 May 2024 22:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="h0EfiOOh"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD791BC58
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 22:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714689227; cv=none; b=Hx92p3F8YkqnzuFSZVPae2jzcd4EKtFFSm1LghBqg/y1GN6VtReMCK6VgCHJJa+XwWbE+VSCY+VmCGrkYut+NaQa0IoRy8D60cBnfbbaSXNvXrro/evoIlGHABGMHd400RRfT5BrM87HXpgtZMYKJQBQ+svnMTZL/Xcpgg5fd+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714689227; c=relaxed/simple;
	bh=WtgCtyIMNT2LXHS8P/KpT13C94RxNhKJ7RovKI+clEE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=INgqHVGCutweDa9gOYtvSvMPSl/llimJmES8v7PKf3hmeN1Hpm84zUJJnvT5JP1KjCkv+mNSCmlp8Y9SBULgdpW51Seag7U1DPANvq44vl0rlG1czUTGHTrpJFz7jxpWVI06Tn0WltPL9q6kw+30wR1HA1r7bTrtC3OEZIwGQaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=h0EfiOOh; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6f4178aec15so2719380b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 15:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714689226; x=1715294026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FS85aS0uSYWPmkJmR+HxkNl8OY9pDJKR/ix6jc3gM1o=;
        b=h0EfiOOhmq8PjQZgn8+PA/uRz1CCoSzsd5+0RMCsycrlsl8RuGIlxlQ675/ukdYLNr
         kueqkcinV0iWaagkejkVrPFgPDVgq0BKWAb5/YmMJUbWPES5NS2MftK8kywHq+VdNSq1
         EGz0UoCxdBCbt4etTLesRg3eAKRXxfKLgSoAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714689226; x=1715294026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FS85aS0uSYWPmkJmR+HxkNl8OY9pDJKR/ix6jc3gM1o=;
        b=LgkQ36JG/H4kG/xtygDYh9w3dFveM3lvWRvKqgTulHKRbiEIsfyzI+2vGPZ4gjAj3U
         HrMipKVbO4+TwK2bWBhR389XfATDW29Uh+pQxvOb23F2e9owHZ3N8nVh4bZArP/QNf4n
         SGCSGKstRsKjOYd99WT8MsoeNGl1oTEjxFAa39lXsU5TQJrQEyC2xDWktkhwViGb5ija
         wKHFiXV3pIZiHB1p1EKGceFm0K3Mhjd7gCmE7eGZbO487Un0B3XPJXa+1MThyDbqtTlp
         D7g7c67eBgNoZ0loeyb/ms/ofKUCPdGIkZDpNYFoP9NWrLZQda8PQQl1j7DrK1AFWFTV
         LU5A==
X-Forwarded-Encrypted: i=1; AJvYcCWMcGV581kpekDwjKvt4gldoXPOm3TLNTz6D5jsg4gmJLe2ZttKy6ek22AepRghu/GOs7q8yJ753Nmr0Sd42ZsK9lVcwZcvrsvAFKIw
X-Gm-Message-State: AOJu0YysM/OFaT/r9ZuaSKWEPTRU1NCDvkBOZleL3LBn8hhqg+3ey8vo
	3UdhNlVLeVuM5hKxIvYtQMx4Mhml7vs2S9UOiaRclpFFX0YP28k4E3yEMIUJjA==
X-Google-Smtp-Source: AGHT+IHPqWSEIWAkmTHA3m+ip5N1siYc+jc02yV1sSYNCUk2VbsJlQut2h0V+Wbt+chL+SgMhgBGWw==
X-Received: by 2002:a05:6a21:1f27:b0:1ac:6762:e62e with SMTP id ry39-20020a056a211f2700b001ac6762e62emr1201922pzb.30.1714689225930;
        Thu, 02 May 2024 15:33:45 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id eu6-20020a17090af94600b002b3631c9270sm2784217pjb.25.2024.05.02.15.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 15:33:42 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	Zack Rusin <zack.rusin@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Matt Atwood <matthew.s.atwood@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	linux-kbuild@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 1/5] fs: Do not allow get_file() to resurrect 0 f_count
Date: Thu,  2 May 2024 15:33:36 -0700
Message-Id: <20240502223341.1835070-1-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502222252.work.690-kees@kernel.org>
References: <20240502222252.work.690-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=923; i=keescook@chromium.org; h=from:subject; bh=WtgCtyIMNT2LXHS8P/KpT13C94RxNhKJ7RovKI+clEE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmNBTDS8z47/RFROL1IOhhstMS1R8chpsln1UTA /ua0FxEWaCJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZjQUwwAKCRCJcvTf3G3A JmiTD/9h3vxAjfd+x38LUO8iBg0XaVYG0fE+uUAgPtl4+tThkzIHVPwRZvUaAttpv0rxblAgfyt blgim7dvZLmsZwvtY+fG0B7Ex0KmlH4jF9o/0oOrFCCJcHFKogjX9q8vOq7nXb0AutdLQxXbALT Gi07OKXY6BfixXgXojnjmDsDX37JKM+9aMT/Js5FWDOhIaFSpn/b4bEgh4VvE5aUCW2AMcqbZUa 5fIMXU+GdA6q1EHkPu/V/oANVb9vi6kkL3MQRMd2Q6yY/QjA5EVHCA2u8w+Wu2DgUCffgY3zli5 QvqPOdlTd2unyBGzT+05ygn2f+4E7JW9FczuGQ9wfArVgUiCUZ5OrOhU7YpgHTgtmZhuA/XKvrb 2uemrbNiU2fmNpil1TqgxnryEz0MfaYDb8BjLOmchF87oBK0wKbVOHNJjVVSoKmqPh3qEk1jC2s uHic4zSh8WIZc/ycwpUNqcghKK0fL0v0apyhBiLHa7PYDDRWE89n4xXFDk8p3es23xa8pvtFZ3p xrXlj4DW1sDT08plpkk0UXHYq6K8qAaSw1Ts1IwjwkVHo95wmegwPwc3/U1ZfqsuTr9BG7ugDI5 LiSdxoiZF/Q9dl04c99LliAAzAHYWqj9BQJwJkkOe2KTTQ5L/Hi4L4GT4RdcdaHuJAF0JTaTtR2 hEa2Zvq5tUpbQpQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

If f_count reaches 0, calling get_file() should be a failure. Adjust to
use atomic_long_inc_not_zero() and return NULL on failure. In the future
get_file() can be annotated with __must_check, though that is not
currently possible.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org
---
 include/linux/fs.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 00fc429b0af0..210bbbfe9b83 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1038,7 +1038,8 @@ struct file_handle {
 
 static inline struct file *get_file(struct file *f)
 {
-	atomic_long_inc(&f->f_count);
+	if (unlikely(!atomic_long_inc_not_zero(&f->f_count)))
+		return NULL;
 	return f;
 }
 
-- 
2.34.1


