Return-Path: <linux-kernel+bounces-65313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0B0854AFE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 461581F29B88
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84675810C;
	Wed, 14 Feb 2024 14:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j/M2c/3c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4D057862;
	Wed, 14 Feb 2024 14:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707919289; cv=none; b=WFfGe4/HWsJdoIB11eGL9oe/LNVY9nMWGW77RG6MO2C5fSvk4ysp5ASvP2nfA3niuhKe6t3Pwxhl5Km5E8c5NNxE3PWVQu3ps5WgBi7IKeBw0EFe1zE9aU6wnBMcdbDfMhUvNBDCcv1KLliNOYJXnq0b4a1kJigOXQMxVLt/qeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707919289; c=relaxed/simple;
	bh=7IrcdoZ+vjPqqPjNfjOphNDGS4S9Nw4aZ0rqVEytrxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+rj+OPc+pxyrVrw68NfGLWPS8Pd6XXW5HvK1xvOaRl7HOZOG1yxwIsiY9UcKov/gS4R8EZsDgSmq7Z0NXu3xHXh7efsP++6mYwSVflhU1E13R02OCC6SoEjdrgWyHmtEkjWGbBO+JltJN8WgVwgcJIcZIWDbzWRp5tprfSrpEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j/M2c/3c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C440DC433F1;
	Wed, 14 Feb 2024 14:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707919288;
	bh=7IrcdoZ+vjPqqPjNfjOphNDGS4S9Nw4aZ0rqVEytrxo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j/M2c/3cbTThd3pdkPLqPNOr4VYk61qNokoju9FQWUn7Htjn5KZSEBz+1s6+BEyGf
	 d6dvM6THbYUYzGTmj8q5spmk3LbLiJjPRCNA5J+BaPBhy1CoA0Sl9/luMUx5Qw9PaS
	 TxMsYAhesRRly5/b4y6GWqC5M6oaLi0Gyp6+0k9s=
Date: Wed, 14 Feb 2024 15:01:25 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Petr Tesarik <petrtesarik@huaweicloud.com>,
	Jonathan Corbet <corbet@lwn.net>,
	David Kaplan <david.kaplan@amd.com>,
	Larry Dewey <larry.dewey@amd.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Carlos Bilbao <carlos.bilbao@amd.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Petr Mladek <pmladek@suse.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Eric DeVolder <eric.devolder@oracle.com>,
	Marc =?iso-8859-1?Q?Aur=E8le?= La France <tsi@tuyoix.net>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nhat Pham <nphamcs@gmail.com>,
	"Christian Brauner (Microsoft)" <brauner@kernel.org>,
	Douglas Anderson <dianders@chromium.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Mike Christie <michael.christie@oracle.com>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Maninder Singh <maninder1.s@samsung.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	Roberto Sassu <roberto.sassu@huaweicloud.com>, petr@tesarici.cz,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>
Subject: Re: [PATCH v1 5/5] sbm: SandBox Mode documentation
Message-ID: <2024021425-audition-expand-2901@gregkh>
References: <20240214113035.2117-1-petrtesarik@huaweicloud.com>
 <20240214113035.2117-6-petrtesarik@huaweicloud.com>
 <20240214053053.982b48d993ae99dad1d59020@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240214053053.982b48d993ae99dad1d59020@linux-foundation.org>

On Wed, Feb 14, 2024 at 05:30:53AM -0800, Andrew Morton wrote:
> On Wed, 14 Feb 2024 12:30:35 +0100 Petr Tesarik <petrtesarik@huaweicloud.com> wrote:
> 
> > +Although data structures are not serialized and deserialized between kernel
> > +mode and sandbox mode, all directly and indirectly referenced data structures
> > +must be explicitly mapped into the sandbox, which requires some manual effort.
> 
> Maybe I'm missing something here, but...
> 
> The requirement that the sandboxed function only ever touch two linear
> blocks of memory (yes?) seems a tremendous limitation.  I mean, how can
> the sandboxed function call kmalloc()?  How can it call any useful
> kernel functions?  They'll all touch memory which lies outside the
> sandbox areas?
> 
> Perhaps a simple but real-world example would help clarify.

I agree, this looks like an "interesting" framework, but we don't add
code to the kernel without a real, in-kernel user for it.

Without such a thing, we can't even consider it for inclusion as we
don't know how it will actually work and how any subsystem would use it.

Petr, do you have an user for this today?

thanks,

greg k-h

