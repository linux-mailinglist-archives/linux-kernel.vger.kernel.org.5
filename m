Return-Path: <linux-kernel+bounces-123823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F4202890E75
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 00:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2027C1C27D79
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F3E132810;
	Thu, 28 Mar 2024 23:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JtGNv6OW"
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7199C13A251
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 23:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711668053; cv=none; b=ibeUr9bSwUt8MwaPuOxHfIAx0bOdAdYo3SFXVxubKrHAZRFQ8yiCUJ01y9rHKSJM9mpLD9Gh8wK1o1pKLQI383uQQNCfJN7ScUjVmB79+I09zBQeKGKGjBACJs4EK2OsW9LI8x2NmlHJ8RtaDpLnSOPd2bE+HG6lrM70+8rOQSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711668053; c=relaxed/simple;
	bh=kXI/N2EFthFpwFqaePA7PW8txr3uYOT4NocqWhJIaVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GctMjp2YwOfyd0U8wT9keO398F2LZ6oUNpjmN7zoDo+E/kW+2Oe8k43V3knZz4ZMx4szRn0cto6rNa9/Rsmlfqk6di5dzQQzl1KBoXaLf4Uho1LpMy0unFCuoOPOFS9D4jdm07UG7I3RwDbmFYTyfClPRukEnDZsTkh7hC+2i1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JtGNv6OW; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-3688b72d08cso4846125ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711668050; x=1712272850; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mGHsh+olpz09agSrZ5PVuqusbfa5vJRT4mSuRZDIFFk=;
        b=JtGNv6OW60benBDqGVPZ3bqUhmh1j9GPfvO64R5YyWGeS/asRttAdCexm+qDjKEgk1
         gu9hOIl4AZ2woWGIcCRSURdvQI6dbJzb24zXdPNP6sPf58B40/1kDPu3iMFldCxQLn1P
         bVLzhMDCt/sYBmlvK+yxyVI0HKmsc6WEXr5T7Lcsyfm12tP8ZP2mRmP1V8wv0FuTsEql
         5N1vO0Co3mH9UAd16cUh0HF/80+Kmq5oW+vBfZqllmyeqs7p7PgdFLTh9BEeT78xiRJd
         gyw6CjjQ7P9eUZkUfA0zm2ZJvUipY8oDiW/FJtoOlHSCdV0SadsxZ5PW2wlZ8oMeKp2L
         j1ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711668050; x=1712272850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGHsh+olpz09agSrZ5PVuqusbfa5vJRT4mSuRZDIFFk=;
        b=vRMDFyem3I9nO3tztgaYLP6PKHw4eeMFXoBDzis9tGsoMxbMD5IJrZaco7Y2NvuWD7
         oI9lerwDZMIuhhQj95IF7qBj4aaIZqzzXbRg0pOgwKj3i007Tk7vlHfxkiMcrw4sZ4qG
         tI4SZTP/GouD1xzgHAqObYQbDmO9Xa5bCYPbrvaqHa4iRgg0xlVZiczm3GLRYPFIILQ1
         msyNj0dvFVCrSwBRU8H1ETNiEsKys9NtsWk5mX1ApCDkbvqS/hR3go/BFDDOzRF7FSH6
         29IxDmciBiy2E4IoDpCNTHFNzSwEgfTUqJzuYGWY/gX4eRYf3EGkezG5JN9JZKgyddLT
         w+hQ==
X-Gm-Message-State: AOJu0YzxysQoRzZESgV+52k2GJQOwEkH7MZ6H5QFN+trsiUR4ZTCKmp6
	KU7XMUHbrrLZhT24elOB3t0305jX9NxLyuAJs0y2DVG2kCP7XOOiuxTpa/XCaw==
X-Google-Smtp-Source: AGHT+IHj/RmxrwmmPniOkZLAq0PRG8Xgl98+vXzJdUNCAQfEqB2x3mGWkMwhUJC1dVUoP0aEft3VFw==
X-Received: by 2002:a05:6e02:3210:b0:368:a85d:2060 with SMTP id cd16-20020a056e02321000b00368a85d2060mr554729ilb.31.1711668050548;
        Thu, 28 Mar 2024 16:20:50 -0700 (PDT)
