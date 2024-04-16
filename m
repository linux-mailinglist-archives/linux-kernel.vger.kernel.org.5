Return-Path: <linux-kernel+bounces-146543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0ED8A66CD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F21821F23218
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17FF784FC9;
	Tue, 16 Apr 2024 09:14:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47F0205E10
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 09:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713258850; cv=none; b=mpHcBJKYpxQ080IUVuzx83rg/HmwVMmQUwIsU22Q6rO2GvxEdXQyDCp+EmFYRPagAsIL/FZFMwizrVblNqFCc4mafak/qBA29fVkwsPlFxkmri8PbaOwniPz9M1tTL79iYsJenQueX4+zftxGdUKMal4BtDkur88nZxrDr+auD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713258850; c=relaxed/simple;
	bh=SLnMlc+/eK00EmnxeOI7j3/d57CnaPFNk93KmLlRKTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXB7sUTbxb/aIGmilWsCqbgwb6Zn0rkuasF/LDjor/MkvM4bt0L74fCrrUWesxdIS4YW5oOuxWeuWZSgqw9Cmd8yNhpt0OFrLFBDFWRbEaImw/6REQLCncKGJy8CK4BVIDQ6aFFH9ib23tOJHffsSuAsHAwZSrtmlQkA/KzYFAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D6D5339;
	Tue, 16 Apr 2024 02:14:36 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 37B373F792;
	Tue, 16 Apr 2024 02:14:07 -0700 (PDT)
Date: Tue, 16 Apr 2024 10:14:04 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: cristian.marussi@arm.com, linux-arm-kernel@lists.infradead.org,
	Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] firmware: arm_scmi: power_control: support suspend
 command
Message-ID: <Zh5BXAuLKM1uUOyD@bogus>
References: <20240415101141.1591112-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240415101141.1591112-1-peng.fan@oss.nxp.com>

On Mon, Apr 15, 2024 at 06:11:41PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
>
> Support System suspend notification. Using a work struct to call
> pm_suspend. There is no way to pass suspend level to pm_suspend,
> so use MEM as of now.
>

While the change itself is simple and no-controversial, I am bit worried
about:

1. The choice of S2R(MEM) by default - not sure if different system
   prefer different things. The userspace can configure whatever default
   behaviour expected as S2R IIUC, so should be OK. I need to check though.

2. The userspace needs to keep the wakeup source enabled always which
   I need to check if it is feasible on all the platforms. If wakeups
   are not configured properly and suspend is triggered, the system can
   never resume back.

We may need to mention above points at-least as part of commit log. I
would wait for some feedback from SCMI users.

--
Regards,
Sudeep

