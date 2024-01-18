Return-Path: <linux-kernel+bounces-29960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 340268315D5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 10:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 676161C24E12
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0ABF200DE;
	Thu, 18 Jan 2024 09:30:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D6481F946;
	Thu, 18 Jan 2024 09:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705570203; cv=none; b=uHBh+BQz58AaABs2EOuVuinm3oMno9VGZg7NXyDbtw1NtQ+rvJJgU2o7VU/SHghzEaHyNGbZluj0U8/Mbv84eVA1UmukGuZ6uEHObfQ6bLU5J7tcID6xN0TAQHJyiNlhVaiYn/P2RgPsksvbDc9ZrZtVORNBAAk3DAdRW3nKqhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705570203; c=relaxed/simple;
	bh=R4+K7Qie20s3jGZS63QrPtjyxEAWl88+m5i1etaoA7o=;
	h=Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:From:Subject:Content-Type:
	 Content-Transfer-Encoding; b=EMrRq5CCG9JHuJVgMmZ0sGvhjJaqZUu1/9orLArH6apbY8ckfY5U5uk49HweuAmsjpyHcO5RQAXhwX5d1UMbzJKhGH+iY0Gc9VmfzzRYCv1IsBnhA2LH8+5ybqDIgBnJRnkkQovg2cFA6AmDjQRKQjvviX467clUJKHdmupZigw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4ECB91042;
	Thu, 18 Jan 2024 01:30:45 -0800 (PST)
Received: from [10.1.36.44] (unknown [10.1.36.44])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 244E23F5A1;
	Thu, 18 Jan 2024 01:29:57 -0800 (PST)
Message-ID: <a86cfdc8-016f-40f1-8b58-0cb15d2a792c@arm.com>
Date: Thu, 18 Jan 2024 09:29:56 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 "corbet@lwn.net" <corbet@lwn.net>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "axboe@kernel.dk" <axboe@kernel.dk>
From: Christian Loehle <christian.loehle@arm.com>
Subject: [PATCHv2] Documentation: block: ioprio: Update schedulers
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This doc hasn't been touched in a while, in the meantime some
new io schedulers were added (e.g. all of mq), some with ioprio
support.

Also reword the introduction to remove reference to CFQ and the
limitation that io priorities only work on reads, which is no longer
true.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 Documentation/block/ioprio.rst | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/Documentation/block/ioprio.rst b/Documentation/block/ioprio.rst
index a25c6d5df87b..4662e1ff3d81 100644
--- a/Documentation/block/ioprio.rst
+++ b/Documentation/block/ioprio.rst
@@ -6,17 +6,16 @@ Block io priorities
 Intro
 -----
 
-With the introduction of cfq v3 (aka cfq-ts or time sliced cfq), basic io
-priorities are supported for reads on files.  This enables users to io nice
-processes or process groups, similar to what has been possible with cpu
-scheduling for ages.  This document mainly details the current possibilities
-with cfq; other io schedulers do not support io priorities thus far.
+The io priority feature enables users to io nice processes or process groups,
+similar to what has been possible with cpu scheduling for ages. Support for io
+priorities is io scheduler dependent and currently supported by bfq and
+mq-deadline.
 
 Scheduling classes
 ------------------
 
-CFQ implements three generic scheduling classes that determine how io is
-served for a process.
+Three generic scheduling classes are implemented for io priorities that
+determine how io is served for a process.
 
 IOPRIO_CLASS_RT: This is the realtime io class. This scheduling class is given
 higher priority than any other in the system, processes from this class are
-- 
2.34.1

