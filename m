Return-Path: <linux-kernel+bounces-152520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C97D8ABFB2
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 17:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5227D1F2154E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 15:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E430A18C1A;
	Sun, 21 Apr 2024 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SwB74i5c"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A04B182A0
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 15:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713712658; cv=none; b=R/pR+WuRTach9US/S1mj1RB2B+Wn4wl+HjnaaW0udWmgE9b6Soh+HaHw/cAxQDXHwTvR5WNGv9jJsEfeCNtV50GY3RUHRTvAndye7AQ9aSN24xzwBcBukNKnh9PJOVsSCWPz3MeW/NmR5nI9GTz4lcin6mboBkSfO74O8zE065s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713712658; c=relaxed/simple;
	bh=q1hyGuqrtoU7mR36qdqK7lNmY/vN03a50XuwjHuqeso=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DDdlmdlLYqeQBq8HWZvzbWKUbvm8+m2ux5Q6jETV3zo45rnMlUpE1KLQm2DG5mzikso+6QLScKtRETVVoNrheUrvqQi98sSIqlVevlaGHvAtfrtLc/gxeTX41v3fMtyiY5Mumol1eNVBspE3vasimcmsAyTNqdXmB0uwD/SbUA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SwB74i5c; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7d6bc8d4535so144174539f.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 08:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713712655; x=1714317455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+xfn7JCqs4DJP8L1doG9UlSi+qLTT0gfyOPjnyjB13U=;
        b=SwB74i5cn1YVwKIy9yzviPeWz6rOUZ5W0jVXTq0+BbBZvW6r5zBK9VqnWsD6kpLUut
         /K4Js5qKkfm8L9GxglIhcEcMUDbYeLTGuVQEfYsUDubUXctynmUQ+EK56VdrheNzTTS1
         C9GRvm0RRfjT3I9cJ/8/O0ei3NkwnLNql1lWCwv0vwjVlCNb8U+KPKFc/QGDeV/KjkCx
         79Cb8JmfxPoIG8MUb26fywz8WBMTF4MKJZGJvLpDYLhV0tVrnoA/6taR0s13BBNlyo3/
         XoWMKUMNmrKklcEBWirLri+fzvYMFZcLR0Kne59qAicZwUu+3Aggxs9lmbz2TW4q7v7u
         exPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713712655; x=1714317455;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+xfn7JCqs4DJP8L1doG9UlSi+qLTT0gfyOPjnyjB13U=;
        b=xFELsW+WKPr4tg4kxUl5ThMHSpgnqVQBcGkxfcxtRd0PbbvbUBCJ2l/b9zJGNB3nYH
         3nBuXsbYEiU/cdaPrDJmVWrytU70EB2QfD+LOPP+fSAklLYi/xWB8RsBigDy8GUP+xDN
         j27a1uXWVz0FIBmL1Ma7etT83bfqNKh2rnKD3KSOp8uGdjC4IcgjKabcwYdSHyJ1TYO5
         1qoMsxdcly0A38cQH699p4fL9txkVeCe6W1hl64fNBT9KOyAQXlFcwT2/MCxygNhJViE
         6IuYBJXHOg2CiaMmO8GZVdwDJ71Y0y7Pykkq1ZZV+OSjD4otvmHhzldFFu31VSSRZkJy
         D/TQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN40Q5pSZ/goyacAb9pTZ5VcC5kiTUoWa4ZsSIaDqQKjiA7few/Ot9ESIteY/Fwvg0qJdD7BWeVQYJv2jrgUoFqk4NgWZMLsBIx+Nj
X-Gm-Message-State: AOJu0YwW254rddAJnbhubpA744d6EkRDZleR4g2LHtyTYxX1Zb0Ecw/V
	nyauY/CJ9p5GjKSrJn7cd0pV2tTRiDuPMwu0dsgjLt3pkR1D7uMKkW62a4cpn5k=
X-Google-Smtp-Source: AGHT+IEe7Kimv8GgDCtMG2dmDPa6n+g+6anbsvUuvqQyRVjthTFfY/QgqiMrnX55lF7LMO2kJDpSHw==
X-Received: by 2002:a05:6602:1b92:b0:7cb:ffe6:b320 with SMTP id dq18-20020a0566021b9200b007cbffe6b320mr8433088iob.5.1713712655703;
        Sun, 21 Apr 2024 08:17:35 -0700 (PDT)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id i17-20020a0566022c9100b007da1efc9b3asm2044016iow.43.2024.04.21.08.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Apr 2024 08:17:35 -0700 (PDT)
From: Alex Elder <elder@linaro.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mka@chromium.org,
	andersson@kernel.org,
	quic_cpratapa@quicinc.com,
	quic_avuyyuru@quicinc.com,
	quic_jponduru@quicinc.com,
	quic_subashab@quicinc.com,
	elder@kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] mailmap: add entries for Alex Elder
Date: Sun, 21 Apr 2024 10:17:32 -0500
Message-Id: <20240421151732.2203345-1-elder@linaro.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Define my kernel.org address to be the canonical one, and add mailmap
entries for the various addresses (including typos) that have been
used over the years.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 .mailmap | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/.mailmap b/.mailmap
index 8284692f96107..a78cd3d300eb1 100644
--- a/.mailmap
+++ b/.mailmap
@@ -38,6 +38,18 @@ Alexei Starovoitov <ast@kernel.org> <alexei.starovoitov@gmail.com>
 Alexei Starovoitov <ast@kernel.org> <ast@fb.com>
 Alexei Starovoitov <ast@kernel.org> <ast@plumgrid.com>
 Alexey Makhalov <alexey.amakhalov@broadcom.com> <amakhalov@vmware.com>
+Alex Elder <elder@kernel.org>
+Alex Elder <elder@kernel.org> <aelder@sgi.com>
+Alex Elder <elder@kernel.org> <alex.elder@linaro.org>
+Alex Elder <elder@kernel.org> <alex.elder@linary.org>
+Alex Elder <elder@kernel.org> <elder@dreamhost.com>
+Alex Elder <elder@kernel.org> <elder@dreawmhost.com>
+Alex Elder <elder@kernel.org> <elder@ieee.org>
+Alex Elder <elder@kernel.org> <elder@inktank.com>
+Alex Elder <elder@kernel.org> <elder@kernel.org>
+Alex Elder <elder@kernel.org> <elder@linaro.org>
+Alex Elder <elder@kernel.org> <elder@newdream.net>
+Alex Elder <elder@kernel.org> Alex Elder (Linaro) <elder@linaro.org>
 Alex Hung <alexhung@gmail.com> <alex.hung@canonical.com>
 Alex Shi <alexs@kernel.org> <alex.shi@intel.com>
 Alex Shi <alexs@kernel.org> <alex.shi@linaro.org>
-- 
2.40.1


