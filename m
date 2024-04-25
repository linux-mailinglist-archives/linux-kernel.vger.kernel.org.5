Return-Path: <linux-kernel+bounces-157935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1708B18E6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 04:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 962E2281F6B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 02:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726B7171C2;
	Thu, 25 Apr 2024 02:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l95Ul+/T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A504A1400A;
	Thu, 25 Apr 2024 02:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714012326; cv=none; b=oO8pIKr3f00fvGA+5WVaihqCmciq5b0DUm8mUCKp+wU10YJW5EsyaoBDQksbj3OeLr3gfjdNk1XEVRtFv3kRleaybeRrEvuAAnZctImUlRHNuN/PrfLDDc2Pgrydn/dKBuoC6+sA574DWm5t27Ctz1aLh7Q1Gj+Wp9uu4Ne3B+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714012326; c=relaxed/simple;
	bh=nAygzTdKA7gXwOCRlEv0GHS1Jlllbh/PJCpLHTfVyZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kdmz95+aP5DClkWTLDY6EbA67c9YLn6iwNjlaGb1AvYOGIvTEYxqrxTbsEORcy3Lrjh+OTgx4va6fHDS0I4RPu6uHsfMgc0dwYxTeql05531S1vjft8aV7u781QTkhX85vwULT8f5etPdujX02ZGTHOsn2gpTL9DA84LaM50sXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l95Ul+/T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94257C113CD;
	Thu, 25 Apr 2024 02:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714012326;
	bh=nAygzTdKA7gXwOCRlEv0GHS1Jlllbh/PJCpLHTfVyZ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l95Ul+/TszTvgQgaS+2oB2XjSuinyC5Ndzqb8ogevjQn2wRGZIKRCs3XOTCYoeH99
	 SmC5TnalrDMs5NWkixVFud4Zj9Hl0cno7TJVBwGTvWMMDYgBZpVOB/O0ZbESZpwE5k
	 zjKAnLa9KL+dFGz4gUHPnbyAuBnaoiso6WA5Tv76uV/DYEXOFUYJFD/V/2P0GRgu0I
	 sLD/lH4h3kkUr7lWECblfnJ4pZJcshHtbIijQ3jv7ucKEvkv11qBcLxuN7JpR8JRq2
	 NmVpwTRM8w7lk/iZpzvBWAZefSzlhPeyk+srjmVplAdO+LE6tyFO0QrVNAHAA4bBms
	 PXvHHg13o0hWA==
Date: Wed, 24 Apr 2024 19:32:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Nick Child <nnac123@linux.ibm.com>, Paolo Abeni <pabeni@redhat.com>,
 Markus Elfring <Markus.Elfring@web.de>, linuxppc-dev@lists.ozlabs.org,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Haren Myneni <haren@linux.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Rick Lindsley
 <ricklind@linux.ibm.com>, Thomas Falcon <tlfalcon@linux.ibm.com>, LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ibmvnic: Use -EBUSY in __ibmvnic_reset()
Message-ID: <20240424193204.39cde604@kernel.org>
In-Reply-To: <ba5e5ccf-59fa-4c7f-b649-97c19b2008a0@moroto.mountain>
References: <4cff158d-b5ac-4dca-9fbb-626237c1eafe@web.de>
	<f493e39063ee52a3d263de27bfd240149d910a88.camel@redhat.com>
	<da19d324-3c66-4bb1-8fa2-dc26dbea622b@moroto.mountain>
	<7e3f43a3-98e0-40ed-8820-2f1eef8742ba@linux.ibm.com>
	<ba5e5ccf-59fa-4c7f-b649-97c19b2008a0@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Apr 2024 18:41:48 +0300 Dan Carpenter wrote:
> > So, the point of the patch not doing any behavioral differences is still
> > true.  
> 
> Ah yes.  You're right.

Hard call but overall I think this wasted more reviewer time than it's
worth. So in the spirit of not encouraging noise I'm not applying this.
-- 
pw-bot: reject

