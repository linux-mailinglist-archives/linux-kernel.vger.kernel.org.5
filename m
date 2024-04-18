Return-Path: <linux-kernel+bounces-150341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC118A9DA2
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CED661C21992
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6080168B10;
	Thu, 18 Apr 2024 14:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GixqRVaZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FECD168B09
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 14:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713451942; cv=none; b=uX3vQ2GDdzV/kSjceZN9uqJzgachP5kkO43lrcmnTSJvKCxtcWaKTYowM22lm2xXJxyA9aHiocFlE5y56i7Fl9F+XcgvOK0NAon5u3X1w2Bau2DNrm0pEsWedFYOfeFa/PEzlrSIF7dE0YRSEXHhpNfFRWoXsPA7FCjW2oAdFdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713451942; c=relaxed/simple;
	bh=A+cUEwAlZpCbvMQdXF4AdOevwufNJf8HRmR93gA0KxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Le63eyLmAcpxInMXEgIAMqSLXB8nE0SChRp3EZvSwb9PPP9gpWj3eOUGmfnVtzWGXGl8Dw80Ft/49xe0umeGhtlAzFIcA/LaAbs8EIFp0RxXnzxtVZThD6UQ6hkK9igKVaHmy3fC5d/JuguHmulVpIkHndEV63lEPYBmr6lQl9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GixqRVaZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45922C113CC;
	Thu, 18 Apr 2024 14:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713451941;
	bh=A+cUEwAlZpCbvMQdXF4AdOevwufNJf8HRmR93gA0KxQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GixqRVaZNPP9D6+J7QM0kWsxFqs7gG74IrQMaeNaEZtn2jaq8VWK8Vp4e9TkZYyF5
	 cTxT8CxllNeW7vOsCevsG4TQpARDKYNi/PBKwFBKxmqMX7297yJ43LBj+WZFvIU03z
	 gGiBGwxZbhau3FvswHy3eqXW4N3DufJcn4zKmqH8=
Date: Thu, 18 Apr 2024 16:52:18 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jean Delvare <jdelvare@suse.de>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CVE-2024-26827: i2c: qcom-geni: Correct I2C TRE sequence
Message-ID: <2024041858-frostily-sedation-600a@gregkh>
References: <2024041703-CVE-2024-26827-67c1@gregkh>
 <a1f56653f2e2be923ed47f7e968230ca8a856553.camel@suse.de>
 <2024041842-handrail-distaste-259b@gregkh>
 <9e15807be09695bbc35070b558e387237a00c988.camel@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e15807be09695bbc35070b558e387237a00c988.camel@suse.de>

On Thu, Apr 18, 2024 at 04:44:33PM +0200, Jean Delvare wrote:
> On Thu, 2024-04-18 at 15:05 +0200, Greg Kroah-Hartman wrote:
> > On Thu, Apr 18, 2024 at 02:56:33PM +0200, Jean Delvare wrote:
> > > Hi Greg,
> > > 
> > > On Wed, 2024-04-17 at 11:44 +0200, Greg Kroah-Hartman wrote:
> > > > Description
> > > > ===========
> > > > 
> > > > In the Linux kernel, the following vulnerability has been resolved:
> > > > 
> > > > i2c: qcom-geni: Correct I2C TRE sequence
> > > > 
> > > > For i2c read operation in GSI mode, we are getting timeout
> > > > due to malformed TRE basically incorrect TRE sequence
> > > > in gpi(drivers/dma/qcom/gpi.c) driver.
> > > > (...)
> > > 
> > > I was assigned the task to backport this security fix to the SUSE
> > > kernels. However, from the description, I fail to see how this fix
> > > qualifies as a security fix. I can't find the reason why a CVE was
> > > assigned to the issue.
> > > 
> > > What is the considered attack vector? Or if there is no attack vector,
> > > what consequence does this bug have, which would put the system
> > > security at stake?
> > 
> > We reviewed this commit as fitting the fact that timeouts due to
> > malformed messages would fit into the definition of "vulnerability" in
> > the CVE world as it would cause a system to incure "negative impact to
> > confidentiality, integrity, or availability".
> 
> If the timeout could be triggered on purpose, then I would agree, as
> this could possibly be used for a denial-of-service type of attack. But
> this isn't the case here.
> 
> All we have is a failure to read data from a random I2C device due to
> an incorrect programming of the I2C controller. Simple lack of
> functionality.

Thanks for the explaination and looking into it.

> > If as the i2c maintainer, you don't think this would be the case, we
> > will be glad to revoke this CVE and just mark it down as a "normal
> > bugfix".
> 
> Yes, please.

Now rejected, thanks for letting us know.

greg k-h

