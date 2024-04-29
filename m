Return-Path: <linux-kernel+bounces-162329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A208B5975
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E0521F225B6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC43F6E61D;
	Mon, 29 Apr 2024 13:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="KnWg7xma"
Received: from smtp-42ae.mail.infomaniak.ch (smtp-42ae.mail.infomaniak.ch [84.16.66.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96310548EC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 13:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714396189; cv=none; b=siHpLVinitpAKVWTmfelMiM8uCwqjRVEx1VPjimxgwT8HAhH47NVhOzBjIvNdVi7C7H11LzzcXZTJqbrme7aYJRo9ogpA8vPpo39GnnEJHxG611IjR4XGl5Mn8d0YDr3RTwnIk+By9RHhft0pwwMtdWorJomEPckRyCTTBvPWYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714396189; c=relaxed/simple;
	bh=Di4akVdlawrQeihQeWvBuO2Ker/fO5bz8gIl7ebo7+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NT0yjSpA4qJF+ZayHOTAUV/0PkfPOpq/YQAj2Wo63z1m12qWkUbND88RyXKh5xUYVg6ukq3cn0AA4BWZP+FhShUlATVphvbdV4w0xEEnsVuIaUNOSJM2S6hhLTiECZub676grsEjQP/EOpk/eQ4hIziuun7tfxcfrIukCueiEPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=KnWg7xma; arc=none smtp.client-ip=84.16.66.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VSkFQ0FjFzMBH;
	Mon, 29 Apr 2024 15:09:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1714396185;
	bh=Di4akVdlawrQeihQeWvBuO2Ker/fO5bz8gIl7ebo7+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KnWg7xmaA/WSCfeQer8yQA8Ja+kFqo5w85K2OSiDfGMQ4vk4j83Ocd5sFBqsrkmu6
	 nQbqAl2l1SlXlOmAwXg/389g5tywq+JinV9TRTwZTCuaXIpVHnXwYSAAwdFcAfgWv6
	 BRT5CEy+y3wwx85GktGkCE1YrbkjqXxeXnWMY63c=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4VSkFP3RVpzKTX;
	Mon, 29 Apr 2024 15:09:45 +0200 (CEST)
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
Subject: [PATCH v2 7/9] selftests/pidfd: Fix wrong expectation
Date: Mon, 29 Apr 2024 15:09:29 +0200
Message-ID: <20240429130931.2394118-8-mic@digikod.net>
In-Reply-To: <20240429130931.2394118-1-mic@digikod.net>
References: <20240429130931.2394118-1-mic@digikod.net>
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
Cc: Kees Cook <keescook@chromium.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240429130931.2394118-8-mic@digikod.net
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


