Return-Path: <linux-kernel+bounces-87101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B025186CFAC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33D7DB21CB0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556C64AEC4;
	Thu, 29 Feb 2024 16:48:22 +0000 (UTC)
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19A9383A0;
	Thu, 29 Feb 2024 16:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709225301; cv=none; b=MRmomeuVHACZVLeitMZKCTuzu10CLk4wNzxGUL7tIv1aV+2tSkaSA4QCUeBpl73RqmUu/cHjStUfLSSd4WT7iCp0ae+u+jVchLQK+YtzXaq72mzv6C/dwb/M+//lAJVgiFuTW9NIrJ6ibaAX2DHoHKaEvgTba39fH/cCa4dq/rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709225301; c=relaxed/simple;
	bh=qOGUpVdRDAYJlycT5lc3gVy4K/H/F/f7brncKz6FGU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDVosfXoqHeWjw/BAVh7bYi5+VUppoaR/TA95+FOeCTMh4uMM3e0qaLv76aEUN1sFC5dH19tcbcL1yscik7aeygc1rHLvJt9CDqaSZT3XFB+UqnDB05ORrhxUh5XaH9Nqc/ltBDASVsSdVciQME/jf3V9lAIvPRT1f5/ob+47JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 12E44100DA1C9;
	Thu, 29 Feb 2024 17:48:11 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id D51985DD6B0; Thu, 29 Feb 2024 17:48:10 +0100 (CET)
Date: Thu, 29 Feb 2024 17:48:10 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br
Subject: Re: [PATCH v3 01/10] crypto: ecdsa - Convert byte arrays with key
 coordinates to digits
Message-ID: <20240229164810.GA7144@wunner.de>
References: <20240223204149.4055630-1-stefanb@linux.ibm.com>
 <20240223204149.4055630-2-stefanb@linux.ibm.com>
 <20240229091105.GA29363@wunner.de>
 <aabeec7b-618c-4d15-b033-4162b6e54f6a@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aabeec7b-618c-4d15-b033-4162b6e54f6a@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Feb 29, 2024 at 09:57:30AM -0500, Stefan Berger wrote:
> static inline void ecc_digits_from_bytes(const u8 *in, unsigned int nbytes,
>                                          u64 *out, unsigned int ndigits)
> {
>         unsigned int o = nbytes & 7;
>         u64 msd = 0;
>         size_t i;
> 
>         if (o == 0) {
>                 ecc_swap_digits(in, out, ndigits);
>         } else {
>                 for (i = 0; i < o; i++)
>                         msd = (msd << 8) | in[i];
>                 out[ndigits - 1] = msd;
>                 ecc_swap_digits(&in[o], out, ndigits - 1);
>         }
> }

Might be beneficial to add a code comment explaining the else-branch
is for curves with key length not a multiple of 64 bits (such as NIST P521).

Otherwise LGTM, thanks!

Lukas

