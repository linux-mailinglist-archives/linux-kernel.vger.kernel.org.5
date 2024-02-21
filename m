Return-Path: <linux-kernel+bounces-73858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A78485CCAC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 306051F24A79
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA042EC5;
	Wed, 21 Feb 2024 00:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="dCEcZzUV"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFAC384
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 00:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708474971; cv=none; b=d9P5qu8ORN8stDdsXcH7SphejGZIllAObDF8eMtTPa9uJCeHbWC3gKrx7tb/WqdE4TqGEJJrmvym+JBlKBfw0BZeDlHN+BTmonFhcy9RBFCbeEDoBira4QrayAR7iD2rz4MG+DbJHrhpSnHBL8yfAx0NJ2xj1DGIQpdJU8bj3Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708474971; c=relaxed/simple;
	bh=8WZKHSERv1Qml7vaoGY8qsCxDz2HE26cW/okoCj1S1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HkKT7GLen1Q+FzF46XEYuw2+Ox0pfbpIxxdU+ZKj1kuppp0eAxvxY6F15rLFlk7gI312U9W0/vsla66vmITOmw3qcONHWq2Uta45EDFtWyhdO7XMG5Oaqs8bMuLrGDuWWVGWlmVUG9W6y9qiLNRG6hnbJaAb+o5QDVJ644khpsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=dCEcZzUV; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-42db60ebcd7so678641cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1708474968; x=1709079768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CNzWCTUy9JFU/dlrovuUssQto5vHi7/OuWTxzbCEBhA=;
        b=dCEcZzUVCwpF25X9tqVGSvgcNLTGzT/X5FJ/nYzFP4eFvFXvni5PxD4swkZnST6tbZ
         +NzMZ7b17zLKU3iRqCuNOc/mIJDttZjDgTNendqKM36PD/pGFSmHJak3fUBne2Gr2bn1
         pL6drN9Q0QVz9M7Cwl5szxC0ZPUEUpJ02xxjA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708474968; x=1709079768;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CNzWCTUy9JFU/dlrovuUssQto5vHi7/OuWTxzbCEBhA=;
        b=wiKciJnTbfct21A86AwJm9dayJ97xn2R5s52qYTNf6937qlYyHoTiPkglW+C99KhI8
         eJdpQaJdSs6JP4C5NMG3P0f4KtH3sfUsXD6/GGTHfna5PiBUKWt4YFRxszoQIzWGaZUl
         hD/U/xXd//HOIclgYb803H5KuI1ZITBjDQUTRX5ZnEBtolNpG4/uHcq9tdrlUeRipCVz
         jKZNa34SQAddCeay8Pzk4/JP00oRArI5RgTm4uMuqeI1GZHElDrMCx0JkZwYRS0yjG7Z
         qlqhHhcv5xZKUE92F2hM4wxocFlmk9fNdSz50sCRZgJaJOjyh/cT5xOMqkJzotZcNS/F
         bIdg==
X-Forwarded-Encrypted: i=1; AJvYcCVhA7ZtwQaQyxUSX03SML1hrupPBiztsTeYEow5evRKCsNpA0QryNkNxnYcQjSfMQmRNXD9T99+nLq5w0xvyYvfVEFkwJwKsdDl4Gd8
X-Gm-Message-State: AOJu0Yz6bu6V6iKKMUQkJijwHErZ7kuENz1G9cpJWG7y4LvQhRQVZ95q
	s9RAoUdCbr9cj5up71TeJ7DpbRzYP4lGsnLJS8vCNPO4vTy0uTh3DiOSl0YIsOo=
X-Google-Smtp-Source: AGHT+IGkEKD5s4h+KVSBolVi/KlyQ6g705fjRLMKfE75hTkTjwe3yoI9olwSKK13//mX6vNwgW7HbQ==
X-Received: by 2002:ac8:59c6:0:b0:42e:24c4:ca0c with SMTP id f6-20020ac859c6000000b0042e24c4ca0cmr4792013qtf.60.1708474968337;
        Tue, 20 Feb 2024 16:22:48 -0800 (PST)
Received: from [10.5.0.2] ([217.114.38.27])
        by smtp.gmail.com with ESMTPSA id fu19-20020a05622a5d9300b0042e1498d645sm2061807qtb.92.2024.02.20.16.22.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 16:22:47 -0800 (PST)
Message-ID: <55e64c9c-8c12-4d1a-b508-3165f7078b8b@joelfernandes.org>
Date: Tue, 20 Feb 2024 19:22:43 -0500
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
To: Shuah Khan <skhan@linuxfoundation.org>,
 Chris Hyser <chris.hyser@oracle.com>, linux-kernel@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>
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
 linux-kselftest@vger.kernel.org
References: <20240216183108.1564958-1-joel@joelfernandes.org>
 <20240216183108.1564958-9-joel@joelfernandes.org>
 <91a5dd24-3a91-3114-d73d-eb57f3128d2e@oracle.com>
 <5b1fa674-d6b4-41a3-86c3-be43467c32c7@linuxfoundation.org>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <5b1fa674-d6b4-41a3-86c3-be43467c32c7@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 2/20/2024 7:03 PM, Shuah Khan wrote:
> On 2/16/24 12:18, Chris Hyser wrote:
>> On 2/16/24 13:31, Joel Fernandes (Google) wrote:
>>
>>> This test begs to be a kselftest, is in the kselftest hierarchy and does
>>> not even use a single kselftest API. Convert it.
>>>
>>> It simplifies some of the code and the output also looks much nicer now:
>>>
>>>   Totals: pass:17 fail:0 xfail:0 xpass:0 skip:0 error:0
>>>
>>> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
>>
>> Reviewed-by: Chris Hyser <chris.hyser@oracle.com>
>>
> 
> Assuming this is going through sched tree,
> 
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>

Thanks, I think Peter is out so it may take a while going through the sched
tree. This individual patch is independent as such and could go through the
kselftest tree. However, I am totally Ok with either option.

Also, thanks to you and Chris for the tags and I will add them for future
submissions.

 - Joel

