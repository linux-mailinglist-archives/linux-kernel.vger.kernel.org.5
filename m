Return-Path: <linux-kernel+bounces-160815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7029F8B433F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 02:28:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A15B5284834
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 977B38BE0;
	Sat, 27 Apr 2024 00:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="F+lqUYr1"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D58A523D
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 00:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714177688; cv=none; b=RaQt3zcP3dBc6dJvbbEDLwj+HXLt6nIpMrgbP0bu8jWLzpdhpJrLL+E1nDFUks51KSdPOzT26jYcGxetV2t5BmeF1M8lARH/FevljdZGFweVTEVAmCC3h8fBkyZZwapD35xDcIjBjay8jD7S1HkIs+UgobxT0IYD2PYkIqNFci4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714177688; c=relaxed/simple;
	bh=TCybvemVxwB/PGZmuZrTIxFjueF9/NwMnx5uGPOboeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+MAHmelRzNCGMD/PUTW1op5Zq+xM5RoZp4pYAhJFdw8DBIBEluFRXqeMeZaZRotiBnJ32Ayb83J/HEDywzHFRSQBhdv6ZV+MQKGsDEBWSNw36oVKL/vAWbfvo6n7/BcFsDGrqy/2L7BrxaoLK1aOnHW5VaYPlr/b0HjLei8bZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=F+lqUYr1; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso1695044a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1714177687; x=1714782487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FXAQF51sDN9F3aF1HpNficcqCGNJWrnMVz3YT4ki65g=;
        b=F+lqUYr1KyCNWBp/ddOuQhyGN+V7hx+KyTfubUCO1ttf8+6Comw8qRmfyb7ZvVjmLU
         cnWzK88yJUi6DbSreLjvYFHixGycdYdhKxZRn2USvTKLwhuJiLvrBxmJ9um9XOsS9fp4
         47bqJnmG0q0BUQzxkkcFSAd3/30t/ankJnZP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714177687; x=1714782487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FXAQF51sDN9F3aF1HpNficcqCGNJWrnMVz3YT4ki65g=;
        b=O6uOf6jXkyCvryck7L5tL3gfLoO+r5mp4EYU8aln8vSqRiLROG6WrI2hzYGH70OiL1
         lCrmN8NV0HNpkYTcyibsijcw48FZvhgKPYsQxlSmDR//rHkqO7R4Cb5KPwjo/+OInbxK
         8/tK/iX00/pKk31JtGuqda/RdSQQXw8WG4/lunIXdph311emMASb/oYlz+OtLAs9escX
         VC4XZdCEmQw0IFxUpWGQYLmU8OA9LYN+utJd1V/o3ALRUGHrSiQYawRet96i6ejXsb+z
         B9ebtwrrAnRdqCFvrcFD7NcljZTQ2Uu1Kp1UCdOvHiAL7JarxDzhdW3+SbkzfGvMSRNL
         wvKQ==
X-Gm-Message-State: AOJu0YzncY3bzpPYC0TcdCZh7/0U353FNDClh/1y99IHJ5RzDJ+DKlei
	B0Bo6F8Kxf3U9qUv5GYTtJG4ZqIY5jbwHJnFfe2NTDyPdi95NHKEH0n0kcuu+ew=
X-Google-Smtp-Source: AGHT+IHR4o4yryMFbnUCig8ibhs2v3Z88xO2pthLFr1r98nC18QTME8VAmDR5VIm9UjWSoHYu8QIxw==
X-Received: by 2002:a05:6a20:9152:b0:1a3:bdd5:41f6 with SMTP id x18-20020a056a20915200b001a3bdd541f6mr5212265pzc.61.1714177686907;
        Fri, 26 Apr 2024 17:28:06 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id d11-20020a056a0010cb00b006e685994cdesm15356472pfu.63.2024.04.26.17.28.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 17:28:06 -0700 (PDT)
Date: Fri, 26 Apr 2024 17:28:03 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tariqt@nvidia.com,
	saeedm@nvidia.com, mkarsten@uwaterloo.ca, gal@nvidia.com,
	nalramli@fastly.com, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:MELLANOX MLX4 core VPI driver" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next v2 1/3] net/mlx4: Track RX allocation failures
 in a stat
Message-ID: <ZixGk8dy8INWD6PV@LQ3V64L9R2>
References: <20240426183355.500364-1-jdamato@fastly.com>
 <20240426183355.500364-2-jdamato@fastly.com>
 <20240426130017.6e38cd65@kernel.org>
 <Ziw8OSchaOaph1i8@LQ3V64L9R2>
 <20240426165213.298d8409@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426165213.298d8409@kernel.org>

On Fri, Apr 26, 2024 at 04:52:13PM -0700, Jakub Kicinski wrote:
> On Fri, 26 Apr 2024 16:43:53 -0700 Joe Damato wrote:
> > > In case of mlx4 looks like the buffer refill is "async", the driver
> > > tries to refill the buffers to max, but if it fails the next NAPI poll
> > > will try again. Allocation failures are not directly tied to packet
> > > drops. In case of bnxt if "replacement" buffer can't be allocated -
> > > packet is dropped and old buffer gets returned to the ring (although 
> > > if I'm 100% honest bnxt may be off by a couple, too, as the OOM stat
> > > gets incremented on ifup pre-fill failures).  
> > 
> > Yes, I see that now. I'll drop this patch entirely from v3 and just leave
> > the other two and remove alloc_fail from the queue stats patch.
> 
> Up to you, but I'd keep alloc_fail itself.
> If mlx4 gets page pool support one day it will be useful to run this:
> https://lore.kernel.org/all/20240426232400.624864-1-kuba@kernel.org/
> 
> And I think it's useful to be able to check in case there are Rx
> discards whether the system was also under transient memory pressure 
> or not.

Ah, maybe I read what you wrote incorrectly in your previous message.

I think you were saying that I should drop just the

  dev->stats.rx_missed_errors = dropped;

due to the definition of rx_missed_errors, but that by the definition of
rx-alloc-fail:

  alloc_fail = ring->dropped;

is still valid and can stay.

Is that right or am I just totally off?

