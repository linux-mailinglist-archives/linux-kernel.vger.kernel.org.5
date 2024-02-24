Return-Path: <linux-kernel+bounces-79709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1068625AD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 16:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A673F28186B
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 15:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 980D345030;
	Sat, 24 Feb 2024 15:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b="uftwJAwo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L6/oMU1V"
Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EBA47784
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708786800; cv=none; b=J4g8YntNHFdBbGzzPOfNeXf5gOKTNnXlKknf/XXdPJJBmw4L3E8lYfPcGPanFwDypTIEHawFU0jvGVHMNSBvdC4RPb+VJdS6z7NMUVDfWpElPVZ5Uz6dFLe3PVMJ1CqskTN1C+vC2XDDDk+vqqxz4B53Z4NnW46Wyn/bbIEEN7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708786800; c=relaxed/simple;
	bh=D57ert1aikHKKxc2PX3l0FT959/wcAPBOlADr8Zauds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChzcG5naTUwAMp0JUlA60WwUNffEUVSpD3wwHKapueW+sHpyVxJSSCvJJJ8/d2ywxaFkJUyJUi1prOhHWmvYDmxK6lzhCdokfwU3tIzJx7UG0f882NsB/lCXv8VF6lqTipZhSSwNGtcv614voXcKAKmORWmFSvzIxWRW7GeYKZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza; spf=pass smtp.mailfrom=tycho.pizza; dkim=pass (2048-bit key) header.d=tycho.pizza header.i=@tycho.pizza header.b=uftwJAwo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L6/oMU1V; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tycho.pizza
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tycho.pizza
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3FCCE11400B4;
	Sat, 24 Feb 2024 09:59:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 24 Feb 2024 09:59:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1708786797; x=1708873197; bh=7U6/dWFNCj
	FUAWKv+H6tTOgTBliIEV5ULnfa+avk0Zw=; b=uftwJAwoye7U9hOdimb6oLl+Zt
	vKxX5wmaQG3tvio/3V/tJ7zFnlEk2ApR8ahg467zjHLnXao4Pm+cjQeXlWNkfN7u
	0axThNbjTGb3iRo/4jWKZi6K+sPMN/FF7dbHD5V34UP97kh3GgsrR+rUYnXEUrkK
	AJfaOM0xVwiKF3e786mPNjGXFemjaO7Pgh1/ch9SGr63Wq/1WRnL6DO6SWHIIyze
	sUC4m0tOrA8Q70VRmeMklhbpiVyFMAfZjVCbH0rOxpJTsplVwiuYktQadglBqvux
	zZnrJ1ZHGfe4XUGXiS72yPO36iQK48Dzh+s0zGauGO2stXnII5QciWXFvDYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708786797; x=1708873197; bh=7U6/dWFNCjFUAWKv+H6tTOgTBliI
	EV5ULnfa+avk0Zw=; b=L6/oMU1VwNKg1e5jO/K0746vp3ny8Ovkdjr7hMvCEpgx
	iFrAuTqdUxMTxMk0Y1BEIuVKOnpME67wXl2tOz1cVt5a4k2J890izHagTPk8qrmO
	DolOaCSvoXy8+CUo8MhZf3RvxV7c0N4hI+74o0EJx0d3NWFX1SpyPYkKBMVxWO2t
	XyNaA47Cfc1iJwjSGfN8e9TMqFenghmPwTV8fbYMl/3tqN3BmkboOS0Kmy4Voc6y
	2O83NqcaGP0VFKysYw0owFHiZd2KYto9e+l+q5v4EUh8USFhl5nF0RrTzioU9GlL
	8Lyd2Gj8yiT+UmaJl6A4LSU5++5Q5HF76A3Q43FTDA==
X-ME-Sender: <xms:bATaZXx98-P4C9nMP1o1WjipF-WJPCCqwnRWk4x1ezT-pwGP-NJ3Dg>
    <xme:bATaZfTxr0-Onp7BjHAAhh4hIHYGfiF8At4B2cFxhLnKqWysKMwhEnU4NoNdXgvam
    V497ZHBqXtlmIsijm0>
