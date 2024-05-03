Return-Path: <linux-kernel+bounces-167440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 439738BA9A6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4F3B2827F6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190FC139CE5;
	Fri,  3 May 2024 09:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lDXJypAk"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58A814EC5E
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 09:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714727917; cv=none; b=U/iuzbxJ7oHo3Sq6RDFtbTp5bKIcPOid5bJwfF1Qvqgq7M49zoDy9NRA4lAwyMBrrQkNat1QKaeB8MjWXRpaYq0ONY6mUJaMiKu8fgLEMXMuo0Ce6DUw7GWPtg/pH5s6IIdVG+X/ws1rkycPK4WtTkWcFT5K6l3XaAVQ/hYQ1VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714727917; c=relaxed/simple;
	bh=aDjTGh+IaHd1Y1oeNCzyWnV4PwsuyBKXATAcYwlR3SE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XWQzJmxLbQPSFB9AREBUJvui/RVlwfDfReIX1EkXTg4MQGxNYqBtf2KeR2RCRFyZP+p6J2Jo4B/HgBd5DDEE8p8HNwNLqV4e0TaW7xauC4X3Zy+1itH+MXx/BdBhR6+7GIKUg8ANBcXAL9f+9O+5gcXSfPQqAd9vlLhocQL9Q5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lDXJypAk; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6ef9dee5bddso670161a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 02:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714727915; x=1715332715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AwVJQNVy6/ohJSDmqCPdG8S/OQ4/Nr2Xkb+o67Sj7fY=;
        b=lDXJypAk3VAeeDnAAUnvjrfIOC+zvBg6m8T706EzNwDzfPh/BmnnxqF6jYflrIht6Q
         BH2HjA/fwmTyOFsAnaOgx2ucM47U/7AXO6fEoY1PKKlRdf4Tt7Qcp8Qq2JBY3usNFTJg
         3kCcW13RsB6jdlS6A8gIK9AIGryAUoN545E8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714727915; x=1715332715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AwVJQNVy6/ohJSDmqCPdG8S/OQ4/Nr2Xkb+o67Sj7fY=;
        b=b8RE/+/klkSaRbhAh70U7IS7JBniANKLgnsWPRuJZXPFwEKv1+idBAuuoBmlRv9naf
         nk0VTE0Qt4piQOgpUG3UHZYcVXjAslXMf9UovwOuBHuwz2KpIwgRRgDwowWQEve0amxI
         XR8HieAohrfGkZSbbsgvMHU2bu3p16RcIuEJN8boJsZYC40+eG9dsiBM5MGb7yU5Uf/w
         4wKhHWtiGi3B9W98ggpiRSf3UUuCukCipk2n6Po9PwZ8ynA7ZkryyptaURln8pC1LCGP
         pcgpJxMi+ABxBtyqMnMdnu997s1IR/4IoK4KtUd4eBXllOJuSSz+LA6QbWWEasiKSBs5
         1kWQ==
X-Gm-Message-State: AOJu0YwZGwqRBBtPthToHKkV/iJ3nKYwhoJAh8MsQEoDM1ISNfLPRrMw
	rUUGQWSH9geo4ynwqgkARWdPFkElMz6Ur+mfPAxL/IFMTGlxH2jlqUvhVWmAyQ==
X-Google-Smtp-Source: AGHT+IHwjvFMD09mc1fPeleuYVXYXabipc5ZLNdrDvI6dnHWUn5JF4kQcYHOtbu6UZLIJLMqt7aL1w==
X-Received: by 2002:a05:6871:3233:b0:21f:9c60:dba8 with SMTP id mo51-20020a056871323300b0021f9c60dba8mr1759870oac.4.1714727914874;
        Fri, 03 May 2024 02:18:34 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:dc60:24a3:e365:f27c])
        by smtp.gmail.com with ESMTPSA id j6-20020aa78d06000000b006ecec1f4b08sm2621938pfe.118.2024.05.03.02.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 02:18:34 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Minchan Kim <minchan@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH 00/14] zram: convert to custom comp API and allow algorithms configuration
