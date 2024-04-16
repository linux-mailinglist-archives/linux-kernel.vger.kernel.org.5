Return-Path: <linux-kernel+bounces-147699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 877CB8A77ED
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B819C1C22A53
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A4913A3E5;
	Tue, 16 Apr 2024 22:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hCCddQzo"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F98137929;
	Tue, 16 Apr 2024 22:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713307270; cv=none; b=A9UNa6BGW4lSJ+p4p9MwFgeh4TdGtzGfifEwHovinbzeFuCX849sCHBNsEHuuuC/mJrsgLZ65DeDdSybTO38alQ2fcsNzjZ1urZn0pJgq+SI3FtkMlMAq6Im6AhNgR3zSQCZSw69dzph8IfceGaazCOiTH8BnlD9bk0gsUwLjsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713307270; c=relaxed/simple;
	bh=y1wrF17AgEHKJmFGNE7yGIyl4eKYJ5YVmr3GJsXkZys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nbHHOUTQP466dyhcsIn0/H8VqUmwq/x7VH1v8c2b8qx5+IgIU+wrF2vyHz7EG+a1jQ3b2ujNZGAohovnC7sHmG6dvHHDOCZJNgybeup+VdmEakCLD/JHqooP3LB+LbFakgRBBCpajbiCX1xfg4Pw65ougVO75vLH2J1TTYwhuKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hCCddQzo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost.localdomain (unknown [4.155.48.117])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5F53120FD47C;
	Tue, 16 Apr 2024 15:41:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5F53120FD47C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1713307269;
	bh=Qzj7PgGGTTDfdmHHRJjNMrG5XlDt+SDkey8oIImgtmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hCCddQzo+9qG2QP70nsDMYCY4q+3KgJCJjOuJ0evtKrz2SW0DO1KGx7bmxSjDAE3U
	 0qVagCv3Z8lBrSj/k+CzCpHnD7MtdNvr0AS8LwGexopXkwJVdwkDoepjbtYz75dSg8
	 lCeLVx8YiqwFwmYy8qB1jOPm/mqDjyV+q5cK/lN4=
From: Beau Belgrave <beaub@linux.microsoft.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	dcook@linux.microsoft.com
Subject: [PATCH 2/2] selftests/user_events: Add non-spacing separator check
Date: Tue, 16 Apr 2024 22:41:02 +0000
Message-Id: <20240416224102.734-3-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240416224102.734-1-beaub@linux.microsoft.com>
References: <20240416224102.734-1-beaub@linux.microsoft.com>
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


