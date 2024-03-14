Return-Path: <linux-kernel+bounces-103677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D0C87C2DF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 19:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A362B21266
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5281274E0A;
	Thu, 14 Mar 2024 18:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKsqAyc+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9440E1E480;
	Thu, 14 Mar 2024 18:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710441472; cv=none; b=Jos6OyZTR0BXIo9pPnv4nvMcmWlpZUaDwZtKUqzz47FCbb0vqvYJ2BV+M7f2He0X9vbxPGoCvbBkDMbqTthlPyQTxxmwL5YVtCImAjDwAre7phPXTeOSePp1reLlwjRWJ2LsyaiL+fqUuQBE1ESVxYfZ+c3NtNHnlqPpirUCQIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710441472; c=relaxed/simple;
	bh=AdXleS6G42NaJO6wIWWlaMgfT66/GrpVGfRg8o5MFAs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fg42p1vxNHtvqoHrwSxVz8u7SzUhv/dC2hTnQ9FPm9cW+SDJZjNXPVqjb5axj6bt0bboURr//3wsjxie7561HdAYDtU2ljOx1wV2U24q1ewHd3l+1p0gKSRtzM5O4SPBcM9dB9XdwiNyiX8A+r2LGYX7uLcZ2cX17bZWKDV+A3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKsqAyc+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B56C433C7;
	Thu, 14 Mar 2024 18:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710441472;
	bh=AdXleS6G42NaJO6wIWWlaMgfT66/GrpVGfRg8o5MFAs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SKsqAyc+l4rgPjOLits/Ow4pfump+/uktbARxvuPEC63HVGI7dYGTgrcXrH5gUVEm
	 60zGyyZvCJ6s5mSoRe0Im/vFurRksBYFJEFJUefhNuRK5eoArvbf1tv/K1t24t6nie
	 zxNNouKRk+XB144ld5OXFl1CH2m0NfVPsmWPuA+94KsKxAT1fkK462+sc6VTxPqbAX
	 rRlkKzGmpzI4SAYDt9IJ66Yv3ruIwPjkqwwgOEwkIBOIC8jgkr06lrVoAYHA+j13/X
	 N2ruhV0zEoC+CGFv03g32Zdt2anUyPAu68wck2GBavg0v1Acc8J6J+fGjrZDp06XzI
	 a15TmXgAPfiww==
Date: Thu, 14 Mar 2024 11:37:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Abhishek Chauhan <quic_abchauha@quicinc.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Andrew Halaney <ahalaney@redhat.com>, Martin KaFai Lau
 <martin.lau@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Daniel
 Borkmann <daniel@iogearbox.net>, kernel@quicinc.com
Subject: Re: [PATCH net-next v2] Revert "net: Re-use and set
 mono_delivery_time bit for userspace tstamp packets"
Message-ID: <20240314113750.5fa33ac6@kernel.org>
In-Reply-To: <65f2c9468188_3ee617294f9@willemb.c.googlers.com.notmuch>
References: <20240314010813.1418521-1-quic_abchauha@quicinc.com>
	<65f2c9468188_3ee617294f9@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 Mar 2024 05:54:14 -0400 Willem de Bruijn wrote:
> Abhishek Chauhan wrote:
> > This reverts commit 30bb896b98fce7d823a96fc02cd69be30384a5cc.  
> 
> Upstream SHA1 is 885c36e59f46375c138de18ff1692f18eff67b7f ?

Yes, and please also throw in a Fixes tag pointing at that
commit.

