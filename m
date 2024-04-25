Return-Path: <linux-kernel+bounces-158629-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE50E8B233B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84B6A1F2251F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9EE149C7B;
	Thu, 25 Apr 2024 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="i/i3e+Xe"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F49149C79;
	Thu, 25 Apr 2024 13:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714053386; cv=none; b=lE7a6BQ3vS+o3Rjv6bHidBIuSfIrREfe9dkHH4uuVHo9Tu2fceQONG9TpWFZVV12Y+kTZuMrIgmx+C1yhm0bnDT2nGc26J6BVDioxpUyZIL5mvwGUzzaRdPmEVAGnPGPiWC+yXfTX34EzxGLV1tlEBJg30Sx1vPJ7iGPh+Qb2wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714053386; c=relaxed/simple;
	bh=trRlCRIhok4K59HDr3TSHDjRs6Ztr8A4LtpNXzJMUDo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ErAV/EwKl38IgY7DYe5ZZEBjb9E/pWx9V9kDvI38WhA8B2qZwHGTdm4/WqT4goBOspy54vTY8vUs+YsJBl+GTKlnBDKLPoJLtcxMJsmQLdXHsjhnJk6/EIlD3gx5AqPtF9d/KIYyyjRV0k56DywijBUG07Pd9XjWI0gambB3ybI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=i/i3e+Xe; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43PDuBeW046241;
	Thu, 25 Apr 2024 08:56:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714053371;
	bh=gH0LZfwLoD7Vua+dAHDFyt7sRvRv22zG5/DbbbrI7hM=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=i/i3e+XewVr69cwoI8dAEQWSZd87IpQQaaa5GkT9EowRLKxSIq5PjM+i+CwdGVB+z
	 q7i3wzPiCOiJatXCpKneLFIVqraIt3bpADvP2cw6ZZrQHFOaEflbwoASJPAH82/f3M
	 phNB+Lkwih1Lv7e1vt9fi+6ONYqshA3hC/bHcitM=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43PDuAhX121733
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Apr 2024 08:56:10 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Apr 2024 08:56:10 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Apr 2024 08:56:10 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43PDuAxi025299;
	Thu, 25 Apr 2024 08:56:10 -0500
Date: Thu, 25 Apr 2024 08:56:10 -0500
From: Nishanth Menon <nm@ti.com>
To: Andrejs Cainikovs <andrejs.cainikovs@gmail.com>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andrejs Cainikovs <andrejs.cainikovs@toradex.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] arm64: dts: k3-am625-verdin: enable nau8822 pll
Message-ID: <20240425135610.6c6ysoejefuazm63@privatize>
References: <20240418105730.120913-1-andrejs.cainikovs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240418105730.120913-1-andrejs.cainikovs@gmail.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 12:57-20240418, Andrejs Cainikovs wrote:
[...]

> Signed-off-by: Andrejs Cainikovs <andrejs.cainikovs@toradex.com>
> ---
> This patch requires https://lore.kernel.org/all/20240409121719.337709-1-andrejs.cainikovs@gmail.com/ to be applied,
> if not the audio will just stop working because no code will ever enable the required clock to the codec.

Thanks. lets wait for the dependency patch to be merged to master, and
once done, please resubmit this patch. I am going to guess for the next
cycle.
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

