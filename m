Return-Path: <linux-kernel+bounces-131904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 500B9898D72
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 812811C278C7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE94D12DDBF;
	Thu,  4 Apr 2024 17:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NQQNeJjq"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4B8848A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 17:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712252822; cv=none; b=YguzrPSLXQoCBdMhh0HQlP3T3ngAiO0SLte/dnqje59rChG8aoNsC8Yzk3kQEJa7H/IW4P+m98gul5cDVaUd9jMs6zWJINBZVM5IlZUcKSSGN6rhLM2BOgMXcvZKbb7+z/ADPiHhSc9vnQLj6IWYAHa+HmGhfIkOmHD6KA5ekaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712252822; c=relaxed/simple;
	bh=44yDMXUOqhExaqDuHmE5IwqLjmwdDpoTzjc9jXQWXlo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I926xa0YdOk/LusT6YrWbFeDJF25Yi6Wq1t7C6gOeIPHdny/YuLW7HvtBfaRTw7qp92gMHvSpnbyuH62H3jhEW8jagiLxXSD0S2sPU1DogGPMfsgXC8sxTUfu4NTNxUdtJzo1Qo98YY0rW4jfhN/QRMWL5V/dtbl83JF7V0I0fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NQQNeJjq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712252818;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=44yDMXUOqhExaqDuHmE5IwqLjmwdDpoTzjc9jXQWXlo=;
	b=NQQNeJjq8D6hffvPgkgPMct3LJGLWhGasLxQREcD3h5fvMTHiDWw/D8NBKZxA5xCxwkJij
	iaVzEef+8tcOwMRF4TWxnRY39laPdgEz+q+V4i6mrIP5n+T2hsiUDxydeZiuhv1rlwX/dt
	1fRMIqlD36/C9dp8znT47E/BNTQeO3k=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-339-PiX1xSoCNn6TewfvKZhbUg-1; Thu, 04 Apr 2024 13:46:56 -0400
X-MC-Unique: PiX1xSoCNn6TewfvKZhbUg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-516ae539accso1536723e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 10:46:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712252815; x=1712857615;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=44yDMXUOqhExaqDuHmE5IwqLjmwdDpoTzjc9jXQWXlo=;
        b=sNtT92CHFRhTMTYQLuFh0OQT9Y0EdsEfdqNDRyl7PiLY0WfRvPmhuWzri8vnO0QgQU
         7Up7r+QctbCeEAlcALHsEHeD4exQUU/Meqvd9n3SYgn2M6++wEHqLnzdBIfNr2h2sweE
         ZAdmVRqsvDQ5FDjeE2VBQt2jkNbYZUsR4ux89jxCNxO6CCn58TzrpOA86mGFyqiaaGsr
         03ilg90TBd5ICOukmCC1FTGDxgcqPeONLoXWiuxhaDkMTPpx8MTlrrId4mh4Dl7rR1iL
         mub1jzhQQtiXDB9g9CZa1M9xJMD6HJVnhQljCxAJyZ/AiL4rvWEg7nX3O6TyI+k66+oP
         Yz9w==
X-Forwarded-Encrypted: i=1; AJvYcCXZqYtWLUqS5yuz7/eKyrIoMCmiNQupx2l5LOa26g2a4tx3LRaEjIBRX0MM2XQOZqoecU43bTwnODbytM8LGq/K/sCtJ9pMpDttyI9u
X-Gm-Message-State: AOJu0Yw49ef+m+Z1tuyRjOcqgXLYDqdnmXYCVWUOEAyC1vW7f4kkaPW6
	hJ6/3fxuXipoNCjVEBqll4O49tO3S7Wgvon6ZwS9d9HuNnYtZvGiSbOcQxH31G3aMfwqR3j3BFN
	VIULiNaIggvoG5Jze7f4zWIU+nhwqywTJRBlZc04c3awdGL0NPMdgGoo28l9viw==
X-Received: by 2002:a19:2d4c:0:b0:512:fe25:550b with SMTP id t12-20020a192d4c000000b00512fe25550bmr3120233lft.47.1712252815427;
        Thu, 04 Apr 2024 10:46:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZElqXYqPmcPOGKRK+CMVgolVa91taTpu8/c6w3chMATXQAFaj7SGEJwQi+5pNoMWrdDsyCA==
X-Received: by 2002:a19:2d4c:0:b0:512:fe25:550b with SMTP id t12-20020a192d4c000000b00512fe25550bmr3120205lft.47.1712252815100;
        Thu, 04 Apr 2024 10:46:55 -0700 (PDT)
Received: from [192.168.0.182] (host-87-2-128-150.retail.telecomitalia.it. [87.2.128.150])
        by smtp.gmail.com with ESMTPSA id jg21-20020a170907971500b00a519e8c27d2sm84758ejc.208.2024.04.04.10.46.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 10:46:54 -0700 (PDT)
Message-ID: <efb82f02-ec22-4a6d-8b1b-8cedcea0bbfc@redhat.com>
Date: Thu, 4 Apr 2024 19:46:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/15] sched/core: Add clearing of ->dl_server in
 put_prev_task_balance()
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
 <20240313012451.1693807-2-joel@joelfernandes.org>
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20240313012451.1693807-2-joel@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/13/24 02:24, Joel Fernandes (Google) wrote:
> Paths using put_prev_task_balance() need to do a pick shortly after. Make sure
> they also clear the ->dl_server on prev as a part of that.
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Makes sense. Added to the v6.

-- Daniel


