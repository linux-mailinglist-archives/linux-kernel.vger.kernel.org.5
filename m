Return-Path: <linux-kernel+bounces-135906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B217189CCF1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E04831C21435
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84FE146595;
	Mon,  8 Apr 2024 20:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jKElYnm3"
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FF5143C59
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 20:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712608109; cv=none; b=nICWjaEoBTZmZffPONF048NAsuiCu+wcPWtgy4Yhxdk5aA5mBhOuZDmdnsmoACJkZ8oIkQzbpltwoDtDIsf9ziTlWbgZXl4oAOj0hPkbc9zD2m9PaoIrtQmKASXtc1aRvH2e1r4H4FrqARTuFMB01baqcJARLjiJydrE/jBBORI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712608109; c=relaxed/simple;
	bh=pGwspNNQBRAnBw9TeuWds6iJ0wMzGbfaAQXYhsJEudo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l02ZYWoabsH/vQZlmFmIdqyXf8a5HB4wQjoZ0kr2bx6JhHRft+qd1cPwT1peJO7jB17pm0OnUIGc3BS/EzdHCNSW1LnI7Vg7zf3VeI9q8LMznKcQcbhrrpTHQ0QoSkpKkECsRoqj1HAsT0ra1Q1EaqKyVjHNBR2Y8cvZjmn4y4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jKElYnm3; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-7d03a6a11a2so221189239f.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 13:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712608106; x=1713212906; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=moQrw458UIrB0C/FS7KDVMJwIciBd7TguCfGXuFSIMQ=;
        b=jKElYnm3qKL5fNd2MT2qYWsotwlkUMhGB1ns5rWd7i+Q2r9s7mvkDpqdbeIKR8DMgX
         ZaFVLUeuM382QL2yHDjTByXnI3V0lgku1DdJ1lrrGH6YRtCFCWPSK7/g6ZSQqpF1a5C9
         IjC9/hcwml2LDeOcPWWif0C+viXs86RSMZhIDcsTapHEkskkmZN+zEE+Fo3mLpI9Wxvs
         rgwzrc843nNd+ELez3gDml0CnfH1wt0vLLZqrceEO0YrbhTBSIe1kboknASt9a9fWHnu
         LDV4EcfiJOyjJwZ5T69RNTkn8KT1Kyyx7v3tmCYtjWygePsFaRrrEEsTr9+EStK6picg
         JouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712608106; x=1713212906;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moQrw458UIrB0C/FS7KDVMJwIciBd7TguCfGXuFSIMQ=;
        b=w/t6kPOgZjs1Uhs4EjoN6KzaPC56vSsMGP9KB0EvdOykCaAiInvuuLMnnEb1x1TxAP
         nZyVezh8IVca3rHeXG6Dxy34RfoBXRiyoED6Db+nUmwQ1N8EVUMdKbv/GiIt2APHU4IN
         hgItDl3R5So6v2/O4bllN9TbVF36C3mH29Xpd01rhJld5Sk9YLwwTDg7JMb8y77nQVF9
         03OGxEuOHdDLjMJKO/eHDp8x3XqFQkceLxug+GGFOY7Uew7cZMj6HS8UZ8jjC3Zimp7z
         eQEm+Id0XZDmYfgslTbyqehBqJJGwp6B76Atvb+ElFK4RfoNnRCqECoTCOL5/xKTgAY2
         meYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFLDrRGpdS2GsF/mm5Pf+giwoceZytylQrF9EuvjG9dJbNsWcRzBB+buyYV8FtxPV2nn4oiviyPNvCwXqPDZWSgoNeBcbcIBN3Ile9
X-Gm-Message-State: AOJu0Yzdkd44JMUu5ne332jDUNQCIpGdbtqNz/asrmr3cgjS5xytM2lE
	PSfhj37DTULtGvuckDad6XxmRiEjvUtc7ulY3w3IXLheDJ7l+krYBddWLdM1KQ==
X-Google-Smtp-Source: AGHT+IEi+zQk9NHUGC5d8RML8yoINv3x6x1TBoWUm8X+CGwzfnVnH1lv+x3XDo71lciSEBs5bqtDKQ==
X-Received: by 2002:a05:6602:488d:b0:7d6:aa:8a64 with SMTP id ee13-20020a056602488d00b007d600aa8a64mr2450544iob.18.1712608106586;
        Mon, 08 Apr 2024 13:28:26 -0700 (PDT)
Received: from google.com (30.64.135.34.bc.googleusercontent.com. [34.135.64.30])
        by smtp.gmail.com with ESMTPSA id kz9-20020a056638948900b004828b1e39absm1344628jab.89.2024.04.08.13.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 13:28:25 -0700 (PDT)
