Return-Path: <linux-kernel+bounces-123631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E2C890C01
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C17128FD79
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5A613A890;
	Thu, 28 Mar 2024 20:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="q4TOXabn"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F67B13A3EC
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 20:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711659170; cv=none; b=Dzx/EXm1xjMJFcoIuOjsQDbt3a/HtUV9vJZL3tmdLNPPGLnmWsYSuLwzDW6SPn5gm4TosT2t5hHjMBmQE0ukecB3OJ/SstInC4JpaOJKSG4zUBzmGKzvJXiHgV47lvqXg0D1CQcXVBYckGJY4lyMjSliNamTOGapjemZcQ/iS+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711659170; c=relaxed/simple;
	bh=7UyDEEhXRVC9YT07DUG5+nGDJxjmpSag9Bdr9s5BvC4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XwJsIA5cPLkCAlyeIXCqLW2QNmK2pkse49GKNgqrkYYUC0Bo5AWX5tJ5Bs3XhzdjA1KZdv6CbnQtscd7/At8rW7duhT5jZpSN0JAt5m04CPPbQjrWA0UmP4zQiRCUTxsBdO87IfuZM//gMzDY/StgSJ/Mi3b33Vg5umg7o0pHVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=q4TOXabn; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6e4f7975121so400423a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 13:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711659166; x=1712263966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1oafGYSMDWbldY67kkeEJQsFsMqsUZhgffGbLT0XrLE=;
        b=q4TOXabnKhP24R45ADDQyqOyQjwWEoVKzBFa3rUhPs7DfqhLftsFs4mDk2atutrvcb
         vTjDnKhQTl/jpAZepx3EGggI2GZ++RmAeiv31dMPHgyEqYxrx8Gk63zr4JYhIZ2hNMWJ
         orEEVKE+Db3j3kjofuA9X5546g8cEzj/OUSSdWXcO1tPqCFVC7e3V7NZiygmTp2b4RIZ
         j1xMaoElHRNI00XSQpnoAl00Ggd38cuTeofObXl7D/adCDlKPaT0qpMy5XdWHUTbFHZd
         xylzEoV2J/M7NFtrrcAFqYYrJKc/u3fZRaMwH0K+j1tYL3n0MXk4g0lM4YUV4/SRx3/t
         2hOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711659166; x=1712263966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1oafGYSMDWbldY67kkeEJQsFsMqsUZhgffGbLT0XrLE=;
        b=AbAuu6Z9PiiAyhdhNKWdfEDGpma0ikNy5+fKFdCfNfpROas9zQla+oFABhrJ6qSml1
         I3ePySOz/b5WNdc+CAo9Jyn+vf+dT5UdBLf/OzSduwCBG/PSRbxF+m6Z5u3GRc2zB6MB
         cPyfuPVszTVd5J9I+ARKETz+BiRUPzdNw/VoCyGft4+iJuTMsL26vEAGxvSWx+Tqn8vb
         EeeMhutExde2ujL0p4hLs4Zx+bHRQt/7510RT9x4ks3+pivZhKomy3LIHT+XK+aVU456
         9nkmTWfrBq6wJLV20rrDeJDB1n1vfRxEKEGNdR55qu8TmkhG5KqAX3OpJCjmw/2gohRL
         AXjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYB/6bYCeusqZug/tErZUTX9Ku/mUOS9VMibmG29Ex0o87y4FcufTy4ZvYXEXXf2DAkNoNaoIzZsiHoE3blQHKtOxfaex1XPyrF8mp
X-Gm-Message-State: AOJu0Yx/uX5hDUYc2ICPFeNmnffAwzeJ/RQU+xAa6jCHxbkkyWINv0L/
	g6BqM+Wu7eql+up8Kkgs5m48IK83xXyPiEH2IxZuVG8jHhGRPjwkIXsldA3ELq98KhJBo6o/fNZ
	T
X-Google-Smtp-Source: AGHT+IG2LmGIXgiSazqUev3B1fMmsJtbXu1EvtvGf4MxW6SLEAkVF2plvzNwzAhJMUF1ils7GZuHdA==
X-Received: by 2002:a05:6830:1308:b0:6e6:e690:49f0 with SMTP id p8-20020a056830130800b006e6e69049f0mr396581otq.31.1711659166553;
        Thu, 28 Mar 2024 13:52:46 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id g16-20020a9d6c50000000b006e7011fea78sm293335otq.41.2024.03.28.13.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 13:52:45 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] spi: more tx_buf/rx_buf removal
Date: Thu, 28 Mar 2024 15:51:44 -0500
Message-ID: <20240328-spi-more-tx-rx-buf-cleanup-v1-0-9ec1ceedf08c@baylibre.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

I found a couple more controller drivers that were checking if the
tx_buf and rx_buf fields in the spi_transfer structure were set by a
peripheral driver that I missed in [1]. These checks can be removed
as well.

[1]: https://lore.kernel.org/linux-spi/20240325-spi-remove-is_dma_mapped-v2-1-d08d62b61f1c@baylibre.com/

---
David Lechner (2):
      spi: au1550: t->{tx,rx}_dma checks
      spi: fsl: remove is_dma_mapped checks

 drivers/spi/spi-au1550.c  | 29 ++++++++++-------------------
 drivers/spi/spi-fsl-cpm.c | 14 ++++----------
 drivers/spi/spi-fsl-cpm.h |  5 ++---
 drivers/spi/spi-fsl-spi.c |  7 +++----
 4 files changed, 19 insertions(+), 36 deletions(-)
---
base-commit: d5449432f794e75cd4f5e46bc33bfe6ce20b657d
change-id: 20240328-spi-more-tx-rx-buf-cleanup-8198f2898036

