Return-Path: <linux-kernel+bounces-90363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3565386FE20
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0FA2B231E2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F1A249F1;
	Mon,  4 Mar 2024 09:56:10 +0000 (UTC)
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1303222625;
	Mon,  4 Mar 2024 09:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709546170; cv=none; b=eyvnlA8xdNLhTQpFpRCYtk6g/eD5HOgM75tOSC4xnU/o1lzpQtRbBtlt6wULidP0B1V4y/ggh12HX/paMuq1ucMW3GCRol1rxqHVkMDyZki2OrJSo/o38q/UXTLnPbWw69iix5UNnM7PMAIAF9cOobs4PSB+FQuEZBQ2Lo1gD0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709546170; c=relaxed/simple;
	bh=ZLWxTNvadb4hyjem5uvWUCn8AIITYg1bzbW2sx4kDIU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VmxLrt77IMoeUY2qkIz3+7oisEL+K31WkhvM2pamcxdR9XRYEus5nsg/YRBrZ+Iz12S4ubuR90bTsrlBB7q/ZKg6W74iiEKBPuOf516eJhqfnMuqbc1xTs7oO47EOvhQWP1G1AJXHCSmaB9s9T8Hk+FW7LpPLgTJMI6n2WgMShA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
From: Daniil Dulov <d.dulov@aladdin.ru>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <stable@vger.kernel.org>
CC: Daniil Dulov <d.dulov@aladdin.ru>, Vinod Koul <vkoul@kernel.org>, Bard
 Liao <yung-chuan.liao@linux.intel.com>, Pierre-Louis Bossart
	<pierre-louis.bossart@linux.intel.com>, Sanyog Kale
	<sanyog.r.kale@intel.com>, <alsa-devel@alsa-project.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH 5.10/5.15/6.1 0/1] soundwire: stream: use consistent pattern for freeing buffers
Date: Mon, 4 Mar 2024 12:55:41 +0300
Message-ID: <20240304095542.4799-1-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-2016-03.aladdin.ru (192.168.1.103) To
 EXCH-2016-01.aladdin.ru (192.168.1.101)

Svacer reports NULL-pointer dereference and double free issues in
do_bank_switch() in case sdw_ml_sync_bank_switch() returns an error
not on the first iteration of the list_for_each_entry() loop. These 
problems are present in 5.10, 5.15 and 6.1 stable releases. These problems
have been fixed by the following upstream patch that can be cleanly
applied to 5.10, 5.15 and 6.1 branches.