X-ME-Received: <xmr:bATaZRWVm50XNRbi-MgTqUh1iQiM5Kfhvnyax2cAgPgV1tXnBxYkdh3jgG9PTSY1qlBydmR2nXFG0_lwqJ21Kpsjk6fD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeekgdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigthhho
    ucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrg
    htthgvrhhnpeeutedttefgjeefffehffffkeejueevieefudelgeejuddtfeffteeklefh
    leelteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:bATaZRjEbs23dtGfuCX7CvDnXglgYZ8LfZrrfKxTScAA8NK1yqFhMQ>
    <xmx:bATaZZDSus5GgY7pFz7GtZo87JbT9HmoqmvXswURg-YQdDmUBSXiug>
    <xmx:bATaZaKjX1xmG_jvTIjtqtgF7L5G16uMIg9zy0siUsLSALPISU4NuA>
    <xmx:bQTaZc55XnCj-meErFRzQiaCmEUbk8MPHeXy7nU4966cbTtoIqC64A>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 24 Feb 2024 09:59:56 -0500 (EST)
Date: Sat, 24 Feb 2024 07:59:54 -0700
From: Tycho Andersen <tycho@tycho.pizza>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	stgraber@stgraber.org, cyphar@cyphar.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] tests/pid_namespace: add pid_max tests
Message-ID: <ZdoEavHorDs3IlF5@tycho.pizza>
References: <20240222160915.315255-1-aleksandr.mikhalitsyn@canonical.com>
 <20240222160915.315255-3-aleksandr.mikhalitsyn@canonical.com>
 <Zdd8MAJJD3M11yeR@tycho.pizza>
 <20240223-kantholz-knallen-558beba46c62@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223-kantholz-knallen-558beba46c62@brauner>

On Fri, Feb 23, 2024 at 05:24:03PM +0100, Christian Brauner wrote:
> On Thu, Feb 22, 2024 at 09:54:08AM -0700, Tycho Andersen wrote:
> > On Thu, Feb 22, 2024 at 05:09:15PM +0100, Alexander Mikhalitsyn wrote:
> > > +static int pid_max_nested_limit_inner(void *data)
> > > +{
> > > +	int fret = -1, nr_procs = 400;
> > > +	int fd, ret;
> > > +	pid_t pid;
> > > +	pid_t pids[1000];
> > > +
> > > +	ret = mount("", "/", NULL, MS_PRIVATE | MS_REC, 0);
> > > +	if (ret) {
> > > +		fprintf(stderr, "%m - Failed to make rootfs private mount\n");
> > > +		return fret;
> > > +	}
> > > +
> > > +	umount2("/proc", MNT_DETACH);
> > > +
> > > +	ret = mount("proc", "/proc", "proc", 0, NULL);
> > > +	if (ret) {
> > > +		fprintf(stderr, "%m - Failed to mount proc\n");
> > > +		return fret;
> > > +	}
> > > +
> > > +	fd = open("/proc/sys/kernel/pid_max", O_RDWR | O_CLOEXEC | O_NOCTTY);
> > > +	if (fd < 0) {
> > > +		fprintf(stderr, "%m - Failed to open pid_max\n");
> > > +		return fret;
> > > +	}
> > > +
> > > +	ret = write(fd, "500", sizeof("500") - 1);
> > > +	close(fd);
> > > +	if (ret < 0) {
> > > +		fprintf(stderr, "%m - Failed to write pid_max\n");
> > > +		return fret;
> > > +	}
> > > +
> > > +	for (nr_procs = 0; nr_procs < 500; nr_procs++) {
> > > +		pid = fork();
> > > +		if (pid < 0)
> > > +			break;
> > > +
> > > +		if (pid == 0)
> > > +			exit(EXIT_SUCCESS);
> > > +
> > > +		pids[nr_procs] = pid;
> > > +	}
> > > +
> > > +	if (nr_procs >= 400) {
> > > +		fprintf(stderr, "Managed to create processes beyond the configured outer limit\n");
> > > +		goto reap;
> > > +	}
> > 
> > A small quibble, but I wonder about the semantics here. "You can write
> > whatever you want to this file, but we'll ignore it sometimes" seems
> > weird to me. What if someone (CRIU) wants to spawn a pid numbered 450
> > in this case? I suppose they read pid_max first, they'll be able to
> > tell it's impossible and can exit(1), but returning E2BIG from write()
> > might be more useful.
> 
> That's a good idea. But it's a bit tricky. The straightforward thing is
> to walk upwards through all ancestor pid namespaces and use the lowest
> pid_max value as the upper bound for the current pid namespace. This
> will guarantee that you get an error when you try to write a value that
> you would't be able to create. The same logic should probably apply to
> ns_last_pid as well.
> 
> However, that still leaves cases where the current pid namespace writes
> a pid_max limit that is allowed (IOW, all ancestor pid namespaces are
> above that limit.). But then immediately afterwards an ancestor pid
> namespace lowers the pid_max limit. So you can always end up in a
> scenario like this.

I wonder if we can push edits down too? Or an render .effective file, like
cgroups, though I prefer just putting the right thing in pid_max.

Tycho

