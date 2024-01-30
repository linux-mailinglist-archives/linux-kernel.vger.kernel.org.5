Return-Path: <linux-kernel+bounces-44064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A070F841CE3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40B861F216A9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAC153E07;
	Tue, 30 Jan 2024 07:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ViRpY/vh"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEF54C614
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 07:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706600875; cv=none; b=bPlJ9zfAf/BSi18QMwgrtdWJ2m6BYWUi+I8FPpyEpB52h+abyX0knhqZxGvdemdNoigFbAhzrNa6W6Mbeswh1FvwPrftAkYjghb3I1M5VDuHmmQ4YrkKp0ILDDdBtO39/QCVn+1/+J+LGaROd4KdiU+hH9UMOQ/B/K6CQ2h4lu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706600875; c=relaxed/simple;
	bh=ZD9FjIFEh9g0f9kLwm6/eKa1ui1iFwhuOPdBntCyj6U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=WAS+HjfNuD5jsM/DO89etNPldOqvlzp6iw+yTZQAFoQpcwRE3h5s7WdJ4w3Y7tg3Qk0n7U/2tvAfUZpxjzrOVLr6qY4McgZ/vUBzDyNtKflZeENk5aXxUO8RPLZIVi2T6zYZLXSGTRSSMY8vNNFoWcHqHPxQVce9jzq7Nx+l3PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ViRpY/vh; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706600870; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=sRk2HXZ+P6gMiJU8Q6E3wGvbidxUtQKZLf2zoOIxXPg=;
	b=ViRpY/vhOANXK2gTTrdULYBcmCE4MEa0YDbd8IVUREQe73aRfvB/cwDGpIAwSmvxZt/Cmjs4FdVqD6o6iLsq09YfJ1Ir/PUCIl4t1xel2N9pyJFh3c3CLpycGHrcTXO2feOTQ4IRUlCmwed2T5I//kscGUF0OizsHWy9EDcNopQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W.fTvZz_1706600868;
Received: from localhost.localdomain(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W.fTvZz_1706600868)
          by smtp.aliyun-inc.com;
          Tue, 30 Jan 2024 15:47:50 +0800
From: Bitao Hu <yaoma@linux.alibaba.com>
To: dianders@chromium.org,
	akpm@linux-foundation.org,
	pmladek@suse.com,
	lecopzer.chen@mediatek.com,
	kernelfans@gmail.com,
	liusong@linux.alibaba.com
Cc: linux-kernel@vger.kernel.org,
	yaoma@linux.alibaba.com
Subject: [PATCHv2 0/2] *** Detect interrupt storm in softlockup ***
Date: Tue, 30 Jan 2024 15:47:42 +0800
Message-Id: <20240130074744.45759-1-yaoma@linux.alibaba.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I have implemented a low-overhead method for detecting interrupt storm
in softlockup. Please review it, all comments are welcome.

Changes from v1 to v2:

- From Douglas, optimize the memory of cpustats. With the maximum number
of CPUs, that's now this.
2 * 8192 * 4 + 1 * 8192 * 5 * 4 + 1 * 8192 = 237,568 bytes.

- From Liu Song, refactor the code format and add necessary comments. 

- From Douglas, use interrupt counts instead of interrupt time to
determine the cause of softlockup. 

- Remove the cmdline parameter added in PATCHv1.

Bitao Hu (2):
  watchdog/softlockup: low-overhead detection of interrupt storm
  watchdog/softlockup: report the most frequent interrupts

 kernel/watchdog.c | 222 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 222 insertions(+)

-- 
2.37.1 (Apple Git-137.1)


