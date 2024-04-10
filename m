Return-Path: <linux-kernel+bounces-137754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC7389E6B9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208E9283EDB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 00:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E504C624;
	Wed, 10 Apr 2024 00:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rf/VLZPN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0877F;
	Wed, 10 Apr 2024 00:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712708511; cv=none; b=D+6BhaXxDVY+wFVPq2EO5iU8ueLdfwa7WqJW9q6241zruT60OeICSUT+J6VJrFP8iGEEI0zAsUnN/DNJSCRXlcVn/C+THlDbDSj3fh41851WpqHxyeTxOZx18cY9VCcgz/rPPSShndAIyY/5C44D+9pmm25++UlsCTZUcqP8pyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712708511; c=relaxed/simple;
	bh=gzUOWwz3tviqyMlmwEHpoHDPsNyvzfup7Ce/HPd7+eI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=muU9COo2gL9xsherK4wl6L6JT+z6rAfrepQ+IUpAtA1dQJGCnMd3jrLSPdxeGaTGuclbl/zkQaiWkjNtwytWHU2zaFLOkRRD9L79PCNuKyqtcN6EYlDNaunwIDungrTKDtyfJhf2wSknVp6QeTdAZoh4Wn1TbM6og+ZByBLbvUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rf/VLZPN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5157EC433F1;
	Wed, 10 Apr 2024 00:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712708510;
	bh=gzUOWwz3tviqyMlmwEHpoHDPsNyvzfup7Ce/HPd7+eI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rf/VLZPNe3KM7PuQkA/waKmvEJyyKyi/21q+CMesC55RySW/yz2jR6t7SExBKRvFs
	 lgInRbwk6OZrp2DTPBYBekxJJ2rMfYoFKfTZ++r6vSAjVh+32+9xnzjdxF6RXODSEE
	 GWhCdzugCYEFm1/n8GI52L3gy7ILDjWGjkjZHYN1bFj2Y6NMXgYZn7bvpWkvTRbMTB
	 QRQMHMGJ69KP70XwgAVhu+iBLCp33YUHS/DkdMg37gJtfMoXOR7AaVahU8ZBbUCLVv
	 hOokROauum4PUqwj4V9y/GYmAZ7+k+WOTOkeGoJ2jKqli8rvJQ3unrYU1DpDiVEmHv
	 S+Q4LpUMT8TXA==
Date: Tue, 9 Apr 2024 17:21:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/4] net: dqs: make struct dql more cache
 efficient
Message-ID: <20240409172149.6f285b68@kernel.org>
In-Reply-To: <20240408172605.635508-5-leitao@debian.org>
References: <20240408172605.635508-1-leitao@debian.org>
	<20240408172605.635508-5-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  8 Apr 2024 10:25:56 -0700 Breno Leitao wrote:
> With the previous change, struct dqs->stall_thrs will be in the hot path
> (at queue side), even if DQS is disabled.
> 
> The other fields accessed in this function (last_obj_cnt and num_queued)
> are in the first cache line, let's move this field  (stall_thrs) to the
> very first cache line, since there is a hole there.
> 
> This does not change the structure size, since it moves an short (2
> bytes) to 4-bytes whole in the first cache line.

Doesn't this move the cache line bouncing problem to the other side?
Eric said "copy" I read that as "have two fields with the same value".
I think it's single digit number of alu instructions we'd be saving
here, not super convinced patch 3 is the right trade off...

