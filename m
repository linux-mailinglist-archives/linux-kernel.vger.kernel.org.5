Return-Path: <linux-kernel+bounces-59741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD9884FB1F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0D3328770C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 17:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E8C7EF09;
	Fri,  9 Feb 2024 17:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="A+TGZY+V"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4232853398;
	Fri,  9 Feb 2024 17:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707500135; cv=none; b=rF/lJQXP8zRD03MFkpBBJ02GXdGWDo7mSj1bwqLjdSL/OVSWKnefqygoTHaTvvBrVIy3eUsR2Op2RKPC57eFrAofBn/SVWwyn4odXeIL4c6SNay5jAXBohCx4rwkHwNGSn7aHeYRfk1kYdBWowsGQ3z7OW3OMILGRlK/SX0ahOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707500135; c=relaxed/simple;
	bh=L7LVF0xgSx/tkSIKccTfmZ8enVLgMwrvXD7JYedesak=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LSGzCtGT33ZA8aO+8E2B77Wu1l95sAOQQGbvqiIU/RkYwaPOUEb3+TNdLCi4IZb9LhZe+Yg3bsvMxsJbUSB8raXwdrZ+boRmT8iqeN2ftof70J2nGkgG5oUOdL+Cin0ph+lxkYXUGQHXcwkEmgL1Ev0yK2mI/pPEyhs3ScArPIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=A+TGZY+V; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 419HZI1Z110129;
	Fri, 9 Feb 2024 11:35:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707500118;
	bh=u1wp8/LboIEGg7Ak8EZDY4zBL+bnAzpumV/bqdbzzrc=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=A+TGZY+V93KJK+E+iweZnKfY4drbX/7o2P35KJmiSVbg6Z7ktF6bvCyd66ZW6SHoW
	 9+TEQ8cDbVic2UxSWAaz6WK0SgyDWzb7BXPiok+Lx4rDjVtQT5t45IE7h3nf7B+OvC
	 ajH55OpUOu2aFsugWwn/fy9AghFy/+eIy0ciBzec=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 419HZIcC010482
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 9 Feb 2024 11:35:18 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 9
 Feb 2024 11:35:17 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 9 Feb 2024 11:35:17 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 419HZHa6069048;
	Fri, 9 Feb 2024 11:35:17 -0600
Date: Fri, 9 Feb 2024 11:35:17 -0600
From: Nishanth Menon <nm@ti.com>
To: Bhargav Raviprakash <bhargav.r@ltts.com>
CC: <linux-kernel@vger.kernel.org>, <m.nirmaladevi@ltts.com>, <lee@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <jpanis@baylibre.com>,
        <devicetree@vger.kernel.org>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <vigneshr@ti.com>, <kristo@kernel.org>
Subject: Re: [RESEND PATCH v1 01/13] mfd: tps6594: Add register definitions
 for TI TPS65224 PMIC
Message-ID: <20240209173517.i67qttasxjum7oek@strum>
References: <20240208105343.1212902-1-bhargav.r@ltts.com>
 <20240208105343.1212902-2-bhargav.r@ltts.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240208105343.1212902-2-bhargav.r@ltts.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 16:23-20240208, Bhargav Raviprakash wrote:
> From: Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>
> 
> Extend TPS6594 PMIC register and field definitions to support TPS65224
> power management IC.
> 
> TPS65224 is software compatible to TPS6594 and can re-use many of the
> same definitions, new definitions are added to support additional
> controls available on TPS65224.
> 
> Signed-off-by: Nirmala Devi Mal Nadar <m.nirmaladevi@ltts.com>

You've got to Sign-off as part of recommendations read [1]


[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst#n451
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

