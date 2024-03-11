Return-Path: <linux-kernel+bounces-98870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4BCE87807F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B14280C85
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471504086C;
	Mon, 11 Mar 2024 13:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="Tg/qee/E"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4A33FB9D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 13:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710163404; cv=none; b=uirtHlMmIY2GBvJXBb9mNUd0qJbqvGUosdxVrdEBS9p0E6o+LcWDCkCXHmu/A96cqm5sMRDWvOkurFpeiTteQOQk0TtSpmxnOnmJTmpCXicKA+zXwjDqe0o72vsd3pP/CF2JGYqFc5BTJasutjZv3GtyeJNxbCRh3ixlkOcaxrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710163404; c=relaxed/simple;
	bh=gF/49PRWqKIOjN0QBPMpilOg6At99mrH6ur7Cuwr5iI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E8WEHtFB11ePkWmfaWOcUhhwk7MFtbuy9sNJ3dXoR50gesjOBTdY9G83+qq3WgPLLgDZOTcXHgTThwrxU33Tb/VzClmOQJgiIPHij6LopGQ8r+s9qiZbMNXqUj7QqSBvdfEXTuVRh/RVeKEBGIKSXHfphbdflL+PFvd6jQMIm94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=Tg/qee/E; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a45b6fcd5e8so523058866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 06:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1710163401; x=1710768201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2W2hX8GUo9AmFrcWY4mRmRpD/vlwywol2TBSthqDcw=;
        b=Tg/qee/E5yy1veoiTimuimDecWz8DvUGC8e/O89HHWcDOpALSApD3T7OcEe3/cZUW7
         GJHr5KXJKQZKN883XYQENdLpxPxqCGXFFNxqIFS9XRjq+IFwux+cwwbGwsDEUoNXTDvw
         LEHP31j0Sze0wCJi2rstGunFrQk4NzbuIbJoxO4dzx1/T3bEX1CeJE7q6FZxujT1TfpW
         fYTqnEdGLDje4Y0VtCznxCiazfiYW1Ucr/bJt8GSAyVd51gsdZi/XvnduGEnJ7VCZcJ3
         Jv0fH7EmulWWn4dBY2k753pglYnUsMROvw8E/0dW12G1cqATUK7u42HxZ39/5pFRgHmy
         5uxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710163401; x=1710768201;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l2W2hX8GUo9AmFrcWY4mRmRpD/vlwywol2TBSthqDcw=;
        b=iYzg9IrWhGiiAs8aBwqQCl3lcCInH+wmB2IVWYXqC5lK2/0tofJbutzlvW3pAkkR63
         KbbfXaHyQ5Of9LRsRDe+F69GZBx3M/v0JM7DrbKmmvm2fIGCI6RaW74PlJoyxEwEkERF
         6TTo3ytDWMbHFABhvrDQ+L9qwS6IkPdENJDtzE4v+aGa2X+ApOLsTsPpRu9/FPQtDnQO
         hlP4uaLMGZoGoanYnSilPGz3ik42729P4Lk3V5Q6fXw13pviDT0z572tK3zzhql/3n2V
         8/PX2aTaeav4XnUBe3u52hk3koolrci35XJjVv2bpotB4kVavyr64BWcX9iDgu5kNW3c
         G8DA==
X-Forwarded-Encrypted: i=1; AJvYcCU4pseSNDUxdgxzxmbZEwYaORLPUQ3MqNXx4W6OuiawdGe4UAIdrpn4IdU/bZfJazVB52Vg/u5KF/J/9uI52SXoCeZzUj2DeKuHzO7u
X-Gm-Message-State: AOJu0YxAp9KcCxPvkEkWLaKPQsgzH8jeCWD2Pe56Hbg5q2Nnov2yNLWH
	28oViwF7QNXUtrSdOFDK9G9YbU/H43HcWWp+vKifuI3JfBZ/KgqRKpvOXLSngKQ=
X-Google-Smtp-Source: AGHT+IHtNPRHx+nhe/W1rI9HjfcbHrjBo2RFzoD+F/seDSm9TKBHirWLtcCrIYZTfrXNi5foWV2pwQ==
X-Received: by 2002:a17:906:1843:b0:a44:71d1:dd9f with SMTP id w3-20020a170906184300b00a4471d1dd9fmr2987117eje.70.1710163401240;
        Mon, 11 Mar 2024 06:23:21 -0700 (PDT)
Received: from raven.blarg.de (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id i26-20020a170906251a00b00a44cb0bf11bsm2861075ejb.79.2024.03.11.06.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 06:23:20 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: richard.henderson@linaro.org,
	ink@jurassic.park.msu.ru,
	mattst88@gmail.com,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH 06/11] arch/alpha/irq: include irq_impl.h to fix -Wmissing-prototypes
Date: Mon, 11 Mar 2024 14:23:01 +0100
Message-Id: <20240311132306.3420135-6-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240311132306.3420135-1-max.kellermann@ionos.com>
References: <20240311132306.3420135-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes:

 arch/alpha/kernel/irq.c:96:1: error: no previous prototype for 'handle_irq' [-Werror=missing-prototypes]
    96 | handle_irq(int irq)
       | ^~~~~~~~~~
 [...]

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 arch/alpha/kernel/irq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/alpha/kernel/irq.c b/arch/alpha/kernel/irq.c
index 15f2effd6baf..51c1c87ad8c4 100644
--- a/arch/alpha/kernel/irq.c
+++ b/arch/alpha/kernel/irq.c
@@ -11,6 +11,7 @@
  * should be easier.
  */
 
+#include "irq_impl.h"
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/errno.h>
-- 
2.39.2


