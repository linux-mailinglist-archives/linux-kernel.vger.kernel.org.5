Return-Path: <linux-kernel+bounces-139171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6441589FF75
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4BD0B21D9E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6945D1802A2;
	Wed, 10 Apr 2024 18:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KwJ1KK9/"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CE617F36E;
	Wed, 10 Apr 2024 18:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712772680; cv=none; b=pqtdY08QqPMUJk005Zw9RXqzoJYr1VVlaY7DLBk3csKQ8BVm3hLLejyWjsXzhDx9XsTUbjAYOdJ2T7V2uSbrBCZUO2dNj07u/Dlpf8bbklpxx6tDnyoLUt93OoO1Lnbqfv8UkuVRyLo5r6oaqzUh56KQ72OiZcE5UAWhGk1AA50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712772680; c=relaxed/simple;
	bh=dMLXJDpVj5P7B6BLkAnsonc4NeXSB+v6Af+GijKItIw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g79Fd5fXY6tCM21/CY4YdprgK3QbA9KfKKjRaVIJTfirkUxDJRXEx9y59WKhijZDeOkqG64EPFm6eWjFNh8gWozsDOgYdpvIXMPMPRJFEX21oaEta+lMrsJsRiH+FIY0lwzl11nrlvk1AF0Tlp5dpCfqM/+LzIknygHQemMEi/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=KwJ1KK9/; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43AIBEZa106752;
	Wed, 10 Apr 2024 13:11:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712772674;
	bh=qifAJ66iv4CCCsPaQ2eLsTQrNfQLePSXrjwNwfvyqQ8=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=KwJ1KK9/+d3CxTZoPNnp8sG7PJNXGR0SFHMgSitP2/iA64vxGWO1I9iidXWb1tYDM
	 znn8mvSuiBCstyssZQ3SPy/aoeznYaVeSHLAp6GzjtL/AcctbOavJPjj0nmB8Am6yO
	 tGW/VZGmufShKtCIwlz5FHezBJ0b9wxhawh2ZmFc=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43AIBEnw100645
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 10 Apr 2024 13:11:14 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Apr 2024 13:11:14 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Apr 2024 13:11:14 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43AIBD7H034530;
	Wed, 10 Apr 2024 13:11:13 -0500
Date: Wed, 10 Apr 2024 23:41:12 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Tony Lindgren <tony@atomide.com>
CC: <linux-omap@vger.kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] bus: ti-sysc: Drop legacy quirk handling for uarts
Message-ID: <20240410181112.6id36j7iysw7memz@dhruva>
References: <20240410064010.57142-1-tony@atomide.com>
 <20240410064010.57142-4-tony@atomide.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240410064010.57142-4-tony@atomide.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Apr 10, 2024 at 09:40:07 +0300, Tony Lindgren wrote:
> With the 8250_omap and omap-serial drivers no longer relying on the use
> of pm_runtime_irq_safe(), we can finally drop the related legacy quirk
> handling for uarts.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---

LGTM!
Reviewed-by: Dhruva Gole <d-gole@ti.com>


-- 
Best regards,
Dhruva

