Return-Path: <linux-kernel+bounces-155554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A57458AF3DA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9C6CB25B62
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6366A13D887;
	Tue, 23 Apr 2024 16:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="e1zf0Nfk"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEA513D256;
	Tue, 23 Apr 2024 16:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713889425; cv=none; b=FYn4ntL9zmmP9PEXFmLcbfDsD6RDWk6cNPfAYENKCbAQR7e6Kd4C7yr6mM6G5UpCa07RqJHl16mBMhRMHV6FqXrhR8VY//thnzM33/oPQ2b+PvMHPfggIDEEXR2py2mnDzxjUZZCvFlN/7os7/LsbWk4qJQmQkp6IYffg9AjV3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713889425; c=relaxed/simple;
	bh=y1wrF17AgEHKJmFGNE7yGIyl4eKYJ5YVmr3GJsXkZys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MGbyE60cot2eVRKYFNYInn/utDW3KQoOWDWcl+NNpZ4U+0TwwSrGXDoADOZ6aSDzTZPonp+Eh9RmePbK0tQEGK6+sw9wwn2aYDANB7njGj8wRK9kzTt1WKMsLPO8azRlC3PEQQ5Y9HkXHB4CWXkhY8lgXDJ8DKTYqn15deRRfss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=e1zf0Nfk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost.localdomain (unknown [4.155.48.122])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2834520FFC2F;
	Tue, 23 Apr 2024 09:23:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2834520FFC2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1713889424;
	bh=Qzj7PgGGTTDfdmHHRJjNMrG5XlDt+SDkey8oIImgtmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e1zf0NfkDoYjqyhjBzT9TbLcXh96wfsbb0UBqW7ipUZ+M/pOHo6MYkru3SUgtQKSl
	 Wxp+ZeX9EDU6gm87rxdsMZ5vRn3pImcExlWv0rIZo/EUkHQY+Mryhj1QilAtPTyev1
	 KwplJaEzgDNoBjit99PyBEYYCs4jEaTOdWjrYdNE=
From: Beau Belgrave <beaub@linux.microsoft.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	dcook@linux.microsoft.com
Subject: [PATCH v2 2/2] selftests/user_events: Add non-spacing separator check
Date: Tue, 23 Apr 2024 16:23:38 +0000
Message-Id: <20240423162338.292-3-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423162338.292-1-beaub@linux.microsoft.com>
References: <20240423162338.292-1-beaub@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ABI documentation indicates that field separators do not need a
space between them, only a ';'. When no spacing is used, the register
must work. Any subsequent register, with or without spaces, must match
and not return -EADDRINUSE.

Add a non-spacing separator case to our self-test register case to ensure
it works going forward.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 tools/testing/selftests/user_events/ftrace_test.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/testing/selftests/user_events/ftrace_test.c b/tools/testing/selftests/user_events/ftrace_test.c
index dcd7509fe2e0..0bb46793dcd4 100644
--- a/tools/testing/selftests/user_events/ftrace_test.c
+++ b/tools/testing/selftests/user_events/ftrace_test.c
@@ -261,6 +261,12 @@ TEST_F(user, register_events) {
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
 	ASSERT_EQ(0, reg.write_index);
 
+	/* Register without separator spacing should still match */
+	reg.enable_bit = 29;
+	reg.name_args = (__u64)"__test_event u32 field1;u32 field2";
+	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSREG, &reg));
+	ASSERT_EQ(0, reg.write_index);
+
 	/* Multiple registers to same name but different args should fail */
 	reg.enable_bit = 29;
 	reg.name_args = (__u64)"__test_event u32 field1;";
@@ -288,6 +294,8 @@ TEST_F(user, register_events) {
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSUNREG, &unreg));
 	unreg.disable_bit = 30;
 	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSUNREG, &unreg));
+	unreg.disable_bit = 29;
+	ASSERT_EQ(0, ioctl(self->data_fd, DIAG_IOCSUNREG, &unreg));
 
 	/* Delete should have been auto-done after close and unregister */
 	close(self->data_fd);
-- 
2.34.1


