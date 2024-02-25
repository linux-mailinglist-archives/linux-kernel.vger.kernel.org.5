Return-Path: <linux-kernel+bounces-79925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 965F68628C4
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 03:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C01AF1C20E98
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 02:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6283246A0;
	Sun, 25 Feb 2024 02:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="VOdaIOKF"
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7541C01
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 02:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.50.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708827109; cv=none; b=u5exclHgLhZ3ZtLn/FoUJzMqacE8AXqmMV5/xmKOJBrp7ajf+ymPhSka6D5pIC92v+dz/YZY3hfIkgJ+3AGT1422WbhKedaVjmRKfLyzoNvDDTOq37TWAaYZw/oON4+xL+dfb+0McCwyPtgpCbrySazNkEX1De4ShTWUAUUeMYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708827109; c=relaxed/simple;
	bh=qUIUsVBstbXO0vlpwp33cf0o3uySQ7xHiTBO3qyZ/TQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j0r9irUqgkPmWIOzNsVLX81aQ0yAcsZVJrg8jMN/NPusNFqhl42PeJ2dXcshdPa8a7s00eu+jpsA9j3G2FSbUJG3dPiv3mLa8W7f6REeNXdeuvZs9ykrIq6lYrSR1rhR02lajFHVvQp68EeUrhRugE60cQ7nwNQwF/T+HKasd4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=VOdaIOKF; arc=none smtp.client-ip=45.254.50.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=qUIUs
	VBstbXO0vlpwp33cf0o3uySQ7xHiTBO3qyZ/TQ=; b=VOdaIOKF+pknlcVz3oJmG
	t3Ajk2Me6k4J7xINkn20mWZnmRK+42i+HawZ03qj9Mc5bcLw7MMZGoC0MWfdtjtA
	XfrlPVO24+upQeaL9suFSjntSRI5pOLRqCj1V7qXyCZojU3FYvGKNgcUPUc3EeLC
	0f9+JGMiDbQk7im3ixnbLM=
Received: from ubuntu.lan (unknown [120.229.19.179])
	by gzga-smtp-mta-g0-4 (Coremail) with SMTP id _____wBnDimkodplE6Z4Fw--.28973S2;
	Sun, 25 Feb 2024 10:10:46 +0800 (CST)
From: Junwen Wu <wudaemon@163.com>
To: bristot@redhat.com
Cc: bsegall@google.com,
	dietmar.eggemann@arm.com,
	juri.lelli@redhat.com,
	laoar.shao@gmail.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	wudaemon@163.com
Subject: Re: [PATCH v5] sched/stats: Fix rt/dl task's sched latency statistics error in sched_stat_wait tracepoint
Date: Sun, 25 Feb 2024 02:10:44 +0000
Message-Id: <20240225021044.6854-1-wudaemon@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <9ce7c466-ce9d-4673-b89a-d3244226dbde@redhat.com>
References: <9ce7c466-ce9d-4673-b89a-d3244226dbde@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBnDimkodplE6Z4Fw--.28973S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjTRMFALUUUUU
X-CM-SenderInfo: 5zxgtvxprqqiywtou0bp/xtbBzQqPbWVOCF2fpQAAsh

>Reviewed-by: Daniel Bristot de Oliveira <bristot@kernel.org>

>Thanks
>-- Daniel

Hi, Daniel, this change is pending one month, when this change can be merged into mainline?
Thanks
--
Best regards


