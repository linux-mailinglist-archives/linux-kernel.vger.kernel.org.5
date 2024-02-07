Return-Path: <linux-kernel+bounces-55937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA8284C3A4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDE2E28DC4F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726E51CF8D;
	Wed,  7 Feb 2024 04:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="allp2fdJ"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390A91CF8C
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 04:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707280603; cv=none; b=mbiTLOIVZChAt58ChqsxmgwobiCpYfcZeYyAHupv4ERCFUFMnc7DyegsNnXXdky7iT6pg8SSU3VkJOTH0nadaGf8MZmVHREgMHP2Ug2JdSgRKUgl5vSJaigepTamRqvpFy6InMXwYT9FXGK2Hhe0WIHRmc+NKEcZtYVIJWHdIZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707280603; c=relaxed/simple;
	bh=RtSqp1JYFTovf2zthsrQ+F52HyZRz9QN+jvAQn9sieM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXIQEJhT2YimumUrYFnkbbk3VSOjyQC7+MV2+WFr4a+dM3hIlFkvloBjbAPuqfUr3RsZiRvAGC/AV6ZdRcHnvjwosLBP3g4pgokSoi6obXQGaPzFeU6TCy13X21mcLPtVgKj79ueIKpbIMhwakyyHB6yKAOCeLjrNEcCmq9TvOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=allp2fdJ; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-21432e87455so161949fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 20:36:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707280601; x=1707885401; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xXmL2187gHpmL0np47Ze2nLt0jvODGEfenOxk5qwPvE=;
        b=allp2fdJrCH1so/XYtPVyopJmQCgAhOWERuy44idtWPR+ZmynH64rCiT+YEaFsfUWr
         RukTGHIw468X0MM2rV+LzqQZX08LS8uk/mffxx07kGWQnUZYbtG5ogbqAMkyhZ8fqARN
         3KGbx3xkbN+URHua85nN/KVRCg363DLh500+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707280601; x=1707885401;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXmL2187gHpmL0np47Ze2nLt0jvODGEfenOxk5qwPvE=;
        b=siBJaG4FRAH3ez2+FCEXBWNPwZEnZP9gDHC0wZ7I9pUHknNqvGVh9upCgE8SAQqes8
         jhlr8GKvgy1l1twjzhYIsPGhjfzcVpL6c5uonzxw/AnzaChNxVPIVuQt5D5h9KoePbZn
         qMZzILbELYYkcAjlFHeEfkGsgYbuOLP1sGvHcHkAqYsdpj30DdNnQeE297Thas3jCwuP
         k9UR7A49Vmt0Impy2umQNY7zr1hnGV7ndBT5nyj5Bg1hvlwCEETlWjLN9GIFikUvkWYc
         hLOJKTXIzDOtxwKiuQTvKr6vUXdw6558eEUX05PNa1ypOcQg82oefmNS3fLH/TvZbvwL
         7qhQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3+rKk37WsgLbkQbnijMtGQu4pUpW7r4AboFmaM3nn+ZxSZ5lnHMZGg8DkddTsXYbbJUGKOIvQ+O2P65hjtycGYzBHocVrjc7AGbSL
X-Gm-Message-State: AOJu0YxOPNuux7seynqZ+ATDVX2A7MZZWbvakQ5DQO11SOzTPNHKCSmB
	ditEqbxHHtWaekYYXASGHSMlynC5CMzeRtQR5PtTjr1VX8f26cNcxJpvsajgtg==
X-Google-Smtp-Source: AGHT+IFO44dKQJIbmf1HaMA+xo1RI3yTOS1ects1dva6gr08BhW/p1aXM5wyZ+X6kTGvy+2n7wGkoQ==
X-Received: by 2002:a05:6870:390e:b0:219:92e5:8b4 with SMTP id b14-20020a056870390e00b0021992e508b4mr5403115oap.5.1707280601380;
        Tue, 06 Feb 2024 20:36:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWPDLtqg4P2TGcdbEEvcr7bpsaydM1bkhMm0f34M1al3KjlWR9Rv6wHLukrXyyJiiB5rsjok7PGeZOdUw54EV9O1QsM/Roo2Pw6pQRxSfColdcfKWorGDXJLP0VkbGPlPsOBIM/DdjvJ0i2kdch5s/XIv3/hiyVGpymPGih6CwH0WFboBO0mkOuo5kX5wtDt0mt0/KjQO7piZY7yfVcWOxsgMS16F5lyrwi713ajRc1Z6Upof8fTsOU3XsQJuvSq9TF2ROBGkO34MqLhIRVZoDrk9WzeneQ47f07w==
Received: from google.com ([2401:fa00:8f:203:679b:7168:b5c0:a415])
        by smtp.gmail.com with ESMTPSA id s133-20020a63778b000000b005d3bae243bbsm371606pgc.4.2024.02.06.20.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 20:36:40 -0800 (PST)
Date: Wed, 7 Feb 2024 13:36:36 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Jens Axboe <axboe@kernel.dk>, Barry Song <21cnbao@gmail.com>,
	Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	zhengtangquan@oppo.com, Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH v2] zram: easy the allocation of zcomp_strm's buffers
 through vmalloc
Message-ID: <20240207043636.GC489524@google.com>
References: <20240206202511.4799-1-21cnbao@gmail.com>
 <20240207014442.GI69174@google.com>
 <41226c84-e780-4408-b7d2-bd105f4834f5@kernel.dk>
 <20240207031447.GA489524@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207031447.GA489524@google.com>

On (24/02/07 12:14), Sergey Senozhatsky wrote:
> ---
> 
> zram: do not allocate physically contiguous strm buffers
> 
> Currently zram allocates 2 physically contigous pages per-CPU's
> compression stream (we may have up to 3 streams per-CPU). Since

Correction:
								^ up to 4

> those buffers are per-CPU we allocate them from CPU hotplug path,
> which may have higher risks of failed allocations on devices with
> fragmented memory.
> 
> Switch to virtually contiguos allocations - crypto comp does not
> seem impose requirements on compression working buffers to be
> physically contiguous.

