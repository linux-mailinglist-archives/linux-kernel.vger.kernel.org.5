Return-Path: <linux-kernel+bounces-70017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 828038591CF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 19:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CBAD282B62
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 18:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9D97E114;
	Sat, 17 Feb 2024 18:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZtD2Uk8G"
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C69134BC;
	Sat, 17 Feb 2024 18:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708195281; cv=none; b=JbSKRRXpinI7aQ8FQvuVEI/SKhoNxvI7lFZcBHcUuYGcvJPQ0RZx/a4wP6bQgJu6GoChdDStu5X5bmJxVJVhQmThF/UWOMsyCWCaKyxw3DB62zajmdOs2ANnnbIP/JLKZlK019BIYI/dHlU4pBkb6MYXE/cD85r/M5M4iBt7K1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708195281; c=relaxed/simple;
	bh=yl8fhiCb+vkQsPoBRBnmk75Ky1snUKjgnNsT75mEJrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IoS8y2dv86WsnFusXPi1qKAIqAsmwapdEMo1XfL26jzusOBvA6uflpW/BNSBMrwTb5niesuelRcp49+HULPDBrz+LUvP4rnz37+LMswU76B4P4s1nd5oAgcpvPw5VGCEcHoDv8SghMgizANW1DcAF4eW0na55RxqkV529bslVy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZtD2Uk8G; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=hN8mFTdhqEE8m94XzHYn7TPoFI/jGHsVtmjgAXHWDME=; b=ZtD2Uk8GlwP1MZCTBW0+7Et45s
	eh95E/EJKgFOuESha/N7GN9PFa8N5NFE2FDEHgC+7u9PWVatz4zb+m9bRHAVGzwsqjTyau5s3gNcU
	djwQjVJghFhtgApnqwk0a5jivl3rS0OVSO5LVCnQrKA3vJ3siQdRh+i6VBE4t6LlxvsI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rbPcp-0084vd-PD; Sat, 17 Feb 2024 19:41:23 +0100
Date: Sat, 17 Feb 2024 19:41:23 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next v3 1/8] net: usb: r8152: Use linkmode helpers
 for EEE
Message-ID: <3fec8501-9b63-4749-9191-7c3ab1c2d923@lunn.ch>
References: <20240217-keee-u32-cleanup-v3-0-fcf6b62a0c7f@lunn.ch>
 <20240217-keee-u32-cleanup-v3-1-fcf6b62a0c7f@lunn.ch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217-keee-u32-cleanup-v3-1-fcf6b62a0c7f@lunn.ch>

On Sat, Feb 17, 2024 at 12:08:22PM -0600, Andrew Lunn wrote:
> Make use of the existing linkmode helpers for converting PHY EEE
> register values into links modes, now that ethtool_keee uses link
> modes, rather than u32 values.
> 
> Rework determining if EEE is active to make is similar as to how
> phylib decides, and make use of a phylib helper to validate if EEE is
> valid in for the current link mode. This then requires that PHYLIB is
> selected.

I started on the next step to remove the _u32 values. And found i
missed a conversion in this file.

v4 tomorrow.


    Andrew

---
pw-bot: cr



