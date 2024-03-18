Return-Path: <linux-kernel+bounces-106238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F5B87EB3D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 480491C21239
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7540E4EB2F;
	Mon, 18 Mar 2024 14:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1YxgD98"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256E54EB20;
	Mon, 18 Mar 2024 14:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710772985; cv=none; b=jhpwEHsgKQo42oCxyCHbxZLqEYfIrepovHN2q4ZUZO3X00MZYcLbStrvMQ1GD0MDcr8oUcmTgzXq+DwCkeT7Fqfi3ssfEez3+qnn7YKYF0kJaTQoFDaeybyEo3GVSf7xMRasADB/CTILZYCuQPjns3kzh+WfT4kesC0Csx7ASjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710772985; c=relaxed/simple;
	bh=8XRZKFmhwG03J49V6ap/MmSlr5bTXR1c8ykaNN3EyUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tvN9soys/21a61RXPbNOSdZ5WusMnTQ+N4MhfpLo9gEGr5apc4Gt1jRxoU0hoL5sjJxMlpyxwI7/WxJXhJig6vYFzJGi2Om0wgFS1EHI9YPtXjDe5rTvkM/L+Ix1KObcHfPmNiLZN3tL/B3NxXsVyyWXDE3XOi8sKLR+dHmby4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1YxgD98; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d4886a1cb4so48812691fa.0;
        Mon, 18 Mar 2024 07:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710772982; x=1711377782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D+l8ZhyeqD/9OLSlImJx3OI1bct+f0EYpDd6giz/+Wg=;
        b=g1YxgD98CnRrob371nI16zno4BsJo1owCMffOSFp5nBWy1zWbNY6BpNN4PzMvs5KMp
         8onFnIwzJC2cm8XQHWcQQ04eH0bR+09k3GdrvEgRyi4ci7ZzMSyn1cqKjUiFQ2mmc69O
         sac5yy1ATXhdCnWoqSWpsg9GQfcFfZ+uEBMVJwYy1qt+PwIgQwfQtPtNnx66pcQY48YP
         tQ5/TmXwH33Z2DPRmKdHuRYAIzEDCkLkBq5ws14SKvaXIpnXbjg35EXGqqcMiRqJULv8
         XNSbOFy5L1Q/oFvXdEzsQUYy5Nt5+jSwo906Bh0p9MDb/DOkIAiBRzvKRiQ9St4nNdsg
         cSNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710772982; x=1711377782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D+l8ZhyeqD/9OLSlImJx3OI1bct+f0EYpDd6giz/+Wg=;
        b=nMukcXCNyfJkPqcDG37TN21nHgqOpx2p7V0M3BYRnt8BIVSYUPn7DM+hHNdrowsZrQ
         /lr5i2Tz+8pfzSnA0zusIaUOfnILUFEpb/mUM+BxRNdkumxUZ/GpBFxOcZuEX0rHAGXL
         qRAuXQgdXtFfLgkrvvPF86Znzp/y2N4lEn1fnSPkFJg0iZxeW+8H78cHfyDOD4c3Daei
         s/jJM9Vk2ab0c6q6wwn0TytaqugGWYtwYSisLIfaVynxpH5S3NjhzFp7cu8SRYWNC0zS
         vVS2tNEQ657eQM8ocTxVibl/29kHHCLURie5GVzuhyiulocy6zT+bh79A/uM4WumMDgt
         gwGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5DvPfbIDiK/il2shRiuE8w7lL7x/W7eRiH8W2wYB6IvFZxsh9xk9MYVpRU+0Hc8AtdEhWgSIO17zjPb3LwqhhVlejllm9U05BwjhHDBeBmaX699AYApNs8b3szawDik89Z8UMzerpxpN7iyQKw4NVYPS3TsCpuVWaIDH73LJDUHTOj38x
X-Gm-Message-State: AOJu0YyO3LR9kaX4PEX7dB6kmITrPAJjTsZ9zJa5fblwOxD9yVaBP3Da
	pFx3zlgeH1+IgMPsbvZ9LE4Lk6vVw2KOAnpBJvYBGI3rlKzK6HtW
X-Google-Smtp-Source: AGHT+IEeK7CDPkehkXCOgtE1aicKlzl25lZb5Aw/miJHV0DZu1X1wA8KDViLzWgcMud0pbrJtQjEFw==
X-Received: by 2002:a2e:9ccf:0:b0:2d4:49d2:a3d1 with SMTP id g15-20020a2e9ccf000000b002d449d2a3d1mr9002287ljj.1.1710772981978;
        Mon, 18 Mar 2024 07:43:01 -0700 (PDT)
Received: from localhost.localdomain ([178.70.43.28])
        by smtp.gmail.com with ESMTPSA id t9-20020a2e9c49000000b002d476327311sm1527486ljj.18.2024.03.18.07.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 07:43:01 -0700 (PDT)
From: Ivan Bornyakov <brnkv.i1@gmail.com>
To: Nas Chung <nas.chung@chipsnmedia.com>,
	Jackson Lee <jackson.lee@chipsnmedia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Ivan Bornyakov <brnkv.i1@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 0/6] Wave515 decoder IP support
Date: Mon, 18 Mar 2024 17:42:15 +0300
Message-ID: <20240318144225.30835-1-brnkv.i1@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initial support for Wave515 multi-decoder IP among other refinements.
This was tested on FPGA prototype, so wave5_dt_ids[] was not expanded.

Ivan Bornyakov (6):
  media: chips-media: wave5: support decoding higher bit-depth profiles
  media: chips-media: wave5: support reset lines
  dt-bindings: media: cnm,wave521c: drop resets restriction
  media: chips-media: wave5: separate irq setup routine
  media: chips-media: wave5: refine SRAM usage
  media: chips-media: wave5: support Wave515 decoder

 .../bindings/media/cnm,wave521c.yaml          |   3 +-
 .../platform/chips-media/wave5/wave5-helper.c |   3 -
 .../platform/chips-media/wave5/wave5-hw.c     | 293 +++++++++++++-----
 .../chips-media/wave5/wave5-regdefine.h       |   5 +
 .../platform/chips-media/wave5/wave5-vdi.c    |  27 +-
 .../chips-media/wave5/wave5-vpu-dec.c         |  17 +-
 .../chips-media/wave5/wave5-vpu-enc.c         |   2 -
 .../platform/chips-media/wave5/wave5-vpu.c    |  33 +-
 .../platform/chips-media/wave5/wave5-vpuapi.h |   3 +-
 .../chips-media/wave5/wave5-vpuconfig.h       |   9 +-
 .../media/platform/chips-media/wave5/wave5.h  |   1 +
 11 files changed, 272 insertions(+), 124 deletions(-)

-- 
2.44.0


