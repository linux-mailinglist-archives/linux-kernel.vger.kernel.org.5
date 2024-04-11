Return-Path: <linux-kernel+bounces-139639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 103F48A05A5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 927CCB2138B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 01:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC973626DD;
	Thu, 11 Apr 2024 01:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="syKWPlVB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266AE79DC;
	Thu, 11 Apr 2024 01:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712799951; cv=none; b=pkZDruTYrwoeXYAnc509bj1OJP91Ffp3EUfPtoCK2szY1hxULEI2oAq+DGevrX4mApaj0IasYO3ObJupbDxbmf+yWKfPYquPeYNvhs+uvggMF1Ys5o5qE2dWQxa3XeNGX8KfPllEgXghntkwEg+UMNNxK1U50eXUPwodS3qoHD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712799951; c=relaxed/simple;
	bh=96JPsyovHm70cO+dYlyEAybI9z60jEL3XL8FpVSQQQc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=omQjsJD6mdjIzrzZiuAyuhswoYldDuAKYaXNPns2E5z0KOO5IYiowZOev720GkJ3DcN3gSPPcXIjwmyNT9d2FRzXVjUENvk7zxJqo9YIV4+hkxB6ksztXv2MI7f57LjTDliX4WTg62tenCub46aW2+jj6d+jEuPDPptcmA93WPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=syKWPlVB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F16C433F1;
	Thu, 11 Apr 2024 01:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712799950;
	bh=96JPsyovHm70cO+dYlyEAybI9z60jEL3XL8FpVSQQQc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=syKWPlVBgVOF1VvO1O9a91ej57SnGUP82id2usB9LXZt32Fk2T9norGprxc/1W9ua
	 ARt8pw+yWBictAqdKx2eXHH634nYa0CToKSd+VbCgXmvv861AxXLo3D+Al1q7ZGkSn
	 kTnxbukvVVCCdjkREtXVYJTI104h0lGZ+thvm/7zQsL+g01w3ojC6UihRZBfO3gyCI
	 UlTMZCFC0qcPL8HO+exdDYRJcx/zBONUc4Aq/rjx1KVmp/7/R1QQCiworMMMlWK5W4
	 u2JmgCAegfDsy8qDpLOpIDwL3Ea/LCv7A+fmRhEP/oJTJmmenpJiimbDCcghydChmz
	 iwIB8vcFRFQfQ==
Date: Wed, 10 Apr 2024 18:45:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 4/4] net: dqs: make struct dql more cache
 efficient
Message-ID: <20240410184549.5e5f77f2@kernel.org>
In-Reply-To: <ZhaZuOjq+b5nzqcs@gmail.com>
References: <20240408172605.635508-1-leitao@debian.org>
	<20240408172605.635508-5-leitao@debian.org>
	<20240409172149.6f285b68@kernel.org>
	<ZhaZuOjq+b5nzqcs@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Apr 2024 06:52:56 -0700 Breno Leitao wrote:
> > Doesn't this move the cache line bouncing problem to the other side?  
> 
> I think so. Looking at dql_check_stall(), it only uses fields in the
> second cache line, except now 'dql->stall_thrs' that is in the first
> cache line.

We do read num_queued at the beginning of dql_completed().
So maybe we we move the read of the threshold there we will be fine.

