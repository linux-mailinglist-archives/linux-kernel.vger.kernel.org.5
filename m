Return-Path: <linux-kernel+bounces-115940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E8BD8898C5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 602D11C31B1A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A16A38EF20;
	Mon, 25 Mar 2024 03:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pa9VHCWp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A78522AB97;
	Sun, 24 Mar 2024 23:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322154; cv=none; b=bn3exQPSH6b1PhMZpmT8ZYKOmAr0/+x4G9MTWe9CMKcNh3tXunhDjKp67wA7JdoV9fzEf/Ux7+c2Jad51Y9o7AsvLC7RHOJproUWWwCLynF7OnsNY8xIpwu8zpYEbZ+cZkNHEw967SipF8TB9S4beaJ7gyMvHlgbR5p7toHUhHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322154; c=relaxed/simple;
	bh=gwobMM9/9qbaSInsdF01UBeLUAeQfgP6FuCZ2TJ+iXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MO9a7+p0P3RPdYMmZfQPMxEotCPAOqQ73Kaa7dHvSApjOmmARplYYXIYNZk4LW5LOzBronH4s4WMI4Qg/kahbOWxMksthiB2G+EgUFO9KBDJ4lHTEmNNPeDhoupJvaG3boo6iTn4sSU5zcSPS1T3WuPgC25hJqqreG2/uX+kP6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pa9VHCWp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34280C433B2;
	Sun, 24 Mar 2024 23:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322152;
	bh=gwobMM9/9qbaSInsdF01UBeLUAeQfgP6FuCZ2TJ+iXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pa9VHCWp7xTj+B1GvCAGGdzLmHCRtfC/Sfl3nBUKmsJIqKoE0bvRwJAYbHqZO1DYf
	 kVifqG+0nqKO7qwTxtxaaOpP7fZBwMU60wMkIP3dQWvjj6Z4vcx8wEhIi2EVqeBY70
	 JO2YJKlyE5sQYgjUz3MKuP95M53nVMXxZdCp6rCI8rCOH9JTO8vw6JtfG5/MKIU4rd
	 rE+QVfw/OwfA8Pj72QzDaRYRI9aWle5B4BatwaxgCMC1paK1kcFoL/Yt/RdpzLYm1C
	 OOeBdIxThjsbSDqf/oUEly3v5FL87Ia4BoyXVbp+XuEUAGtn4G89c3DunBjSkjVwZi
	 zUgtusRNUDqhA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Duoming Zhou <duoming@zju.edu.cn>,
	Louis Peens <louis.peens@corigine.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 230/451] nfp: flower: handle acti_netdevs allocation failure
Date: Sun, 24 Mar 2024 19:08:26 -0400
Message-ID: <20240324231207.1351418-231-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Duoming Zhou <duoming@zju.edu.cn>

[ Upstream commit 84e95149bd341705f0eca6a7fcb955c548805002 ]

The kmalloc_array() in nfp_fl_lag_do_work() will return null, if
the physical memory has run out. As a result, if we dereference
the acti_netdevs, the null pointer dereference bugs will happen.

This patch adds a check to judge whether allocation failure occurs.
If it happens, the delayed work will be rescheduled and try again.

Fixes: bb9a8d031140 ("nfp: flower: monitor and offload LAG groups")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
Reviewed-by: Louis Peens <louis.peens@corigine.com>
Link: https://lore.kernel.org/r/20240308142540.9674-1-duoming@zju.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/netronome/nfp/flower/lag_conf.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c b/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c
index e92860e20a24a..c6a2c302a8c8b 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c
@@ -308,6 +308,11 @@ static void nfp_fl_lag_do_work(struct work_struct *work)
 
 		acti_netdevs = kmalloc_array(entry->slave_cnt,
 					     sizeof(*acti_netdevs), GFP_KERNEL);
+		if (!acti_netdevs) {
+			schedule_delayed_work(&lag->work,
+					      NFP_FL_LAG_DELAY);
+			continue;
+		}
 
 		/* Include sanity check in the loop. It may be that a bond has
 		 * changed between processing the last notification and the
-- 
2.43.0


