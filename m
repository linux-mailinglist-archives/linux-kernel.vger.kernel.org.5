Return-Path: <linux-kernel+bounces-73561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 499FB85C430
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF73E1F24072
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4D413958E;
	Tue, 20 Feb 2024 19:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MyQpiTk6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD2D6A01C;
	Tue, 20 Feb 2024 19:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708455652; cv=none; b=ha4Jm4AjN6DEZZjgx6UXtv5nGGmWDZQ5Zr5sJGqxMh2BHRLc9uSAhx8fihSo3CVCb8AK4BJlsKXZNWWhlVbxod3QkamBSoZDyc1oAWgsFvxjHJohKPmymaHVWAe29Gz7x9TFDUyXeszxYumAHEegZQhdzGSa8h6n1+FBKqFcas4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708455652; c=relaxed/simple;
	bh=I3DIUhiFiCChc1O+UyL6/snCDIRq/dn4PEK9wZxLEdg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rsYQ5jDc7rrUW82dslm+fINfK+5CpOGp2Pu7KyTbFaRTRgkX8iA9fDa3RaXUwO5ale1w/bdwsJ+pOj6D3Y1SPLzMw8YhOpI2mzOWPWpgfmVvSfRy2Wr70xk6xIN052HvcL5Guec450CIUamf1vSF64ZKSMZUBzRRXRqSVBbzKUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MyQpiTk6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63240C43390;
	Tue, 20 Feb 2024 19:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1708455651;
	bh=I3DIUhiFiCChc1O+UyL6/snCDIRq/dn4PEK9wZxLEdg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MyQpiTk6TotHP19bqN2ewPLAav5vz4wjYsaAhqdB94ym2nOGp4eeE+BpKSnxEckIg
	 uYawJ5U6YG2yUcCWWM63G1dUYcXtU0kBihYPMzkNxzEByyU7Iiu6Dre5W6MqvoyUYE
	 nkL0lb2mshdzM/71k2IehiHwOcjb3/3tcIwNQ4cw=
Date: Tue, 20 Feb 2024 11:00:50 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: willy@infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, gost.dev@samsung.com, p.raghav@samsung.com,
 da.gomez@samsung.com, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] test_xarray: fix soft lockup for advanced-api tests
Message-Id: <20240220110050.210b1f2866d2c80716d021e8@linux-foundation.org>
In-Reply-To: <ZdTlL3UvlyrfpBlt@bombadil.infradead.org>
References: <20240216194329.840555-1-mcgrof@kernel.org>
	<20240219182808.726500bf3546b49ac05d98d4@linux-foundation.org>
	<ZdTlL3UvlyrfpBlt@bombadil.infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Feb 2024 09:45:19 -0800 Luis Chamberlain <mcgrof@kernel.org> wrote:

> > > --- a/lib/test_xarray.c
> > > +++ b/lib/test_xarray.c
> > > @@ -781,6 +781,7 @@ static noinline void *test_get_entry(struct xarray *xa, unsigned long index)
> > >  {
> > >  	XA_STATE(xas, xa, index);
> > >  	void *p;
> > > +	static unsigned int i = 0;
> > 
> > I don't think this needs static storage.
> 
> Actually it does, without it the schedule never happens and produces the
> soft lockup in the splat below.:

OK, I'll restore that.

