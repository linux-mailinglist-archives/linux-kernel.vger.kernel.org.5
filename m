Return-Path: <linux-kernel+bounces-90585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E65628701B9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96AD7281C3E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9144B3D39F;
	Mon,  4 Mar 2024 12:41:31 +0000 (UTC)
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC9F1D53F;
	Mon,  4 Mar 2024 12:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709556091; cv=none; b=JeLnROQ5uW+KQKkGXLrgDnQzpEcT72aJrZhR4ROrW23C+iRXwtvxjZhTsmw6QNNb2b2HtU9SE/OYzcWONZ4Hzxo/RkyBQ/pO1dOXyUICRHKF9fkADl9VNjvaNQszaNHac6q3AFvc8LdymlKWiGA89aBpv02kg01ERsDYLlnuc6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709556091; c=relaxed/simple;
	bh=n4TJ0d6qjbOI8Xx4ib2oaN7MTZY5YsSPrg9jw/wrV3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YM0hx++jARa8qL8cLmfS+mrL5bfdiRJBmAmGy8hNR0CwOLiXqFTJ6CHRE8nM1cTD1sC39yIk453Jg/EWdLFJ/QDa0zwcQttgOeSE7MEm3jAjaxiWqFxqFfWHRQ4MijhYf7vVtX5PMz5cjL4PoOyqPLJTHTKne6pE/XqN1irjqUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.33.11] (port=42844 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1rh7dA-00CFAm-GK; Mon, 04 Mar 2024 13:41:22 +0100
Date: Mon, 4 Mar 2024 13:41:19 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: Lena Wang =?utf-8?B?KOeOi+WonCk=?= <Lena.Wang@mediatek.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"kadlec@netfilter.org" <kadlec@netfilter.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH net v2] netfilter: Add protection for bmp length out of
 range
Message-ID: <ZeXBb6dKL0GQe909@calendula>
References: <d2b63acc5cd76db46132eb6ebd106f159fc5132d.camel@mediatek.com>
 <ZeL1_-Pdq6Kw0NIO@calendula>
 <20240302115241.GA7494@breakpoint.cc>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240302115241.GA7494@breakpoint.cc>
X-Spam-Score: -1.9 (-)

On Sat, Mar 02, 2024 at 12:52:41PM +0100, Florian Westphal wrote:
> Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > > +	if (f->sz > 32)
> > > +		return H323_ERROR_RANGE;
> > 
> > Could you possibly place this in get_bitmap()? IIRC these are the only
> > two calls to this function.
> 
> How would you signal the error?  I think this patch is fine as-is.

Provide the bitmap instead as parameter, but this opencode variant
also LGTM, I am probably overdoing, we can take this as is.

Thanks.

