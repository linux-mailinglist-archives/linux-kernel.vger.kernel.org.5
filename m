Return-Path: <linux-kernel+bounces-28951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 574B4830517
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA66128A3D8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641411DFEB;
	Wed, 17 Jan 2024 12:20:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164381DFCD;
	Wed, 17 Jan 2024 12:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705494017; cv=none; b=hT44F0an2852AIoy2Qp3GsutMMkHUFoLXP0RO3UwFMLQWuqJ6pCFpdVCErAcTWtQhyd11P9tyOczSnI3R4rQYsKcdoID79L5gmnk7cTXkzmyy1yN7Oot22Iqom9VdL8HFDe3UwL7gAHlsgPmB19xbqHyHJ0Fa10D3aQUdxFd5uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705494017; c=relaxed/simple;
	bh=wZhbyFNn4JqJb0pkLFRCR7iXvHOOBQbUVu4GjXo16/U=;
	h=Received:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Content-Language:To:From:Subject:Content-Type:
	 Content-Transfer-Encoding; b=GnmSg8Gm+uk1G7Y8v+j21qNOJTep/HqPFz4LKb6uAq7hOTJnCiAYD6K83pk7d+03sv9eGZwwUIXShmG81QQephpz1HgOgCdsqNoH5RiAzBeAmPzmHxQPflaKIlqhHiSCJj/rKD9Qgs3Rz3fdm01wmHXZraPSFXgnqSsWQyAlMlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8262C11FB;
	Wed, 17 Jan 2024 04:21:00 -0800 (PST)
Received: from [10.1.26.46] (e133047.arm.com [10.1.26.46])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C77F3F766;
	Wed, 17 Jan 2024 04:20:13 -0800 (PST)
Message-ID: <cde50a18-7c09-4d00-b3b8-32da2992c952@arm.com>
Date: Wed, 17 Jan 2024 12:20:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-kernel@vger.kernel.org, axboe@kernel.dk, bvanassche@acm.org,
 linux-block@vger.kernel.org, corbet@lwn.net
From: Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH] Documentation: block: ioprio: Update schedulers
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This doc hasn't been touched in a while, in the meantime some
new io schedulers were added (e.g. all of mq), some with ioprio
support.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 Documentation/block/ioprio.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/block/ioprio.rst b/Documentation/block/ioprio.rst
index a25c6d5df87b..5410308888d2 100644
--- a/Documentation/block/ioprio.rst
+++ b/Documentation/block/ioprio.rst
@@ -9,14 +9,14 @@ Intro
 With the introduction of cfq v3 (aka cfq-ts or time sliced cfq), basic io
 priorities are supported for reads on files.  This enables users to io nice
 processes or process groups, similar to what has been possible with cpu
-scheduling for ages.  This document mainly details the current possibilities
-with cfq; other io schedulers do not support io priorities thus far.
+scheduling for ages. Support for io priorities is io scheduler dependent and
+currently supported by bfq, mq-deadline and cfq.
 
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

