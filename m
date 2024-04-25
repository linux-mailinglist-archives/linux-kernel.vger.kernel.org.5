Return-Path: <linux-kernel+bounces-158508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4678B2172
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F1421F226BB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFDD12BF28;
	Thu, 25 Apr 2024 12:14:48 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CFB85274;
	Thu, 25 Apr 2024 12:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714047288; cv=none; b=n7gMlAXK0oFWMBoqnm4Zs/G6nDSCMK0F9A0bmX3hMawXgLU0/qNXt6IT8I9Q65iJzVQxuH75IcTenpJFfufUkQP8+vT9OZARaLZA9HObI2C0Y9BNMdF9dqaBXoksdLOR2kJLz2pzlIFlWC0O4POsutNhx5ua3P2uwAfHn/jonOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714047288; c=relaxed/simple;
	bh=3vGb389ZmgV4GOiQ1rZ+LjSvyzxdXIH+pwBolR/mcC0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nULIJhjBzKc6oKK+R88k8kENaVambzz17MRGHf+mL3j59GGpNkWwwK1qGmoOoJFE8RzjZI+KcK9XXJN9a+o0olHHJneFXOxoW257JhLs+OO9wtqfgxnI0p1NYkiyBvQJfs126U9l9o6eobXWJR/jz7c3kgHtThY4TEh8Y56n+iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8BxmPA0SSpmbMsCAA--.13315S3;
	Thu, 25 Apr 2024 20:14:44 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxLN4zSSpmGw4FAA--.17827S2;
	Thu, 25 Apr 2024 20:14:43 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	WANG Xuerui <kernel@xen0n.name>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev
Subject: [PATCH] LoongArch: Lately init pmu after smp is online
Date: Thu, 25 Apr 2024 20:14:43 +0800
Message-Id: <20240425121443.1009824-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxLN4zSSpmGw4FAA--.17827S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

There is smp function call named reset_counters() to init PMU registers of
every CPU in PMU initialization state. It requires that all CPUs are
online. However there is early_initcall prefix with PMU init funciton
init_hw_perf_events(), so that pmu init funciton is called in
do_pre_smp_initcalls() and before function smp_init(). Function
reset_counters() cannot work on other CPUs since they do not boot up
still.

Here replace prefix early_initcall with pure_initcall, so that PMU
init function is called after every cpu is online.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/kernel/perf_event.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/perf_event.c b/arch/loongarch/kernel/perf_event.c
index 3265c8f33223..f86a4b838dd7 100644
--- a/arch/loongarch/kernel/perf_event.c
+++ b/arch/loongarch/kernel/perf_event.c
@@ -874,4 +874,4 @@ static int __init init_hw_perf_events(void)
 
 	return 0;
 }
-early_initcall(init_hw_perf_events);
+pure_initcall(init_hw_perf_events);

base-commit: e88c4cfcb7b888ac374916806f86c17d8ecaeb67


