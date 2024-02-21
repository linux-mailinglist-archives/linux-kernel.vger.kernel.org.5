Return-Path: <linux-kernel+bounces-73847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6791185CC7F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22FA2282877
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9522A7EC;
	Wed, 21 Feb 2024 00:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L3DQG/YT"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD30193
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 00:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708473800; cv=none; b=sfnXy1YKGuvulAtJSYV6NnAzvMsArd1RxzoaDxgg/4Czey811sbWXVqpCZwg8PJtvfcQnOoUKSOLNCbrhcYtjK2SWGScg/Lxg1lyY8yATsvZ1YtPmR7NKmY+E++vN6evTWvDJzgeA+dqrqse0WIXJgEMRzGzn25wkt5lq6JKKlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708473800; c=relaxed/simple;
	bh=VLF6pe2KlpUaD/YQphYnv8Kbh60VcvVVFseFbIymCmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V6zH2Z34adCcitGzjWOXixKfDyPuRSHndPv1XhS1LI4XFwnlaXfj57UrF5U0a5U9hUr0i1zHa58UwV8NgrJ3ieNRDoM6a9kma2N5t0xNZPNFzygc8bYiGdVM5kWMGvox2wqQeo8jvtYnwYXUDBltXu0XdFRoUHLizuXawFeL5Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L3DQG/YT; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7c495be1924so66151339f.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1708473798; x=1709078598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KdzC+0SBOk3sPai1fZFmMCHYkj39Li+e17MeEWbItQM=;
        b=L3DQG/YT5NSHJhgIeiJRsKRtmwX4mIYsiiZm8UGGXRNWNnOM0yyprJze8aRMdEqjC+
         4b8WhkDYrWUSWDQIpXj8t67+OhhYY3DmruXKIBefPAEmIBRmtZFPx20AZi1KpJygZyOy
         p+ShmNndsf2mlCRhUmGTeDtkf+sIsJZ/n8zjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708473798; x=1709078598;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KdzC+0SBOk3sPai1fZFmMCHYkj39Li+e17MeEWbItQM=;
        b=ZLB3aduvyMCoZZigjOdrzLYpypqtgSA/6j+BvW0/CsS94yn51s32pgpIYpYfLw1lYb
         GG2jaGf3muY9OlkvurecTLKbrCQfom9Sp7u8rc5hQUor23DhBm2nlEiD6IWFGFhtNURg
         IXsL5hdykkt0nwRJFB8FU7dzsrYFD1DHNo9FUu5v1govkdVAm4WQCmQG0+1xIksbyzJI
         FYCiDClJXl9G8MKrBm7r1wEoHvJ9tShRgariSj5DdOOQ4030mQDEgDHTSO77rG1YuRFD
         VQJMmstGGnZXJ7RS0cTq9VYbWpAwzBEyNLC5lRJiRbqlFECn4ZifSyFgIrDDF8asdij3
         TvEg==
X-Forwarded-Encrypted: i=1; AJvYcCXPV+532kEaK0A0d3BQXaS431hfEs4N+BDJiiQhL+hJnQBatfVkJj+GvCvZe4XICOOt1agFDqyNJfHxArsCLgo9r6HyhCNyxq6IkoDW
X-Gm-Message-State: AOJu0YwCK6GzIHxsjSbyWREaTVSFMiU5eGkKjKDdDay/CEEAuiQpWlDG
	DTPliVy3GcVYZDfo9o9nuq/wAmB2YUjUs5lwW1I3ItzZXHUNuQGWYTlEG2opwHI=
X-Google-Smtp-Source: AGHT+IFMgAG/+Gs7T1z3Brdrd5ypm7xNwAGGeitjt89C6ZFuM6ml5/MdtM+cSsj3Ngry6ku+13mqYA==
X-Received: by 2002:a05:6602:1582:b0:7c7:35f8:86ee with SMTP id e2-20020a056602158200b007c735f886eemr12142680iow.1.1708473798474;
        Tue, 20 Feb 2024 16:03:18 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id s18-20020a02ad12000000b0047137d479c1sm2360226jan.123.2024.02.20.16.03.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 16:03:18 -0800 (PST)
Message-ID: <5b1fa674-d6b4-41a3-86c3-be43467c32c7@linuxfoundation.org>
Date: Tue, 20 Feb 2024 17:03:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] selftests/sched: Migrate cs_prctl_test to
 kselfttest
Content-Language: en-US
To: Chris Hyser <chris.hyser@oracle.com>,
 "Joel Fernandes (Google)" <joel@joelfernandes.org>,
 linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>
Cc: Suleiman Souhlal <suleiman@google.com>,
 Youssef Esmat <youssefesmat@google.com>, Steven Rostedt
 <rostedt@goodmis.org>, David Vernet <void@manifault.com>,
 Thomas Gleixner <tglx@linutronix.de>, "Paul E . McKenney"
 <paulmck@kernel.org>, joseph.salisbury@canonical.com,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall
 <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Luca Abeni <luca.abeni@santannapisa.it>,
 Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
 Vineeth Pillai <vineeth@bitbyteword.org>, Phil Auld <pauld@redhat.com>,
 linux-kselftest@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240216183108.1564958-1-joel@joelfernandes.org>
 <20240216183108.1564958-9-joel@joelfernandes.org>
 <91a5dd24-3a91-3114-d73d-eb57f3128d2e@oracle.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <91a5dd24-3a91-3114-d73d-eb57f3128d2e@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/16/24 12:18, Chris Hyser wrote:
> On 2/16/24 13:31, Joel Fernandes (Google) wrote:
> 
>> This test begs to be a kselftest, is in the kselftest hierarchy and does
>> not even use a single kselftest API. Convert it.
>>
>> It simplifies some of the code and the output also looks much nicer now:
>>
>>   Totals: pass:17 fail:0 xfail:0 xpass:0 skip:0 error:0
>>
>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> Reviewed-by: Chris Hyser <chris.hyser@oracle.com>
> 

Assuming this is going through sched tree,

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

