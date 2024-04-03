Return-Path: <linux-kernel+bounces-129037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0829896391
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 06:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1CAC1C22CBF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 04:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415B7535BF;
	Wed,  3 Apr 2024 04:34:54 +0000 (UTC)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918F23EA97;
	Wed,  3 Apr 2024 04:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712118893; cv=none; b=JDnOodJCMs5JXHr2c//R0Zk4MqUonrN+ROLA7mF6AJhBoMUfXhwf3On3tZpWY2MbHTNN26XpEXu05nvGphAFZtsSODDBsRWuG6brUfV5vH0G2cqrCsPQN60Xma617BKEsHUAJ9goc/xEEsCQBmZehMCO+kjQCKhvIsqYAsMPx3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712118893; c=relaxed/simple;
	bh=d6t0OpZWCleSKwfIZcJNzzOAl2ghFpTA4jbzTs48FsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0rEbtacjscZfQslUbZxJMdE3qLgQ0Pf9BK9/P9MLVo2FnLbv2RoeoGjv0Ok/e8rdOToqrfJiDMaZ6HslEtvY73/T8sOe/trDZGO/vynf/vok0yQvBnvut7dikFeLSJFboCnQOlTAf9WQdIK7uV5Pdf8HVZanO18YYqyu3ZFDyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rrsKQ-00EQQZ-O8; Wed, 03 Apr 2024 12:34:27 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 03 Apr 2024 12:34:43 +0800
Date: Wed, 3 Apr 2024 12:34:43 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>, xingwei lee <xrivendell7@gmail.com>,
	davem@davemloft.net, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
	samsun1006219@gmail.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Re: BUG: unable to handle kernel paging request in crypto_sha3_update
Message-ID: <ZgzcY3/9sZkVWe/O@gondor.apana.org.au>
References: <CABOYnLzjayx369ygmr0PsGYGeRpnBnaH1XPqfbispL5nAeOJ9w@mail.gmail.com>
 <ZgvDe6fdJzgb8aZZ@gondor.apana.org.au>
 <ZgwfoSj7GqFiOOsc@linux.ibm.com>
 <20240402101023.aea0f8ed981903077dcd9e6b@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402101023.aea0f8ed981903077dcd9e6b@linux-foundation.org>

On Tue, Apr 02, 2024 at 10:10:23AM -0700, Andrew Morton wrote:
> On Tue, 2 Apr 2024 18:09:21 +0300 Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> > Yeah, there was a bug in folio_is_secretmem() that should have throw an
> > error about this.
> > 
> > David Hildenbrand sent a fix, it's in Andrew's tree
> > 
> > https://lore.kernel.org/all/20240326143210.291116-1-david@redhat.com
> 
> I'll send "mm/secretmem: fix GUP-fast succeeding on secretmem folios"
> upstream this week.

Thanks for the quick follow-up!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

