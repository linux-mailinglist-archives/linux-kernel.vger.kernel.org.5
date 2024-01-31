Return-Path: <linux-kernel+bounces-46890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCF98445DE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 502DF1C24390
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B5812CDAD;
	Wed, 31 Jan 2024 17:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Jp7Fvhl8"
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDEC12BE8F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 17:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706721476; cv=none; b=Gobmz4dphQLi5DNSG+cKQR2yeGLV8Z+9zOm0JFnC1aW5zz07M9XctEY+kI6K+N1U/3wqUXxG46p5SSd6DP4cpdpeld/Qha1uWo0jEhmjhXEFI2NEbvGAZnWFyrx5uQ8stibySA6Vu91uJ2vwFERKRZXwK8fa6qcwy7KbqJGWRuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706721476; c=relaxed/simple;
	bh=xDWbSj+lWcUFeXVwKmzyveEoDYPjena42XWOP2OB/2g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qZ3uB4tV565+mETQDIw1lBIdDJyGOh4DqZHNf/78dw6PWNMb2x8bsuhP/OsIBBDWwtTtLVgLomuTBVZ1KvQxVg2jJyCUbI4GjC7rfbxN7K+BBKhWB6wGg4mM/qfj8k96bpf6Hf0OjOgfnpm29mYuUaLVSdb0zS6wouLyGtvukrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Jp7Fvhl8; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706721464; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=iJAyliH1jmGlDN9SYN3BWB7VVtP7e8HnSMJHDLoyYew=;
	b=Jp7Fvhl8epCn3qowKBxyy2pb6/iE1dlwhVda7ue0qmQydlI6JqS8EWWEu7x7Ou1jak+4tLuhK6wPuoOhntJK/D9PQOOv7YFLIqDuXL8bkW5BXMB5lEUvDMBOqg668Q64wzGZ4gzxDwy4EGyDsMnaUODNe/zHEJzk87tF1j/FPGc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W.kJfU8_1706721462;
Received: from localhost.localdomain(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W.kJfU8_1706721462)
          by smtp.aliyun-inc.com;
          Thu, 01 Feb 2024 01:17:43 +0800
From: Bitao Hu <yaoma@linux.alibaba.com>
To: dianders@chromium.org,
	akpm@linux-foundation.org,
	pmladek@suse.com,
	kernelfans@gmail.com,
	liusong@linux.alibaba.com
Cc: linux-kernel@vger.kernel.org,
	yaoma@linux.alibaba.com
Subject: [PATCHv3 0/2] *** Detect interrupt storm in softlockup ***
Date: Thu,  1 Feb 2024 01:17:36 +0800
Message-Id: <20240131171738.35496-1-yaoma@linux.alibaba.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, guys.
I have implemented a low-overhead method for detecting interrupt storm
in softlockup. Please review it, all comments are welcome.

Changes from v2 to v3:

- From Liu Song, using enum instead of macro for cpu_stats, shortening
the name 'idx_to_stat' to 'stats', adding 'get_16bit_precesion' instead
of using right shift operations, and using 'struct irq_counts'.

- From kernel robot test, using '__this_cpu_read' and '__this_cpu_write'
instead of accessing to an per-cpu array directly, in order to avoid
this warning.
'sparse: incorrect type in initializer (different modifiers)'

Changes from v1 to v2:

- From Douglas, optimize the memory of cpustats. With the maximum number
of CPUs, that's now this.
2 * 8192 * 4 + 1 * 8192 * 5 * 4 + 1 * 8192 = 237,568 bytes.

- From Liu Song, refactor the code format and add necessary comments.

- From Douglas, use interrupt counts instead of interrupt time to
determine the cause of softlockup.

- Remove the cmdline parameter added in PATCHv1.

Bitao Hu (2):
  watchdog/softlockup: low-overhead detection of interrupt storm
  watchdog/softlockup: report the most frequent interrupts

 kernel/watchdog.c | 240 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 240 insertions(+)

-- 
2.37.1 (Apple Git-137.1)


