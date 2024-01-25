Return-Path: <linux-kernel+bounces-38849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 493AE83C73C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00B14292381
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADAC745D0;
	Thu, 25 Jan 2024 15:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="gT2uAi8k"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1097B73172;
	Thu, 25 Jan 2024 15:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706197768; cv=none; b=YKUsxpHYk2nrqLLQwbuRmzEVJAUtVo/lR1KfjDuLow1lVZdNxQBVAm7Rhy06XjgMr4+M141xKEBfz0xI7cLGF7Y7SCOAalub8v+I21BSnrIrWUoqLfLbzh6L71jWb5cU3dv9wmaBIe7cZwXZZ4h7FKF/AWKvqe/+cpUFoAfmbeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706197768; c=relaxed/simple;
	bh=Uq2v743gJaoPIQCnfIBj7JCBZnQMdT1G44QjJkIk6M4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tubmab0Xfy4gMhFmAbdPaoso8Sm6dGh3Go+5uy2mO5oE/HKiqM8OJc28M9t5qT1KnFGuJhB7s/Q4fakSFG7h5T3z1ibwgWvT13eYwUB5cZlQGFFZO6HhEHAfUM5+qkguWwetuPQOj0/pKSlkiWXamXZXsmy+V+pDAlD2bn4rX+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=gT2uAi8k; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from umang.jain (unknown [103.86.18.175])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id BE9E47FA;
	Thu, 25 Jan 2024 16:48:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1706197683;
	bh=Uq2v743gJaoPIQCnfIBj7JCBZnQMdT1G44QjJkIk6M4=;
	h=From:To:Cc:Subject:Date:From;
	b=gT2uAi8kNorNIv1aOJAZFq3AkEKLVK1TZpR2sfGQfMChvsit/SC0fFKPUU7f1CGMx
	 WBQIeuRO/i6KzcfCW8/iqOKV3lnq9OpLZLplOpoymDIqnFbK0LIWBVQpVIFeR2wpJB
	 wx9r5sk1Rktsk/do8QQ3KF84PsQy8oSF0Z8yjPic=
From: Umang Jain <umang.jain@ideasonboard.com>
To: linux-media@vger.kernel.org
Cc: Kieran Bingham <kieran.bingham@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Umang Jain <umang.jain@ideasonboard.com>
Subject: [PATCH 0/4] imx335: Support additional link-freq and TPG
Date: Thu, 25 Jan 2024 21:19:04 +0530
Message-ID: <20240125154908.465191-1-umang.jain@ideasonboard.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for additional link frequency and
test pattern generator on IMX335.

Patch 1/4 is a drive-by patch which drops setting of a reserved
register.

Patch 2/4 is also a prep-up patch for TPG introduction(in 4/4), as the test
pattern needs sensor to be powered up to apply the test pattern.

Patch 3/4 supports for additional link-frequency supported by IMX335

Matthias Fend (1):
  media: i2c: imx335: Add support for test pattern generator

Umang Jain (3):
  media: i2c: imx335: Drop setting of 0x3a00 register
  media: i2c: imx335: Refactor power sequence to set controls
  media: i2c: imx335: Support multiple link frequency

 drivers/media/i2c/imx335.c | 227 ++++++++++++++++++++++++++++++++-----
 1 file changed, 197 insertions(+), 30 deletions(-)

-- 
2.41.0


