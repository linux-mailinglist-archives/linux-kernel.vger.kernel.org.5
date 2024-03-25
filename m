Return-Path: <linux-kernel+bounces-117981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF78588B201
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A3DB3224DA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC6F6FE26;
	Mon, 25 Mar 2024 20:46:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1CE59B70
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 20:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711399604; cv=none; b=VJuhlUJ2heoIdplg0v5d8SMXdwdaeIVSjOkhWnq3nr/+vog1K9XrHYnWPhrzV4MHXagEUR+Jv0NgfgyI0t6qyz+G2iuL6YqHoGxnESDLU5XIYgWKeSnykUHJcOew+8j5KMtqfqRLdkmREwPzFunMFH6b4nO5hLwgESOP2UtjwaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711399604; c=relaxed/simple;
	bh=PI/uzcbG6TLOI2MpOsyBNq+VgpXQTVuXHTCEuJ6Ptic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GGC98J4vrPSjZILnc6AgrtZSR5ouUBoMN8xdfkqqZVuSGvz+FdGSvmZqUfbkCHGwxuKK9gELRkVG+fwJ+zrLfHmcBpmGPbHz7nJFhgT+v3zluChn3Fq8dWiwpPqf8XH47IF4mLPHQHq/UQoA1ysDUBL5i/WNX76swhPFmArd/bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 504FA2F4;
	Mon, 25 Mar 2024 13:47:14 -0700 (PDT)
Received: from pluto.fritz.box (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 027F43F64C;
	Mon, 25 Mar 2024 13:46:39 -0700 (PDT)
From: Cristian Marussi <cristian.marussi@arm.com>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: sudeep.holla@arm.com,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v2 0/5] SCMI misc small-updates
Date: Mon, 25 Mar 2024 20:46:15 +0000
Message-ID: <20240325204620.1437237-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

a bunch of small SCMI updates based on v6.9-rc1.
Mainly adding traces for weird SCMI messages like late timed-out replies,
out of order unexpected messages and malformed messages due to spurious
mbox IRQs.

Thanks,
Cristian

V2:
 - rebased on v6.9-rc1
 - added a common trace helper for weird messages
 - added traces for spurious MBOX IRQs

Cristian Marussi (5):
  include: trace: Widen the tag buffer in trace_scmi_dump_msg
  firmware: arm_scmi: Add helper to trace bad messages
  firmware: arm_scmi: Add message dump traces for bad and unexpected
    replies
  firmware: arm_scmi: Simplify scmi_devm_notifier_unregister
  firmware: arm_scmi: Use dev_err_probe to bail out

 drivers/firmware/arm_scmi/common.h  | 11 ++++
 drivers/firmware/arm_scmi/driver.c  | 83 ++++++++++++++++++++++++++---
 drivers/firmware/arm_scmi/mailbox.c |  4 +-
 drivers/firmware/arm_scmi/notify.c  | 30 ++---------
 include/linux/scmi_protocol.h       |  2 -
 include/trace/events/scmi.h         |  6 ++-
 6 files changed, 97 insertions(+), 39 deletions(-)

-- 
2.44.0


