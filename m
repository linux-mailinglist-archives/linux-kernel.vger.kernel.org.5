Return-Path: <linux-kernel+bounces-162902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4218B61E3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C1A1F23BFD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A147C13C692;
	Mon, 29 Apr 2024 19:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="HkFsXhyp"
Received: from smtp-bc0c.mail.infomaniak.ch (smtp-bc0c.mail.infomaniak.ch [45.157.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7052913BAFB
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 19:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714418365; cv=none; b=YLFQ65kwzYiYcMSKuRZTVQ0CStaeOtpWuOgDkKhDQ68vFPXq8D2zGYVT+IXPttiP4fhruCThAmIf8kVn3svCXCJsYE5udTm55BGYQyOHdvneg/+vKABv6UiHEBn7yklBwSuMjJiqx8GtpEIyzcptGBVgVr1B9iHRYEw/eoRZ+tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714418365; c=relaxed/simple;
	bh=8sa48kjmxhX24SgrO37sT/zldbxAU6rathoZxgt9xR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pfIbspJI8N5/4tz1oFTQbYy0pFTMaNY/S39lCbkMQVGu5ud6F7xapiBkqBsZTh1hIdPD6jsJkzeV1aX2RY75HClR8BL2XbKXQPfSO2d+gtqGcFtDwbBzMkYsU5uQ7bhmkzgFhHjcDW0+sjwo33ikObqPhHSuhkwOjAbgmuwUBAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=HkFsXhyp; arc=none smtp.client-ip=45.157.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VStRs56WfzNkn;
	Mon, 29 Apr 2024 21:19:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1714418361;
	bh=8sa48kjmxhX24SgrO37sT/zldbxAU6rathoZxgt9xR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HkFsXhyp2LfRAwGPsD1wHqfeIFW3ltVU0A0bxstCX5AB+xPr8IRid8BDNtKdpXGGc
	 KPJkE55WCKEYsHnGfkfG4PGFrAzTMAuIhvXXfDAd9yzSM1+GDQYt10VdZk1fyyNArA
	 RAUBr1FgJLtcqofeaQcdT/UQf3vRtHYeNg6WgVMY=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VStRs15cNzGVt;
	Mon, 29 Apr 2024 21:19:21 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Mark Brown <broonie@kernel.org>,
	Shengyu Li <shengyu.li.evgeny@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	"David S . Miller" <davem@davemloft.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Will Drewry <wad@chromium.org>,
	kernel test robot <oliver.sang@intel.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v3 7/9] selftests/pidfd: Fix wrong expectation
Date: Mon, 29 Apr 2024 21:19:09 +0200
Message-ID: <20240429191911.2552580-8-mic@digikod.net>
In-Reply-To: <20240429191911.2552580-1-mic@digikod.net>
References: <20240429191911.2552580-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Replace a wrong EXPECT_GT(self->child_pid_exited, 0) with EXPECT_GE(),
which will be actually tested on the parent and child sides with a
following commit.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240429191911.2552580-8-mic@digikod.net
---

Changes since v1:
* Extract change from a bigger patch (suggested by Kees).
---
 tools/testing/selftests/pidfd/pidfd_setns_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/pidfd/pidfd_setns_test.c b/tools/testing/selftests/pidfd/pidfd_setns_test.c
index 6e2f2cd400ca..47746b0c6acd 100644
--- a/tools/testing/selftests/pidfd/pidfd_setns_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_setns_test.c
@@ -158,7 +158,7 @@ FIXTURE_SETUP(current_nsset)
 	/* Create task that exits right away. */
 	self->child_pid_exited = create_child(&self->child_pidfd_exited,
 					      CLONE_NEWUSER | CLONE_NEWNET);
-	EXPECT_GT(self->child_pid_exited, 0);
+	EXPECT_GE(self->child_pid_exited, 0);
 
 	if (self->child_pid_exited == 0)
 		_exit(EXIT_SUCCESS);
-- 
2.44.0


