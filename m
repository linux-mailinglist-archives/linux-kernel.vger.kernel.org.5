Return-Path: <linux-kernel+bounces-166883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D445B8BA154
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:05:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 758D81F2144E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16F85181304;
	Thu,  2 May 2024 20:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUYwu7iU"
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1760516D4FD
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 20:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714680340; cv=none; b=n9N2KmYwTGGV6JoXu+tH6M8kuPu65DUDmePD9iOpI2O3wEpyHcq/drhrnM8ff5X2XwnY1C7vGjpCQlHrplY7DOD0zqASZT3q2fyjOi9PA6FKTpqY4vD726kfDie1Nr5WIXkwvZx5aoWrazfPBShrX4pYHkAgDL/aMzOQzQgwmDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714680340; c=relaxed/simple;
	bh=rb3+3axq0ArHOeglMNGwwoYuWnEKwIZF6CyAIDiHpsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fBqN3mlWG18/89GZaQYkiBQ29s2IPTl/DlKEXQTXbrSJg+qT5Udg2woqkZ7uBFL6tcdq0OVRAo256c/EK2qsiN0WV9liI4XiKH045HE3dGjk7/kaB6EasPc1sriiun7psHi+XDTeOYNIrYXyJxtxDDXvi+J4owZJhuje+2wnQpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUYwu7iU; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6a071595d22so43461866d6.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 13:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714680338; x=1715285138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z0eeA2c+auK+aXg6KNPwfi/nf0ZrssrhFecJaWxdXRI=;
        b=iUYwu7iUWCQIcpW98Yk2RaKbDEnxRIJSFYo8EeCVl+L032Pgkts/XEa+xa0H+L6HVf
         o9riO75w/oMw6dssEAFMpEVEhjDqIDp938i9WIr99anlQysWHrox67KD/5lNSYRa/iCX
         XUW+g+KCSzdnW0oeZlVHUBv0QtDqdaQMPDjVm18hoeiVMPkt8KoK6r2dWuPO7ll060h+
         8uipbc8YOwv9URYukPQWN03nxBRQLHDPfUR9pX7vN1qHB4PBU5G6VRSRo1sSfzj7zvaJ
         nAuvkwOrhhqtil+OuVVHDcsVtSz65NyqImDEBxrfLnM12sG+gooF5EgNpGg+MLYMJ8we
         eLbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714680338; x=1715285138;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z0eeA2c+auK+aXg6KNPwfi/nf0ZrssrhFecJaWxdXRI=;
        b=O4Vt2hmnx+Xpyt55ATc9Ly/hm1HgfQWmpT+VPDczZUhbfCB8sU3mGad9syCMnu6h03
         5qQFfqu55IQg4PnNPiXrBZMdd/Yi8R44nvI9MLQHqF4ISiDfB1px0F9Ixwevl0bc63zA
         EkavQN/bcLD60ISx8veAyZfk2m8o66FbY2qOjzlFpzVSdVsiaIMZOM99EZCFM7TEFB/0
         33ZHEEu+gYS9BLAoYHaRLoaRczQJqg5+TlMRZ7pK1V0+FZeS6p4AQ9IvGKLE/Hak1l/V
         55p7gtpevTP+nPxVFRYy6NLR/RlF914fzcHwFgSFSgpW4xDBIOfBTeJTJoK6ovtWlgV9
         IFBA==
X-Forwarded-Encrypted: i=1; AJvYcCUx8pUpSbHK+7mp9FzJNNZOk4ghTteb/hpnJDYKGM5cyfJhy42EIgnhecg8oHelogQapn3Qdz/n8oF0ME+jOk+leylIbxAuWD9QoXAo
X-Gm-Message-State: AOJu0Yz/bTTYsBQHMUQYjaHmHCxllJvSUdlQpkpr0k+zf8cSMHNG6roK
	5UZmkGb87BzIqy0FBujL4pLMfYckmymONvpxzNUy4L9HzzIkMKQaN2bwaHj47YQ=
X-Google-Smtp-Source: AGHT+IFY5Wmec7sa66rtCOXZWmpu3PizaWiuVwSFDLKvzTxUxEN66BYBbtpvyXv9GihvbdS5ijwZQw==
X-Received: by 2002:a05:6214:1d2e:b0:6a0:95a5:cf01 with SMTP id f14-20020a0562141d2e00b006a095a5cf01mr835602qvd.19.1714680337871;
        Thu, 02 May 2024 13:05:37 -0700 (PDT)
Received: from localhost (fwdproxy-nao-013.fbsv.net. [2a03:2880:23ff:d::face:b00c])
        by smtp.gmail.com with ESMTPSA id j11-20020a0ceb0b000000b006a0dd5ad71bsm612471qvp.12.2024.05.02.13.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 13:05:37 -0700 (PDT)
From: Usama Arif <usamaarif642@gmail.com>
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org,
	yosryahmed@google.com,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Usama Arif <usamaarif642@gmail.com>
Subject: [PATCH v2 1/1] selftests: cgroup: remove redundant addition of memory controller
Date: Thu,  2 May 2024 21:04:26 +0100
Message-ID: <20240502200529.4193651-2-usamaarif642@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240502200529.4193651-1-usamaarif642@gmail.com>
References: <20240502200529.4193651-1-usamaarif642@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Memory controller is already added in main which invokes
the test, hence this does not need to be done in test_no_kmem_bypass.

Signed-off-by: Usama Arif <usamaarif642@gmail.com>
---
 tools/testing/selftests/cgroup/test_zswap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/cgroup/test_zswap.c b/tools/testing/selftests/cgroup/test_zswap.c
index cd864ab825d0..19ac29c533e0 100644
--- a/tools/testing/selftests/cgroup/test_zswap.c
+++ b/tools/testing/selftests/cgroup/test_zswap.c
@@ -485,8 +485,6 @@ static int test_no_kmem_bypass(const char *root)
 	trigger_allocation_size = sys_info.totalram / 20;
 
 	/* Set up test memcg */
-	if (cg_write(root, "cgroup.subtree_control", "+memory"))
-		goto out;
 	test_group = cg_name(root, "kmem_bypass_test");
 	if (!test_group)
 		goto out;
-- 
2.43.0


