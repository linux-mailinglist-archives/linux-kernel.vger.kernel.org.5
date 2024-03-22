Return-Path: <linux-kernel+bounces-111885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A05088722B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BCEC1C223CD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA86605DF;
	Fri, 22 Mar 2024 17:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="L0zU8CJQ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD37D605C7
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 17:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711129917; cv=none; b=rlt3qTCOz8FvE+gr6o4KPns9010E04VkyRmcX4Qp67luhSm1LQgFcsaGjv/LajDMaOBiZtNPto+35a9k+RgGgYDixVstpbJGLdIOgbWV7ETpJnqNbhtcEHp1l1fToN5pZ0flY7UU/e0HPb7KcaF1nuvLF7dHr2dhvs1EFSWHlwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711129917; c=relaxed/simple;
	bh=PZdEA2lkWEJu+n4Qdcxn8N11KxjDt+CSGgGsSTjIJPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jELyFb/bkFIhIDhtYpiWKL/XdRmnD4fFP7Wdwca6ns9m2kUUh201GCn3f7ckviP1DJpVx2wP7GzRnI6IsmHfL9EZ47Pm7zWjV5QgM8zcdJchfbvv0Q/dpp49FUzIOXBIg7ltANWi1JfM895CKsIXwCae6U9OKb51agrdmslYN+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=L0zU8CJQ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711129914;
	bh=PZdEA2lkWEJu+n4Qdcxn8N11KxjDt+CSGgGsSTjIJPQ=;
	h=From:To:Cc:Subject:Date:From;
	b=L0zU8CJQYJEE1MettTXheU6GoTyEYajLxMR+b1F8s2gNBbQjl37RaejsZWWuS6LvN
	 W98TRjTtR4J5reWe+euTGIpWherMT1pTZiAjSv/PP035fygpoJvvnP8ncynrZJUSp1
	 QXOLWvQDaEGGVmfFIwvORl3j+Lo85S5apTtFVGx7WktKkW6rN/vo9Mpoa+DL1mB6kd
	 OlRr6k7tRJbkG5u9shKivt4T4IQlzL5fvrGh+TjLOfbSgb1/nFMB1vpU5in4FABtGI
	 Kg0pdcPJdAfXkfumngsvweE2eD+PaZFTlkIc2LA8VDvm2hxpcB09fsZ9kw73Cp0URq
	 /aICVlqxK3xqQ==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 876F9378211C;
	Fri, 22 Mar 2024 17:51:53 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: regressions@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: [REGRESSION] mainline boot regression on AMD Stoney Ridge Chromebooks
Date: Fri, 22 Mar 2024 18:52:10 +0100
Message-Id: <20240322175210.124416-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

KernelCI has identified a mainline boot regression [1] on the following
AMD Stoney Ridge Chromebooks (grunt family), between v6.8 (e8f897) and
v6.8-1185-g855684c7d938 (855684):
- Acer Chromebook Spin 311 R721T (codename kasumi360)
- HP Chromebook 14 (codename careena)
- HP Chromebook 11A G6 EE (codename barla)

The kernel doesn't boot at all and nothing is reported on the serial
console after "Starting kernel ...". The issue is still present on the
latest mainline revision.
The defconfig used by KernelCI for the boot tests can be found in [2].

Sending this report in order to track the regression while a fix is
identified.

Thanks,

Laura

[1] https://linux.kernelci.org/test/case/id/65fca98e3883a392524c4380/
[2]
https://storage.kernelci.org/mainline/master/v6.8-11837-g2ac2b1665d3fb/x86_64/x86_64_defconfig%2Bx86-board/gcc-10/config/kernel.config

#regzbot introduced: v6.8..v6.8-1185-g855684c7d938


