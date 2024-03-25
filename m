Return-Path: <linux-kernel+bounces-118053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DD588B2FD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8778E1F65BAE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830916FE27;
	Mon, 25 Mar 2024 21:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jYIp0by4"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6E06F525
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 21:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711402909; cv=none; b=FICbrH45W4E+xrOnrhV9V3kcyl4yypOJh/CEqkCHLHsi2Of8jwUOvvd8vBwXK37RGTKjpQmGmPSzCM2EdVtKswIl+3pdSW4xySYiWHQ/MPIaIXJEnSuYvkuoe/GPQTunKKgV8vrPB4AG8GklaAXdHburYnwIp8zyvc9T5ZEzrjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711402909; c=relaxed/simple;
	bh=hD9XsIBzAV/bPhZwOQmQep3NyRgaTjUJYFuVVNQO7Yw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDiRcJs+nmLRZWK1Phv5YET7ryYgLRFZW4a5nj0iacE4hEUFSiWKXWmNmAQJGrRcvlawVIM+xV8WtUCCXlENUI6GtdF3NmF+D0QDpeBzKnRFJq+dOGGXMw0iJshKWhs8Ifb/9nb0OpXlFYqsnDEns8h8H+Vms4bDW3Jklu1cVbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jYIp0by4; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-56c1a50b004so2651a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711402906; x=1712007706; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O/KboFRJyODJZyWJydsADn20bl4YX3uVsNj1S+g1jiA=;
        b=jYIp0by4RD9yx8iqDLdDhq7bozzs5ImXfzfVIyurahnTYqKNA8NpOkkwK5Ih7jS5WN
         a/KKp5qwN+tfCs4eWb2XgEQpw3G4zzFwF71mEQS2++87NKl+x709eq3esV1HxbwrzFnG
         gTWACJXfsjJ27HeH5sfcBbFt9TI37vdZqaP8bo4aIuhINPlCjxNl09va5SprMhvGBf+i
         +gNbsv8J8p1VTXM4S9yrFjtq+VG4l2jH35/6nmk0MS/KsDdKYqKQV2o3k8tmEs1pl0bw
         tSG6O/aQ0nzUqXkL6XD0X8O1jLtiJwypqHNfJmo+jC1BSIpCT9eLFVBI/3+YXcqkK/7I
         9oLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711402906; x=1712007706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O/KboFRJyODJZyWJydsADn20bl4YX3uVsNj1S+g1jiA=;
        b=DW+4p9R9Irqcy0chiszMjHRnoUw8aO+q7GDKw1A5lY1YpxOq35KVq6mQGngawQZ91T
         1pdoq8vwTmXematoHyKEmcNzbf5aMKDocrXD2XFjdOU4KGDtZQfhrlkyApHdXRfp9vym
         BgCW0qJaDFBPu1BAg3Vmj4hoMzKDrt3ZbKgA1D+5ENNwL0wWNjbQr6gc4WAq+wbhIP61
         ozB6+V59g6MfenDBa2O39+Xbc7Qsa1jcNbFk4UHAoZ3FgQPXeWBI8wgntTISUI/Rq7/n
         4KTmVV3Bw62KIYQPobc/7wTZYqf750A2jf7yqL4+xJfOkw7CUp5seiQ9gbnVQk0y/nso
         0JRw==
X-Forwarded-Encrypted: i=1; AJvYcCUOq3wHFl9AiY/g4/abxUV1/GZgxsBOVQKoqp9FcyNvxvnk4BrS85NNmSF+kb4nZ9FYpNLlXRwElt6WzwZpdBS6CXhPAN0zDGMor/Ps
X-Gm-Message-State: AOJu0Yy4rApSMzDDsIdkrkvYJMx5GbKFs33bIq+cWjudNQcGmWJmQ5aL
	QNEyHxCEpHhoQkQjFo36GHgmL1SSmqk1eRJYOhyXflmVPl/4dD177MqvHyflUCI74rYwqgRfmqP
	tR86nO4iEe3oC47sNj8+V+bu32obXYubak/6y
X-Google-Smtp-Source: AGHT+IHgkwX8y9U03a0Hq2u9cOn7hIzoMZsLqoGAIZkeovc4m2XkeHedXDRkFuGzeQSfjLbAnvGesQj0WAvl+cOCr+U=
X-Received: by 2002:aa7:c44d:0:b0:568:7767:14fd with SMTP id
 n13-20020aa7c44d000000b00568776714fdmr27919edr.7.1711402906313; Mon, 25 Mar
 2024 14:41:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103031409.2504051-1-dapeng1.mi@linux.intel.com> <20240103031409.2504051-3-dapeng1.mi@linux.intel.com>
In-Reply-To: <20240103031409.2504051-3-dapeng1.mi@linux.intel.com>
From: Jim Mattson <jmattson@google.com>
Date: Mon, 25 Mar 2024 14:41:31 -0700
Message-ID: <CALMp9eSsF22203ZR6o+qMxySDrPpjVNYe-nBRjf1vSRq9aBLDA@mail.gmail.com>
Subject: Re: [kvm-unit-tests Patch v3 02/11] x86: pmu: Enlarge cnt[] length to
 64 in check_counters_many()
To: Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Zhenyu Wang <zhenyuw@linux.intel.com>, 
	Zhang Xiong <xiong.y.zhang@intel.com>, Mingwei Zhang <mizhang@google.com>, 
	Like Xu <like.xu.linux@gmail.com>, Jinrong Liang <cloudliang@tencent.com>, 
	Dapeng Mi <dapeng1.mi@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 2, 2024 at 7:09=E2=80=AFPM Dapeng Mi <dapeng1.mi@linux.intel.co=
m> wrote:
>
> Considering there are already 8 GP counters and 4 fixed counters on
> latest Intel processors, like Sapphire Rapids. The original cnt[] array
> length 10 is definitely not enough to cover all supported PMU counters on=
 these
> new processors even through currently KVM only supports 3 fixed counters
> at most. This would cause out of bound memory access and may trigger
> false alarm on PMU counter validation
>
> It's probably more and more GP and fixed counters are introduced in the
> future and then directly extends the cnt[] array length to 64 once and
> for all.
>
> Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> ---
>  x86/pmu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/x86/pmu.c b/x86/pmu.c
> index 0def28695c70..a13b8a8398c6 100644
> --- a/x86/pmu.c
> +++ b/x86/pmu.c
> @@ -254,7 +254,7 @@ static void check_fixed_counters(void)
>
>  static void check_counters_many(void)
>  {
> -       pmu_counter_t cnt[10];
> +       pmu_counter_t cnt[64];

I think 48 should be sufficient, based on the layout of
IA32_PERF_GLOBAL_CTRL and IA32_PERF_GLOBAL_STATUS.

In any event, let's bump this up!

Reviewed-by: Jim Mattson <jmattson@google.com>

