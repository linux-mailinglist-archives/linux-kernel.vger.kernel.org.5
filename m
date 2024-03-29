Return-Path: <linux-kernel+bounces-124967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BFE891E55
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 549A82878D5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505271AC032;
	Fri, 29 Mar 2024 12:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+vucgmx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC751AC01C;
	Fri, 29 Mar 2024 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716523; cv=none; b=ByqKLFa9ffvS7WF4YJMNAg/dUz3aj6Kzxe89QzOpkcqPvK+Kg1BkUx4/0Koby2Ft6Z5HB1PhZtRb8GT2PEGoepCouLgVxlv45yhLh+b7jhrNJnCAZsnOfQ540M2kC7S9avtXZGFMAZadHr9zdiZUclhfgK0bSi5uVsJ2ctNq9zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716523; c=relaxed/simple;
	bh=ewjU2HkeKat/OJ2QdByR91WQA7bTQED3R5Erhj5bqsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EiQqmJEVc5MPtKPU1XkKJvlttQ9Uf9TdBF8ofSSTrL+7utNA1TIx45Hw75RMh8DhhXqEL9Og2phcFl/4IGrOVe37uBCnEeBAthXu4h9eSYaml5/PDoBwpQbTDXu18LXVQOMIcPVIKLiia3KKlk5L3+DrR9TDqqJcI+Q7+4YM74c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+vucgmx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3310DC433C7;
	Fri, 29 Mar 2024 12:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716523;
	bh=ewjU2HkeKat/OJ2QdByR91WQA7bTQED3R5Erhj5bqsw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s+vucgmx1iUojwA7p2kaVYagYHUjnPGyulDZB9guracNoJ419+agL+tOK/FG43nyu
	 DnngHrIhX7zcgQiCctg0k8y3RHiXbiSnr0vmJoByPXrE/B5KV9gOc0+lAI29122m4/
	 sSTG7KUbJ0l7RwCNo+8gsMa+SMXDbKfq6czvOTlpZ0OiLhs4S+BSOBdBQuHYxs0MEE
	 GbA8LXaRw6u+S2iry0pO7CXjndIBj2Og2vS2OtXOagTbKa0o7pHsqrztPZ6gGx8a3j
	 cGz/+sc+ZLOv6LfdxgTp9wTbu2SHwD4NhkP5173RS5zP1lfUWEuRv4ud6NBLQDHJAk
	 mDAnjs9w2c+jQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gergo Koteles <soyer@irl.hu>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 31/34] Input: allocate keycode for Display refresh rate toggle
Date: Fri, 29 Mar 2024 08:47:32 -0400
Message-ID: <20240329124750.3092394-31-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124750.3092394-1-sashal@kernel.org>
References: <20240329124750.3092394-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.153
Content-Transfer-Encoding: 8bit

From: Gergo Koteles <soyer@irl.hu>

[ Upstream commit cfeb98b95fff25c442f78a6f616c627bc48a26b7 ]

Newer Lenovo Yogas and Legions with 60Hz/90Hz displays send a wmi event
when Fn + R is pressed. This is intended for use to switch between the
two refresh rates.

Allocate a new KEY_REFRESH_RATE_TOGGLE keycode for it.

Signed-off-by: Gergo Koteles <soyer@irl.hu>
Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Link: https://lore.kernel.org/r/15a5d08c84cf4d7b820de34ebbcf8ae2502fb3ca.1710065750.git.soyer@irl.hu
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/input-event-codes.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
index 7989d9483ea75..bed20a89c14c1 100644
--- a/include/uapi/linux/input-event-codes.h
+++ b/include/uapi/linux/input-event-codes.h
@@ -602,6 +602,7 @@
 
 #define KEY_ALS_TOGGLE		0x230	/* Ambient light sensor */
 #define KEY_ROTATE_LOCK_TOGGLE	0x231	/* Display rotation lock */
+#define KEY_REFRESH_RATE_TOGGLE	0x232	/* Display refresh rate toggle */
 
 #define KEY_BUTTONCONFIG		0x240	/* AL Button Configuration */
 #define KEY_TASKMANAGER		0x241	/* AL Task/Project Manager */
-- 
2.43.0


