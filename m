Return-Path: <linux-kernel+bounces-57745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 746A384DCEC
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:30:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A77F11C2677A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136106E2CB;
	Thu,  8 Feb 2024 09:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="nTxFGSMg"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11936E2D9
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 09:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384399; cv=none; b=der5cKDhGtEf3YccJSVrsBrQnyLeklgs0l48FWpLArds1189n6sLLVeZ4SbNgfpIrZ992fCechbO+iLWgx1fvR24F8YP+Z3Md44DzJOTygRDVXPO3qIjRmPcrHeugPBGbqR7WDHgG79NNeCDtTJmQYYsJNDlvOT9k+Cfh2f1WMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384399; c=relaxed/simple;
	bh=UWeQJCER8zXhqPwH0OuvxMry3m1VwMFBmLt7F6/2HpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n/ZB3rIJvm3JuVuipaEJoCKxnaI09yGAJXO5koP9uhAqgtiGZk23Vy20XK1uIll+pZ9SaN7NqNmXnN0nzrog0T1tcIMPK7GqFStuZMaU881Blt94Om7oC+lZpGPsIplKVk5n1Ky7ru/Wgo9zbtSGOfJTItm4PMG3PuKfaTHTsNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=nTxFGSMg; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-68cbddc476dso7873826d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 01:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1707384396; x=1707989196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VQR/FZR/rxXp/GDaSedW04oA7HUPwpCfLl/D3NpRt64=;
        b=nTxFGSMgFTXXk+jHeqf7uY4CjELRNnaJBy+Di+APkIOOtisSsE5DeIeu2NAsF56yXl
         5MqC9edFM+FbBobmIazEdbiGHFkO+U/L1wHDavaXmaMtYtBfxQ4vm8g+vmUdEHIonIBB
         3M8m1ZWS8Fa4N1oChYcgE6rGtGvhySg6Zl02s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707384396; x=1707989196;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VQR/FZR/rxXp/GDaSedW04oA7HUPwpCfLl/D3NpRt64=;
        b=Ovu9omUY++VfU7xHRewiMaIeaL2YscSb87aZCdfSFmqBKz1GTyBDxa7hoES5uo2fgr
         UuqxR+Qe8yMmxFzINlB/oFG0UOSqDTiq/KCDzcBTveXjS+R1ZCJGN6Nvi1eZ7mWZw5M5
         fb6WT1RNlIz8aYrkDXG4dAUS5viWMfi8PIgsV0KGbzYTGmhKxByAEfKigcSntn4+Vjcu
         cTMXCO7mIC/2E3k5T4x3DrMAp43+1hhtdwa5w9kbAceCXs37i1YL9eUgaIknGTe/wxqP
         S17BA4L69t8LrHvhyonQkRCMHChF+n87GmgSF439/Q8Zqmcaj6OMt6hi7NJpZrUNZ1Ox
         H72A==
X-Gm-Message-State: AOJu0Yx+GEOJO+jhzCbhTaoInmD/z2kql50exJR0SSrY8NExlM+zdwA2
	F4O9XQMWPT88K4BzZk+nM7sEclQmHthXNxlQ1hLy8MEixok5WJ7l+eEt6F8rfl0=
X-Google-Smtp-Source: AGHT+IFyQqY/XMxLBi2+dW1HrhIyrQBgWWK6z36X0AV/vyVfmePVfHf89Cci4NiwIgBgMn8BTIQSjA==
X-Received: by 2002:ad4:596a:0:b0:68c:87ed:ef36 with SMTP id eq10-20020ad4596a000000b0068c87edef36mr8957401qvb.29.1707384396330;
        Thu, 08 Feb 2024 01:26:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWGEJIadMuHTt7Jw2f7HfK54uZfZvBAKdjJMHuqaJU+VzV0d0j4E0vrLDjLQwxeTE4zgd9d4LJqCxQ34ZSxxQDEMRMgwVAwPoUk2+BA9Y55cZ//dagNPc6ssASYAs5wRizJ1vGyZ5AgUbvFTzAzWaqIROCdt2PazC9Hyozi7/iVjw9nFGIbVC2b77pjYwNZyFGVIvIAonO+F3cpbMHS5wV0BTupRfrjQLpLst5Z4g0VcJyHhcJMia/WbhSqhH9AUHk879BylgJABR4eQCY8BkXqfGplm4yjxnBcb55ojyK1LoIHpCZOt8Tl2QaeKUy9cduhfR+be/8xU/yF0OgbssQjtxpW9wmI+yzcK4Bdm4vidAOMmvbYgWzYQjI1JrPe14rNtS0ZjCETxZrmxPv4p9Y6jJZyufAfZEyTg1460vrjJ9aqIOf6fFhjluO5ols3ys8pyZTgSUtSoDYyaB6FIkC16bfZDQ4nniMnywP/IGxRgKFUqLZE23LALf/Dq4MRuKg6b0ztq1iBSq8xTow8yKRNAoXQIOV5/cEAewsF66hZHnh52TYx7U09gRJrdGm8kptD4Kae03uBgxSXspUaDxHEPyGKUQ/PV66GlLEBc/rXQVyVg2o=
Received: from [192.168.0.226] (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id ph30-20020a0562144a5e00b0068c6dd9af10sm1407729qvb.64.2024.02.08.01.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 01:26:35 -0800 (PST)
Message-ID: <497fdb48-9fce-444e-8d51-2073a37f697d@joelfernandes.org>
Date: Thu, 8 Feb 2024 04:26:30 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] tracing: Support to dump instance traces by
 ftrace_dump_on_oops
Content-Language: en-US
To: Huang Yiwei <quic_hyiwei@quicinc.com>,
 Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mark.rutland@arm.com, mcgrof@kernel.org,
 keescook@chromium.org, j.granados@samsung.com,
 mathieu.desnoyers@efficios.com, corbet@lwn.net,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
 quic_bjorande@quicinc.com, quic_tsoni@quicinc.com, quic_satyap@quicinc.com,
 quic_aiquny@quicinc.com, kernel@quicinc.com,
 Ross Zwisler <zwisler@google.com>
References: <20240206094650.1696566-1-quic_hyiwei@quicinc.com>
 <50cdbe95-c14c-49db-86aa-458e87ae9513@joelfernandes.org>
 <20240207061429.3e29afc8@rorschach.local.home>
 <CAEXW_YSUD-CW_=BHbfrfPZAfRUtk_hys5r06uJP2TJJeYJb-1g@mail.gmail.com>
 <ec99fdee-8d3f-476f-842f-f57b2b817dae@quicinc.com>
From: Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <ec99fdee-8d3f-476f-842f-f57b2b817dae@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/8/2024 4:22 AM, Huang Yiwei wrote:
> 
> 
> On 2/7/2024 10:13 PM, Joel Fernandes wrote:
[..]
>>> Perhaps we need an option for these too, and have all options be
>>> updated via the command line. That way we don't need to make special
>>> boot line parameters for this. If we move these to options (keeping the
>>> proc interface for backward compatibility) it would make most features
>>> available to all with one change.
> It's a good idea that "traceoff_on_warning" also has instance support, but we
> will use another patchset to do this, right?
> 
> And for this patchset, shall I fix the typo and resend again? Thanks.

That is fine with me but it is up to tracing maintainers. ;-)

 - Joel



