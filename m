Return-Path: <linux-kernel+bounces-75266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E81285E575
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C86B9285674
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF5185284;
	Wed, 21 Feb 2024 18:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ck4nE2Ck"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403D284FD8
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 18:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539712; cv=none; b=GZy7FTz3TTDrF1PBR7raBMgdv4cqAY1vMMUxFJlcG7hwNfHzKcTk37ppFlnJP2bApiVoOVvBV2X/1FvH4yQj4Gc1wUCEQFYcXZccCh7nIMHfAHr8EAtSf5tGMRBvqVuPcc95AUArluGIGW1NOb9ELO+ABg2BoGvb30LbHW3Vrkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539712; c=relaxed/simple;
	bh=DAOAHEsByKvgSlimCh6bEh2Fq6eNmoS8XzE0H/p6NiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p+HilVgOTp9V/ys5hp+ToDpXLWpIt03HF2BjCdF4Zn1cIDAOUYgqYjz/nS0fZsrWOCqsDPzcIP5eXEu3YFMPSfGMFUsql4CjyHEUkfGJjdzbgmzV6lxYZUWYVzGH8hflaP30uuMrLOwD8X5Pr4ZfWKXHF8fcAyp52+1P8XLGfzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ck4nE2Ck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACE6C433C7;
	Wed, 21 Feb 2024 18:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708539712;
	bh=DAOAHEsByKvgSlimCh6bEh2Fq6eNmoS8XzE0H/p6NiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ck4nE2Cky9tnDSQPE1MZuCROttFs+O9Arh0DLAvGa+Sk3tAr8DgEtfZ86WEGcZIMc
	 iXkn+RcpvUG0zw95/VJLHGQ46TvoK/PbbH80sxpsz94hxXd8RqSkiH7KlCUYcxjzWt
	 YsO4YnmnTDh5Y/uJlY80eoja/wwZuVkiPt4PNlkM=
Date: Wed, 21 Feb 2024 19:21:49 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	cve@kernel.org, Jiri Kosina <jkosina@suse.cz>
Subject: Re: CVE-2023-52437: Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING
 in raid5d"
Message-ID: <2024022129-expiring-resurface-146c@gregkh>
References: <7ae646b3-28e4-4344-a7a4-730a0d6e3f38@redhat.com>
 <CABgObfYDcFPRNpGtsY=UbstXbqVCMcxy3LPS_xJ65aFcByC=Nw@mail.gmail.com>
 <ZdXt09vL4GJy6PbP@sashalap>
 <0e8675e0-165d-4cf7-9755-666278868ab8@redhat.com>
 <ZdX2LcAWR6wyvYC5@sashalap>
 <bec7c1db-c13e-4b00-a968-4ae69539d7ac@redhat.com>
 <ZdYKSkqRckOc5aRO@sashalap>
 <a9652aa2-e79b-4144-b3b7-746587af9eca@redhat.com>
 <ZdYSmdUKzQAYpprc@sashalap>
 <3ebbc121-8cb8-4b8d-ad5d-fb5c576e5171@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ebbc121-8cb8-4b8d-ad5d-fb5c576e5171@redhat.com>

On Wed, Feb 21, 2024 at 04:56:31PM +0100, Paolo Bonzini wrote:
> To recap:
> 
> - the CVE description comes from was upstream commit bed9e27baf52
> 
> - neither the CVE mitigation section nor the mentioned kernel releases
> fix the bug mentioned in the upstream commit, because the mitigation
> section also includes commits that _revert_ commit bed9e27baf52
> 
> - this second revert is not mentioned anywhere, so the CVE description
> is at best misleading; or perhaps more accurately described as
> "completely f***ed up".
> 
> I'm sure it's just a bug in the scripts, but it's worrisome that you
> don't acknowledge this.

Yes, this is a bug in the scripts, but it wasn't obvious what you were
objecting to here honestly.  Reverts were not anything I tested the
scripts with before now, and I'm sure there are going to be more cases
that fail in odd ways too.  We'll fix them when they show up, that's the
best we can do.

I'll look at it tomorrow and try to figure it out, if nothing else, I'll
just manually update the json record and push the update to cve.org as
that's the "canonical" record here.  The json files will be updated over
time as new releases happen and patches flow backwards, so they will be
updated, but for now, sending out new email messages all the time would
be a mess.

However in this case, I'll fix it up and send out a new announcement as
obviously it's wrong in places.

If you want to replace the wording in the description here with anything
else better, PLEASE let us know and we will be glad to do so.

That's the benifit of being a CNA, we can ACTUALLY MODIFY the CVE
records, previously it was almost impossible to ever do so.

thanks,

greg k-h

