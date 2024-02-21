Return-Path: <linux-kernel+bounces-75353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A265885E71A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:18:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 522C31F2293F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85A585C68;
	Wed, 21 Feb 2024 19:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="ZMOoE3vL"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9600D85955
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 19:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708543078; cv=none; b=sPlNzhny3l6A1+hWQFcaFWejr5+otcaXYdyayer2GWKcouTs8jPpQAwTTlvu9LTiOVKd+gr6eHqyTh2YqYIjDEMEqV2deI9oUqGyPORSOLn1b7059NoTP9VnAEpX1FtEAc7gvOVwO9ZyR87zEUzvhotNQOmicXYQbSbCRYvKKY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708543078; c=relaxed/simple;
	bh=M0FDvNe5gdx4GV6MSGP6C/r0ckrzasd1+5u7VS+D/BA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DOILaKpg2GCyo1VQRfSDGvy2okn6VITJfXievzCjCil3miJ8wN4f6xxwaGiVvV5KtyQIq1Hk6C68kaTEOIib5UAjnRfSQmWn9fGIDF6Wjj+vhDEIzLd20vpndCd5UfnGEv3UCtwYDl0UtlSvnTf2/FVxJjKoTijuvywsTlZd/YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=ZMOoE3vL; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dbf1fe91fcso31995025ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 11:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1708543076; x=1709147876; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPyGME1+D4Rx5RWLjxT2dahKKgtER+x9+Q9YDDK3GZ8=;
        b=ZMOoE3vL80Ynwz2ejJBBIbOsOmXSZcJJ7PjQrw2q4tyf8FCHLvgVYqKJjSr+svi30K
         s6oxbob2r0lxbnWcTKWCcCI+tseFhnxQ6+y3LdjVHNPDbsRMMJ0HqMLLFb/BToWchOdS
         HqLjXCJ+3LjPj9x4yJDcDODaTCzHUCPTFuKmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708543076; x=1709147876;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPyGME1+D4Rx5RWLjxT2dahKKgtER+x9+Q9YDDK3GZ8=;
        b=XBIps+6dsSL90/02lyLqvkjYJfyQoidWiPbbbAegLbvDftYPhdQXpj+d6ycXVz26Ve
         aPmL0k+zMoQAGyEknArDbfbz236ae4+P7IKLMfy5m2HXEGqbP3YyauvqToQEUyKUb9z7
         mcDBlv/OqUkc643Jgb20KDXKiwf2qX9tsEFgJ4QEB/ajD9ujoMO2xdoFBayhrr6gsF6L
         F5ieiSI01HB9wfJlHL02IVqAhBmGfh/KrSkUqeWWY5Q+OKOnPRuI+RKDsUDoDLxq547H
         DUrbP6a4eaMaBVtvoi8tpgdd/4cXvlIMZfiqffsBGDMiQj3YThInqzFXrFNgZWLl3FZd
         kTxA==
X-Forwarded-Encrypted: i=1; AJvYcCVzQLpS1OHG93NKQQXbQ4qQZdnxFOmRKV/vyJtklMBI8+oxeknzwN198JxL41fSVZQ3pWEjmICSadJsisg7dOBmJGznr5xs6qw7PeqI
X-Gm-Message-State: AOJu0YxdonF9jLF1pX2yhs6X5liB2DFys9Qy+BLFxIfQDtHaPtZV4KkC
	t/EDqPwW20jx7k7Gj0A8r0tWgJ9nXOQV01G5QtplqK2s/IuBYhGEVkzQgBlyyWw=
X-Google-Smtp-Source: AGHT+IHQ43TQqS81oq7BxL4LKPXRytHQQhnbBClXNRp3eXg0/eCkjOfuROs7YtvYUWtReCcYtmoQVg==
X-Received: by 2002:a17:903:1ca:b0:1db:aab5:1db5 with SMTP id e10-20020a17090301ca00b001dbaab51db5mr19811932plh.42.1708543076046;
        Wed, 21 Feb 2024 11:17:56 -0800 (PST)
Received: from fastly.com (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id bj11-20020a170902850b00b001dc3916853csm1143816plb.73.2024.02.21.11.17.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Feb 2024 11:17:55 -0800 (PST)
Date: Wed, 21 Feb 2024 11:17:53 -0800
From: Joe Damato <jdamato@fastly.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH net-next 1/2] netdev-genl: Add ifname for queue and NAPI
 APIs
Message-ID: <20240221191752.GA68788@fastly.com>
References: <1708531057-67392-1-git-send-email-jdamato@fastly.com>
 <1708531057-67392-2-git-send-email-jdamato@fastly.com>
 <20240221111220.4e6b6170@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221111220.4e6b6170@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)

On Wed, Feb 21, 2024 at 11:12:20AM -0800, Jakub Kicinski wrote:
> On Wed, 21 Feb 2024 07:57:29 -0800 Joe Damato wrote:
> >  	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_ID) ||
> >  	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_TYPE) ||
> > -	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_IFINDEX))
> > +	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_IFINDEX) ||
> > +	    GENL_REQ_ATTR_CHECK(info, NETDEV_A_QUEUE_IFNAME))
> 
> This means user always has to provide both ifindex and ifname,
> right?

That's right. I'm OK with omitting this requirement, though. I feel like to
your earlier point on name changes, maybe ifindex is enough as far as
required params go.

