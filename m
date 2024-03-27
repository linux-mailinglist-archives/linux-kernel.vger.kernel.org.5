Return-Path: <linux-kernel+bounces-120373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A1E88D662
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 07:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38B7C1F2A300
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63D22576F;
	Wed, 27 Mar 2024 06:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NcoRQN7u"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FCA20B04
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 06:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711521122; cv=none; b=KsMXDDQ2WBqw7So0x9Rr7nrn9vk3C3U1vlB2sfazLDmmVNZn1qBWyVKq6cpabOJMLPdqBCfkjyEzwqOymlT6K/pzzIUO+/Po0N+dl7bAUObqq73ur4e8zVFvUceJlGoNP2RExPZIU1z7Q39slO6Q1bUtKqRpIarmfFmp2gZYNe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711521122; c=relaxed/simple;
	bh=KB5Kw8+VJDCNS6VTOkfW1rXx9Npz7y6cpQv6s8onYfE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZVyvty8C0y0vSa6/3syGg7KDp69Vqvlp7rqOuCFk0R8fw0i4+OUgqEqOjdKIxqRXIomF3G0ThRRlx3Dwy/h+00jPwtHagcACM1Rj5yh5i0H1PBEkwkdICY11DmNWKdJqOLrxuEEVdrf/a+mgo2rsU4wioXNU/bUji1MdtOCSJWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NcoRQN7u; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d68c6a4630so74354091fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 23:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711521119; x=1712125919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3T42PDe6POVUiD2RNtF/xYGMNPYox2/xgraOY1XEF7o=;
        b=NcoRQN7uXtn0ouZUTg737buG1fP1GgA+FBzHzlAyuvEPgK9axQHoZ3+prSRP/srcf9
         kE540ec+rL6F+lIp0FtG8Y5DChjBvyYL2szwuCNVAgBOH71hI7WerfiYAGuuxIPVPCsM
         euIK627Z9FO+eg0TkY+GK7S7GhIJPnxg0ZgtKyJBK7Ji07dW+oYGie+/lcDC66kGckys
         3W3Nyi31L1o/lc3ni3V3VPdqI4WhTdkEEDc8Er6sW1Y+WfpcSXFbnMK0QeSniWEpl370
         cKck6BZnkxWP9TRdwvPQXx3FCNHskyJuy/4O9mV9ie7mAsvG/Eun92SCL/1pJni86unD
         4uTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711521119; x=1712125919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3T42PDe6POVUiD2RNtF/xYGMNPYox2/xgraOY1XEF7o=;
        b=kxiutlOzB2P2v+RsOJpPwhJX6GckIeJFwxS311C03LBtiOuZTd9Y5IoOOux9H7VWzn
         g3yzes+MzoJ+LNuhYnDRGmW7mfnhj+p6BVKoe9PZEcQN9dqtwd1D7aW+a8D65GU1JAYT
         ju9pG+kRpew3HcnOCea5K3KCU1fqo9bpZynIQWfeGRpvVdCnJHQbr+1aIlSabB3zb7H8
         re7Kao0RiVRPLL1e5a0YPLb8SaSm1+nKhGmq1wT5NAsZDXUSANnJVC0u/Ornc/Z5GSYp
         Hmi9DNkqGPgX6vYPgKnyJwtXYXsvZdKS0OjQCz7cXaLcnjeRYW8s8qbKYx1p10vrdBMX
         Gm9g==
X-Forwarded-Encrypted: i=1; AJvYcCXE7i80FeT75c+3+vlgJxVfC3DK7kRFXRJUrHZXa8hC7a/p6kwqCU4TuEpJ70HWXnC84/Lgk+1XIq8SVW+J/RjaNd78l6Y0uPbl5NeS
X-Gm-Message-State: AOJu0YxKg8HuLZDI6d39rKcgWrk6GBgrcx10s5kV67cYWpvdeHcssZbc
	j0Q+zHJq1a5wREbVGt8aekBfAao/UbpWUTSxQ++wV+sRnbUdriNs
X-Google-Smtp-Source: AGHT+IGr3nZKGJe6ChxBKXfRHVU7yyiuKjO7popwkBfEPul66SPcOW8tWPzQYHx7bmDDWmovIsviKQ==
X-Received: by 2002:a2e:8455:0:b0:2d6:93c9:1f87 with SMTP id u21-20020a2e8455000000b002d693c91f87mr284404ljh.4.1711521119126;
        Tue, 26 Mar 2024 23:31:59 -0700 (PDT)
Received: from YOGA.local ([2a06:c701:736b:f200:f38a:32d3:e6f6:959])
        by smtp.gmail.com with ESMTPSA id u22-20020a05600c139600b004148d7b889asm1121360wmf.8.2024.03.26.23.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 23:31:58 -0700 (PDT)
From: Shahar Avidar <ikobh7@gmail.com>
To: gregkh@linuxfoundation.org,
	elder@linaro.org,
	andriy.shevchenko@linux.intel.com,
	robh@kernel.org,
	parthiban.veerasooran@microchip.com
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] staging: pi433: Fix includes, comments & macros.
Date: Wed, 27 Mar 2024 08:31:53 +0200
Message-Id: <20240327063156.96307-1-ikobh7@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset continues with some cleanups:

1. Untangle include hierarchy.
2. Delete a misleading comment.
3. Make use of general macro instead of magic number.

v2->v1:
Undo macro update. Remove its inaccurate comment instead.

Shahar Avidar (3):
  staging: pi433: Use headers in appropriate files.
  staging: pi433: Remove an inaccurate comment.
  staging: pi433: Make use of spi mode macro instead of magic number.

 drivers/staging/pi433/pi433_if.c | 5 +++--
 drivers/staging/pi433/rf69.c     | 1 +
 drivers/staging/pi433/rf69.h     | 1 -
 3 files changed, 4 insertions(+), 3 deletions(-)


base-commit: 26a73b4d30d29f572163f7399e39d56677607b55
-- 
2.34.1


