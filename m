Return-Path: <linux-kernel+bounces-139259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC258A009D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:32:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4FD628611E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10700181335;
	Wed, 10 Apr 2024 19:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f07Bjwb7"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03DA172BBA;
	Wed, 10 Apr 2024 19:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712777519; cv=none; b=jhDT5guajPadXGr6gvk91S6ZwAjHUUf4Hl1uuw+nteRKDyFHdHbFutehfI80vqEIGOlxKBmiMDzzxSxpbz8ETslHH06uIVsdCUuBQchtQ13BoJKZRLtl51gNyMg3zHAdRR43xihF21EkmPffuEAEJ+2+Q7bkkYJEJwbJ2GHdl0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712777519; c=relaxed/simple;
	bh=affGpGfenMt3WZroBCjBwcF6ti3VyPoji9ShXHx5Efo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ipLmByWOCws7pcbw5qbu/DbSU5G6YbI5Ftl2IhTbcErpocoyBsUwcdaOmtHs4/xK/OYyul/nTUCTn7SyrN5hRvDpd/9WKguAOgl0eMDPEMq0AHSfKmQjX4rNHwonHaYd3g4Ub/HPfrfX62E1dbOohAp7kUhp/YR302GY5jugCMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f07Bjwb7; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-78ebc7e1586so17629685a.1;
        Wed, 10 Apr 2024 12:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712777516; x=1713382316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vRad0l69ZdTLBrwskwW40rKN+aCOPQ7/4HlpEGp2GHg=;
        b=f07Bjwb7ZswT+UfGBv3blNim4B+DOGbOhfz7OotZZvVVmDKGeW+gA3lQ+4u9gQY74n
         XmbTpVARwql4Nqv5YQMsqgl0wMUU7CHly/2poUCpll5mHaDILRhbvsacgMXQBEU0cBnd
         U3FKdP9N5wrp7nSMtw/LuUasY7HEdOxSkodTsw1GgQHTZM48x9LHz2f4WBdOFwSZ5peA
         fhfJnQu11m3M5qXw1ZZKBevqU+CLo53MdOODYyChhQ1FTCcvXs7BCkp5T9MxVrB7Qq5k
         fvxeaEBrEwOfY3ZHfBH9odXrUnKzEg3u+TisQ2PbbV5mTsaihvOanVM3RMhBhbDxx8zC
         jizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712777516; x=1713382316;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vRad0l69ZdTLBrwskwW40rKN+aCOPQ7/4HlpEGp2GHg=;
        b=LoOELvQOyKRIgdPRApYDbUjdkIqasB8m1HsTWdBbx3n1prTZ0whXxe0ySlxMa7HLjz
         IaD9wu7QwrRZqAjCvukROrpi3sOO8e6PmI4EcezN0gMUpJywuXkSaC1Dtbj2rrtqopRZ
         t6+Sazwz+KoaIYfO/NpymdLZknhSA+tUmARs3uPf3tU5i0KIfZ4ufFlZReYWfPWGhUqO
         dA0x3FXi2paq/CDqqWOs3s9k9BhYgtBB6NH0ImZvaudcUFQ5/3VQDtMaWRnKJQbWyeda
         e/0tzA9EsiTqPmO4WdrYWlBf1RY+pthEGwhCvMpNIi1lHAqG590MEfc17SdLmLcxEXNF
         rCJg==
X-Forwarded-Encrypted: i=1; AJvYcCUynTieedC1MFNaRSOiIS4k290gifQNdQyCN43k01UvRjTrRldhuclV3hOJLj4UoFRZ9WfgaxrzUkjt0FkDwn1nG9uFuzcGRAyC7ItuHWoPu3iar+Hb5syaHfrtJ1lv/+gsMQ5O
X-Gm-Message-State: AOJu0Yw+YUms5zkfc+QSRZDxn4xNe2oIIuio1/AezwxuBRpDD/kEy2d4
	6B2wsM2nJqnPT1uRrLP9QQg01NFE0sEltajxYKlbzrPcVDUqHiw7
X-Google-Smtp-Source: AGHT+IHokfeWRwBPEGPxbbrpu6y71Sgk54duSGrxuVrM5UgHwWMzilpw5lVpfZ5v/1RNSLy2qu0hfg==
X-Received: by 2002:a05:6214:287:b0:699:2dc0:8561 with SMTP id l7-20020a056214028700b006992dc08561mr1107698qvv.20.1712777516518;
        Wed, 10 Apr 2024 12:31:56 -0700 (PDT)
Received: from localhost (73.84.86.34.bc.googleusercontent.com. [34.86.84.73])
        by smtp.gmail.com with ESMTPSA id qh9-20020a0562144c0900b006969f5d3159sm5447445qvb.50.2024.04.10.12.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 12:31:56 -0700 (PDT)
