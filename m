Return-Path: <linux-kernel+bounces-64886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D91CA854444
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:49:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 187FC1C20752
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813C77499;
	Wed, 14 Feb 2024 08:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="Xokx9Rem"
Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42340BE49;
	Wed, 14 Feb 2024 08:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707900582; cv=none; b=RfG4Zq/GZiO2s8BGONADmv8wSTNfutO/I+17OYoCYQhCL4n129NpAyjZdZi9TCh3X3KSakLfDgZVA+qaW+HFWaP00AAB6rMcWtvf0W00BZh9SuikDTi8tYEP/icE4SuR6i0gpjGPjvH++m2lD3ZpxZlm1Ivrg5/vpwZRSWrehts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707900582; c=relaxed/simple;
	bh=0dKOTDFFev2XaGHESEFJjmbPJOyKhxlyotONPs2LaXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pR163+LtP6er+h/gJ74hj4+keta6+dhquMjJlr4D6iIbLzxB3nIcwUC7W1cssDK7GU70jB7Zm1o0HA4OfZ5xAHjSkhJKgEnX8UCIrj+qhRLqsOBzwCo1v1pdOomkgFDv/Rhm3YNTXVpXIPEI9oJfhQI6z9ZJVOLaE6L2/c0NudY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=Xokx9Rem; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id 63DE2604D9;
	Wed, 14 Feb 2024 08:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1707900579;
	bh=0dKOTDFFev2XaGHESEFJjmbPJOyKhxlyotONPs2LaXw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xokx9Rem2bTGe6OoCJMTUymjnOpkhfs2wKfwa81amGnWyPQNQRUCzKghQ79kHEt9l
	 CpEFfiyJz3ULwL/CapDajR49g0HTMOqouBlfZhccDP4pHA29Zia5FiuoPlohR/sZy7
	 gP1GlM6GqBspogeXJ+C5fBEjTjubpgmqstNLeeqRMWV401xJEobDtsWYZqdYU4NaQZ
	 OlMiNgO9PaxUG6axd6ZxDKM5sXJZGU/KF9FlIgEiQLf2uUwb5xdPqv4/Qdbt0gjJN4
	 lEZaMyOT9oGzrAXkFKvujbegLoNSUwK5mf1KQNaOGcyT68f1NLYQWLzggMGF1092yE
	 C+XT+uMou7/pw==
Date: Wed, 14 Feb 2024 10:49:05 +0200
From: Tony Lindgren <tony@atomide.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	"David S . Miller" <davem@davemloft.net>,
	Dhruva Gole <d-gole@ti.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Johan Hovold <johan@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH v6 1/6] printk: Save console options for
 add_preferred_console_match()
Message-ID: <20240214084905.GP52537@atomide.com>
References: <20240213084545.40617-1-tony@atomide.com>
 <20240213084545.40617-2-tony@atomide.com>
 <Zcub1bQrDqHE0Mkt@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zcub1bQrDqHE0Mkt@smile.fi.intel.com>

* Andy Shevchenko <andriy.shevchenko@linux.intel.com> [240213 16:42]:
> 		strscpy(con->name, str, namelen);
> 		strscpy(con->opt, opt, optlen); // not sure if emptying opt is okay

The strings above now get terminated too sort with the + 1 removed,
I suggest we use what we already do for brl_opt:

		strscpy(con->name, str, CONSOLE_NAME_MAX);
		strscpy(con->opt, opt, CONSOLE_OPT_MAX);

Regards,

Tony

