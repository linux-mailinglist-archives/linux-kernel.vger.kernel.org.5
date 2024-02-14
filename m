Return-Path: <linux-kernel+bounces-65833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A268085529C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57C551F2D3BF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A54C13A86A;
	Wed, 14 Feb 2024 18:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U+4WPR7F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542F313A262;
	Wed, 14 Feb 2024 18:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707936536; cv=none; b=XdVRKPISpgtKbxAkL+hdDAHq3UdxW+esgWTac07GhBTAn2fyzCkLt5+kZyPmjD/HxFLlxQDsaV6FEPeaqVRkUq44fmsCTxwsNFcWeegMS5CDKR5z6eeIZs/EhkwcAKIt/6fpFia+tR2d5L4tfX6T5EKUGJz1eId505rHGJYE7Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707936536; c=relaxed/simple;
	bh=ejiWvMBTFfDP5bYwemxPHCGB5A7hNC8yP0sXjxxKzhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dfb2JgiIlNyMaWTZEJq+knUi70zbAt8DQC1Nlo8VH0I2iDWF+nu0MuANEbXWTy/MWEOiRyRjO2CWxPuu8muL0aYoyZzDKpnGbJFWlzoX+ledO9p02Ut4EN533e/Nhxms9Vna/TZBG7Y44RCzSyeHLJKciMstezXz5WPNR1mce2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U+4WPR7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE04C433C7;
	Wed, 14 Feb 2024 18:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707936535;
	bh=ejiWvMBTFfDP5bYwemxPHCGB5A7hNC8yP0sXjxxKzhg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U+4WPR7F+47WH60A3+xBF8axrzPeVAgwicuRlfc9bYhYJrvhtOwpLzXZ7qvEGQDng
	 qRdBIJQI1aIdcuCJFL0aAZRTqMMRJ9pBxBZrwOWp4dtlNvW8kLLpaT8+02Dwvx1aLf
	 CGhn3AYWvzcALYu4/qR3qe51l2t4eNN05rB6IPuY=
Date: Wed, 14 Feb 2024 19:48:52 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Petr Tesarik <petrtesarik@huaweicloud.com>,
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
	Roberto Sassu <roberto.sassu@huaweicloud.com>,
	Petr Tesarik <petr.tesarik1@huawei-partners.com>
Subject: Re: [PATCH v1 5/5] sbm: SandBox Mode documentation
Message-ID: <2024021417-magma-drudge-ad70@gregkh>
References: <20240214113035.2117-1-petrtesarik@huaweicloud.com>
 <20240214113035.2117-6-petrtesarik@huaweicloud.com>
 <20240214053053.982b48d993ae99dad1d59020@linux-foundation.org>
 <2024021425-audition-expand-2901@gregkh>
 <20240214155524.719ffb15@meshulam.tesarici.cz>
 <2024021415-jokester-cackle-2923@gregkh>
 <20240214173112.138e0e29@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240214173112.138e0e29@meshulam.tesarici.cz>

On Wed, Feb 14, 2024 at 05:31:12PM +0100, Petr Tesařík wrote:
> On Wed, 14 Feb 2024 16:11:05 +0100
> Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> 
> > On Wed, Feb 14, 2024 at 03:55:24PM +0100, Petr Tesařík wrote:
> > > OK, so why didn't I send the whole thing?
> > > 
> > > Decomposition of the kernel requires many more changes, e.g. in linker
> > > scripts. Some of them depend on this patch series. Before I go and
> > > clean up my code into something that can be submitted, I want to get
> > > feedback from guys like you, to know if the whole idea would be even
> > > considered, aka "Fail Fast".  
> > 
> > We can't honestly consider this portion without seeing how it would
> > work, as we don't even see a working implementation that uses it to
> > verify it at all.
> > 
> > The joy of adding new frameworks is that you need a user before anyone
> > can spend the time to review it, sorry.
> 
> Thank your for a quick assessment. Will it be sufficient if I send some
> code for illustration (with some quick&dirty hacks to bridge the gaps),
> or do you need clean and nice kernel code?

We need a real user in the kernel, otherwise why would we even consider
it?  Would you want to review a new subsystem that does nothing and has
no real users?  If not, why would you want us to?  :)

thanks,

greg k-h

