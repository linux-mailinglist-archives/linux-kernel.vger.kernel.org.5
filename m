Return-Path: <linux-kernel+bounces-28875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35891830412
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32DBF1C24134
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1011CD3C;
	Wed, 17 Jan 2024 11:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nYfNvMDH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7D61DDFF;
	Wed, 17 Jan 2024 11:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705489232; cv=none; b=u44m0JQ+JjWMUhLVi/ZZr8UXNphtFQi6VSIBWL/XCUnPWa8LMzIX3D4mE6T5T2FAaifO5aq8SzFfSbGOVNiewyTicnbaDMbg7RFa1DI7uzEnpo+g2EvPmWXsGYNzKwx0mMkFncZbN5V7H+O6lx1ayDQyj94qlOs05dCSS7wmJb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705489232; c=relaxed/simple;
	bh=2mxQPFZJuiMxYKFigVDQRD9zyCF3tIWlcfet1VFifmY=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To; b=XuAsyd3/jYfhcFuCFSvQJNCC2tqn7E8NYN0GOwC3AU0FfWf2ZmskEiBK/dc+nJUROpwAaTE9Ev8wLmWZHy137z4zNTSChAOzO4VR7wXPYw9YkIuWAOo2X5VCSx1eHeU/ngeo1h3gQG1uqS4EzD7saJmZ2EbrCx14iTOT0v7rrRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nYfNvMDH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C98C43390;
	Wed, 17 Jan 2024 11:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705489232;
	bh=2mxQPFZJuiMxYKFigVDQRD9zyCF3tIWlcfet1VFifmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nYfNvMDH7mId/vAtJuFtY4q9wSpGwX8KiI7X3wLMZMs72N6fpS+E1bLacMLgfN/82
	 +uIzh81aD3fZAJ0EK5PIJ82l1Y/EubwmXGB1IgS4PNx4yRAm0zTBOMzW39uuhbKYHQ
	 uvopnmmTrlpVPrTPsK+ysjQW+2ZjBCzI6rVlyb0E=
Date: Wed, 17 Jan 2024 12:00:29 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, x86@kernel.org,
	Borislav Petkov <bp@suse.de>,
	Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH stable] x86/microcode: do not cache microcode if it will
 not be used
Message-ID: <2024011756-dosage-deviator-6e03@gregkh>
References: <20240115102202.1321115-1-pbonzini@redhat.com>
 <2024011502-shoptalk-gurgling-61f5@gregkh>
 <CABgObfZ0gpw2-n2d5vyEjuCefOp+3TPyUuMvjScAbae2GKfO0A@mail.gmail.com>
 <2024011543-dropout-alienable-a9e9@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2024011543-dropout-alienable-a9e9@gregkh>

On Mon, Jan 15, 2024 at 09:59:23PM +0100, Greg KH wrote:
> On Mon, Jan 15, 2024 at 07:54:59PM +0100, Paolo Bonzini wrote:
> > On Mon, Jan 15, 2024 at 7:35 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Mon, Jan 15, 2024 at 11:22:02AM +0100, Paolo Bonzini wrote:
> > > > [ Upstream commit a7939f01672034a58ad3fdbce69bb6c665ce0024 ]
> > >
> > > This really isn't this commit id, sorry.
> > 
> > True, that's the point of the mainline kernel where the logic most
> > closely resembles the patch. stable-kernel-rules.rst does not quite
> > say what to do in this case.
> 
> Ok, then just say, "this is not upstream" and the rest of your changelog
> is good.  I'll edit it up tomorrow and apply it, thanks.

Ok, now queued up for 6.6.y, but what about older kernel versions?  Is
this relevant for them as well?  I will note that it does seem to apply
to them properly and build, is it not relevant?

thanks,

greg k-h

