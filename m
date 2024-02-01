Return-Path: <linux-kernel+bounces-48660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C84845F77
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED2D71C2A2F8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C839612B17D;
	Thu,  1 Feb 2024 18:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="doP0lCgp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126C082C97;
	Thu,  1 Feb 2024 18:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810803; cv=none; b=JsChUnkvV6fl2O49CzaiQAkjpBmClVdM+wy1EihLQkiDIucNFJT6p9sYqOw7aLo8ljt4EAJe2SMLAQaSCtyn2YvZEOd3/yFfgfc/NpopCGKlzMtO5Ip3gRsBSasOWg5n0PR2g8pNG7IDU2sv8HJWUFl3XvScUQd0SrVyMfbzVc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810803; c=relaxed/simple;
	bh=grYi/p4N1X4DD1hgZKLp/XELHnCmaiCXcvEboAb1fCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFBGT6iZjb1ewC8+y5khv9MZYOEk8smQ6f5MKZurB6cp4TKWxbPY4TyAQwKOaLR0Gy304cdZEMgxu+DFY09n6hY41+UrTke9A2ieC6Pku8Uq+BoWebrxNSBqrGVMvDINPOEATVL0s4UQhw0zdRslSiV3BQwce6KNIC3+RYUlXBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=doP0lCgp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B00EC43399;
	Thu,  1 Feb 2024 18:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706810802;
	bh=grYi/p4N1X4DD1hgZKLp/XELHnCmaiCXcvEboAb1fCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=doP0lCgpQC4BNrBUGYN1yeLXtgIwDBUwd1kcBCbgzRp5JnGz17JJ3amOGtIGMIIOF
	 HqQXdW0AzGbHWUDY6m6kvnjpHiUMcTtmKieSbRxK6tOTE2u+fxncc/sD9wWSAX57NX
	 33zG1hwzT6vPEA+hU5kGQUMMkDNB3uCuSKFryNTI=
Date: Thu, 1 Feb 2024 10:06:41 -0800
From: Greg KH <gregkh@linuxfoundation.org>
To: Guan-Yu Lin <guanyulin@google.com>
Cc: Oliver Neukum <oneukum@suse.com>,
	Alan Stern <stern@rowland.harvard.edu>, mathias.nyman@intel.com,
	royluo@google.com, hadess@hadess.net, benjamin.tissoires@redhat.com,
	heikki.krogerus@linux.intel.com, grundler@chromium.org,
	yajun.deng@linux.dev, dianders@chromium.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	badhri@google.com, albertccwang@google.com, pumahsu@google.com
Subject: Re: [PATCH] [RFC] usb: host: Allow userspace to control usb suspend
 flows
Message-ID: <2024020106-gore-cohesive-4bb3@gregkh>
References: <20240130064819.1362642-1-guanyulin@google.com>
 <0e4221b5-bafe-4bea-b533-0ed8add81ef1@rowland.harvard.edu>
 <CAOuDEK2VSBcQdLKt27VrLUxH2S22275ffbe5mdVM=vBZDhceQA@mail.gmail.com>
 <09fce208-72b1-49e8-988e-ea149fbaf0b5@suse.com>
 <CAOuDEK3YcHxm4H2+n1r5KZoFK9PG9+XeJD49FCKaeX+KFhkrzQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOuDEK3YcHxm4H2+n1r5KZoFK9PG9+XeJD49FCKaeX+KFhkrzQ@mail.gmail.com>

On Fri, Feb 02, 2024 at 12:00:00AM +0800, Guan-Yu Lin wrote:
> On Thu, Feb 1, 2024 at 5:38 PM Oliver Neukum <oneukum@suse.com> wrote:
> >
> >
> >
> > On 01.02.24 10:02, Guan-Yu Lin wrote:
> > > On Wed, Jan 31, 2024 at 1:12 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> > >>
> > >> On Tue, Jan 30, 2024 at 06:47:13AM +0000, Guan-Yu Lin wrote:
> >
> > >> Why does this affect only the USB subsystem?  Can't the co-processor
> > >> use other, non-USB, devices on the system?
> > >>
> > > In our use case, the co-processor only supports USB subsystem. There might be
> > > other co-processors support more subsystems, but we're not sure about how they
> > > will interact with the system.
> >
> > Hi,
> >
> > it would be very good if you decided this now, before we add attributes.
> >
> > The reason is that if this feature is needed for multiple subsystems,
> > the attribute should be added to the generic device structure, so that
> > the naming and semantics are consistent.
> > You really don't want to repeat this discussion for every subsystem.
> >
> >         Regards
> >                 Oliver
> >
> 
> Hi,
> 
> Given that in our use case the co-processor only supports USB subsystem, I'd
> like to proceed with adding the attribute exclusively within the USB subsystem.
> Please let me know if there is any further consideration, thanks.

Please do it properly as Oliver states here.  Otherwise it will require
more work in the future for you to modify this again for all other
subsystems.

thanks,

greg k-h

