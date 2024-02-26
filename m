Return-Path: <linux-kernel+bounces-82314-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E2486824A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DFA71C24694
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939A9130E5D;
	Mon, 26 Feb 2024 20:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="n5GKoXZ0"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D5912F388
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 20:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708981152; cv=none; b=jIQngutlgTZi+n9RcyQogORCtDU4gKogetjIplSKPrHRyjpL+ddFKyF1+UlWx72CXIeWnX8MLXDUrc+c42/kuL0nak49ogKZAmP/d7HfCABO6fjn/2S71e4NckJjgCGeS37MmwAzEuk8YDInAopRzCC1Hlw75DEFS6hF5OVtxaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708981152; c=relaxed/simple;
	bh=I13u80wehoL7yZigBlbWlZ9sIq0o3OU3G+/4u3mj824=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDdM6zLai9MVa0Aa2Av/8nEicDmSvjP2Mm436Jl8rEIzMH/DhezJvoa6STmrywHIS3yAjOQ2ATuiLHXjOxfeChA/nB2QxqeRsPS/bPclWbgksWwHlCEZNHtyFcp/3t2Ar4mbJ1FZas27eHFOPuSMHwCY55WxhyFug9JZrPNDNnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=n5GKoXZ0; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dcafff3c50so7545095ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 12:59:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708981150; x=1709585950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tvXtQkou+3jgtWiymj8iA4CC02C8/+k3MEqbkxtLPKw=;
        b=vUIXPOfAeLw4vLyRC2GHCpXVm+ZuUM6t6/JhezgWgti4pgvsC4Su7eu+4NO9fBqtDW
         At6P4tXodObxqdt6cMFSP9zlB4BIJ/g9Tu/pUnA9AI5vUQi5TP9aiCJAJAJ/p820t0yT
         RxRNneohjHdwMZtJakxxGvoolY41S6jMRo6oCxvRV4L8ee/Y32mfbesuHJOFWYPVI295
         6KM9ne4vAQNaBS7Xs52eGvaZ2p4wrpAb4NRQsoI4EQ4NoniYR7zQV6Uc4bHNzXEsmBGc
         NcDHc9IjE/+EPqvID9p4nMCHRdosUXraOqvT7al/pJKVx5dLOnWGA21R7uPr36clx1z1
         jdKA==
X-Forwarded-Encrypted: i=1; AJvYcCVEZKaDv/ngQEIi0O5bMHB1vTHsYdxTU4ygRwixycjFMiex6gXzFmTnS/jo1RNzPHpnxawY8Bjwb8wN49VVwIqxTlkJ4cW4iHN6o8fj
X-Gm-Message-State: AOJu0Yzjeb3C93XBR7t/IUIfvBqOCxK4B8GmZJJbmKE2sD5lOZd+Gq5k
	tjMyVE5ApPVuZMBWqC8h5KhEVfH2/3VQuLSoaNB9VVXfFO8feA4x
X-Google-Smtp-Source: AGHT+IEl9slEL2hYnORXfQhlJr0N8zi7zwtb/4MHBm69JdEjfna6RlEEcHsmlCwJts1srq5ul5ohVQ==
X-Received: by 2002:a17:90a:e681:b0:29a:d7ba:2c99 with SMTP id s1-20020a17090ae68100b0029ad7ba2c99mr1783387pjy.10.1708981150468;
        Mon, 26 Feb 2024 12:59:10 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id sh14-20020a17090b524e00b00298ca3a93f1sm7213170pjb.4.2024.02.26.12.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 12:59:10 -0800 (PST)