Received: from google.com (30.64.135.34.bc.googleusercontent.com. [34.135.64.30])
        by smtp.gmail.com with ESMTPSA id p3-20020a92d683000000b00368ad50d9e5sm715627iln.41.2024.03.28.16.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 16:20:49 -0700 (PDT)
Date: Thu, 28 Mar 2024 23:20:47 +0000
From: Justin Stitt <justinstitt@google.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Robert Moore <robert.moore@intel.com>, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, 
	Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>, Arnd Bergmann <arnd@arndb.de>, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Subject: Re: [PATCH 06/11] acpi: avoid warning for truncated string copy
Message-ID: <qjjr3joytboeadlax7ws3j3nxiflkbcclikl4z2pezpfyj2oup@ytyzgxoyihyw>
References: <20240328140512.4148825-1-arnd@kernel.org>
 <20240328140512.4148825-7-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328140512.4148825-7-arnd@kernel.org>

Hi,

On Thu, Mar 28, 2024 at 03:04:50PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc -Wstringop-truncation warns about copying a string that results in a
> missing nul termination:
> 
> drivers/acpi/acpica/tbfind.c: In function 'acpi_tb_find_table':
> drivers/acpi/acpica/tbfind.c:60:9: error: 'strncpy' specified bound 6 equals destination size [-Werror=stringop-truncation]
>    60 |         strncpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/acpi/acpica/tbfind.c:61:9: error: 'strncpy' specified bound 8 equals destination size [-Werror=stringop-truncation]
>    61 |         strncpy(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This one is intentional, so rewrite the code in a way that avoids the
> warning. Since there is already an extra strlen() and an overflow check,
> the actual size to be copied is already known here.
>
I also tried cleaning these up but Kees informed me that this subsystem
is maintained elsewhere:

https://lore.kernel.org/all/202308241612.DFE4119@keescook/

I am not sure if you can get changes through by the traditional means.

> 
> Fixes: 47c08729bf1c ("ACPICA: Fix for LoadTable operator, input strings")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/acpi/acpica/tbfind.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/tbfind.c b/drivers/acpi/acpica/tbfind.c
> index 1c1b2e284bd9..472ce2a6624b 100644
> --- a/drivers/acpi/acpica/tbfind.c
> +++ b/drivers/acpi/acpica/tbfind.c
> @@ -36,7 +36,7 @@ acpi_tb_find_table(char *signature,
>  {
>  	acpi_status status = AE_OK;
>  	struct acpi_table_header header;
> -	u32 i;
> +	u32 len, i;
>  
>  	ACPI_FUNCTION_TRACE(tb_find_table);
>  
> @@ -46,19 +46,18 @@ acpi_tb_find_table(char *signature,
>  		return_ACPI_STATUS(AE_BAD_SIGNATURE);
>  	}
>  
> -	/* Don't allow the OEM strings to be too long */
> -
> -	if ((strlen(oem_id) > ACPI_OEM_ID_SIZE) ||
> -	    (strlen(oem_table_id) > ACPI_OEM_TABLE_ID_SIZE)) {
> -		return_ACPI_STATUS(AE_AML_STRING_LIMIT);
> -	}
> -
>  	/* Normalize the input strings */
>  
>  	memset(&header, 0, sizeof(struct acpi_table_header));
>  	ACPI_COPY_NAMESEG(header.signature, signature);
> -	strncpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
> -	strncpy(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE);
> +	len = strlen(oem_id);
> +	if (len > ACPI_OEM_ID_SIZE)
> +		return_ACPI_STATUS(AE_AML_STRING_LIMIT);
> +	memcpy(header.oem_id, oem_id, len);
> +	len = strlen(oem_table_id);
> +	if (len > ACPI_OEM_TABLE_ID_SIZE)
> +		return_ACPI_STATUS(AE_AML_STRING_LIMIT);
> +	memcpy(header.oem_table_id, oem_table_id, len);
>  
>  	/* Search for the table */
>  
> -- 
> 2.39.2
> 
Thanks
Justin

