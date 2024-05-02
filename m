Return-Path: <linux-kernel+bounces-166215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 859AF8B97A2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 902DB2898C5
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACAF55C26;
	Thu,  2 May 2024 09:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iQmNT1Ia"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A26953816
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 09:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714641891; cv=none; b=cYg85kFNaZ3sy0oCH32F6ULAdGS1zgF4Xhsgd2BKt+VqM26Gh7GklJA9Xhu30vW5PWxAHPCWPIAyq1i0oNU9dZ68otG0wIkYr10VVmHjE936c4zHF/15x+/W2K17kja7M6AYckZV/7X4kiFbbr2G4PldYOUrXv7+hloYbcV0z7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714641891; c=relaxed/simple;
	bh=cKInVC5T4I3HaxUrrsdmRZ5sx+HsrlLpLX/flkMO0iE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UC02sdj5wcS5RfMAY6trsahYhT+5tFA2YcEt/xqRsTCtd+na8v+89F76pqfS2U5jdvE0C1RK7WVWPC4vuB2Cg5epUdDkzmpaTxbxIidE2DQiAw6v+skWD7lC4P9gmL+7F+BupsU8yO4Z4kpEITZhZpMZlbMbZ9NGAiqEXF7jkrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iQmNT1Ia; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2b3e2d3d05cso28420a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 02:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714641890; x=1715246690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X2Vn6MUWYq052ee8OD6labzPW3pLyYdDuIFE4s71etM=;
        b=iQmNT1IaSNprRohC2fkW+yQfUqzIPh3I8xlApeMstosk6GUOWZaEvJCez2BX6FP89u
         r9OzjnGAN5Ke/xIY6cUZsSCk6m9UQ7CxBTB0XB1BjmTFOFMkfKfb9lylzicKa2kqy710
         Xmy8z+QIqaWxIq1HFpEUH8SHk6ACAVddDZevNJd86P5mQCLtJuN8GOBgMm9BbttOVJ5m
         76zHrOmCigYobGvd7Nvbw8N3qtyX88V/CukUvZihZ+foUnyYB9alk1xmRqK1/TubPdTi
         XkA3bwKFA0iG+FeGaw5STUDTZ6m9IKbETb3Uu9avKLvHMQ8cdiVt9OxkIyoWSB0Sn5uU
         Pd6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714641890; x=1715246690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X2Vn6MUWYq052ee8OD6labzPW3pLyYdDuIFE4s71etM=;
        b=DZo5JX4zpWALn5Rt84bMxj0OwHCtYul3ZiK/DYvATzTxIj5xCtCRe6woHXAPcG8S/s
         c33ixNtkuWAixgYTg12Otu+6Cmv+cOA+aDIc/OiF+qppflAX/2XX5dDdcB4zUD9O1A7N
         2aWH3J0OW98YScuMUrw+xafpy25ZpHWtLF4QetABZOug+tDghA+MQHofohg6ANIBohIr
         RA1HZwFAYIJILJh91N4emNKIcKBENiI8+5vSfx1bAgn3RcmuJMidFc6CxdbCkK+Mteyl
         NlmGnnh3HtsIQJpP22Z8zXLpm6kOBN0u03nRiXA7acPpmw6mhhpLaJA326J/d000uW/O
         UaZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3W4tmlMmERBk3S9/WJAZ3qLNK4yBqW463OaYSGmylxeAPKvoN3ClbxVooTKvm8ogamRR3AOyGZ8I6hlZXCrdIvqaXMn0swyUSQFMe
X-Gm-Message-State: AOJu0YxsPK93OaPtJTxLeulV3b1FtXqBc7+P5Ws8/pnf5OjkDntfuFGP
	nRoSI+hkmTX+Gy1YXyYIiPnVLZS/dvakoVVs9c4n/EipyS/7Lflpp0lxqFP3
X-Google-Smtp-Source: AGHT+IFKmWdR/Ceayt7BlKUetWLuFEgvrkXK/cYSmIy7d3R4IuXgwH6fVZZp0cqI9U4XCBiH7DXrRA==
X-Received: by 2002:a17:90a:fe86:b0:2b2:760d:9507 with SMTP id co6-20020a17090afe8600b002b2760d9507mr5241959pjb.0.1714641889612;
        Thu, 02 May 2024 02:24:49 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id bk15-20020a17090b080f00b002a51dcecc49sm746836pjb.38.2024.05.02.02.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 02:24:49 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org,
	yury.norov@gmail.com
Cc: linux@rasmusvillemoes.dk,
	n26122115@gs.ncku.edu.tw,
	jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v5 0/2] bitops: Optimize fns() for improved performance
Date: Thu,  2 May 2024 17:24:41 +0800
Message-Id: <20240502092443.6845-1-visitorckw@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This patch series optimizes the fns() function by avoiding repeated
calls to __ffs(). Additionally, tests for fns() have been added in
lib/test_bitops.c.

Changes in v5:
- Reduce testing iterations from 1000000 to 10000 to decrease testing
  time.
- Move 'buf' inside the function.
- Mark 'buf' as __initdata.
- Assign the results of fns() to a volatile variable to prevent
  compiler optimization.
- Remove the iteration count from the benchmark result.
- Update benchmark results in the commit message.

Changes in v4:
- Correct get_random_long() -> get_random_bytes() in the commit
  message.

Changes in v3:
- Move the benchmark test for fns() to lib/test_bitops.c.
- Exclude the overhead of random number generation from the benchmark
  result.
- Change the output to print only a total gross instead of each n in
  the benchmark result.
- Update the commit message in the second patch.

Changes in v2:
- Add benchmark test for fns() in lib/find_bit_benchmark.c.
- Change the loop in fns() by counting down from n to 0.
- Add find_bit benchmark result for find_nth_bit in commit message.

Link to v4: https://lkml.kernel.org/20240501132047.14536-1-visitorckw@gmail.com
Link to v3: https://lkml.kernel.org/20240501071647.10228-1-visitorckw@gmail.com
Link to v2: https://lkml.kernel.org/20240430054912.124237-1-visitorckw@gmail.com
Link to v1: https://lkml.kernel.org/20240426035152.956702-1-visitorckw@gmail.com

Kuan-Wei Chiu (2):
  lib/test_bitops: Add benchmark test for fns()
  bitops: Optimize fns() for improved performance

 include/linux/bitops.h | 12 +++---------
 lib/test_bitops.c      | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+), 9 deletions(-)

-- 
2.34.1


