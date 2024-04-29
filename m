Return-Path: <linux-kernel+bounces-162916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5FD8B6231
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F9DF1C21556
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B258A13C669;
	Mon, 29 Apr 2024 19:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8H5tHkS"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FB513B792;
	Mon, 29 Apr 2024 19:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419137; cv=none; b=TMoDGu5zyXsJensjAULbZGYftLXXxO/h57OYBJ14TRXWnhEvzgb2UE6v16nTDZc42yQWrbCSdJ/diqTLGOBU7VAlbugMMzIXJTpz8RcAoTJYJ/e/VQuS4V6X7EXTXWlIaP5aLJ7vTWkmeyMnlkOq3xb74p412BAfGf6gHYKW6Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419137; c=relaxed/simple;
	bh=HtCrrX5c+iiTjbF0YZ4GUlJog3ej7ihnvN5pVpfoU7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tlciVysPO9NIkJmhAWMLIxZf/LrW8x/knDGYTvG8NNqUEcF3BxS2pY9SZTp4HCq1PpQy6/ELquH2Sm6DRHCBYffjtqzznzrFalnPLgYAGLhfb6BAWiTVOgmox1kNB3Yl44vHA/qlTZkaB9wGhicdScidtwKNj1S6N1QdrjRgjro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8H5tHkS; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7ded214dbdcso45344239f.0;
        Mon, 29 Apr 2024 12:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714419135; x=1715023935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDfc87QI/eMI4MzIADapjmb72+cDPF1z6qQEsyJfsGs=;
        b=X8H5tHkSgD7f/mH//Zf/AhSpvl6XchIWQfaX1trBAWm+tjL7Sd76MJMU807eRtKk/N
         OVWt192PgwqAYh3e9yXXzjfvmVIDxr0rmRdX7C8skke4puXN9PfqwqqxbW2wVQFvsh8Q
         8sTBbbWzN+XQmlvCB+5T6wiO6Y25LGO1cuAMiKwfsGVt4EZAKeXLmLzTZZ1mESolR43P
         hVVkrG7IiLSIfR3FUgyZ0jbvWjKtFe8A/exH/BYQbru8jWnroZ7s8Qld0G6X12OUat/a
         hVwmnPb7j9HB9UPL0V2JCHgVDr/yJKg5CBJN4BJhDR5qlGnUvct45ia3SkvPbJxHKw+D
         lqAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714419135; x=1715023935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wDfc87QI/eMI4MzIADapjmb72+cDPF1z6qQEsyJfsGs=;
        b=bBKpABv+eeRkC1FR3vWgUxMSnodycNkShnJpYv31GxMMmR5JcnKsLNTSJD8iovPDkC
         Ah2LAxJlJ6ekw9g0VNw6bX5/Le8w2LU5ykQQ+9O9tv+w+16887gU5oy+K0p6Apy6m/zj
         RXhLNPjsY2CMf9q6K7lZok9YMzOJTgOw+FVglWmGJWXEVlTqpmOPFgCJyaQvDnD1j4FB
         /bU2BLCaLBekW+J+qqMZ6RJdpOLIxqjlfG3rel4p1HrcMTv2RJaxp6ViSdLYwy1T2GUI
         ILa4i3FG/7tAbRw+0aMU7ZvR2g2A3G7mziPBl1sMTWAqkaXXT7IFko0UwnYounWDpYY3
         nBkw==
X-Forwarded-Encrypted: i=1; AJvYcCXESmuPPMeO8c1ngwZwUZ4RY5JUqkjYpHA2HkNF/G9F928uYc3H6B1lu3Z+pv9zSB3q/wf1BZSSZJ1rdtTFZulNaGBL/HUS5oj9TXisImVoWRgcWENsraBgLk36VUnkwgNTQPP+fIRY
X-Gm-Message-State: AOJu0YxaZB/CLeUBzcmloTzEW5lKJO4cvTM26tPyJm+0VTU+zTVTQAr1
	GJtArgWKcwKNo/MK6S5J/bN3ZTqASv/GvBYEA+81rUatouHqlIU1
X-Google-Smtp-Source: AGHT+IFCpqSCEP95iURCr0k1lU6JUePJS0EaRN/GAVW2aKwBMyed7xyc65n15xF4Y5xyFvKbGHsOVw==
X-Received: by 2002:a6b:f715:0:b0:7da:109d:1b84 with SMTP id k21-20020a6bf715000000b007da109d1b84mr13383318iog.12.1714419134673;
        Mon, 29 Apr 2024 12:32:14 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id dq18-20020a0566021b9200b007d5ec9b77aesm5988402iob.51.2024.04.29.12.32.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:32:14 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: ukaszb@chromium.org,
	linux-doc@vger.kernel.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v8 03/35] test-dyndbg: fixup CLASSMAP usage error
Date: Mon, 29 Apr 2024 13:31:13 -0600
Message-ID: <20240429193145.66543-4-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429193145.66543-1-jim.cromie@gmail.com>
References: <20240429193145.66543-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A more careful reading of logging output from test_dynamic_debug.ko
reveals:

lib/test_dynamic_debug.c:103 [test_dynamic_debug]do_cats =pmf "doing categories\n"
lib/test_dynamic_debug.c:105 [test_dynamic_debug]do_cats =p "LOW msg\n" class:MID
lib/test_dynamic_debug.c:106 [test_dynamic_debug]do_cats =p "MID msg\n" class:HI
lib/test_dynamic_debug.c:107 [test_dynamic_debug]do_cats =_ "HI msg\n" class unknown, _id:13

107 says: HI is unknown, 105,106 have LOW/MID and MID/HI skew.

The enum's 1st val (explicitly initialized) was wrong; it must be
_base, not _base+1 (a DECLARE_DYNDBG_CLASSMAP param).  So the last
enumeration exceeded the range of mapped class-id's, which triggered
the "class unknown" report.  I coded in an error, intending to verify
err detection, then forgot, and missed that it was there.

So this patch fixes a bad usage of DECLARE_DYNDBG_CLASSMAP(), showing
that it is too error-prone.  As noted in test-mod comments:

 * Using the CLASSMAP api:
 * - classmaps must have corresponding enum
 * - enum symbols must match/correlate with class-name strings in the map.
 * - base must equal enum's 1st value
 * - multiple maps must set their base to share the 0-62 class_id space !!

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/test_dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
index 8dd250ad022b..a01f0193a419 100644
--- a/lib/test_dynamic_debug.c
+++ b/lib/test_dynamic_debug.c
@@ -75,7 +75,7 @@ DD_SYS_WRAP(disjoint_bits, p);
 DD_SYS_WRAP(disjoint_bits, T);
 
 /* symbolic input, independent bits */
-enum cat_disjoint_names { LOW = 11, MID, HI };
+enum cat_disjoint_names { LOW = 10, MID, HI };
 DECLARE_DYNDBG_CLASSMAP(map_disjoint_names, DD_CLASS_TYPE_DISJOINT_NAMES, 10,
 			"LOW", "MID", "HI");
 DD_SYS_WRAP(disjoint_names, p);
-- 
2.44.0


