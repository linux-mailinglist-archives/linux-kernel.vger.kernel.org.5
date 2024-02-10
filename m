Return-Path: <linux-kernel+bounces-60302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E7C8502E0
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 08:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96C65B2371A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 07:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A41424A1C;
	Sat, 10 Feb 2024 07:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QNBi4MHC"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3547212E7B
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 07:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707548609; cv=none; b=lYgvIWUhfbORGK/B6EgvfAKgKRJh7D5Nub2QghCQkmLtm2c8FCrOcuqYdFeqOXbUFQ4kaBUWcRdwhz1UufazdzauKQE9s+Gfl2/4HYtHRsM0nj0C6sLPQoz7GMQh1XMmUftONFNF0ismcIlMxoMBArEjPD9MBRCilg1C1NeLykc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707548609; c=relaxed/simple;
	bh=fzKd5sM2H6OinEuv0B/JTwhdgPCIwQL/U62Z5YuhAMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=An/yPJSVt8yMpq5Q7BV0EKe5hGIEswvPtOy4UX8PjiQvei62+mzd4g5JIO3WJzOLnX2gHPZiqmWanNuxU2haPp+rswfS4FlQKnm8Mb47SOA1gmga1yfr+JonbF+Ch03on4k1AnnqSfWqhfMOE+/mK/lOma/OY2Nn+1Lcyag4lQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QNBi4MHC; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d72f71f222so14664365ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 23:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707548607; x=1708153407; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a/R0p3sqbp/oJ8NLKMCn4/HQbHB5whK36xRfdKQiMls=;
        b=QNBi4MHCqYKpZD7DlgyE/gLswuXWngOMZ4qKTY1GGFla9rtsfW4jV+yHqB30UNx6BK
         oKBPhjLl6O81AzxzAjaOoX5lDoNws4twjXGZYyDi/fTwMjS7o2nORk1uQRvXBxYeSBUO
         QP1+A2Iqe8hY6GbaUOCi2QRJb8dceD05TW8FU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707548607; x=1708153407;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/R0p3sqbp/oJ8NLKMCn4/HQbHB5whK36xRfdKQiMls=;
        b=rOBLMn2bGG+aT650d9PIKTPfSxgntK56tnUr04x8MiQAkioYrxNM+oQl99FgBc1oCE
         BxBZKKdhufIIqtccF54ZtRk3P503Es26u1IPRfhVf8PxUvIB1CQ2B7P0ACqp4zjapkH2
         ZxVYT1Cq1tnotFAre0ksnuXqdfmp0VPvb4i3iacxE999KWwnqbYKsU1Wi9cuIVD3A9xL
         Wqn+3krBGUddsA6F1Xtu6SXvv2KG/TXTCqyKQ1WbM08WGDBjKt/FvxLCLQveflA2pdeh
         tBOWc1vea1U4iIJTBtR9NmH/dyYZGf7MzOeS5prw3PbZBczjJfKtypw54zXlWGcRLyvX
         dy7w==
X-Gm-Message-State: AOJu0YyqJzzgU4UGHCYRcxexglXLAChEOAUE7XMagAqmaUdfAEnSZcci
	qVNnbrY46IXhdHuvma2kzrTY0Hldhy0BmGmKjLy3KhPsRXTpYy+hPHC9d78nXQ==
