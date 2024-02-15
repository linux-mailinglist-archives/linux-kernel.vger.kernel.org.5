Return-Path: <linux-kernel+bounces-66307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48077855A1B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 06:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A0DC28A61E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 05:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E768F6F;
	Thu, 15 Feb 2024 05:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gAsZIq6m"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC204A12
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 05:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707974797; cv=none; b=YfQN50WCNh/hDvYP7vnea+jN2vLKk3giqY23YheOq+dDJD/7lzqmaWeeqvizSDAMHRrIFJylsAjcdN2ICGaSRTNJ3YPJZ+AwpaChw0ScX/EM5cttfsXsHtwOWU7McA+E2/MVE5G09N4epkogtqdQzfHuPCIp5QFYhl04Di6dqiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707974797; c=relaxed/simple;
	bh=69d7yyGOhafB8n+tO0/rE6tu86/aKk9s+8wh0ogxSR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dVCgsC0NKVQDy/0sPBBjHutOup3Uciow/013HI6RVnwe9tjHuEqIkkCAfbuRKrq+77cZ0wgNA5HBwVPlrtMUdYQxeMB+SqM2x7OgbjbADhU+N8TDZyVa+IOsr2tXBeVwE5SA/hGVNWa/soZubmOmFxsAU5ayAOsZcXVRlfCWih4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gAsZIq6m; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=eZo2FbCPntW9rqcvihdnTz8OuF3PfVFZ9HRVPVJYEg0=; b=gAsZIq6mYuoItec7Y9FJ+4dmeX
	O56C4eDD+7jlBSdEd0c5V4f9+Yx2v5bASbBYS8Dvha+6g/zBomsQZx0SfA6NzWtgLr+7iwTOMDBd5
	aHjgZ/p3a5KcA48K+OTNXDAVZDHhQX0LQO+ztPw8xdV3Jh78hOVtiO2ERHOUkZoKx+OohYlMu0WTe
	Gzo2G/U4fXF0H/gRF5CL3Df03hc3SqL8H63YenpP9epkEG/tarxqZhGA/vz85sxvNaLCvLGmSpXLV
	7/+EnQVNBADWrLdT/gApc8ahrT3svwO2j3bKDBEjTUMpaLdY4mkA2CSP9XxZ1uUsJjLF2g4Y9BzB/
	3rmbzFEw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raUGY-0000000F1Ul-3zaX;
	Thu, 15 Feb 2024 05:26:34 +0000
Date: Wed, 14 Feb 2024 21:26:34 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	fuyuanli <fuyuanli@didiglobal.com>
Subject: Re: [PATCH] kernel/hung_task.c: export sysctl_hung_task_timeout_secs
Message-ID: <Zc2giqMeZhxuDSU9@infradead.org>
References: <20240209070935.1529844-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240209070935.1529844-1-kent.overstreet@linux.dev>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Feb 09, 2024 at 02:09:35AM -0500, Kent Overstreet wrote:
> needed for thread_with_file; also rare but not unheard of to need this
> in module code, when blocking on user input.
> 
> one workaround used by some code is wait_event_interruptible() - but
> that can be buggy if the outer context isn't expecting unwinding.

I don't think just exporting the variable ad thus allowing write
access is a good idea.  If we want to keep going down the route of
this hack we should add an accessor function that returns the value.

The cleaner solution would be a new task state that explicitly
marks code than can sleep forever without triggerring the hang
check.  Although this might be a bit invaѕive and take a while.


