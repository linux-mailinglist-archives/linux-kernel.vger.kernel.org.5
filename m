Return-Path: <linux-kernel+bounces-157734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 482748B1529
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4355B25206
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF4E156F21;
	Wed, 24 Apr 2024 21:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oK0aO8jp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D1D13C9DE;
	Wed, 24 Apr 2024 21:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713993832; cv=none; b=IDUiGlC4o+DtNDEjx/N+tmJcXSOd+csbm7lVXPPrLICS4CnFfz50f9RKV8ZbWTYZjPAznfQv8/Ufc3LIMrjxI6cfDCTLSyBOUNePgbB0eQQKyFkuv1xehzDWhxisBzYVmbyqIEFdNzvTzfyu1c9HUvqONldkPSjf+cnTZXqIPIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713993832; c=relaxed/simple;
	bh=vkoQ3xlxRkOTA/ExiXKlpU0HDe2Y8nnTPrKZAKD/jho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uDBafKdTa1O8Z2T2JQAv3929hzqn7OlwF8coDZaFrb36jBr82R3vRlgBCKIqJRMhZj3rEzTmjpJfl7jvOIw1afgAQj1OQXRJTf/WOzE3yZ6/+WJ6jxuRa7Vu65/u+9nNWcuqxeeuVDWBmzj3vLXZ+jdZwMS7WAoPuLE+fBT9FRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oK0aO8jp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824F5C113CD;
	Wed, 24 Apr 2024 21:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713993831;
	bh=vkoQ3xlxRkOTA/ExiXKlpU0HDe2Y8nnTPrKZAKD/jho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oK0aO8jpxvVEH6ur4FPKIRrs9mR8FHc3mmj34ZHUanWUV7K7kEKNX/xbOCiH/jhSC
	 RNlshUKkGcKQMcJyf2Y33oyVfM9fXeyu148SW9ERlRr2/HQXWWYLYp3GBWjcePsAcq
	 1SryWxrrT+3ukSuQyhaeF9HpgsPwpj+1W7+5i7Y4=
Date: Wed, 24 Apr 2024 14:23:42 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jason Wessel <jason.wessel@windriver.com>,
	Douglas Anderson <dianders@chromium.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, Liuye <liu.yeC@h3c.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] serial: kgdboc: Fix NMI-safety problems from keyboard
 reset code
Message-ID: <2024042427-luster-unbend-5ed6@gregkh>
References: <20240424-kgdboc_fix_schedule_work-v2-1-50f5a490aec5@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424-kgdboc_fix_schedule_work-v2-1-50f5a490aec5@linaro.org>

On Wed, Apr 24, 2024 at 03:21:41PM +0100, Daniel Thompson wrote:
> Currently, when kdb is compiled with keyboard support, then we will use
> schedule_work() to provoke reset of the keyboard status.  Unfortunately
> schedule_work() gets called from the kgdboc post-debug-exception
> handler.  That risks deadlock since schedule_work() is not NMI-safe and,
> even on platforms where the NMI is not directly used for debugging, the
> debug trap can have NMI-like behaviour depending on where breakpoints
> are placed.
> 
> Fix this by using the irq work system, which is NMI-safe, to defer the
> call to schedule_work() to a point when it is safe to call.
> 
> Reported-by: Liuye <liu.yeC@h3c.com>
> Closes: https://lore.kernel.org/all/20240228025602.3087748-1-liu.yeC@h3c.com/
> Cc: stable@vger.kernel.org
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
> @Greg: I'm assuming this could/should go via your tree but feel free
>        to share an ack if you want me to hoover it up instead.

Hoover away!

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


