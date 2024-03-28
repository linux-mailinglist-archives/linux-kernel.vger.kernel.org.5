Return-Path: <linux-kernel+bounces-122924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F72C88FF8E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0538A1F25EB9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 404E47E77B;
	Thu, 28 Mar 2024 12:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IHs8Oi6B"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BA97D3F5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 12:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711630198; cv=none; b=Ivd87zYJkdUxoQNXWbptv8zDKv2EjUOfZcUrqZVufxS6kL7i35Z2eSG4ugahm0Jr13cDIFuuU24B/yaX7aHPFWDG/WNXRTwiuuVPlLk7Cghgun9uNLsrSGvNgIGd6I9PcDHhldagpukTXc/m9aDMVxHAruH2JcnMER2Ix+37Mp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711630198; c=relaxed/simple;
	bh=AUx/FZ/RU76mHzg4qaAQoDkIORYPJrAzMVU1E7OcnBU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XIM9y6OlF/CTUoHN8/YGojU16gYieMuS+AFtnm+NeAdPO5mC5j79UAMmMD+cAjhpQyIkbf6qGgDdvjePxoEak7dl3Lp1T96i4JkdgCD6HkLRjxfTMl6QJmMvb04gshzAD5ZzhiBeSwTKLaUtfgGHStUb+o5sv9NSIKdTP16cFDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IHs8Oi6B; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dd169dd4183so1072535276.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 05:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711630196; x=1712234996; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V2hEdvFPOs3Q7MZ/48YeLwC2rbA6kByg8D1e17fzf9U=;
        b=IHs8Oi6B5QCHM6FNUqya6j7pwke6Ag5l+vVzVNNCrhxekP6JUqlMsiYzZrlA0ZTyK+
         iRaEZwWQuhoLyC124o0qVcf1agOsMmnSYSXDNTtyBKRFDU9QG10MxqI/MSmFBIYeicxL
         ffiDFtghmyeyRD+p/Iu7YvmZMQJf2CORds7nSmnVk+pRXOmRXERrqIDMaQKFNRibMUn/
         0VoZasTSkSCEDyTyEhM4Zvcbj0a/8cFwH5LArGUQsAbXLHBI0Tk5qdApcVYtxIJ6AA/8
         aNoFEA5FHmGV3DmqKvlctugDKQlYtckEX0nZqyn2WPv/D69PBXiM6KJC5WOAFQo1Xi8m
         7kpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711630196; x=1712234996;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V2hEdvFPOs3Q7MZ/48YeLwC2rbA6kByg8D1e17fzf9U=;
        b=wVHVZWnGu0BdBYk29nfMFFsgGKZy7DiiBo6SI/CPuoETGtpGVPcCkf+0VW6KoRR5s3
         jwNRypt3hVYEXdhYkJZ4ODgl5x6SaxSZUW0iWM7kkDM/QKKiIiJCkWoqCF42Fa7qd1wG
         +PpJO/A1vPsKhIQQzsAS3ab3Hm8WfDG6SJEhToRHRbBvxhEX+Q+hb/dc8atyOMX79B/a
         4NTvA+ltHt3FSwAN2f8k7BcUfMKx+6xjMzVrcJcqI6k6PZIRMZKzDVh3sdDrJEdYR8Qz
         +gl2xDiroeQdKjx/LY+8wlKS4llgL6MOx/eZAxCuLd0IpSRbR8BzmbhtbiLTQzAyfPCA
         AlFg==
X-Forwarded-Encrypted: i=1; AJvYcCUHM52pl5GIzU9/+xgmE3tJ4w0zKl4/FDCoGpVN9jROwlpJsfyjTBWN9W3GlFqKdLAh5oljl1NByEAW0AulwQWN6Z+J02kHeCekqIaU
X-Gm-Message-State: AOJu0YxaduI+dM5yOFU9MK4RcV1nXP1urTaKKFtuC+TeCfOKpB1K0y4b
	I0nxfYma1ro+q6veCNu3tmwP5Wg2LcdWYowaAEnTsTBH1GTopgAJ2P48cpflJSaomk9m0fUqhaP
	Qew+diZMc6Q==
X-Google-Smtp-Source: AGHT+IGt2ygy/VPmzIkHQmiuHIvV0t44t+pVY/Hqx3xUuS/Nkorst0byXe/yT544CQP9wTy7G5WPltAJjbM2lA==
X-Received: from beeg.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:11db])
 (user=jackmanb job=sendgmr) by 2002:a05:6902:727:b0:dc7:4af0:8c6c with SMTP
 id l7-20020a056902072700b00dc74af08c6cmr195564ybt.6.1711630196104; Thu, 28
 Mar 2024 05:49:56 -0700 (PDT)
Date: Thu, 28 Mar 2024 12:49:47 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240328124947.2107524-1-jackmanb@google.com>
Subject: [PATCH] Documentation: dev-tools: Add link to RV docs
From: Brendan Jackman <jackmanb@google.com>
To: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: corbet@lwn.net, jackmanb@google.com, bristot@kernel.org, 
	rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"

I could not remember the name of this system and it's pretty hard to
find without the right keywords. I had to ask an LLM!

Drop a breadcrumb to help people find it in the future.

Signed-off-by: Brendan Jackman <jackmanb@google.com>
---
 Documentation/dev-tools/testing-overview.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/dev-tools/testing-overview.rst b/Documentation/dev-tools/testing-overview.rst
index 0aaf6ea53608f..1619e5e5cc9c4 100644
--- a/Documentation/dev-tools/testing-overview.rst
+++ b/Documentation/dev-tools/testing-overview.rst
@@ -104,6 +104,8 @@ Some of these tools are listed below:
   KASAN and can be used in production. See Documentation/dev-tools/kfence.rst
 * lockdep is a locking correctness validator. See
   Documentation/locking/lockdep-design.rst
+* Runtime Verification (RV) supports checking specific behaviours for a given
+  subsystem. See Documentation/trace/rv/runtime-verification.rst
 * There are several other pieces of debug instrumentation in the kernel, many
   of which can be found in lib/Kconfig.debug
 
-- 
2.44.0.396.g6e790dbe36-goog


