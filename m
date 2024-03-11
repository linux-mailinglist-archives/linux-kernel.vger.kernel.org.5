Return-Path: <linux-kernel+bounces-99322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC2487869A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B005D281D13
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53E552F61;
	Mon, 11 Mar 2024 17:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YCr3TBI/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB7E4D9E6
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 17:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710179246; cv=none; b=kph7F7idnOOVO9ha1wqdqdJyOcpHw9S7yKbWvhF6So4qCew/fECHoFkfaZcUF1cOVKDeZ2dPrsN6fSQuSUFsT4TARkSFcwN+30dhHGP5GSZeQVzqJV07RcMLiEfS+kJPgBOvxnp2TxoAmhrXDFD/bhsW7meKW4F6c1lca59SWrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710179246; c=relaxed/simple;
	bh=r7uClMLuZYE7AgrhsTWV2qszim5tbe2WKWP659ugFwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8ZngCxewK6sgoPe8v+UK8ybuzCIH+GHX4OIkvBtP1LiUb4mSC29pQGJPUnR26/3ZrQtGHAe4LJ/fIJKxkc1Pl8wTQ8hv5VnVsCTqJgSe+OEQAOCLrPuAnVoHtAUXah9NYcBVk73A+pTuGioswdnb/FiPAPnDsrFdFR6W+uDiw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YCr3TBI/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710179243;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e3tUcIlJ5o5Hs/7+gdyglVV0O0xMiKwtCqd2APcSMtU=;
	b=YCr3TBI/ENR1AkFjyEC9HN8lU7DyV0Yx9vVQpC2Ue5fEHaeSSL6abopXJkC+1W+OiX5TOY
	aJkD+Doa7e4QvgvSa+vmgsevFuTaD1qNWGiqfjxx8RidKOBbQ63C1Rqk1jVkVWH8rnbxOI
	yxnekcZDM0jA8kEDtAA4HJjLY2jfIxU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-VmhUtWdHNIiDbzbJDaljAw-1; Mon, 11 Mar 2024 13:47:22 -0400
X-MC-Unique: VmhUtWdHNIiDbzbJDaljAw-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-690b861a1c0so38402876d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 10:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710179241; x=1710784041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e3tUcIlJ5o5Hs/7+gdyglVV0O0xMiKwtCqd2APcSMtU=;
        b=QNf4g5VoTiwQZrOaHg59s9JpdQt6/G6my3Tzjfu6sr7Zl9ZXKXMi5XlUvP8XVTEgLU
         eq8zDUuPreFSTh8UsfhnB3VieDktTsJv6P5mo8c1p0TjE7fhAprdw1ZXXy16KleVWDFy
         trZImTbyMorlSbt5yBRJimb/sTrA+pkR08xwgtaHkNKI7ih6gOJNnb3upIqmVI+U5cc9
         ojC9VW+pYFFF9N5IToZgvvXMe62okLEmrYInkzzQdsnp4BdRckqmGEz5oZUgwD1dZ58l
         sLltQG4sWBaew/Mi2309Lr2OfWw1vqFDYsiADbJRIOP/HQlk1YNERa5dnrCHV4FsZuC7
         CMaw==
X-Forwarded-Encrypted: i=1; AJvYcCW31MQIG/irNgwM6Fm5BvOtSIbWCNj5CzkRPiwCG1vq98pJNUVgtaa+XOmw/jv0yPuZMURSHlmuIruzUlzyLRrQr/pwo6rKJT/rMUwm
X-Gm-Message-State: AOJu0YwincDlPnxnRiYrspTzS6xsG4feRZQMPqTRdOxhghNF/Cqbw3Nn
	c4PjnxVdAqYQWqsm0o0gycyYLhrZunmGE/3nN5Ep29kRXw1jfwf6tNn7CouQtY25odIPBnEMgxe
	Yus+0ibFRwNGlmAQ2YX08O0S97p/SnkXxgGlT1tgIwwsAW+0/CRqzhk3uvTAYBA1DA0vvWA==
X-Received: by 2002:a05:6214:247:b0:690:db88:9eb with SMTP id k7-20020a056214024700b00690db8809ebmr1672459qvt.50.1710179241531;
        Mon, 11 Mar 2024 10:47:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKkd3g/GU6B6xqvPUivb+7iFgK8i45ZkaZeEfZReIDlgxd3Q+6lkyFcUHq8gFduAC17Jv0uw==
