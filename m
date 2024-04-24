Return-Path: <linux-kernel+bounces-157429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8698B1190
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55BA4B241FE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECCB16D9C5;
	Wed, 24 Apr 2024 17:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SKuMQCjf"
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A4E13C672;
	Wed, 24 Apr 2024 17:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713981552; cv=none; b=s3h1144XhxG8ddUYwUvVsnFJ+IpKognlodgcCWL7LRcv4J5ctbcPpnXxXT08LhJ3BeIoAVyWPu0lksDW6B0B6JTqsdk6uMVVphF6gHVUsUDMEvIGL6Pg30IpBGCKNro0bSQMhuLvwZV9Hff5PhJWdiGAm4xZrX/Z+6o2tNaBAFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713981552; c=relaxed/simple;
	bh=Uvo8L2oKNvPS/82Qykx5/RwOPOJlTRBGJtWHyAljGoY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N3gA0HtjQ/WcT2PtCP3u6uTZccTmR8j1Rjs6E4I5rLZgh5XEAwLRjfmggmzCMXlaBE3UPb5XDcxRWfhQIzSxpYxC7KRZoivRhZai2PcYSB6VXus50cU8ojYDy38Ng6MJno0oCWrstlMbQILhrejFq/IF7y1BcJ+BK3DhtR7pk3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SKuMQCjf; arc=none smtp.client-ip=192.19.144.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id A7741C004D03;
	Wed, 24 Apr 2024 10:59:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com A7741C004D03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1713981549;
	bh=Uvo8L2oKNvPS/82Qykx5/RwOPOJlTRBGJtWHyAljGoY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SKuMQCjf6SFHNgGBHHn5/RRaQOuG0SRw1UmiCgVOn/P/wiT5T9E2oSZ0snYuFkt6T
	 ndwA9KIAnT/+H5EUyX0uMOS+pfXZ2M3u6WItaVHKMUMhvHl8xx/ZbU0HKJmOsLzEma
	 A/VeGr3ZrK3EttkXjrIuLknLtcTK/BkATUorQYXs=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id AE32518041CAC4;
	Wed, 24 Apr 2024 10:59:07 -0700 (PDT)
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
Subject: Re: [PATCH v3 1/5] dt-bindings: arm: bcm: add bindings for ASUS RT-AC3200
Date: Wed, 24 Apr 2024 10:59:09 -0700
Message-Id: <20240424175909.1526760-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240423-for-soc-asus-rt-ac3200-ac5300-v3-1-23d33cfafe7a@arinc9.com>
References: <20240423-for-soc-asus-rt-ac3200-ac5300-v3-0-23d33cfafe7a@arinc9.com> <20240423-for-soc-asus-rt-ac3200-ac5300-v3-1-23d33cfafe7a@arinc9.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Florian Fainelli <f.fainelli@gmail.com>

On Tue, 23 Apr 2024 12:50:45 +0300, Arınç ÜNAL via B4 Relay <devnull+arinc.unal.arinc9.com@kernel.org> wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Add ASUS RT-AC3200 under BCM4709 based boards.
> 
> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian

