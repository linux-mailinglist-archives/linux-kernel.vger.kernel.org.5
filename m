Return-Path: <linux-kernel+bounces-156604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 963EA8B057C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54B0028CFFA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7237158DC6;
	Wed, 24 Apr 2024 09:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNcaRKTs"
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC962561B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 09:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713949613; cv=none; b=HmyifzcyQPJTYCt8J5cGFwwyWROGJI2ZfWq1AnINjtbkWFH6VbeWDEn5CSm7mxeHQtrAqbNHWbM/kWSmkPmX5j99c65Oh2YtnFjnE60ZfMLkeq4Ifk3PV91KQ0nUw2ti26rod+wvIuc7jURqeUjO2EMVpHRYeHrezeMtaTVsnFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713949613; c=relaxed/simple;
	bh=PIWDBeJBTJ8nI6deAO9S/CefLEHkMF1CEvSU9ILhtCU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f2AWqgSx84ffTcRR2Io7CoaaTsXp8ZLVRXLqpvow3qMDzgWEaNqqkUnQFc83V7l4qyyMr6+ID6p7Bp2ZvxBG7PqhTwf7coKziB25ZP7ShuXZ9bCUC4Xa8MZHx8dqnoFVV0X0uu5iMoOS9DMu4U60a2+MQY/0xcEW71+W+0GjceA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNcaRKTs; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-6ed04c91c46so6434536b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 02:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713949611; x=1714554411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5/BejucCQJg/1a61zK573V93gjIoiZEwubJ52BTIMU0=;
        b=XNcaRKTsXJ8hfjN814Caekn/Mzrp4pNDe6t/gjh0UoIMmjr5b6wxTlFyG+ZH5RbD+5
         UVXqmXSy/HPP1SCS+6XnI9nEWr9ynfpwRbaRnmY4TH92MAbkovXUrTh5ob8EQlT4XAei
         VW+biCuWOAhEpXuDvUEIsx/n760uTOKq6dUZxKv/4cyQIuzheiaJB4OY889WOaGtuLKd
         HJZb0vzFWwuEutT51HHlI3K+oBSzjP+Zzj09LR63dezXmuwHF6wQMLjqkaIRTZnvNbne
         Wa5gFi9knBa/5O6yVNDmgC39EiHgQsfC64hueL5D1k/PpmchT0Qv6Hf+F/xwGU1lzzU6
         vWEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713949611; x=1714554411;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5/BejucCQJg/1a61zK573V93gjIoiZEwubJ52BTIMU0=;
        b=gNNFndt5YoSR/nGtX4zD+bqV7HWHOW1Pmj2OZCu9HAkgGZf86hxOwsZaTMRefU6/u1
         3TygnWmiiUmXwRRp+KzcLYXARSJkfs2t/rBt3uSRY9cdS+xk/kEqDLnztbpfRLZ+T7XV
         R5jK0oEnqU1iI4ysKduTdXqRSEoZwuJAqEhElvKLGyF/mHGpKvGn75A0kvb+EzMvFgBS
         +NnDFj6/4px8kRrUxPhch4w9ABpW70ySKa/qrxN7IPkg5BOXw0QvuOIpok0+J8P+549y
         J18y7pnUoT7QTg9Tcrb6mt4dwz4hRnKnxhZqd6apsjKdrsxgwdjEGPVvWPiK9HLhsZNj
         0rTA==
X-Forwarded-Encrypted: i=1; AJvYcCWp3StpO8g+/mcRG9GGn4mxUBTC527AKejl6M7VSMo1fMHOatnCW6JfO2T/e0HqOkH1r4wsFcM0SDfggF8Xc6v/TvFGXAzXNG3FBiaY
X-Gm-Message-State: AOJu0YySxcWO4M4u9Vnm+Qel7eb9XhDSxY7EVovIRjLbIYwXvGhfKER1
	0jnJuARgyoD53RAzrskBWkuTh2bdPsk8zTI3dZ/uhDRwObKWATaC2Iz0pQJj3r2Wvg==
X-Google-Smtp-Source: AGHT+IFKRzyx9snJqmoMOtX6aAXFm0HExvHrUY7JVErkB9slUDmbicNo+zAy+Vth61McqB3ocB3b5w==
X-Received: by 2002:a05:6a20:7faa:b0:1a9:3cf2:508d with SMTP id d42-20020a056a207faa00b001a93cf2508dmr2047738pzj.38.1713949611015;
        Wed, 24 Apr 2024 02:06:51 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.33])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902e5c200b001e556734814sm11408569plf.134.2024.04.24.02.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 02:06:50 -0700 (PDT)
From: Xinghui Li <korantwork@gmail.com>
X-Google-Original-From: Xinghui Li <korantli@tencent.com>
To: airlied@redhat.com,
	kraxel@redhat.com,
	wander@redhat.com
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Xinghui Li <korantli@tencent.com>
Subject: [PATCH] drm/qxl: fix comment typo
Date: Wed, 24 Apr 2024 17:06:13 +0800
Message-Id: <20240424090613.2630952-1-korantli@tencent.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There is one typo in drivers/gpu/drm/qxl/qxl_gem.c's comment, which
'acess' should be 'access'. So fix it.

Signed-off-by: Xinghui Li <korantli@tencent.com>
---
 drivers/gpu/drm/qxl/qxl_gem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_gem.c b/drivers/gpu/drm/qxl/qxl_gem.c
index fc5e3763c359..2cfe29d72d81 100644
--- a/drivers/gpu/drm/qxl/qxl_gem.c
+++ b/drivers/gpu/drm/qxl/qxl_gem.c
@@ -74,7 +74,7 @@ int qxl_gem_object_create(struct qxl_device *qdev, int size,
 
 /*
  * If the caller passed a valid gobj pointer, it is responsible to call
- * drm_gem_object_put() when it no longer needs to acess the object.
+ * drm_gem_object_put() when it no longer needs to access the object.
  *
  * If gobj is NULL, it is handled internally.
  */
-- 
2.39.3


