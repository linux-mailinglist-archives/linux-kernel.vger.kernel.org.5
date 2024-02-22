Return-Path: <linux-kernel+bounces-76548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FCB085F8EB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A89A287730
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6983EA68;
	Thu, 22 Feb 2024 12:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WzlGaLhf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD7D12DD96
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 12:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708606522; cv=none; b=M+/fd7dKH1D2bxFbYrZefWxUXF0Ac2DgBi+9tVkD+eW0BlvtbnM7rRds5ggJ6N2eu9feO82rkO8mIAXJLXBiVIGLqbTi76U1brZ29+G/p9CDmVs7xKYUpOK16Ulk0Vhw8MnAx9S6vYzya7UIUlc2+KzuRaWpOCUd6FtMK9WblwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708606522; c=relaxed/simple;
	bh=JWE9cZb4lklCT3XndAAWLvX2LhoU45SKHoC+Zy0rGFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VUZ3T1uYp4aByaXpeYTIsph3Wvv47WAKgZfeRz4i+FXI+L9+2KzQqNwWtv9hA3HCD+p1oDNxUapqyhVrKamWXxwyxkNTQOj8YAI3UiqsHhYbFW+LGXe3L8qCS1inwgCiBpk4yy9GIcRiLwLp2K4tv6wyxEH29BQN+06iuYnU2vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WzlGaLhf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E063C433F1;
	Thu, 22 Feb 2024 12:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708606521;
	bh=JWE9cZb4lklCT3XndAAWLvX2LhoU45SKHoC+Zy0rGFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WzlGaLhf9GEXHCEa/LPqZgDnoXwavfbBvKjO+fTr96bDgw7FDkYhT+i/iZMLsIFV5
	 eALN91NjneRTVYknzUIB/lDCVmcbj4acnSVbfOJqM+7zJE00ZlIKCsu4GGmvsxVyYz
	 kqt2SneK6/BsdO4bgNXv0P7x5gemw2u8OK60n4Mc=
Date: Thu, 22 Feb 2024 13:55:18 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	cve@kernel.org, Jiri Kosina <jkosina@suse.cz>
Subject: Re: CVE-2023-52437: Revert "md/raid5: Wait for MD_SB_CHANGE_PENDING
 in raid5d"
Message-ID: <2024022236-stock-wielder-fcbc@gregkh>
References: <ZdXt09vL4GJy6PbP@sashalap>
 <0e8675e0-165d-4cf7-9755-666278868ab8@redhat.com>
 <ZdX2LcAWR6wyvYC5@sashalap>
 <bec7c1db-c13e-4b00-a968-4ae69539d7ac@redhat.com>
 <ZdYKSkqRckOc5aRO@sashalap>
 <a9652aa2-e79b-4144-b3b7-746587af9eca@redhat.com>
 <ZdYSmdUKzQAYpprc@sashalap>
 <3ebbc121-8cb8-4b8d-ad5d-fb5c576e5171@redhat.com>
 <2024022129-expiring-resurface-146c@gregkh>
 <288132ea-87cf-4b56-908e-2263b6c6b67f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <288132ea-87cf-4b56-908e-2263b6c6b67f@redhat.com>

