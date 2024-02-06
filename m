Return-Path: <linux-kernel+bounces-55346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA40D84BB89
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 18:03:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30FF9285EA9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146A66AB8;
	Tue,  6 Feb 2024 17:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FBDG1oux"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DA68F61
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 17:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707239011; cv=none; b=KtD+BOmzbO3OYwyLgL2c1s9fMboKepFgPP5ENFs2KGL7YmnzkC3oew+5Xzjz19HxHuCmNjP3sSy/uYNt5mo8FHYPJRWkdiLoUTwmr+0DkDURI46rQa8xdeLy/jLlN28bWWIgaZFZlKKbzbvDyHqGJG02YxD4ruDC6qhaLHhp4X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707239011; c=relaxed/simple;
	bh=U8HuNwUdlEEPLHdv3QRnH+uJMA60aHmIoxCx5CgE2PE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K+G9D2TGt7lVaZ/VpmRxxBKst+qTY3L3K/8mcYxK3R8XYAqUYVxwaIiGX9SURNeT6Shtek+xvyNOfKZaCjaMZ3vIzt4TaeBf3jDN5FLxCDWlgPgJQABTumWaf40ZYNZ6j6+KDzrK2wHPswjZ9ciBJiFuvCjPZ4lIR3fWksjY7Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FBDG1oux; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e04eca492fso1287830b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 09:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707239009; x=1707843809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=umeDhyeqcFKdvC6xxd3vUkMjNRJ2Irf8wU+CDgjfryk=;
        b=FBDG1oux/ky5+k755maPrtT0RG5gwjHPUBqHrZmCgIefVLPFxicCxqVmfF5gHnJTPY
         YV79EDOKb80h0Bb7CHdMR9fzDTjGk+UZ8TrFxJ32tbPPQd6o+6L5QD/R6NyTB/lPfJoc
         zg4WReuTd2L7ZpnWp9I1ADnBf2qQgKV2TvGXo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707239009; x=1707843809;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=umeDhyeqcFKdvC6xxd3vUkMjNRJ2Irf8wU+CDgjfryk=;
        b=I0tLX+HYDOXEayx4MNPH4SzAN7lD7D0GhRmiJjqO2uCgYbkWnFazy487+CDM6TLi8F
         +jzdXfX70P0Sb5WqPYQ5GB0cXOt/++x6WdeaiNNThDqmj0KtFfimARId7qlPO5f6iee5
         ns/Ri8VUmYgxge7brT4yIhl6MrnPAc4fFqkK756Otj/cQEDvqN0vQlfUGPNtJMEx8oc4
         ud5n33Y3dMGENrKvQY9bGr7PftSf2jrmER5Vo8NQSpzsvwHI9jKJrsV+RphMaJdbhorO
         1/qYXA2VyzalzAZ86WTw9G4vC3AoNwlFTqGVvV1DUsQhBpBUqQ39C1QCwUoDtdHKnSjx
         FkHw==
X-Gm-Message-State: AOJu0Yz7ueXtK1yNqr9x2UPxz84ohVv03ejCAbQ8Bzrsi1Tp8JJBKY26
	T2WXCTSOuz87vEdinWjFCzz0p2LbUtXJBD/L72k+jGrqphwBlu0MFR2K+cSU9X8k5w/AGq06Seo
	=
