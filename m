Return-Path: <linux-kernel+bounces-113513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 422038884EC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73AA71C2433B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B1A13D89B;
	Sun, 24 Mar 2024 22:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZejAGNYJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FF41BB722;
	Sun, 24 Mar 2024 22:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320314; cv=none; b=grBI5ovv+JfqETxoNw2ueNOVbsbm2Jsr1ZP4hJljHFnqBpJuqH9epRIpEnhronivM5h6VyeEh/0kADU02VERJpTm0i3+KoWmzcZn6tcFxCLA/bAHTg08r6wiOl/4tmtF03FtQ+CtD9/idp0jEpvS2YgQulgDNoqtXI8SwN7lBSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320314; c=relaxed/simple;
	bh=EVF5sdG0klNtYkoUeJztrDyKdX6LhfnuSa4F8ZYnt8I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YAJmEwD1QbEunpw0Bg2SWbUjODEXgVPkqc0mRDiPHv82CTs8WrhDJCITSTiFoLs2WcSrMdz6DA/GqT5OQVBrITvVG80f/Qplmla6MzZsw6QLNueLsPKX8LDVHCWw0N2ilevZ6q1in/kKifAy59vDBGWMSkn22boaHORgrI8F7JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZejAGNYJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A993C43394;
	Sun, 24 Mar 2024 22:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320314;
	bh=EVF5sdG0klNtYkoUeJztrDyKdX6LhfnuSa4F8ZYnt8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZejAGNYJctG0hpBh4Su0Q9ZVqLGbAgGWGvKqDil38IWoXFL3gQCsEqrCASwsz3wmy
	 5pTkadd3Ot9SNj+fuYvvRwkhoZYLXoKL1PcDq+Q7/pYAjhtg7HJtZoLRAqSbTe2eOh
	 5Pmz/z9XBZGX8Nis73iPy3IqukO0OYAtFyJxp1iQz7aqUYGsHWlWYLpuZWdtZZQUxo
	 ucM+d0ciqzufynKoQCSS+F5fHFqqdW8s9bW1umV/NEBDjvYPPnXzhnl+3szinFevT+
	 3wn2oq/2AGc7vcwKTWxdFRzCiPW8lDG5TCaYXdS+VWx7IP1ufiULvcL7a8ndF2GAvJ
	 cc5owixOJ9qjg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Li Zhijian <lizhijian@fujitsu.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	cocci@inria.fr,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 622/715] coccinelle: device_attr_show: Remove useless expression STR
Date: Sun, 24 Mar 2024 18:33:21 -0400
Message-ID: <20240324223455.1342824-623-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Li Zhijian <lizhijian@fujitsu.com>

[ Upstream commit 173f6cd384ae27bb57af8cc5201b4f4a137d6e55 ]

Commit ff82e84e80fc ("coccinelle: device_attr_show: simplify patch case")
simplifies the patch case, as a result, STR is no longer needed.

This also helps to fix below coccicheck warning:
> warning: rp: metavariable STR not used in the - or context code

CC: Julia Lawall <Julia.Lawall@inria.fr>
CC: Nicolas Palix <nicolas.palix@imag.fr>
CC: cocci@inria.fr
Fixes: ff82e84e80fc ("coccinelle: device_attr_show: simplify patch case")
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/coccinelle/api/device_attr_show.cocci | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/coccinelle/api/device_attr_show.cocci b/scripts/coccinelle/api/device_attr_show.cocci
index 550d1d2fc02a9..dfcf9304195f3 100644
--- a/scripts/coccinelle/api/device_attr_show.cocci
+++ b/scripts/coccinelle/api/device_attr_show.cocci
@@ -28,7 +28,7 @@ ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
 
 @rp depends on patch@
 identifier show, dev, attr, buf;
-expression BUF, SZ, FORMAT, STR;
+expression BUF, SZ, FORMAT;
 @@
 
 ssize_t show(struct device *dev, struct device_attribute *attr, char *buf)
-- 
2.43.0


