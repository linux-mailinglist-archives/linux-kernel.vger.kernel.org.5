Return-Path: <linux-kernel+bounces-100947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAEA879FF5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B4B51F2233E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316514AEC7;
	Tue, 12 Mar 2024 23:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Usr2HyC0"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD994643B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 23:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710287812; cv=none; b=JXVCAA20hxTyGTU6gRcd1kj3Tt+YlTUDOGl/zl1dPEk8BK4URaYFgjUhY9kST5B7jECpFxIy1IyY3SvLjamXTbxU43FHjl7qTEF8EeklbkqcOMFuUM7tvpxnGU1icG7G0zi6xDlh7ktrnCNn0d3RQ9xSt/8o1MVDC/Uu5K4txRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710287812; c=relaxed/simple;
	bh=093KVda26WqmqdJht4WhK6nR+8yU7yPh9WYzE3fzY7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=unklYNXMy0WXltwlZnkANCtPpNrCMgcec4spgefR46UQFFJeqFPOcbBD9W68fhVu6EsTJxxQ0tqZBlFsQcgr9vIdv7YCMJbSiVRHwz/hGIySJsdadiGYS6C6Laz/mnbd0PIGtBp5E1S/czGp2NtuKML79r6QM6PD5uhaHFYDsXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=Usr2HyC0; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-42a029c8e62so38591821cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 16:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1710287810; x=1710892610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zl9PC7FMZlnjsGfkV0mu1AuaGsWjNCYzUqWD8hwrZds=;
        b=Usr2HyC0zap0I51WQ4AOjvcHDJ52/pGaqx0+9TN/K0M0JKXWbe2QJVqw3wpuySQljX
         HVk0CmWQBiTIYk+pjxvzsVSHvGke+VAbNcpelvvYKSj5suP/E9ZlJvDtwbbL6sMLQ1RB
         5vdpT83NM7GeJB+I30Cio/M8vUl66kqGz1356YAS2RR62LBmFSGTNeJnd6KhZmgJCypv
         6cb3wf1t4o5H80D5X7si/VliOnbldr/oZl9o+6EOQxF7j7f5QcVYYE9jsP6F3GNWDmu1
         z4fwzlWuyszg68TmY0ObHfl6jfy1r1niEhXoJU1SHhrAgdeIzzfMO2rSj6Zjzdx0HGrU
         aFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710287810; x=1710892610;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zl9PC7FMZlnjsGfkV0mu1AuaGsWjNCYzUqWD8hwrZds=;
        b=DA/hz9oJ/QX8YlzFydxe8bw981sfVolfRpJhQXHmvyH3TfNZPCXr7n3PZswDEeNMSS
         P96nHRgnqvhJlH9wtm4eacMKhMEc+yi4zcvGXLNMA8NhMQSFBcmFQtpwya5A4uK/n/zU
         rbOk0qMy4tMJuZqSynUVIvElegIpf24dfiJV6z9F+sVAH1FkDvyszfT3DADBRfysERMf
         sJeD905Z3tSCAI9kKFzcXf/nLkB1jlR6IeysCeDVr2DYrJQk9B5pWwJzKCZUhJHiJ5tM
         gsqQaWX3s14GNPDgvmjQ/cqL9vk0da9Jn1oR8cp3LKupuWcFs8U8ebqfj+NCCA77L4X5
         AqoA==
X-Forwarded-Encrypted: i=1; AJvYcCVacTppzMDjH7oD4m4JuF5K1iBrJmW45DdKltXk+bTTmVzB0WR5HgM4lVBIBzKqlKVNZlSJ2q+kpvM0/LyDIfIpZOXh4MfR6jHdoOos
X-Gm-Message-State: AOJu0YxJaF06s7hzy4RNRU60IuBdRrgVMkvTPjhgca8BAUmx2pZg3Hxf
	nBR8yjo9JgG5V++GlQqA8V8uFkZgDZiJQA2njiDl0FdbZFe5Tqpdmdgl4xJO4wM=
X-Google-Smtp-Source: AGHT+IE8Dmw1Z80zDDEuGQisqIkLb3ATdKh/kIXXdSWtfBQ7CA9QAFZ+Fy8t43y0MFgM+taz+MT7xQ==
X-Received: by 2002:a0c:fc41:0:b0:690:7a4f:d670 with SMTP id w1-20020a0cfc41000000b006907a4fd670mr13082479qvp.8.1710287809872;
        Tue, 12 Mar 2024 16:56:49 -0700 (PDT)
Received: from [100.64.0.1] ([170.85.8.176])
        by smtp.gmail.com with ESMTPSA id r6-20020a0cf606000000b0069046d929a3sm4080243qvm.145.2024.03.12.16.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 16:56:48 -0700 (PDT)
Message-ID: <1c24d9d8-36dd-4bf1-a1b0-afd371fbb809@sifive.com>
Date: Tue, 12 Mar 2024 18:56:47 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 2/4] riscv: Include riscv_set_icache_flush_ctx prctl
Content-Language: en-US
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Atish Patra <atishp@rivosinc.com>,
 Alexandre Ghiti <alexghiti@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Jonathan Corbet <corbet@lwn.net>, Conor Dooley <conor.dooley@microchip.com>,
 =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 Atish Patra <atishp@atishpatra.org>, Randy Dunlap <rdunlap@infradead.org>,
 Alexandre Ghiti <alex@ghiti.fr>
References: <20240312-fencei-v13-0-4b6bdc2bbf32@rivosinc.com>
 <20240312-fencei-v13-2-4b6bdc2bbf32@rivosinc.com>
From: Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20240312-fencei-v13-2-4b6bdc2bbf32@rivosinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-03-12 6:53 PM, Charlie Jenkins wrote:
> Support new prctl with key PR_RISCV_SET_ICACHE_FLUSH_CTX to enable
> optimization of cross modifying code. This prctl enables userspace code
> to use icache flushing instructions such as fence.i with the guarantee
> that the icache will continue to be clean after thread migration.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Reviewed-by: Atish Patra <atishp@rivosinc.com>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/include/asm/mmu.h       |   2 +
>  arch/riscv/include/asm/processor.h |  10 ++++
>  arch/riscv/include/asm/switch_to.h |  23 ++++++++
>  arch/riscv/mm/cacheflush.c         | 111 +++++++++++++++++++++++++++++++++++++
>  arch/riscv/mm/context.c            |  19 ++++---
>  include/uapi/linux/prctl.h         |   6 ++
>  kernel/sys.c                       |   6 ++
>  7 files changed, 169 insertions(+), 8 deletions(-)

Thanks for the updates!

Reviewed-by: Samuel Holland <samuel.holland@sifive.com>


