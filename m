Return-Path: <linux-kernel+bounces-149000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE118A8A4D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 19:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 733BE1F214BA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34077172BAC;
	Wed, 17 Apr 2024 17:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NsJKJOXw"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AB3172777
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 17:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713375352; cv=none; b=pLByVhOuP6OV07nHXl4SQHcmVJb71eyo6jvgtlbnjYe+k6CtpPVvGO0GrRZws3Rg+F28n4AdhXDmNzH7hGBXJ0X0nxJ5Qnj577nhasazSJzqfweb+9biRZxPzKzCDzOC8VCTDB6jtLCYnrohyChJ9LhnB7rhAp1bdGhzxCBl2Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713375352; c=relaxed/simple;
	bh=EUEq5eCikvb1PA+1pE5jT5oLwrFNWhGgWfY9hb71rBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hiZb5p0wTP8RsigVyezS03qNjfGeGJ2q8VrcVudaATC3tO+8a0FK5apl+oTFUJjzv2QemYV21b6sCaIANpf9176+a9HgAhgl50ZrdOpuzBGGZnOeTLlU7AySjWTYUFCMI9B2EeMiQuxQVED2NsXme1M7Nmsq0QtwdJJBn/Xw7mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NsJKJOXw; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6ed3cafd766so48089b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 10:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713375349; x=1713980149; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pBJiH4urg4DBG6eZbcNPwgnZOdXfIaMFo9RuiRFHB0E=;
        b=NsJKJOXwccHJwQ85rjFYE5qWw9ab4sPiSFGsQinb/nv07xhBj94Ty+ttoygJ0Ayekz
         IIgZxNprKvMkfksYKhW89s9hAPPiknzK/5deAJu7lU0fzVuUuzZEBlx/o2LjL3ZEwbWS
         JOzOo19mCKfQko9dmQUoQpDC+YeeC3P/p0bH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713375349; x=1713980149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBJiH4urg4DBG6eZbcNPwgnZOdXfIaMFo9RuiRFHB0E=;
        b=vIfAD6fyPTeS1Y1ykAKrAqVXlHjDv01Uw/JdXVQdyCBr7ACLWVQ71hNkbPyssXYuFf
         nraTOtDN5uwLxnAoPLvFfNlU0em+81iHW5hiITsXceg6eimmHUbCVnjXW61RLsbWQ0pt
         MEplG9oZd7NWOrVm/jIr2anP0dwLLpWJIk1wprO/BF4sN5H9G4x9AAM8u80FqBb1V+jQ
         GwUw+SESKdlI1lC0lBp/aeTh86m7spQv/URblvMVHm8F8Xd+/1zA+xrUZ8ZWLgAF+gb4
         4GJLxV6RdN0PApDE6EgG3VoInhmvgyIY81k3i7Y1M/oqtgwMjtXTbrZV5u/uSeYeAhHF
         GL/g==
X-Forwarded-Encrypted: i=1; AJvYcCW27UufYszATATl+3JwJmVtZTLvInhrP7B0RaqyvuverGR+3EtFQZdol3gt1eWJ8TriAb8Evf3aVuamZB9Xt1AL5yl0V+sLS7tB2z33
X-Gm-Message-State: AOJu0Yw1FhORLRn+StSy/rq9rnybSWA9mgvs/X74aw2u+wKbUsdkB3sp
	epWGic8Z6Ytw1GRBboi3Q4fHadDXZuvjvB6OIMgwRgER4uC1iiINk12hsSriUA==
X-Google-Smtp-Source: AGHT+IGRhXAn8BnFec3OXIieh95t6IYTWzPHJKZQXAIRwjXtFeTGFo/I0JMHxUAOWhgdyp8JVnjm6A==
X-Received: by 2002:a05:6a00:22c4:b0:6ec:ec8f:d588 with SMTP id f4-20020a056a0022c400b006ecec8fd588mr281477pfj.16.1713375349095;
        Wed, 17 Apr 2024 10:35:49 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id gx15-20020a056a001e0f00b006e71aec34a8sm10927754pfb.167.2024.04.17.10.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 10:35:48 -0700 (PDT)
Date: Wed, 17 Apr 2024 10:35:47 -0700
From: Kees Cook <keescook@chromium.org>
To: "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Charles Bertsch <cbertsch@cox.net>,
	Justin Stitt <justinstitt@google.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Andy Shevchenko <andy@kernel.org>,
	Sathya Prakash <sathya.prakash@broadcom.com>,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
	Suganath Prabu Subramani <suganath-prabu.subramani@broadcom.com>,
	"James E.J. Bottomley" <jejb@linux.ibm.com>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>,
	Nilesh Javali <njavali@marvell.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Himanshu Madhani <himanshu.madhani@oracle.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
	mpi3mr-linuxdrv.pdl@broadcom.com,
	GR-QLogic-Storage-Upstream@marvell.com
Subject: Re: [PATCH 0/5] scsi: Avoid possible run-time warning with long
 manufacturer strings
Message-ID: <202404171035.BDFF28D@keescook>
References: <20240410021833.work.750-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410021833.work.750-kees@kernel.org>

On Tue, Apr 09, 2024 at 07:31:49PM -0700, Kees Cook wrote:
> Hi,
> 
> Another code pattern using the gloriously ambiguous strncpy() function was
> turning maybe not-NUL-terminated character arrays into NUL-terminated
> strings. In these cases, when strncpy() is replaced with strscpy()
> it creates a situation where if the non-terminated string takes up the
> entire character array (i.e. it is not terminated) run-time warnings
> from CONFIG_FORTIFY_SOURCE will trip, since strscpy() was expecting to
> find a NUL-terminated source but checking for the NUL would walk off
> the end of the source buffer.
> 
> In doing an instrumented build of the kernel to find these cases, it
> seems it was almost entirely a code pattern used in the SCSI subsystem,
> so the creation of the new helper, memtostr(), can land via the SCSI
> tree. And, as it turns out, inappropriate conversions have been happening
> for several years now, some of which even moved through strlcpy() first
> (and were never noticed either).
> 
> This series fixes all 4 of the instances I could find in the SCSI
> subsystem.

Friendly ping. Can the SCSI tree pick this up, or should I take it
through the hardening tree?

Thanks!

-Kees

> 
> Thanks,
> 
> -Kees
> 
> Kees Cook (5):
>   string.h: Introduce memtostr() and memtostr_pad()
>   scsi: mptfusion: Avoid possible run-time warning with long
>     manufacturer strings
>   scsi: mpt3sas: Avoid possible run-time warning with long manufacturer
>     strings
>   scsi: mpi3mr: Avoid possible run-time warning with long manufacturer
>     strings
>   scsi: qla2xxx: Avoid possible run-time warning with long model_num
> 
>  drivers/message/fusion/mptsas.c          | 14 +++----
>  drivers/scsi/mpi3mr/mpi3mr_transport.c   | 14 +++----
>  drivers/scsi/mpt3sas/mpt3sas_base.c      |  2 +-
>  drivers/scsi/mpt3sas/mpt3sas_transport.c | 14 +++----
>  drivers/scsi/qla2xxx/qla_mr.c            |  6 +--
>  include/linux/string.h                   | 49 ++++++++++++++++++++++++
>  lib/strscpy_kunit.c                      | 26 +++++++++++++
>  7 files changed, 93 insertions(+), 32 deletions(-)
> 
> -- 
> 2.34.1
> 

-- 
Kees Cook

