Return-Path: <linux-kernel+bounces-52837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F924849D44
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3C581F2354E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66F032C1AF;
	Mon,  5 Feb 2024 14:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vznOIzCW"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048A22C1A3;
	Mon,  5 Feb 2024 14:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707144267; cv=none; b=qoA/CF36ZZpn8BHXiDIevjiaLIJzC76nCfMW+Pf5oJk6oNkmW2M7u6JBQUNco7nA7sY9WqArxvy3GxNPgkoXc9dncrzq5GVBf5/P56QP6P2qqpW82zLtc7wZ26Lg6DVEDAgRRdP9YVvFOpft/dqFu6SH9Whqx2WXwO4r+6C5CpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707144267; c=relaxed/simple;
	bh=QdE5XO1z+ZN2JUWva3tD0crieFT8WVbx2jzcJcMgouw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qpurpgGPTo04TRBRYA0hgv6xGXuGbfh+dz0qJSWAjSr4nOXrV67dPZZJ8YucIj4deca0jMumUtdqMeCFkM+0eiC/2CeltafGF8Tgd6oxPPWZjmqFZrax1aO5RRDLpP8xVFnsPSoxfLrlDgYVWbG0BLOeylzxZ662o1O8nd8Wdww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vznOIzCW; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 415EiIoH007466;
	Mon, 5 Feb 2024 08:44:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707144258;
	bh=R+IZhbouHeTBfhkol51yl3a65E5pUYRPm1UVLkEApAE=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=vznOIzCWeN3ld5XTmi6CuC0wRMfu+MIh58sW+fJE8rGfICIbGWmhsPh+PHNzTCtU3
	 +8dTbbN9SJh9k+x8BK/oVd9/IwgFmkNDvsZi4Uwxob6CBVl0Lc9/sgi5fvKyX80Ewl
	 fh5LN5Mw2UWmTucRQo5g/DVOXU2/XtZ1MUMhgvhc=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 415EiIBl001532
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 08:44:18 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 08:44:18 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 08:44:18 -0600
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 415EiHLG104241;
	Mon, 5 Feb 2024 08:44:18 -0600
Date: Mon, 5 Feb 2024 20:14:17 +0530
From: Dhruva Gole <d-gole@ti.com>
To: =?utf-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
CC: Mark Brown <broonie@kernel.org>, Apurva Nandan <a-nandan@ti.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Gregory CLEMENT
	<gregory.clement@bootlin.com>,
        Vladimir Kondratiev
	<vladimir.kondratiev@mobileye.com>,
        Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>,
        Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Subject: Re: [PATCH v2 0/5] spi: cadence-qspi: Fix runtime PM and system-wide
 suspend
Message-ID: <20240205144417.44jidulexgyccodv@dhruva>
References: <20240205-cdns-qspi-pm-fix-v2-0-c59ac6996428@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240205-cdns-qspi-pm-fix-v2-0-c59ac6996428@bootlin.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Feb 05, 2024 at 15:22:34 +0100, Théo Lebrun wrote:
> Hi,
> 
> This fixes runtime PM and system-wide suspend for the cadence-qspi
> driver. Seeing how runtime PM and autosuspend are enabled by default, I
> believe this affects all users of the driver.
> 
> The initial change has been split into three commits and a fourth commit
> is added to add system-wide suspend/resume callbacks.
> 
> The MIPS platform at hand, used for debugging and testing, is currently
> not supported by the driver. It is the Mobileye EyeQ5 [0]. No code
> changes are required for support, only a new compatible and appropriate
> match data + flags. That will come later, with some performance-related
> patches.
> 
> TODO: changelog below

Accidental "git-sent" email? ;)

> 
> Thanks all,
> Théo
> 
> [0]: https://lore.kernel.org/lkml/20240118155252.397947-1-gregory.clement@bootlin.com/
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---
> Changes in v2:
> - EDxxITME: describe what is new in this series revision.
> - EDxxITME: use bulletpoints and terse descriptions.
> - Link to v1: https://lore.kernel.org/r/20240202-cdns-qspi-pm-fix-v1-1-3c8feb2bfdd8@bootlin.com
> 
> ---
> Théo Lebrun (5):
>       spi: cadence-qspi: put runtime in runtime PM hooks names
>       spi: cadence-qspi: fix pointer reference in runtime PM hooks
>       spi: cadence-qspi: remove system-wide suspend helper calls from runtime PM hooks
>       spi: cadence-qspi: add system-wide suspend and resume callbacks
>       WIP: spi: cadence-qspi: add debug logs for PM

I don't seem to have recieved any of these FYI

> 
>  drivers/spi/spi-cadence-quadspi.c | 45 ++++++++++++++++++++++++++++-----------
>  1 file changed, 33 insertions(+), 12 deletions(-)
> ---
> base-commit: 13acce918af915278e49980a3038df31845dbf39
> change-id: 20240202-cdns-qspi-pm-fix-29600cc6d7bf
> 
> Best regards,
> -- 
> Théo Lebrun <theo.lebrun@bootlin.com>
> 

-- 
Best regards,
Dhruva Gole <d-gole@ti.com>

