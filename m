Return-Path: <linux-kernel+bounces-33363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F7C836941
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E64A8B260C6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6585A6A026;
	Mon, 22 Jan 2024 15:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/fam52P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AD96A00C;
	Mon, 22 Jan 2024 15:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935977; cv=none; b=qtpBfmWdP3tOCJsGS0J4UQUPYvaEqZ7SeWjj5et97bagpzpXjuoHNxY8DXVev4Zo7KHYLxN3aqzgXOdDhhUJCklF8s2OTe8EvbEHMnFtCzh+1kaqlcKqUMxAA7JL7wMf6m3bQmUCPL1eOBs5YyEPRKQuuMNd9TXviPqRwt0fK5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935977; c=relaxed/simple;
	bh=Mak+Lj5rUfA9eGs0UEJTZqDvCPi0Bu/m7ejQSQMOZKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dSga9DORDEBcPKDPoSvHEG5H0iwLrGb35VYMeyY6bp/4eZuYs3bswLEjZwjlqaFZfty/RwbMetOGAWoGCdDWqibz+c7UYvCLej0OtWRzD8PcYPXMDFkazkwtRf2tF8KcNX33ujYzgHpsbb1yQSSG+nEadmZUAYVaKioCy+r2CIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/fam52P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B696CC43399;
	Mon, 22 Jan 2024 15:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935977;
	bh=Mak+Lj5rUfA9eGs0UEJTZqDvCPi0Bu/m7ejQSQMOZKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I/fam52PExknBpM7g35GIHi4cgw/h05B7VqN+CzeV3WQIaKXw/k7c3C/DtLr/obnV
	 y85W0nSjd9uCebNOMK4cDL5qd60VgeEsrnw6a7BoQtwFB7DA0oRkAd9J3jVFZUE0Nd
	 N43jKiWaXQ4LGo3RrrKH5xWxvkbNlDg5lgO4KMpHvBq35mjAMNGjvLH7o0EGTdw7YC
	 CwWqagilqF2JB9+rtI+OkCHVF2WcsBnFiIwqhafjHdjidcg5SH0R+dQr4pdxsTJeRA
	 /qP5VwD5J8vSfCCF8IAu/LBKXwSfvwLXUPjHFWqIykszDOn+gESkdROfVh7ETmR4RO
	 hLSnZKmfdW6Eg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Su Hui <suhui@nfschina.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>,
	mchehab@kernel.org,
	linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 41/73] media: ddbridge: fix an error code problem in ddb_probe
Date: Mon, 22 Jan 2024 10:01:55 -0500
Message-ID: <20240122150432.992458-41-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150432.992458-1-sashal@kernel.org>
References: <20240122150432.992458-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
Content-Transfer-Encoding: 8bit

From: Su Hui <suhui@nfschina.com>

[ Upstream commit 09b4195021be69af1e1936cca995712a6d0f2562 ]

Error code is assigned to 'stat', return 'stat' rather than '-1'.

Signed-off-by: Su Hui <suhui@nfschina.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/pci/ddbridge/ddbridge-main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/ddbridge/ddbridge-main.c b/drivers/media/pci/ddbridge/ddbridge-main.c
index 91733ab9f58c..363badab7cf0 100644
--- a/drivers/media/pci/ddbridge/ddbridge-main.c
+++ b/drivers/media/pci/ddbridge/ddbridge-main.c
@@ -238,7 +238,7 @@ static int ddb_probe(struct pci_dev *pdev,
 	ddb_unmap(dev);
 	pci_set_drvdata(pdev, NULL);
 	pci_disable_device(pdev);
-	return -1;
+	return stat;
 }
 
 /****************************************************************************/
-- 
2.43.0


