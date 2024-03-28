Return-Path: <linux-kernel+bounces-122831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3320388FE12
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C50EE1F26459
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86BED7E57F;
	Thu, 28 Mar 2024 11:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yfKPljNU"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F8F5FB88;
	Thu, 28 Mar 2024 11:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711625336; cv=none; b=MUC32Ge8pAIoi/gRAeNfV3eZc2gBJxlvNUuhkAOBl1CvnG/46zogeg87aobiGYwNbJSv4rIPAIxYaLJHxoeTKLAT0PPG4U0uwmZIDPBhZLZyPSIRGdKito5L3rj6AlDDyzLlmp4Sc1ZmmRNcDMqGBXbv1QF7sVYsXXdxBrreO4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711625336; c=relaxed/simple;
	bh=w71PyqTWUYXQPlDqF75uE2tFWxAgMclVgkaI7BGxqo0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbdFB+muS2JFEvv99tWaNr/cOw2JhSMXysMyMslImN222HUaoDgkBvQLV4BVJilXf+KtoDqFaT/FG7986Wff8R7FJJxASfhWo6i0SR9sPh07gipc1hK+a5tIps+jCy9AQld5zasqffYxiW6nmN1PGWk7DRrKQYPRnNrlw5Y/pWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yfKPljNU; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42SBSptS127909;
	Thu, 28 Mar 2024 06:28:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711625331;
	bh=yC5GkTzUWJ4BfrXXRzX982bBR94IDaZhvBUH9M9+e+I=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=yfKPljNU2eJfqrxkk4PdxGtL3P0uQYxKY1PEAYNhEzdpDt1MeVUB9viodbAUnkKSg
	 xg8KYO05+Jymki8Om+YTO8TEDDNTXNoVRcA1KhpYM3CFGHR5ediZfx4t7xdnTM/er+
	 kXJJMvtbqLhchS/1ZBxIgOyJf7x5AxabcPyI/GOY=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42SBSppA105420
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 28 Mar 2024 06:28:51 -0500
Received: from lewvowa02.ent.ti.com (10.180.75.80) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Mar 2024 06:28:50 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by lewvowa02.ent.ti.com
 (10.180.75.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2507.34; Thu, 28 Mar
 2024 06:28:50 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Mar 2024 06:28:50 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42SBSnGN095156;
	Thu, 28 Mar 2024 06:28:50 -0500
Date: Thu, 28 Mar 2024 16:58:49 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Tony Lindgren <tony@atomide.com>
CC: <linux-omap@vger.kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] bus: ti-sysc: Drop legacy idle quirk handling
Message-ID: <20240328112849.uku4hy4rjd3qgd65@dhruva>
References: <20240327081508.36747-1-tony@atomide.com>
 <20240327081508.36747-6-tony@atomide.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240327081508.36747-6-tony@atomide.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

On Mar 27, 2024 at 10:15:08 +0200, Tony Lindgren wrote:
> There are no more users that need the legacy idle quirk so let's drop
> the legacy idle quirk handling. This simplifies the PM code to just
> sysc_pm_ops with unified handling for all the interconnect targets.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/bus/ti-sysc.c                 | 109 +-------------------------
>  include/linux/platform_data/ti-sysc.h |   1 -
>  2 files changed, 2 insertions(+), 108 deletions(-)
> 

looks much cleaner :)
Reviewed-by: Dhruva Gole <d-gole@ti.com>

-- 
Best regards,
Dhruva

