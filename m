Return-Path: <linux-kernel+bounces-147887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E27BA8A7AF4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 990751F237F5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 03:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3289849C;
	Wed, 17 Apr 2024 03:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GqMbTzDv"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A84EAD7;
	Wed, 17 Apr 2024 03:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713323802; cv=none; b=MRxY25jo92TUA0VrWk2Fjw5uVfx3WpqkuK+65C4cQETH/UXfG5ZGzAWTFUJRLpZ3A8T1nK+tzdF2D+S6p8cKKLs5zENMLBRcAdqScsbHnjnVIPrTb6iGKNKgHMdM3ND8JsiE/ry+0S8qsqkJ6j2KybXezh5tHV9+pFSjErN39Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713323802; c=relaxed/simple;
	bh=298P4mdRpA1gJFHU3AOHwV+eJpPTEaIu8zf52O1eOjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EdYx7EsY3vq5Z2P9TuzZCLHpcXuGVAFfZrxhVXs3Zg/rfl/zeeJMjbMkRoydtPxwVhmzr+I7/ieoIXqBdLYyeKhWXS+dJ3zLN2U5tsHS5ezxCjZXIzaMgxbmanlhk0y4qaWKyIOFeAVSasrnhL0nyi9iw1Kva5GI9kUIwPM6P+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GqMbTzDv; arc=none smtp.client-ip=192.19.144.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 711C5C0000F3;
	Tue, 16 Apr 2024 20:10:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 711C5C0000F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1713323454;
	bh=298P4mdRpA1gJFHU3AOHwV+eJpPTEaIu8zf52O1eOjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GqMbTzDvaiGR0R9IuUPhKDMB+B0tdF1DyFq7z3CxnzWueEg/YjaC6jPoXjjL4rKxV
	 APlzffN0g09/9kznYXVSn98XzAegXepkRl8fpvUS1Fxh+HxZw8uozol/IinDMw04I9
	 0v3l1oZrmhBEJhIdOEFmzDHQBTgXhVE81/IKzoJ8=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 7FA6818041CAC4;
	Tue, 16 Apr 2024 20:10:52 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	=?iso-8859-9?b?QXL9bucg3E5BTA==?= via B4 Relay <devnull+arinc.unal.arinc9.com@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	=?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?iso-8859-9?b?QXL9bucg3E5BTA==?= <arinc.unal@arinc9.com>
Subject: Re: [PATCH 3/4] ARM: dts: BCM5301X: remove duplicate compatible on ASUS RT-AC3100 & AC88U
Date: Tue, 16 Apr 2024 20:10:53 -0700
Message-Id: <20240417031053.919389-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240414-for-soc-asus-rt-ac3100-improvements-v1-3-0e40caf1a70a@arinc9.com>
References: <20240414-for-soc-asus-rt-ac3100-improvements-v1-0-0e40caf1a70a@arinc9.com> <20240414-for-soc-asus-rt-ac3100-improvements-v1-3-0e40caf1a70a@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Sun, 14 Apr 2024 20:01:23 +0300, Arınç ÜNAL via B4 Relay <devnull+arinc.unal.arinc9.com@kernel.org> wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> The compatible property on the node with the srab handle is already
> described with the same value on the included device tree. Remove it.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian

