Return-Path: <linux-kernel+bounces-118747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0412188BEDC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 969691F31B30
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29ECD5B1FB;
	Tue, 26 Mar 2024 10:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W4R+E31m"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6325B208
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711447672; cv=none; b=S9OTqIcId1xG5vzFXT0VlcEsG4ZRF1AZ3Zs/+NFlVQVwgbxJNahTVF5UbTSLv2ZRbxGgsDBJ5UxZY8MA43vpYfMjqzru12LCdOmVLnwBdDHCv4i+CTi6irEGLtNftvgUCz+aQuc+EchS5ASPnQOXiPreSphwhed/xf4xGYeiPHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711447672; c=relaxed/simple;
	bh=+G6LAk+yEHqNbO0JO+tLpmM3eDC5/I1CZRFOR+V45KM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QZpH3zVMFfcW0mXIYtyneAku3hDZwYQ9aExlVIdOqmxlf16+YY7nJm87NxKSHR0eTNd9rFRlLJ4s+oso9Dn2pSrAOdLnndjZDPlukWIFwHq7fvBaWuM3nqsKxhd3SFQfsw5qmeggzYB4dekov3iSceE8TLTNol2M+GIhuj8m5Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=W4R+E31m; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-ddaf165a8d9so1227528276.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 03:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711447670; x=1712052470; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2RbBdaobUXsca5coxxV6oOWp8XKT6HorsbFw32NCXco=;
        b=W4R+E31mBPslCh4wY3hCfQDKeUs//dt9FMtWgikiRVf/LQE/S7uApa2ETr86+aYQ8B
         d/sF7jx3wb4palEvBEfHMcZl6PVMhsGBWPHbMwuClE035eTfuFH3ylGPjxf2MlZ5EoFi
         D7R6l9xzvlFJPa+ocgGBW+Vpx3f0HpFvDyonxlg8aNNzE2ArGSeEjZwiSnmeorfMkvzB
         41bHMFQW7WnbwxVr5gXZ5mMZbXnKU6VKaIErzBBCJJ759hBiSHkr32gnvECKNegewkhR
         wubBWoHWtykpf7Bd06PtnQ5Jyk3d7D0wqinggf1QtFA9nEuUBi8LuQycI9AAAgzVhb51
         5Ytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711447670; x=1712052470;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2RbBdaobUXsca5coxxV6oOWp8XKT6HorsbFw32NCXco=;
        b=oxd8URIUNTD2BLTFYoltv89KHoBT1txoPfKbfUQka7GxsHSPzkFZwi/C/sMggMhs8U
         2HaTnoWnhjcN0c6gstVWpz0WDxp/vFtQEQmx3tv1Ou9Lh9hyM9FFhOPO61gJRxpluCDE
         YKqGrYXwTMgGAOARHhXYH2Qs5CawChkzybeGVkQqSI8MnKp2FijGT4G5/jIPkyO4scXu
         LcyR+ahJFjPx7BChmCwW050K5Q26bMzhQkd5UeRhJiAJI4l0533vyNkVHY88Orod9qJY
         C8fdtvVj1s29fFbXa/Xd3JUm+QMe0Tnkh/4fwjWkW/YJefrZfWcsPNFQdkgT1LxEHAtg
         m6vA==
X-Forwarded-Encrypted: i=1; AJvYcCWbMllha+vdLXMJr9hTsWvSsHvPsIsxd6WcuKXNj17dheOnvDUm7BXv90xp4I7BsZTJhWl/0cbBKxfHEHiLgVsP1qTQoaTwM25YF97H
X-Gm-Message-State: AOJu0Yw1mtcyjSEikMKJYCaAIS80iYlE1poJQMRROqGbsfsCUJVbbzyY
	xPG1dcjho9phfkXFhJf4HE62tJybdw+bWAmkCEp6Qita3D3ahjoZyul0784hhng9ZndoH/TFQ4y
	/J7y7fjoiHg==
X-Google-Smtp-Source: AGHT+IEC4khUGqXzhYaQdt2H1zWZaE5a54/9dd/Pdyx/tywdDoRy9BvDAIj1fzNU93/ObzxgBm8rZeWyFlm7Bw==
X-Received: from slicestar.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:20a1])
 (user=davidgow job=sendgmr) by 2002:a05:6902:1604:b0:dc6:d890:1a97 with SMTP
 id bw4-20020a056902160400b00dc6d8901a97mr578453ybb.9.1711447670059; Tue, 26
 Mar 2024 03:07:50 -0700 (PDT)
Date: Tue, 26 Mar 2024 18:07:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240326100740.178594-1-davidgow@google.com>
Subject: [PATCH] kunit: configs: Enable CONFIG_DAMON_DBGFS_DEPRECATED for --alltests
From: David Gow <davidgow@google.com>
To: SeongJae Park <sj@kernel.org>, Rae Moar <rmoar@google.com>, Mark Brown <broonie@kernel.org>, 
	Johannes Berg <johannes.berg@intel.com>
Cc: David Gow <davidgow@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	Shuah Khan <skhan@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"

This is required, as CONFIG_DAMON_DEBUGFS is enabled, and --alltests UML
builds will fail due to the missing config option otherwise.

Fixes: f4cba4bf6777 ("mm/damon: rename CONFIG_DAMON_DBGFS to DAMON_DBGFS_DEPRECATED")
Signed-off-by: David Gow <davidgow@google.com>
---

This is breaking all UML alltests builds, so we'd like to fix it sooner
rather than later. SeongJae, would you rather take this yourself, or can
we push it alongside any other KUnit fixes?

Johannes: Does this conflict with the CONFIG_NETDEVICES / CONFIG_WLAN
fixes to all_tests.config? I'd assume not, but I'm happy to take them
via KUnit if you'd prefer anyway.

Thanks,
-- David

---
 tools/testing/kunit/configs/all_tests.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
index aa5ec149f96c..f388742cf266 100644
--- a/tools/testing/kunit/configs/all_tests.config
+++ b/tools/testing/kunit/configs/all_tests.config
@@ -38,6 +38,7 @@ CONFIG_DAMON_VADDR=y
 CONFIG_DAMON_PADDR=y
 CONFIG_DEBUG_FS=y
 CONFIG_DAMON_DBGFS=y
+CONFIG_DAMON_DBGFS_DEPRECATED=y
 
 CONFIG_REGMAP_BUILD=y
 
-- 
2.44.0.396.g6e790dbe36-goog


