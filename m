Return-Path: <linux-kernel+bounces-46818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DC88444B8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 056BA289717
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 16:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F9712AAFE;
	Wed, 31 Jan 2024 16:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="wpj0VHVs"
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057257EF1B
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 16:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706719562; cv=none; b=AxIKyWK77CcF4lbyJN+MSg9EoD3YRabSaMqlXkcymuH+UKoKLXSVE6hlK9Xsyg6QR9GHOrmzyOtk3X9H5ieWSDJLAT8cxCPmELc9f214VaqCh2enKd0ZgstTp+WiRtv2b7gBuHWtXHPegiba6pdhx5nRbz5EqLrx/P52BxkaPhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706719562; c=relaxed/simple;
	bh=rWuY2WFjFpK0iQCxg3UfVQjxegUObE7Os8H2Jn7B3yE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=oqSEpSWlBKOhuLG/cvSHUweUk+sqVKTw4NgpPRacO3T7Z3KiKhDJIh+EKlMPqxqE7lzIzevc1sIHNJuEkATxsRYedhXcY/fuPg2KlaTPaKFuc37JXyufLQM1koUMYeEEt/qQnbn4+igUuznSbqhjzVpDLpP8AMQaB2f8BW6pqig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=wpj0VHVs; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706719551; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=qZaaHsXtjAuwT+RfcSCBmL07/CAuXbhOkxSW2znBchQ=;
	b=wpj0VHVs49E44Yqmvsy77BBD24+uzfZNrAwvIbfVwpoBFeHz+rZ/uZmmUDzh+vLoTEHAxI85zzjxLxKEKbUnTQJXg3JOaWBqCKWt0QBpc2DKNi2A+2InOYIX1lQTYYR5rnoAEufCKKLvkO5QGpV8vbhGoKLMUwY2e4jNnQxxw24=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=yaoma@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W.k84N3_1706719549;
Received: from localhost.localdomain(mailfrom:yaoma@linux.alibaba.com fp:SMTPD_---0W.k84N3_1706719549)
          by smtp.aliyun-inc.com;
          Thu, 01 Feb 2024 00:45:51 +0800
From: Bitao Hu <yaoma@linux.alibaba.com>
To: dianders@chromium.org,
	pmladek@suse.com,
	kernelfans@gmail.com,
	liusong@linux.alibaba.com
Cc: linux-kernel@vger.kernel.org,
	yaoma@linux.alibaba.com
Subject: [PATCHv3 0/2] *** Detect interrupt storm in softlockup ***
Date: Thu,  1 Feb 2024 00:45:14 +0800
Message-Id: <20240131164516.34139-1-yaoma@linux.alibaba.com>
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
'sparse: incorrect type in initializer (different modifiers)'.

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

 kernel/watchdog.c | 238 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 238 insertions(+)

-- 
2.37.1 (Apple Git-137.1)


