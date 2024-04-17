Return-Path: <linux-kernel+bounces-148894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 194098A88AA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0C741F211C7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5424B148FEA;
	Wed, 17 Apr 2024 16:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSwkGopk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C62F84E14;
	Wed, 17 Apr 2024 16:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713370778; cv=none; b=qzC5dq1sC94gEcWZp8YgQHVbf32+M9gelmBxKl+Re5NsmWalgjsI9XnwnChHj4G58DRHlLTrKdKJoAfcP/q5UJ+LlUYV99kWL+tK2V+GIbmeHK3dSocMB3W2+eOwKchJw44DGCZp1aN3byboUBFonJ69lYceFN3yS++dvKhn8Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713370778; c=relaxed/simple;
	bh=+IXw6cq41/KiaWXYS6v6T/R+F3lZu/uCGQeunZByk2g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjdEXQExw3wUKVnHbN9uWKcNrxVOlhLwSOeXekgtx9pZrTopSV3ttdflJTdcHy1YsQM3Hh4L91q2R1MS9ZMsLBMO01gaHn8qDkhDkzr55WOhAQ3I03FXpsMEDlUUhDIqfKb88qztZLV800xqLSStyTFhChuuaPPoubFSLD1TIhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSwkGopk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32765C2BD11;
	Wed, 17 Apr 2024 16:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713370778;
	bh=+IXw6cq41/KiaWXYS6v6T/R+F3lZu/uCGQeunZByk2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oSwkGopkw1aV1SHbTL93Jc9Rxh01yHEszIDHdobbxIhkRTYSAQZd2xTN5KVsDAvif
	 +EwkB33fHgWvON/yBxc1LYR9D/qbuX8h3x/A6i/eATTwlBwbVcS26DVDF0VGstv7/+
	 gXfBaXSGFttoL5ufG6rT55MgKoEOkM9sYnzvkc+JQeIefjdKt44SA21qymu77VyO3u
	 SfQlNnDQVvHQe7ARIFUQXywWvR7L4nGeDMBSXKHmQitaRt/C8j4QEddDhOY077rntM
	 g3AQ5BFhybooEGnICN784IOjvYH6jsTEVn/q3y2lJTvHHr9WKcwLb3KJ5DwbPYoZ+F
	 W0iMNklAaKrhw==
Date: Wed, 17 Apr 2024 17:19:33 +0100
From: Simon Horman <horms@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Justin Chen <justin.chen@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net] net: bcmasp: fix memory leak when bringing down if
Message-ID: <20240417161933.GA2320920@kernel.org>
References: <20240412181631.3488324-1-justin.chen@broadcom.com>
 <6881c322-8fbb-422f-bdbb-392a83d0b326@web.de>
 <9afad2b3-38a5-470d-a66f-10aa2cba3bab@broadcom.com>
 <8ae97386-876f-45cf-9e82-af082d8ea338@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ae97386-876f-45cf-9e82-af082d8ea338@web.de>

On Mon, Apr 15, 2024 at 09:46:44PM +0200, Markus Elfring wrote:
> >>> When bringing down the TX rings we flush the rings but forget to
> >>> reclaimed the flushed packets. This lead to a memory leak since we
> >>> do not free the dma mapped buffers. …
> >>
> >> I find this change description improvable.
> >>
> >> * How do you think about to avoid typos?
> >>
> >> * Would another imperative wording be more desirable?
> >
> > The change description makes sense to me. Can you be a bit more specific as to what isn't clear here?
> 
> Spelling suggestions:
> + … forget to reclaim …
> + … This leads to …

Markus, let's cut to the chase.

What portion of your responses of this thread were produced
by an LLM or similar technology?

The suggestions in your second email are correct.
But, ironically, your first response appears to be grammatically incorrect.

Specifically:

* What does "improvable" mean in this context?
* "How do you think about to avoid typos?"
  is, in my opinion, grammatically incorrect.
  And, FWIW, I see no typos.
* "Would another imperative wording be more desirable?"
  is, in my opinion, also grammatically incorrect.

And yet your comment is ostensibly about grammar.
I'm sorry, but this strikes me as absurd.

