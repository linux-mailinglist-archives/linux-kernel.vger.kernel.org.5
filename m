Return-Path: <linux-kernel+bounces-86227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0D586C26D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 445F61F26643
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 07:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1802C482C7;
	Thu, 29 Feb 2024 07:22:16 +0000 (UTC)
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9209644C73;
	Thu, 29 Feb 2024 07:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.243.71.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709191335; cv=none; b=MYv+v4k35H2Glz4xcOxgqdwV8Aq7huLelsNb3bHiP0vh0hW/ipj6U5adleWIKaY37ehSwWnM3C75RKYh5bxh49BjufBtv85mmVlgwmFjT/0oTLHXPQ5U+BZaGWeGQVLxQfSe49/4YACrg2uUPNP5dbQ7oWnwaaIIKe8kbPhHnGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709191335; c=relaxed/simple;
	bh=diX3pIRqz7sozTYyyoVHZaQ3JZoXmk83szRqqasw29o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hoo9zcR9J13YKaCtAN6s7cxLs1TskdX8K7tRoHfJkRnrDsaYSEMlu9Wi6ASyWTRfgzB0gPFS1huRElYXglU3l1ijeZb8+qX+RMM2mdVc7XKzGJ8eigALHvu23b4F+v2mG/Ze48Oq0mTGCSizbf20QytEq0ZRbVaDThm9ySSvOFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net; spf=pass smtp.mailfrom=dominikbrodowski.net; arc=none smtp.client-ip=136.243.71.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dominikbrodowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dominikbrodowski.net
Received: from shine.dominikbrodowski.net (shine.brodo.linta [10.2.0.112])
	by isilmar-4.linta.de (Postfix) with ESMTPSA id 078582002B9;
	Thu, 29 Feb 2024 07:22:08 +0000 (UTC)
Received: by shine.dominikbrodowski.net (Postfix, from userid 1000)
	id D4A3EA0091; Thu, 29 Feb 2024 08:21:42 +0100 (CET)
Date: Thu, 29 Feb 2024 08:21:42 +0100
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: tomas.winkler@intel.com, mchehab@kernel.org, wentong.wu@intel.com,
	hverkuil-cisco@xs4all.nl, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: v6.8.0-rc6: mei_ace_probe / mei_vsc_probe: do not call blocking
 ops when !TASK_RUNNING
Message-ID: <ZeAwhhW7DSEazs0F@shine.dominikbrodowski.net>
References: <Zd9wUv1zSJ59WS8i@shine.dominikbrodowski.net>
 <Zd-BVmoFOiCxA632@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd-BVmoFOiCxA632@kekkonen.localdomain>

Hi Sakari,

many thanks, this patch helps. Another issue persists, though:


$ dmesg | cut -c16- | grep -E "(mei|vsc)"
mei_me 0000:00:16.0: enabling device (0000 -> 0002)
mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04: bound 0000:00:02.0 (ops i915_hdcp_ops)
mei_pxp 0000:00:16.0-fbf6fcf1-96cf-4e2e-a6a6-1bab8cbe36b1: bound 0000:00:02.0 (ops i915_pxp_tee_component_ops)
intel_vsc intel_vsc: silicon stepping version is 0:2
mei intel_vsc-92335fcf-3203-4472-af93-7b4453ac29da: deferred probe pending: (reason unknown)
mei intel_vsc-5db76cf6-0a68-4ed6-9b78-0361635e2447: deferred probe pending: (reason unknown)


During suspend entry (s2idle), the following messages are emitted:

ACPI Warning: \_SB.PC00.SPI1.SPFD.CVFD.SID: Insufficient arguments - Caller passed 0, method requires 1 (20230628/nsarguments-232)
intel_vsc intel_vsc: silicon stepping version is 0:2
PM: Some devices failed to suspend, or early wake event detected
ACPI Warning: \_SB.PC00.SPI1.SPFD.CVFD.SID: Insufficient arguments - Caller passed 0, method requires 1 (20230628/nsarguments-232)
intel_vsc intel_vsc: silicon stepping version is 0:2
vsc-tp spi-INTC1094:00: wakeup firmware failed ret: -110
vsc-tp spi-INTC1094:00: wakeup firmware failed ret: -110
intel_vsc intel_vsc: wait fw ready failed: -110
intel_vsc intel_vsc: hw_start failed ret = -110 fw status = 
intel_vsc intel_vsc: unexpected reset: dev_state = RESETTING fw status = 
ACPI Warning: \_SB.PC00.SPI1.SPFD.CVFD.SID: Insufficient arguments - Caller passed 0, method requires 1 (20230628/nsarguments-232)
intel_vsc intel_vsc: silicon stepping version is 0:2


Any ideas?

Thanks,
	Dominik

