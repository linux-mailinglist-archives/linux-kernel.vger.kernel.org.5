Return-Path: <linux-kernel+bounces-81271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D648673E5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBB59B2A27C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540A6339BC;
	Mon, 26 Feb 2024 11:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="K++EOJnY"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1672D029
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 11:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708947242; cv=none; b=lRNHobTX+A8EN81D+x6hiJngJoFd1ug0QmSbTBvQBa59pw6aQUaIdzWh62ylumXFOU6FHVdqLOqswhkEaF5QT1GFaUlSfWFovKaKSySxaL7oglkIyQ6pQNOKcQ+JWc5E05wergWAuVIGGqsuJMVK+u52U368bUuWrZ6qmtD0Pco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708947242; c=relaxed/simple;
	bh=d0kydW1Yxuo1MsG4YJurMo9qxI32GA5maZXnljWXEGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kXDf+TIhI5okrt2UmEYReU2uQZfHbfFjXm0EkaKe/fBrOHrlt07x10OOxPVnA9ePReofmr0WvlQWq1adeK/1lGztXMVo3qwK8DxDQ7z9LXNY9q5IdlqoP8ic3rF92TYK7xaHisWY6eTCtJogoljZCx3GFGgnUgCNvQj14UWin70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=K++EOJnY; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e332bc65b3so1416964b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:34:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1708947240; x=1709552040; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wdsp0gMDY9ztgsqYmpfOLfIwYX7WF34YfJrpayCYhWs=;
        b=K++EOJnYUCNPr0CYwYChswGetVdU8ZYqtdMelvpfIiCYLsZX0Vr+hv2l9zThbiPMS2
         eC+7nM4BgXJHsFYUAwQGgNJQd1ImXPUaoKNmxqZBjMBb/cL5nwnSPk9sugyb5Jo9N0e7
         fO+aV0SBAPxcPvaS3K+r6zPDOuOCGquieNrtKW9cyk0Uu0iZnpwKkD+u901UbKwWewi0
         gtNspoHsbDKSD8IDtghmjEKoz0LoSNWpIM7h72iRbczvkBqiF6PLOxFOPFMLgLawdPG0
         21nMkvT3gBd7dYJhCHXN1jvperYQAl3FM0XWBQ4ih+Zea8zFIWSJ/PRRbRkyTLMERdRh
         rnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708947240; x=1709552040;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Wdsp0gMDY9ztgsqYmpfOLfIwYX7WF34YfJrpayCYhWs=;
        b=a91Ba97OU8wEZ6MPyFJ3NH1g1J2a2UEyC6a5Wi2hFRTC8ZUzxLZSECE43rHkLC2sLf
         vw5Gu9nRp1x83ezmqacVBzSr55XeMR0SU2a5SB9M64avv4FgfhYJpli9IsMADnatX+OI
         fo04c9FIJop6cyrs15TvP+aIBY9LnItcUnyHRWVRkpRLizV3QZceTalMGdeLqwWFEpjD
         IxMAnBBBEt3Zws9mExnGvZmZSeGmixM8rPoVlBWQtZHczkGZgxuAOglUuGC14/iEGBkR
         4SotXS0z5Q54QCjsh4XVcWh7DCr3fT5dAe5dPeDUwCMo9BfQGsjFcGpmN3Lai92G1pf0
         XhDA==
X-Forwarded-Encrypted: i=1; AJvYcCUrA7PLYu1EqrSoIkZbEIRK44htsNIR06xUxZsWHmSu3N6hCPckf8xSKfVoR9ZotKa6y4EJWzh5ZRiu3eOC/z3Fv6Y8tJjfYJM55Ev9
X-Gm-Message-State: AOJu0Yx5Tl1wH8z5fxR5fdFm6CRKDTTnEhtD9VErY1nujAzT9P0SYiiZ
	j9W9N5Jeb8smxuVYxPGR/DUA7eEaD5s56YzsVQEk0iqkHWerzc4FQ1WiaPb4pkA=
X-Google-Smtp-Source: AGHT+IFrqop9IWtx6Qj69nWqO1n/SWu8DT5ggnEUyrLz2QTvgJxjukIRIrGPsQX+Am24ajuetLPWRg==
X-Received: by 2002:a05:6a21:1693:b0:1a1:3dc:6686 with SMTP id np19-20020a056a21169300b001a103dc6686mr801467pzb.59.1708947240327;
        Mon, 26 Feb 2024 03:34:00 -0800 (PST)
Received: from [10.74.73.182] ([203.208.189.12])
        by smtp.gmail.com with ESMTPSA id d20-20020a170903209400b001dc95205b56sm2320016plc.53.2024.02.26.03.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 03:33:59 -0800 (PST)
Message-ID: <f516eb83-c393-af67-803f-4cf664865cf8@bytedance.com>
Date: Mon, 26 Feb 2024 19:33:53 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 0/3] Support intra-function call validation
To: bp@alien8.de, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
 jpoimboe@redhat.com, peterz@infradead.org, mbenes@suse.cz,
 gregkh@linuxfoundation.org, stable@vger.kernel.org,
 alexandre.chartre@oracle.com
Cc: x86@kernel.org, linux-kernel@vger.kernel.org
References: <20240226094925.95835-1-qirui.001@bytedance.com>
From: qirui <qirui.001@bytedance.com>
In-Reply-To: <20240226094925.95835-1-qirui.001@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

This issue only occurs in 5.4 LTS versions after LTS 5.4.250 (inclusive), and this patchset is based on commit 6e1f54a4985b63bc1b55a09e5e75a974c5d6719b (Linux 5.4.269)

On 2/26/24 5:49 PM, Rui Qi wrote:
> Since kernel version 5.4.250 LTS, there has been an issue with the kernel live patching feature becoming unavailable. When compiling the sample code for kernel live patching, the following message is displayed when enabled:
> 
> livepatch: klp_check_stack: kworker/u256:6:23490 has an unreliable stack
> 
> After investigation, it was found that this is due to objtool not supporting intra-function calls, resulting in incorrect orc entry generation.
> 
> This patchset adds support for intra-function calls, allowing the kernel live patching feature to work correctly.
> 
> Alexandre Chartre (2):
>    objtool: is_fentry_call() crashes if call has no destination
>    objtool: Add support for intra-function calls
> 
> Rui Qi (1):
>    x86/speculation: Support intra-function call validation
> 
>   arch/x86/include/asm/nospec-branch.h          |  7 ++
>   include/linux/frame.h                         | 11 ++++
>   .../Documentation/stack-validation.txt        |  8 +++
>   tools/objtool/arch/x86/decode.c               |  6 ++
>   tools/objtool/check.c                         | 64 +++++++++++++++++--
>   5 files changed, 91 insertions(+), 5 deletions(-)
> 

