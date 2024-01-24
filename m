Return-Path: <linux-kernel+bounces-37416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3554283AFB9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E32FF28C940
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F79885C76;
	Wed, 24 Jan 2024 17:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YYTuWMd+"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BF185C49
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 17:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706116880; cv=none; b=OS+OwxvQrDtMIJmE0EV5dx96WK2huMZ3l0kU7YJdba969uTmFX22xN3bLaFsnB+oe4NOOiLJzTvKCHbEGKJRihwLWx58jYPB0IL1fJOpg/HdSuwbylsxtL8FiDoeNhiyhIcun9Bi3OoaD53MFPJ8w7KXvhyjh1S45OnwwYybPYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706116880; c=relaxed/simple;
	bh=EiCoJPnTL7TGvTbryiqXAzqyBUxETLyJiebAgcz5L/w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgKvRR77wK0IH+vmQ1fzvQoof5wLwNSaTgPLgGiQfPEE6aqNC/JZzHl0AazVYn5hW3Wukw1r7q5Y73Z5dzRJFGk8hvx8w2ggKJKNB37NClm5lslozAV3gUWEz6fLL+BtdgWZjr2qmGEwDIe4StzJ0EkrnCObmSfWdRHhmf0T3uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YYTuWMd+; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40OHL7rb067789;
	Wed, 24 Jan 2024 11:21:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706116867;
	bh=yBzQPwPqylVFT4fC7f7c6TpIfQpRU+mNF8bt8vOP0RI=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=YYTuWMd+VqQqixMPYVaJrIaRb0oiXc8dJAQNi6YtpBdBmT4CBeWLfqPho9JLW8/yK
	 CRCR8BlqijCOXfiYQHQSiXq0RVDGhbk8OytiBm1Dh2yYbXVU6m2/PO0HU1IFlbcqob
	 SP2k+MqPp3trOOhVymbosReVCY0IuYlCQpTrw9VE=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40OHL7YK091589
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Jan 2024 11:21:07 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 11:21:07 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 11:21:07 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40OHL7lj047860;
	Wed, 24 Jan 2024 11:21:07 -0600
Date: Wed, 24 Jan 2024 11:21:07 -0600
From: Nishanth Menon <nm@ti.com>
To: Andrew Davis <afd@ti.com>
CC: Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Santosh Shilimkar
	<ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] ARM: multi_v7_defconfig: Add more TI Keystone support
Message-ID: <20240124172107.un5xltsefttn3xzu@affected>
References: <20240124162857.111915-1-afd@ti.com>
 <20240124164141.e6sdftiqxoxr6k7t@ravage>
 <1e6a94e7-1b88-450e-825f-bf4b56afb748@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1e6a94e7-1b88-450e-825f-bf4b56afb748@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 10:59-20240124, Andrew Davis wrote:
> On 1/24/24 10:41 AM, Nishanth Menon wrote:
> > On 10:28-20240124, Andrew Davis wrote:
> > > The Keystone platforms used their own keystone_defconfig mostly to
> > > enable CONFIG_ARM_LPAE which could not be added to the multi_v7 config.
> > > Now that we have multi_v7_lpae_defconfig/lpae.config target we can and
> > > should use that defconfig for Keystone. Add the remaining must have
> > > options for Keystone support to multi_v7_defconfig.
> > > 
> > 
> > Please state bloat-o-meter impact on vmlinux.
> > 
> 
> $ ./scripts/bloat-o-meter build/vmlinux.baseline build/vmlinux
> add/remove: 387/0 grow/shrink: 6/0 up/down: 130945/0 (130945)
> ...
> Total: Before=22791863, After=22922808, chg +0.57%
> 
> 
> Seems half of that is TI_KEYSTONE_NETCP, if we don't think
> anyone will need nfs rootfs boot then we could make it a module:
> 
> 
> $ ./scripts/bloat-o-meter build/vmlinux.baseline build/vmlinux
> add/remove: 286/0 grow/shrink: 4/0 up/down: 64393/0 (64393)
> ...
> Total: Before=22791863, After=22856256, chg +0.28%

Please add that to commit message - the delta and rationale for the
config params you think we need to add in.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

