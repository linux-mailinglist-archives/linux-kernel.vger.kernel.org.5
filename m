Return-Path: <linux-kernel+bounces-104359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD9687CC96
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CA57282EA5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D8463A29B;
	Fri, 15 Mar 2024 11:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="febbbb5S"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760DA374F8;
	Fri, 15 Mar 2024 11:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710502753; cv=none; b=fB2d6dblCSodsQ+TNXJNpu/iWreB4qE9IDdhG2lIQesfcninPAS8lghhVXcPSXWi5G/y/zIKaCoLQ52131If1aWb9WVO+TpTQ8CFOemi5/5wEPyHwzA1w94ibM8fkz5Bh9GrZp+LoHgZitgj6Q/cccHd5sjh4L/RvyOLWXJTTRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710502753; c=relaxed/simple;
	bh=q188HzvOUC/SWbrcVrOvRopYEaFyTUWDEJRgbVqCiO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I1HJJ5RUty+aY8gHBKX3MTUgHNz83m5naLib43FivFVnki0hL9IiiSSbVmhlUBudXg2vM777wznyTLbZ8KvU//COKVqbao3pooKyfPfj8+yDLDqOu1c1hNcvToo7IbON2hSWoRsMlQlUBCWSAuRO1FUvQjmA3SXN5Dwzm3/ldHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=febbbb5S; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-563c595f968so2579136a12.0;
        Fri, 15 Mar 2024 04:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1710502750; x=1711107550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cfmF9oVuH/nqtcAZ9ZoTPovZTcMFlC6oTWbI9R5zfGA=;
        b=febbbb5S6zucEme1c3YDVJghkJzmoxo53V2i8FKe9wvFAw3ovHOIY1VaJ1rXM1FKxF
         EQ4Xiju5bVy8M11BrOdiy3vUmbspXL2M6zwvc3xBLGvVJqQ6bHvdswXPGvBd9blqHhrL
         rEmQeU78d9jw0RJtzilfFr8svnEe9YPpBhSLQb8kJC32PBcmRj5Q4TE926YZsWaP4+NB
         JQZKjPRGnVV+tGM4WvREV8XhWf43E50WOQXFe8ke11kue1PSufxmpEgoANbtstYdNMTV
         y11Sn17VmZA0dKj7/sidoFrM2A9Laz67lVa+9xOtPd3U7TpuvvcWjf6e1TYU4Bx/sTC2
         CwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710502750; x=1711107550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cfmF9oVuH/nqtcAZ9ZoTPovZTcMFlC6oTWbI9R5zfGA=;
        b=iJYHXdQuvK6x3RW7EJnyreV34G/dgUcEJw3F4TVNC49Vtg0LSau6dTNMajsYkrYDpn
         JVDmFNBq06eShid3Vj3XMCwBvUi3ZOtClTTDGjB7n8/DXDns9Sz7LtQZ/rsPQyasJFLi
         wL9/tsNrb54gjg1wjuR9gwI3YxU5BLp/Cn4Y2Wgt53Nju+rx2brG75QfIbZQJRLDfCYe
         SUMWmAVrZ39p9ak3YXmXqOPlyT5awee/omWFsCOW4enwC9pFhktKOPkhCRSd6agKIefb
         5LBcXfHORnVvsDdi2EOWs3tB7X5OerpE+g3Y0i9MGxaW/MnDu1XmpZfB2RDMUoQOj96S
         +VmA==
X-Forwarded-Encrypted: i=1; AJvYcCXy8EFAigHF5YWFoPDslQK6rWEpddaq/43rvIOhxfaJk8BteoAMQ1b0aj/7xVshtYckx+KLHxsCLLGng1c9LvEvBnjaKef/NYTi/Iid07WiAPYoGw8HPp9kEHgqe+Tvcc/G
X-Gm-Message-State: AOJu0Yx6d9NHFovyx7tYBhYk1Q1ZeXErtVU3hCUbQLFFtECKVjhUBH5T
	pFHXP5wTRUqHyuQ291n2ImSSfKuipm1ZzqfDObj3QP4I347kdhmwg0VpbfV84qpD6A==
