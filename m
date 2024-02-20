Return-Path: <linux-kernel+bounces-72330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EA685B20B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A08371C20D37
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E902482DF;
	Tue, 20 Feb 2024 05:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M8G8JSU2"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281941E484
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 05:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708405360; cv=none; b=It/SSlJfqH+Yvd9vLJXeXJ6NBn92zLyHvY743iG3gqItT8E7GwQ8Fclrl8eBjAkucp3NZFbkIyLVtA7S3VDTROYvAEyfWh27EwTJ+J/AjWYaM+ifzuSjkPg422ui/e4VWFufAJtRkYTirlnv15LSq/Mc7xf82uEzis4ECLHKCgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708405360; c=relaxed/simple;
	bh=/RpG9Pc3+Rbtm+vUAXv8r65w7qlRqb2zJIhURWMEb78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b7q6U6lEKHYSfmozqEgiF0lC/WOads4Q5brRSoyiyn3D3GopTXnyV4kPdBAaBUpT7VkPlLzXivS8g9fnoQsazNbJzMhxtJmb6vt1kgs584btnsfpYcNqDRXzxRVfe5khpm9HVIotQW1p04Ou+O7lWEzH5uFdnc4ttLcrGWHxoyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M8G8JSU2; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso3391023a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 21:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708405358; x=1709010158; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i7hcAUjulo0+/qim2LMcT08gaOMiztNgOLDf1ljB3M8=;
        b=M8G8JSU2gTKVNd37BDIgd/QFFFW1COs+c4yFefp61GHtxwIlNw/B43/vPwsNcJxNxu
         Vmk0z5UvIBeQm5/jnJLfl796J8cyOWze+foTPjyfrlhDnjhkg/wimep+cyPdaQTyEQRD
         cCfcYTtQzX8xxZjoPJf53p0k0eMhjaIcSRowk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708405358; x=1709010158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i7hcAUjulo0+/qim2LMcT08gaOMiztNgOLDf1ljB3M8=;
        b=Ai/iB+goDTNjE8vYVbNsso5uQL6XOUaRbc2VpK6qcmCJ/ogVeK8uvoa7C0T+OgqBDd
         pzTxJZjbBPCEUoS9ndXtdZk1iXTZLTJjuKpuWeNtk8BBBBlqhzDmuyzacTjgU6UP4pcK
         ImFuCP9bqhcmD6SUkvcX89qkohazokH7llnT/zjLU0qCSBvYzfhf/8l//UsUkKnpwyhs
         5+y5dvqbBP6pgwYccLryudY9fwLIdClzO6MzLj4n0i8yM2fyIvxl/ElOUfhz7WoFHpbn
         86Nysosp8z+ys/4bKY0RvzyU2gTlOceb5o2IX0qWs6VKVENLf+nkHywUtRaUFgSMBVRU
         OjRw==
X-Forwarded-Encrypted: i=1; AJvYcCUE3w3syZycunjuKNZCtGGpUXd99DtR4KIMv7GgSlBj6PcJKx8SqwQanabUj+Y1YHIaoemSMJtKUzcJQ4QZ+OBuZbY4TMHZojpVh9rs
X-Gm-Message-State: AOJu0YzTxHG2N10qMH8T8TEK8E3w3jtn9Kefzaby0y53YDjo4bwJ2IJn
	/NWgSUqr+2Ur86Qu/VyN1aIOtNv9I2sQUxhZPLJ99x4XoizRvbaFKKxcvRWdhg==
X-Google-Smtp-Source: AGHT+IFnw8f+Iv8s0JtZeRo/Aq/frJZM4gToXTA5lqXQHkUoidmeMbJ82/S1IYyUPI8tCKvvGWgBnA==
X-Received: by 2002:a17:90a:4381:b0:298:c136:2ffc with SMTP id r1-20020a17090a438100b00298c1362ffcmr10210738pjg.45.1708405358502;
        Mon, 19 Feb 2024 21:02:38 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:8998:e92c:64ca:f09f])
        by smtp.gmail.com with ESMTPSA id x18-20020a17090aca1200b0029933f5b45dsm6277027pjt.13.2024.02.19.21.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 21:02:38 -0800 (PST)
Date: Tue, 20 Feb 2024 14:02:34 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Chengming Zhou <zhouchengming@bytedance.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, nphamcs@gmail.com,
	yosryahmed@google.com, Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, hannes@cmpxchg.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm/zsmalloc: remove migrate_write_lock_nested()
Message-ID: <20240220050234.GF11472@google.com>
References: <20240219-b4-szmalloc-migrate-v1-0-34cd49c6545b@bytedance.com>
 <20240219-b4-szmalloc-migrate-v1-2-34cd49c6545b@bytedance.com>
 <20240220044825.GD11472@google.com>
 <4f3c6c96-3bea-4369-a2de-e3c559505bba@bytedance.com>
 <20240220045340.GE11472@google.com>
 <a6c22e30-cf10-4122-91bc-ceb9fb57a5d6@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6c22e30-cf10-4122-91bc-ceb9fb57a5d6@bytedance.com>

On (24/02/20 12:59), Chengming Zhou wrote:
> On 2024/2/20 12:53, Sergey Senozhatsky wrote:
> > On (24/02/20 12:51), Chengming Zhou wrote:
> >> On 2024/2/20 12:48, Sergey Senozhatsky wrote:
> >>> On (24/02/19 13:33), Chengming Zhou wrote:
> >>> [..]
> > 
> > Not really. We have, for example, the following patterns:
> > 
> > 	get_zspage_mapping()
> > 	spin_lock(&pool->lock)
> 
> Right, this pattern is not safe actually, since we can't get stable fullness
> value of zspage outside pool->lock.
> 
> But this pattern usage is only used in free_zspage path, so should be ok.
> Actually we don't use the fullness value returned from get_zspage_mapping()
> in the free_zspage() path, only use the class value to get the class.
> 
> Anyway, this pattern is confusing, I think we should clean up that?

Right, looks so.

