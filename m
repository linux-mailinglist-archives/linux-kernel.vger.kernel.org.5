Return-Path: <linux-kernel+bounces-33433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 717338369A3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4C271C2255A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131F2128392;
	Mon, 22 Jan 2024 15:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4vef5rx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F22128383;
	Mon, 22 Jan 2024 15:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936274; cv=none; b=QhxJmGtAwE0EHbnpKOQRBtv48gXdzYktujGrtZ50a2k81vOB4jl4f7vveiTqNUjlw4XPbIM2C9fEKt1E+7weTHdV5dscXi8n1X7nF3U4Jl01VG7BGSryymi9UU5s6zGR167EES5ffZ5Wd3YYB/A5vkR1cqiG0JdlBAM2cVoW+PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936274; c=relaxed/simple;
	bh=Mak+Lj5rUfA9eGs0UEJTZqDvCPi0Bu/m7ejQSQMOZKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VtJudTbkt+3whf+PqSgZlb1tQIGzILfsgQLEP0M/leyvxjGFNr2M6u4Xn5vSfwAbc0ceCrmppa4oF8anRafuCaQH/ihA6h4x5aYsVCQtUj2qYGg8mbPW/+o80WbBB4k0kqc6R1YsnAWGUHUjokNANGRlAzkDVla9Qu5+5cvE6/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4vef5rx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA12C43394;
	Mon, 22 Jan 2024 15:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936273;
	bh=Mak+Lj5rUfA9eGs0UEJTZqDvCPi0Bu/m7ejQSQMOZKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l4vef5rxTlMR7IsaWo4GpYwgi9OuI4UmsreSEvlI7Uilze8OYzQtuSJve8JEteLD2
	 IAgRWdwDNRqUUhU62lAy0n1zu3pbgU5qMMoS9Wf0Z5uGX5kzUQot5PD65NCk3tdhwW
	 WSOO4a711ygAZ+FCSyFBFoSOK7n1USXux3nsV9AIpHJIBSPEY1qOSozH/7OmcMZ3nS
	 M58iC612WqTKyYns5gwh2YQCsmbKBlcQT/fVwFvwOKXlfD3Mw6vVUWTo/K24+0H/dU
	 XpKda7d6O7G4L6jw25wMf9kdRd7W8gzpXegfE7wPkwqqeqc9dZTTCDPhh3dMKioWlo
	 XY8pu2c1/ebLw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Su Hui <suhui@nfschina.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>,
	mchehab@kernel.org,
	linux-media@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 33/53] media: ddbridge: fix an error code problem in ddb_probe
Date: Mon, 22 Jan 2024 10:08:34 -0500
Message-ID: <20240122150949.994249-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150949.994249-1-sashal@kernel.org>
References: <20240122150949.994249-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.74
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


