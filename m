Return-Path: <linux-kernel+bounces-79015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F80861C49
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89AA42822C9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1B9143C74;
	Fri, 23 Feb 2024 19:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="H9WEYkU4"
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA76EEAD2
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 19:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708715169; cv=none; b=kCmqUTWlQUmmdBJ4xCuCgxVgJRWhMOm7N5ktVvC+SZdi7FDoGH5gO5kJjOONGJU0+I/yR0eCt5ar1XSNg4bV69InUlEh3JxwvJWFmPYdRqowRu/Vtb4mZEzhGQSTLHpZ05slwe3LoWFcJRSJCVtH0TtJaq7Us7ZH0NLG4pfnaII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708715169; c=relaxed/simple;
	bh=YdGYAHw605VafQ4cjqctlQpaI+zPzB3uwPRkJjOjJFE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oQBkYuzkXENYgvB6tBMAE/1Z2pKhp+Pq6sUv9EI6yas0U74GqkrYrj17BBRMyIcKytSs+GYM1aFWfHysrYOM7qy5HhtYhU9wNxxCIOxsHKbnQLnYqoQPPtQHtrJOUV9GKuj+P/UuHE/ZB+1p9Y7uG6YO+duCmYWFQ0UkB0EecT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=H9WEYkU4; arc=none smtp.client-ip=185.125.25.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ThKGv49QfzMq2xt;
	Fri, 23 Feb 2024 20:05:59 +0100 (CET)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ThKGv0pfYzMpnPc;
	Fri, 23 Feb 2024 20:05:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1708715159;
	bh=YdGYAHw605VafQ4cjqctlQpaI+zPzB3uwPRkJjOjJFE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H9WEYkU4GyTi79yWNsj+FBBwY2I/Zm9vHlkuL2GG+FniECt0mVFOKqZkNHj7g0SR7
	 1np3Zpre5uRvuBsKC4mPYJ5qluB+Q7MQHE2a6o6JlD2DBpzYmaKjK/DqFEAQxkf9yy
	 XQrvusHt5juvdNyRutZawD3xEJfECNx2tvu5UI24=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Casey Schaufler <casey@schaufler-ca.com>,
	John Johansen <john.johansen@canonical.com>,
	Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 2/2] AppArmor: Fix lsm_get_self_attr()
Date: Fri, 23 Feb 2024 20:05:46 +0100
Message-ID: <20240223190546.3329966-2-mic@digikod.net>
In-Reply-To: <20240223190546.3329966-1-mic@digikod.net>
References: <20240223190546.3329966-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

aa_getprocattr() may not initialize the value's pointer in some case.
As for proc_pid_attr_read(), initialize this pointer to NULL in
apparmor_getselfattr() to avoid an UAF in the kfree() call.

Cc: Casey Schaufler <casey@schaufler-ca.com>
Cc: John Johansen <john.johansen@canonical.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: stable@vger.kernel.org
Fixes: 223981db9baf ("AppArmor: Add selfattr hooks")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/apparmor/lsm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index 98e1150bee9d..9a3dcaafb5b1 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -784,7 +784,7 @@ static int apparmor_getselfattr(unsigned int attr, struct lsm_ctx __user *lx,
 	int error = -ENOENT;
 	struct aa_task_ctx *ctx = task_ctx(current);
 	struct aa_label *label = NULL;
-	char *value;
+	char *value = NULL;
 
 	switch (attr) {
 	case LSM_ATTR_CURRENT:
-- 
2.43.0


