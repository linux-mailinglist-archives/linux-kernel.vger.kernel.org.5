Return-Path: <linux-kernel+bounces-66821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D1A8561E3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABDE3296508
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ABC212BEAC;
	Thu, 15 Feb 2024 11:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MTijY09q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604C212A172;
	Thu, 15 Feb 2024 11:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707997161; cv=none; b=Q879AfXItyy+Fvn4ZWeLCXP5vCmIAN9SyhQ7AiccM/X8qDqzksUbR5447ybomTjbtLw8SEmCTDCeAj+O/x8Q48iRfx4YgPmC/C/wG5NDODb7N44UJr2ikywKBtmjn6uliRNESINQVYckJGsxX6ndWpei3CX/fGaxwzWNl0eVo6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707997161; c=relaxed/simple;
	bh=s4qXPF9/xMcTwOJSQh6uOh6iy6zFV6dHuV6VibIyPN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BthXWpr5m4nogUhrEbwnLSTSLnvuYZxPUmBlkZGiXSAXIUsx6W1F/wKkG8lB7r/dpz08x+bJOWKCTGNctoRFRNM39h3HgzFHL7ha6ziVSkM8cNT4D6uDrMaZpMI/npMsJ2kgymIApp7GQe3YlAQ9BpKDFG2TU5NjR1zpfpy/aOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MTijY09q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25864C433F1;
	Thu, 15 Feb 2024 11:39:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1707997160;
	bh=s4qXPF9/xMcTwOJSQh6uOh6iy6zFV6dHuV6VibIyPN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MTijY09q6lC2TTBkKE8UXHiQanU6XyGYlee5r/B3fJvRFcFBWKTZS0g7GAmj96q6W
	 T76iFd/UedsrdBTSlbpEyxmZGPKasAmL+aTGS0wAbOvFXYPJBRmnijf2mbEvjGWrp7
	 d89gE8VipCnKFfjhr+vOTj90j/BRVQnw3CQtH5gY=
Date: Thu, 15 Feb 2024 12:39:17 +0100
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
Message-ID: <2024021534-antibody-routing-466e@gregkh>
References: <20240214113035.2117-6-petrtesarik@huaweicloud.com>
 <20240214053053.982b48d993ae99dad1d59020@linux-foundation.org>
 <2024021425-audition-expand-2901@gregkh>
 <20240214155524.719ffb15@meshulam.tesarici.cz>
 <2024021415-jokester-cackle-2923@gregkh>
 <20240214173112.138e0e29@meshulam.tesarici.cz>
 <2024021417-magma-drudge-ad70@gregkh>
 <20240214204254.6208ca2f@meshulam.tesarici.cz>
 <2024021514-manmade-ambitious-414a@gregkh>
 <20240215104515.2075577e@meshulam.tesarici.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240215104515.2075577e@meshulam.tesarici.cz>

On Thu, Feb 15, 2024 at 10:45:15AM +0100, Petr Tesařík wrote:
> As a matter of fact, hpa does not like the x86 implementation. For
> reasons that I do not fully understand (yet), but if the concept turns
> out to be impractical, then my submission will serve a purpose, as I
> can save myself (and anybody else with a similar idea) a lot of work by
> failing fast.
> 
> Is this a valid way to get early feedback?

Asking for feedback is one thing (that's what RFC is for, right?), but
submitting something and expecting us to review and accept it as-is like
this, just doesn't work well.

thanks,

greg k-h

