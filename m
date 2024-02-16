Return-Path: <linux-kernel+bounces-67902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7786B8572B9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035151F22E28
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FFFBA38;
	Fri, 16 Feb 2024 00:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XfrZ+gqM"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B8D9454
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 00:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708044208; cv=none; b=Vvy6UdQdKCqVhF4coSEBV/xg6bYh/b+N+Qn0JQo4l3dibDIMYk7RI7E/6kbVuwf3rd2BEH24ZfzyYRnRLCJ68YRqbUFWRZDzTeYmiK78cGckvHYH5hIr9pjoApToMQpqa4k+lGtYWr694bnaDfk01XhgDR5V50qRv7/msW0dA+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708044208; c=relaxed/simple;
	bh=wpZ3+q2A27+VBpLN60qONBQkdaGjFE1Z/O7en5rKHOs=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BP9Q+LMJWzRU6R5JlHjgUSOmiJwAiYi53jprq13rBcK/vdjglRsRQamcU8dt9s+xLQfR5duWHhK8sKlBxwQ4ViYUTWdoUb65cskxsMEnKo86lECZ8U034+Rb3pVZTzdHUCUPOOA0aUxYE75nNEXZr95NteKRO/JYlc+8wB/kbUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=XfrZ+gqM; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-7bf2c826a5aso67472039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 16:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1708044206; x=1708649006; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=906AztgBDa+u1AARHWRp02F7s/rxI61AgVNDIWi+eXM=;
        b=XfrZ+gqMx7ImLq5Wp4a6sMC0iGU8CPVLnCzcxuNN5VVNPW9zZdTF49cANdFuDNSWG0
         NxVDe4qrQSP03LhrnDrUEXKJXYPI8Zu9exuqT1O9I990s8+C5OGt8pMVJQZUqKQ6Q0+N
         FUCcn1t68AijJRO6gdqU+Jq7Gr3wCjJ9a4ximnsXzIjbsxveSlQXdlbl2ULm+BaxMMcA
         hglnXs1ZF0LXg1xernuevmRfDMyG6Rqrc6ZqEliYMg+lusSlDOHaGBn7cuBKD8GymIoT
         PWRNn5On2RR0izyn824kkldgbZuW1BeGhO6iSXS/Fzjn6vKwIma+vwsvN2XwEzPu80/+
         Z46A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708044206; x=1708649006;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=906AztgBDa+u1AARHWRp02F7s/rxI61AgVNDIWi+eXM=;
        b=Hxm7ntLjmwIAiItOZTB9FtzQEC5KrLpBnrtdqZ3Fe/UASrKnzxWR+vTsXhw/DkkZSk
         XR4fhKzDZGF/bNMybiz5qGKVlT5Xf57QVgYMVYEHhub8V5V+zQJQmBbOlxjV2uB0+KNY
         LX/YGPrTnD5jTGMVX088KIx426tfu5QSm3d/sOu/2qkOVG/zRxkzLPKVzXrrah+TAkxW
         Zo2TN2P110EGC2t455uGWJZKCfYAm9w1Ue9U0PEaZJYtdjSszYRSyIliC1dI2g6Z8igg
         QV6J6bDHpnG1OKc21bgrtQIB7k4AxUUYST6qZ/MpbmDwNR9881219qOGWlFjU3CzVeiJ
         FawA==
X-Forwarded-Encrypted: i=1; AJvYcCXc4vR/j5GEYzCZczW8VA+UiSyB9pg8F7hbaLVYZYwCUbUh2xNbhdc19O9EAw1RJ/8RBzaVZwj1gCxGx8B9BFBxYkrCANyttv6xJ4ax
X-Gm-Message-State: AOJu0Yz+Ovl7VzWmcsCnLGOQlmBo2wr0b/Oi038MJOVfT6h86tis1u0x
	9w1FMejKhwyhMmMCW0/n21YHC99nXNr9jSGfo1a5eMJWCwmbGSpln+384AFNS/c=
X-Google-Smtp-Source: AGHT+IERnpQSZ7MTb6KfYlV0kBQ6EVjYQL9pSnng2dDwidYnOh6AyMUrOQceP7bFABcYCPnVZeKZSw==
X-Received: by 2002:a5d:841a:0:b0:7c4:5910:8ab9 with SMTP id i26-20020a5d841a000000b007c459108ab9mr4153852ion.5.1708044206274;
        Thu, 15 Feb 2024 16:43:26 -0800 (PST)
Received: from localhost (c-98-32-39-159.hsd1.nm.comcast.net. [98.32.39.159])
        by smtp.gmail.com with ESMTPSA id l24-20020a02a898000000b004713ba1b284sm609266jam.44.2024.02.15.16.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 16:43:25 -0800 (PST)
Date: Thu, 15 Feb 2024 16:43:24 -0800 (PST)
From: Paul Walmsley <paul.walmsley@sifive.com>
To: Samuel Holland <samuel.holland@sifive.com>
cc: Conor Dooley <conor@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
    Greentime Hu <greentime.hu@sifive.com>, linux-riscv@lists.infradead.org, 
    Green Wan <green.wan@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Update SiFive driver maintainers
In-Reply-To: <20240215234941.1663791-1-samuel.holland@sifive.com>
Message-ID: <114d9cf3-0ebd-56c7-f3e4-57ebc235df45@sifive.com>
References: <20240215234941.1663791-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 15 Feb 2024, Samuel Holland wrote:

> Add myself as a maintainer for the various SiFive drivers, since I have
> been performing cleanup activity on these drivers and reviewing patches
> to them for a while now. Remove Palmer as a maintainer, as he is focused
> on overall RISC-V architecture support.
> 
> Collapse some duplicate entries into the main SiFive drivers entry:
>  - Conor is already maintainer of standalone cache drivers as a whole,
>    and these files are also covered by the "sifive" file name regex.
>  - Paul's git tree has not been updated since 2018, and all file names
>    matching the "fu540" pattern also match the "sifive" pattern.
>  - Green has not been active on the LKML for a couple of years.
> 
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

Acked-by: Paul Walmsley <paul.walmsley@sifive.com>

- Paul


