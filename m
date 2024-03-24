Return-Path: <linux-kernel+bounces-114336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C81F8889D4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56C1D28CD96
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA63129E8B;
	Sun, 24 Mar 2024 23:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sg8xXOvQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E1D212563;
	Sun, 24 Mar 2024 23:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321719; cv=none; b=SZ3ZivOjDpCXeh4uZTEyDaVYdyPiAX40413NQwk5h/NIKhTORZ1CUjIqcXsDdRCihK7uJhyk5K+IQ/zd9XOtka+F3kFtayeSLwaB+UvfqFp4wADVfnYXHmpKVd1o8GQdWhL+hRxx3tIhmmICCOnRnQIkx7mydOihM7fc9xoXjuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321719; c=relaxed/simple;
	bh=sQRCYGzckSV5Jjd6wj71S1AaITF1DrtDPJ2/hsC37Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JgYwdgfSzz6S7P9yuyGjIcOAfK1wBNwNvmYWRoyLQbHilK7ug08Ysz7/6s+J+AYo9e9VI7t9mJ0DT0akdQwZC1B2ArzqH+pcIhowbcMfHRXt6KeOjn//fmAcCvMA1l5uEjIBQ7WTkhUuSAJKJI6Uik8HdkbyI3bWBCIqbCvIM/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sg8xXOvQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C57C433F1;
	Sun, 24 Mar 2024 23:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321718;
	bh=sQRCYGzckSV5Jjd6wj71S1AaITF1DrtDPJ2/hsC37Q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sg8xXOvQFW5lBp9Ss2utk6j/dJKS3SqFBLTy7odT4tw5+W2F/hHEbVtrHqrjp791q
	 /5a8opaFIgrcBeggWTFYtzQlD2kloG3mS7X6udXmREBijvCc3jbjM9cewR3Nre/zN7
	 lKMpui7OUCLQLtAbT+6+Z554QXYSQx/ABmAG6dqHi0XcwwtPYcwju4M2CFTikQNDF5
	 cxIt2/rqhfEEEyalHAx4FRqiJbYkjU6J1oiadcM8bNY1O0LH/Tk2CMqapxZPvflZ1v
	 7qM/lzR3+3DKOngUPhaWqFZ52G4dgpGGHlKnyvGlqMNYDv9eMUQ0UmA+CXEhuGg3AW
	 qhJdYEAPpNAwA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Adam Guerin <adam.guerin@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 446/638] crypto: qat - avoid division by zero
Date: Sun, 24 Mar 2024 18:58:03 -0400
Message-ID: <20240324230116.1348576-447-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Adam Guerin <adam.guerin@intel.com>

[ Upstream commit f99fb7d660f7c818105803f1f1915396a14d18ad ]

Check if delta_us is not zero and return -EINVAL if it is.
delta_us is unlikely to be zero as there is a sleep between the reads of
the two timestamps.

This is to fix the following warning when compiling the QAT driver
using clang scan-build:
    drivers/crypto/intel/qat/qat_common/adf_clock.c:87:9: warning: Division by zero [core.DivideZero]
       87 |         temp = DIV_ROUND_CLOSEST_ULL(temp, delta_us);
          |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: e2980ba57e79 ("crypto: qat - add measure clock frequency")
Signed-off-by: Adam Guerin <adam.guerin@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/intel/qat/qat_common/adf_clock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_clock.c b/drivers/crypto/intel/qat/qat_common/adf_clock.c
index dc0778691eb0b..eae44969dc84f 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_clock.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_clock.c
@@ -82,6 +82,9 @@ static int measure_clock(struct adf_accel_dev *accel_dev, u32 *frequency)
 	}
 
 	delta_us = timespec_to_us(&ts3) - timespec_to_us(&ts1);
+	if (!delta_us)
+		return -EINVAL;
+
 	temp = (timestamp2 - timestamp1) * ME_CLK_DIVIDER * 10;
 	temp = DIV_ROUND_CLOSEST_ULL(temp, delta_us);
 	/*
-- 
2.43.0


