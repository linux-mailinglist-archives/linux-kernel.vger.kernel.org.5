Return-Path: <linux-kernel+bounces-149193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A45088A8D05
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52A911F226EA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146A944C8D;
	Wed, 17 Apr 2024 20:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdCu2ba6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A8C1E48B;
	Wed, 17 Apr 2024 20:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713386075; cv=none; b=ivOnWBSiaQIEmhIed6A9yT3sHMpFFD8OHCsBVmw57Ml7+V40XcXiv+8nma94BJ5LZ5Ppqti8wcJZCKf4aw74N/DJtVPdhHk9NWpSyZtuLQPRJ0EKk3utz9I4whcIb2o0y6AfCcVYd3eScAJsRe+kPaFe2gddAvq+6rHrgW30BPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713386075; c=relaxed/simple;
	bh=EtXU9c2X1rus7AR+E4QdwNGG0e/acH591nahmvg0zE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cQ0qmJlORzksu2SLIenqxmFxkUJDZ8zNwMydfFs3ZTzbfPa/Mb3BHat/GquZLF89pAZD5V6qy0E9t+zBo+uZsyZiShSBEabEquKebflfw/eQRYjY4pOaF3heATGSPI2TZDLsQRtS/OK71DaajpuW2ZJgA0mObTyDHMkPlmRKto0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdCu2ba6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5F7C072AA;
	Wed, 17 Apr 2024 20:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713386074;
	bh=EtXU9c2X1rus7AR+E4QdwNGG0e/acH591nahmvg0zE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UdCu2ba6hcAPeyyocbmuIrgN5vfGx7tuIbgJfByfWkWqHYsEwRAIdQ6ytJq6qoujB
	 bsbrHf2dKw7omIuXKr+I2wZYriYo0KCsj6bDBPo9czZMETYAxI0IMoiR1rM5F+PXNj
	 CmY5wXIT5HnK0/PfHPLzkr0mx1qD5reZ0JPAiYjzHigqYf05CiIIkw3K+36Gzrmzo2
	 kcI6tEMbG0iGw7aJPAmP4hANxV/JlUCIlvcu/XOST3DWZ0UCRvrSTq7Vw2Xmz6G6QZ
	 OO6q+2/jDKduzXDMsXDZ5Wr8dvI6SHg3+chjSY+nu6MLu09Gh0BRoEqBa/ItI7f1ur
	 88qMoDIwMeMtA==
Date: Wed, 17 Apr 2024 21:34:30 +0100
From: Simon Horman <horms@kernel.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Markus Elfring <Markus.Elfring@web.de>,
	Justin Chen <justin.chen@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: bcmasp: fix memory leak when bringing down if
Message-ID: <20240417203430.GB3935777@kernel.org>
References: <20240412181631.3488324-1-justin.chen@broadcom.com>
 <6881c322-8fbb-422f-bdbb-392a83d0b326@web.de>
 <9afad2b3-38a5-470d-a66f-10aa2cba3bab@broadcom.com>
 <8ae97386-876f-45cf-9e82-af082d8ea338@web.de>
 <20240417161933.GA2320920@kernel.org>
 <3a5cb80e-7169-4e82-b10c-843ff1eb0fd3@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a5cb80e-7169-4e82-b10c-843ff1eb0fd3@broadcom.com>

On Wed, Apr 17, 2024 at 09:52:47AM -0700, Florian Fainelli wrote:
> On 4/17/24 09:19, Simon Horman wrote:
> > On Mon, Apr 15, 2024 at 09:46:44PM +0200, Markus Elfring wrote:
> > > > > > When bringing down the TX rings we flush the rings but forget to
> > > > > > reclaimed the flushed packets. This lead to a memory leak since we
> > > > > > do not free the dma mapped buffers. …
> > > > > 
> > > > > I find this change description improvable.
> > > > > 
> > > > > * How do you think about to avoid typos?
> > > > > 
> > > > > * Would another imperative wording be more desirable?
> > > > 
> > > > The change description makes sense to me. Can you be a bit more specific as to what isn't clear here?
> > > 
> > > Spelling suggestions:
> > > + … forget to reclaim …
> > > + … This leads to …
> > 
> > Markus, let's cut to the chase.
> > 
> > What portion of your responses of this thread were produced
> > by an LLM or similar technology?
> > 
> > The suggestions in your second email are correct.
> > But, ironically, your first response appears to be grammatically incorrect.
> > 
> > Specifically:
> > 
> > * What does "improvable" mean in this context?
> 
> I read it as "improbable", but this patch came out of an actual bug report
> we had internally and code inspection revealed the leaks being plugged by
> this patch.
> 
> > * "How do you think about to avoid typos?"
> >    is, in my opinion, grammatically incorrect.
> >    And, FWIW, I see no typos.
> 
> There was one, "This lead to a memory leak" -> "This leads to a memory leak"
> 
> > * "Would another imperative wording be more desirable?"
> >    is, in my opinion, also grammatically incorrect.
> > 
> > And yet your comment is ostensibly about grammar.
> > I'm sorry, but this strikes me as absurd.
> 
> Yeah, I share that too, if you are to nitpick on every single word someone
> wrote in a commit message, your responses better be squeaky clean such that
> Shakespeare himself would be proud of you.
> 
> There is a track record of what people might consider bike shedding, others
> might consider useless, and others might find uber pedantic comments from
> Markus done under his other email address: elfring@users.sourceforge.net.
> 
> Me personally, I read his comments and apply my own judgement as to whether
> they justify spinning a new patch just to address the feedback given. He has
> not landed on my ignore filter, but of course that can change at a moments
> notice.

Thanks Florian,

On reflection, my previous email was inappropriate.
I do have reservations about the review provided by Markus,
but should not reacted as I did. I apologise to every for that.


