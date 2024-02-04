Return-Path: <linux-kernel+bounces-51709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB2F2848E7D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 15:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8061E1F22444
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 14:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 402381EA6F;
	Sun,  4 Feb 2024 14:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9E7sDIx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BCA01DDD7;
	Sun,  4 Feb 2024 14:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707057318; cv=none; b=K0sxowF8Nozm8mKpVOcbnrQAXAMUcXmcxeFhDusbZYVFTlQsgKqQ/YpN57T1WfJPA631Z7kQT1skkV4kxH0bTCie+dwqqKbQpxJw67/LJ89CgfNOhbYIzkPoh6hjU3hM1B5rGZ33l0r0zr7npo2Z2vZelECC/EnVK99W/e40+Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707057318; c=relaxed/simple;
	bh=awoxN+LCbkkokatZAAIy7lRCtvPNshr7ALjiqC/b9Dw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oENV0FQESY2GITwQxZL9KEpiobiKaBV8F2peXf4ol8VFn9f+NPpy9FJAco6aLz7jrE5cGE3SmG70hS09I6LMwz2GMtY2yuphs2XzsV6uvLvJXGdLMKnQr9Mac9h22kV/pykBehzGte3VeXZq+2Qq07AQuaqP6isa2f85/9W9Rbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9E7sDIx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5691C433C7;
	Sun,  4 Feb 2024 14:35:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707057317;
	bh=awoxN+LCbkkokatZAAIy7lRCtvPNshr7ALjiqC/b9Dw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z9E7sDIxdImlRl1LZst/Ws48XUjtoa2LWbX4doA5jXzdGfV5wBpXgTsFO665ZvNyL
	 u8ROGapSQNwXDD05CDRNAr7HoV9OQ2VSjXtUzTy5kRQ2/6quoZqZvrBII5Pa9eCcNc
	 /N6hy7Yi7TBxPgtx1KR/x678IaCjZWAjL9nImuughwv1M31gpbpeZ9Kwp8hQ80SDjk
	 ZzJJNO5np00stUCmx05Ob3/s7DPUhs3+PLez+URQ55s/HH5Xwt2FwHEc6JoSj16tr8
	 LqwJ5MSgz+a+oXjtLX2LU+6Rsw3cM8s7I7hXb/t7D6fwBimAglIKnx8n48Efav8vFL
	 uIZ6FI4JZDrnA==
Date: Sun, 4 Feb 2024 14:35:13 +0000
From: Simon Horman <horms@kernel.org>
To: Bo Liu =?utf-8?B?KOWImOazoikt5rWq5r2u5L+h5oGv?= <liubo03@inspur.com>
Cc: "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
	"alex.aring@gmail.com" <alex.aring@gmail.com>,
	"stefan@datenfreihafen.org" <stefan@datenfreihafen.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-wpan@vger.kernel.org" <linux-wpan@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: ieee802154: at86rf230: convert to use maple tree
 register cache
Message-ID: <20240204143513.GB941651@kernel.org>
References: <982c399a2bd043a186a27a399f9b2493@inspur.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <982c399a2bd043a186a27a399f9b2493@inspur.com>

On Fri, Feb 02, 2024 at 08:08:14AM +0000, Bo Liu (刘波)-浪潮信息 wrote:
> 
> >Hi Bo,
> >
> >liubo03@inspur.com wrote on Fri, 2 Feb 2024 01:45:12 -0500:
> >
> >> The maple tree register cache is based on a much more modern data
> >> structure than the rbtree cache and makes optimisation choices which
> >> are probably more appropriate for modern systems than those made by the
> >rbtree cache.
> >
> >What are the real intended benefits? Shall we expect any drawbacks?
> >
> Hi
> 	The maple tree register cache has now got to the point where is is
> 	roughly feature compatible with the rbtree cache. It's based on a much more modern data
> 	structure than the rbtree cache

Thanks Bo Liu,

You have stated that maple is more modern than rbtree.
But please address Miquel's questions: what are the real
expected benefits; what possible drawbacks are there?



