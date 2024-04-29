Return-Path: <linux-kernel+bounces-162898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDD58B61DA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B7B5284339
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BC613AD3E;
	Mon, 29 Apr 2024 19:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Am1BAp+L"
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [84.16.66.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07A513AA48
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 19:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714418359; cv=none; b=VZ2dWnk2fgMRivrCByx5HaY7owb+56SN4vblbPVSuO3pHk2C98YRycVh20ljiHL6pI26sic97GKOYMCCItjSoHxofeqaMlYq0wj8xAYSHzSiHYQFjAmD6j8Vb2bttRB8jZqE5U4z6gD0hKpBa5T4YJwBeawtEfb9ZzuOKPwS6Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714418359; c=relaxed/simple;
	bh=8zH5TDdNRcNb8ynFUJ7igfj446ezUJo3mZ7XXP6sHRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g29vxavnkj0D357nNRWuIEbZAY/saPd0kf/7N+20oGsBMkg6ro+pqNwczq7TQK/uH9XSXEIxRoJwh9Zs0MDGtjM2QIUwskaWHrPcNTqir83JT/M6ZeIWt6e86Ln6XaUYwaYK1jSSStVB0JQkDWbmxe015E0iXxr7gpGFjE0cr3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Am1BAp+L; arc=none smtp.client-ip=84.16.66.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4VStRk6FhqzPKS;
	Mon, 29 Apr 2024 21:19:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1714418354;
	bh=8zH5TDdNRcNb8ynFUJ7igfj446ezUJo3mZ7XXP6sHRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Am1BAp+LEgEWLwnTXkpS1w4M7TzJIps8z86ireglFeOYBSkdJg0zAIFpKkukCWr28
	 4FOezYbR05C7k1FkJS4c6KYnF+NnhnQTajXey9F+eYZTguFs1A50GPN6bbtl1bDS7S
	 nKVjCrPqqp/XItgCEK85gXQG2ZoxJicmqhJyIUe8=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4VStRk1hVszYlS;
	Mon, 29 Apr 2024 21:19:14 +0200 (CEST)
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
Subject: [PATCH v3 1/9] selftests/pidfd: Fix config for pidfd_setns_test
Date: Mon, 29 Apr 2024 21:19:03 +0200
Message-ID: <20240429191911.2552580-2-mic@digikod.net>
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

Required by switch_timens() to open /proc/self/ns/time_for_children.

CONFIG_GENERIC_VDSO_TIME_NS is not available on UML, so pidfd_setns_test
cannot be run successfully on this architecture.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Fixes: 2b40c5db73e2 ("selftests/pidfd: add pidfd setns tests")
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240429191911.2552580-2-mic@digikod.net
---
 tools/testing/selftests/pidfd/config | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/pidfd/config b/tools/testing/selftests/pidfd/config
index f6f2965e17af..6133524710f7 100644
--- a/tools/testing/selftests/pidfd/config
+++ b/tools/testing/selftests/pidfd/config
@@ -3,5 +3,7 @@ CONFIG_IPC_NS=y
 CONFIG_USER_NS=y
 CONFIG_PID_NS=y
 CONFIG_NET_NS=y
+CONFIG_TIME_NS=y
+CONFIG_GENERIC_VDSO_TIME_NS=y
 CONFIG_CGROUPS=y
 CONFIG_CHECKPOINT_RESTORE=y
-- 
2.44.0


