Return-Path: <linux-kernel+bounces-159774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFF58B33CB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2ED4B22511
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 09:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A442813E419;
	Fri, 26 Apr 2024 09:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UKc4Dp+j"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0673E13C90F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 09:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714123280; cv=none; b=LQfbx5Ikj6Hg5znhi3sBl8NwkTWLAtAR13eztjem+F1zkjwq6U16CnCP/pQLl6YnzUjLG0prGdi+6NyImuOvblFRIQkPxINMU0+HTNaJ/BILfS1HqMA7nIdjO5VmBIdTkLFqJA90objDSGXIDFjwp5utyT/Pnx3SWYiaxqMyYlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714123280; c=relaxed/simple;
	bh=YlSV9MHEdn0UkTqFkGp1sF2oEJTvEr43RosTA3ZgZ5s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cxvyrHZRDcWdFIgLNlxoXiG5gpHmLSxFrUYLzB3tRj4g/uS2hyeAh4SzUcsvBI0QwR2eVOVs392/cqW6Lmkt5/p+4rql+DfsFE86+8OLAvTbaf8K165pqPGVuRyJrS5QzOjVEFvi1KvuQWD3Q4iD3x+7BfSHnI3ccM+Uv9NAq8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UKc4Dp+j; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714123276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=l+OLn3fwvzI89G9RX/zIKYuqzytEnbtBvadhMUyN5tA=;
	b=UKc4Dp+jUIZq3LsZRL1V2r1V5yY5ZiXqEnHq4NdagviM2ib70cSkTZ8QGovX2JMRCIWEm/
	PaIfwKPKCno4EnVSDdGLZY3A7EHWspw29gBYsXvX+1jUepicbQ4CnC4raZ8UPBvRDZYiUS
	ekYGy/c0Rorb/DHe8ix2wZ9k13J4Ebw=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-PIx6_FtWPOeBrjI9cvSUlw-1; Fri, 26 Apr 2024 05:21:15 -0400
X-MC-Unique: PIx6_FtWPOeBrjI9cvSUlw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-51aeca18962so306661e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 02:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714123273; x=1714728073;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l+OLn3fwvzI89G9RX/zIKYuqzytEnbtBvadhMUyN5tA=;
        b=gx9DQmwXyEjlQbCqNGFPC/MdlYaWLkSvvDTg7Khr9U/G7P9obhD+hzmzZNQTYs5E0U
         OldKd23w031FsS1QcNuYm510IY70K17iIbUA91oupnNVCWKANDTW22/OKWTDrlQ5qfqI
         RVIeKsRHyHhzo03PMp/eZA/RRe+QQMu81MNRDRzKh5AZFkwWF6jbuquoX4xRUta061Q6
         YObUQblOpQPCL6CTyMEDbl34xJochyuaTCgMNFHiOXoFK0C/apmW826o7jNJHqKQjSFc
         mb6Z1099zl9v1jBwElNvmyqm4FTv7OwIwBG77ruEdhVH7MHX5zEAQe61IfeyTmPfQCFL
         6t0A==
X-Forwarded-Encrypted: i=1; AJvYcCWtS1F4P4uVij+uoaeAtaBXLhM57W/SetOTpjScruw7ox3xAk6ZdnT2PaXstQggVcG1hR8DfrZ1wxu4KsjH/4JElzCU5x90Juy8nsIZ
X-Gm-Message-State: AOJu0YxD9JEfq9xIK2f9+iob+xJZP/CvDxv68uJ18o6GR/u6zdxL4IyZ
	eXu84ZWd62q0GZJ68mZTQHKyUMqaCcWlLdMSeo+llNjZxoOFqWZ2X5SCr//dfV2OlHZFoRM7f34
	Dq/4ED7vCg3Vuj1fQB/xkBCwbB+eICmyzDu1Nw5zPZW7K2GMyOg52WuSU0x96WQ==
X-Received: by 2002:a19:690f:0:b0:51a:e38d:4e0b with SMTP id e15-20020a19690f000000b0051ae38d4e0bmr1061463lfc.0.1714123273672;
        Fri, 26 Apr 2024 02:21:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXvA5huHlGxI1WPaCJ1lc6Kqj4LqIycuj6/1VDXjrx/7VrlslPNPMVcDGK+TNjiE30qul/7Q==
X-Received: by 2002:a19:690f:0:b0:51a:e38d:4e0b with SMTP id e15-20020a19690f000000b0051ae38d4e0bmr1061443lfc.0.1714123273286;
        Fri, 26 Apr 2024 02:21:13 -0700 (PDT)
Received: from gerbillo.redhat.com ([2a0d:3344:171d:a510::f71])
        by smtp.gmail.com with ESMTPSA id d4-20020adfe2c4000000b0034a3a0a753asm20280165wrj.100.2024.04.26.02.21.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 02:21:12 -0700 (PDT)
Message-ID: <15b93453c79467ce3b46085019afe2a83d09f247.camel@redhat.com>
Subject: Re: [PATCHv3 next] ptp/ioctl: support MONOTONIC_RAW timestamps for
 PTP_SYS_OFFSET_EXTENDED
From: Paolo Abeni <pabeni@redhat.com>
To: Mahesh Bandewar <maheshb@google.com>, Netdev <netdev@vger.kernel.org>, 
 Linux <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Richard Cochran
 <richardcochran@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Sagi Maimon
 <maimon.sagi@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>, 
	Mahesh Bandewar <mahesh@bandewar.net>
Date: Fri, 26 Apr 2024 11:21:10 +0200
In-Reply-To: <20240422220707.162146-1-maheshb@google.com>
References: <20240422220707.162146-1-maheshb@google.com>
Autocrypt: addr=pabeni@redhat.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-04-22 at 15:07 -0700, Mahesh Bandewar wrote:
> diff --git a/include/uapi/linux/ptp_clock.h b/include/uapi/linux/ptp_cloc=
k.h
> index 053b40d642de..02684d7e00e6 100644
> --- a/include/uapi/linux/ptp_clock.h
> +++ b/include/uapi/linux/ptp_clock.h
> @@ -155,13 +155,27 @@ struct ptp_sys_offset {
>  	struct ptp_clock_time ts[2 * PTP_MAX_SAMPLES + 1];
>  };
> =20
> +/*
> + * ptp_sys_offset_extended - data structure for IOCTL operation
> + *			     PTP_SYS_OFFSET_EXTENDED
> + *
> + * @n_samples:	Desired number of measurements.
> + * @clockid:	clockid of a clock-base used for pre/post timestamps.
> + * @rsv:	Reserved for future use.
> + * @ts:		Array of samples in the form [pre-TS, PHC, post-TS]. The
> + *		kernel provides @n_samples.
> + *
> + * History:
> + * v1: Initial implementation.
> + *
> + * v2: Use the first word of the reserved-field for @clockid. That's
> + *     backword compatible since v1 expects @rsv[3] to be 0 while the

Minor nit ^^^ 'backward'

> + *     clockid for CLOCK_REALTIME is '0'.
> + */
>  struct ptp_sys_offset_extended {
> -	unsigned int n_samples; /* Desired number of measurements. */
> -	unsigned int rsv[3];    /* Reserved for future use. */
> -	/*
> -	 * Array of [system, phc, system] time stamps. The kernel will provide
> -	 * 3*n_samples time stamps.
> -	 */
> +	unsigned int n_samples;
> +	__kernel_clockid_t clockid;
> +	unsigned int rsv[2];

AFAICS, here you are using the 'old' rsv[0] as 'clockid'

Please either always use rsv[0] instead of rsv[2] or re-order the
fields.

Thanks,

Paolo


