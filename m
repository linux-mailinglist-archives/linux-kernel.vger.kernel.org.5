Return-Path: <linux-kernel+bounces-13184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1FD8200D3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 18:29:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECF971C21731
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 17:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9528C12B8D;
	Fri, 29 Dec 2023 17:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="UUpPtQo7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0FB12E43;
	Fri, 29 Dec 2023 17:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xrWs+MrhNlw7+uIPLMBuNj81/lHdj7mSahUJV2XHzL8=;
  b=UUpPtQo7IVwVIwqhaHavBEA469c1pug59iaaGEeW5MNPDtoJE11yakVZ
   GXl/18PM83xQPndKGAu2IAfX6r2JAYrkchOl9o64Tv0F3Q4q7W9kxSSUA
   r4KW90AtpHndCQlpyEWUCvYjQEOgoXCDkegp494gIOJSAhEhJ5c2BkXRI
   A=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.04,315,1695679200"; 
   d="scan'208";a="144322364"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 18:29:03 +0100
Date: Fri, 29 Dec 2023 18:29:02 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: James Bottomley <jejb@linux.ibm.com>
cc: Markus Elfring <Markus.Elfring@web.de>, linux-scsi@vger.kernel.org, 
    kernel-janitors@vger.kernel.org, 
    "Martin K. Petersen" <martin.petersen@oracle.com>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: ses: Move a label in
 ses_enclosure_data_process()
In-Reply-To: <9d24844f30604f969ac10da456801f594ce72f2d.camel@linux.ibm.com>
Message-ID: <50978c86-cf4a-991d-54ab-50d8d977f946@inria.fr>
References: <4616e325-e313-4078-9788-dd1e6e51b9e0@web.de> <9d24844f30604f969ac10da456801f594ce72f2d.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 29 Dec 2023, James Bottomley wrote:

> On Thu, 2023-12-28 at 15:48 +0100, Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Thu, 28 Dec 2023 15:38:09 +0100
> >
> > The kfree() function was called in up to three cases by
> > the ses_enclosure_data_process() function during error handling
> > even if the passed variable contained a null pointer.
> > This issue was detected by using the Coccinelle software.
>
> Why is this an issue?  The whole point of having kfree(NULL) be a nop
> is so we don't have to special case the free path.  The reason we do
> that is because multiple special case paths through code leads to more
> complex control flows and more potential bugs.  If coccinelle suddenly
> thinks this is a problem, it's coccinelle that needs fixing.

Coccinelle doesn't think anything.  Markus for some reason thinks it's a
problem and uses Coccinelle to find occurrences of it.

julia

