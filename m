Return-Path: <linux-kernel+bounces-89857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F28B986F697
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 19:48:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC75281472
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 18:47:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83328768E7;
	Sun,  3 Mar 2024 18:47:52 +0000 (UTC)
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A661EB37;
	Sun,  3 Mar 2024 18:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709491672; cv=none; b=ZQ0NLv63T/ru57qtTg/DrknAtHpZaVMzhJaylDUBDfXqnaf6YYUjaFhLl/OqBmGyzFZZf9/ANbJoBl/KC0petxhHD8Wtcr0PyoZQC/MKu6ou+ORWvi7NHjj3tuwLjjANn0dqH7P7OWFC58N1p/XzowM84c4Kqwj435SIxOKBlLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709491672; c=relaxed/simple;
	bh=VWOFm4tp/nqIq4iUaCjVanBK0FPgSR4195k+RyVBmTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Egi5eowX2kl2rHMkk72CiOZ6syXAdU5MgkEu8Xifmi244qR6vCEse4BS28nQEvycaTY46QRN6poV0o+Ax44UNcKk2vrkK6GtXsPRbArud32QzWvvVweGRx3UTfGAdb8PEt7x+E8jhyFboTjcE1BqW2cwAPzfzxKihFxT1NTwJHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 9F536100DA1A6;
	Sun,  3 Mar 2024 19:47:45 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 6A666353E6; Sun,  3 Mar 2024 19:47:45 +0100 (CET)
Date: Sun, 3 Mar 2024 19:47:45 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br
Subject: Re: [PATCH v4 11/12] crypto: asymmetric_keys - Adjust signature size
 calculation for NIST P521
Message-ID: <20240303184745.GA9392@wunner.de>
References: <20240301022007.344948-1-stefanb@linux.ibm.com>
 <20240301022007.344948-12-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301022007.344948-12-stefanb@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Feb 29, 2024 at 09:20:06PM -0500, Stefan Berger wrote:
> Adjust the calculation of the maximum signature size for support of
> NIST P521. While existing curves may prepend a 0 byte to their coordinates
> (to make the number positive), NIST P521 will not do this since only the
> first bit in the most significant byte is used.
> 
> If the encoding of the x & y coordinates requires more than 128 bytes then
> an additional byte is needed for the encoding of the length. Take this into
> account when calculating the maximum signature size.
> 
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

Reviewed-by: Lukas Wunner <lukas@wunner.de>

