Return-Path: <linux-kernel+bounces-25105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8414182C804
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28C04286E15
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283271A71D;
	Fri, 12 Jan 2024 23:37:17 +0000 (UTC)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774441A706
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 23:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6ddec7e5747so2514181a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 15:37:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705102634; x=1705707434;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DXiBs0Dsv9lw08RA+psp/orErqrti+c5fonsf5dUFRo=;
        b=gvdgTDIalNpO6pkPGpQ4SY+7xoAXKQzKFHZ6QrOlUnKBUyljTeR8SaRl/34cCgfbi1
         5RfSIgDlQgYbespOqwkMWkNgHakph2dXJgG89c5VaCzroSIut9vGKT0K9uWR/z1BP2au
         bhUzzou6yd5iyEGJO31whfHmmzrsDaQuMENiXx7RFoLeQ0LnTJquC4bX4JwXOcL2Fe70
         ++oVGo5vDrPSUhE1NpmsrVQrfcjDvb/nv6R7ns2YCePDITxPtIdb9UZTsXgC6VsVggMp
         4Q4DshVl7pGPmGBSZVDAUNbjxQt0xD6+839lHgkKvIvR3eThnJ5MdfoLrr0cwKQKMp5v
         4Gqg==
X-Gm-Message-State: AOJu0YxkwVW6trqtEDUSt2qyHzZdNRgKZirCKsyoofZasF/ffwnya21/
	yRcjvvsdLCHedYDvEN9bddI=
X-Google-Smtp-Source: AGHT+IEdNIM2lremxB3JZhNXf4OuMUXyIV4MCDVGmUw8k5Ivx9Us2Hv3XZbGLovn7MBYk8JmFX6PxA==
X-Received: by 2002:a05:6830:12d6:b0:6dd:eebd:cd5f with SMTP id a22-20020a05683012d600b006ddeebdcd5fmr2415192otq.48.1705102634455;
        Fri, 12 Jan 2024 15:37:14 -0800 (PST)
Received: from snowbird.lan ([136.25.84.107])
        by smtp.gmail.com with ESMTPSA id x5-20020aa793a5000000b006d9b4171b20sm3676811pff.112.2024.01.12.15.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 15:37:14 -0800 (PST)
From: Dennis Zhou <dennis@kernel.org>
To: Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux.com>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Dave Chinner <dchinner@redhat.com>,
	Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Ye Bin <yebin10@huawei.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Dennis Zhou <dennis@kernel.org>
Subject: [PATCH 2/3] cpu/hotplug: Remove export of cpu_active_mask and cpu_dying_mask
Date: Fri, 12 Jan 2024 15:36:47 -0800
Message-Id: <1d719106061cc0177eb16d6d5ac914c0485772b2.1705101789.git.dennis@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1705101789.git.dennis@kernel.org>
References: <cover.1705101789.git.dennis@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

No module users and no module should ever care.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
[Dennis: applied cleanly]
Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 kernel/cpu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index a86972a91991..c4929e9cd9be 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3126,10 +3126,8 @@ struct cpumask __cpu_present_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_present_mask);
 
 struct cpumask __cpu_active_mask __read_mostly;
-EXPORT_SYMBOL(__cpu_active_mask);
 
 struct cpumask __cpu_dying_mask __read_mostly;
-EXPORT_SYMBOL(__cpu_dying_mask);
 
 atomic_t __num_online_cpus __read_mostly;
 EXPORT_SYMBOL(__num_online_cpus);
-- 
2.39.1


