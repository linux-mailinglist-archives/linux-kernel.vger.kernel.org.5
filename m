Return-Path: <linux-kernel+bounces-25103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA6782C802
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B34311F23365
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10061A5A7;
	Fri, 12 Jan 2024 23:37:13 +0000 (UTC)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F155F17734
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 23:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-6dde173384aso2709309a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 15:37:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705102631; x=1705707431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SVfOI8w12aI3+T3TMUSSNd7UpcAZD7/xtS98IbT/+6k=;
        b=AeqAI/OkLSjCu61nLjU5ekoC62A2ndu1dNFq95J/lhVv6eCt5xXtbCoNuJk6TEVq/r
         YVhD5Y0SN8kVxZ4a/OPtAglbII9WIbSqzN3URimSgkF540PF6MF+iz/s+PJCXWQRvSyD
         a4vkHjHM7JisVwgkKM8czF7RytOfPkFonWO5T1HLzts7SHh17C9NsiWqon+jCEcokY7x
         JXM67YUQWU2lCQwQTGU7dKy9CaWl1hEQqwZ+YWiRzJSlCp4C4jyaZl2qwspvzHfajz1t
         hvmqLWH6MmC3YIIaKaCDLyLmIFS/zGlljiGKu7Sb0MUKP4C/MYNQmEt+dD+nu7s0KJZr
         Z7Ow==
X-Gm-Message-State: AOJu0Yzk7aAk5sDomv78MwcdaItsDOeQ7rd3oULn7i0AsgJKH8cQdn3r
	9s9heE+znNnJTMamw57JiDkot8fjjyq8rA==
X-Google-Smtp-Source: AGHT+IHKvz7Suy9cX9d3UWM+8TuvQVA9u/4+U4ILo0hzoZjxC1LPbmbbcPFQ4oaVb1T4JlVF3Q6Peg==
X-Received: by 2002:a9d:5c11:0:b0:6dd:e286:309 with SMTP id o17-20020a9d5c11000000b006dde2860309mr2194781otk.76.1705102630992;
        Fri, 12 Jan 2024 15:37:10 -0800 (PST)
Received: from snowbird.lan ([136.25.84.107])
        by smtp.gmail.com with ESMTPSA id x5-20020aa793a5000000b006d9b4171b20sm3676811pff.112.2024.01.12.15.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 15:37:10 -0800 (PST)
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
Subject: [PATCH 0/3 v2] lib/percpu_counter, cpu/hotplug: Cure the cpu_dying_mask woes
Date: Fri, 12 Jan 2024 15:36:45 -0800
Message-Id: <cover.1705101789.git.dennis@kernel.org>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

This is a respin of Thomas' series [1] against v6.7-rc4. Largely it's
the same minus a slight change in percpu_counter.c for batch
percpu_counters and updating __percpu_counter_limited_add().

I don't think we reached an alternative resolution here so I can queue
this up and give it some soak time in for-next.

[1] https://lore.kernel.org/lkml/20230414162755.281993820@linutronix.de/

Thanks,
Dennis

Dennis Zhou (2):
  lib/percpu_counter: Fix CPU hotplug handling
  cpu/hotplug: Get rid of cpu_dying_mask

Thomas Gleixner (1):
  cpu/hotplug: Remove export of cpu_active_mask and cpu_dying_mask

 include/linux/cpuhotplug.h |  2 +-
 include/linux/cpumask.h    | 21 ------------
 kernel/cpu.c               | 45 +++++++++++++++++++++-----
 kernel/sched/core.c        |  4 +--
 kernel/smpboot.h           |  2 ++
 lib/percpu_counter.c       | 65 ++++++++++++++++----------------------
 6 files changed, 70 insertions(+), 69 deletions(-)

-- 
2.39.1


