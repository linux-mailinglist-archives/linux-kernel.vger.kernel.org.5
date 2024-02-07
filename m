Return-Path: <linux-kernel+bounces-56504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDF084CAF5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3339B26E01
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A8376035;
	Wed,  7 Feb 2024 12:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yTcug6xl"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CD658AD0;
	Wed,  7 Feb 2024 12:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707310555; cv=none; b=gHAY+cHz4b+ryjxupwoGp1AMaAlL6qco2vAL4eAZdO5ynrifcntAPfrV2jNh2x0rRYlWvKTlJggRNZm5sx7APDdQduXLNGwXdn/JL+MuUWsP1pQGmWxYgtaBBCFMEEvt6dihX5eTLBfAlppNcF5DSuArg9CqNEl5aBmpoxRc64c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707310555; c=relaxed/simple;
	bh=86CEiR8Qk2LPFxdR8IR7g3c2tfkCJKLqr7f8uVBnOYo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1BPYpBwnUr+5ukTNZbm1VHIxkSgbvOhi9sEg5WLqiuZt4djc4E2Zg7RbqPOEeAmvJldCfKuhWX9MZeu5t7sEcqYZzBJ6neRaxB/ppFryGxzlgxsWViyD4QrdaJ/lmxDBGyYvla/Fc60EMIjzsjwWYZB79IOQyN7PoJJv2x/xxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yTcug6xl; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 417CtlLt054165;
	Wed, 7 Feb 2024 06:55:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707310547;
	bh=IKNk9oQWotkMzJk2/nGT+Z2XUGF4Q+T0Q2x6YfjgH2s=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=yTcug6xlHMHPDXMQGzhJQiqZKDMv0R6y9jzmQgbX3N7xgDuLHK0qVlXpUuB6z0M9F
	 kTo1aoqK0eBD8aVL82MYPVEqrAnKID1hCsm4vk4p6s/RxsiMfwXHe8WngO1QFyX32g
	 rrv7BSE3JR6aHb0ZZGtjmhWFeg+XtTo18AGhpVjA=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 417Ctlw8091263
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Feb 2024 06:55:47 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Feb 2024 06:55:47 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Feb 2024 06:55:47 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 417CtliX032776;
	Wed, 7 Feb 2024 06:55:47 -0600
Date: Wed, 7 Feb 2024 06:55:47 -0600
From: Nishanth Menon <nm@ti.com>
To: "Kumar, Udit" <u-kumar1@ti.com>
CC: <sabiya.d@mistralsolutions.com>, <vigneshr@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linus.walleij@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Dasnavis Sabiya <sabiya.d@ti.com>
Subject: Re: [PATCH V2 0/2] Add CAN and OSPI support for AM69-SK platform
Message-ID: <20240207125547.fet53fd26g4cjnpm@operate>
References: <20240205200744.216572-1-sabiya.d@ti.com>
 <d490d4cb-fb42-4189-b992-ba46be404137@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d490d4cb-fb42-4189-b992-ba46be404137@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 14:45-20240207, Kumar, Udit wrote:
> Thanks Sabiya
> 
> On 2/6/2024 1:37 AM, sabiya.d@mistralsolutions.com wrote:
> > From: Dasnavis Sabiya <sabiya.d@ti.com>
> > 
> > Hi All,
> > 
> > This series adds support for the below interfaces on AM69-SK platform:
> > -  CAN support on both MCU and MAIN domains
> > -  OSPI NOR flash support
> > 
> > v2: Changelog:
> > 1) Removed CAN interface aliasing.
> > 2) Updated bootph property on the leaf nodes.
> > 
> > Link to v1: https://lore.kernel.org/lkml/20240118153524.4135901-1-sabiya.d@ti.com/
> > 
> > Dasnavis Sabiya (2):
> >    arm64: dts: ti: k3-am69-sk: Enable CAN interfaces for AM69 SK board
> >    arm64: dts: ti: k3-am69-sk: Add support for OSPI flash
> 
> Series LTGM

If that is an Reviewed-by, please add tag.
> 
> 
> >   arch/arm64/boot/dts/ti/k3-am69-sk.dts | 162 ++++++++++++++++++++++++++
> >   1 file changed, 162 insertions(+)
> > 

Please CC linux-arm-kernel mailing list and resubmit.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