X-Received: by 2002:a05:6214:247:b0:690:db88:9eb with SMTP id k7-20020a056214024700b00690db8809ebmr1672446qvt.50.1710179241228;
        Mon, 11 Mar 2024 10:47:21 -0700 (PDT)
Received: from localhost (ip70-163-216-141.ph.ph.cox.net. [70.163.216.141])
        by smtp.gmail.com with ESMTPSA id n13-20020a0cfbcd000000b00690bb839b5bsm2842551qvp.135.2024.03.11.10.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 10:47:20 -0700 (PDT)
Date: Mon, 11 Mar 2024 10:47:19 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: mpe@ellerman.id.au, linux-integrity@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, jarkko@kernel.org, 
	rnsastry@linux.ibm.com, peterhuewe@gmx.de, viparash@in.ibm.com, 
	devicetree@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/3] powerpc/prom_init: Replace
 linux,sml-base/sml-size with linux,sml-log
Message-ID: <s2a42qzx4pp7fvgde4p5t7pcwsop4wlm266e2gdgr2gb5y77cn@udrmavhiwqoo>
References: <20240311132030.1103122-1-stefanb@linux.ibm.com>
 <20240311132030.1103122-2-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240311132030.1103122-2-stefanb@linux.ibm.com>

On Mon, Mar 11, 2024 at 09:20:28AM -0400, Stefan Berger wrote:
> linux,sml-base holds the address of a buffer with the TPM log. This
> buffer may become invalid after a kexec. To avoid accessing an invalid
> address or corrupted buffer, embed the whole TPM log in the device tree
> property linux,sml-log. This helps to protect the log since it is
> properly carried across a kexec soft reboot with both of the kexec
> syscalls.
> 
> Avoid having the firmware ingest the whole TPM log when calling
> prom_setprop but only create the linux,sml-log property as a place holder.
> Insert the actual TPM log during the tree flattening phase.
> 
> Fixes: 4a727429abec ("PPC64: Add support for instantiating SML from Open Firmware")
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  arch/powerpc/kernel/prom_init.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
> index e67effdba85c..6f7ca72013c2 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -211,6 +211,8 @@ static cell_t __prombss regbuf[1024];
>  
>  static bool  __prombss rtas_has_query_cpu_stopped;
>  
> +static u64 __prombss sml_base;
> +static u32 __prombss sml_size;

Should inside an #ifdef CONFIG_PPC64 since prom_instantiate_sml() is?

>  
>  /*
>   * Error results ... some OF calls will return "-1" on error, some
> @@ -1954,17 +1956,15 @@ static void __init prom_instantiate_sml(void)
>  	}
>  	prom_printf(" done\n");
>  
> -	reserve_mem(base, size);
> -
> -	prom_setprop(ibmvtpm_node, "/vdevice/vtpm", "linux,sml-base",
> -		     &base, sizeof(base));
> -	prom_setprop(ibmvtpm_node, "/vdevice/vtpm", "linux,sml-size",
> -		     &size, sizeof(size));
> -
> -	prom_debug("sml base     = 0x%llx\n", base);
> +	/* Add property now, defer adding log to tree flattening phase */
> +	prom_setprop(ibmvtpm_node, "/vdevice/vtpm", "linux,sml-log",
> +		     NULL, 0);
>  	prom_debug("sml size     = 0x%x\n", size);
>  
>  	prom_debug("prom_instantiate_sml: end...\n");
> +
> +	sml_base = base;
> +	sml_size = size;
>  }
>  
>  /*
> @@ -2645,6 +2645,17 @@ static void __init scan_dt_build_struct(phandle node, unsigned long *mem_start,
>  		}
>  		prev_name = sstart + soff;
>  
> +		if (!prom_strcmp("linux,sml-log", pname)) {
> +			/* push property head */
> +			dt_push_token(OF_DT_PROP, mem_start, mem_end);
> +			dt_push_token(sml_size, mem_start, mem_end);
> +			dt_push_token(soff, mem_start, mem_end);
> +			/* push property content */
> +			valp = make_room(mem_start, mem_end, sml_size, 1);
> +			memcpy(valp, (void *)sml_base, sml_size);
> +			*mem_start = ALIGN(*mem_start, 4);
> +			continue;
> +		}

Same question as above.

Regards,
Jerry

>  		/* get length */
>  		l = call_prom("getproplen", 2, 1, node, pname);
>  
> -- 
> 2.43.0
> 