Date: Mon, 26 Feb 2024 18:00:03 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708981148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tvXtQkou+3jgtWiymj8iA4CC02C8/+k3MEqbkxtLPKw=;
	b=n5GKoXZ0G8qjH7PgyxYBabm8cJZNQK60cM2AA7trHXqbEngzJwg7iSCdAypXVFTBG185ok
	FlRMAJHHIoHLu/KCMriXJiEAtbagV0dbqJ4V1iaW/RWSLiYsmwv1X32nG7Rlb+bd3RG0rw
	zFMDZ1Q2GfcrBZQamF2iIqvQ+EJ4hQf9F2x110ddW266hXEvI4c4tK8HPt+2jgyQto6y5g
	ssrwcwuZHTeEE3Dd5MbaXZ5beN39uwibH/1juxNTuF0wu9QGLl+3PJvwXz+ZdaKaLNAEmP
	URigvlwP2IUjDidJWra99YrLFOp1ehWUTA6EUGT0Lj5S8J5FBsGLzuM9m/3YiQ==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Alex Elder <elder@ieee.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, greybus-dev@lists.linaro.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] greybus: constify the struct device_type usage
Message-ID: <i2pptclnx3otryvzzndtfh5zqgmenbe2aa36xfrbpuripbfsym@5ophc6hj3u3g>
References: <20240219-device_cleanup-greybus-v1-1-babb3f65e8cc@marliere.net>
 <cf5b2696-d7ca-40fc-856a-52f352cd270c@ieee.org>
 <ids3525jm5zkwkgizt2xtg3do37kqqtfdy5gc2cptdduexoe7r@cr4yxh3tykkh>
 <2024022553-deepness-sublevel-73de@gregkh>
 <yru2ywkyqwhg3rpyuqkkx73fxkkgsfj3vcbttnzrjq662ctrov@boh65bhxjjgo>
 <17e89261-d46b-4845-9fca-05dac3006a39@ieee.org>
 <xsotlft7byeu4iyyzty74dgzxtszmvyj4nuhga7qwuqc2tnubc@lp4ut22lc622>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xsotlft7byeu4iyyzty74dgzxtszmvyj4nuhga7qwuqc2tnubc@lp4ut22lc622>

On 26 Feb 17:21, Ricardo B. Marliere wrote:
> On 26 Feb 13:50, Alex Elder wrote:
> > On 2/25/24 5:04 AM, Ricardo B. Marliere wrote:
> > >>>> On another subject:
> > >>>>
> > >>>> Johan might disagree, but I think it would be nice to make
> > >>>> the definitions of the Greybus device types as static (private)
> > >>>> and make the is_gb_host_device() etc. functions real functions
> > >>>> rather than static inlines in <linux/greybus.h>.
> > >>>>
> > >>>> It turns out that all of the is_gb_*() functions are called only
> > >>>> from drivers/greybus/core.c; they could all be moved there rather
> > >>>> than advertising them in <linux/greybus.h>.
> > >>> I guess it depends whether they would be used somewhere else in the
> > >>> future. Perhaps it was left there with that intention when it was first
> > >>> being developed? I agree, though. Will happily send a patch with this if
> > >>> desired.
> > >> Let's clean the code up for what we have today.  If it's needed in the
> > >> future, we can move the structures then.
> > > Sounds good to me, will send a v2 then!
> > 
> > I might be misinterpreting Greg's response; I *think* he
> > agrees with my suggestion.
> 
> That's what I thought too.
> 
> > 
> > In any case, please do *not* send v2 with the purpose of
> > including my suggestion.
> > 
> > If you send a v2, keep it focused on this original patch.
> > You can then implement the other suggestion as a follow-on
> > patch (or series).
> 
> Indeed, this one is good as is but I thought of converting it into a
> series so that they can be taken with no dependency on this one. So it
> would look like:
> 
> Patch 1: move "is_gb_*()" into drivers/greybus/core.c
> Patch 2: move "device_type greybus_*" into drivers/greybus/core.c

Sorry, this made no sense!

> Patch 3: make "device_type greybus_*" const
> 
> But you're right. I could simply send 1 and 2 after this one has been
> applied. If I were to send them separately, how would I communicate that
> there's a dependency? Something like:
> 
> ---
> This series depends on [1].
> [1]: lore://link-to-this-patch 
> 
> ?
> 
> Thanks and sorry for the noobishness
> 
> > 
> > 					-Alex

