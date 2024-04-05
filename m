Return-Path: <linux-kernel+bounces-132705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D6A89990B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:11:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6003928359E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CE415FCEB;
	Fri,  5 Apr 2024 09:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P9pfVP+3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6997A15FCE1
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 09:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712308283; cv=none; b=B4d5Ly5OiPZuGbIhZl/24SYWsiIg9eJmbWgnShSuW4rKt/PrsCxM0b0nWTybiXkNehLYaezT+DQQCOh4ounRGxYEG6kIMiVs52mNGW+S6yokJcSA6kxYSdFSnCyNIvxMyt9z97wxIckJbxHZPUkw7STt2lr9bSJzkWsQMWZBKP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712308283; c=relaxed/simple;
	bh=k0f43+HFwe5n19byaKZ48TcGJsOkZL4OmBwr7J41pnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iegiHNZ4ZEOwrawQpd9PL0Iaw+2CINaHOBiEzBujFcBbR29yOk8iPW1dZCaRpzEw+piTH95r2YI2CfZdyHOpHo/sF1mvCeYsqPvSsnfj5xOc0CNFg1wTycgQh7nUDU7cMPZRWrQ5QRHeOXK9fXy0qCUsTUWHIb188UYDBWiEPXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P9pfVP+3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712308280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QDHrnKr22DgnWZlfJMhtdjJFlgWgZa4zlRRiaoUSTyE=;
	b=P9pfVP+3LPcitSs7sllqyBOxeB97gtett6ccWKYRBYgwmz4mIrMemd64Qd5TqVHij5cXX2
	E5Cqrf3vWbAkopdU+kgVQFv4HKW1qvZdSnsQLYWC1NMIEE5ItmYlm8YUBrDLJdqDp1GUa5
	5WfAXI/F797j8l35Ov7WQMAIR4XR/L0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-rSxiKV8PNiS593V-_8N7-w-1; Fri, 05 Apr 2024 05:11:18 -0400
X-MC-Unique: rSxiKV8PNiS593V-_8N7-w-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a51a7dc45ecso22200766b.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 02:11:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712308278; x=1712913078;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QDHrnKr22DgnWZlfJMhtdjJFlgWgZa4zlRRiaoUSTyE=;
        b=OqZbIbdPpXyqyhhV4ri0pF1VCsn6Xa5Cjh3ehjuD4LHDSlQOPi6vdXFFs1Fv6yeVwb
         /PgsSAdqnl9btWAS0kHpD3Tu1gP+ad6ZYLhXJT0LL5JTcEFwCQA2CUmnzkujFToS4YR/
         LeeYRFOYsWTbwlgnczl9RQAwJZPWGWSlNy/t7DkX8MbW6CtKem31TDBGBOYrX6lC0Yi0
         tCbQJKRDbEM+MnQOyzAfhScmpNX8ZYOn5uew8V/jjgepWp4FtHgi4RFAAYaDu375tG3C
         Wfz2gngYp/vWpgLFV22qBhAymdewKCPyt+Q4x1ZjiGMs6eUXA0zITu7PbLrxyOMb3DSF
         Kfpw==
X-Forwarded-Encrypted: i=1; AJvYcCVHt94X3GQIEazEfXj4VROX92OSFoO3FVBW2NLLiDQljaFdkfmRmyYPy8b0CdiLTWKfJCsfiUEfYAS/iBXt2zPLHozh48hm4uCxd606
X-Gm-Message-State: AOJu0YwS3QfobtBRxBIArwwmsa3CNKuNKWw8zhn3JAr1qb9Pjsp5Ru4e
	aHxH3ySgR/leQaAMAlwhBQ7zVpvZ4YkSZdQ0Gpqf9sMFCJultraH6mcrcC+kMtyagszXfsBGNPi
	qOTZptx/UPy+PL0bqe7ZOa8VHSeVxwL7jofD77ZxvRunG0jMVGwvWjY4W/CU0vw==
X-Received: by 2002:a17:906:138e:b0:a4e:5fe8:46bd with SMTP id f14-20020a170906138e00b00a4e5fe846bdmr548359ejc.51.1712308277872;
        Fri, 05 Apr 2024 02:11:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGg3Gmg/1Vrlb1IifqTTzC6Xf8ZH6MZYfRKH8HT+cM1QbcoWsvKZ85OPeS1OtIFLbCRgmFvCQ==
X-Received: by 2002:a17:906:138e:b0:a4e:5fe8:46bd with SMTP id f14-20020a170906138e00b00a4e5fe846bdmr548350ejc.51.1712308277642;
        Fri, 05 Apr 2024 02:11:17 -0700 (PDT)
Received: from [192.168.0.182] (host-87-2-128-150.retail.telecomitalia.it. [87.2.128.150])
        by smtp.gmail.com with ESMTPSA id v17-20020a170906b01100b00a46aba003eesm607927ejy.215.2024.04.05.02.11.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 02:11:17 -0700 (PDT)
Message-ID: <61387236-2645-4030-9859-b8a661cf110d@redhat.com>
Date: Fri, 5 Apr 2024 11:11:16 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/15] sched/deadline: Do not restart the DL server on
 replenish from timer
Content-Language: en-US, pt-BR, it-IT
To: "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>
Cc: Suleiman Souhlal <suleiman@google.com>,
 Youssef Esmat <youssefesmat@google.com>, David Vernet <void@manifault.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Paul E . McKenney"
 <paulmck@kernel.org>, joseph.salisbury@canonical.com,
 Luca Abeni <luca.abeni@santannapisa.it>,
 Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Phil Auld <pauld@redhat.com>
References: <20240313012451.1693807-1-joel@joelfernandes.org>
 <20240313012451.1693807-15-joel@joelfernandes.org>
From: Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20240313012451.1693807-15-joel@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/13/24 02:24, Joel Fernandes (Google) wrote:
> There is no point in doing so if there are no CFS tasks to run. If there
> were, we would be doing ENQUEUE_REPLENISH from the dl_task_timer,
> instead of calling replenish_dl_entity(). Fix that.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Makes sense, adding as part of the defer patch.

-- Daniel


