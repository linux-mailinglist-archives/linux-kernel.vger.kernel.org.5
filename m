Return-Path: <linux-kernel+bounces-167063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5B98BA3FC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C7941F23B79
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DE9320322;
	Thu,  2 May 2024 23:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FdUxQH/N"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E58C18EB0
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 23:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714692730; cv=none; b=tfrUEYHI5jI3LOX50oryz2onV2w4DTEN7JLNACeVcsW06v0H9M0pRkpeRyETQWXt3NpWG1tHBa+Sjarv7Gw9oFIvjJXAKYuyda71QxwlAc9+Oru2FqE/JPjxdLxwg4Pl88GbhM3SdMZyndqAX9BMMqJHDusr0+uKJTq9Gp3MUwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714692730; c=relaxed/simple;
	bh=loR6EKvTvBYiaJvjleAGgIbbG8CtNxBlIHenP8meYtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F5C0BvAaD0juXal6GAzhMiP30phOHjwWe3jNa4OaA2vZLNNm8ZBic9FdEgA+LAUOgfF72uk/QTt0MJMxKYX+mTID8N7VtxpIeHyXNDKDvosfFxOqDJIm6sy89CzEcaaQGoBmoQTYtCxvWj8gGEJwOqbWWT2IViSTOzPZvNOBylM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FdUxQH/N; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-61b62005f38so87658717b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 16:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714692728; x=1715297528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=El+PWm8m+MU5+4IcrF+uOdAedQHo6CzIZgWen1Cp26E=;
        b=FdUxQH/NLDU1hjhW9HmCAg2Qu9QX8H1YJRFn04g4bZK16kymzw+MVeltKFGg8KQ7mG
         Cf1ZoGl23Uml+znY8GV9toru+m/uUcsmmcS2gniCojjT2Y7zUVReptW6JGktVIhVljsr
         98/go1acR3f2EDoqOi+wtCsJKgmrZL7meddi+IFD4jg2Q/nj3SIqTX1Sr8ftIZzSoKPK
         9RaUN9KsRzv+l9pQD3UCFPzmU7hIkFypzp04bepVw36Cl5Uqw6Kv1+2CFBjYKuaAmSBI
         omN98IY2Ifa9RAZhdKLIUoY83qEXsMH5EBBovZigXZgZIQJAcAQy0ZXsQ2YOfMnak3Qt
         KSHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714692728; x=1715297528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=El+PWm8m+MU5+4IcrF+uOdAedQHo6CzIZgWen1Cp26E=;
        b=b8+JcSH5CLtqaW9CQRSBy+kOK3vEdtxQBfTIw6v3Dv+HvRGLQkQJnAA1ysXru4vvo8
         JJ/am/1Nu0fjQWIpMGTrEW1IKf8s3FY2QHkdacc1qDpReksSg3VBttPz7exOjWDvDXtN
         5mWFZKLC/IwlpN9bgo25n4cGpXT++P6iR88Yw+XH0jT1nIaM6+0CLe5ZQs2JRvVcYyh9
         SYpeblUg9eG6bd/riHWJ2sswDxbSoSv/85qiN9UsEgAVa6zx1Mn7VurWHyqKKv3edD8u
         aRV1DaOZ19d+DgHyxafEyJqLUH6Cy3gjrK96+ydygnn8nEjyyl6knebo8XD+tg1gTHnE
         PLMw==
X-Gm-Message-State: AOJu0YwjB0DcuRfu8+yUoACqkG8i/BlZp4DY4Pcu3ezEwdbC8r4uXgcS
	BZ6cTTCt75NFUfjCmyp5lAZXUkDy4KkdrmgS20vqcG4WeIlgX/MowFmSZA==
X-Google-Smtp-Source: AGHT+IHZRulI3dRGOD1Y1ml+pKuQRBc5bzggbcUhHKWH4uED52YAaan0vWVRgg28UrKMB+H2wkJv8Q==
X-Received: by 2002:a0d:dd44:0:b0:61a:cde6:6542 with SMTP id g65-20020a0ddd44000000b0061acde66542mr1063713ywe.16.1714692728091;
        Thu, 02 May 2024 16:32:08 -0700 (PDT)
Received: from localhost ([69.73.66.55])
        by smtp.gmail.com with ESMTPSA id r6-20020a814406000000b006186a9d32b0sm424392ywa.43.2024.05.02.16.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 16:32:07 -0700 (PDT)
From: Yury Norov <yury.norov@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kuan-Wei Chiu <visitorckw@gmail.com>
Subject: [PATCH 0/4] bitops: optimize fns() for more
Date: Thu,  2 May 2024 16:32:00 -0700
Message-Id: <20240502233204.2255158-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series follows up [1].

[1] improves performance by switching from __ffs() + __clear_bit()
in fns() to the equivalent but much faster expression that searches
and clears first N-1 bits:

	while (word && n--)
		word &= word - 1;

We can squeeze out of fns() even more by replacing linear walk over all
the bits in a word with a binary search.

Patch #3 implements it by adding fns8(), fns16(), fns32() and fns64(), 
and patches 1 and 2 are cleanups related to fns().

The last patch creates a MAINTAINERS record for bitops. Currently they
aren't maintained. I add Rasmus and myself as a reviewer and maintainer,
accordingly, just like for bitmaps. Rasmus, please let me know if you
don't want to review it.

[1] https://lore.kernel.org/linux-kernel/20240502092443.6845-2-visitorckw@gmail.com/T/

Yury Norov (4):
  lib: make test_bitops compilable into the kernel image
  bitmap: relax find_nth_bit() limitation on return value
  bitops: squeeze even more out of fns()
  MAINTAINERS: add BITOPS API record

 MAINTAINERS            | 13 +++++++++++++
 include/linux/bitops.h | 42 +++++++++++++++++++++++++++++++++++++-----
 include/linux/find.h   |  2 +-
 lib/Kconfig.debug      |  1 -
 lib/find_bit.c         |  2 +-
 lib/test_bitmap.c      |  4 ++--
 6 files changed, 54 insertions(+), 10 deletions(-)

-- 
2.40.1


