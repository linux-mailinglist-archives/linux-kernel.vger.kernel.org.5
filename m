Return-Path: <linux-kernel+bounces-72334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C8785B21D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB2DC2819D6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E679356B6E;
	Tue, 20 Feb 2024 05:09:44 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1241E484;
	Tue, 20 Feb 2024 05:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708405784; cv=none; b=S6V+Ybk1JKVM+Pna+WsVwSfXewWFkkJ9C4/EI2ToNSRB9c3ZH5yuoQIlV4U2qypnVXHRvFcZHKJ3xuobp4EZoJ+jpAMPUQqw2onS5Sjs89yisgQfllTWJmJPINu9niUBy1FGWHlkpp46KPtMWZm/p4uIS7eUI6+0hFP2BCRSlOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708405784; c=relaxed/simple;
	bh=qE3m4ey1wSd/5GJq68ttthesLt1zRidR9UVACQubuzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6jckSd80o0tqng2SE4w7C44nps5JM3XWKHUv8rG1YEbhGUQ1oKreHPew0jVSK1XkztCcW6TcF69JxzS3m1qph378FbxmB/zgbXLU4ViV7Z9ev+kJIB3iagyKLzuwuI18vMk4n08Tm597Wp0eF2KmAf7SgxL3aclaDnkIRw+qqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rcINT-00FWkr-7C; Tue, 20 Feb 2024 13:09:12 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 20 Feb 2024 13:09:25 +0800
Date: Tue, 20 Feb 2024 13:09:25 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, davem@davemloft.net, hannes@cmpxchg.org,
	linux-crypto@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com,
	yosryahmed@google.com, zhouchengming@bytedance.com,
	chriscli@google.com, chrisl@kernel.org, ddstreet@ieee.org,
	linux-kernel@vger.kernel.org, sjenning@redhat.com,
	vitaly.wool@konsulko.com, Barry Song <v-songbaohua@oppo.com>,
	Yang Shen <shenyang39@huawei.com>,
	Zhou Wang <wangzhou1@hisilicon.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: Re: [PATCH v4 1/3] crypto: introduce crypto_acomp_get_alg_flags to
 expose algorithm flags
Message-ID: <ZdQ0Bfw82Uzsv7cK@gondor.apana.org.au>
References: <20240220025545.194886-1-21cnbao@gmail.com>
 <20240220025545.194886-2-21cnbao@gmail.com>
 <ZdQm7n6Jc3tqsg1F@gondor.apana.org.au>
 <CAGsJ_4yP1Z4xAy5DEiaPB14YsOSYuYa80C-UY6SC2_eT7vhK9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGsJ_4yP1Z4xAy5DEiaPB14YsOSYuYa80C-UY6SC2_eT7vhK9g@mail.gmail.com>

On Tue, Feb 20, 2024 at 06:05:16PM +1300, Barry Song wrote:
> 
> So it could be something like:
> if data is short, acomp driver works by polling; if data is
> long, acomp driver works by sleeping and waiting.

This sort of logic is specific to each piece of hardware and
should go into the driver.

There is no reason why an async driver cannot return synchronously.
The API fully supports this mode of operation.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

