Return-Path: <linux-kernel+bounces-119614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACFB88CB16
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69282324B28
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4C41CFB5;
	Tue, 26 Mar 2024 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BmT2AVle"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4791C6A0;
	Tue, 26 Mar 2024 17:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711474614; cv=none; b=bpoOMGD+ZKJFkyIGvWsOCZdgncT5j2iAE4ejb9oLweN+zrrxEP/ZIhOpX9C/wK87If5BTzWTxRrfqfczFknE8r811YsFnDgYTJwnpbPCPDLGWeMQNnRrsKNvzziRnP1WqYrpSoEi9GPUgc8BmUdem0xkxcSqF6rShrgsHhGNM28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711474614; c=relaxed/simple;
	bh=2/itiDg6w2I8VbMpyk7sVomDyd+Cy9H6eOgIPi/lCsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tyy9n07I9wr0iHGnljW6A2dnYkhusSQTrHRZwzzZTg0pdBjLhQKm+1n2UhzDEU26BrJX2Jr4o2EnDhduT+Kyun81EOEDAMMpdslebvhQPuTXsifB1+SJeTsExiGJZadLcp0EGT7exvXX4l9oK3TI/zN+gCkUJcgfxtGwbuGBhuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BmT2AVle; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42QHalIf020700;
	Tue, 26 Mar 2024 12:36:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711474607;
	bh=d8uiMeJr+LPBPe7uhP++AemudgMk5YWiqD65Iq3anlk=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=BmT2AVleKozadQz8WqKpVIr+d7zT5MR/8utq/NdBqIhleHtbKctIQ+HCuU42AGrq/
	 nDfHp0CBtmA44MaulghKLBndZwl3qmRU+KT7P7AkVgLA+n8e/VHSi6cbkAOKVAAmit
	 s4XL/KpUhpOzuWs8JlYwbLNaAknKOWbP10qB39Ig=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42QHalsk057223
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 26 Mar 2024 12:36:47 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 26
 Mar 2024 12:36:47 -0500
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 26 Mar 2024 12:36:47 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42QHakSv056686;
	Tue, 26 Mar 2024 12:36:46 -0500
Message-ID: <ceb391d3-c7f4-4d46-9f97-b651e1f5451c@ti.com>
Date: Tue, 26 Mar 2024 12:36:46 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] uio: pruss: Deprecate use of this driver
Content-Language: en-US
To: Robert Nelson <robertcnelson@gmail.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Drew
 Fustini <drew@beagleboard.org>, Tony Lindgren <tony@atomide.com>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240325210045.153827-1-afd@ti.com>
 <2024032631-excursion-opposing-be36@gregkh>
 <CAOCHtYjauA+BAxZJBMTaxxaMGcvipP9=ZPeWe4FiNFs_jpq6dg@mail.gmail.com>
 <ZgME0qSL3KXCD07I@chinchilla>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <ZgME0qSL3KXCD07I@chinchilla>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 3/26/24 12:24 PM, Matthijs van Duin wrote:
> I'll write a more in-depth reply when I have a moment, but right now I'd
> like to point out that the uio-pruss driver in mainline linux is for the
> pru subsystem on the freon/primus family of ARM9-based SoCs (OMAP-L1xx /
> AM17xx / AM18xx / TMS320C674x / DA8xx), which is not currently supported
> by remoteproc-pru.
> 

I'll wait for your full reply, but a quick note, for those devices listed
this driver isn't usable either after they all moved to DT. As this driver
never got a DT port and relies on platform data (which is gone for those
couple devices).

Andrew