On Thu, Feb 22, 2024 at 10:58:22AM +0100, Paolo Bonzini wrote:
> On 2/21/24 19:21, Greg Kroah-Hartman wrote:
> > On Wed, Feb 21, 2024 at 04:56:31PM +0100, Paolo Bonzini wrote:
> > > To recap:
> > > 
> > > - the CVE description comes from was upstream commit bed9e27baf52
> > > 
> > > - neither the CVE mitigation section nor the mentioned kernel releases
> > > fix the bug mentioned in the upstream commit, because the mitigation
> > > section also includes commits that _revert_ commit bed9e27baf52
> > > 
> > > - this second revert is not mentioned anywhere, so the CVE description
> > > is at best misleading; or perhaps more accurately described as
> > > "completely f***ed up".
> > > 
> > > I'm sure it's just a bug in the scripts, but it's worrisome that you
> > > don't acknowledge this.
> > 
> > Yes, this is a bug in the scripts, but it wasn't obvious what you were
> > objecting to here honestly.  Reverts were not anything I tested the
> > scripts with before now, and I'm sure there are going to be more cases
> > that fail in odd ways too.  We'll fix them when they show up, that's the
> > best we can do. [...]
> > 
> > If you want to replace the wording in the description here with anything
> > else better, PLEASE let us know and we will be glad to do so.
> 
> But there's not even a documented way to do it.
> 
> All that the document says is "the authority to dispute or modify an
> assigned CVE for a specific kernel change lies solely with the maintainers
> of the relevant subsystem affected".  But it doesn't say:
> 
> * how the maintainer would ask for such a modification or dispute

Email.

> * if and how anyone else could propose them

Email.

> * whether the CVE team can also do them unilaterally

Yup, through email :)

> Perhaps since there's no archive for cve@kernel.org, there should be a
> public discussion mailing list (e.g. linux-cve@vger) that maintainers can
> reply to?  The private cve@kernel.org alias would then be just for the
> request of embargoed CVEs.

What's wrong with lkml for discussion?  I'll add a "reply-to" to point
there as well so that it will properly redirect if you respond to a
message sent to the -announce list.

> It would be great if modifications or disputes could simply be sent as
> patches to the vulns.git repo.  You guys can have push hooks or something
> like that that take care of sending messages to linux-cve-announce etc.

Yes, I'll gladly take that as well!

> Another underspecified part is the early request of CVEs.  Some questions I
> have:
> 
> * what information is needed

What ever information you feel is necessary.  What would you do if you
had to make up your mind on this?

At the minimum, a git id :)

> * is there a limit on embargo length similar to security@kernel.org

We have no embargos here, you should NOT be emailing this alias about
any unfixed security things, the document explicitly states this.

Funnily enough, one major Linux vendor has already done just that, and
exposed the fact that they were getting leaked information sent to them
and possibly an embargo is now broken.

The fallout of this is going to be "interesting".

> * should it be acked by the subsystem maintainer

Not needed, but sure, if you want to.

> More in general, I think you're underestimating the extra work for the
> "listeners" of CVEs, that will come from bugs in the script or other
> not-so-well-defined aspects of the process.  I really think it would be a
> good idea to behave "as if" you were already creating CVE, but for now just
> send out the announcements and publish the JSON in a git repo.

How is it any different from the existing "listeners" of CVEs today?  in
fact, it's a world better as the meta-data we are now providing in the
json files is so much better than all of the crud that all of the other
CNAs were putting in there, it's not even a fair comparison.

So far some vendors have said "this is great!"  No one has said "this
sucks", but if you know of any, let us know, and we will be glad to
adjust the information published as needed.

> As we run the experiment for a while, we can get input from interested
> maintainers and third parties.  I am sure I can find someone from the Red
> Hat product security team to explain their desires, clarify how they consume
> CVE announcements, and what simplifies/complicates their job. Their needs
> are probably not that unique.

I've already had soo many threads from the "Red Hat product security
team" including flow charts and other fun things to last me quite a
while already, and that's just in the past few days.

Given that the "Red Hat product security team" was the #1 offender in
creating CVEs against the kernel that caused us so much work and
headaches that it pushed me over the edge to go through all of the extra
work to actually become a CNA, I think it's worth considering what you
are asking for here.

In other words, they know how to contact us, before, we could never
contact them.  This is up to them to decide how to interact, not us.
And remember, the number of RH systems that that team affects is pretty
much in the rounding error of the other Linux systems out there, not
that I'm counting or anything, just saying :)

> > That's the benifit of being a CNA, we can ACTUALLY MODIFY the CVE
> > records, previously it was almost impossible to ever do so.
> 
> Agreed.  There is potential to do much better than before.

Totally agreed, thanks for the questions!

greg k-h

