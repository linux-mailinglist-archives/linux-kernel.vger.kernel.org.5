Return-Path: <linux-kernel+bounces-67296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6CF856957
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:17:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C69F1F29A5C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB50134CE6;
	Thu, 15 Feb 2024 16:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="UFYkEXX/"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0FD134721;
	Thu, 15 Feb 2024 16:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013789; cv=none; b=F3S4PDtP2hqjOum5uuZ8l6ZXkGdP5GUgxIgkoc9xz5WYQ7G4hlGF+wyYj6IYICNPKgenmtBrta79P3tK5rCXWzMV7gek/I0KOAG5WPsyu7EwxxxyNzwYn/5JaeL50tVH+drtluJpuqCGNT56iHLqD4OVEWsWLkXW6L+5UNFbPHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013789; c=relaxed/simple;
	bh=K7/s9BrhrXjtwpTn1wH7BV9+VkoKECs58AQnNFAKXuw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aUBdI28YcQkXlGL8IbuAvQ0jGX7/V6rVEJ9NwBgFZd0TxZWbhN3ShWjxXfWtV4yzdSqxL844MB8wZutRPnziFoKYKbdFlGCZIwxc701hy3HZOVkiOVqzzZ7C+vsVXI1onFBYfOyeRI1noIlPyHVIR3CmRuyAOjZk6WUo93kH60I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=none smtp.helo=mx0b-0016f401.pphosted.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=UFYkEXX/; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mx0b-0016f401.pphosted.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41FCk83k026995;
	Thu, 15 Feb 2024 08:16:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=j7NSDwb/
	05g4ujivAOjTwmWiHN6UlrJeSt0vUbauOFA=; b=UFYkEXX/edsEL9R6b56IQlWR
	oaTSYCJXUTrQ6Cua/+ATRc/cc0h1S62v0YAuL1l3uV7kNb5cIFrb50IMHDv9987v
	9KDlbgofx96yTH/0IEmS3nZ+eWR6jSKjQVwGKmst/xX2zfywJtWu3lEwjH5rNJXm
	+umgMAKLOsM4yz+Wm7H6ubxDGIn+Mry10A2GOsA5piOOsHPgO21XezOYjwcAyEE/
	z+XEH6oRqn/948zGHdMsUrcPnYw5rdPAN+8ldyMkGxv5X13ru4RZAoBVRG/XO3HY
	WSP0FXpSykEpqOiC4Gq+x5yNS2Qmmi9cH2iQY8DOBjQxLVk2KV6oDg/c8KD6Aw==
Received: from dc5-exch02.marvell.com ([199.233.59.182])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3w9jw98uue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 08:16:19 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 15 Feb
 2024 08:16:17 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 15 Feb 2024 08:16:17 -0800
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
	by maili.marvell.com (Postfix) with ESMTP id 6EBCC3F7085;
	Thu, 15 Feb 2024 08:16:15 -0800 (PST)
From: Elad Nachman <enachman@marvell.com>
To: <huziji@marvell.com>, <ulf.hansson@linaro.org>, <adrian.hunter@intel.com>,
        <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <enachman@marvell.com>
Subject: [PATCH v2 0/2] Fix PHY init timeout issues
Date: Thu, 15 Feb 2024 18:16:11 +0200
Message-ID: <20240215161613.1736051-1-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 9mdM5BoGD5ZAA_7IrjU_vhaJTdr82g34
X-Proofpoint-ORIG-GUID: 9mdM5BoGD5ZAA_7IrjU_vhaJTdr82g34
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_15,2024-02-14_01,2023-05-22_02

From: Elad Nachman <enachman@marvell.com>

Fix PHY init timeout issues:

1. Clock Stability issue causing PHY timeout

2. Timeout taking longer than needed on AC5X.
   Solve by constantly testing the PHY init bit
   until it toggles, but up to 100X timeout factor.

v2:
    1) convert polling loop to read_poll_timeout()
       for both patches.

Elad Nachman (2):
  mmc: xenon: fix PHY init clock stability
  mmc: xenon: add timeout for PHY init complete

 drivers/mmc/host/sdhci-xenon-phy.c | 48 ++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 9 deletions(-)

-- 
2.25.1

