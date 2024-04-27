Return-Path: <linux-kernel+bounces-160801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C1B8B4303
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 02:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64EA21F267DD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 00:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3662ECC;
	Sat, 27 Apr 2024 00:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="Xhhec6hw"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8F7C139
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 00:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714176312; cv=none; b=jMGBJg8V7RftVpFh2tVz+M33cewrtEQobJOYJ/YQhNblGQf/eCiMBq53giXq7CvOmdXGDVpgT5ew0qPw+LzEX7i6IGfsGFd3MBwS34i38eEVBoVi+zmdqbVcw83htRpRIrU6Nkwa9i4oNhJ+ThmUXxXarDxfgn+ylUd8HGEBH88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714176312; c=relaxed/simple;
	bh=/fd/N7v3qro9nza0VrndytUPmzZi7jlSVwjA4rio/DY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVeW2f6Lw2RjeICAx2qdwH7yis/2SLJa3FryQistOXGoP26GE+hwKsfOsnUJXJs86LJYjx93BLlAJ3Rg4nM8VWRGo2Eib6kBLlWeEcNaG1hyk/sE4VViNAB4feFCFOOxDTnL52DO776405UJmCX6hOKt9/XgGoNBZgk3curDPPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=Xhhec6hw; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e4bf0b3e06so26305355ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1714176309; x=1714781109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lRc2kHVSDrDvqQGDE2B5fMNzoZg6D0PSUdf9JLW6aCI=;
        b=Xhhec6hw769ekVwKoZMZZHsTFAvdFBUYSfIqexVVDLpFIgII/LrTXF5FcVb8HHrbmB
         UBbl8EBptLAhFVL4GYWCZRNBQV0xwUBitta1ci21BI5mspqzLpuYB2SD1QRXGH6WSn6h
         mvrDn6h5Y9Dv6rZn31fqAz0tH306aL90dhdC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714176309; x=1714781109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRc2kHVSDrDvqQGDE2B5fMNzoZg6D0PSUdf9JLW6aCI=;
        b=fpGPpUXZe05S4o41R93BsfmpzCOgZCBMb3/prgqj9dO2yRWkFfFntFbSjdvKmYhWqV
         81jpIceG04wohp9G6ZhrLh0uSxdOMaPJwjE4B0zcXdvspiojdeYrpQ57T82JDYI2NKWu
         Zy7FxX8ykBEW9WNe4aE8TR4YlzGMGGLft2vmuiiIWEQGRYM88x7JPgFurMsC4CFnFNG4
         YtrvAPevpA2HHGi0lq3pcQ2SBEvmi1Ogj75Del+IrH+vgN1HDaz7enwW1hsnY0ouE+NQ
         IYQwkS/zN33rqYi8tof2CW3lG5uHPY2W9XOUcR+PPk/W3BkmPnjMllxwxGO/Azo5nN3A
         WLCQ==
X-Gm-Message-State: AOJu0Ywr6YNuO2LAFKgzlwD6xk5z9oYnipH7uoxZ9FLZM5c27Qv20OCt
	wUfe+Gv2Df6by9rbaCwBFvtkFCx/pkSoB37hj4N2g+YI4nT7DnEG4in+Ahe/R+A=
X-Google-Smtp-Source: AGHT+IFN27qWIbdvnvs9eKXT4KClDm7VytA2q/XzZf3cRRyIQdpg9N4Tfs4AOsINPgBeX9k7ZKTCaQ==
X-Received: by 2002:a17:902:dad2:b0:1e4:9bce:adcf with SMTP id q18-20020a170902dad200b001e49bceadcfmr5001638plx.63.1714176308979;
        Fri, 26 Apr 2024 17:05:08 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id jc14-20020a17090325ce00b001e50dff6527sm15992243plb.269.2024.04.26.17.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 17:05:08 -0700 (PDT)
Date: Fri, 26 Apr 2024 17:05:05 -0700
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tariqt@nvidia.com,
	saeedm@nvidia.com, mkarsten@uwaterloo.ca, gal@nvidia.com,
	nalramli@fastly.com, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"open list:MELLANOX MLX4 core VPI driver" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next v2 3/3] net/mlx4: support per-queue statistics
 via netlink
Message-ID: <ZixBMZLq5nPl9kU9@LQ3V64L9R2>
References: <20240426183355.500364-1-jdamato@fastly.com>
 <20240426183355.500364-4-jdamato@fastly.com>
 <20240426130116.7c265f8f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426130116.7c265f8f@kernel.org>

On Fri, Apr 26, 2024 at 01:01:16PM -0700, Jakub Kicinski wrote:
> On Fri, 26 Apr 2024 18:33:55 +0000 Joe Damato wrote:
> > Make mlx4 compatible with the newly added netlink queue stats API.
> > 
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
> 
> Not sure what the "master" and "port_up" things are :) 
> but the rest looks good:

So in mlx4_en_DUMP_ETH_STATS, the driver calls mlx4_en_fold_software_stats
which does the same "port_up" / "master" check and bails out... so I figured
for these stats I should do the same.

Was hoping Mellanox would give us a hint, but glancing at the code where the
MLX4_FLAG_MASTER bit is set, it looks like sriov ? maybe "master" means pf and
"slave" means "vf" ?

Not sure why the stats code bails on is_master but not is_slave, though.

> Reviewed-by: Jakub Kicinski <kuba@kernel.org>

I'll add your reviewed-by to my v3 and wait until sometime mid next week to
send the v3. Hopefully we'll hear back from the Mellanox folks by then if they
have thoughts/opinions on the stats code.

