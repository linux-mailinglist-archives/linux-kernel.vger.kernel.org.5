Return-Path: <linux-kernel+bounces-115045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 834D2888CB8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C9F728E1A0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA5F2EE7C5;
	Mon, 25 Mar 2024 00:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+GKWDyy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4CD2853E2;
	Sun, 24 Mar 2024 23:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323827; cv=none; b=ivskeUgttptEZ3/T3gn+Hl96ym34WSLaAp/Xby2BTb3V3LON5ovhtwX3GPy5qnQPpYBnhU50wygtZDz3O/NwDUmb/zvHpD8dSwYixw1SsGqdRSIXC+y7WNg/emNvh53585X4OhOazpf7CZFdOslfX/i880Jh44Bo1mbKQIfWewU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323827; c=relaxed/simple;
	bh=1O29+L8eYLtaC1wsuuN4KIqG/8nPNXCARHuSIJi92SA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lP9Bk2Rrn6JCgXdzoM73yGQSM32R2Nl9Dg10toeAjZrhjvDt3eHWJncwFsdgOfrsS6cNXrpd5h5tSq83OOAqqHTUcZZLXNDXjawifFyhPdm7+b7WofZb6ilB7Tt4q3KN4kH/TS7rtYaNyYpEcVBmOOPKyKUvFGqMopwx4C5+aGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+GKWDyy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DDDBC433F1;
	Sun, 24 Mar 2024 23:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323825;
	bh=1O29+L8eYLtaC1wsuuN4KIqG/8nPNXCARHuSIJi92SA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d+GKWDyyonqgJDDnKPidb3HTFLrbv2ylZLWIWts+eK2/iflRt6DpSIQCnN9lAiTZ+
	 R4hdV55LA4IShK4bwiJVaulHIGoOEtgqtrg3ieHBnQrwjlNSvRX04/B+G33SVpWJms
	 IBaurZ7/WZOfL8ZE3JpeJd9rNQ3Gg0Oy1hckwRD+FBFeYU5lrjX6dQ8xnk2ozhExdd
	 vpyPZ/XWwiyJ2wSdaqISU6oNCLnf0py7QWE5SYC3gHiYzFTHqIbZGQ0WSe8c6hJQQs
	 htKqafNVf4QNOaPr5JqdxCufQCVdxjDNS8LyxR/EPZP5UijQJqiO9dceODWhcF3Q23
	 z3MQ3XBkVuLEw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rikard Falkeborn <rikard.falkeborn@gmail.com>,
	Arnaud Pouliquen <arnaud.pouliquen@st.com>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 204/238] remoteproc: stm32: Constify st_rproc_ops
Date: Sun, 24 Mar 2024 19:39:52 -0400
Message-ID: <20240324234027.1354210-205-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Rikard Falkeborn <rikard.falkeborn@gmail.com>

[ Upstream commit 0eee3d28ff6572f0e1afd41e863e44d396a308e2 ]

The only usage of st_rproc_ops is to pass its address to rproc_alloc()
which accepts a const pointer. Make it const to allow the compiler to
put it in read-only memory.

Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
Link: https://lore.kernel.org/r/20201107233630.9728-3-rikard.falkeborn@gmail.com
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Stable-dep-of: 32381bbccba4 ("remoteproc: stm32: Fix incorrect type in assignment for va")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/remoteproc/stm32_rproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/remoteproc/stm32_rproc.c b/drivers/remoteproc/stm32_rproc.c
index df784fec124f6..5f12553f0b6d7 100644
--- a/drivers/remoteproc/stm32_rproc.c
+++ b/drivers/remoteproc/stm32_rproc.c
@@ -553,7 +553,7 @@ static void stm32_rproc_kick(struct rproc *rproc, int vqid)
 	}
 }
 
-static struct rproc_ops st_rproc_ops = {
+static const struct rproc_ops st_rproc_ops = {
 	.start		= stm32_rproc_start,
 	.stop		= stm32_rproc_stop,
 	.attach		= stm32_rproc_attach,
-- 
2.43.0