X-Google-Smtp-Source: AGHT+IGW1uWxdTJiFXfLpY+Fl3cbOeeZ6/+E5blbanUFwgZizbLKEo3Rs6c248+0TJkAzhcIeBzNLQ==
X-Received: by 2002:aa7:cd58:0:b0:568:260b:e502 with SMTP id v24-20020aa7cd58000000b00568260be502mr2091951edw.13.1710502749840;
        Fri, 15 Mar 2024 04:39:09 -0700 (PDT)
Received: from ddev.DebianHome (dynamic-095-119-217-226.95.119.pool.telefonica.de. [95.119.217.226])
        by smtp.gmail.com with ESMTPSA id fg3-20020a056402548300b005682f47aea7sm1610024edb.94.2024.03.15.04.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 04:39:09 -0700 (PDT)
From: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>
To: linux-security-module@vger.kernel.org
Cc: Serge Hallyn <serge@hallyn.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	linux-kernel@vger.kernel.org,
	cocci@inria.fr,
	bpf@vger.kernel.org
Subject: [PATCH 10/10] coccinelle: add script for capable_any()
Date: Fri, 15 Mar 2024 12:37:31 +0100
Message-ID: <20240315113828.258005-10-cgzones@googlemail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240315113828.258005-1-cgzones@googlemail.com>
References: <20240315113828.258005-1-cgzones@googlemail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a script to find and replace chained capable() calls with
capable_any().
Also find and replace capable_any() calls where CAP_SYS_ADMIN was passed
as first argument.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
---
v5:
   add patch
---
 MAINTAINERS                              |   1 +
 scripts/coccinelle/api/capable_any.cocci | 164 +++++++++++++++++++++++
 2 files changed, 165 insertions(+)
 create mode 100644 scripts/coccinelle/api/capable_any.cocci

diff --git a/MAINTAINERS b/MAINTAINERS
index f4d7f7cb7577..32349e4c5f56 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4731,6 +4731,7 @@ S:	Supported
 F:	include/linux/capability.h
 F:	include/uapi/linux/capability.h
 F:	kernel/capability.c
+F:	scripts/coccinelle/api/capable_any.cocci
 F:	security/commoncap.c
 
 CAPELLA MICROSYSTEMS LIGHT SENSOR DRIVER
