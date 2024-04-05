Return-Path: <linux-kernel+bounces-132493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8B68995D7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:50:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBF081C21A2D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632C323775;
	Fri,  5 Apr 2024 06:49:55 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4A81BC26
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 06:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712299795; cv=none; b=mKAP3DylPfBDbQkCjbNBpnL7HE//w9+nuVxpWlZF3AtsUBUIk5S/rgCHRQRGNs+Opx0Pdfqj4oc4DP9Fhpu32u1UJV/OcMyS44/CabjjkPez/rBCjU5mGk9FlgffraKQuK/mvUp5R7yYfA71jnbwDihIb5SDZQ8tvKAZBirlD00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712299795; c=relaxed/simple;
	bh=AFpafnKbsgVNP2jpePTb8AYY+b40xrzzyrZhuS3vF4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tf4iwzTCiOLqWz2tFioxP84PnCf+aLFlogS3K+iryJeowchSv3vd0w+Ms+VQoVbTe+UmgWtEfA2GVkcBwF964F9DUUbW7M1wX8NG7pOYD7yj7T1EfU53pr3zovEsDPXKpW+kHj+uGwwfV+GqjqnyYaso4pFPxHS1T0K+9jobmkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8CB5C68D07; Fri,  5 Apr 2024 08:49:49 +0200 (CEST)
Date: Fri, 5 Apr 2024 08:49:49 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, James Smart <james.smart@broadcom.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] nvme: authentication error are always
 non-retryable
Message-ID: <20240405064949.GB3788@lst.de>
References: <20240404154500.2101-1-dwagner@suse.de> <20240404154500.2101-2-dwagner@suse.de> <20240405061624.GA3107@lst.de> <woyigt522zjki3zqudphkxmnzqmerrbk4qdammefuuxww3n3a2@ahfxqfztkmvp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <woyigt522zjki3zqudphkxmnzqmerrbk4qdammefuuxww3n3a2@ahfxqfztkmvp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Apr 05, 2024 at 08:45:11AM +0200, Daniel Wagner wrote:
> > This is still abusing on the wire status code for in-kernel return
> > codes.  Can we please sort this out properly?
> 
> Okay, though I am not really sure how to do it correctly.
> 
> So the current mapping is
> 
>   ret < 0: kernel errors
>   ret = 0: all good
>   ret > 0: wire status incl DNR

Yes.

> In order to split the internal DNR away, we could attach it to the cmd.
> Is this what you had in mind? Or do you mean we should not return
> NVME_SC_AUTH_REQUIRED at all. Instead just a negative value and update
> the error handling on the callers?

The latter.

