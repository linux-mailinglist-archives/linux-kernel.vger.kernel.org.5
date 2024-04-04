Return-Path: <linux-kernel+bounces-131053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB88898274
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 684472891E7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8576E5D478;
	Thu,  4 Apr 2024 07:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hKeuJszI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F5D63C7;
	Thu,  4 Apr 2024 07:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712217017; cv=none; b=oPaE5QSXXD47QfOXYAP0ZS2EMNX7Tok3LPWilpBSVo1iIQLM+qV8yGYjZKv2f1GtENZXT6K675tpcGPvQpvaggC//qWoD5GzOIRCnjrdGqtM4e+tFy3ost2kFnkyih+pD1lIMrBeWLrm/tlaLSC0aNlJKocG7/h4/2axjHjARN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712217017; c=relaxed/simple;
	bh=UQi/pLUsh2CNZLFSXNBZi74ZYYKx/Q531FOkLYDdepg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDGEUox5Hr06PkbdLO2U5W0zAzqNYbx0zu/XQRQF3DU5umrXAXj/eLa3JPVfwAWab9uB8ytMpQifFQwu2RU4AeDfJKAIfU2x/wEVGQxjvoz8JiRBiuksFjKeg+7zxnmDZ/Syc7wuVuC+jVfFCUfGusrecMDx4SM9LLHZzuUIDAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hKeuJszI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DE89C433C7;
	Thu,  4 Apr 2024 07:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712217017;
	bh=UQi/pLUsh2CNZLFSXNBZi74ZYYKx/Q531FOkLYDdepg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hKeuJszIqZPc0jGV4OqM6n6VTxHQs240dv/tevcdFCqOuq8e+s+vo0F/PdgCCtNf/
	 8ocWcP0XYUkdhQfMsp/YGajJMfyC1OV2Vc/dlzL8nvEMfTzXoBVMNlELFyDXyuVJjt
	 YhcMB1RmTCkrYev9rmOof+9TXedlcQ4Ea/IdoIUY=
Date: Thu, 4 Apr 2024 09:50:12 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bastien Curutchet <bastien.curutchet@bootlin.com>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	herve.codina@bootlin.com, christophercordahi@nanometrics.ca
Subject: Re: [PATCH 1/1] serial: 8250_of: Add clock_notifier
Message-ID: <2024040455-bungee-subsidy-f5aa@gregkh>
References: <20240404074450.42708-1-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404074450.42708-1-bastien.curutchet@bootlin.com>

On Thu, Apr 04, 2024 at 09:44:50AM +0200, Bastien Curutchet wrote:
> The UART's input clock rate can change at runtime but this is not
> handled by the driver.
> 
> Add a clock_notifier callback that updates the divisors when the input
> clock is updated. The serial8250_update_uartclk() is used to do so.
> PRE_RATE_CHANGE and ABORT_RATE_CHANGE notifications are ignored, only
> the POST_RATE_CHANGE is used.

Why just this one notification?  You say they are ignored but do not say
why.

> 
> Reorder the #include to match alphabetic order.

That is not needed here, why do that now?  And "alphabetic order" is not
an issue for tty drivers, no need to do that, but if you really want to,
a separate patch series is good for that.

thanks,

greg k-h

