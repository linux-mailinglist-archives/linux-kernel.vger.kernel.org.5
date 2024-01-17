Return-Path: <linux-kernel+bounces-28630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5778300F9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A0521F21EE4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E073FD30B;
	Wed, 17 Jan 2024 08:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilMPdSwl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BA18821;
	Wed, 17 Jan 2024 08:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705478638; cv=none; b=Ux4oRpBDmmPXJ+1gme7PrjYIPUyS34BRbhGOLyXqT4db1u7autNa5YCDNyRMIom0ZxEUnq2YSqXgZ85TRPux5Gh/+LUdDLobSkTrtWTaVvV2F28k4wAEF1PoUBOV25GC+ews+8p7S4Fj0/8aKHcH/IqVtX1Tm1Wk+lNOl58P7EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705478638; c=relaxed/simple;
	bh=ETB5AB8avM6Q2+w/QltTg8gAglo6HWM8L7ODmPsQsAk=;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PRFuqXr1c/Dxj/uofgrqFnplgH6GtmhHf+bchz9HWxreHUABO5Xh67cHkL6sz9Cqukxokj2wVt9lSEJxR4rwafHsRTyrU3R19gI6EeL2WMkuFhZt3EvsjiagPUUNO0AxV1XmaPOc1Co6peqQCQeXN5lwtW1jeqoLVy237TD10Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilMPdSwl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91BB6C433C7;
	Wed, 17 Jan 2024 08:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705478637;
	bh=ETB5AB8avM6Q2+w/QltTg8gAglo6HWM8L7ODmPsQsAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ilMPdSwlug/3WRyCeZo9ze+3bm0nRwbnv4ae9XX+a7TJ9jcKyR7yFQW3Gkd/3Z/3+
	 bDQhA1zMX1leu54ZL7AVifs+hAA+BbsdIg4R4/6i6O6ANLwr2dSj3nbkiAhouh866R
	 IqPno0/fk0qyxv8kcpoouQjbTHUXIy12b9ctyFK+2/ju/UWn721h5Rcsv/dhscD80e
	 w/O6pa6fTJL66TWSA0KVv2vg7Fwa3nG/RCqTgISyUYhyrcfJR+je+cPEWe1Rymm3dx
	 3DEer0KulBllpqe8nhTvaDdA7WNLnEcnVGCvw/4vRFfGz8933eIFG//pMRaiJIqqVo
	 rUpFVXyZGb8kg==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rQ0u1-00050u-1F;
	Wed, 17 Jan 2024 09:04:01 +0100
Date: Wed, 17 Jan 2024 09:04:01 +0100
From: Johan Hovold <johan@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>, gregkh@linuxfoundation.org,
	hdegoede@redhat.com, fabrice.gasnier@foss.st.com,
	quic_jackp@quicinc.com, saranya.gopal@intel.com,
	quic_linyyuan@quicinc.com, andriy.shevchenko@linux.intel.com,
	minhuadotchen@gmail.com, johan+linaro@kernel.org, robh@kernel.org,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.7 044/108] usb: typec: ucsi: fix UCSI on buggy
 Qualcomm devices
Message-ID: <ZaeJ8Sh4JLo5GAQw@hovoldconsulting.com>
References: <20240116194225.250921-1-sashal@kernel.org>
 <20240116194225.250921-44-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240116194225.250921-44-sashal@kernel.org>

On Tue, Jan 16, 2024 at 02:39:10PM -0500, Sasha Levin wrote:
> From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> 
> [ Upstream commit 1d103d6af241dbfc7e11eb9a46dff65db257a37f ]
> 
> On sevral Qualcomm platforms (SC8180X, SM8350, SC8280XP) a call to
> UCSI_GET_PDOS for non-PD partners will cause a firmware crash with no
> easy way to recover from it. Since we have no easy way to determine
> whether the partner really has PD support, shortcut UCSI_GET_PDOS on
> such platforms. This allows us to enable UCSI support on such devices.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Link: https://lore.kernel.org/r/20231025115620.905538-2-dmitry.baryshkov@linaro.org
> Signed-off-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Correct me if I'm wrong Dmitry, but while the commit message makes this
sound like a fix, it is not needed unless you backport follow-on patches
that enable UCSI on these platforms.

So this one can be dropped from all stable queues (unless you're
backporting patches that enable new features and that depend on this
one).

Johan

