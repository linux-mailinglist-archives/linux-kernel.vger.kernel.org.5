Return-Path: <linux-kernel+bounces-56046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E8D84C548
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01D401F27599
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792801F5F0;
	Wed,  7 Feb 2024 06:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MfeQX4J+"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4B41CD30
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 06:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707289083; cv=none; b=LDbPI15X4U7FWmYah5814TpQUohd+0owptfEbzE90TK2a12IVPf7047DEkPkrdJj2foP+FMJF83ArEWtqTnsmefYHbTZdOhWFu84KovZ10P2D2A9h2mmVPKUbHtMDL+aNbUhsDDziWYakZ6Ssg+Ww3DySr42I3V/dInuWTX0y0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707289083; c=relaxed/simple;
	bh=rCZ9HSGtLLD4caLOi+C1H8AptWnr7xurWcFkoFTjU1w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eJrJEbpwnw+4jLzqX9eUbLg+wmXGOaGencEUm5aijNTUfoTBMyfI5mZr7ihdsuvQHBM478N6IF7VvVzy5icmvi/H2hLgPaQg7NRhgPdL6jrpoSgAGq3BQoskmyn2zy7/xjaQVcnU0pkZjtRhiOP/LwIqWGt3t+72RIbNz8bSH4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MfeQX4J+; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc730e5d88cso213745276.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 22:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707289080; x=1707893880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Tjfy54B6+Jm7MlmeoV5+p4SaY3yr3KlOWnWh/R3pw/Q=;
        b=MfeQX4J+50Q+ag2o5vzzyEtnDwVDIINPiKv4QiLy11lxUI83QtjeWW1+AMOA6jN4r0
         jsSgFnJsuh1RtTwjsR7mIcesGHpSIqnT7Nmkrmsaf+HB+nsrIxuow1vT0mPU96zkyN8Z
         w6azVL2BzPEHxB28B4dWbKXPgWUMiMSjQXg/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707289080; x=1707893880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tjfy54B6+Jm7MlmeoV5+p4SaY3yr3KlOWnWh/R3pw/Q=;
        b=OJMqUL4Ri9WvqUZN3EzUi64kSOswGtwYEh1FzexEdOMNyUtc6XGTs87JEWKO1sc4o4
         +XlTR87nYKnJ6VsJM9Z7vW2ygqYausH4w+RfAO/D8eWoOyMAgMGOyaOK5qtUFYlgqyfL
         ONV3ZJO9EVjID6yYxU+4dLpvJeGwFDVLSwQv8gsr8rrqz3JOpBdoUCKt+q2dF5yfZdz5
         xNoWgclTKHCoHMOGnhhJEPM0QVI2JSuf+aUrmNwuF7wu69K+XA6rRefG1YkLxlcmfQAU
         yyQfsdcFX6Cd8UH4/8ypI+GDuiAfTge9uJKy2YnIVY7RdMqeMQHRu7ShMsIpUfP8zrI+
         qaOg==
X-Gm-Message-State: AOJu0YwMZ9xme2QGBa2A7uWwvC9rl6IaMmUWDeV/stPtnRT6n85gz1w5
	EJ9h9WJnRZaVYOqXhQTaWfzv78vf/fmVKxf9Z1zWPKRq6P/ol/nlpbsRTXilTA==
X-Google-Smtp-Source: AGHT+IHYzKqvu7XWwdPK9IPIQeA91PTLPU/0wlPyf2K/JsBCamw5GLYRhxdxFWHdSc6dKa3lYE3i8w==
X-Received: by 2002:a05:6902:1a45:b0:dc6:b8f5:50ae with SMTP id cy5-20020a0569021a4500b00dc6b8f550aemr4421214ybb.32.1707289079959;
        Tue, 06 Feb 2024 22:57:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW0zpFxQmjQG8MCNugXs8T9eOKOGkwr3Fe3UTCLKl3sSP4+a0vNh1XuKHHW5agD9D1LTYrg91AHdng2rpQiRJrzXdZtQgTITvaLSFetHFjk3/ZfKxeHMU5IowymtMTkelrCsGTsxATuh03xQ8S6SsQA/3oGqqy8hL92FGaz0Ubl0zw=
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:aa4c:2868:935:7ac6])
        by smtp.gmail.com with ESMTPSA id jw15-20020a056a00928f00b006e03ac84d53sm672576pfb.193.2024.02.06.22.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 22:57:59 -0800 (PST)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [RFC][PATCH 0/2] zram: decouple comp stream and comp buffer
Date: Wed,  7 Feb 2024 15:57:10 +0900
Message-ID: <20240207065751.1908939-1-senozhatsky@chromium.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	RFC

	We keep compression work memory buffer per-comp stream (which
is per-CPU), but we don't need that many buffers, because on each
CPU only one compression backend can access work memory at any given
time. Hence the patch series moves compression work memory to a
dedicated per-CPU area, reducing the amount of memory we allocate
for those buffers.

For instance, assume a 12 CPUs system, 2 compression streams
per-CPU (a default and one for deferred recompression). Before
we'd allocate 12 * 2 * 2 pages, after we'll allocate 12 * 2 pages.

NOTE:
The series stops short of moving comp buffers to a global per-CPU
area, which all zram devices can share. Compression backends use
CPUs exclusively (disable migration and CPU hotplug), so in theory
comp work memory can be in global per-CPU data. This can reduce
memory usage on systems that init numerous zram devices.
E.g. instead of num-zram-devices * num-cpus buffers we'll allocate
only num-cpus buffers.

Sergey Senozhatsky (2):
  zram: do not allocate buffer if crypto comp allocation failed
  zram: move comp buffer to a dedicate per-CPU area

 drivers/block/zram/zcomp.c    | 118 +++++++++++++++++++++++++++++-----
 drivers/block/zram/zcomp.h    |  24 +++++--
 drivers/block/zram/zram_drv.c |  32 +++++++--
 drivers/block/zram/zram_drv.h |   1 +
 include/linux/cpuhotplug.h    |   1 +
 5 files changed, 151 insertions(+), 25 deletions(-)

-- 
2.43.0.594.gd9cf4e227d-goog


