Return-Path: <linux-kernel+bounces-47100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8A3844922
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A0AD28255F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5612C383A4;
	Wed, 31 Jan 2024 20:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fOo7CxMr"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A7038382
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 20:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706734036; cv=none; b=PPB1zjY20bT1JL/a6mxEoDk25BopTl37H5F73NTUPqtdRz1gJM3nZg21AwufD4cdo5IFfSniEcRmEZEsKioVzamL93+MsEBhiPjw5QFlrjCO4mQg+IqrNdWdsJQe6G7eE/i2xSWtpnY/ReDmFKmdqJm7DvgqDcp5M13GXj5/hdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706734036; c=relaxed/simple;
	bh=U5ubKWb5lmNwnTSRf1K63zeIXxhV8he9NKglHhX61pM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=l9aU59IgE92Wo4MxIIbb80eHzynUAdCPi8L9lVvhKY/jO6rN9CfEwixibBL8hDmMJ1IHvS0o3DJK/JA6VkOvwYw4sVZucHKTlQ3xtBdHA+17O4UI9TYrR+ZB6XViIYrgjJBygIFOct+7gRgMMzcDuJtuciHlPopAXllgvqL7x4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fOo7CxMr; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7853a9eb5daso12049585a.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 12:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706734034; x=1707338834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IHehOClwdwyT5hm1jstGhrGJBzJcQJ/fIMBxPcZfJIQ=;
        b=fOo7CxMr/3JbUbtfD/pGNfD65MJccHRHs5f277Kn0jnzxOUwRySgopxS7FprHfq559
         DiImO2y5Pb+6qCmTWfFXF+Z3mnuIBsOk09ZKTsOmkaNSdNVBD9mM9kdqcaUaDaZEOcFY
         G1NE4br91CXm+FT7CaHyR/4MfRjnEvFdMMhfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706734034; x=1707338834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IHehOClwdwyT5hm1jstGhrGJBzJcQJ/fIMBxPcZfJIQ=;
        b=lGS1RLZriQSTdhG2PaJ5q8gcVdVDahP9IqLrayzxv02qDJg3pIQthXGEgSyj9qMjde
         npli+nWwo9x5b4OFSN638g/CaY3iJGExUvFhgED65NefE10zA9dLhyimJ2YVeiq33Rht
         8rY0aBhWyyarGW6kluwUsGGW/eG6amzXB3hvYj76n8i1pXa5ID8o1ZzPQMVqKgpc1N3w
         FleV38FI0jPTvVMd/mr2HaoD75/fDxF27CRgKKrg+FrRcwJxHgUkSB9pJLp9fQytGYNb
         R6/NTvg5pR6GcVJWo3Z4whXqkWdgoMMX5z+PqY1Z1ZObAlzF4ojutExENixQGUDCrflj
         vBhw==
X-Gm-Message-State: AOJu0YxG6Viw6T74l6sX3TegT/Ez31S9NQ4PDDaHVKR0UDJ/Wp3mPhST
	DIpX3IEhV5+e6cGaU7uDBnCQSwTDGU/bdG9euoUkM1qB7F2AHNsOZjIICMpSLQ==
X-Google-Smtp-Source: AGHT+IGFl+yQTcSkjdkSZkj7+XvZs9cGGUHj14aKkZC+jmz3gUMJNsJYBd6YGetGBZWQKYm6fSYcbg==
X-Received: by 2002:a05:6214:d02:b0:686:2ff1:8de2 with SMTP id 2-20020a0562140d0200b006862ff18de2mr3086741qvh.41.1706734033777;
        Wed, 31 Jan 2024 12:47:13 -0800 (PST)
Received: from pazz.c.googlers.com.com (240.157.150.34.bc.googleusercontent.com. [34.150.157.240])
        by smtp.gmail.com with ESMTPSA id ow11-20020a0562143f8b00b0068c67a3647dsm1410352qvb.76.2024.01.31.12.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 12:47:13 -0800 (PST)
From: Paz Zcharya <pazz@chromium.org>
To: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Luca Coelho <luciano.coelho@intel.com>
Cc: Subrata Banik <subratabanik@google.com>,
	Manasi Navare <navaremanasi@chromium.org>,
	Drew Davenport <ddavenport@chromium.org>,
	Sean Paul <seanpaul@chromium.org>,
	Marcin Wojtas <mwojtas@chromium.org>,
	khaled.almahallawy@intel.com,
	intel-gfx@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Paz Zcharya <pazz@chromium.org>
Subject: [PATCH] drm/i915/display: Include debugfs.h in intel_display_debugfs_params.c
Date: Wed, 31 Jan 2024 20:46:54 +0000
Message-ID: <20240131204658.795278-1-pazz@chromium.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Commit 8015bee0bfec ("drm/i915/display: Add framework to add parameters
specific to display") added the file intel_display_debugfs_params.c,
which calls the functions "debugfs_create_{bool, ulong, str}" -- all of
which are defined in <linux/debugfs.h>. The missing inclusion of this
header file is breaking the ChromeOS build -- add an explicit include
to fix that.

Signed-off-by: Paz Zcharya <pazz@chromium.org>
---
 drivers/gpu/drm/i915/display/intel_display_debugfs_params.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/display/intel_display_debugfs_params.c b/drivers/gpu/drm/i915/display/intel_display_debugfs_params.c
index b7e68eb62452..f35718748555 100644
--- a/drivers/gpu/drm/i915/display/intel_display_debugfs_params.c
+++ b/drivers/gpu/drm/i915/display/intel_display_debugfs_params.c
@@ -3,6 +3,7 @@
  * Copyright © 2023 Intel Corporation
  */
 
+#include <linux/debugfs.h>
 #include <linux/kernel.h>
 
 #include <drm/drm_drv.h>
-- 
2.43.0.594.gd9cf4e227d-goog


