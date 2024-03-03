Return-Path: <linux-kernel+bounces-89713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D37486F493
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 12:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F222C1F21C77
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 11:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9DFBE4B;
	Sun,  3 Mar 2024 11:07:17 +0000 (UTC)
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72E5BA46;
	Sun,  3 Mar 2024 11:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709464037; cv=none; b=b9peFl2jfyYNlM+xSLLFAfqh9nvsbm9IfHOdQxY0sjpcI+/UuS2rjS3eq1eLRZF4NwKXZabvuMrDmB1gepj6f3O1k0D9qkNn5ziYsqN98pTc9+xmt7d1PIBNVJQUqGM9d3qCKSuwfffqG7U5b75xksbL3TTH9AwglO+Sz9bY0hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709464037; c=relaxed/simple;
	bh=I43RMyn6osBtg686uYMwi4dhcpjKKvp1hXc4tbwIK0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfCyW9RgEHye5vFaD6DlwZ8hiCTPUq3nYuc8alafI73kUxLkVloptHWCOm8UyVpjqas8ABsvr7Tist8GDyV9TdlxWzWJLnXiV3L0h49QB7GE2o1yspKvPSogs93Ac3InG49srFZ5/177kUsJDVzId2GLNcCO7uFQjdWsFSW5OXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 1CBD8100DA1C4;
	Sun,  3 Mar 2024 12:07:06 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id DAAC82E321; Sun,  3 Mar 2024 12:07:05 +0100 (CET)
Date: Sun, 3 Mar 2024 12:07:05 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br
Subject: Re: [PATCH v4 05/12] crypto: ecc - Add nbits field to ecc_curve
 structure
Message-ID: <20240303110705.GB394@wunner.de>
References: <20240301022007.344948-1-stefanb@linux.ibm.com>
 <20240301022007.344948-6-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301022007.344948-6-stefanb@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Thu, Feb 29, 2024 at 09:20:00PM -0500, Stefan Berger wrote:
> Add the number of bits a curve has to the ecc_curve definition and set it
> on all cruve definitions.

Nit: s/cruve/curve/


> --- a/include/crypto/ecc_curve.h
> +++ b/include/crypto/ecc_curve.h
> @@ -23,6 +23,8 @@ struct ecc_point {
>   * struct ecc_curve - definition of elliptic curve
>   *
>   * @name:	Short name of the curve.
> + * @nbits:      Curves that do not use all bits in their ndigits must specify
> + *              their number of bits here, otherwise can leave at 0.
>   * @g:		Generator point of the curve.
>   * @p:		Prime number, if Barrett's reduction is used for this curve
>   *		pre-calculated value 'mu' is appended to the @p after ndigits.

Nit: Looks like this kernel-doc uses 1 tab instead of blanks.

