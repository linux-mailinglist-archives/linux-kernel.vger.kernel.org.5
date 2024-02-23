Return-Path: <linux-kernel+bounces-78711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 789838617B0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9631B1C21CF7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCA812D1F4;
	Fri, 23 Feb 2024 16:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="EThzj3iT"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099F982D75
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708705258; cv=none; b=B/ml+xf2HuDLHlcxRCcZR313mBzQvs9ArxpNxMGmXhlHxNgn7NECQ63w7JfndXHQURD4djsaqrrlM2GslzjWL2BjjRDTj1dUZaZB3ahP6Mtdsn0GykwDrf8x01xk0BSA3LYDcC5LVVznkAwl4rFBxq9moJ3gyFS9uKbBouJjBPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708705258; c=relaxed/simple;
	bh=L8PXCozSmgxbC1C2giikVCZGfkKTi2J80S0eCgayR/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e6Tof9EJEX8fsypzClR7CM+gLhnYwu3vRz5mqH0VB3Kbz9W6CP5IBJxXlD3/4fJv8k8615/EQyRKDUb88mMQk1OaKKY1CSU4AB0KuMbHvmzaQdZFuRbLJ6lrahEFW23Ophelszn5ap++e31BwDMZn/VKY9vvJRe+QD2FwLllazc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=EThzj3iT; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=L8PXC
	ozSmgxbC1C2giikVCZGfkKTi2J80S0eCgayR/Q=; b=EThzj3iTuaiUOtJB7kd/o
	i9Qjfrapoy8rf5eFvnVaCWQE6J4y9L3wRh8iFhlgawV6uXTBYkCoX+ihn4LiY1NG
	KcVzhxlrWW0M8EB/8IFzvNsjJZ/ohFv22+9KweLj37GyAapmXmHCn1D2Vm9SPwbR
	K72ZSwkEbkwNEHBa9abQwk=
Received: from nilq-virtual-machine.localdomain (unknown [60.24.208.202])
	by gzga-smtp-mta-g1-0 (Coremail) with SMTP id _____wC3_ce6xdhlK7OlAw--.4841S2;
	Sat, 24 Feb 2024 00:20:12 +0800 (CST)
From: "ni.liqiang" <ni_liqiang@126.com>
To: will@kernel.org,
	danielmentz@google.com
Cc: iommu@lists.linux.dev,
	jin.qi@zte.com.cn,
	joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	ni.liqiang@zte.com.cn,
	niliqiang.io@gmail.com,
	robin.murphy@arm.com
Subject: Re: [PATCH] drivers/iommu: Ensure that the queue base address is successfully written during SMMU initialization.
Date: Sat, 24 Feb 2024 00:20:10 +0800
Message-Id: <20240223162010.6884-1-ni_liqiang@126.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240221160849.GB7362@willie-the-truck>
References: <20240221160849.GB7362@willie-the-truck>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wC3_ce6xdhlK7OlAw--.4841S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw1UWryruw18XryDGw1xZrb_yoWfWwcE9F
	W7Gan7Jw4UXF4vkanI9Fs0vrs5A3y8ZFy8Ww4fKrsrKryfXFy0gry8Xry3t3W5Jay3XrZF
	9a9rZ3WIy3ya9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbJ3vUUUUUU==
X-CM-SenderInfo: xqlbzxxtld0wa6rslhhfrp/1tbirxqJ5WVLZEeq5gADsb

> (Disclaimer: I don't know what a CCG port is)

CCG(CXL Gateway) is a part of the CMN700 Coherent Mesh Network. It plays
a crucial role in facilitating cross-die access in a multi-chip system.

> Hmmm. The part that doesn't make sense to me here is that migrating between
> CPUs implies context-switching, and we have a DSB on that path in
> __switch_to(). So why would adding barriers to the driver help? Maybe it
> just changes the timing?

This is very likely. Through our experiments, adding a delay before CMDQEN
does not reproduce the failure of writing to the CMDQ base register.

> I'm not sure what you're proposing, but I don't think Linux should be
> changed to accomodate this.

I am very grateful for the responses from both of you experts. We will
continue to check the current hardware configuration of the system
and attempt to fix this issue.
Once again, I express my thanks. Thank you.