Date: Fri,  3 May 2024 18:17:25 +0900
Message-ID: <20240503091823.3616962-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	This patch set moves zram from crypto API to a custom compression
API which allows us to tune and configure compression algorithms,
something that crypto API, unfortunately, doesn't support. Basically,
this seroes brings back the bits of comp "backend" code that we had
many years ago. This means that if we want zram to support new
compression algorithms we need to implement corresponding backends.

	Currently, zram supports a pretty decent number of comp backends:
lzo, lzorle, lz4, lz4hc, deflate, zstd

	At this point we handle 2 parameters: a compression level and
a pre-trained compression dictionary. Which seems like a good enough
start. The list will be extended in the future.

Examples:

- changes default compression level
	echo "algo=zstd level=11" > /sys/block/zram0/comp_algorithm

- passes path to a pre-trained dictionary
	echo "algo=zstd dict=/etc/dictionary" > /sys/block/zram0/comp_algorithm

TEST
====

using default zstd
/sys/block/zram0/mm_stat
1750315008 504602831 514256896        0 514256896        1        0    34204    34204

using zstd level=7 dict=/etc/dictionary
/sys/block/zram0/mm_stat
1750310912 432540606 441712640        0 441712640        1        0    34187    34187

Sergey Senozhatsky (14):
  zram: move from crypto API to custom comp backends API
  zram: add lzo and lzorle compression backends support
  zram: add lz4 compression backend support
  zram: add lz4hc compression backend support
  zram: add zstd compression backend support
  zram: pass estimated src size hint to zstd
  zram: add zlib compression backend support
  zram: check that backends array has at least one backend
  zram: introduce zcomp_config structure
  zram: extend comp_algorithm attr write handling
  zram: support compression level comp config
  zram: add support for dict comp config
  zram: add dictionary support to zstd backend
  Documentation/zram: add documentation for algorithm parameters

 Documentation/admin-guide/blockdev/zram.rst |  38 ++++-
 drivers/block/zram/Kconfig                  |  69 ++++++--
 drivers/block/zram/Makefile                 |   7 +
 drivers/block/zram/backend_deflate.c        | 133 +++++++++++++++
 drivers/block/zram/backend_deflate.h        |  10 ++
 drivers/block/zram/backend_lz4.c            |  47 ++++++
 drivers/block/zram/backend_lz4.h            |  10 ++
 drivers/block/zram/backend_lz4hc.c          |  74 +++++++++
 drivers/block/zram/backend_lz4hc.h          |  10 ++
 drivers/block/zram/backend_lzo.c            |  44 +++++
 drivers/block/zram/backend_lzo.h            |  10 ++
 drivers/block/zram/backend_lzorle.c         |  44 +++++
 drivers/block/zram/backend_lzorle.h         |  10 ++
 drivers/block/zram/backend_zstd.c           | 174 ++++++++++++++++++++
 drivers/block/zram/backend_zstd.h           |  10 ++
 drivers/block/zram/zcomp.c                  | 145 ++++++++--------
 drivers/block/zram/zcomp.h                  |  38 ++++-
 drivers/block/zram/zram_drv.c               | 110 ++++++++++++-
 drivers/block/zram/zram_drv.h               |   1 +
 19 files changed, 870 insertions(+), 114 deletions(-)
 create mode 100644 drivers/block/zram/backend_deflate.c
 create mode 100644 drivers/block/zram/backend_deflate.h
 create mode 100644 drivers/block/zram/backend_lz4.c
 create mode 100644 drivers/block/zram/backend_lz4.h
 create mode 100644 drivers/block/zram/backend_lz4hc.c
 create mode 100644 drivers/block/zram/backend_lz4hc.h
 create mode 100644 drivers/block/zram/backend_lzo.c
 create mode 100644 drivers/block/zram/backend_lzo.h
 create mode 100644 drivers/block/zram/backend_lzorle.c
 create mode 100644 drivers/block/zram/backend_lzorle.h
 create mode 100644 drivers/block/zram/backend_zstd.c
 create mode 100644 drivers/block/zram/backend_zstd.h

-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


