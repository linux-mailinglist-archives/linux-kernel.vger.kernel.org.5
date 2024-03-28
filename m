Return-Path: <linux-kernel+bounces-122712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B16C88FBEB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BD1F1C2EA00
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D7E4657B0;
	Thu, 28 Mar 2024 09:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kWVoI4Rg"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBAE651B6
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619061; cv=none; b=REeXhSRSNiv44/XxFDDlPtQ7eue7M5qIdLN5elDebX7ITZ/Z+XadR7G9/LJwW6sAA5HLC/sb9nZHI+A1FO6F+2CQ9iZOQL8BfAKUu7o6/X7UUrGI6KI/0VC63eQ2Koa1LhZJ1qGivt4FV4U7t+5FuB2tN9GB7uWa8TgwvaDJbrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619061; c=relaxed/simple;
	bh=E4KSI2z4NsbbxgslmGhAAaQ2+Yf3DfNL6llAanuCxVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f574Rb3/DevDeAVLb1VRjfzxLIAQk9fc4/sh7REw7uHDVj94Du7zY0BoLqO9TY5+uzuV/dpuHT2jWzVpxe+xc8DHxNVk8Mj+Sf+M0FQI1qgYf9yqpcYXU+qwHsCPHDZrzeGD3VeHbxSs73bzA5jL4Tzq18UepeEAw/Pb3UBUdn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kWVoI4Rg; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711619058;
	bh=E4KSI2z4NsbbxgslmGhAAaQ2+Yf3DfNL6llAanuCxVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kWVoI4RgEt4wpKCdm4aOsE22srRrZSElG2wK9g28o0jMF0AseSBhPrgLR8vHK4VDW
	 Zp5Og3h7gcE+At2mLFZD6gmotinMQ9Nu/EKpIbaF0RHpJehtY0WyynTYy6Dj/E7r9h
	 HRf2dNHaa546sD1nV+nMnM4rTOhpoBKLSP0U00LfycapVLif3rcmLUklcb1nray1Jv
	 oKxEuDwrOfLBkp2Ln0JqbZe2vFu6DhNP/5iwCSof6ELQFsxNy4qSPcq+vpXK0bEqcq
	 7qWvylDukwcphS/4foQ8l2/aY5nVRhwo3FLrLmXtTzSwpYKgjZCV1Z97ga5Wi0iZf0
	 ahpzjI4vkp17A==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2BD613782112;
	Thu, 28 Mar 2024 09:44:18 +0000 (UTC)
From: Laura Nao <laura.nao@collabora.com>
To: laura.nao@collabora.com
Cc: tglx@linutronix.de,
	kernel@collabora.com,
	linux-kernel@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [REGRESSION] mainline boot regression on AMD Stoney Ridge Chromebooks
Date: Thu, 28 Mar 2024 10:44:33 +0100
Message-Id: <20240328094433.20737-1-laura.nao@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240322175210.124416-1-laura.nao@collabora.com>
References: <20240322175210.124416-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Thomas,

I ran a manual bisection to track down the root cause for this 
regression and landed on the c749ce commit from this series:
https://lore.kernel.org/all/20240212153625.145745053@linutronix.de/

Do you have any insight on this issue or any suggestion on how to
effectively debug this?

Thank you!

Laura

#regzbot introduced: c749ce393b


