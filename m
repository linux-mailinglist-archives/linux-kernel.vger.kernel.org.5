Return-Path: <linux-kernel+bounces-122780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D855688FD26
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21F7DB28D87
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254E97C6D5;
	Thu, 28 Mar 2024 10:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fZDuX3ZL"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD092561D;
	Thu, 28 Mar 2024 10:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711622028; cv=none; b=UP6g8/KH3sKc3nDlT/5gbgkqp//0dTlo9k/gR6hkXDG/gzLFdVb6VE/4FDqaFTdoW9V3nb36igA8F2dnKJBc46nr7rj51BvyQVOgdBCDVMPd08BIZsufqH0HSAVAzrkQ0uZYteymLzAzkJLl+J5t2DlM2rAwH4obHMDV96W7ptY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711622028; c=relaxed/simple;
	bh=OVALdI1w8Y5mN9IU9xR+T3K7yhcGZNMc4Vt/TYPpm/8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHCzzHx73oEmhOgQJ2hpZ6ma8xhCh/KCDaIwbezbpMkCH3JZSvVWlhKSH1MpN39mUmqpvlyF4fWFTakoPJ4XmVFny+WJgxG4whSG3PYkHEifl3PBUEAyBgzHlgpsJJnFp6nZxvmJ1EIy5jJFPRXB5hpbeojzdktZUu2JtHTfF6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=fZDuX3ZL; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42SAXF9a020364;
	Thu, 28 Mar 2024 05:33:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711621995;
	bh=u481CXysCbg/7oYNWvsfepiT4MxiwQGwVYQbpgRBaNg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=fZDuX3ZLFC3AztKK12GOETXs8erBT6xhL8TsKlz0bmHhHjM2WDYEiwdnnLG/0aNVx
	 sdZwn8LuToew8OwutwwWAD9cs95fAmwsinj6bgs6PF9ApLnjuZM+UxXuAZPtpQXSLh
	 lBXsyohwB2kGOTNj6Pje0dCYY+La72jk2v1HLA34=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42SAXF77042178
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 28 Mar 2024 05:33:15 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 28
 Mar 2024 05:33:12 -0500
Received: from fllvsmtp7.itg.ti.com (10.64.40.31) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 28 Mar 2024 05:33:12 -0500
Received: from localhost (dhruva.dhcp.ti.com [172.24.227.68])
	by fllvsmtp7.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42SAXBDU057525;
	Thu, 28 Mar 2024 05:33:11 -0500
Date: Thu, 28 Mar 2024 16:03:10 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Tony Lindgren <tony@atomide.com>, Jiri Slaby <jirislaby@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Petr Mladek <pmladek@suse.com>,
        Steven
 Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        "David S . Miller"
	<davem@davemloft.net>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
        Johan Hovold
	<johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, Sebastian Reichel <sre@kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v7 4/7] serial: core: Add support for DEVNAME:0.0 style
 naming for kernel console
Message-ID: <20240328103310.hd4z2bt6cvje5hbo@dhruva>
References: <20240327110021.59793-1-tony@atomide.com>
 <20240327110021.59793-5-tony@atomide.com>
 <20240328063152.bjkdtdsu42cqbgf3@dhruva>
 <2024032859-subscript-marshy-7508@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2024032859-subscript-marshy-7508@gregkh>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On Mar 28, 2024 at 08:22:26 +0100, Greg Kroah-Hartman wrote:
> On Thu, Mar 28, 2024 at 12:01:52PM +0530, Dhruva Gole wrote:
> > Hi,
> > 
> > On Mar 27, 2024 at 12:59:38 +0200, Tony Lindgren wrote:
> > > We can now add hardware based addressing for serial ports. Starting with
> > > commit 84a9582fd203 ("serial: core: Start managing serial controllers to
> > > enable runtime PM"), and all the related fixes to this commit, the serial
> > > core now knows to which serial port controller the ports are connected.
[...]
> > >  
> > > +#ifdef CONFIG_SERIAL_CORE_CONSOLE
> > > +
> > > +static int serial_base_add_one_prefcon(const char *match, const char *dev_name,
> > > +				       int port_id)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = add_preferred_console_match(match, dev_name, port_id);
> > > +	if (ret == -ENOENT)
> > > +		return 0;
> > > +
> > > +	return ret;
> > 
> > Can we do this instead?
> > return (ret == -ENOENT ? 0 : ret);
> 
> No, please no.
> 
> Just spell it out, like was done here, dealing with ? : is a pain to
> read and follow and the generated code should be identical.
> 
> Only use ? : in places where it's the only way to do it (i.e. as
> function parameters or in printk-like lines.)
> 
> Write for people first, compilers second.

Okay understood, I will keep this in mind from now on.
Thanks.

Tony,
Please feel free to take my R-by and ignore this suggestion as per
Greg's comments.

-- 
Best regards,
Dhruva

