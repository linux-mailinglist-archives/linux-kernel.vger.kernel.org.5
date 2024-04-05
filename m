Return-Path: <linux-kernel+bounces-132350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BDD89936F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 04:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA6DB1C21E52
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 02:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EF618049;
	Fri,  5 Apr 2024 02:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="dCTQlyw0"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED1E171AD
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 02:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712285703; cv=none; b=kFe0QnOarOr3Bp310W0gEOfG9XC7UaZPzjV1ImqdLRBs5FuHf54VDsKvmKzoaaDWRPLdF5742CjFnXttDgSVSLHmsCXOPK4AiICU6iym5dQu9TdM7axNV9kc80tcpAzonAleRbwckCI9YlYOY8gxHiX1BrpW3o4+hATG6mVewWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712285703; c=relaxed/simple;
	bh=e9llrihK5byMhFHIZeeQIEult4uk6A4t2h+EPc40sOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9893c4Idcoz/vnSooFNIqlxvYUzVSAnZHnlgLk/UVBxATduhclaJnxRFcsmic3/sn5R2zFitywSSObnJw5798Qcm9c4ltINwDbWlvJrx0CMw/i6i/cyucjfrnOubwGDkictTLjGqpnWEG9xnEvSZ3NuCPzhbZs33F3nHY3huBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=dCTQlyw0; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-113-2.bstnma.fios.verizon.net [173.48.113.2])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 4352sd5s002237
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 4 Apr 2024 22:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1712285681; bh=IJ37NqUIwrNgsAizQ/y4TjAF/Vi8qw2ku0kzM5T3adk=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=dCTQlyw09B6Td81OI8jDSAxF6BsliQVkPSB7Jq91t2UhCtgrwS+2ooW6RYGWiH/B+
	 ktnMR9n5/F6Keh44Aie/6pV/i8UzZJzYcjusIZLVUV7HxHOwzoBhEFfOTiwrEPz66J
	 NePPwwfcPJyFsbTo9XCv6906aqqoBRNYzR3kpWboLlYqEs/iDQwZ09/+ochVUIKmMG
	 jI8Zw31xeYY1btJR1zaM2GPUhwiVhxgnKP+tbnk1Oq1I/5Vk5rF4y7eFXyhSb9BdfR
	 mvgK2kq0Micr5uyAdkcq7aF82MGtOEBCX28JV9OEq2dpVjXBekr7t9sUJ2i33JKPFX
	 K7PRZY9weZmEQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id AFE3115C00DE; Thu,  4 Apr 2024 22:54:39 -0400 (EDT)
Date: Thu, 4 Apr 2024 22:54:39 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Greg KH <gregkh@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Do we need a "DoNotBackPort" tag?
Message-ID: <20240405025439.GC13376@mit.edu>
References: <ce4c2f67-c298-48a0-87a3-f933d646c73b@leemhuis.info>
 <ZgylCe48FuOKNWtM@slm.duckdns.org>
 <b6cdb17f-206c-4dff-bb45-a60317e0a55e@leemhuis.info>
 <2024040328-surfacing-breezy-34c6@gregkh>
 <Zg10Keik4KORjXMh@slm.duckdns.org>
 <2024040319-doorbell-ecosystem-7d31@gregkh>
 <dfd87673-c581-4b4b-b37a-1cf5c817240d@leemhuis.info>
 <2024040454-playful-tainted-7446@gregkh>
 <8488e647-d2f4-484f-939f-eb827802d5c6@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8488e647-d2f4-484f-939f-eb827802d5c6@leemhuis.info>

On Thu, Apr 04, 2024 at 05:56:58PM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> 
> I know, as I wrote that (as you likely remember). ;-) But it seems it's
> not well known; and maybe making it explicit that this can be used to
> convey a "DoNotBackport" message is supported as well.
> 
> Guess I'll prepare a patch to do that then and we'll see how it goes
> from there.

Maybe something like "ManualBackportOnly"instead?   The basic idea is
that it's not that the commit should *never* be backported, but only
with human intervention where someone has specifically requested the
backport, perhaps with qualification test.

(For example, the XFS file system has an implicit ManualBackportOnly
on all commits, and the XFS stable maintainers are responsible for
backporting identifying commits with Fixes: tags, and running QA
before passing on a request to having them be backported.)

              	       	    	       - Ted

P.S.  I'd love to be able do something equivalent for ext4, if we
could scare up the resources to do the same, in terms of having some
company fund the necessary developer resources, or someone turn up to
volunteer to do that for ext4.  Gentle reader, if that's you or your
company --- let's talk.  :-)

