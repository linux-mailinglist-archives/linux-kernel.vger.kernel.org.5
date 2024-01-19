Return-Path: <linux-kernel+bounces-31355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98952832D0B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E1E4B23282
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FE554FB6;
	Fri, 19 Jan 2024 16:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RJU0kY5V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA62254F9D;
	Fri, 19 Jan 2024 16:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705681348; cv=none; b=LlrdtuihQujsI0z5ip94GvaKvqYX7+cVpCBplm4rzAOP42n8YF/ejpQ0pTptwhGyhtWTlxMjwXB+R4aAD/O7pVRwp96aIyv6bmy+ivrPUeluhmiHcuHRYeGV+pf+PV9GNt5jlrHxljZjfbah7Tz6XtAhoQcqpCxt5sp1AU2CZuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705681348; c=relaxed/simple;
	bh=8oTS/JPNPH63FyG+8PYnQHWTK0FkIeL1C8Wyeu1NV/I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Zm8NS4wJI7VXtS1tyykTi7JyKjx6U0yi/BEqfHP2a2G6KzVGRJyueXZ7hb5TUw69gyBRVUw+xSzn0H9Fb0ZrItcVdUQeBWmDMqU+aQ50GMP6xqB4XmwaVGr4uLN+5JPzpnqwprnhFO6A7Y7Ta/e0MFRl7CLOLdBgRcxI2TPmJNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RJU0kY5V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DE9C433C7;
	Fri, 19 Jan 2024 16:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705681348;
	bh=8oTS/JPNPH63FyG+8PYnQHWTK0FkIeL1C8Wyeu1NV/I=;
	h=Date:From:To:Cc:Subject:From;
	b=RJU0kY5VJbCxEsfJ6zn+3Er93PoiD0rFfl6wwayycQh+LetpzkEN26fv/5jIwEOm6
	 aYUGy740P4S5mgy/XSx2FKkBtRG9Beygu0lHQyOQl+XZ8VE9iAwAEPkeWhV0J/xd6o
	 lNWKxK4HtbjKOpCojnrU4fgO7S1jopUyeocJIZBY6fkOBpvbXoaViUWJa8HFjObLTS
	 gWr57t9TXYoVwXSiS/kyyTWN5N7PZ/qFMkaupQWMOpb40m5MA6XBp/gnx+qlVd3utF
	 GRfxscfklCiZmVZ4pKSTfhXB1PeeLd+oG3Y8/EJYWe22g52iWhu0s7yZFp1dB1Azhg
	 LZpkagS+ZOJcA==
Date: Fri, 19 Jan 2024 10:22:25 -0600
From: Rob Herring <robh@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree header detangling for v6.8
Message-ID: <20240119162225.GA449893-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

As mentioned in my first pull, this is a long overdue DT header cleanup 
(I sure wish we'd done this when it was only PowerPC to fix before 
adding all the Arm drivers in the last 13 years). These commits have 
been in linux-next for over a month now, but I've rebased them on your 
tree to have a branch that builds now that all the dependencies are in. 

Rob


The following changes since commit 9d1694dc91ce7b80bc96d6d8eaf1a1eca668d847:

  Merge tag 'for-6.8/block-2024-01-18' of git://git.kernel.dk/linux (2024-01-18 18:22:40 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.8-2

for you to fetch changes up to ef175b29a242fea98f467f008237484b03c94834:

  of: Stop circularly including of_device.h and of_platform.h (2024-01-19 08:17:28 -0600)

----------------------------------------------------------------
Devicetree updates for v6.8, part 2:

Remove the circular including of of_device.h and of_platform.h along
with all of their implicit includes. This is the culmination of several
kernel cycles worth of fixing implicit DT includes throughout the tree.

----------------------------------------------------------------
Rob Herring (4):
      sparc: Use device_get_match_data()
      net: can: Use device_get_match_data()
      thermal: loongson2: Replace of_device.h with explicit includes
      of: Stop circularly including of_device.h and of_platform.h

Stephen Rothwell (1):
      clk: qcom: gcc-x1e80100: Replace of_device.h with explicit includes

 arch/sparc/kernel/pci_sabre.c          |  9 +++++----
 arch/sparc/kernel/pci_schizo.c         | 13 +++++++------
 drivers/clk/qcom/gcc-x1e80100.c        |  3 ++-
 drivers/net/can/c_can/c_can_platform.c | 13 ++-----------
 drivers/net/can/flexcan/flexcan-core.c | 12 ++----------
 drivers/net/can/mscan/mpc5xxx_can.c    |  8 ++++----
 drivers/net/can/xilinx_can.c           |  9 +++------
 drivers/thermal/loongson2_thermal.c    |  3 ++-
 include/linux/of_device.h              |  5 +----
 include/linux/of_platform.h            |  4 ++--
 10 files changed, 30 insertions(+), 49 deletions(-)

