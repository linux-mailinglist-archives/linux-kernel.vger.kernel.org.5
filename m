Return-Path: <linux-kernel+bounces-22256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E77829B7C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91C7E1C2224C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292D64A994;
	Wed, 10 Jan 2024 13:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="WF1+wJ1D"
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1863348CC7;
	Wed, 10 Jan 2024 13:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Received: from mail-auth.avm.de (unknown [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Wed, 10 Jan 2024 14:37:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1704893836; bh=LCuaVe73rplzywlFwA0UbIaUH/rZvyTsPAJWHyMOIqw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WF1+wJ1DyBUf0s9manoHhCKw6x54DY1H92W7WuZRRZs0bBODb12Nhln7ZT8zZ1pIA
	 Rdf5uKFe5DgtlaY9zFeKzq8+GGsNjQpdRyY2N/fwl7DfljsjNlioJBsqS22+nm33C6
	 pf/GMRT5TqZPlxTJArZ2Ddg8B4OiOwlRjnVUK7y8=
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id 7B3DD803AB;
	Wed, 10 Jan 2024 14:37:17 +0100 (CET)
Received: by buildd.core.avm.de (Postfix, from userid 1000)
	id 6E2B81812A6; Wed, 10 Jan 2024 14:37:17 +0100 (CET)
Date: Wed, 10 Jan 2024 14:37:17 +0100
From: Nicolas Schier <n.schier@avm.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] kbuild: deb-pkg: make debian/rules quiet by default
Message-ID: <ZZ6djUvyyJPiduL4@buildd.core.avm.de>
Mail-Followup-To: Masahiro Yamada <masahiroy@kernel.org>,
	linux-kbuild@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	linux-kernel@vger.kernel.org
References: <20231230135200.1058873-1-masahiroy@kernel.org>
 <20231230135200.1058873-2-masahiroy@kernel.org>
 <ZZ1UxkCgKQ9J6Iut@reykjavik.ads.avm.de>
 <CAK7LNATdFdLfw4Xg9C29_X1iEun4kmgccFbW=Nvqkk2LFzewsA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNATdFdLfw4Xg9C29_X1iEun4kmgccFbW=Nvqkk2LFzewsA@mail.gmail.com>
Organization: AVM GmbH
X-purgate-ID: 149429::1704893836-A0FDFDFE-E8347147/0/0
X-purgate-type: clean
X-purgate-size: 1060
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate: clean

On Tue, Jan 09, 2024 at 11:46:49PM +0900, Masahiro Yamada wrote:
> On Tue, Jan 9, 2024 at 11:14 PM Nicolas Schier <nicolas@fjasle.eu> wrote:
> >
> > On Sat, Dec 30, 2023 at 10:51:57PM +0900, Masahiro Yamada wrote:
> > > Add $(Q) to commands in debian/rules to make them quiet when the package
> > > built is initiated by 'make deb-pkg'.
> > >
> > > While the commands in debian/rules are not hidden when you directly work
> > > with the debianized tree, you can set 'terse' to DEB_BUILD_OPTIONS to
> > > silence them.
> >
> > Reading Debian Policy §4.9 [1] I'd expected some fiddling with V=1 or
> > 'make -s', but I am ok with the simple '@' silencing (which matches my
> > personal preference).
> 
> 
> Hmm, you are right.
> 
> 
> Maybe, we should follow what the Debian kernel does.
> 
> Debian kernel sets KBUILD_VERBOSE=1 unless
> 'terse' is given.
> 
> 
> https://salsa.debian.org/kernel-team/linux/-/blob/debian/6.7-1_exp1/debian/rules.real#L36

yes, I think it makes sense to do the Debian way.

Kind regards,
Nicolas

