Return-Path: <linux-kernel+bounces-141981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE308A25BA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8752A286D11
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4CD1B946;
	Fri, 12 Apr 2024 05:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JK0N/ubr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3391E1F934;
	Fri, 12 Apr 2024 05:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712899760; cv=none; b=FHP8lr6S6+y2hhd1hDDbDrQ5+eWzh1M8MBRySkxXOm9y0v7lazI42Zlzm5z0QO3aZGsuT5UbX0u7r8c0g5NX0+NglMWmttymRHNmGckJ2pJHnxb73elWsCpaY2wSIzkku4GZVeEk1iM2e2jbtcqf75qJHd6kkWfnatIIQ/lhsEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712899760; c=relaxed/simple;
	bh=8bi6ee2KE7tWw9jg23MVgqYOY0sTFVighRqcEyShMDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQaOlQY4qmiD8h/DaXuK624M85u5sKl3h19wlNgjkIKnYcHtTOI2oUGAOQWMPLr2D68BWcvgH2RopiAFG2Uo54ctiMFMWnguU7n+3JTBrTW4yIHva4VaHh+AoYrQx4fUYdjF1QTLy96YIXOePGUc1qL5PCNJWNt15O7GJpRIm4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JK0N/ubr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DC5C2BD10;
	Fri, 12 Apr 2024 05:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712899759;
	bh=8bi6ee2KE7tWw9jg23MVgqYOY0sTFVighRqcEyShMDI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JK0N/ubrIi9OdOk2tmSbS505wxEfErtUdnCRVa9rBz4Vw3z02RncjXTp8P3pfx2Ct
	 pjqzWjahjrwIpelDreVQFYYvgxdbZumuCOODxIT9LwO315sdiTCaUZEWnSf2P5dotC
	 YMTxYV7IAExtWZvt2Y4h6/dRB5C7kI7etlxJ4s3M=
Date: Fri, 12 Apr 2024 07:29:16 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: parker@finest.io
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v2 3/7] serial: exar: add support for config/set single
 MPIO
Message-ID: <2024041213-uncouple-justness-35fa@gregkh>
References: <cover.1712863999.git.pnewman@connecttech.com>
 <3e671b6c0d11a2d0c292947675ed087eaaa5445e.1712863999.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e671b6c0d11a2d0c292947675ed087eaaa5445e.1712863999.git.pnewman@connecttech.com>

On Thu, Apr 11, 2024 at 04:25:41PM -0400, parker@finest.io wrote:
> +/**
> + * exar_mpio_config() - Configure an EXar MPIO as input or output
> + * @priv: Device's private structure
> + * @mpio_num: MPIO number/offset to configure
> + * @output: Configure as output if true, inout if false
> + *
> + * Configure a single MPIO as an input or output and disable trisate.
> + * If configuring as output it is reccomended to set value with
> + * exar_mpio_set prior to calling this function to ensure default state.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int exar_mpio_config(struct exar8250 *priv,
> +			unsigned int mpio_num, bool output)

When you have a bool in a function, every time you read the code you
have to go and figure out what that boolean means.

Have 2 functions:
	exar_mpio_config_input()
	exar_mpio_config_output()

and then have THEM call this function with the bool set or not.  That
way when reading the code you know exactly what is happening.

Same with other functions in this patch.  Naming is hard, make it easy
please.

thanks,

greg k-h

