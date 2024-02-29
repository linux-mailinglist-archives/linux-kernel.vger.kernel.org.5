Return-Path: <linux-kernel+bounces-87254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8B886D1C4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25717286B8E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44AF7A159;
	Thu, 29 Feb 2024 18:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GDGFtnP3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3138B70AE4
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 18:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230388; cv=none; b=GtB8hEE2RhGo8AO6XYDKCzlOxsVndR0oFuLUKv9VvoLU+Gxn8C9wTPZD80wX8sgs8DHQSzU9aSPfvaGzbyd6xyl+lyDQO1K63ZhYARx1i8j6uabY4Ss9brsz0oHr/FCQYHBzhQhne9oE0qoTCPEU9GsNDoVrTXOY1GIpzV7Ud2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230388; c=relaxed/simple;
	bh=wwT/73TZLUN9nMPo1iubmrl4kKujUgP+nvI3bxKowtY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CqMd/8ODAq391stNxwA4ALRqB/EJr1MhWx0axV+6fjJtCdvbBgJgvrXi6XWJUdiKjrV2g9JgvH9rFeGYK9ehiW7TdGz59P/bUI3xz2yuYZ/UPLI/72FajVP/4R/Z4PFwnbNYupd1ULIb79b39EULKdxGsZy/BOEy7eXXpjDyzXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GDGFtnP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5A3C433F1;
	Thu, 29 Feb 2024 18:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709230387;
	bh=wwT/73TZLUN9nMPo1iubmrl4kKujUgP+nvI3bxKowtY=;
	h=From:To:Cc:Subject:Date:From;
	b=GDGFtnP3zxkG5xvsUeTyTb0eCeqhsiYlMgxf4/Z48Av8OSdGxu7kDcQA69IaFLywn
	 iBhqJ8braZpPHJ+6Gw6NNkys2BaSONIIQIpLRT2wL7n4evJpO4oX1H8BAdZ6t2wl3J
	 vTnVXxqVHVbUc11tdOTfYFOpwcX7mG/CIYZ/ttecaSkDHBXPDDOR1wJTRdPV8aF4+3
	 AyPBXV9F0bMRvL5YiwXvVR+nY8todt8+taPkqrE9gQGTN5GjEGanqS3B58/IljrT7l
	 mwhvQCFlZW/kXG5m7be0AvHzsK8dXeSq290YwlgtGpbvKwwUSeTslUQULpyStz2kej
	 yi6uw1S2UgiEA==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tomas Winkler <tomas.winkler@intel.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/3] mei: remove unnecessary NULL pointer checks
Date: Thu, 29 Feb 2024 12:12:57 -0600
Message-Id: <20240229181300.352077-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

After .probe() has returned success, drvdata has been set to a non-NULL
value, so there's no need to check for NULL in other callbacks.

Bjorn Helgaas (3):
  mei: gsc: remove unnecessary NULL pointer checks
  mei: txe: remove unnecessary NULL pointer checks
  mei: me: remove unnecessary NULL pointer checks

 drivers/misc/mei/gsc-me.c  | 17 ----------------
 drivers/misc/mei/pci-me.c  | 38 ++++++------------------------------
 drivers/misc/mei/pci-txe.c | 40 ++++++--------------------------------
 3 files changed, 12 insertions(+), 83 deletions(-)

-- 
2.34.1


