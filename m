Return-Path: <linux-kernel+bounces-87086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C066F86CF3A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C25728AC1C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF3F757E7;
	Thu, 29 Feb 2024 16:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QMkvyfId"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE2D70AF5;
	Thu, 29 Feb 2024 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709224177; cv=none; b=YrbqZRA8qUQj/fPV+d30zUBxCq+qte1pbxYDsE+zwojmzTBwzCUZ16o5KyQKjzBNd1GwJ+VaRLxR5CsvQvWJvYltB9pAMQkY+wvpee7KXuJJ001OciOF4H3atoYqHLiXKfY/P7fVrtYLkW3MUviO7QO8kH6oEJfEkGlS2FLA+W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709224177; c=relaxed/simple;
	bh=SBH3IxdEplFFcD11L2ZgQ0Oq6K4q8knEjTbHRPm5G2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O6IKTj83XtaJk7Sq7b2rSmsVB/SVaTf/p5rXYgRjfQJx8QwP6MNjQUbHtRyxuZ0kjMjJwfE+J8mPATuvdjB/5zk/fhG5S9z+aiHA5W8z1+nq7vOx9NYyRB4D+tFTYMsE3+B7lx9LtrgGzT9Art+2HENzBHlSBwI7XljGLqXxzkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QMkvyfId; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709224175; x=1740760175;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=SBH3IxdEplFFcD11L2ZgQ0Oq6K4q8knEjTbHRPm5G2c=;
  b=QMkvyfIdLzSqQyJk4rYcOov+MOgPBRJjf7kxqbLC25xNC73BcOxCUFVo
   Qura5aocR6DYKFfIkI/tgooO62J0Xpxk7feFq/bEhfQx4AIlMO7zRi0yS
   vHabELCxtwe9b6vA/4i2KwfmuXqOxtIf+SOkzkwXDikKB+W9fmk0h7MNk
   Q6gqDEfShf7TtMjW242j8qtPe32en61BE+4bD32h8IA+cSBLLb/HT1CNJ
   TcqSpCFzbjSR18LmNUGhCSmL/zlFfQ3wafR/A04cDgJVno92gtoJCc8Ab
   dIZHXpNGT2ZS2BlsBN421GVhjaJOqpA1a2Gn2BON0cISDzs3oaIDRPpSm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3575528"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3575528"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 08:29:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="913986033"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="913986033"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 08:29:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rfjHa-00000008ijg-1Qdj;
	Thu, 29 Feb 2024 18:29:18 +0200
Date: Thu, 29 Feb 2024 18:29:18 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] gpiolib: Fix the error path order in
 gpiochip_add_data_with_key()
Message-ID: <ZeCw3pzHdrXw46of@smile.fi.intel.com>
References: <20240221192846.4156888-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=MdvYdx6x=gSiOZ3SXAdJORnqhsNW79G2c7wABofWARwFw@mail.gmail.com>
 <ZddLRAqxFr7v3Zqs@smile.fi.intel.com>
 <CAMRc=Mdxtx-wh3HGu+SNrCwfSq0PEm3fG7hK_6wPAk2uzk8xpA@mail.gmail.com>
 <ZddOKTP73ja6ejTc@smile.fi.intel.com>
 <CAMRc=Mf_w_E4B7c_Uj1WV3zv9DbmJ22oFvJJwtd-+3oUDVcvXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mf_w_E4B7c_Uj1WV3zv9DbmJ22oFvJJwtd-+3oUDVcvXA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 22, 2024 at 02:39:28PM +0100, Bartosz Golaszewski wrote:
> On Thu, Feb 22, 2024 at 2:37 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Feb 22, 2024 at 05:33:59AM -0800, Bartosz Golaszewski wrote:
> > > On Thu, 22 Feb 2024 14:25:24 +0100, Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> said:
> > > > On Thu, Feb 22, 2024 at 10:37:06AM +0100, Bartosz Golaszewski wrote:
> > > >> On Wed, Feb 21, 2024 at 8:28 PM Andy Shevchenko
> > > >> <andriy.shevchenko@linux.intel.com> wrote:

..

> > > >> >         gpiochip_irqchip_free_valid_mask(gc);
> > > >> >  err_remove_acpi_chip:
> > > >> >         acpi_gpiochip_remove(gc);
> > > >> > +       gpiochip_remove_pin_ranges(gc);
> > > >> >  err_remove_of_chip:
> > > >> >         gpiochip_free_hogs(gc);
> > > >> >         of_gpiochip_remove(gc);
> > > >>
> > > >> This undoes machine_gpiochip_add() and I think it also needs to be
> > > >> moved before acpi_gpiochip_remove().
> > > >
> > > > You mean it should be like
> > > >
> > > >        gpiochip_irqchip_free_valid_mask(gc);
> >
> > > >        gpiochip_free_hogs(gc);
> >
> > But should it be here...
> >
> > > > err_remove_acpi_chip:
> >
> > ...or here?
> >
> > I'm sorry I really need more (morning) coffee, maybe you can simply update
> > yourself or submit a correct fix?
> 
> Ok, I'll apply this and send a fix on top of it.

I don't see any progress with this. Do I need to do something?

-- 
With Best Regards,
Andy Shevchenko



