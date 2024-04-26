Return-Path: <linux-kernel+bounces-160004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6277E8B378F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EFCB28368D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35167146D42;
	Fri, 26 Apr 2024 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOeSJ8+e"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4669F13E88A;
	Fri, 26 Apr 2024 12:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714136166; cv=none; b=EhAgJwsvSBxop5XDL+rRlhFvRhj+/D3lAqF83X0Yu6ofI4KGepzhBdRiWuybqS3f95gCFpne03EFVh/imRChRgG7AuwOAXjAPfpMI6Wl0+cHhszsGAD4qXf10d4dppByueRBJ/1EDhCPr6x8/Gk7EjoZ3CAqzINe2BjJPIgsmIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714136166; c=relaxed/simple;
	bh=e24+6ar6f8THt7ttNJUQUkzg2x4kPeF6cikcX2osWII=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JiuZRtyEozYtYL+gOeiNGV9VR8KAOnjP/AuRPwmzL90BZLk5k+D894H4nus9nQMsdmNCl+4V7vgC93/4IlRMBogMJ0xs/QxeEHDUwbpf1hyc0+WsJccVgm9MY/ymHeVOcuIQdFISpdKWkghCDTgnsbSu+cpJBgSPILIQq97T/NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DOeSJ8+e; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2a2cced7482so530365a91.0;
        Fri, 26 Apr 2024 05:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714136164; x=1714740964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uX907XxOordYUAxSgHq5czawxQqlBIx+KQKIi98LRxg=;
        b=DOeSJ8+e7SXLs4lo/wbLr559mHAernnZG+rjgw4C+wgyrJPHu44UefVq58fspoCQp+
         Y0rk3lovEDh1LJvfhI2/Cz55uSo/BEtMPMaxmfv0WCHsQauL/CuI3C7wXgSAoibwBFXk
         PmU9qs29v9143Z3zYSJu0slR+fm0yRxBLWQYtYVGvBav6BRUaIcZLPXP/nuKvZUQODVw
         R7Mnbl5jhow6KdFaUbfboeIMQ77aQSSEXdLbNWAuquL4J8NIhUna67G3d2TO3cmfnnhd
         v5lOJPiMgMol3BIOyTGPrY4At2EkK5HLIE8X0ox3Z0ykmDJe/pKscGkpPsvtYxKoSbCA
         qLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714136164; x=1714740964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uX907XxOordYUAxSgHq5czawxQqlBIx+KQKIi98LRxg=;
        b=PjVENzGW1jEb4ENi6M67LISsI2VuW8cQ7fhHDCsmQcReneXd+/+1ohdF20A4Z7zbac
         WQ57rhr5WfzyGPIQHxuxH4Xzo2c1eG/SpmlYYvOJgtqTpU9/QpJsEqEY3GWCdmHwij52
         TRkd+B7Jw+JMTbwRYmc+T+P+wzspGM8CLeH7qS10iC2uA9z9Yuc2e3ymDO86+Sjz/yly
         mjKaICFIRxsIiWLnmEKFdAB+XISAnaCFye2cZr4Xdr8J6G9UsCWl/H6YcW7nvzYt4IGl
         MrSuhA1IhN9ikn2XjSuCfnk8kbh/VlYRigp3/Rz7ueAgfXCFtSFF0eaFMjAjakZiZLXc
         czgg==
X-Forwarded-Encrypted: i=1; AJvYcCW/YPfohe7wnpdmkOf955UQaQVdZC75bH9NaP5M7/OMjmqgGf5o4WUgw++ftt3xOvKSAltkr9vR9TXTjXiz2OgCWLE2oWMcMGNzcfF6
X-Gm-Message-State: AOJu0YydklYcK/xTVlggXspw2HFadSz0x3oDFkBv88/vY0W/HDaV90lk
	iQT/OBfu+BvotoNc2YVa8evXXnTo5howtYtDarDOB1IjXVgs/I+AQK2PY2XG
X-Google-Smtp-Source: AGHT+IEk3bPUEuIWOFK/L2xF1SwAh2qRi9ToB9DKYF51AccL8jUZkrbygWE4ULy0YFXns7FHJDPz0w==
X-Received: by 2002:a17:90b:30d7:b0:2a7:aa52:5568 with SMTP id hi23-20020a17090b30d700b002a7aa525568mr2531461pjb.0.1714136164442;
        Fri, 26 Apr 2024 05:56:04 -0700 (PDT)
Received: from vaxr-BM6660-BM6360.. ([2001:288:7001:2703:751f:9418:61f4:229e])
        by smtp.gmail.com with ESMTPSA id o16-20020a17090aac1000b002a27132ac02sm14485568pjq.2.2024.04.26.05.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 05:56:03 -0700 (PDT)
From: I Hsin Cheng <richard120310@gmail.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [PATCH] wireless: Fix typo mechanimsm to mechanism
Date: Fri, 26 Apr 2024 20:55:40 +0800
Message-Id: <20240426125540.14084-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed a typo in the comment description from "mechanimsm" to
"mechanism".

Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
---
 include/uapi/linux/wireless.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/wireless.h b/include/uapi/linux/wireless.h
index 3c2ad5fae..b0d911f20 100644
--- a/include/uapi/linux/wireless.h
+++ b/include/uapi/linux/wireless.h
@@ -27,7 +27,7 @@
  * better than command line options of insmod because we may want to
  * change dynamically (while the driver is running) some parameters.
  *
- * The ioctl mechanimsm are copied from standard devices ioctl.
+ * The ioctl mechanism are copied from standard devices ioctl.
  * We have the list of command plus a structure descibing the
  * data exchanged...
  * Note that to add these ioctl, I was obliged to modify :
-- 
2.34.1