diff --git a/scripts/coccinelle/api/capable_any.cocci b/scripts/coccinelle/api/capable_any.cocci
new file mode 100644
index 000000000000..83aedd3bf81d
--- /dev/null
+++ b/scripts/coccinelle/api/capable_any.cocci
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/// Use capable_any rather than chaining capable and order CAP_SYS_ADMIN last
+///
+// Confidence: High
+// Copyright: (C) 2024 Christian Göttsche.
+// URL: https://coccinelle.gitlabpages.inria.fr/website
+// Options: --no-includes --include-headers
+// Keywords: capable, capable_any, ns_capable, ns_capable_any, sockopt_ns_capable, sockopt_ns_capable_any
+
+virtual patch
+virtual context
+virtual org
+virtual report
+
+//----------------------------------------------------------
+//  For patch mode
+//----------------------------------------------------------
+
+@ depends on patch@
+binary operator op;
+expression cap1,cap2,E;
+expression ns;
+@@
+
+(
+-  capable(cap1) || capable(cap2)
++  capable_any(cap1, cap2)
+|
+-  E op capable(cap1) || capable(cap2)
++  E op capable_any(cap1, cap2)
+|
+-  !capable(cap1) && !capable(cap2)
++  !capable_any(cap1, cap2)
+|
+-  E op !capable(cap1) && !capable(cap2)
++  E op !capable_any(cap1, cap2)
+|
+-  ns_capable(ns, cap1) || ns_capable(ns, cap2)
++  ns_capable_any(ns, cap1, cap2)
+|
+-  E op ns_capable(ns, cap1) || ns_capable(ns, cap2)
++  E op ns_capable_any(ns, cap1, cap2)
+|
+-  !ns_capable(ns, cap1) && !ns_capable(ns, cap2)
++  !ns_capable_any(ns, cap1, cap2)
+|
+-  E op !ns_capable(ns, cap1) && !ns_capable(ns, cap2)
++  E op !ns_capable_any(ns, cap1, cap2)
+|
+-  sockopt_ns_capable(ns, cap1) || sockopt_ns_capable(ns, cap2)
++  sockopt_ns_capable_any(ns, cap1, cap2)
+|
+-  E op sockopt_ns_capable(ns, cap1) || sockopt_ns_capable(ns, cap2)
++  E op sockopt_ns_capable_any(ns, cap1, cap2)
+|
+-  !sockopt_ns_capable(ns, cap1) && !sockopt_ns_capable(ns, cap2)
++  !sockopt_ns_capable_any(ns, cap1, cap2)
+|
+-  E op !sockopt_ns_capable(ns, cap1) && !sockopt_ns_capable(ns, cap2)
++  E op !sockopt_ns_capable_any(ns, cap1, cap2)
+)
+
+@ depends on patch@
+identifier func = { capable_any, ns_capable_any, sockopt_ns_capable_any };
+expression cap;
+expression ns;
+@@
+
+(
+-  func(CAP_SYS_ADMIN, cap)
++  func(cap, CAP_SYS_ADMIN)
+|
+-  func(ns, CAP_SYS_ADMIN, cap)
++  func(ns, cap, CAP_SYS_ADMIN)
+)
+
+//----------------------------------------------------------
+//  For context mode
+//----------------------------------------------------------
+
+@r1 depends on !patch exists@
+binary operator op;
+expression cap1,cap2,E;
+expression ns;
+position p1,p2;
+@@
+
+(
+*  capable@p1(cap1) || capable@p2(cap2)
+|
+*  E op capable@p1(cap1) || capable@p2(cap2)
+|
+*  !capable@p1(cap1) && !capable@p2(cap2)
+|
+*  E op !capable@p1(cap1) && !capable@p2(cap2)
+|
+*  ns_capable@p1(ns, cap1) || ns_capable@p2(ns, cap2)
+|
+*  E op ns_capable@p1(ns, cap1) || ns_capable@p2(ns, cap2)
+|
+*  !ns_capable@p1(ns, cap1) && !ns_capable@p2(ns, cap2)
+|
+*  E op !ns_capable@p1(ns, cap1) && !ns_capable@p2(ns, cap2)
+|
+*  sockopt_ns_capable@p1(ns, cap1) || sockopt_ns_capable@p2(ns, cap2)
+|
+*  E op sockopt_ns_capable@p1(ns, cap1) || sockopt_ns_capable@p2(ns, cap2)
+|
+*  !sockopt_ns_capable@p1(ns, cap1) && !sockopt_ns_capable@p2(ns, cap2)
+|
+*  E op !sockopt_ns_capable@p1(ns, cap1) && !sockopt_ns_capable@p2(ns, cap2)
+)
+
+@r2 depends on !patch exists@
+identifier func = { capable_any, ns_capable_any, sockopt_ns_capable_any };
+expression cap;
+expression ns;
+position p;
+@@
+
+(
+*  func@p(CAP_SYS_ADMIN, cap)
+|
+*  func@p(ns, CAP_SYS_ADMIN, cap)
+)
+
+//----------------------------------------------------------
+//  For org mode
+//----------------------------------------------------------
+
+@script:python depends on org@
+p1 << r1.p1;
+p2 << r1.p2;
+@@
+
+cocci.print_main("WARNING opportunity for capable_any",p1)
+cocci.print_secs("chained capable",p2)
+
+@script:python depends on org@
+p << r2.p;
+f << r2.func;
+@@
+
+cocci.print_main("WARNING " + f + " arguments should be reordered",p)
+
+//----------------------------------------------------------
+//  For report mode
+//----------------------------------------------------------
+
+@script:python depends on report@
+p1 << r1.p1;
+p2 << r1.p2;
+@@
+
+msg = "WARNING opportunity for capable_any (chained capable line %s)" % (p2[0].line)
+coccilib.report.print_report(p1[0], msg)
+
+@script:python depends on report@
+p << r2.p;
+f << r2.func;
+@@
+
+msg = "WARNING %s arguments should be reordered" % (f)
+coccilib.report.print_report(p[0], msg)
-- 
2.43.0


