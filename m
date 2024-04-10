Return-Path: <linux-kernel+bounces-138481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F7089F1F5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA0841C217E6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D84F15B15A;
	Wed, 10 Apr 2024 12:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KXD8jncI"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5548515959F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 12:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712751881; cv=none; b=jefRudjre2+V2HQE97Hl7h6YZszYGvL4Qx3aTUyBqt/8GMPiDQgKqIo0pF6w0+yFE7TjKOE4YeYZXY8REVEKQ1rxl3Pf0oFcGkYZPmtXlmaAb0DJDUpXe2QRBTITE2woQJxoQLaLPycPwug4d7D1FekfQeubxjs4n5PulyON/Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712751881; c=relaxed/simple;
	bh=1pJNgHja5lINwwCyP7IMrT5P1uTkgu8caHFcfR0b+eI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FYUBW+J65SjqvPM3qEsFXSWAptFqXGVFhwvxzx4MH4aY8CEHUO7bmXtnEu/2Z+KWcsenjKUpM3mZOaX7nKbmdZ+BSqSbF3k9aGp061hL0c/14jGKdf2qP6/i+q7dAb/PqM3+nq5OktWhKcFlBu2V9CXRL3i4G6Y50K6dtWRS074=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=KXD8jncI; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dcc80d6004bso6698111276.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 05:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712751879; x=1713356679; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e1+CFsAZcxsXAsqWL11G58KQqX/CKeYd932ouf9LqRw=;
        b=KXD8jncI/3XJV4PxdjplDy/Xed3t4+H/znLLSCf1GH4BGdxhpqv688NpvZgVlH38PV
         ks4VvsWpMdGHPt92RRZMlRolody//7cpo1lIq1KubaUMlr/wUoIwrZ+syBzj7Jt/Cwz0
         z5JGy2iGsmgREua0N+BAOfefJJzZTz28jWT3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712751879; x=1713356679;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e1+CFsAZcxsXAsqWL11G58KQqX/CKeYd932ouf9LqRw=;
        b=ThYapsz2Gjq3PmgVaAz3RYVbEsSALCfQ/K/tPUmn8zLazgNcii8tUOhaP+ND9ahrWq
         o08QYvc7yhlonv0E5C8m4MLtjFlWqjC4g1sxADzs09j6MFJhy3reUcfJNaCD5DHyurmf
         Y3znUZIUPpeH9SBt5xqjXUibn7RiI1rLarG5+z/KBJjhBHMBs62O9EEUOthT7UskNmDY
         nwW7iYeLsJgj/fiphVF4vKYIxNHAvDlTtVMbOkS/XmtXeURSr7beLrvBeUuPkbeVuAFr
         LQvK4JTfc9yT05k26M0K8y9RTTH6CvjwNoVnMx/bB7ASj1IU/Hu2pFFV5CDQz5xF2iV6
         1qZw==
X-Forwarded-Encrypted: i=1; AJvYcCUzJKaPwPCEozC+S7D0axBX+C2gNzjq5R2bhanIkdsdpismKDemvqpf5pbc0TbqIA0pFw8Uqah7VOZqP+Lqo95VBvwZIPBKZ/YDIFlS
X-Gm-Message-State: AOJu0YzHgzfpbVMltk9BoPJehuy8okSUuAV+d8bKcDvpsflhZtMafXB5
	u28J7tPSsCwWzzE46iqReyrvH+wkeEGLqOMAxIISoZ5JACFtt0AyygxJQJ+9gA==
X-Google-Smtp-Source: AGHT+IGvW8CkuVTktKKdjqs+rbBISn9XmK8a9ITx0Plcjoh/1m4SUh13KgaX8czR0naFY6oxRsKJlw==
X-Received: by 2002:a25:60c2:0:b0:dc7:4ad4:c977 with SMTP id u185-20020a2560c2000000b00dc74ad4c977mr1293698ybb.25.1712751879270;
        Wed, 10 Apr 2024 05:24:39 -0700 (PDT)
Received: from denia.c.googlers.com (188.173.86.34.bc.googleusercontent.com. [34.86.173.188])
        by smtp.gmail.com with ESMTPSA id jy14-20020a05622a818e00b00434ce53c664sm1921579qtb.80.2024.04.10.05.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 05:24:38 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 0/3] media: Fix missing warnings for llvm am32
Date: Wed, 10 Apr 2024 12:24:36 +0000
Message-Id: <20240410-pack-v1-0-70f287dd8a66@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAWFFmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDE0MD3YLE5GzdVHNDy+SUtESDRLM0JaDSgqLUtMwKsDHRsbW1AJtUSA5
 WAAAA
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.12.4

When we were building the project with llvm for arm32 a number of
warnings where shown.

This is passing the ABI check:
https://gitlab.freedesktop.org/linux-media/media-staging/-/jobs/57432144

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Ricardo Ribalda (3):
      media: dvb: as102-fe: Fix as10x_register_addr packing
      media: dvb: Fix dtvs_stats packing.
      media: videodev2: Fix v4l2_ext-control packing.

 drivers/media/dvb-frontends/as102_fe_types.h | 2 +-
 include/uapi/linux/dvb/frontend.h            | 2 +-
 include/uapi/linux/videodev2.h               | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)
---
base-commit: d8c9a6e204f1466d228428174ce6d40ccdfb583e
change-id: 20240410-pack-e719cdfa0a6f

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