Date: Wed, 10 Apr 2024 15:31:56 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 John Fraker <jfraker@google.com>, 
 netdev@vger.kernel.org, 
 Praveen  Kaligineedi <pkaligineedi@google.com>, 
 Harshitha Ramamurthy <hramamurthy@google.com>, 
 Shailend Chand <shailend@google.com>, 
 Willem de  Bruijn <willemb@google.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Junfeng Guo <junfeng.guo@intel.com>, 
 Ziwei Xiao <ziweixiao@google.com>, 
 Jeroen de Borst <jeroendb@google.com>, 
 linux-kernel@vger.kernel.org, 
 kory.maincent@bootlin.com, 
 andrew@lunn.ch, 
 richardcochran@gmail.com
Message-ID: <6616e92cbcca_2bfabf294c5@willemb.c.googlers.com.notmuch>
In-Reply-To: <20240410061928.712ff9a3@kernel.org>
References: <20240408180918.2773238-1-jfraker@google.com>
 <661550e348224_23a2b2294f7@willemb.c.googlers.com.notmuch>
 <20240409172838.247738f3@kernel.org>
 <87jzl5akh5.fsf@nvidia.com>
 <20240410061928.712ff9a3@kernel.org>
Subject: Re: [PATCH net-next] gve: Correctly report software timestamping
 capabilities
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Tue, 09 Apr 2024 21:40:46 -0700 Rahul Rameshbabu wrote:
> > > My gut tells me we force drivers to set the ethtool op because
> > > while at it they will probably also implement tx stamping.  
> > 
> > I think the logic should be the other way (in terms of the
> > relationship). A call to skb_tx_timestamp should throw a warning if the
> > driver does not advertise its timestamping capabilities. This way, a
> > naive netdev driver for some lightweight device does not need to worry
> > about this. I agree that anyone implementing tx timestamping should have
> > this operation defined. An skb does not contain any mechanism to
> > reference the driver's ethtool callback. Maybe the right choice is to
> > have a ts capability function registered for each netdev that can be
> > used by the core stack and that powers the ethtool operation as well
> > instead of the existing callback for ethtool?
> 
> Adding a check which only need to runs once in the lifetime of
> the driver to the fastpath may be a little awkward. Another option
> would be a sufficiently intelligent grep, which would understand
> which files constitute a driver. At which point grepping for 
> the ethtool op and skb_tx_timestamp would be trivial?

Many may not define the flags themselves, but defer this to
ethtool_op_get_ts_info.

A not so much intelligent, but sufficiently ugly, grep indicates
not a a massive amount of many missing entries among ethernet
drivers. But this first attempt is definitely lossy.

$ for symbol in skb_tx_timestamp get_ts_info SOF_TIMESTAMPING_TX_SOFTWARE ethtool_op_get_ts_info "(SOF_TIMESTAMPING_TX_SOFTWARE|ethtool_op_get_ts_info)"; do
    echo -n "$symbol: ";
    for i in `grep -nrIE "$symbol" drivers/net/ethernet/ | awk '{print $1}' | xargs dirname | uniq`; do echo $i; done | wc -l;
  done

skb_tx_timestamp: 69
get_ts_info: 66
SOF_TIMESTAMPING_TX_SOFTWARE: 33
ethtool_op_get_ts_info: 40
(SOF_TIMESTAMPING_TX_SOFTWARE|ethtool_op_get_ts_info): 59

This does not add up, but that's because some drivers share prefixes,
and some drivers have different paths where one open codes and the
other calls ethtool_op_get_ts_info. Marvell is a good example of both:

$ grep -nrIE '(SOF_TIMESTAMPING_TX_SOFTWARE|ethtool_op_get_ts_info)' drivers/net/ethernet
/marvell
drivers/net/ethernet/marvell/pxa168_eth.c:1367: .get_ts_info    = ethtool_op_get_ts_info,
drivers/net/ethernet/marvell/mv643xx_eth.c:1756:        .get_ts_info            = ethtool_op_get_ts_info,
drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c:5266:   info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |
drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c:962:          return ethtool_op_get_ts_info(netdev, info);
drivers/net/ethernet/marvell/octeontx2/nic/otx2_ethtool.c:964:  info->so_timestamping = SOF_TIMESTAMPING_TX_SOFTWARE |

One more aside, no driver should have to advertise
SOF_TIMESTAMPING_SOFTWARE or SOF_TIMESTAMPING_RAW_HARDWARE. Per
Documentation/networking/timestamping.rst these are reporting flags,
not recording flags. Devices only optionall record a timestamp.

