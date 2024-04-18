Return-Path: <linux-kernel+bounces-150130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A49F38A9AD5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D68BC1C217F2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3994F156F54;
	Thu, 18 Apr 2024 13:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i6lhbbli"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D149823A2;
	Thu, 18 Apr 2024 13:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713445511; cv=none; b=iOWrh4BTsCm6AlvX8amZfg3vM2oop6Mr5d0+GBIohCEnCTwhTWq2DodX7Lepa8ZwbPvElJEJyEpGre/JDwuKwv2gkDUvyQM1OHXbmzgjr9OJVppv13/hblBfbOOoBu5L7T9MJTijuklrOqJy6ePWuwGq11yuDVzatpVotkUdCC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713445511; c=relaxed/simple;
	bh=/YTnzTdSJvLIjLVY9xkySWIzZVL5MmYbQ5Xj04YwmGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5QZtw4aYbSqDqevgaQNm+55+KmYZsb3oblHS7dOHzENYb293GsKtSnPuoeTi4oK4Eejv0Zfd2Uc0xMSL+0VZ/jcjAhh+ESZO/zAbO/VwIcQV47ypKVqXpVqZQw2Twhpvw3HV4MFIZfvwt6nUVOTVbNFJLxFtFUnT2zWTo/64dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i6lhbbli; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E42C113CC;
	Thu, 18 Apr 2024 13:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713445511;
	bh=/YTnzTdSJvLIjLVY9xkySWIzZVL5MmYbQ5Xj04YwmGE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i6lhbblifKvBcWoavr4IwlPzecequr6p7sFQL5ULI2LzPNGPCjTCRY2nferSb/6en
	 0BFYwSMsDSRCdubRi8RCHKIhsAjVhVFAz39f45xTP8oJC673DiVo0P8vbTHpKWt0i0
	 QxQ/g8zKw0MaOUaZtcgKOD8EDnnciwC3Yyh4vI1I=
Date: Thu, 18 Apr 2024 15:05:08 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jean Delvare <jdelvare@suse.de>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	linux-cve-announce@vger.kernel.org
Subject: Re: CVE-2024-26827: i2c: qcom-geni: Correct I2C TRE sequence
Message-ID: <2024041842-handrail-distaste-259b@gregkh>
References: <2024041703-CVE-2024-26827-67c1@gregkh>
 <a1f56653f2e2be923ed47f7e968230ca8a856553.camel@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1f56653f2e2be923ed47f7e968230ca8a856553.camel@suse.de>

On Thu, Apr 18, 2024 at 02:56:33PM +0200, Jean Delvare wrote:
> Hi Greg,
> 
> On Wed, 2024-04-17 at 11:44 +0200, Greg Kroah-Hartman wrote:
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > i2c: qcom-geni: Correct I2C TRE sequence
> > 
> > For i2c read operation in GSI mode, we are getting timeout
> > due to malformed TRE basically incorrect TRE sequence
> > in gpi(drivers/dma/qcom/gpi.c) driver.
> > (...)
> 
> I was assigned the task to backport this security fix to the SUSE
> kernels. However, from the description, I fail to see how this fix
> qualifies as a security fix. I can't find the reason why a CVE was
> assigned to the issue.
> 
> What is the considered attack vector? Or if there is no attack vector,
> what consequence does this bug have, which would put the system
> security at stake?

We reviewed this commit as fitting the fact that timeouts due to
malformed messages would fit into the definition of "vulnerability" in
the CVE world as it would cause a system to incure "negative impact to
confidentiality, integrity, or availability".

If as the i2c maintainer, you don't think this would be the case, we
will be glad to revoke this CVE and just mark it down as a "normal
bugfix".

> From my perspective, all we have here is a functional bug in newly
> introduced code. It's not even a regression.

Regressions are not an issue for CVE assignments :(

thanks,

greg k-h