X-Google-Smtp-Source: AGHT+IFiGLgdwQmJATPTmFlBcwGWgaIzbvqs2822TDnUmZtf6U5aNPq27owfp0ktcCJDZ9C9GKgs+A==
X-Received: by 2002:a17:902:c652:b0:1d9:6fce:54fd with SMTP id s18-20020a170902c65200b001d96fce54fdmr1365226pls.42.1707548607564;
        Fri, 09 Feb 2024 23:03:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVO7+Evqs1HW6o0qfGiQILNLSa6cprI3lXZgGBUCeMeOv/VmpNOebwjt30x43SD/dKi1n07wgZkgfg4aOM4y0QrCicc6kuBagNRfwlmg2uEeDxnuMFXvJtTmhC/PlQY1CIMLMWNCoB0Re2YH8uXNFLto0eiB9l1UZT4zFxiUPFbdl4u3XQPQ55VMbI28FNtpjHN7etXt5RhDfi9iDS+BOE1fQiQ7Ngc/y4rWtSfuIG8Ik8N2UFMa4WDB4UaLgNPbX3No8w8XM/GOgMr
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q4-20020a170902dac400b001da001aed18sm2486369plx.54.2024.02.09.23.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 23:03:26 -0800 (PST)
Date: Fri, 9 Feb 2024 23:03:26 -0800
From: Kees Cook <keescook@chromium.org>
To: Lee Jones <lee@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"PMC-Sierra, Inc" <aacraid@pmc-sierra.com>,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH 05/10] scsi: aacraid: linit: Replace snprintf() with the
 safer scnprintf() variant
Message-ID: <202402092301.5097145A@keescook>
References: <20240208084512.3803250-1-lee@kernel.org>
 <20240208084512.3803250-6-lee@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208084512.3803250-6-lee@kernel.org>

On Thu, Feb 08, 2024 at 08:44:17AM +0000, Lee Jones wrote:
> There is a general misunderstanding amongst engineers that {v}snprintf()
> returns the length of the data *actually* encoded into the destination
> array.  However, as per the C99 standard {v}snprintf() really returns
> the length of the data that *would have been* written if there were
> enough space for it.  This misunderstanding has led to buffer-overruns
> in the past.  It's generally considered safer to use the {v}scnprintf()
> variants in their place (or even sprintf() in simple cases).  So let's
> do that.
> 
> Link: https://lwn.net/Articles/69419/
> Link: https://github.com/KSPP/linux/issues/105
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
> Cc: Adaptec OEM Raid Solutions <aacraid@microsemi.com>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: "PMC-Sierra, Inc" <aacraid@pmc-sierra.com>
> Cc: linux-scsi@vger.kernel.org
> ---
>  drivers/scsi/aacraid/linit.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/scsi/aacraid/linit.c b/drivers/scsi/aacraid/linit.c
> index 69526e2bd2e78..0e47d9c4cff23 100644
> --- a/drivers/scsi/aacraid/linit.c
> +++ b/drivers/scsi/aacraid/linit.c
> @@ -583,7 +583,7 @@ static ssize_t aac_show_unique_id(struct device *dev,
>  	if (sdev_channel(sdev) == CONTAINER_CHANNEL)
>  		memcpy(sn, aac->fsa_dev[sdev_id(sdev)].identifier, sizeof(sn));
>  
> -	return snprintf(buf, 16 * 2 + 2,
> +	return scnprintf(buf, 16 * 2 + 2,
>  		"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X\n",
>  		sn[0], sn[1], sn[2], sn[3],
>  		sn[4], sn[5], sn[6], sn[7],

I'm confused about this conversion and the original size argument. Isn't
this also a sysfs entry? Size should be PAGE_SIZE, or it should be
replaced with sysfs_emit().

-Kees

> @@ -1302,13 +1302,13 @@ static ssize_t aac_show_serial_number(struct device *device,
>  	int len = 0;
>  
>  	if (le32_to_cpu(dev->adapter_info.serial[0]) != 0xBAD0)
> -		len = snprintf(buf, 16, "%06X\n",
> +		len = scnprintf(buf, 16, "%06X\n",
>  		  le32_to_cpu(dev->adapter_info.serial[0]));
>  	if (len &&
>  	  !memcmp(&dev->supplement_adapter_info.mfg_pcba_serial_no[
>  	    sizeof(dev->supplement_adapter_info.mfg_pcba_serial_no)-len],
>  	  buf, len-1))
> -		len = snprintf(buf, 16, "%.*s\n",
> +		len = scnprintf(buf, 16, "%.*s\n",
>  		  (int)sizeof(dev->supplement_adapter_info.mfg_pcba_serial_no),
>  		  dev->supplement_adapter_info.mfg_pcba_serial_no);
>  
> -- 
> 2.43.0.594.gd9cf4e227d-goog
> 
> 

-- 
Kees Cook

