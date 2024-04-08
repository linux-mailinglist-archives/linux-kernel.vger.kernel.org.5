Return-Path: <linux-kernel+bounces-135658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A0789C95C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D92CD1C21F19
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2C21422C5;
	Mon,  8 Apr 2024 16:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EFGqRsiK"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66FE13E88F;
	Mon,  8 Apr 2024 16:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712592616; cv=none; b=QKasl4l9Uo46wMoNYLY3ewHp+taqnNHEqFuECGuKfR2X5DRd9At3mdQtKyh0dDyt/HxPuGScvrCyr9FukdUrz9xVottcw1uMxMTkpKH/nF7dt4YaW7qj5bhysPiS00F1bgs+zAKVJ7mk/4wHN17mVy+TGbX1TCfSDHxSS7CU1nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712592616; c=relaxed/simple;
	bh=s+O4kONFViiAAbscvBJlJboLEbxXcxsDb36i+2Uu9so=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t3hA1MHngPfS4VtISFoos6ggumcGw2tU4OWcBOzRwJGHJQcwuk7xcmdJMsQkNHaRjH62XzXm8GqyG4OiaspKVRiwyigBNTfJLXbP7bUO0n4BAkwa7mLOo7ji6MDrQ+HPKi80fkcH57PMLMuQKzaF4V1Pr10U/bVUavfq4xvNGNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EFGqRsiK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yLf9gOuFWFn+mj2cKkeSPV0XXmwiJvp1/2MZm/fvtpw=; b=EFGqRsiKiVUSn1VLhowgBds29H
	Im0pHC+mfakvLwEL3aYVF4XSvws1N4rnyWruY/KgEdtqRPaMw5GwyaMLTnBLWEjFtZ0h5BCGS4wsF
	i8Fm5Bydx/dGMPwVLuliHiV+ApMN/6EyPUiWzEGysAGAAMq5lrcDWhvPsfcWvwJFOfsxINP9x1qgf
	UDc2AJoqFQCNzFDH0pv3Aso3s+b9O6DFYK54XIY1oM1mRAHWUPE3UnurUevLtQamXVq6Q1Yv7K/Qj
	mF3JcvMun37PiHtzqXGA+cvEmwm3j5YivHvxcdz/M1cw7zXv2eSAcoBGuM8c3UNW6ggqdpfPkswaX
	VSgUnP3g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtrZP-00000000ABB-2GJv;
	Mon, 08 Apr 2024 16:10:07 +0000
Date: Mon, 8 Apr 2024 17:10:07 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Danielle Ratson <danieller@nvidia.com>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, corbet@lwn.net, sdf@google.com,
	kory.maincent@bootlin.com, maxime.chevallier@bootlin.com,
	vladimir.oltean@nxp.com, przemyslaw.kitszel@intel.com,
	ahmed.zaki@intel.com, richardcochran@gmail.com, shayagr@amazon.com,
	paul.greenwalt@intel.com, jiri@resnulli.us,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	mlxsw@nvidia.com, petrm@nvidia.com, idosch@nvidia.com
Subject: Re: [PATCH net-next 07/10] ethtool: cmis_cdb: Add a layer for
 supporting CDB commands
Message-ID: <ZhQW3wxgv_lJF8Ep@casper.infradead.org>
References: <20240408125340.2084269-1-danieller@nvidia.com>
 <20240408125340.2084269-8-danieller@nvidia.com>
 <ZhQFV7I3EwW7FV+H@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZhQFV7I3EwW7FV+H@shell.armlinux.org.uk>

On Mon, Apr 08, 2024 at 03:55:19PM +0100, Russell King (Oracle) wrote:
> On Mon, Apr 08, 2024 at 03:53:37PM +0300, Danielle Ratson wrote:
> > +/**
> > + * struct ethtool_cmis_cdb_request - CDB commands request fields as decribed in
> > + *				the CMIS standard
> > + * @id: Command ID.
> > + * @epl_len: EPL memory length.
> > + * @lpl_len: LPL memory length.
> > + * @chk_code: Check code for the previous field and the payload.
> > + * @resv1: Added to match the CMIS standard request continuity.
> > + * @resv2: Added to match the CMIS standard request continuity.
> > + * @payload: Payload for the CDB commands.
> > + */
> > +struct ethtool_cmis_cdb_request {
> > +	__be16 id;
> > +	struct_group(body,
> > +		u16 epl_len;
> 
> u16 with a struct that also uses __be16 looks suspicious.

I'd understand if it were the other way around.  The command ID isn't a
_number_, it's an ID.  You can't add 1 to it and get a meaningful requilt;
all you can do is check it for equality, so a u16 makes sense for an ID.
That's what I did in NVMe; command_id is typed as a __u16.

But a 'length' field is obviously a number.  You can meaningfully add
and subtract numbers to it.  If there's an endian consideration, that's
where you'd expect to see it.

So I concur, this is supicious.

(Oh, you might wonder why namespace ID (nsid) in the NVMe command is
an le32 rather than a u32, since it is also an ID.  And that's because
it's an ID which is exposed to userspace.  You wouldn't want to have big
endian systems call the namespace 16777216 and little endian systems
call it 1)


