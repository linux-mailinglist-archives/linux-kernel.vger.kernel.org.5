Return-Path: <linux-kernel+bounces-28943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EC48304F2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 034791F24672
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1959A1DFCF;
	Wed, 17 Jan 2024 12:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jJvF/my5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584321DFC7;
	Wed, 17 Jan 2024 12:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705493313; cv=none; b=K4Vju3Ae58768Fkuwe9S5KWPrK+WL89kTbBub76UUPkuX7QpeQjIVNG971nC6itRMjDTMe+xQjqnBoGXsxDChX/cP4c0mkGDDEZutxl2X3P4b3NRrsXmcUVDJFOEpcutK6rj1g+Nt+lGsSrrPMWj/Njk4NYckXxLTofSKbWjJHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705493313; c=relaxed/simple;
	bh=sXaUd5luyM2wpUXY6IyzW9hYsNS5vpH7Z25LN3uqAiE=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To; b=mKDbHt/LdAzMBzE78JagoCJrNrvDNUC/eQHmeBGvsK8cUaKot8hRjZTK3CqBFw+m3vyFRYapsXd2U/PJy7/AkEtOrokiZ5F2hy1c0g7+XKKEchhtsbhPaQYgW2bQ4oie8QgZwPtqv1ngOJ9RYKUvJyXArRO2AExhrihegw8kyw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jJvF/my5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EC7C433C7;
	Wed, 17 Jan 2024 12:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705493311;
	bh=sXaUd5luyM2wpUXY6IyzW9hYsNS5vpH7Z25LN3uqAiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jJvF/my5ftnX0PWZBsIVdcDY9x5vwQV47w8npJQ8V8jLQNUnT0PnJc8Pw/2SkU7hM
	 5sADgHolbvMefWZV1GzXpQhq3blGk4sIi2Xk0YolsCpX8yDRvWsYx/4A2TMPi61ii3
	 1X3kgEqvpAYE1u9Gm7p/rQN0+OOddvx5bURmFakM=
Date: Wed, 17 Jan 2024 13:08:29 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, x86@kernel.org,
	Borislav Petkov <bp@suse.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH stable] x86/microcode: do not cache microcode if it will
 not be used
Message-ID: <2024011712-stipend-arena-aeb3@gregkh>
References: <20240115102202.1321115-1-pbonzini@redhat.com>
 <2024011502-shoptalk-gurgling-61f5@gregkh>
 <CABgObfZ0gpw2-n2d5vyEjuCefOp+3TPyUuMvjScAbae2GKfO0A@mail.gmail.com>
 <2024011543-dropout-alienable-a9e9@gregkh>
 <2024011756-dosage-deviator-6e03@gregkh>
 <CABgObfaiz94fCb2ULDhSE-dKBGnT+qE+pnf=O9+6OavpPTRScQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfaiz94fCb2ULDhSE-dKBGnT+qE+pnf=O9+6OavpPTRScQ@mail.gmail.com>

On Wed, Jan 17, 2024 at 12:57:40PM +0100, Paolo Bonzini wrote:
> On Wed, Jan 17, 2024 at 12:00 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Jan 15, 2024 at 09:59:23PM +0100, Greg KH wrote:
> > > On Mon, Jan 15, 2024 at 07:54:59PM +0100, Paolo Bonzini wrote:
> > > > On Mon, Jan 15, 2024 at 7:35 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Mon, Jan 15, 2024 at 11:22:02AM +0100, Paolo Bonzini wrote:
> > > > > > [ Upstream commit a7939f01672034a58ad3fdbce69bb6c665ce0024 ]
> > > > >
> > > > > This really isn't this commit id, sorry.
> > > >
> > > > True, that's the point of the mainline kernel where the logic most
> > > > closely resembles the patch. stable-kernel-rules.rst does not quite
> > > > say what to do in this case.
> > >
> > > Ok, then just say, "this is not upstream" and the rest of your changelog
> > > is good.  I'll edit it up tomorrow and apply it, thanks.
> >
> > Ok, now queued up for 6.6.y, but what about older kernel versions?
> 
> 6.6 is where I tested that it works, and I didn't want to put an old
> kernel version in the "Cc" line, without even testing that a
> non-upstream patch applies there.
> 
> The benefit would be absolutely marginal. People playing with Intel
> TDX are not going to use old kernels (6.1 counts as old) anyway, for
> example support for lazy acceptance of memory went into 6.5.

Fair enough, thanks for the explaination, I'll leave it alone then.

greg k-h

