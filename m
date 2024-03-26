Return-Path: <linux-kernel+bounces-119579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9382C88CAA6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBEBC325306
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050D21CD29;
	Tue, 26 Mar 2024 17:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eftGmQ5y"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7761C6A0
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711473809; cv=none; b=UcqpAYARsRUoaZ6+zV1lkHAMfLoXRUNxDmoy8wkD77YmzbFcntZfWTl7hikeMJdfKNDZJvOdqy7AhA0vdLv9Lm/qxY2CBb3UaoIz6agh/07XWB5zjc1hPikeCo6PLrxy/NjimRVkzSGhUgLRCMVcDpmCkO1TQpkTQgLfje6isJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711473809; c=relaxed/simple;
	bh=cMXba/qoy/bpGv4NqvbSD5Zu08ZKbaf7xWPSRDDJAhA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hdb0eBLPaUNKbMElDHJCfKSInzWIk/tQ1mcugHxy9kqlPJABt3S9Ij3aV/Tzv6wpytYcnuURaTsKAUo83oDTeo/NS9TO1pfpIlM35CXvxJcqx3buYYyHYnU8Tsk4DgtTkbPpEjLOQAfqJish4H+q/3KMMpYfIlogK3R5X7QbLOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eftGmQ5y; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7cc5e664d52so65814539f.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711473807; x=1712078607; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WfqhMfTwQzjtukQYLlDEi7Fz8060jibOn1ZPoDBARM8=;
        b=eftGmQ5y1zlwc3fT6elMtQD476b4DvzyPM+7SJrIMealbql3ZWPWbCE8tR8IjT1AKQ
         vi4uK8/gXXRYLGrRlZFQjnh+l14nbtP1oSbVqxawqmskOWiHEacqeoH+thH9s0fkh/7X
         DYxa2pO1sgm6ZMjM5SSAkEsHhAsCC83QZ8yuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711473807; x=1712078607;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WfqhMfTwQzjtukQYLlDEi7Fz8060jibOn1ZPoDBARM8=;
        b=ekB4DtIFwn27S8Q6sBd/uPcJ3wGRRvQuHrZ7A8cy3Vs+pKck2JoHZp/z/LTVfRABaO
         dp/WoDUh+uuKixOPRQlSHRZg4YOUaMWBoUIv9gUXWFElmVxrR/EIaS4tlOgmEVmN3/5V
         gvtN9vfsCCHC6XG/emAycZqErObmilHUSLj/yljmemAlR/FU++6N50eqEqmQYRTB4+la
         DqV0UZWxGjOiRyrjuYRRXh363PrEKWnOPN72hZqL00klLhklPjdC35j9ZCcZt2SSXoIc
         EOpHKeM2/olH3uNwjIlX56Xpbh3oOn+VL4ZJKUgiYXpql7XbgLEAryhxZEsN/RJhZ3+g
         5nRQ==
X-Forwarded-Encrypted: i=1; AJvYcCU78wdQD7Iq3WFYeVP4vHAJszYNjA3PhxZtMu2DHzS2y3YTqv9WVyaBaOs+xuDfI6q/4URJBbkfQft9XWk5ciu66mxVRtcx40bkYG4I
X-Gm-Message-State: AOJu0YxsoOu1sCgWbi2XWg6uIrCJMLmvUrYzoz0lLwANgGmFGrPRke/H
	BYZP9q+qduMX7bQ0QujFL2SdUhe+KHeOy8YlaJKGwi4j7zjUEycHvqzsqZhVk84=
X-Google-Smtp-Source: AGHT+IGpnam4gq6TybGxH3HiZtwDvaITufJE24+llwHdPu6wnAx9XSZzUUSFdlZCbzfidG0rgDUoMw==
X-Received: by 2002:a6b:5d16:0:b0:7d0:3f6b:6af9 with SMTP id r22-20020a6b5d16000000b007d03f6b6af9mr9560845iob.0.1711473806766;
        Tue, 26 Mar 2024 10:23:26 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id k13-20020a02a70d000000b0047c0c7b6c6esm1912654jam.175.2024.03.26.10.23.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 10:23:26 -0700 (PDT)
Message-ID: <6ae8509a-b071-474e-b93a-2814109ccfa1@linuxfoundation.org>
Date: Tue, 26 Mar 2024 11:23:25 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.4 000/180] 5.4.273-rc2 review
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com, pavel@denx.de,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240325115908.1765126-1-sashal@kernel.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240325115908.1765126-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/25/24 05:59, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 5.4.273 release.
> There are 180 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 27 11:59:07 AM UTC 2024.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.4.y&id2=v5.4.272
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah



