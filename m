Return-Path: <linux-kernel+bounces-126921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDE8894477
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D012A1C217FD
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D684D9FB;
	Mon,  1 Apr 2024 17:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C9pLrKFK"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AD51DFE3;
	Mon,  1 Apr 2024 17:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711993707; cv=none; b=JnkkuWbKWufu8ihAvh/V6Xy9oF1nb20m3zDzr9uJImOA1+6GVX9RfGWaW8iNtsA86mRK2DeaGAJGclDZhSbDILH+0lB+phqiFVM/iNrtT8L695VRH4V5zqbhSykVqkmdxiaPXz1zV38Zb7+6F0QaRB0Ivrgd+Wdj6DUHh4zdHEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711993707; c=relaxed/simple;
	bh=cGKsto8joijaUzPJ36dDVYKo3X8qow71na/atRrnNpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Znlcz1PWbKPEV/5c+HQBpSTy+geNLuDMZ3V9YfYjzOQlZm+vyDtdq38y+OynzAd70yYFibtN6swKROxPMA/uCqldGMP/2hI9wqBKbyIw0vqRQsh0Igk41OIx4pXm7dvcBTHeMoZ8vJYLV9YXC4xfrx8aNGFBhpGCmNNR2RFHXfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C9pLrKFK; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41569f1896dso4657445e9.2;
        Mon, 01 Apr 2024 10:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711993703; x=1712598503; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zrigaZFXWcx1kCyKa9oGq8jbBkbvJ11REE5OiYoomxk=;
        b=C9pLrKFKkKowmmrAWAlvw8JiqrxhVp3bZL3oZSZr5QoR4cCDqLfUtR3IBf4fxZfLWd
         pOiMGYXC4Wzjjp28/9GqzWGwP5pC3Po/TA8gKq9079yQnZN6y5EafeoAc+1uncXGs3Zx
         ZMmrE0ZPcL2WLW+oS04YCWLiDT17bfI4rbIMGvgWsune0IFTjKg0iiC+26pTkzcgvutp
         R7YwpOqZ57uHiL9/K8D/7384VwRsBuGrkSBMSDo0qsdzyn+tt13KI4DmswFAppUNkWME
         qy+bbiIjLbKw4K8tVaG5h9AK9RJrL0Z4nweF5KH1YE+jHqYqT0a27/7hglQogPkU/h70
         /8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711993703; x=1712598503;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zrigaZFXWcx1kCyKa9oGq8jbBkbvJ11REE5OiYoomxk=;
        b=F6/SQCbKyvF5NaRa/gRmmQ/OgyfgNvWK+wgLhZzL/1vcItCj717R+C/5ocMtpj/bmG
         7T+DiVHok2kzc1JsNFVibWvZ3LzTPoVZqdxqHN6QL05CLyVd2d1iwQ587yCfSIl6TRT5
         fcyblcvGiACgaBqlhL14rbwMXDRTHLqA01fxNsxivbSGdTle2QmKSLUmd+KWMGBrdKTQ
         WK28Cuu4vXl9RXIAZzR9tMVIZO+vw1n3b3N3upy00Xqg95agZa7acbTfDaLlbt3SRr6o
         xQx9mR29nLUPlQbrrJRx+BBtvJTVjir7tQGuTvTeFci6TOI/76XTwUMfqh7MJrz7rpJl
         ouqQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSBm2V6+08QmV8CnYS+V+2JeJQP0EcbMTTFhjS/k7KR0ihslrrOMKwN9cId/kl6KIZDVpznSIEO3PD6bf+wSgNbgr2Cl3/H/FLVwTWgjVOq67Bny69Pu0acPguHf2hCzjyj3Au
X-Gm-Message-State: AOJu0Yy8EjWSRaZnlhX/R7vFuONy/VWfa9dhJu49BlCgKLrpluX1OzHk
	UDdKb3xdibe9krZFTIzWCDsEI7XRG6i/32g1NQrppwVyB0MOL8wS
X-Google-Smtp-Source: AGHT+IFFKEPqYBqhXPvo3d9e2KGAB3GpC18x3pZ1hRTgMveG4viHnSGaLgA5CQDjSMLrjG8QFtrf1A==
X-Received: by 2002:a05:600c:1907:b0:414:869b:dbd9 with SMTP id j7-20020a05600c190700b00414869bdbd9mr7334584wmq.9.1711993702998;
        Mon, 01 Apr 2024 10:48:22 -0700 (PDT)
Received: from Kalray-lp320 ([2a01:e0a:a92:c660:38e3:78b9:48eb:4246])
        by smtp.gmail.com with ESMTPSA id n17-20020a05600c3b9100b0041493aae77esm18603515wms.23.2024.04.01.10.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 10:48:22 -0700 (PDT)
Date: Mon, 1 Apr 2024 19:48:20 +0200
From: Piotr Wejman <piotrwejman90@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: stmmac: fix rx queue priority assignment
Message-ID: <20240401174820.GA22684@Kalray-lp320>
References: <20240303190339.52496-1-piotrwejman90@gmail.com>
 <20240311134144.7b1e1a34@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311134144.7b1e1a34@kernel.org>

On Mon, Mar 11, 2024 at 01:41:44PM -0700, Jakub Kicinski wrote:
> On Sun,  3 Mar 2024 20:03:38 +0100 Piotr Wejman wrote:
> > The driver should ensure that same priority is not mapped to multiple
> > rx queues. Currently rx_queue_priority() function is adding
> > priorities for a queue without clearing them from others.
> 
> Do you know what user-visible mis-behavior this may result in?

When changing priority to rx queue mapping with tc qdisc taprio command (man tc-taprio),
all packets with priority assigned to multiple queues are dropped.

> 
> > From DesignWare Cores Ethernet Quality-of-Service
> > Databook, section 17.1.29 MAC_RxQ_Ctrl2:
> > "[...]The software must ensure that the content of this field is
> > mutually exclusive to the PSRQ fields for other queues, that is,
> > the same priority is not mapped to multiple Rx queues[...]"
> > 
> > After this patch, rx_queue_priority() function will:
> > - assign desired priorities to a queue
> > - remove those priorities from all other queues
> 
> But also you seem to remove clearing all other prios from the queue:
> 
> -	value &= ~GMAC_RXQCTRL_PSRQX_MASK(queue);
> 
> and 
> 
> -	value &= ~XGMAC_PSRQ(queue);
> 
> is that intentional? Commit message should explain why.

Yes, that keeps other priorities assigned to that queue and only clears
the same priorities from all other queues.

> 
> > The write sequence of CTRL2 and CTRL3 registers is done in the way to
> > ensure this order.
> 
> Ensure which order? Looks like you're actually writing in the opposite
> order than what I'd expect :S First the register you want to assign to,
> and then the register you only clear from.
> 

I meant the order you wrote: first assign new priorities to a queue,
then clear them from others queues.

> When you repost please include a Fixes tag.
> -- 
> pw-bot: cr

