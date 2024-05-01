Return-Path: <linux-kernel+bounces-165310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081358B8B0B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8770283429
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD0512DDB3;
	Wed,  1 May 2024 13:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJe70q/x"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1221DFFB
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 13:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714569655; cv=none; b=I4l4ankR1Qk0W5G0whXJBC1ejhgWBt4seLrSfHud5eY/os6brMuYt6VWtAdqtj6edVgMtnE2G74zwrYVS3CAMQl2Vt2KEgKPBVb0nyVMuu/mPujbuU6PzkvYlgk3RHO/kGHKDBUS5CeHyeBDOkcYxG67QasoyvJP1Msv1KSQ9kY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714569655; c=relaxed/simple;
	bh=CWro4Xms9mhr1ZF/8sTefkMM1W+aIwrOiuyL1rRmo1s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BozemojYMkLDj5Czkg/6gNk/q7tzfjRdrvcow8FjGyaU+09ihSbMs2KiaO/fAwHvzRRTAuhekfjKoJPoM8m+YDvHVyIg0lkBvNK6NT+Per9ByA9Wwpp7JVibbwEpxSm0DeAI+DGEtAQMP8qWLxs6oy7wtn0BQaOPLs0B/Pgk008=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJe70q/x; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2b360096cc4so54870a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 06:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714569654; x=1715174454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZrweeYFzfysHhj3fGqsjBcNklM6yOYXtVsFY8OIDA0o=;
        b=EJe70q/xkau4tmxrwEiKAkwVVz7tzotHFKqCSOsOiZbJuXIenE78gFVZ5Bpi6fE1bq
         xzxcB8hgog8BI62NPz8hEJ/NizKaCOq2mKK6J7nzOBQpRBzAfgi6A+QjvxcDHo8fE0Ds
         1WDHnc04DpzIGzDjjzm1a5QtZKhaeefsajP7+FXJ4UMbtW2Jr9nG1Sib3FAg/eS3xCwT
         wIcOa8FiFsJ38IZufVu3BRQECXDeBuv3/hAoBlb6pbxvPOdPRbu22sTBq2juCw9HUp6P
         sCv4Q5YOJc8IDBcM0dNkj9TH13FM5a1tqU1KDDrMUC1KA5VA+/VTMNp6dNTyx6ZUg1SS
         iEXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714569654; x=1715174454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZrweeYFzfysHhj3fGqsjBcNklM6yOYXtVsFY8OIDA0o=;
        b=Vr1pcd5wMvBD0CTEAUH5BwNaXSwgfYks5E9CeBlpMEB9Rytkm+0L4fen4urKF7Nc2G
         oYo9F31YmIe8kq2zJyEN5GNiFGUootrQy01Zzd7KsNVowSYY5PcA/KGbCXSgZ+4K3nrG
         BHJakd405CAmKd0spCttfvfbYoU0C98Jj7pBad9nLHxSBH2CB0kLPPynZe0Tzo42jCev
         /0I8CAWH2anqeoHlQLIxRe/6B7MfHE1b8UXjAw65GmdNDgYwd0U0tD/hOpjLQOgVUuKV
         wRnN8P+2ncsEndBuwCSaybvBgtztJZPz1rrra+rHE2Cjs9nkc+UVwZLWvbWXMpMwaoKJ
         lfmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzx9NDBeeq1sgiWxgfKRT34l9JBhstq0t0tlPYOB3wtMewTlfh0JuJShHvMN5ZLEWPosinMN+VDD0OE3aTuVrMDkN08JyWflMSshgE
X-Gm-Message-State: AOJu0Yw66r4mC27jfe11lWHN/dK3rvrVkdujhVC6OtKoa/dq8FoTyikX
	ZoG3v3RYdAcsmGofXx30sWaR5s4vsACStZtx73tA0aeuCECSBZI5m97hMwC0
X-Google-Smtp-Source: AGHT+IHcnS0k2ilEejJS4wcBAG72CBh2wBoF029veuRdDbLg1TZwv77/ONtxoee2KpMQ1shqZRiopA==
X-Received: by 2002:a17:903:1208:b0:1e5:1138:e299 with SMTP id l8-20020a170903120800b001e51138e299mr2593924plh.1.1714569653581;
        Wed, 01 May 2024 06:20:53 -0700 (PDT)
Received: from visitorckw-System-Product-Name.. ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id y22-20020a17090264d600b001e0648dfd68sm3277164pli.296.2024.05.01.06.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 06:20:52 -0700 (PDT)
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: akpm@linux-foundation.org,
	yury.norov@gmail.com
Cc: linux@rasmusvillemoes.dk,
	n26122115@gs.ncku.edu.tw,
	jserv@ccns.ncku.edu.tw,
	linux-kernel@vger.kernel.org,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH v4 0/2] bitops: Optimize fns() for improved performance
Date: Wed,  1 May 2024 21:20:45 +0800
Message-Id: <20240501132047.14536-1-visitorckw@gmail.com>
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


