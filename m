Return-Path: <linux-kernel+bounces-107485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6593287FD2E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21CF7283ABD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FA17F47E;
	Tue, 19 Mar 2024 11:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dTfn1+gO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9DA1CD13;
	Tue, 19 Mar 2024 11:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710849099; cv=none; b=S8HdxJ6VgPZ37Col/hLd7UHvwp+eezyaFEnul21edTcqcdQclB70EwYj4C3n3WUOyA74lgyY+E6NrWl+ICSKR1V/pDZVhxREeb1P/ULRxbhRrQA9VktkTRvhmwkVV1UpJpnEM5k4jwzuiiERXrOZSTGKjA5NzsInUQm4EuOSESk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710849099; c=relaxed/simple;
	bh=iw76am/BAxipiKfEjUG6N/StwBmf4pEy82GZKI/qTdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWFnXTQi0kXxAisWkODWns6WgaPbAhoDlKwB7J2aYp0UxB7qRrKFMb6EjOe/HxdLiQzDXDYkxNQtXjearV68vNhs665D3/iuGmpkdxSlyyD+FiBZE0NBH2UsQRHRyzr1J8DAcW5W4JYQQpkxhH1jd2+1LsShf78tvcBgVv4tVwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dTfn1+gO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18FD5C433F1;
	Tue, 19 Mar 2024 11:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1710849098;
	bh=iw76am/BAxipiKfEjUG6N/StwBmf4pEy82GZKI/qTdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dTfn1+gO6g5I//Sw1o0wjHXgZeXePOipCvW3qKsnDnP00We8/q/Ur/OTD+jCq8Lvj
	 nIXwWy3ibh3+AMdnYrNQJ9jX0oBrf2/Bj2JhymjMd4SDrFyb3OOe8fNr3jDKWwqQ3j
	 X5gwHBaOsuO3fd+inpbq8FYXX/RgeDYnZDTY85yw=
Date: Tue, 19 Mar 2024 12:51:34 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wentong Wu <wentong.wu@intel.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 1/1] mei: vsc: Unregister interrupt handler for system
 suspend
Message-ID: <2024031905-showpiece-coral-c76c@gregkh>
References: <20240318080126.2813476-1-sakari.ailus@linux.intel.com>
 <2024031915-manhole-winnings-43d4@gregkh>
 <ZfltTgGANYs9uix5@kekkonen.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfltTgGANYs9uix5@kekkonen.localdomain>

On Tue, Mar 19, 2024 at 10:47:42AM +0000, Sakari Ailus wrote:
> Hi Greg,
> 
> On Tue, Mar 19, 2024 at 08:51:43AM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Mar 18, 2024 at 10:01:26AM +0200, Sakari Ailus wrote:
> > > Unregister the MEI VSC interrupt handler before system suspend and
> > > re-register it at system resume time. This mirrors implementation of other
> > > MEI devices.
> > > 
> > > This patch fixes the bug that causes continuous stream of MEI VSC errors
> > > after system resume.
> > > 
> > > Fixes: 386a766c4169 ("mei: Add MEI hardware support for IVSC device")
> > > Cc: stable@vger.kernel.org # for 6.8
> > > Reported-by: Dominik Brodowski <linux@dominikbrodowski.net>
> > > Signed-off-by: Wentong Wu <wentong.wu@intel.com>
> > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > ---
> > >  drivers/misc/mei/platform-vsc.c | 17 ++++++-
> > >  drivers/misc/mei/vsc-tp.c       | 84 +++++++++++++++++++++++----------
> > >  drivers/misc/mei/vsc-tp.h       |  3 ++
> > >  3 files changed, 78 insertions(+), 26 deletions(-)
> > 
> > What is the git commit id of this in Linus's tree?
> 
> This one isn't in Linus's (or any other maintainer) tree yet.

Then why was it sent only for 6.8?  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

thanks,

greg k-h

