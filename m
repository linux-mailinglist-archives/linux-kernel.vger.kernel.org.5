Return-Path: <linux-kernel+bounces-103817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB5087C4EA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 22:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54AD11F220F9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E5E176C73;
	Thu, 14 Mar 2024 21:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oSMtl9W4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54EF376414;
	Thu, 14 Mar 2024 21:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710453302; cv=none; b=fFomu/CI8kvXKFn2jMctj+wiez5nNwotuv/egdWpKnPm7mF4l9BJgM6x5xwL4j5NeXBlS5ciyWfU7PybY5YjbmN7c1cUVkKAkj5fLhP5jrPdU8jI+y/e4cu6O8rRe1rV99nrgKn8tBHRpLSGNL0utCkqLparYZc50ElQ7rM1rA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710453302; c=relaxed/simple;
	bh=H4RYZfy6bgqOfA1gltQv38hEIlvGCb4vgyc16aGU3gw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TYARPhiI/lrqTQLGSzkBTfCWEGKYdIVjHYht8FPg5lUW1u6/X4pKt5vxoyekTj9lfwsifvkEZSrC4SEaubMwtnIUntW3g/Sn9jpExE6IFg8/usnIScKmiG5eaf1/GuKGo69t2g5Dza77df4ZnvtoDl6kFlEq9zk0dFiEaLpThRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oSMtl9W4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C389AC433F1;
	Thu, 14 Mar 2024 21:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710453301;
	bh=H4RYZfy6bgqOfA1gltQv38hEIlvGCb4vgyc16aGU3gw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oSMtl9W401FPzb/39ox5xpKbri4fysztQtP1mdvOl3BUcUDfDp7yreKs2KiFd0fda
	 OYovpfXCm/XlUb/f8kuJH3kPk9q/5QeiChoVqVanJ9c2BRU8vsxX8fVQBTY8h5VRMQ
	 /aGW/XnjqkoDqmISc9ctJdbIu/Mtw9QmRmCF2Zn4i9Me3upKuGSxFqWUqdH4n0szWd
	 pPIiYiFef+ycjDGXi9yEvf4TLWpXSBXgB2OFtp2i1m65l1qijuJR0VctgH4xC0WbdM
	 XTMmTpTLyOEDr6P6gCnVUwbfohXmzy8mMAbH55ikc/40KT1Vv7BOtCtRCfh7iEqQ9K
	 CP0UAz5W9wpIA==
Date: Thu, 14 Mar 2024 14:54:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yan Zhai <yan@cloudflare.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jiri Pirko
 <jiri@resnulli.us>, Simon Horman <horms@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Lorenzo Bianconi <lorenzo@kernel.org>, Coco Li
 <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>, Alexander Duyck
 <alexanderduyck@fb.com>, Hannes Frederic Sowa <hannes@stressinduktion.org>,
 linux-kernel@vger.kernel.org, rcu@vger.kernel.org, bpf@vger.kernel.org,
 kernel-team@cloudflare.com, Joel Fernandes <joel@joelfernandes.org>, "Paul
 E. McKenney" <paulmck@kernel.org>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdl?=
 =?UTF-8?B?bnNlbg==?= <toke@redhat.com>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>,
 mark.rutland@arm.com, Jesper Dangaard Brouer <hawk@kernel.org>
Subject: Re: [PATCH v3 net 1/3] rcu: add a helper to report consolidated
 flavor QS
Message-ID: <20240314145459.7b3aedf1@kernel.org>
In-Reply-To: <f71214e6221c5c50b32a62a33697473c756e604e.1710346410.git.yan@cloudflare.com>
References: <cover.1710346410.git.yan@cloudflare.com>
	<f71214e6221c5c50b32a62a33697473c756e604e.1710346410.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Mar 2024 09:25:49 -0700 Yan Zhai wrote:
> +/**
> + * rcu_softirq_qs_periodic - Periodically report consolidated quiescent states

> +#define rcu_softirq_qs_periodic(old_ts) \

scripts/kernel-doc says:

include/linux/rcupdate.h:271: warning: Function parameter or struct member 'old_ts' not described in 'rcu_softirq_qs_periodic'
-- 
pw-bot: cr

