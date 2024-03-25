Return-Path: <linux-kernel+bounces-117720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD0E88AECB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CB48295C21
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E3082863;
	Mon, 25 Mar 2024 18:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JzOTSe1F"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099E4C125;
	Mon, 25 Mar 2024 18:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711391675; cv=none; b=hF6brtiBhjg2X1KNN2M7sAFRSQlbss1lvsyeFHryVQzlOl7KCVncHfGe09Zkpjt9mE6dUWBdCIsjo4VzMTfxx3MzEhHZBTskvHUQq2qkc+T9w8Npja3NxXR7zjwNjwW+ZyJnEdU6fZ0MxuJYuOvRsxlvPkXr4owqxi3Z//cACSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711391675; c=relaxed/simple;
	bh=Gee8AhASIWspdFBvXIzlQfg0s65UdgTudloR+DtL5jI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=j7nalo/HcIyk4LQhGGdzyVbBUsvjKqvyxHplhL1Zn3GV9kfYV3hcyIllI6etuIPp0WU85Vw0pgcGRxJYDGBEq1V6trucDjXBICi4+b4nFj97y30BJTOJ2NNJ8o+5vFXoz/5S1mp4cpmNco8nPyeN/ZP3/KI8KvN9J4p7tdqF/Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JzOTSe1F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422FFC433C7;
	Mon, 25 Mar 2024 18:34:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1711391674;
	bh=Gee8AhASIWspdFBvXIzlQfg0s65UdgTudloR+DtL5jI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JzOTSe1FTjo+x6vX7OV37+5/gddAKe4tENsFBLDVspaoRrQVNVt0+7QCjHnsxSnot
	 whgKliIcFrr2NGT14nIgk5QTlgZKUp1SrteeDZeM7teA3ZNd6HBvtsuCTf3YOkbKYJ
	 aXXcCFq/r6ypcuhqsf2S0ZFraTvaQ+O+6yyxhhgw=
Date: Mon, 25 Mar 2024 11:34:33 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Borislav Petkov <bp@alien8.de>
Cc: "V, Narasimhan" <Narasimhan.V@amd.com>, "linux-next@vger.kernel.org"
 <linux-next@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "Aithal, Srikanth" <Srikanth.Aithal@amd.com>, Dawei Li
 <dawei.li@shingroup.cn>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, Yury Norov <yury.norov@gmail.com>, lkml
 <linux-kernel@vger.kernel.org>
Subject: Re: Boot failure with kernel BUG at mm/usercopy.c on next-20240325
Message-Id: <20240325113433.e04c2b508ac325630cd113c8@linux-foundation.org>
In-Reply-To: <20240325125017.GBZgFzCXVxeF50uGVE@fat_crate.local>
References: <DM4PR12MB5086E76CF24A39017DA8567189362@DM4PR12MB5086.namprd12.prod.outlook.com>
	<20240325125017.GBZgFzCXVxeF50uGVE@fat_crate.local>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Mar 2024 13:50:17 +0100 Borislav Petkov <bp@alien8.de> wrote:

> Adding more people from that
> 
> 328c801335d5 ("cpumask: create dedicated kmem cache for cpumask var")
> 
> in linux-next.
> 
> On Mon, Mar 25, 2024 at 01:40:20PM +0100, V, Narasimhan wrote:
> > [AMD Official Use Only - General]
> > 
> > Hi,
> > There is a boot failure as below.
> > On bisecting, the bad commit is found to be 328c801335d5f7edf2a3c9c331ddf8978f21e2a7.
> > Boots fine if we revert the above bad commit.
> 
> Narasimhan,
> 
> please send your .config and reproduction instructions. I'm guessing
> you're simply booting it, right?
> 
> Leaving in the rest for the newly CCed people.

Thanks, I'll just drop the patch.  It didn't receive a very favorable
review reception anyway.


