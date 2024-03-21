Return-Path: <linux-kernel+bounces-110631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C2D886180
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ED8A1F22961
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E850B1350DE;
	Thu, 21 Mar 2024 20:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8GPmMZI"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F465134CEF
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 20:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711051908; cv=none; b=BBo+o7ET/5N3FEbcn1D5Oi9+RJiWxrJU/MGXJrXBGaBy/D6hnM3InrTLECht+kIrvbX66nT/gyK207uYkIk+Y29rvTWOnNR9TM3ZKL94i69V+xrpMqDkYlY+MzHABZ9Fcvw/IbuqNDYRlamZwwBUj/KZa8Wbd/dqSgbFTb6xHiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711051908; c=relaxed/simple;
	bh=uhX6GYDNNtlyCovC9hT+neR70GADXG1ymHwW1MOCHL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mR7P7RNuZLeV2bBKIEncwCi3GVVK8Ba+Ai7U/fk2T+ZosYYTY3CsO3n8g/geRMTdbS+D4CU10x/64mXVh/HjN6TH26izSPmdYxOXkcQrtUdnQE8A4VQwY/bgUm472revQZ4ChWU9npKAqz28EVztUXfuGErpq5zUUfPdNmyAn4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8GPmMZI; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4146a1ac117so8825625e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 13:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711051904; x=1711656704; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eC6jgE/JRdFrOaz09LGSTM9P5P7XxBJ+9PvcFKNpvbM=;
        b=a8GPmMZIyccg9PlPAUnVKTN2iclwufZVoZx4hyWCCk1XvD0jK3eCPeLBh8juKGrPRn
         VMnVx3bU06fDEKrEeMtlra0GM+jTfepVLyJwogJXGCuEDsvjiECXxdYND+GbDiLplHHy
         WSzGHMzWlEYBRYcNPjl47f74ofda3jsgQ9kPhiLHHeWiPpQ+AaO4ZQg5qkQnNy0JnlGc
         4rTkXRkCxeUEtC7V6QsLKc0Hoe10Hh/Xm8+siIk/yXvAVb4BmLa1eO55Vt5kQM1e7X4+
         Ah/mi22NGnMn8K0v3l+Yt25vXbNKz+2i8DuiqhyDlhEzVInchweAWnAlD7nXLHzcWv7K
         0/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711051904; x=1711656704;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eC6jgE/JRdFrOaz09LGSTM9P5P7XxBJ+9PvcFKNpvbM=;
        b=ViT1NC7fzCJTJHMjZFs2xXeRBsk4SUH2QNDAPw9eqX0nm56cL7o/T/IxWeSqiT8aGY
         Q4lYvDbP43ezIcQaLud8cDn4fC5slrpKQSoWtsBrZ0SECSbHUwjMkhx8a2vGX0H0cjvE
         kOFk/9CaqK4sOmzPy1aDiaRkAu0dVoJXPC/3SUUSd2LyMP0ek4UHsGW5tr5/5KHwF5Dl
         ae/KN/CWiBVvydFG4sZNR9y7SSAvW+mNgOZhiNt9+rcNJYqsXtSeRNpq7XCo9nt523pZ
         jr/V2cVgLnJKf6kqxviwWyXHih/oAbgPBZhH4yMD9SAbhEYBgylWCNiIttJFWhC+8HtQ
         Llgg==
X-Gm-Message-State: AOJu0YzmCPKUFRohDVkRlNcIPAJpt8ntpaJjayktpMionJfKSfb1x7kH
	qw78rcCbDKK4jg3G+xSY9b9yeMr05xRP/0Bc9UWKlxrzRxvozKzW
X-Google-Smtp-Source: AGHT+IEsmrZsSBcMFJfimUf1shifE2MvIuVcK3gKjl47KpvXKh6BXPrCVH+d4D1A82MetbbMNGysGw==
X-Received: by 2002:a05:600c:1d02:b0:414:6a1d:2013 with SMTP id l2-20020a05600c1d0200b004146a1d2013mr20651wms.16.1711051903977;
        Thu, 21 Mar 2024 13:11:43 -0700 (PDT)
Received: from gmail.com (1F2EF04C.nat.pool.telekom.hu. [31.46.240.76])
        by smtp.gmail.com with ESMTPSA id n11-20020a05600c3b8b00b00413eb5aa694sm759878wms.38.2024.03.21.13.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 13:11:43 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Thu, 21 Mar 2024 21:11:41 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Maksim Davydov <davydov-max@yandex-team.ru>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, gpiccoli@igalia.com,
	den-plotnikov@yandex-team.ru, dave.hansen@linux.intel.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Subject: Re: [PATCH] x86/split_lock: fix delayed detection enabling
Message-ID: <ZfyUfTI4vjmeu8Kv@gmail.com>
References: <20240321195522.24830-1-davydov-max@yandex-team.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240321195522.24830-1-davydov-max@yandex-team.ru>


* Maksim Davydov <davydov-max@yandex-team.ru> wrote:

> If the warn mode with disabled mitigation mode is used, then on each cpu
> where the split lock occurred detection will be disabled in order to make
> progress and delayed work will be scheduled, which then will enable
> detection back. Now it turns out that all CPUs use one global delayed
> work structure. This leads to the fact that if a split lock occurs on
> several CPUs at the same time (within 2 jiffies), only one cpu will
> schedule delayed work, but the rest will not. The return value of
> schedule_delayed_work_on() would have shown this, but it is not checked
> in the code
> In order to fix the warn mode with disabled mitigation mode, delayed work
> has to be a per-cpu.

Please be more careful about changelog typography. The above portion has:

 - ~3 capitalization inconsistencies
 - one missing period

> +/*
> + * In order for each cpu to schedule itself delayed work independently of the
> + * others, delayed work struct should be per-cpu. This is not required when
> + * sysctl_sld_mitigate is enabled because of the semaphore that limits
> + * the number of simultaneously scheduled delayed works to 1.
> + */

.. and some of that seeped into this comment block as well, plus there's a 
missing comma as well.

Thanks,

	Ingo

