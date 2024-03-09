Return-Path: <linux-kernel+bounces-98036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8458773F0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 21:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24BC5281BC4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 20:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308214F894;
	Sat,  9 Mar 2024 20:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ECBTE9LX"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2966C28DAE
	for <linux-kernel@vger.kernel.org>; Sat,  9 Mar 2024 20:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710017133; cv=none; b=NUDKzD2fXEBwiWM39ig7z7yI+hAI6NCt2IDLyV2VFdpZViI9Wu+OsQZXa5pFhSUoB2vRG+v1yyyBkzH6HnlA/aDoljCHPDbKc+mAcOyo3BtSygk4kEHDUR/d6IxEnK/KtMGCNiVLazDqH7VjNBs4g9avbmKsGwIBktB5kYebsX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710017133; c=relaxed/simple;
	bh=2xVQ6YLBTJufLI/pUinDakNOFXXAi/CnbR0aJFke73M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B2kGAdz0/Y+TKdUBexhgiuEKOSx2YeVcbnRoX3IolzNEScPyDKjfJXEQY2qaXjF+v+E95Qdv7qrKR1N4P1iVs/1dl3+ISYjui7hgvuBblhJ94LqKzVaL0tlArzjpxdCKOyhAUYTFvqpj8I7dntviXY/tP1rxygCgmMhNseDEd6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ECBTE9LX; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5dbd519bde6so2675836a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 12:45:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710017131; x=1710621931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j8cSVrzPl017CQylbPoOYG8VdJXWFcmVE4EDs2UuqbY=;
        b=ECBTE9LXQlzDQXbOeXAR0S6fjndJIFe88GjyLMRFeb5uWmZX3puGcvstsG3MnenZI5
         JoWQabF2GMk5TjxbhQOItm+lA/H17L7pUJt1qoM9hERHsVK0GIf1JKiE5gOlpiRwuTUA
         N6Z1GkjKMC1S5+CnprGRg09uzauUR7tStRqME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710017131; x=1710621931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8cSVrzPl017CQylbPoOYG8VdJXWFcmVE4EDs2UuqbY=;
        b=Jfp2KDtFJ38gZziNV5uk4oT1nAGXGlsacHBtObdz5Sj7Qu8mbTjxPkgUf/uZLOPS33
         lAFJZiPnoETcRRV7KVbtBeQbTl8oLnky2FpfQFMioWMpPZLhuHNGYf5XYZp1GT16nEYQ
         +99aw5Bp7rKeKrBB38o41hI5PSG7J+vZzgCO0RRFKfu6MtCR9kWlGtM7d4yqbCUMLQoI
         65JgXPK4wrOQHgluu8MGvmw5gOUktgwLHCnmMcOhUX9BFsJ3+H8NiHPKasAFmfizVWmE
         Jak80iFhh10slYQeXciBITxVV5UATS/NdxCOEONJ3+0kd0PIrvsCXEN94qFDqV2dWDUD
         rDuQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3a11UgPcbsE+LCkgKZopQ5Nq11/lrae4QzHoWFq3QpGWIyIhBOwAosre2uZfjMpe7ko6EMjlXF9ZlUzvTS0/qAlTLuqIX1azqpnrE
X-Gm-Message-State: AOJu0Yzmsux4OCBGJKSpjlTWR68sWiVUTh7qnL+7Ioe5NU93IkSHfQmq
	gcOq2mR3sLnm+fPNTODLKGN8zI/TqJGyLmuJ4ypn5Z9bfUKDZrGBsBexBTya0Q==
X-Google-Smtp-Source: AGHT+IEVVeTTmm+IlHRR7hp/Tp6eeDE6zj05vKbKaiwtCd8bjKCSTAtgUYYU7bL+A/ciRLcAq7YIIw==
X-Received: by 2002:a17:903:124c:b0:1dc:dfb7:a6e0 with SMTP id u12-20020a170903124c00b001dcdfb7a6e0mr2665355plh.50.1710017131440;
        Sat, 09 Mar 2024 12:45:31 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l5-20020a170902f68500b001dca99546d2sm1696286plg.70.2024.03.09.12.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 12:45:30 -0800 (PST)
Date: Sat, 9 Mar 2024 12:45:30 -0800
From: Kees Cook <keescook@chromium.org>
To: Simon Horman <horms@kernel.org>
Cc: Aleksandr Mishin <amishin@t-argos.ru>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Justin Stitt <justinstitt@google.com>,
	Felix Manlunas <felix.manlunas@cavium.com>,
	Satanand Burla <satananda.burla@cavium.com>,
	Raghu Vatsavayi <raghu.vatsavayi@cavium.com>,
	Vijaya Mohan Guvva <vijaya.guvva@cavium.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] liquidio: Fix potential null pointer dereference
Message-ID: <202403091243.99279C61@keescook>
References: <20240307092932.18419-1-amishin@t-argos.ru>
 <20240308201911.GB603911@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308201911.GB603911@kernel.org>

On Fri, Mar 08, 2024 at 08:19:11PM +0000, Simon Horman wrote:
> On Thu, Mar 07, 2024 at 12:29:32PM +0300, Aleksandr Mishin wrote:
> > In lio_vf_rep_copy_packet() pg_info->page is compared to a NULL value,
> > but then it is unconditionally passed to skb_add_rx_frag() which could
> > lead to null pointer dereference.
> > Fix this bug by moving skb_add_rx_frag() into conditional scope.
> > 
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > 
> > Fixes: 1f233f327913 (liquidio: switchdev support for LiquidIO NIC)
> 
> A correct format for the tag above is:
> 
> Fixes: 1f233f327913 ("liquidio: switchdev support for LiquidIO NIC")

FWIW, I have this in my ~/.gitconfig[1]:

[alias]
        short = "!f() { for i in \"$@\"; do git log -1 --pretty='%h (\"%s\")' \"$i\"; done; }; f"


then I can type:

$ short 1f233f327913f3dee0602cba9c64df1903772b55
1f233f327913 ("liquidio: switchdev support for LiquidIO NIC")


-Kees

[1] https://github.com/kees/kernel-tools/blob/trunk/ENVIRONMENT.md#git-command-aliases-gitconfig

-- 
Kees Cook

