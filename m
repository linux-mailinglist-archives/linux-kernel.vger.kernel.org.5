Return-Path: <linux-kernel+bounces-75977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7F685F171
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:22:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EBF51C2175D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 06:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50FB17C68;
	Thu, 22 Feb 2024 06:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rvk8w2Hn"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4E0179B0;
	Thu, 22 Feb 2024 06:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708582951; cv=none; b=KtWqS5U+IP/c7czN8uuoZNkUtNWPSDIaexElFDKPo09b3mkHI3PXgpicoS4vwEYYn6hrJQJAwPI1/ZSrskfwIR6+Larg0nBX9eYQ7XOZ0F28tKjnr3Dz7tOa2OX9jyNwmu162IRbcrkUVEma8kbVLeIsq7kOmfs9OfOIKybS7FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708582951; c=relaxed/simple;
	bh=5zPWaGxuvPdH6xrIjwITcYmJ0FVhd7Z6bIq4IKyG7PE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cnnId2QMQvndmgoC8THA6ZVUYl2l65igwiXyosLNLhWykNo4592nmoWx6x42ms9izavOxT9hbw23wF41WEfNVSwZ1jod/hxuqzeN9TOS9Lj/XpPMQ7F1OSvZAZlvQBqMtypkf9uQ2tB2z98ciWEKnphOE53c/pILWGh+m1Wsb8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rvk8w2Hn; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512d8fe4fceso742391e87.3;
        Wed, 21 Feb 2024 22:22:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708582947; x=1709187747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H1a0uGmRwFxQVTjWSYQgbbb6IcpaIjDAJCmTdMKxd2U=;
        b=Rvk8w2HnIFjrbBMXkaEkvzoIrVxmH7ZSGc8KlcJFbYX7iDoinYipFj5kK7jb6vMT2n
         qg9yZ7gWb9nIZhhhpq9W8cR78CUh7gfbia9VtYaanlgrAVrxv02jpECEGLknsY54Txml
         Y+NzLpRLS5gSVe4IgpaN5hWkWkqUvRiLknGZ0n32fMWjPz+holHsprfFbEXswkzNslh8
         dCEUygFStfByWLrWkpEm53Ek3M/kF/sb0G05eRMYQdolVy/dH7R6CdyvMYQ0Mz3ORTxA
         Fn93Pq6gwNAPnsKKgQahLfL69i3FKkKARZ02z9ImG6dzmTocyDEMDKlDWKQAIdEQU5z/
         V/PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708582947; x=1709187747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H1a0uGmRwFxQVTjWSYQgbbb6IcpaIjDAJCmTdMKxd2U=;
        b=cFmLYrO4O71D/79vRNxr/eGCg94IySEQiF4XD/8G7VDunBNWqqVdkdoU3smW4BmxwJ
         ezzHCdxUytU432unUSd/DwVQV12hvEfV5WbgC7aGHBgE/PcPCB0pqEBY0DqUOJ7mp3Bk
         mJimUWp+9CL0nUd/QLql9ENos5wgdlDXZ81spkogYOBVdGDfj+R/SbTi2bVCsZuZOduf
         h4NR3MXVJ8FMnR52z+CiX7QOlOYsp+2ynzmCtQyp09x+gkt02EBgEqTUJcpdOf1xgndZ
         0DqdEUWJhR1MvLfZkH9wphusRWmiRJxMKCKAEfYvrqNpLwulCiDwU0gcTHxr/EeAv+Xg
         6djA==
X-Forwarded-Encrypted: i=1; AJvYcCXRz76WlX8zdSh18eNrMtAbBBI60t2Hbj76rXFO+5s0aHETC5c9TUsenJUNpBZhzhUQrmF9fjMEJVTXrBolY12cAdQSN8DbbP4bD9bhvyrPp0uM/lYaztd1MXUJVmf/BBBmbSJ2JX3pTEKuijwHxdvevwpXsw4v/blyXH4LuXBFlwzPGrhL
X-Gm-Message-State: AOJu0YwkhF9F0YDgZNGRaSkhfAsJeWzL2FZdLSiEOaVy5Zn4/+q9qNIG
	CQVVHXE0cBwo1RRk/17SzWM/k/KGt5jG52j+36/aCcwYR77IB9P0O/bvbXnD10c=
X-Google-Smtp-Source: AGHT+IHmITekBIGo1Rlou/oYfs2bRUkkZ2jcZqPTPIkfiZp3t0jE6XJABlWVB9Q1hAu5NOPQE6+8qQ==
X-Received: by 2002:a05:6512:318a:b0:512:cb0c:d984 with SMTP id i10-20020a056512318a00b00512cb0cd984mr5323554lfe.68.1708582947271;
        Wed, 21 Feb 2024 22:22:27 -0800 (PST)
Received: from localhost.localdomain ([2a05:3580:f312:6c02:29d4:49b1:c3dc:494c])
        by smtp.gmail.com with ESMTPSA id e8-20020a05651236c800b0051296788949sm1945574lfs.232.2024.02.21.22.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 22:22:23 -0800 (PST)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Pavel Machek <pavel@ucw.cz>,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH v2 0/2] media: gc2145: add basic dvp bus support
Date: Thu, 22 Feb 2024 09:22:12 +0300
Message-ID: <20240222062214.2627810-1-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Tested on PinePhone with libcamera-based GNOME screenshot.

Andrey Skvortsov (2):
  dt-bindings: media: i2c: add galaxycore,gc2145 DVP bus support
  media: gc2145: implement basic dvp bus support

v2:
 - bindings:
   - add required bus-type property
   - conditionally require link-frequency property based on bus-type
   - add DVP properties with their default values

 - driver:
  - fix fwnode parsing
  - remove gc2145_is_csi2
  - fix error message for unsupported bus-type

 .../bindings/media/i2c/galaxycore,gc2145.yaml |  64 ++++++++-
 drivers/media/i2c/gc2145.c                    | 122 ++++++++++++++----
 2 files changed, 159 insertions(+), 27 deletions(-)

-- 
2.43.0


