Return-Path: <linux-kernel+bounces-161043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5401A8B463E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 13:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E6DD1C22801
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 11:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1958A4D5A0;
	Sat, 27 Apr 2024 11:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTNfEdu/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C721E52C;
	Sat, 27 Apr 2024 11:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714218498; cv=none; b=X+V/kg5B4X3eOOwY9RfiWNNgnGgIJrtjuvhd+z6wsFS2imhIgdk/AyDd0Ody9Hhp8NEfBrUD2QVBmBYXWPQy8PGIldrm/jyGk3vBkGFvtFHKNKUZJbsdakk2GLTeWYYprkphcIVkxI3H3zJh5UGfTuSn/gRo+QocvkmM8BR/7+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714218498; c=relaxed/simple;
	bh=HQxRaUraETKiT/XSDc967hn9ZV8LY4HtqHBIMVLyIJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtf6Cxp78Hy920CZfB1B84unnvhbZdj2mx56zXYCkulpdde6DKx20v5HyDgzV92vjHJEYOge4+F2mVoe9RtBPewC1EvZ9WIIltfC/BzlbDcOMZaEOmbe3jWHx7Il6xEugRdA7vn4PCkB6uKhpxMdulVL73VYMX1xrHuVTbx4ibs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTNfEdu/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57044C113CE;
	Sat, 27 Apr 2024 11:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714218497;
	bh=HQxRaUraETKiT/XSDc967hn9ZV8LY4HtqHBIMVLyIJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CTNfEdu/AEHEWUzmxyB3MNb04hhRjFpqcz3VQSKdxFxDe64tuOx1ZWv2nUY/ly0J6
	 oYYPuOpP4Lpo2utP1A0NPmCzM06xmsDu65Hf/QsZisb9GebnRbff7UdoCWwNASppeP
	 wilehLazCJ9ds0o4dnL7HAF1xgTqiJHTkntKj8L5ef9RjWnqW5296rFpk5bQ3axP5z
	 SEuUl78hMrld9SbuZK3Y6nYAPtFR9oF31Dqu4r24fHzw7mczs6gKT2rkDaW4x+2PUa
	 hydhyVmtBAqtoqEABSVnFJV7GmmhJLbzF61gSdK9awObZDl5uLMurTN/MHHl1SkEdo
	 4T8k1fshfeBAw==
Date: Sat, 27 Apr 2024 12:48:13 +0100
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ariel Elior <aelior@marvell.com>,
	Manish Chopra <manishc@marvell.com>, Jiri Pirko <jiri@resnulli.us>,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [PATCH net 0/4] net: qede: avoid overruling error codes
Message-ID: <20240427114813.GG516117@kernel.org>
References: <20240426091227.78060-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240426091227.78060-1-ast@fiberby.net>

On Fri, Apr 26, 2024 at 09:12:22AM +0000, Asbjørn Sloth Tønnesen wrote:
> This series fixes the qede driver, so that
> qede_parse_flow_attr() and it's subfunctions
> doesn't get their error codes overruled
> (ie. turning -EOPNOTSUPP into -EINVAL).
> 
> ---
> I have two more patches along the same lines,
> but they are not yet causing any issues,
> so I have them destined for net-next.
> (those are for qede_flow_spec_validate_unused()
> and qede_flow_parse_ports().)
> 
> After that I have a series for converting to
> extack + the final one for validating control
> flags.

Hi,

I'm fine with these patches so far as the code changes go.
But it is not clear to me that they are fixing a bug.

If so, I think some explanation should go in the commit messages.
If not, I think these should be targeted at net-next
(and not have Fixes tags.

Also, if you do end posting a v2, blamed, is misspelt several
times in commit messages.

