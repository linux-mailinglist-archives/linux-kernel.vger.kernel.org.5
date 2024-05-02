Return-Path: <linux-kernel+bounces-166694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B028B9E40
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 876C71F2580C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CB815E1EE;
	Thu,  2 May 2024 16:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SjOpADPw"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD9115CD7B;
	Thu,  2 May 2024 16:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714666153; cv=none; b=aFtuPKA45XX8oRCUt3QUfh07Gk7EnJ8ZafHs2rcBncTXubzLHSFO43HfAe0sTyZBeKgrmst302xmuiaMzDBiL/Se89g3IVXzrj1p2/wC+vofhEI0Wo/JCneVMmphLuKrNtRRd0ME3pXddM3N7a4rp2/QkLPIP+9neO8FnVAHvGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714666153; c=relaxed/simple;
	bh=bEIqQ5F5YN4F9JTpN1ESGIlQIRXLOYQv3szua/b9Dhs=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=K8QJbEPY7dfLz5WwCKBjb2lerY4tY2HtyQu6p6pK8QHM5C/R6kWE/3UQFGwQ5cwsEJr9idb7d4ER24IvDfxKNTTxAp3WAex+hAPnoKrfzG7EKo2unLjslrtb1mV8x5samyzklm5UcgAiUh7uInWCdDA9jhpVs5cfrLMFhYygo/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SjOpADPw; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714666152; x=1746202152;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bEIqQ5F5YN4F9JTpN1ESGIlQIRXLOYQv3szua/b9Dhs=;
  b=SjOpADPwVdwSK+j/pVMjAF2Yf00W62AWBVzh33mE98SECOIKXrxIwcFP
   hMTN3V4UyNwvIpE5M3HhlgAldWEvk/93+pWNalxbsnZ7lGS2z/rbJfVs7
   VTWifE8A9KkpK1SZLKCVvl2bahvSY/7D6LbIUWNZyAbTDuiW3oOfNZjdW
   bZ/ZfZV9g0hJwfdJ6ZmBzveVLFM1WxQ/CqSSvuL192t4Mf/ecNJ4zboL3
   px5VpaK04GZfVDkYlNAGr9vWCyxA9Ce4PcOt5yNmPJGM+qMMWaa4cSVbw
   aa3jKXBo/OKUxtGJfcNSYIHsVKNPns4orN/WEaIqTGnPfR8hy0T+Z1tZ4
   Q==;
X-CSE-ConnectionGUID: wxzK+aQoQQyp/aB4lN6qmQ==
X-CSE-MsgGUID: sUpDfCthSse3UJhuzf7+HA==
X-IronPort-AV: E=McAfee;i="6600,9927,11062"; a="27975649"
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27975649"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 09:08:30 -0700
X-CSE-ConnectionGUID: TXl1Wl+XRlC2W6neqMOg5g==
X-CSE-MsgGUID: Etv4bJKsRVy+2meoIb9Y9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,247,1708416000"; 
   d="scan'208";a="27143502"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.54])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2024 09:08:27 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 2 May 2024 19:08:21 +0300 (EEST)
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc: Parker Newman <pnewman@connecttech.com>, 
    LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 11/13] serial: 8250_exar: Use BIT() in
 exar_ee_read()
In-Reply-To: <20240502144626.2716994-12-andriy.shevchenko@linux.intel.com>
Message-ID: <702a9145-5bc1-c765-a1fa-278702741637@linux.intel.com>
References: <20240502144626.2716994-1-andriy.shevchenko@linux.intel.com> <20240502144626.2716994-12-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 2 May 2024, Andy Shevchenko wrote:

> Use BIT() in exar_ee_read() like other functions do.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/tty/serial/8250/8250_exar.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> index 306bc6d7c141..bf3730f4231d 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -340,13 +340,13 @@ static u16 exar_ee_read(struct exar8250 *priv, u8 ee_addr)
>  	exar_ee_write_bit(priv, 0);
>  
>  	// Send address to read from
> -	for (i = 1 << (UART_EXAR_REGB_EE_ADDR_SIZE - 1); i; i >>= 1)
> -		exar_ee_write_bit(priv, (ee_addr & i));
> +	for (i = UART_EXAR_REGB_EE_ADDR_SIZE - 1; i >= 0; i--)
> +		exar_ee_write_bit(priv, ee_addr & BIT(i));
>  
>  	// Read data 1 bit at a time
>  	for (i = 0; i <= UART_EXAR_REGB_EE_DATA_SIZE; i++) {
> -		data <<= 1;
> -		data |= exar_ee_read_bit(priv);
> +		if (exar_ee_read_bit(priv))
> +			data |= BIT(i);

Does this end up reversing the order of bits? In the original, data was 
left shifted which moved the existing bits and added the lsb but the 
replacement adds highest bit on each iteration?

-- 
 i.


