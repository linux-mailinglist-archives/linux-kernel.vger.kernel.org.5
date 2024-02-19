Return-Path: <linux-kernel+bounces-71095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5977B85A090
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16C152833C6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B549125635;
	Mon, 19 Feb 2024 10:09:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369AE25601
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 10:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708337370; cv=none; b=iTrE23T1IpLxj7DgkBWce/GN43JN8kNeX5dbDzzWyNBq2BuJ5DzM97PKkJpj6CRvLfxAUk7rIe7abyzw3m80BOdiLnfe0Zuxkq83CFCBg9YPSDsSGqlDQMf0MmQj9cjBo6l1zOU/ljWKVma6tUcSL07jMUbUod0EepT+X7xis48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708337370; c=relaxed/simple;
	bh=l9jnpS5fEMTzqbm0IIV1WtUjhRNFkMv2EvaLgdWJNNw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V+wCnS7ZQ24E+57zoJyqQ3+diP0alNdrfM/IW7z6C/1GIWP5z+QF8UzoXAayC1LzXuEpMNvor/FGPbW+jyW7VOROrXjuIvbTU58NN4vDBlxAIWO3YXqdvSIvpLOgLih3BoNQnCNFeOoGbsMc9F8Ws5zWaq5ImnXIDbRT2mk8wC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45C331FB;
	Mon, 19 Feb 2024 02:10:07 -0800 (PST)
Received: from a077854.blr.arm.com (a077854.arm.com [10.162.41.80])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B992E3F762;
	Mon, 19 Feb 2024 02:09:24 -0800 (PST)
From: Faiz Abbas <faiz.abbas@arm.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: liviu.dudau@arm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	Faiz Abbas <faiz.abbas@arm.com>
Subject: [PATCH 0/3] Fixes for the komeda driver
Date: Mon, 19 Feb 2024 15:39:12 +0530
Message-Id: <20240219100915.192475-1-faiz.abbas@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following patches add fixes to the komeda DPU driver.

Patch 1 fixes an issue where the crtc always expects both pipelines to
always have remote nodes populated.

Patch 2 is a cosmetic fix that ensures komeda does not print verbose
pipeline information unless the entire pipeline is actually up.

Patch 3 adds a 40 bit DMA mask for each pipeline.

Amjad Ouled-Ameur (1):
  drm/arm/komeda: update DMA mask to 40 bits

Faiz Abbas (2):
  drm/arm/komeda: Fix komeda probe failing if there are no links in the
    secondary pipeline
  drm/arm/komeda: Move pipeline prints to after the entire pipeline has
    been enabled

 .../gpu/drm/arm/display/komeda/komeda_crtc.c  | 45 ++++++++++++++-----
 .../gpu/drm/arm/display/komeda/komeda_drv.c   |  4 ++
 .../gpu/drm/arm/display/komeda/komeda_kms.h   |  1 +
 .../drm/arm/display/komeda/komeda_pipeline.c  |  4 +-
 4 files changed, 41 insertions(+), 13 deletions(-)

-- 
2.25.1


