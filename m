Return-Path: <linux-kernel+bounces-121390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 203A188E756
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBEF41F31767
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AA1140370;
	Wed, 27 Mar 2024 13:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SK8fYpPJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE0414036A;
	Wed, 27 Mar 2024 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711547488; cv=none; b=T/9hhZKycQXRXeYoYHfwtcURK1T2ALMLr6wd4bvWBzdazIaGy6tMlmAbnvDmz8c5m63032YqEGolcXOppJD5Zv3PETRHP8oCDLt8Oyalm04S6GugjyXWv+eES1UBkscWvlyjzI+sSeQbMFjb7mVpWgWvG1JC81kyEYzpDPGJn+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711547488; c=relaxed/simple;
	bh=C+/DHEdS6K2+oImIJDlxR2Qi86AMUZcRYdZThwNiKKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o15qqAJnk48yjzKf71MdeHxMY2s2Re3BruTi1EeuZIrxTaWHv4NsTB32hU7DevdSuFEc+R3mFIZisG23MAKBvH1GWz0SLDTWxRxYKATjFT4BqGeOKG1isLZb1zE3B2uUe6z+9/Qx5KZtDyjVCdguiiOG9G4XSN+mWfXy93zXyS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SK8fYpPJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD764C433C7;
	Wed, 27 Mar 2024 13:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711547487;
	bh=C+/DHEdS6K2+oImIJDlxR2Qi86AMUZcRYdZThwNiKKo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SK8fYpPJtAdUQJs3ZnedwLi/VYQpFHMCwgbWnHQOQdMOKNizlHjNNhEKiOpMVrTsH
	 C2WfQ2wT8Qy24ZJb6Sy+AH5ky09FMOcS80yXRlpdDHZTymivSxsckWnFHn1HSQltpm
	 3/0rB6geR7lpmwmhEPJI4CPrtEdw6IjaHzc5bPxOurPop2E8tYEaSgjPJDELsqTM1h
	 T2My22/I8YJiJeJfJKDeh8GLL6XkhMqxa7LwXwipJTAPXKEtPZPMmsPNhXMn+1FCBT
	 xipKCE3LGzlHeSBXrYS7HGWUJVMgxXKrwAw3MI6pvCujydGkvzlZXpTtF2BGcGkFbu
	 BhEZ77nCfIRIg==
Date: Wed, 27 Mar 2024 13:51:22 +0000
From: Simon Horman <horms@kernel.org>
To: =?utf-8?Q?Asbj=C3=B8rn_Sloth_T=C3=B8nnesen?= <ast@fiberby.net>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vlad Buslov <vladbu@nvidia.com>,
	Marcelo Ricardo Leitner <mleitner@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	llu@fiberby.dk
Subject: Re: [PATCH net-next v4 2/3] net: sched: cls_api: add filter counter
Message-ID: <20240327135122.GF403975@kernel.org>
References: <20240325204740.1393349-1-ast@fiberby.net>
 <20240325204740.1393349-3-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240325204740.1393349-3-ast@fiberby.net>

On Mon, Mar 25, 2024 at 08:47:35PM +0000, Asbjørn Sloth Tønnesen wrote:
> Maintain a count of filters per block.
> 
> Counter updates are protected by cb_lock, which is
> also used to protect the offload counters.
> 
> Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>

Reviewed-by: Simon Horman <horms@kernel.org>


