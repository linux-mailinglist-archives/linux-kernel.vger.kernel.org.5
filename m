Return-Path: <linux-kernel+bounces-97758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92164876F07
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 04:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 460932825CD
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 03:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFA836126;
	Sat,  9 Mar 2024 03:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jq4balvW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8113218B;
	Sat,  9 Mar 2024 03:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709956625; cv=none; b=YhhoxA4Yh/BnU6a2hDv08yiQJYxYTXt15h/SSdIHm++/RZq9URenaSamVjg3YiZgHJuxc1LL5amJtOhQRZr48tCyb32VxWibocDEq/Fi4+pnfSHGSH8GIjrBXbwkbYsZtllz9YMjSWkhbG6x9KxUWkI2O+VFPAGmVhFN+E+zJs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709956625; c=relaxed/simple;
	bh=e/myOlJjPvoMk8xBCponcF+t0IYuRQviePbYNIlftyg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tpDRKnnRbCz7jRVng2UnCTKH+Dgtyyw5ReJPRNzNnj2TyERoDH10X0PoPuyihCtn54/0irj0kuI7sTrjf1+vYHRNt7I6bqbuJwuUZZRjAzVAvW3N5DRVeP0fMYSsqpe38HyZPL2PdfPm6MYg4tNbHqgiFk9sNOyvsvFqfzLcCrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jq4balvW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6217EC433C7;
	Sat,  9 Mar 2024 03:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709956624;
	bh=e/myOlJjPvoMk8xBCponcF+t0IYuRQviePbYNIlftyg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jq4balvWByXHxrSni31UNEfCTvNK5Tg2uLEAj2NNqWHb6CemCe5wDSg+ap7NVWRtB
	 X22t7GtQHwGRhhepXVGSef9cpbz8rCK3JbeWeuN+pera4HjWp+ZpHR0R0Z0PAhFxHD
	 AtHHTmlefl1If0VVOa8uqbYDAn+ubrCYfmgZBMyDB8ME+fpr6efDuhZ57ZWiPY57GN
	 RfAqDUA5DtrJPCu5kaXuJs23VyUlw7wyNn/+VgKTTFUawsco1Z5/6NMyngQoSWdIcJ
	 7+Th2NcSyIJomsq39c1TUaVC3eXnN/nqmCb2uEp8DUGG5Md2KErSkiebTXEWDIuHhF
	 d71tSAU2P+Afg==
Date: Fri, 8 Mar 2024 19:57:03 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Frederic Weisbecker <frederic@kernel.org>, Valentin Schneider
 <vschneid@redhat.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next -v5] net/core/dev.c: enable timestamp static
 key if CPU isolation is configured
Message-ID: <20240308195703.3e77c27f@kernel.org>
In-Reply-To: <Zen126EYArNCxIYz@tpad>
References: <Zen126EYArNCxIYz@tpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Mar 2024 14:14:03 -0300 Marcelo Tosatti wrote:
> net/core/dev.c: enable timestamp static key if CPU isolation is configured

Doesn't apply to net-next, please respin.

When you do, one more nit: please use net: as the prefix,
instead of net/code/dev.c. No need to state the entire file path.
-- 
pw-bot: cr

