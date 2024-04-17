Return-Path: <linux-kernel+bounces-147878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D04708A7ADF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 712ED1F2198E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 03:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF90F79D8;
	Wed, 17 Apr 2024 03:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="M1uEL4WU"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF086FB9;
	Wed, 17 Apr 2024 03:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713323363; cv=none; b=nFj2gkjP0lecWF4VrPxGu6pMTU6Ick5ZfQ9v0fENJgZRHxqhnP7r9KBUbWJSut05g9VkH/b8PvYwelW1VTGHBWqTxX17S5wZ0Y0EzthJV5pCn2aqbmDmtr2bKlTrVfiabZxcw/E6LZMsKeiRD06xE8P7tBnsRe4q+Eciwj12VZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713323363; c=relaxed/simple;
	bh=3qrfbpId+r+8Pf56kTzyLtPFA5qAA/c1McUZnD127z8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XhIhkT4VuIBrKOXOUO3/LEqeFYD+1rFjr+9sCThNtYL5jcC0K+pPSzxkkSxUI+lde8CLmPTIBpapwTpfbfW3bEcr8HdcQ7+ilUsT9hQ/HvcCBvhHpyavzsb1ruYFNO3P6XbGrSHwm4c6gHKVHHUR1L+PUZZ8IVT43i9BmCPyL8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=M1uEL4WU; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 4C7BEC0000F3;
	Tue, 16 Apr 2024 20:09:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 4C7BEC0000F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1713323360;
	bh=3qrfbpId+r+8Pf56kTzyLtPFA5qAA/c1McUZnD127z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M1uEL4WUlLeeDhxMz4z3huKUT5tnuc+Ky3AnUO0dy8IPNb5moDNCAVZiCnbxcUI8I
	 E6ArlXfbcdp/VGjqGqHA/9WBvgcUT+HfAVDElbLOQjNFVN1ygtnu92wbjOZNt4pxQZ
	 0Kk8blBEB6MFx30IFhdhLWuEF994B/sF0xJXE7Hk=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 55B9718041CAC4;
	Tue, 16 Apr 2024 20:09:18 -0700 (PDT)
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
Subject: Re: [PATCH 1/4] ARM: dts: BCM5301X: use color and function on ASUS RT-AC3100 and RT-AC88U
Date: Tue, 16 Apr 2024 20:09:19 -0700
Message-Id: <20240417030919.919118-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240414-for-soc-asus-rt-ac3100-improvements-v1-1-0e40caf1a70a@arinc9.com>
References: <20240414-for-soc-asus-rt-ac3100-improvements-v1-0-0e40caf1a70a@arinc9.com> <20240414-for-soc-asus-rt-ac3100-improvements-v1-1-0e40caf1a70a@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Sun, 14 Apr 2024 20:01:21 +0300, Arınç ÜNAL via B4 Relay <devnull+arinc.unal.arinc9.com@kernel.org> wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> As the label property for LEDs is deprecated, use the color and function
> properties to describe the LEDs on the device tree file for ASUS RT-AC3100
> and ASUS RT-AC88U. Reorder the LED and button nodes in alphabetical order.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian

