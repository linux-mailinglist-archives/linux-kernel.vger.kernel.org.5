Return-Path: <linux-kernel+bounces-110786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E214A8863EB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 00:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 201B61C21E97
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F9D14271;
	Thu, 21 Mar 2024 23:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sfSEDZKT"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB6DF9CE
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 23:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711063233; cv=none; b=l+Z/kIU5hy0KI80L+d5gnJWxQJ43hFfGPP6KGqEgPDsiE3pBwSiVwkTaSTmrDk8W2h34mypBLLpinA7a//Os3PGA4nSa9OhkVxlQ3ia//AXnZlTXv2h7Vt33O8sqXNv25wm0imUQKvixVxF3DrEa+bu2IqiHpv3Y/qRyPdf+lP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711063233; c=relaxed/simple;
	bh=dxz7GqyPcYMZ17vA34k+wHNNyKUjhZBgCEw2mQEZ818=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Cim3a36VoQVD0nG6BEPUKLMQhKL8syKRCxmDYCl3O4erHsClXJ4cGsRRciN/zk6LTmUqV0PIF/jTpm+PTzuRDMnTVsehWqkdaqtwXB/wu7lBX4C6qkZKIf93uFpiJek3Q/Z1zp3Qok7zr0p2Lma1DnUceL4AnndF8K/izbgok3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sfSEDZKT; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edliaw.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-5d8dbe37d56so966719a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 16:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711063231; x=1711668031; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fJkna889vaoG1pUyPc+t29CTNaYEYMQM72LV9bOJhDM=;
        b=sfSEDZKT/tjeYK1unjoLrp6sMH6n44/Dbqrfpa/GqjwncNSYXFMYfRg1MSr6kJc3Rb
         wXX6o5GCw+ewKuOnZXDO/smoM4yTVDtjt2x+41lvKCeUgMb7E6hjwT8LZEgQy3pqln1N
         Ii1B3xlumTo7EGlrGXFrx44SN5RJsEWKiwmDJJw8w4ateTG/A9uh2VipKIi6KKqyxI2H
         p0hZE+APX7oaIcgPwnTrRS5QbOLHBaUNiGSh/O9EbFjeBRi7EY1/lF7wrTfgo9DxWynl
         qnPq2eAeCPGhzhBQk19XE+EPQXI5WdGeS3wVrNm1DaHxLcDmMpvIthN1UZa/CsCi5vlt
         p5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711063231; x=1711668031;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fJkna889vaoG1pUyPc+t29CTNaYEYMQM72LV9bOJhDM=;
        b=V1rBWteOhSyC3KVyi8Qz2nsZi3NYGWJ3FVeaYi8ByIq75/mnda6xX68n8/5Fd8Rq8J
         r10ULcwj+JRK8HkvaiGL61oZR3H9V3hXSGkGpwpZfooFO66xxk22vO6YxugJQjc2++P0
         WbZAV3xXxnjq/csNKwcNPKLjmPUNQovrLF4lLDL3c5R6BSGfO/q47mFGpc9zEATidSks
         o1ml8vr/URwx7lxqo8D7OrPWO4XbtCeZNTcBpE8F/qmmYwPdcLOa4NUVOD8Vz27j10WI
         MrPsZavbR8BGTv5mkQo6znUIpXtRv5CFM/VXt3cQzWwlRCPTP6XyNWZm9AUM9bwtmMLc
         LWSw==
X-Gm-Message-State: AOJu0YxuxTrLp01uVOkGDpIE6Kuv4WGqEWtaghRR0dkVSHZt0WzKEFYB
	2XJF//FeQ2fh7wT2WrtiGV7fVdpxbd9UWb0OAsT64MrMigPikFpcWdHj5xanXcTmGA2HQlA6mQ5
	wVtA0vwRovo4gwkb3SSzlHrBPNReUYKCsmzV5zwLjqcpAdAzAYnLZ1imB7VPMP3f4yPcpew80x4
	XXtNIwffMY50GlCLcJi9FI9PVzU9kTowzZfFrwpjVY
X-Google-Smtp-Source: AGHT+IHy7n9urU4OinfJFgbLw+GEQU4fI6k6GosyucewtA/EmPr7Kyb5FxEC4vw7lvW9PN/ezx1bGic7M9g=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:e304:0:b0:5dc:1cc9:36ab with SMTP id
 f4-20020a63e304000000b005dc1cc936abmr1620pgh.12.1711063229245; Thu, 21 Mar
 2024 16:20:29 -0700 (PDT)
Date: Thu, 21 Mar 2024 23:20:21 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240321232023.2064975-1-edliaw@google.com>
Subject: [PATCH v1] selftests/mm: sigbus-wp test requires UFFD_FEATURE_WP_HUGETLBFS_SHMEM
From: Edward Liaw <edliaw@google.com>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, kernel-team@android.com, 
	Edward Liaw <edliaw@google.com>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

The sigbus-wp test requires the UFFD_FEATURE_WP_HUGETLBFS_SHMEM flag for
shmem and hugetlb targets.  Otherwise it is not backwards compatible
with kernels <5.19 and fails with EINVAL.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 tools/testing/selftests/mm/uffd-unit-tests.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/uffd-unit-tests.c b/tools/testing/selftests/mm/uffd-unit-tests.c
index 4a48dc617c6b..21ec23206ab4 100644
--- a/tools/testing/selftests/mm/uffd-unit-tests.c
+++ b/tools/testing/selftests/mm/uffd-unit-tests.c
@@ -1437,7 +1437,8 @@ uffd_test_case_t uffd_tests[] = {
 		.uffd_fn = uffd_sigbus_wp_test,
 		.mem_targets = MEM_ALL,
 		.uffd_feature_required = UFFD_FEATURE_SIGBUS |
-		UFFD_FEATURE_EVENT_FORK | UFFD_FEATURE_PAGEFAULT_FLAG_WP,
+		UFFD_FEATURE_EVENT_FORK | UFFD_FEATURE_PAGEFAULT_FLAG_WP |
+		UFFD_FEATURE_WP_HUGETLBFS_SHMEM,
 	},
 	{
 		.name = "events",
-- 
2.44.0.396.g6e790dbe36-goog


