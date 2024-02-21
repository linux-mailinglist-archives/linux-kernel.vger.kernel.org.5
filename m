Return-Path: <linux-kernel+bounces-74399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4006C85D381
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7188F1C216D9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448A93D961;
	Wed, 21 Feb 2024 09:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tjt4n3eJ"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1616A3D551
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 09:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708507688; cv=none; b=QdZQGZOGOsDzjSYvea+xrPY7+mh9pcizV1SgakZGVIiplky0BxkC48f51coesmdTKrT5RMpB1f/oZKCmdEIWcwJ7brX31hpdsdGNCEx8vpSbN7yKjRECb9FyzRa2mM3SY62b7WG3MEkVBIZCYIPnJWa297IYptWXlcTqog+1zxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708507688; c=relaxed/simple;
	bh=oHmG0+uAlgPHog1/cM3f+yE6TgqouD3e0qjE2/guiC8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pnQ/cHCcxA7O/FldPyYLXPv7i5mtZ/Ml7NXoDsYrMMhS/iPIHQ4ouldQK4jslv6SswB6dSbNP4Lx3BlIyYbJ6RbKK0D4X5NioCtNuFIcXy1KJPBNmNDl4ZwHZkc5vYKcSdhg0yr3QGRsYARFTZJrsCPdJfm4y3jfkM7sBgBTC+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tjt4n3eJ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf618042daso10802280276.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 01:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708507685; x=1709112485; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xu+inTe2LF3ynuuv7W7Ho6VSuZooh3VEfNa1s4AiQic=;
        b=tjt4n3eJokRHzTY63qkAIPpMP+w8B503sAGRac2GqoBgdZvlfguvV+WA4ImnDeylDn
         BE/pE/bJGWedcv2VC7gxC33KaDf9ngF2esnpaGcEetHogxg+d79pLQXZUYDU6FrokN3D
         A0Dmssb/FQ+M4ouk5mU2CgpG6aEuji6sRsyFwG+w3Yj4Ml+LRIx3H+1ULNtv/CulMefZ
         Df0LCpeZQic2QnwqQIhSlbYcLxxet1+vpLfWeeptddEWoYZh1ZbHgQQJcg29arLq4I94
         khCo22xZb62JYbPhHNK9Tnl6r4iejJco6NqmVACUz+HTFZWnnoccQwtbJ/FGa9BAtfuk
         3beg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708507685; x=1709112485;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xu+inTe2LF3ynuuv7W7Ho6VSuZooh3VEfNa1s4AiQic=;
        b=sUO+gTiU7aOVYp9L7oEd8W1M+K98EhGFYfVS/8Ppv6QpFpY3Xcsr/r+mLXaUBxaMrZ
         c/akS/IwXiieNmQyddpsSA8XPk0RknVEs3J6BnmeWgszHJSe4LeUMTINiTg3d7EfIEyD
         I8lLCKcnvBXp5cFlNHTC7soxuGTSxn9oYEVTVbWiiZUOvEqVRtc9VSMHiyb8foZ0cuyr
         SuiStJm1zuUcXxnztE+fiDVQeiIiDqTxPx/vFZ3Dz8eoMbytXcIxgtVKDSWaZ3sBmwOl
         dDEifvNRdcUCyA51l3upVNtdxOl04a6xxZkXNHheYf/C3odJ0iiskCDgDorJ1VAisfrq
         HoXg==
X-Forwarded-Encrypted: i=1; AJvYcCXf017aPAKzdjtOC5u5s3X7tqAc7APIj6BSfnVaY+plc/QCK1etLTFZwYZWkdUnKJa0t5++7kd8d9UPeDI2/FXVQfrTYBGi6SQZklQP
X-Gm-Message-State: AOJu0YwwX0Q7aOF+aQwXZoXSkwTktBtrijDKUYi7T54X65BhzCigFbNK
	u3iFbQWYZSygrzePsmyl9nEuuY9cC6yy4zgKpO84GRP4v9AKcVArs/NRRL/4XYRNxRwI2JZDeWx
	sPotWWIyqyQ==
X-Google-Smtp-Source: AGHT+IFRWRv9O0ZJFWIQABWXYSjWTv0ZUYrlwMd+3gPavDYER8N+pRX59ZNK2IiQ8Dvkd5y8wLfb4lO8UUdSxw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6902:1005:b0:dc7:59d9:7b46 with SMTP
 id w5-20020a056902100500b00dc759d97b46mr624383ybt.3.1708507685189; Wed, 21
 Feb 2024 01:28:05 -0800 (PST)
Date: Wed, 21 Feb 2024 17:27:14 +0800
In-Reply-To: <20240221092728.1281499-1-davidgow@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221092728.1281499-1-davidgow@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221092728.1281499-2-davidgow@google.com>
Subject: [PATCH 1/9] kunit: test: Log the correct filter string in executor_test
From: David Gow <davidgow@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Guenter Roeck <linux@roeck-us.net>, Rae Moar <rmoar@google.com>, 
	Matthew Auld <matthew.auld@intel.com>, 
	Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>, 
	"=?UTF-8?q?Christian=20K=C3=B6nig?=" <christian.koenig@amd.com>, Kees Cook <keescook@chromium.org>, 
	"=?UTF-8?q?Ma=C3=ADra=20Canal?=" <mcanal@igalia.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Matthew Brost <matthew.brost@intel.com>, Willem de Bruijn <willemb@google.com>, 
	Florian Westphal <fw@strlen.de>, Cassio Neri <cassio.neri@gmail.com>, 
	Javier Martinez Canillas <javierm@redhat.com>, Arthur Grillo <arthur.grillo@usp.br>
Cc: David Gow <davidgow@google.com>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Daniel Latypov <dlatypov@google.com>, Stephen Boyd <sboyd@kernel.org>, David Airlie <airlied@gmail.com>, 
	Maxime Ripard <mripard@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	intel-xe@lists.freedesktop.org, linux-rtc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-hardening@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

KUnit's executor_test logs the filter string in KUNIT_ASSERT_EQ_MSG(),
but passed a random character from the filter, rather than the whole
string.

This was found by annotating KUNIT_ASSERT_EQ_MSG() to let gcc validate
the format string.

Fixes: 76066f93f1df ("kunit: add tests for filtering attributes")
Signed-off-by: David Gow <davidgow@google.com>
---
 lib/kunit/executor_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/kunit/executor_test.c b/lib/kunit/executor_test.c
index 22d4ee86dbed..3f7f967e3688 100644
--- a/lib/kunit/executor_test.c
+++ b/lib/kunit/executor_test.c
@@ -129,7 +129,7 @@ static void parse_filter_attr_test(struct kunit *test)
 			GFP_KERNEL);
 	for (j = 0; j < filter_count; j++) {
 		parsed_filters[j] = kunit_next_attr_filter(&filter, &err);
-		KUNIT_ASSERT_EQ_MSG(test, err, 0, "failed to parse filter '%s'", filters[j]);
+		KUNIT_ASSERT_EQ_MSG(test, err, 0, "failed to parse filter from '%s'", filters);
 	}
 
 	KUNIT_EXPECT_STREQ(test, kunit_attr_filter_name(parsed_filters[0]), "speed");
-- 
2.44.0.rc0.258.g7320e95886-goog


