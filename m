Return-Path: <linux-kernel+bounces-119319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DDCC88C705
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05A44B23CA9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACD713C8E2;
	Tue, 26 Mar 2024 15:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="cDEEblNi"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6E158220
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711467148; cv=none; b=IoteN8r4VdNNsnaaqbR48xbyhlq0qp1fF1csHFJbUW/m7orXUaBT8EP0iQRDO8Z8Vy4R8umEFV1d/xTkDqTA+yF1W4OSodIk21yBDaxT1gAA2wlp+FEcKmmgNSQhLFkDLoKByblTXc9UoGkYL2E3WqhzsSry9eVOM06Es8MReJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711467148; c=relaxed/simple;
	bh=GLatH7ZOZFENhKDsjDGlkbHAT25/qlITlr0m28sLf1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5/MkOGQdfPijiIPkTtbDrFxkqGcpFXh4IpIShazcuFVddVCwm62veUBtHOBuC5E2oP1s/YLvcQSHLS1+GaDJtyiWsINMTmoNbnnrrYM8IiLQGwwmEjSvXsJS2jk00t7DcPngWUi/mdBeAMGyc049wGE0Yf8xXnHtHMtWhb3wUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=cDEEblNi; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-690d7a8f904so59122036d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 08:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1711467145; x=1712071945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O3SHR7HxdotDZ2M8AZNxpUiAzi1WTnbP3eb5Z70DWwE=;
        b=cDEEblNiAVtCyfEV6MbEuaHjUO9yn1GdSZn2AbetcrY14TkpcfdJT82gOsdNrellwK
         0bFxXc7VcfPCkk4zEvrK6sxEvIZA8MsjFSp3dKYh8ymz4H8rRJSzaYIZk5YKR1eO25Wr
         STRE59SAC8eJAs7l4ClbRSIv1QSjPhNFFBbKbuiQg82hKC6O8TvD5avVn8ywbpxizhim
         xjF1ame40YwmcIUXWu6aBi4h/rVHulWnm7a6do26F2fXLd6JDfgd6UyILP0jVWIskHmf
         KVuFXAmH+h6QgxmS+niXOiCzZxi3dRKw+YlbWY7wDTzM9zanDSQN3t1BZ9wt3lbZWKSP
         ZozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711467145; x=1712071945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O3SHR7HxdotDZ2M8AZNxpUiAzi1WTnbP3eb5Z70DWwE=;
        b=K65aodugpjSVurGLdp34R01SszfB4tdLL6IbBKYETpUVkf8AF9sm6uquerZmxSpJWp
         iJsDFB9xTLntZcBujpzuFDw8qxvbReugoJrhXgvfX+d2nGZbV1As30lIoTYAKMG7YlbE
         jMJAu+HJNxjUAoZksvoLSi2odDyM/vhBUM8nbjIBZTrnotSjDKm3j6g8vV2PO0FITms3
         x/o0qpOcoRt+wJc90wvnN9/I54aCwlo+eYz3rwomyZOaai5r73da+2WmTpDU4rIuCZfE
         mLwXmTsGWjbMMr4IF0GQfRUYz+t4Bb8XuMjAt+2dByjk6fRTEYHUG0XtNT0iJjOGay+M
         3L3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUNBbVzvGZvxR2hBFRD0nm999OjvDRuTGz/cBFF+FNI4+6l7B7L1TCK4vlKtCkEqhHiyIn06xM0UfFJim3fOonc2gw7dmnj8RQmHlVs
X-Gm-Message-State: AOJu0Yx0DxxT9Hyw6TQ8EyviERU4gxmDGPzIyCEBqNdmWOO7fTiIpq6k
	As8gzLRK4YdblVg8vkuCuGtyVS9eq5gv5SUdJom82AboWUlw+VNrvUSGI+iY3TU=
X-Google-Smtp-Source: AGHT+IFb5rsoFzP1zcQcm+tSf+kkK6vnwteEHMmMK0+qzdpITXfqA9F3uCSQSSM/c2javsPnq0SJmA==
X-Received: by 2002:a05:6214:2249:b0:696:89ae:9f57 with SMTP id c9-20020a056214224900b0069689ae9f57mr2883743qvc.25.1711467144748;
        Tue, 26 Mar 2024 08:32:24 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 5-20020a05621420c500b006968303bf73sm3279781qve.94.2024.03.26.08.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 08:32:23 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rp8ml-003UNx-AR;
	Tue, 26 Mar 2024 12:32:23 -0300
Date: Tue, 26 Mar 2024 12:32:23 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Margolin, Michael" <mrgolin@amazon.com>
Cc: Tao Liu <ltao@redhat.com>, Gal Pressman <gal.pressman@linux.dev>,
	sleybo@amazon.com, leon@kernel.org, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: Implementing .shutdown method for efa module
Message-ID: <20240326153223.GF8419@ziepe.ca>
References: <CAO7dBbVNv5NWRN6hXeo5rNEixn-ctmTLLn2KAKhEBYvvR+Du2w@mail.gmail.com>
 <5d81d6d0-5afc-4d0e-8d2b-445d48921511@linux.dev>
 <CAO7dBbXLU5teiYm8VvES7e7m7dUzJQYV9HHLOFKperjwq-NJeA@mail.gmail.com>
 <b6c0bd81-3b8d-465d-a0eb-faa5323a6b05@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6c0bd81-3b8d-465d-a0eb-faa5323a6b05@amazon.com>

On Tue, Mar 26, 2024 at 02:34:45PM +0200, Margolin, Michael wrote:
> Hi Tao,
> 
> Thanks for bringing this up.
> 
> I've unsuccessfully tried to reproduce this kernel panic using production
> Red Hat 9.3 AMI (5.14.0-362.18.1.el9_3.aarch64).
> 
> Are there any related changes in the kernel you are testing?
> 
> Anyways we do need to handle shutdown properly, please let know if calling
> to efa_remove solves your issue.

efa_remove should not be used for shutdown..

If you have an iommu in your system (smmuv3 for this ARM64 case) then
drivers must implement a shutdown handler or you will risk data
corruption on ARM64 sytems during crash.

The shutdown handler must stop all DMA from the device.

If you don't have an iommu then the shutdown handler shouldn't be
critical.

Jason

