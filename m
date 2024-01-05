Return-Path: <linux-kernel+bounces-17552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7C9824F41
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 540CC1C2292F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 07:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3AC20333;
	Fri,  5 Jan 2024 07:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bMI3keqk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50CD20B0E;
	Fri,  5 Jan 2024 07:38:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46916C433C7;
	Fri,  5 Jan 2024 07:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704440328;
	bh=6oagLH0ZnzA9OExagj9jK3ris0AggDvZMrPRowXSBgw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bMI3keqk1NLcrjInsJm7BVPpFvf7SZ3daSntEpyGtU0FglEpxyW+WValibzVvw3X3
	 DqsXnmC2fJvOQ5D0cDhVGhM68xrmpISyuUNMCERBuygWu6ESvQU2ePk7eW/oeD/4id
	 9ibUlioQ7GYpg9MzTwnIpaIUhLXloabxMoj3k8/k=
Date: Fri, 5 Jan 2024 08:38:45 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	MyungJoo Ham <myungjoo.ham@samsung.com>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Jonghwa Lee <jonghwa3.lee@samsung.com>,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [RESEND PATCH 1/2] PM / devfreq: Fix buffer overflow in
 trans_stat_show
Message-ID: <2024010542-thespian-agreed-ff3d@gregkh>
References: <20240104215521.10772-1-ansuelsmth@gmail.com>
 <9d57f4ea-67d1-48b5-92df-c5556f95f5d6@wanadoo.fr>
 <659735f1.050a0220.efb5.1c0d@mx.google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <659735f1.050a0220.efb5.1c0d@mx.google.com>

On Thu, Jan 04, 2024 at 11:44:54PM +0100, Christian Marangi wrote:
> On Thu, Jan 04, 2024 at 11:19:44PM +0100, Christophe JAILLET wrote:
> > > @@ -1688,7 +1688,7 @@ static ssize_t trans_stat_show(struct device *dev,
> > >   			       struct device_attribute *attr, char *buf)
> > >   {
> > >   	struct devfreq *df = to_devfreq(dev);
> > > -	ssize_t len;
> > > +	ssize_t len = 0;
> > >   	int i, j;
> > >   	unsigned int max_state;
> > > @@ -1697,7 +1697,7 @@ static ssize_t trans_stat_show(struct device *dev,
> > >   	max_state = df->max_state;
> > >   	if (max_state == 0)
> > > -		return sprintf(buf, "Not Supported.\n");
> > > +		return scnprintf(buf, PAGE_SIZE, "Not Supported.\n");
> > 
> > Hi,
> > 
> > maybe using  sysfs_emit_at() could be even cleaner and less verbose?
> >
> 
> If you notice this change is done in the second patch of the series.
> This patch still use this more generic way to permit this to be
> backported on stable kernel. (older kernel doesn't have sysfs_emit_at()
> hence it can't be backported)

All activly supported kernels on the kernel.org front page have
sysfs_emit_at(), so this should not be an issue for anyone.  Just do the
change here at the same time.

thanks,

greg k-h

