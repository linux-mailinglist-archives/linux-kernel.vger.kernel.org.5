Return-Path: <linux-kernel+bounces-158033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 978408B1A6F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 515B0285DBD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0CD03C08D;
	Thu, 25 Apr 2024 05:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="fqMO4rgv"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96423BBD6;
	Thu, 25 Apr 2024 05:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714024216; cv=none; b=jy++Zdf8IdqphcuwPpC4RKMld1MkXtW4IgNNDg/FCziXWs96QeGZxOGqd1fYIGvySKjvE13lDp8bQ9CIRd6tLbuhkyuRsRbEMaVLGmnhZGnTD+f7GmZ8gkNQJD9hg5rXvxpgaryWUpDiDLVZSKx9MSZiFG4dgBGYy+tbhp+Z7so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714024216; c=relaxed/simple;
	bh=bbqSZHXDH5YX8l4a1A9v5kKEdR2507rlQQqYcjvLw/8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=A2rb4ZnKd54dzR01Gp5UH+JyFPsMfJroR1edTL1I4k+qp9tuX8XqR2IYvOLEKWdlQcmUknqeivXk6t0tLV6Plz+YnJaeYA9OjOwvDK6BBK6UuWRR+NJLtuq8qlyRZEmHYLAKObU4ndEDTp41Ll8fAXiGkY5Q6qDkIhJu4AG01+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=fqMO4rgv; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=25X9tJIKZWP/1Kp0tRo7ccMAxI1n3jx3M8I8yPnxZzQ=;
  b=fqMO4rgvZqc2tkZjazfjwdw5HaZXX3ZeMt8seCuEoPhMJXurB6e4+/Gh
   TnITOkD/th4nuGW2bq+DZvFNuOKoq+eghlnIyw7X6jcgmaaSbtDE8xehZ
   TcYGEcirb6NNXlV9jQq9qc/6etbLTYSpK/kCElHdTOUut+VkDiMRGyuEl
   U=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.07,228,1708383600"; 
   d="scan'208";a="85670232"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 07:50:04 +0200
Date: Thu, 25 Apr 2024 07:50:03 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Kees Cook <keescook@chromium.org>
cc: Abhinav Jain <jain.abhinav177@gmail.com>, tony.luck@intel.com, 
    gpiccoli@igalia.com, linux-hardening@vger.kernel.org, 
    linux-kernel@vger.kernel.org, skhan@linuxfoundation.org, 
    javier.carrasco.cruz@gmail.com
Subject: Re: [PATCH] pstore/ram: Replace of_node_put with __free() for
 automatic cleanup
In-Reply-To: <202404241639.3F455ECCD@keescook>
Message-ID: <alpine.DEB.2.22.394.2404250745590.3674@hadrien>
References: <20240415161409.8375-1-jain.abhinav177@gmail.com> <202404241639.3F455ECCD@keescook>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 24 Apr 2024, Kees Cook wrote:

> On Mon, Apr 15, 2024 at 04:14:09PM +0000, Abhinav Jain wrote:
> > Add __free(device_node) to the parent_node struct declaration.
> > Move declaration to initialization for ensuring scope sanity.
> > Remove of_node_put from parent_node struct.
> >
> > Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> > Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
> > ---
> >  fs/pstore/ram.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/fs/pstore/ram.c b/fs/pstore/ram.c
> > index b1a455f42e93..14f2f4864e48 100644
> > --- a/fs/pstore/ram.c
> > +++ b/fs/pstore/ram.c
> > @@ -644,7 +644,6 @@ static int ramoops_parse_dt(struct platform_device *pdev,
> >  			    struct ramoops_platform_data *pdata)
> >  {
> >  	struct device_node *of_node = pdev->dev.of_node;
> > -	struct device_node *parent_node;
> >  	struct resource *res;
> >  	u32 value;
> >  	int ret;
> > @@ -704,14 +703,13 @@ static int ramoops_parse_dt(struct platform_device *pdev,
> >  	 * we're not a child of "reserved-memory" and mimicking the
> >  	 * expected behavior.
> >  	 */
> > -	parent_node = of_get_parent(of_node);
> > +	struct device_node *parent_node __free(device_node) = of_node_parent(of_node);
>
> Please don't move variable definitions into the middle of the function
> body. :)

This is done in other cases where it makes more sense to put the
initialization later in the function.  The point is that the variable has
to be initialized, and puttng the declaration lower, which is now allowed
when needed, is better than first uselessly initializing the variable to
NULL.

>
> >  	if (!of_node_name_eq(parent_node, "reserved-memory") &&
> >  	    !pdata->console_size && !pdata->ftrace_size &&
> >  	    !pdata->pmsg_size && !pdata->ecc_info.ecc_size) {
> >  		pdata->console_size = pdata->record_size;
> >  		pdata->pmsg_size = pdata->record_size;
> >  	}
> > -	of_node_put(parent_node);
>
> So this change is functionally fine, but there's really no good reason
> to do this -- there is no fancy error handling here, so there's no
> benefit to making this change. It doesn't really help readability.

The benefit is general consistency across the code base.  If we could just
get rid of all local-scoped of_node_puts, then we could more easily check
that device nodes are safely used, without having to study the rest of the
code.

Just my opinion.  You decide.

julia

