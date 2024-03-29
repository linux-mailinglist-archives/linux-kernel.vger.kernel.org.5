Return-Path: <linux-kernel+bounces-124644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6CD891AEE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 716BD286AA3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D76416133A;
	Fri, 29 Mar 2024 12:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1fBPTtj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F92B161322;
	Fri, 29 Mar 2024 12:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715617; cv=none; b=sGIO1v8yfFFJsZzX7+rWcHs/vmwMbkNE5VuXCyPwhhup29hb2zuMJ84dDa2B6g/IsrHHtSl5SozEEi87bmuttT8rPnOoBinJ5uSGtGPz/+eC0/+iMFvEvo72TZwZORuKEvvOMOm8AYKP7gLqIZQxe+guS45s6JQlYsMoceJbKrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715617; c=relaxed/simple;
	bh=atLbCrAFF/AvlcWQ0EJKEUSz3x7UDvnUlEl5LvVKMzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYvk+4j5wKbzE5Z43GlJ5ZVzUX1RZ92mbS56TN2O+dObGiy+C45zAv/16ZQOackoMLG1S/GwtHagZaCsT0cLx1d+zSddOWAA9zouIK7VH/fsmm5lo0lmGLqxGJm4MvcwMxHCVkNAz7HhHCidtDYMYXNPUxJ752crIM4WeLAxH9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1fBPTtj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1DAC43399;
	Fri, 29 Mar 2024 12:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715617;
	bh=atLbCrAFF/AvlcWQ0EJKEUSz3x7UDvnUlEl5LvVKMzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i1fBPTtjhZ4GQKE0GQy7eZPfrohYcVz4ZEpiSbp7wvZii3USczUipEc0NwnRTeKsT
	 MPnUjaCkr8FsGQz/AMM1XmcDO+u+0QiP8c6aFohC4JuYbVGeK/mp2jZWZVVjEOpr+I
	 STAb3Mmkc+VXPuaqAXPgGCTl0uNIz64EasK2Vw3ld4dBk9U0ZV4/FOzs6r3+4ZXaSf
	 TejRLnWeYqrmbMM18aJAJAfn12dk8dnKvCscqx1t3JrIbF8O+mnVB2g5/5VrKBrhT3
	 qzwcTB5Sat6jS9UeEAKImkzefmLIsmx6uHj580d0KTCOt4yd2GurDp659n6zb9qlT5
	 gaAFwl/Tpu+Ng==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kunwu Chan <chentao@kylinos.cn>,
	Kees Cook <keescook@chromium.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 10/20] pstore/zone: Add a null pointer check to the psz_kmsg_read
Date: Fri, 29 Mar 2024 08:32:58 -0400
Message-ID: <20240329123316.3085691-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123316.3085691-1-sashal@kernel.org>
References: <20240329123316.3085691-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.153
Content-Transfer-Encoding: 8bit

From: Kunwu Chan <chentao@kylinos.cn>

[ Upstream commit 98bc7e26e14fbb26a6abf97603d59532475e97f8 ]

kasprintf() returns a pointer to dynamically allocated memory
which can be NULL upon failure. Ensure the allocation was successful
by checking the pointer validity.

Signed-off-by: Kunwu Chan <chentao@kylinos.cn>
Link: https://lore.kernel.org/r/20240118100206.213928-1-chentao@kylinos.cn
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/pstore/zone.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
index 5d3f944f60185..295040c249d91 100644
--- a/fs/pstore/zone.c
+++ b/fs/pstore/zone.c
@@ -973,6 +973,8 @@ static ssize_t psz_kmsg_read(struct pstore_zone *zone,
 		char *buf = kasprintf(GFP_KERNEL, "%s: Total %d times\n",
 				      kmsg_dump_reason_str(record->reason),
 				      record->count);
+		if (!buf)
+			return -ENOMEM;
 		hlen = strlen(buf);
 		record->buf = krealloc(buf, hlen + size, GFP_KERNEL);
 		if (!record->buf) {
-- 
2.43.0


