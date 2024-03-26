Return-Path: <linux-kernel+bounces-119138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BD188C4B4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56C561C61218
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E04131E59;
	Tue, 26 Mar 2024 14:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SgoflYaX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7CA12AAC8;
	Tue, 26 Mar 2024 14:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711462077; cv=none; b=sd7NmV0zygYlIFDUKtHeMZBN0qaZGNObAYWsxM9WfEat/uaH6C/6ivrIv1vG/byRw86qZ90odIuPuP7FO+NJffQld/0CNYHALOshG1r3t7JK0FU+ey6YgLlylK/pMcuaa8yZAp+Z2s5zZRfXhy8QVz6jyBM4TwVYtjSOPdsZSEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711462077; c=relaxed/simple;
	bh=AFPRqnQJDU3Mww+Q+PGbCSYBh5G7RAdhLVbv2k0RGC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBSQ7III67TJUT1m4OTp4gsjS4+A2O7imxfXKKyM1XOmPGdoK/cV0ws7pHFpLwD0sPrhO/XBidUIsD66nKtIEzBQ+5mIeRniMvNVX4m/gD4fLSHJLLFgjZWBG/YtyD9BMCS8DO9SEwycNr+nrBnsK0b0HIcy704jGjmhwQoZdks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SgoflYaX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF0EC433C7;
	Tue, 26 Mar 2024 14:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711462076;
	bh=AFPRqnQJDU3Mww+Q+PGbCSYBh5G7RAdhLVbv2k0RGC8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SgoflYaXuQ6zwC2/CgziWfKtqdQ9oZ52ksJumQ/bvi7dFIHOdvjQsEJ8bHD+NibiW
	 unorKZEHmC3eriuxRktEzYgE1MCtwBZkdc5BNiJrAVj5EN/fd4DuXHhFEiew/n39p7
	 rz874lj6o/maYdwMyTccBN3j+C/R9rn2UavM9u5I=
Date: Tue, 26 Mar 2024 15:07:53 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Norihiko Hama <norihiko.hama@alpsalpine.com>
Cc: "balbi@kernel.org" <balbi@kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: gadget: f_ncm: Fix UAF ncm object at re-bind after
 usb ep transport error
Message-ID: <2024032638-celery-caravan-8aa8@gregkh>
References: <20240325094543.5362-1-Norihiko.Hama@alpsalpine.com>
 <2024032629-frolic-obtain-ad55@gregkh>
 <TYVPR01MB107816428A6B1C75930F19C1790352@TYVPR01MB10781.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYVPR01MB107816428A6B1C75930F19C1790352@TYVPR01MB10781.jpnprd01.prod.outlook.com>

On Tue, Mar 26, 2024 at 10:10:04AM +0000, Norihiko Hama wrote:
> > What commit id does this change fix?
> I'm not sure.
> I think that it's potential issue for long time.

Then please mark it as such when you resubmit it.

thanks,

greg k-h

