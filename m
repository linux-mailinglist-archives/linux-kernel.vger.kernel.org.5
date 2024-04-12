Return-Path: <linux-kernel+bounces-142951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D47E8A3271
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09089285B67
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3A1147C9D;
	Fri, 12 Apr 2024 15:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Brtp5Tzl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8319B144D34;
	Fri, 12 Apr 2024 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712935706; cv=none; b=V5tBrGthsBtIELZWozhu9ipPMxlh+Y7a4RLWwJvAhVFjpGvo18PB4/0h57eYRvx7Xh5aywEUbK5rxhX5ENRNrwJUkMcphlU0180yuCkZjiSVZLFuWwkLiokDwilwM4z3XQbiBg0PpJeqEx48mH0baBrs6YlQyYWF8aY4h7/ppus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712935706; c=relaxed/simple;
	bh=0GPAx3B+uC1u8pMMt3HI7wNGi3jM/KEZtOQcPni5jHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2P7jtH380wr7AD0Em1azfGRrpmFcI325Q1bvYdRI9bhI+yYbu5FLrXlDMMv50uPC2VrD/15jeoeN/G4CeIANvBW+M7fngqMUXGOygI90Yjarrs8kLF0FrB7ZyFnx5VXjtvE1WsWNxX/Po2wJ8fPe5kTNOEsVxfcHv3r5PXxdVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Brtp5Tzl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73541C113CC;
	Fri, 12 Apr 2024 15:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712935706;
	bh=0GPAx3B+uC1u8pMMt3HI7wNGi3jM/KEZtOQcPni5jHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Brtp5TzlhQO8e0+0nt8tDnuEtZn99kmCrkGK4SNeQPwAJzYxKEJXxbVkzvO2RVdYd
	 3HsUkNo7VmZTutSu7I0feRtP7KJwpOjAZN5FPbDCrGz7nCnLzdCXkp25w0CpKEhzeM
	 PqQb97nVIYnvwxUSWprJoFJiHNomoYl/4WtWw7RA=
Date: Fri, 12 Apr 2024 17:28:20 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Parker Newman <parker@finest.io>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-serial <linux-serial@vger.kernel.org>,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v2 6/7] serial: exar: add CTI board and port setup
 functions
Message-ID: <2024041248-enjoyable-barterer-4f01@gregkh>
References: <cover.1712863999.git.pnewman@connecttech.com>
 <ca94454e54504c1621f17f5e3933cad299f61344.1712863999.git.pnewman@connecttech.com>
 <c73b4fc3-be87-6a6d-408e-634ba915f28e@linux.intel.com>
 <20240412111926.5b4c9953@SWDEV2.connecttech.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240412111926.5b4c9953@SWDEV2.connecttech.local>

On Fri, Apr 12, 2024 at 11:19:26AM -0400, Parker Newman wrote:
> On Fri, 12 Apr 2024 13:57:01 +0300 (EEST)
> Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> wrote:
> 
> > On Thu, 11 Apr 2024, parker@finest.io wrote:
> > 
> > > From: Parker Newman <pnewman@connecttech.com>
> > > 
> > > - Removed old port setup function and replaced with UART specific ones
> > > - Added board setup functions for CTI boards
> > > - Replaced CONNECT_DEVICE macro with CTI_EXAR_DEVICE and CTI_PCI_DEVICE  
> > 
> > In general, you should try to do refactoring in a preparatory patch (one 
> > refactoring thing at a time) and add new stuff in another patch in 
> > the series. I didn't go to figure out how much it applies to those three 
> > items because you likely know the answer immediately.
> > 
> > > - Moved "generic rs485" support up in the file  
> > 
> > Please do this in a separate patch.
> > 
> 
> Will do.
> 
> > 
> > Another general level problem with your series is that it adds functions 
> > x, y, etc. without users, whereas the expected way of doing things would 
> > be to add the functions in the change they are getting used so it's easier 
> > to follow what's going on.
> > 
> > I believe if you separate the refactoring & moving code around into own 
> > changes (no functional change type patches), the new stuff is much 
> > smaller so there is no need to split that illogically into incomplete 
> > fragments in some patches.
> > 
> > --
> >  i.
> > 
> 
> Thanks for the feedback, I am new to the mailing lists and am trying to balance
> what you mention above with not having giant patches. 

It's a fine line, and takes a while to learn, but as a first cut, this
was pretty good, I didn't have any major problems with the structure of
it, so nice work.

thanks,

greg k-h