Date: Mon, 8 Apr 2024 20:28:19 +0000
From: Justin Stitt <justinstitt@google.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] [v2] staging: rts5208: replace weird strncpy() with
 memcpy()
Message-ID: <wb5h2syqmxpoxmajwiiyqvlkyojjsjql5xpfmris6djegtqzya@6xfio4dmqjdp>
References: <20240408194821.3183462-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408194821.3183462-1-arnd@kernel.org>

Hi,

On Mon, Apr 08, 2024 at 09:48:09PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When -Wstringop-truncation is enabled, gcc finds a function that
> always does a short copy:
> 
> In function 'inquiry',
>     inlined from 'rtsx_scsi_handler' at drivers/staging/rts5208/rtsx_scsi.c:3210:12:
> drivers/staging/rts5208/rtsx_scsi.c:526:17: error: 'strncpy' output truncated copying between 1 and 28 bytes from a string of length 28 [-Werror=stringop-truncation]
>   526 |                 strncpy(buf + 8, inquiry_string, sendbytes - 8);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> The code originally had a memcpy() that would overread the source string,
> and commit 88a5b39b69ab ("staging/rts5208: Fix read overflow in memcpy")
> fixed this but introduced the warning about truncation in the process.
> 
> As Dan points out, the final space in the inquiry_string always gets
> cut off, so remove it here for clarity, leaving exactly the 28 non-NUL
> characters that can get copied into the output. In the 'pro_formatter_flag'
> this is followed by another 20 bytes from the 'formatter_inquiry_str'
> array, but there the output never contains a NUL-termination, and the
> length is known, so memcpy() is the more logical choice.
> 
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Link: https://lore.kernel.org/lkml/695be581-548f-4e5e-a211-5f3b95568e77@moroto.mountain/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: remove unneeded space byte from input string for clarity,
>     rework changelog text
> ---
>  drivers/staging/rts5208/rtsx_scsi.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/rts5208/rtsx_scsi.c b/drivers/staging/rts5208/rtsx_scsi.c
> index 08bd768ad34d..c27cffb9ad8f 100644
> --- a/drivers/staging/rts5208/rtsx_scsi.c
> +++ b/drivers/staging/rts5208/rtsx_scsi.c
> @@ -463,10 +463,10 @@ static unsigned char formatter_inquiry_str[20] = {
>  static int inquiry(struct scsi_cmnd *srb, struct rtsx_chip *chip)
>  {
>  	unsigned int lun = SCSI_LUN(srb);
> -	char *inquiry_default = (char *)"Generic-xD/SD/M.S.      1.00 ";
> -	char *inquiry_sdms =    (char *)"Generic-SD/MemoryStick  1.00 ";
> -	char *inquiry_sd =      (char *)"Generic-SD/MMC          1.00 ";
> -	char *inquiry_ms =      (char *)"Generic-MemoryStick     1.00 ";
> +	char *inquiry_default = (char *)"Generic-xD/SD/M.S.      1.00";
> +	char *inquiry_sdms =    (char *)"Generic-SD/MemoryStick  1.00";
> +	char *inquiry_sd =      (char *)"Generic-SD/MMC          1.00";
> +	char *inquiry_ms =      (char *)"Generic-MemoryStick     1.00";
>  	char *inquiry_string;
>  	unsigned char sendbytes;
>  	unsigned char *buf;
> @@ -523,7 +523,7 @@ static int inquiry(struct scsi_cmnd *srb, struct rtsx_chip *chip)
>  
>  	if (sendbytes > 8) {
>  		memcpy(buf, inquiry_buf, 8);
> -		strncpy(buf + 8, inquiry_string, sendbytes - 8);
> +		memcpy(buf + 8, inquiry_string, min(sendbytes, 36) - 8);

I must say I am not the biggest fan of manual string management with raw
pointer offsets. I wonder if scnprintf() could achieve your goal here of
combining inquiry_buf with inquiry_string into buf (perhaps utilizing
%.*s format specifier).

With that being said, I am just a casual reader of this code and I
really don't know much about the expected behavior of `buf`
(NUL-terminated, NUL-padded, etc) or even what the next line buf[4]=0x33
does.

Your patch looks good and removes an instance of strncpy which helps
towards [1].

Reviewed-by: Justin Stitt <justinstitt@google.com>

>  		if (pro_formatter_flag) {
>  			/* Additional Length */
>  			buf[4] = 0x33;
> -- 
> 2.39.2
> 
>

[1]: https://github.com/KSPP/linux/issues/90

Thanks
Justin

