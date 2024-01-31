Return-Path: <linux-kernel+bounces-47114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC67A844983
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C75C28EEA2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443A33984A;
	Wed, 31 Jan 2024 21:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CINiIu8c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DB438F99;
	Wed, 31 Jan 2024 21:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735582; cv=none; b=GEU9ZbUo+Dr1d205iylenXvF983gSzDkEnAtKwZ2PQKdj8llKO/AZlAHZfKSsaGrPHDoXXuF0pXc6aT0FreWKdYEQDS9xWfjgP+0CjOKrGaG5ebuCHXeY8x7jgpXFF16YgFNKPXiWAKH0KVC0x+D1e0aNphy30d//hCiaf8KciY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735582; c=relaxed/simple;
	bh=DoZ1YihdlAS/IIbEKJ6/i00j2rTLW7LkeFYXNRHaTSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTovl5nMr0PVkWfr63blS4to9P9XUwoGATyAf4u5DqXHdsyF/tdLiNVS1g/VXwhp/UIhDvgnc39TQknmi4bRVpwAMUv1occoeKcwoTDOdTMhyIddZDMhEots7HvloBjcJYWZaE6/Lnu+Zuve5XQjJgnyDB7XKA3Y93eIOecRJ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CINiIu8c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C539BC43399;
	Wed, 31 Jan 2024 21:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706735581;
	bh=DoZ1YihdlAS/IIbEKJ6/i00j2rTLW7LkeFYXNRHaTSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CINiIu8czP40RCAK7E4RK0aQ+zAFTvmZilfkEdTqdNBRgkdym/LBfFgUFWIxkSyqC
	 UdV+OX0Der+1hMJg/aDvykJyveYus6z/NKcvdJjShIeiuvZFKNO36u1RruuogwTrNx
	 x16fAy55u9VoK6JrJygC5hPLDuwY8TKDfm/wp9ts=
Date: Wed, 31 Jan 2024 13:13:01 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
	op-tee@lists.trustedfirmware.org,
	Shyam Saini <shyamsaini@linux.microsoft.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Jerome Forissier <jerome.forissier@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Tomas Winkler <tomas.winkler@intel.com>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 1/3] rpmb: add Replay Protected Memory Block (RPMB)
 subsystem
Message-ID: <2024013108-hamster-audacious-9e3a@gregkh>
References: <20240131174347.510961-1-jens.wiklander@linaro.org>
 <20240131174347.510961-2-jens.wiklander@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131174347.510961-2-jens.wiklander@linaro.org>

On Wed, Jan 31, 2024 at 06:43:45PM +0100, Jens Wiklander wrote:
> +struct class rpmb_class = {

This structure should be marked as 'const', right?

> +	.name = "rpmb",
> +	.dev_release = rpmb_dev_release,
> +};
> +EXPORT_SYMBOL(rpmb_class);

EXPORT_SYMBOL_GPL() to match all the other exports in this file please.

thanks,

greg k-h

