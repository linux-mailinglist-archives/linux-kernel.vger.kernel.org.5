Return-Path: <linux-kernel+bounces-157430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C017E8B1192
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88269B24A5B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5AF16D9B7;
	Wed, 24 Apr 2024 17:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="qNDjdfiF"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6AD16D4FB;
	Wed, 24 Apr 2024 17:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713981560; cv=none; b=Hs0KeWWV+XE7mpD8tnzaqprEL54Mwli/JfhxQ7p4sQWksXAOoX2I4t+7w7XlmIiTSL4a6Z1QydWxIejCxYnYiknCw5quflr0ICwqVuolqSI2tMglPP4mjFbFlm9Tk5UukOZMtGbjOIGAyPXtV/7rq4ih7Sfm/0R8Xhqs4lAjZe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713981560; c=relaxed/simple;
	bh=A77P7UGOqlPJPXGQY3r1Zpku7cD6D7yB1cNplfmIq2I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SldiX7nddvaoiLmDgtQQlJtL5R2xBzSTVEZTXwdzLEdxQLA4VqUpJ3XImSGDZ16dnPNhp7XTbLlj2Ty3mpiLLKIlpSKK7N44rKJ+ojLRHtv0gxyvItWfAyQYOBhtpJqSpmDNlKSAfAoH3lppLbSvXCOx4d1XR0Xyk/MlMhnZGNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=qNDjdfiF; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 3EEB3C004D12;
	Wed, 24 Apr 2024 10:59:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 3EEB3C004D12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1713981558;
	bh=A77P7UGOqlPJPXGQY3r1Zpku7cD6D7yB1cNplfmIq2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qNDjdfiFHU5xWqE3hyrMMEi8+2TDyrmNktiyObid++AJoEz/VGIcy5nC/gRO34khQ
	 9DvhOdz9CdYD0+5OpNoL/IPv2vojiPJBQTpqTG+YCJCeI2PThRTGD5uB8ylgiXh09d
	 oJZlEgm0BdKEhKSxnB5h5MmqTWJGnCLdhsUVXBz8=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 4E80E18041CAC4;
	Wed, 24 Apr 2024 10:59:16 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: bcm-kernel-feedback-list@broadcom.com,
	=?iso-8859-9?b?QXL9bucg3E5BTA==?= via B4 Relay <devnull+arinc.unal.arinc9.com@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Hauke Mehrtens <hauke@hauke-m.de>,
	Rafal Milecki <zajec5@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Tom Brautaset <tbrautaset@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	=?iso-8859-9?b?QXL9bucg3E5BTA==?= <arinc.unal@arinc9.com>,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 2/5] dt-bindings: arm: bcm: add bindings for ASUS RT-AC5300
Date: Wed, 24 Apr 2024 10:59:17 -0700
Message-Id: <20240424175917.1526848-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423-for-soc-asus-rt-ac3200-ac5300-v3-2-23d33cfafe7a@arinc9.com>
References: <20240423-for-soc-asus-rt-ac3200-ac5300-v3-0-23d33cfafe7a@arinc9.com> <20240423-for-soc-asus-rt-ac3200-ac5300-v3-2-23d33cfafe7a@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Tue, 23 Apr 2024 12:50:46 +0300, Arınç ÜNAL via B4 Relay <devnull+arinc.unal.arinc9.com@kernel.org> wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Add ASUS RT-AC5300 under BCM47094 based boards.
> 
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian

