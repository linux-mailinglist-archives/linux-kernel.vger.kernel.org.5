Return-Path: <linux-kernel+bounces-92327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C46C871E7C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32A471F2513C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AD559B77;
	Tue,  5 Mar 2024 12:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n9r0LJ9R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398105676D;
	Tue,  5 Mar 2024 12:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709640187; cv=none; b=LCI5BFodUOhy5zwts3vrAZJQTODl8qxKjK66MUrYtVRpydzcVOoXB1N5dIrenEHs0nBmc7wgqSQhmIFZB1K29S6p5IYZv1SKB1dQ8Kzvfqa3QUpC+b70/3dGmfwIT2eTAbPkv5GccgAi0wCIKFxOBkFZsgRvdvs83Z3Wl2w0oiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709640187; c=relaxed/simple;
	bh=79bRoIfWwTyJNE+ZvVpy+oLKq8Gm67lYHHCXczcorVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQAFh5SEChdFYbybxBhNLc1lbF/RKGHyhSbcJYvZQjFcT7DXcEtWjDXT7CmKpQ3NRNhXpiRE5KwscVDAkpUIH7LG9jQJxI1IlpGDkVtTLpWXT3Y3Z585I1GnY4F4Q4rUOe7zwPrYbm99sfV72MFKCAte777ilPh2ZyXBW0WrMOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n9r0LJ9R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328C4C43390;
	Tue,  5 Mar 2024 12:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709640186;
	bh=79bRoIfWwTyJNE+ZvVpy+oLKq8Gm67lYHHCXczcorVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n9r0LJ9RfA/26lr6yOwdcDslL6g/pWULDLz2lup790Qe42gB6MIHIicIPKgGCUp5C
	 5bg2wfB9MJFYgFnuO+6azNvbksiLEEIGw4DFBgavYf34a6zDAD4XmVzam7aPIMZMur
	 xn7Vc6tfwLwr7etf40KCf3apgiHddiw9d7EeqCM4=
Date: Tue, 5 Mar 2024 12:03:03 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Sam Sun <samsun1006219@gmail.com>, Tejun Heo <tj@kernel.org>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	"xrivendell7@gmail.com" <xrivendell7@gmail.com>,
	hgajjar@de.adit-jv.com, quic_ugoswami@quicinc.com,
	stanley_chang@realtek.com, heikki.krogerus@linux.intel.com
Subject: Re: [Bug] INFO: task hung in hub_activate
Message-ID: <2024030557-bullwhip-stray-9db4@gregkh>
References: <CAEkJfYO6jRVC8Tfrd_R=cjO0hguhrV31fDPrLrNOOHocDkPoAA@mail.gmail.com>
 <e9d710fc-eace-44de-b3cc-1117c3575ef7@rowland.harvard.edu>
 <2024030428-graph-harmful-1597@gregkh>
 <416a8311-c725-419a-8b22-74c80207347f@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <416a8311-c725-419a-8b22-74c80207347f@rowland.harvard.edu>

On Mon, Mar 04, 2024 at 01:30:35PM -0500, Alan Stern wrote:
> On Mon, Mar 04, 2024 at 05:36:19PM +0100, Greg KH wrote:
> > On Mon, Mar 04, 2024 at 11:15:24AM -0500, Alan Stern wrote:
> > > Third, this must be a generic problem.  It will occur any time a sysfs
> > > attribute callback tries to lock its device while another process is
> > > trying to unregister that device.
> > > 
> > > We faced this sort of problem some years ago when we were worrying
> > > about "suicidal" attributes -- ones which would unregister their own
> > > devices.  I don't remember what the fix was or how it worked.  But we
> > > need something like it here.
> > > 
> > > Greg and Tejun, any ideas?  Is it possible somehow for an attribute file 
> > > to be removed while its callback is still running?
> > 
> > Yes, it's a pain, and I hate it, but I think SCSI does this somehow for
> > one of their attributes.  I don't remember how at the moment, and I
> > can't look it up (am traveling), but this should be a good hint.
> 
> Are you thinking of the sysfs_break_active_protection() and 
> sysfs_unbreak_active_protection() functions?  They seem to be the 
> appropriate ones to use here.

Yes, that sounds correct.

