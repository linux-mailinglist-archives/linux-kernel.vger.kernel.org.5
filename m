Return-Path: <linux-kernel+bounces-79854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C84598627A2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 22:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 660BC1F21B0C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 21:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AB0481C6;
	Sat, 24 Feb 2024 21:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nqh/+g+P"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AAA4C2D0
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 21:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708808533; cv=none; b=NDACHEibQPqjFFaD6L2e1WPTmEvU8sE93ke7usQfylYSR2V5UD+Ehdsg0usgVCSRohsDrMtd1sMO8l2KQKVGnJ0Oyo903K2gEAG6iTjbb8gLGPrwoYkyvUauokuWkFf+0v67Ac2MghyMkslpYPD4aFV67+lDTVstcrqw5724hxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708808533; c=relaxed/simple;
	bh=WiBv8N82kcLZuhS9znenjc2QK2P06cLRxM1o/FwZOqU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TCA29pOKnFWAf7Ec7fyo96GP/jU7GZtidnvUAY3XCGRNs2/WTIsa3V9F+eqmyleMDerBp3GhUXsSQiJP9AVXvYPzebmmGimcnHYLkdqnpbVguodFaiObJdItekgUkhwOeXsLPNv5DcX64nnHvakDuPJyMN71z1SaxXjToj4rF9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nqh/+g+P; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dbe7e51f91so84205ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708808531; x=1709413331; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ePcRftl5sVDiYzrpHJ3u0w2CefDD/b0RFj0UwX8i7Ys=;
        b=Nqh/+g+PI5JNNYzdTMFlZxemS+vltwg0ng47ivl3QsSh4iLSIZ7t72a53NDHBOUr/E
         b1zRBS9DgW98bmdgDzcBXJClZtHXhk0osOIRs9yg/V/a9R+C6Z2x8fguar8Y80quDqh3
         eBQNyNkciqGLj8qU/u5IjePCNv7ghcy+RCgYh0DoW+A7L9jqD1wqT61oypwgEO9MPdTJ
         aGlJSxmEHQIjIRbig9wC5mUnuX9i11wl5le3QF0GsfL43ipBaZIk8nK2GdsEToGD6ovO
         SaMZjeOV60ETndFcMW4+GZd3yNZhSwj+3fPvuQOr8YRLWxS90yx2/nBbG21z8efEvwQS
         YIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708808531; x=1709413331;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ePcRftl5sVDiYzrpHJ3u0w2CefDD/b0RFj0UwX8i7Ys=;
        b=ufiJ/IQAqWrEi7OKun2f/0gi60jg3oO5izRqNuZP4G3aYS8ivbU100vDPGuqP2kCaF
         AmsbZ+r/LCNu0YQWJMbJfsfD2xujuY4tbpIe3rpnJs837LfYiWcCGBopEZLS7vH2LUD4
         /DiIaxt7xdoGqUCJCiVild4Bf9AXr9KB8Gbs7FU84Myhh4Vr+gcqJtcSbolKJlOZ48Zd
         S0xcXj8pVaAg9EPO7HoFKY170ukmZkyWLeL8a3tBnascqppfUD22IYhzYSYwfVaFJkJw
         iZ8zQloJYPkYyrmML2LJ4uWE+dm+PYF8oHqksdnNzy3HiXi1CPcue0oO/mzG3gXQFoJP
         GdIg==
X-Forwarded-Encrypted: i=1; AJvYcCW1oPfH1J7vlj1zlY/C54BOtI0YZvKg9qIR6vtQcI7CvRCaFcof22P0hrG0kKEFkt1+8VsBe057DIITLLENkrA7LVLNk4xOfqYqQN0b
X-Gm-Message-State: AOJu0YysBp8qj/XhCrwJyOu4jyQWysR4NhuG9q5G69CHIwsxx0wRX5Wo
	La23+lfjajGMREhflJCBiXqU0KFTvcJCKBTsZGJFeRZhSwYFsnoNIUx4FYQU8Q==
X-Google-Smtp-Source: AGHT+IENt6y3xMZdPidcytahM/DYB9CW9Wn2djHjVN8SOPgNVka0WghH09kEdgaru+hlSeLMJP3RPg==
X-Received: by 2002:a17:902:d203:b0:1d9:907f:635a with SMTP id t3-20020a170902d20300b001d9907f635amr183529ply.13.1708808531154;
        Sat, 24 Feb 2024 13:02:11 -0800 (PST)
Received: from [2620:0:1008:15:ce41:1384:fbb2:c9bc] ([2620:0:1008:15:ce41:1384:fbb2:c9bc])
        by smtp.gmail.com with ESMTPSA id r32-20020a632060000000b005d30550f954sm1474292pgm.31.2024.02.24.13.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 13:02:10 -0800 (PST)
Date: Sat, 24 Feb 2024 13:02:09 -0800 (PST)
From: David Rientjes <rientjes@google.com>
To: Vlastimil Babka <vbabka@suse.cz>
cc: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>, 
    Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Hyeonggon Yoo <42.hyeyoo@gmail.com>, 
    Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
    Alexander Potapenko <glider@google.com>, 
    Andrey Konovalov <andreyknvl@gmail.com>, 
    Dmitry Vyukov <dvyukov@google.com>, 
    Vincenzo Frascino <vincenzo.frascino@arm.com>, 
    Zheng Yejian <zhengyejian1@huawei.com>, 
    Xiongwei Song <xiongwei.song@windriver.com>, 
    Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org, 
    linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH v2 2/3] mm, slab: use an enum to define SLAB_ cache
 creation flags
In-Reply-To: <20240223-slab-cleanup-flags-v2-2-02f1753e8303@suse.cz>
Message-ID: <9e2e6912-5778-2e34-5f63-3ccaebdbe576@google.com>
References: <20240223-slab-cleanup-flags-v2-0-02f1753e8303@suse.cz> <20240223-slab-cleanup-flags-v2-2-02f1753e8303@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 23 Feb 2024, Vlastimil Babka wrote:

> The values of SLAB_ cache creation flags are defined by hand, which is
> tedious and error-prone. Use an enum to assign the bit number and a
> __SLAB_FLAG_BIT() macro to #define the final flags.
> 
> This renumbers the flag values, which is OK as they are only used
> internally.
> 
> Also define a __SLAB_FLAG_UNUSED macro to assign value to flags disabled
> by their respective config options in a unified and sparse-friendly way.
> 
> Reviewed-and-tested-by: Xiongwei Song <xiongwei.song@windriver.com>
> Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
> Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Acked-by: David Rientjes <rientjes@google.com>

