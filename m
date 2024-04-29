Return-Path: <linux-kernel+bounces-162967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C48B8B62D4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32FF71F212EA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A6013B5AB;
	Mon, 29 Apr 2024 19:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OUtm69vX"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005A112AAC9
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 19:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714420147; cv=none; b=XT/hZlPBatalh5oKLdgAWoeRzu5fyDNs+Lp+ZIQNDnWU+A8slPkVBCrEme0ARKfwGlni5FR6YzLhmxT5vS41yPVPqhgoBTLudst6TpyPKm3yW3SVLlUeQWoVZVEPt7KEVKYNJYib7moLxF4usiDsdNQjF8rU23snQl/aWtjfbrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714420147; c=relaxed/simple;
	bh=G5w+y4k/0B/MIhP3OIdnfnaBZzVFiznSU5o3Q+eJJrM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=exeMrZvkIzXy9H35RQ5kTMXGwe7lSsKDjcgMTpAKmqeCaCtgphAeUhyzWE2rAQhYEofdRsJ7EE98dOLXwuIRmu2nQK+68Mw/hmha44hQys0N+asBYdKa4BkYzls662CYiZrGMDTOxNkcBfZOfkvezB5FLEcqNYzTXRB+ZPRMZmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=OUtm69vX; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e51398cc4eso44089855ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714420145; x=1715024945; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jxlmAhxfEfZT8bTyeNiSvqaH1zNJ82/SnYCLRCDDuj4=;
        b=OUtm69vXtxg/bF9L249dalzDtwsmmtcLzd+zQkMs/QcakiD8ydFCtA7GRRQSu1QrRL
         Qv9yHiwgXQSn/eGX5eMaeDLHMNaj6ZokcYfG2duXxtIAMQPDhWiuf02yjt/l/kmqWShp
         r0Xf177p1IPZc7ebLfcf7y2P/gQdC3aTCVRNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714420145; x=1715024945;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jxlmAhxfEfZT8bTyeNiSvqaH1zNJ82/SnYCLRCDDuj4=;
        b=KBdC58P2I6z9YTpMUCdX9DzMhQZBlDxg/9rwbvETXXs7cPd/x8icKry0IjDStJwB9U
         VsUAnYZbbCkbK7I/hF+MPvvANkHcK+PXvFffpLcGo8fpNoILSGR9z6wfqbjXkVla+o7z
         NfdgQlL6W+3NX9L0185yfeR+uo0acd1py4H1/VcmFWTJMl56q74fLlfAIqrjmCVow90u
         O4SiNdShWz9IX5wjdYcJ+uXt14WTazUWAp/cVIUr4jG2R6vUZUY4omlQOxTFS9pIMlAY
         qj6kjSoSqmelyNHMcyBJ1QWKy4vgiAzp/arhPlYWAZO9VH0r6f49dt8oxMxZX4AIEkch
         Fx4w==
X-Forwarded-Encrypted: i=1; AJvYcCUNMRGRGzCQd5a6uphu9gVGFEAxm/2QkhguBriPOEVV5/WRdSpVBGBMf4NTSKpVb4ByLkG/PlwVQP6hkmTahAaKz5VeXWVgkQGBW5sc
X-Gm-Message-State: AOJu0YyFvDW42SMrINLAH1OMkx9guLNsLQnjdcrMUXZLO04wtez6wnx5
	SS0n2yqj1dgbA5DR7I75TWY9lWIhGsfrOi8m5i8mNjATvKFyiYqZsoidp/AN8w==
X-Google-Smtp-Source: AGHT+IECRu8g8bwToaxRHQbb2UWAgCPjLtsrdSUmHlot5oVJviA+DDbB+NRaMqmFHCB9C3nFU7igXg==
X-Received: by 2002:a17:902:ce87:b0:1eb:7285:d6fe with SMTP id f7-20020a170902ce8700b001eb7285d6femr8741775plg.23.1714420145374;
        Mon, 29 Apr 2024 12:49:05 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s1-20020a170902ea0100b001e3d2314f3csm20739290plg.141.2024.04.29.12.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:49:04 -0700 (PDT)
Date: Mon, 29 Apr 2024 12:49:04 -0700
From: Kees Cook <keescook@chromium.org>
To: Allen Pais <apais@linux.microsoft.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
	jack@suse.cz, ebiederm@xmission.com, mcgrof@kernel.org,
	j.granados@samsung.com
Subject: Re: [RFC PATCH] fs/coredump: Enable dynamic configuration of max
 file note size
Message-ID: <202404291245.18281A6D@keescook>
References: <20240429172128.4246-1-apais@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429172128.4246-1-apais@linux.microsoft.com>

On Mon, Apr 29, 2024 at 05:21:28PM +0000, Allen Pais wrote:
> Introduce the capability to dynamically configure the maximum file
> note size for ELF core dumps via sysctl. This enhancement removes
> the previous static limit of 4MB, allowing system administrators to
> adjust the size based on system-specific requirements or constraints.

Under what conditions is this actually needed?

> [...]
> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
> index 81cc974913bb..80cdc37f2fa2 100644
> --- a/kernel/sysctl.c
> +++ b/kernel/sysctl.c
> @@ -63,6 +63,7 @@
>  #include <linux/mount.h>
>  #include <linux/userfaultfd_k.h>
>  #include <linux/pid.h>
> +#include <linux/coredump.h>
>  
>  #include "../lib/kstrtox.h"
>  
> @@ -1623,6 +1624,13 @@ static struct ctl_table kern_table[] = {
>  		.mode		= 0644,
>  		.proc_handler	= proc_dointvec,
>  	},
> +	{
> +		.procname       = "max_file_note_size",
> +		.data           = &max_file_note_size,
> +		.maxlen         = sizeof(unsigned int),
> +		.mode           = 0644,
> +		.proc_handler   = proc_dointvec,
> +	},

Please don't add new sysctls to kernel/sysctl.c. Put this in fs/coredump.c
instead, and name it "core_file_note_size_max". (A "max" suffix is more
common than prefixes, and I'd like it clarified that it relates to the
coredumper with the "core" prefix that match the other coredump sysctls.

-Kees

-- 
Kees Cook

