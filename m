Return-Path: <linux-kernel+bounces-61016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5CA850C4E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 00:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE652B234D6
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 23:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F911772F;
	Sun, 11 Feb 2024 23:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="fLqLrnNq"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16F5A38DE4
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 23:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707693370; cv=none; b=rbznNPE8I8daiQccGUvK7NVEXqmrI7gXPhtJbSTFy7f1gRs5pbSUZgcNQ6wmWgsnrbC3iq6kU2H5QTRAGDvLIsAo8xtU3zvEVk6jPMUTKwCPPZxJTLvKYtFd3r9j7OWxsG0Ied+kXfQp4oeOC3lPNlnMubdkClVTs1O1wBoO3TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707693370; c=relaxed/simple;
	bh=HgB9s5w0AlPuLVyJkL0iJmSauVG9XEFFZWYHG9S9I54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E+2UgCkInB5zbgDscf4E/3NQOcVpuG0XNMFGE37OmgKP9AEV2XAL1xzZa9HEkZEyfg3DJyZsw2FCqAmAv6BC7nIafOgfaXjPyIIh3Noa2n4yKE/qqQnyc3W8Z5ZOJVCpgq11zOwPPERypq/ukCc17eQ8QXFEIjGaK6Ir74BQM1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=fLqLrnNq; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d090c83d45so36390351fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707693365; x=1708298165; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwHtii56Sk9j6aWasrwO47WYwdkHuwukNe9vK4w9g6U=;
        b=fLqLrnNqNTGw99jKxr6BP8rW5oBv7PY2SRhxW3sNX8/zB7qfa/tRf5+R35TjSNNXLk
         Bhs169/tgLNOT45ZtZUVZho7BHBi50ofVxjpV2bycRXASgl7QIJOamxwjIi5QTXxMW13
         CPrE/Irs5bPR1THvH8ehMMkmo+jyNArpfZSHEwyf0r1+84E6+0rKmJ2hUuDvaRx1G6CL
         H/I9tLaFAloJtCD37xW7R00qGI3vZRzUHSKfNpBlVPV1R9dk4mRZAe17Gdr1lNEWdWY7
         FM1TyzCIm1HMT+13FoEdvCtP8tVAMOT2z+kLNHe4+BkUTJhJ7a2c8rbKJR0UvZeI+p8s
         XIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707693365; x=1708298165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fwHtii56Sk9j6aWasrwO47WYwdkHuwukNe9vK4w9g6U=;
        b=RA4S5dKxytpeflaTr2vQZ2jhp7zG5CMp8NGy47KZrZnWLhzwhGQw0RoNpZEL2ke/Bz
         6b8GV1WXa6/VFZD6ok2swM339e0mVoY3yrW8o32LbpmtQP3HqAPq3TyS/T00Rhf0KJFp
         WXa+rhVsa5K3BG4PQa7vWaw7YPXd0UKqOwhaNB7m9g1vad/x9jl7JUZzHOa+8KUQZMl1
         w9g3KK/ynx4TiCtHKcLyL9ASCPmtX90wcdMNKybyRC9UYjAmjZjo008sK1Xn/R5Jn/Uc
         fEA3422g7bKKwWvCmPsciLnE8WcsSWZnnckeQI0QUu70gPbnRmhqnWtiRtkb3hD+0hXz
         g5aA==
X-Gm-Message-State: AOJu0YxSDhcubrJlPOlhIZJsUw7VL0mJtKdBPZ2p/Gsr31XHg1c9r4o3
	bhjSoCsYwknt+OGWzHUs9bpVHGaiNa5VIewsckW54PpLPxtv+cTnf6LRheVzK3RhVW6h1y1kKB6
	x
X-Google-Smtp-Source: AGHT+IFGhArMbG78TCKgIoriFXen4KegUTE9t1rSet03Y/jJ+WydoDgDzytmhd426RLzNDFT84MbSA==
X-Received: by 2002:a2e:b0f2:0:b0:2cd:9503:f91 with SMTP id h18-20020a2eb0f2000000b002cd95030f91mr3026829ljl.15.1707693364749;
        Sun, 11 Feb 2024 15:16:04 -0800 (PST)
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id et13-20020a056402378d00b0055d19c9daf2sm2170180edb.15.2024.02.11.15.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 15:16:04 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH v4 34/35] linux/kernel.h: move PTR_IF() to ptr_util.h
Date: Mon, 12 Feb 2024 00:15:17 +0100
Message-Id: <20240211231518.349442-35-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240211231518.349442-1-max.kellermann@ionos.com>
References: <20240211231518.349442-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reducing dependencies on the header linux/kernel.h.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 include/linux/kernel.h   | 3 +--
 include/linux/pm.h       | 2 +-
 include/linux/ptr_util.h | 7 +++++++
 3 files changed, 9 insertions(+), 3 deletions(-)
 create mode 100644 include/linux/ptr_util.h

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 6f436367dd16..e323fe139cc8 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -32,6 +32,7 @@
 #include <linux/sprintf.h>
 #include <linux/static_call_types.h>
 #include <linux/instruction_pointer.h>
+#include <linux/ptr_util.h>
 #include <linux/wordpart.h>
 #include <asm/byteorder.h>
 
@@ -39,8 +40,6 @@
 
 #define STACK_MAGIC	0xdeadbeef
 
-#define PTR_IF(cond, ptr)	((cond) ? (ptr) : NULL)
-
 #define u64_to_user_ptr(x) (		\
 {					\
 	typecheck(u64, (x));		\
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 34cf20dd1ad1..cccf320b67f6 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -9,7 +9,7 @@
 #define _LINUX_PM_H
 
 #include <linux/export.h>
-#include <linux/kernel.h> // for PTR_IF()
+#include <linux/ptr_util.h> // for PTR_IF()
 #include <linux/list.h>
 #include <linux/workqueue_types.h>
 #include <linux/spinlock_types.h>
diff --git a/include/linux/ptr_util.h b/include/linux/ptr_util.h
new file mode 100644
index 000000000000..7469aff978a9
--- /dev/null
+++ b/include/linux/ptr_util.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_PTR_UTIL_H
+#define _LINUX_PTR_UTIL_H
+
+#define PTR_IF(cond, ptr)	((cond) ? (ptr) : NULL)
+
+#endif /* _LINUX_PTR_UTIL_H  */
-- 
2.39.2