X-Google-Smtp-Source: AGHT+IGvoigLJEbHKpYBrrZJJVxKU9n0m5DvgYvJ8ZsIdLNHqnrzt3qcY0VxotJUZVvRPos9blAcsQ==
X-Received: by 2002:a05:6a00:842:b0:6e0:28eb:275e with SMTP id q2-20020a056a00084200b006e028eb275emr102249pfk.22.1707239007816;
        Tue, 06 Feb 2024 09:03:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWfB/tr7pyFK2HPXESsJ1h9TpKXYrK9eOqf81YqGqlYqEBLTPjHVqjnFSch/E1RwQgtmUg6t/v1lbDkytUEOHoI+aPHG9TJb8Fjr1LUujkShO2c0Xt8LdUmwvicI/JBXQ2643PJqQGtsn/SOX8WNNhexsAZBeu/5DERV85KCPtfxGgG65Nj+Q0Q0nNft5VzbKWpP6fOg0dV1CRjqPX+zVrjeWj5NsaSfE6hrXbQav7R/+4KuONSyqslgF6VURAuJ8bjkvxUDAH/4PFKePXGPHpiSI2lGiW0evYlY2s=
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h4-20020aa786c4000000b006dbda1b19f7sm2168838pfo.159.2024.02.06.09.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 09:03:27 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Juergen Gross <jgross@suse.com>
Cc: Kees Cook <keescook@chromium.org>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	xen-devel@lists.xenproject.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] xen/gntalloc: Replace UAPI 1-element array
Date: Tue,  6 Feb 2024 09:03:24 -0800
Message-Id: <20240206170320.work.437-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1659; i=keescook@chromium.org;
 h=from:subject:message-id; bh=U8HuNwUdlEEPLHdv3QRnH+uJMA60aHmIoxCx5CgE2PE=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlwmZc1Jfxj5fa/YwMvoyvAPkFWN+gRJLJEPn7F
 n308vxItD6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZcJmXAAKCRCJcvTf3G3A
 Jm0GD/oDXr7gvAa43q/4w9dV1f3MZINBzTm2QNk9mHvC7Lp7XSOmcgrCG2Fi8o4c5s5TyWIybl8
 slT25ToB1KNPSc6IPGYoFcQTXwRn39TzQq9T6n+5z5alG6Bz6ZcAk34BQcIm6vfpD3/N11fHF5F
 pdXab4HtiJd2JS9uhggiaHQbN59FGqFQjmpFiouIQ/v5r3awL2QgSC+DznPmZAbee6vD1Rz7G3F
 Ko9yltkr64NVBYCrLDQEylWIDjzGcaMn7kb9npaAYzOCcDcDcQgyfA41idDc+YZlQhxJhuTBe+h
 kHCag8yYsbha7fMXGE+7jHPzjKzE92858eEHiqDJUS+n7u5FMMzarLFrfzeX2LRKJT3oKVKLNhA
 pZ8OYm0q7YJihVOtzaWRo2aNTZ1TpHpDtp7xQo0UFmVh8lcE8p41nIm3bKoC/PbT6ygufKRWEgT
 F1cqwtPM+91yYdVb5HqaHdJ1hIahqo84hQrS6uoeJb2fDi7VWnvopFiUKfVEjWhqUqDo4DCatRo
 9wGXoVt2ljvrVqDQoE56vPuRpeLfSDuLDp/koDL82+UGsSCzmRyXeFrADIlakadryKPFCIqd6xf
 eyoiFXJ0khVBIixLTkPKRY4vvEmldd97HWkoEuj0POSSL7w/8LzGaHlA9x8qqoGsFQwQ6Uvf4U+
 Vekxg2a ltTDiLAQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Without changing the structure size (since it is UAPI), add a proper
flexible array member, and reference it in the kernel so that it will
not be trip the array-bounds sanitizer[1].

Link: https://github.com/KSPP/linux/issues/113 [1]
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Cc: xen-devel@lists.xenproject.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/xen/gntalloc.c      | 2 +-
 include/uapi/xen/gntalloc.h | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/xen/gntalloc.c b/drivers/xen/gntalloc.c
index 26ffb8755ffb..f93f73ecefee 100644
--- a/drivers/xen/gntalloc.c
+++ b/drivers/xen/gntalloc.c
@@ -317,7 +317,7 @@ static long gntalloc_ioctl_alloc(struct gntalloc_file_private_data *priv,
 		rc = -EFAULT;
 		goto out_free;
 	}
-	if (copy_to_user(arg->gref_ids, gref_ids,
+	if (copy_to_user(arg->gref_ids_flex, gref_ids,
 			sizeof(gref_ids[0]) * op.count)) {
 		rc = -EFAULT;
 		goto out_free;
diff --git a/include/uapi/xen/gntalloc.h b/include/uapi/xen/gntalloc.h
index 48d2790ef928..3109282672f3 100644
--- a/include/uapi/xen/gntalloc.h
+++ b/include/uapi/xen/gntalloc.h
@@ -31,7 +31,10 @@ struct ioctl_gntalloc_alloc_gref {
 	__u64 index;
 	/* The grant references of the newly created grant, one per page */
 	/* Variable size, depending on count */
-	__u32 gref_ids[1];
+	union {
+		__u32 gref_ids[1];
+		__DECLARE_FLEX_ARRAY(__u32, gref_ids_flex);
+	};
 };
 
 #define GNTALLOC_FLAG_WRITABLE 1
-- 
2.34.1


