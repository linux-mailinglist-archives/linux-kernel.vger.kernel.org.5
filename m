Return-Path: <linux-kernel+bounces-131814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34879898C1B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6402D1C22895
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688D112BF06;
	Thu,  4 Apr 2024 16:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ao5y+t5J"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F6C8528B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 16:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712248198; cv=none; b=Oy3XvmK/CPFAwQ1tRmrJBJAgSoxn3A8GmERON3okOvGXvhmRWtqTnPxa22AflBGVn+gqEaKYhPTCGgh+eC5vZp/l2lZTsww5IFPszqY40VGoEbtkXvNcnGutQ+ZsANC5a2ImD5CWbT4q5d7nLe/m0zcVNTn94zK3mdncejUAr+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712248198; c=relaxed/simple;
	bh=ytv+ue1TGaBnCZL0FxJWPJ991CN3uWCP8kbp+s+9WCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hf9l1pW5po/uXTvWlAlMioiZpPoHWMcQZluV0ciB990ZNhn0bwKuI5IbKGO2fdAqQMXnBSRi1JwIpF2RpTSWfpQjH5ZOTSsgw3u8AIo1ZSWeTFcQ59yyeY7XtiCQzBgf322JVGPMHKOVaxq+AbQMX6375+E9viCe0oCCBbXfv60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ao5y+t5J; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7d0772bb5ffso24908039f.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 09:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1712248196; x=1712852996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pY36khtaeJuaS4ZuxN8qXaz5gkZz7w/s1SIWsgW9Chs=;
        b=ao5y+t5JHWRgja1ibQvdD9Ingy2AEyRcKm6h2nnoLnMpbzAkVFPHVcbaIyje4u5pSW
         z/EQNwDeANuJbKarkbn+ueI9XRDyFztYy0GWktfEbCGLZK3pjq0fLtdbdNZ/EL2QxFKQ
         8eKLhAYabHtihVyiEzjmqCpNSFaUnFrw7LCX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712248196; x=1712852996;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pY36khtaeJuaS4ZuxN8qXaz5gkZz7w/s1SIWsgW9Chs=;
        b=Jx5D62uSQBYOEZVoudR2QCd0JjlO0zcQMP4xowysGhxrKCk7bsvR5OA2DYTuSqTMgx
         muMYJ3BudyktM7APkZnSvHvqgfhWyvgB390V1OhbwmzaYtO7VUbl5rgs3be2VkVyOk/X
         whGPk3hy1Yd54ToGh3D/9NtsxgZi8ML6UDxzA3wuez7laWjbOwIqc28T4s7DIkoieFax
         GB+ssZmL/TNZ6lmGopJQG2SdkWrDfu8AecSUNK2NHdSkLptr6bb2kfKGmLjsEjD0B81G
         98D9kmm8FHhIcuOtjNlwijM64JO4uilLsejVQ+xO22qWRtx1+emuPb0udcvlHLtP8Vj+
         U66g==
X-Forwarded-Encrypted: i=1; AJvYcCWcs8X13gun+ivqkerCz/hFmCbE/5n/07BjZk9w/h509r90lF4qI79Z+hqFYnQ7qekq8BxHYW52g/79qMNusRwnigBXf9nnsZ+JL4/x
X-Gm-Message-State: AOJu0YzdtfDbG1wHe67cfBTbAqQ9m3sYbGsTaryzg1J2f3Ba7Wd51Plz
	lj5SFzRjp6An+lIvGlK2WqcH0aYswBSaPXHOlpOM6OItB6TUxLJb4+zrlp/t314=
X-Google-Smtp-Source: AGHT+IFAtxn+F+qBPu5j66DqkeU9a1RLFIfhLDUYtCM0d+dADmmnnTGKwyEhlBVyDNO96becWywWog==
X-Received: by 2002:a5d:8d05:0:b0:7d4:1dae:da1a with SMTP id p5-20020a5d8d05000000b007d41daeda1amr436014ioj.2.1712248196071;
        Thu, 04 Apr 2024 09:29:56 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id w24-20020a056638379800b00480f0130f19sm133182jal.45.2024.04.04.09.29.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 09:29:55 -0700 (PDT)
Message-ID: <7c9e1527-b0c0-47be-9d4b-f39a9af21636@linuxfoundation.org>
Date: Thu, 4 Apr 2024 10:29:55 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/ftrace: Limit length in subsystem-enable
 tests
To: Steven Rostedt <rostedt@goodmis.org>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Yuanhe Shu <xiangzao@linux.alibaba.com>, Shuah Khan <shuah@kernel.org>,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <20240226031816.88715-1-xiangzao@linux.alibaba.com>
 <20240226150938.7f0d8fd639bab79199d8556b@kernel.org>
 <20240226115942.1213cff4@gandalf.local.home>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240226115942.1213cff4@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/26/24 09:59, Steven Rostedt wrote:
> On Mon, 26 Feb 2024 15:09:38 +0900
> Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> 
>> On Mon, 26 Feb 2024 11:18:16 +0800
>> Yuanhe Shu <xiangzao@linux.alibaba.com> wrote:
>>
>>> While sched* events being traced and sched* events continuously happen,
>>> "[xx] event tracing - enable/disable with subsystem level files" would
>>> not stop as on some slower systems it seems to take forever.
>>> Select the first 100 lines of output would be enough to judge whether
>>> there are more than 3 types of sched events.
>>
>> Looks good to me.
>>
>> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>
>> Hi Shuah, can you pick this as a fix?
>>
> 
> Yes please.
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> -- Steve

Sorry for the delay on this. Applied to linux-kselftest fixes branch
for next rc.

thanks,
-- Shuah

