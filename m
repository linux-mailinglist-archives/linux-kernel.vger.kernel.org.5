Return-Path: <linux-kernel+bounces-133193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC2C89A02D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF0AE1C2110F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04DA16F29F;
	Fri,  5 Apr 2024 14:50:23 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9AC116F29B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712328623; cv=none; b=DSNQQiFPgZzdXgk6BIvtWYadWFFPZlzv20JZfco63vzk8FHLcjLvWdY8B+mFkYTVtfuj5Jiu9JrW7kwVaYD/mPOE6gJ4X7V/YfdgKMOVLrnwga+DGfu9/GFErjWvwMeqStxVOj7Sqpnf+UR92390zgnwYo71Vjd/Dd+IMpN7zCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712328623; c=relaxed/simple;
	bh=VqINHYATEwC4O5L2MZdP3SWw93PfxhwfQb3t/PgqT/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I1DiZmtbQ1owGOsEfSzn3ZdfJAP5odO/wonMIDg4SvxcyzJGtvYNowiu4+fC0tyIB/qwP5ZrhGQbSzF3bSeHb47+occKuB6u1yqgWbbgOdvO9tnrPhMIFWNcXB++Z85Jv6AdLlrm7TdgeHYaq/EfV4owQYmMawCKmR84u3lpFcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8DC3368D07; Fri,  5 Apr 2024 16:50:17 +0200 (CEST)
Date: Fri, 5 Apr 2024 16:50:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, James Smart <james.smart@broadcom.com>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH v4 3/5] nvmet: return DHCHAP status codes from
 nvmet_setup_auth()
Message-ID: <20240405145017.GA6844@lst.de>
References: <20240405062055.GC3107@lst.de> <3qh6d2fensgck2rodnbhreirfwkf7lloqwvk6gyfafu4fvgxss@jxb4b4kzu224> <20240405144752.GA6352@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405144752.GA6352@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Apr 05, 2024 at 04:47:52PM +0200, Christoph Hellwig wrote:
> > Are you sure I should map this to errno codes and the back to NVME
> > status codes? Sure, this is possible but don't really think it makes
> > sense.
> 
> No, but we should not overload the return value.  Pass in the req
> or sq, or add a new paramter for the auth fail reason.

Or make sure all returns are the status codes, change the return
value to a u8 and clearly document what values it returns if that
works out.

And while you're at it please fix all the overly long lines.

