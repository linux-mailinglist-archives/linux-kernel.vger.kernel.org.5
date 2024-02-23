Return-Path: <linux-kernel+bounces-77808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC255860A71
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 06:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4857288C7B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3537E125A2;
	Fri, 23 Feb 2024 05:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PXs4YSvy"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5F811C84
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 05:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708667368; cv=none; b=DJRVMjbf2PN5uExDsP0q4w/tgPXd93H3FrpxHkK0n9u/csTCO/oE7hHEA5e8pOZdHPTr7Ar85kXQSI1G3mziKNw577UyuksIucvf36MBHOIxAbmptqHb3WLTaBfWToJdC31BxwR6bFf2IhCXkIX4tdVg5M1qu1zKY/RnAv7shdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708667368; c=relaxed/simple;
	bh=RPma9Pbpu6m641KMR7W1nUOf0sw2d0xoTE9GBEiQ92A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ix8Q2I6pVQ3VR2qN9P7YpAzRaklrlvPKxbLlia0Ir3dCDKoNGuPtVYVZh82t0aHEsGCuhBMHqnJO/+5KyazwNt9e2/ypM7HBYxSrW71GElMYL6MX5W3IkEwQIZ2i3VUsF97Lcgk05i0WE0cFh1pAVNadEUHJnjkGZD69BBMPuA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PXs4YSvy; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dc0d11d1b7so5379285ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 21:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708667366; x=1709272166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MBESAnNJeprTqvz59zbcwjxkx2D2G7ynywNMleDeZzk=;
        b=PXs4YSvy5a7xXDSu+YGGg+pOvNrPRK5dWrJZlAzvyaAjkgeP/wRkvXxHFWkmLqsZA3
         bF8aaEjgmooBKr9OPy7qcEH0wv8feROo1979WBS0J5sPJ0MIZ4TD8r6noMymwy2wJlYo
         QgRgPnJ0EQREQjNoVbQYizdB+xO8nus3NV1uc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708667366; x=1709272166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBESAnNJeprTqvz59zbcwjxkx2D2G7ynywNMleDeZzk=;
        b=JmQu5+WQCHtc8BXfoSf2l8q6+dGyCzczZEzNMiYa1MGlQX6jQCeehx8+4jxMHkyu4P
         Gy1JtMM1B8wo70BGYy3MIho+GDIYB08EcacBxI6f/4XSSz4ef/M4yK4C09NgqrkVws6n
         hIHvIm+XFA/Xzvsn+j/+BlF7jPWZdmCnl0T1msMsLsfqGqvyJHlj/jB+YAws/svtPxZ1
         dvCxbD52cLEkOd1/AxKF+UH4NaOnzIl+moiD9dO4P4BXHmsz39BfK06eFIWTB6559a/b
         Qis0ZcV/KxMmhYja9VW9NjwAVQRkBiDayDWiWtDEjzp3Wonp0UU+H3K00Yn2n8awCpcK
         8/6g==
X-Forwarded-Encrypted: i=1; AJvYcCVOCNInyjmEkFQmabiI5pTtlhgsjeGF7z9JEEW+jfaS/KFuYUUX61o/Qw9KQ/T05v8AUH2/4wOW7Zm7+YjKxPhqRag9SEQGeJQLDiVk
X-Gm-Message-State: AOJu0Yxjd0TK1iYjhcRzaI1BAYZGkOXWa56KYAWv4ZJi6OAklS9CDbnR
	vZkJxFEXnPwjq3VgMEX1cB+jS/BzNUCrZedUIvzaakwlOBSdv/VB+I7Uimf4Og==
X-Google-Smtp-Source: AGHT+IEN4m/ZdcDaPm89m3KXbtl5Q55DPJWRWcBtIrXE9D4k2meckqiLdB7h4zJojCPr0CzigmSeBw==
X-Received: by 2002:a17:903:240c:b0:1dc:600b:12fc with SMTP id e12-20020a170903240c00b001dc600b12fcmr1274798plo.23.1708667366343;
        Thu, 22 Feb 2024 21:49:26 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:b194:4f71:568a:eeb0])
        by smtp.gmail.com with ESMTPSA id u12-20020a170903308c00b001da11733477sm10890708plc.75.2024.02.22.21.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 21:49:25 -0800 (PST)
Date: Fri, 23 Feb 2024 14:49:21 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: hannes@cmpxchg.org, Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, nphamcs@gmail.com,
	yosryahmed@google.com, linux-mm@kvack.org,
	Chengming Zhou <zhouchengming@bytedance.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 1/3] mm/zsmalloc: fix migrate_write_lock() when
 !CONFIG_COMPACTION
Message-ID: <20240223054921.GT11472@google.com>
References: <20240219-b4-szmalloc-migrate-v1-0-fc21039bed7b@linux.dev>
 <20240219-b4-szmalloc-migrate-v1-1-fc21039bed7b@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240219-b4-szmalloc-migrate-v1-1-fc21039bed7b@linux.dev>

On (24/02/20 11:36), Chengming Zhou wrote:
> From: Chengming Zhou <zhouchengming@bytedance.com>
> 
> migrate_write_lock() is a empty function when !CONFIG_COMPACTION, in
> which case zs_compact() can be triggered from shrinker reclaim context.
> (Maybe it's better to rename it to zs_shrink()?)
> 
> And zspage map object users rely on this migrate_read_lock() so object
> won't be migrated elsewhere.
> 
> Fix it by always implementing the migrate_write_lock() related functions.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

