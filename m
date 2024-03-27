Return-Path: <linux-kernel+bounces-121615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DD888EADC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98E971F33A7F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB03012F392;
	Wed, 27 Mar 2024 16:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iUVo+lJ+"
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FD1130AC0
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 16:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711555982; cv=none; b=dXl3GkopkegCc+0ITXV0prOpvmgJKkLI6EvS509Kmnza2UF1on3UylEhyuSIif7MytVq65mPtN4HLzQkxHAoJ1AWdvcqG3K+CTqmYbo0gGUN/GUtmp0D5cabBqnQRsFKUz+VriVvio7soP3RTCcih6TPK7nPtRlpxnK9qC2RuZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711555982; c=relaxed/simple;
	bh=asmUPmQus7LUzQcer9/ecRHC+gd8g+NWqrc+D732lew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rwVcH19ell3DsUv9x0eg6OyhjsEA51Qe3KauFz3FJQlPfcOEuQMpXnTuT8MhTywgSaBsXuXfsmfcRwJPsUAGdeY1RoycYHhwhjItVuCbGd+voI/K3mwHts6nksj9VsOSMnflxZhko6wlbkWwo9gkt3hCZLCQxEQSgfa5VDFRaaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iUVo+lJ+; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-368539ef3dfso1645475ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 09:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711555980; x=1712160780; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XaFX9mxiKZDeQbSxmpDbkMXN0EZslMStzgRp5fvgfwQ=;
        b=iUVo+lJ+OGD2dVjA9AgVl7h0S4UG+4aAyIiSfE6iyqLC8bgCmxe9jad7ekE1zr7rfr
         AhudpwKeG46H8U6rYwaHYfRQKu2E+kFZPx+BZZOQPADz7OpXZv8jQbcuyFJBX8KzT5Gg
         9EFgib51pz67Js9WFJUrF6vy+djB5xkFpvPTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711555980; x=1712160780;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XaFX9mxiKZDeQbSxmpDbkMXN0EZslMStzgRp5fvgfwQ=;
        b=NhZ9P+sNQE5ALnNxwM+a5h7IXv60mFptVsOLPIkV+Lw2J4O/T313BSehYg/IoU/Z6h
         ZIu834DtJJ7s9fiZ3WigpTBretmJ341forh27bsc/xI1T2Aef+SnQb/JIO1fDcsD5iKp
         3OaXkvKfkPSLHj5zBPFF5M1IvsRtWBEVDbboitpbVZCVARmn6TM27CrDOTLzPSjCRsMt
         Hzep2SGE+Mjf80d6CUVYy1M514Xm25JvtLIXpnAFC5oeFV8Etyh8vO61O2xAFGLLMO7a
         H1/Kbuvtw06kdFtavy+ricdexpUVwD35zmnO0CZ3xVe4BwVa3ufXMx6R0TtdyQC9S2KI
         5HpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXU7IyL82c12YzCkC5Z56LAVJT6JnKBqzJQ2GtA2BJZEhWPv/wcmOZU93Wh5pkZ/Rh4DlIDN+gH8yjmtze9GZyU+O1PmNURphQH54Lb
X-Gm-Message-State: AOJu0YwD0lCGtTGsBGc1FlfYFgraXtR1QPyczRflFiAuz4zdwYw3jCvs
	OkrOA+x8bNHgd9CO52qd5tVNG/jzMAaA81XB3autI7H0gFztudp4kbFE9LXFYlI=
X-Google-Smtp-Source: AGHT+IEiXA6OtOY9zanEWliIGMGWJVj77uZLVHDmL258djEO4ZMAaUheobq2lblEoYMdKO5ZRdKtRA==
X-Received: by 2002:a92:d08f:0:b0:366:b0bd:3a1a with SMTP id h15-20020a92d08f000000b00366b0bd3a1amr436522ilh.1.1711555979887;
        Wed, 27 Mar 2024 09:12:59 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id r12-20020a92d98c000000b0036851cd6c59sm343584iln.1.2024.03.27.09.12.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 09:12:59 -0700 (PDT)
Message-ID: <3c8bcd55-3acd-4659-ab4d-567053049a7a@linuxfoundation.org>
Date: Wed, 27 Mar 2024 10:12:58 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Add Landlock test for io_uring IORING_OP_OPENAT
 operation
To: Dorine Tipo <dorine.a.tipo@gmail.com>, mic@digikod.net,
 outreachy@lists.linux.dev
Cc: "Fabio M . De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-kernel-mentees@lists.linuxfoundation.org"
 <linux-kernel-mentees@lists.linuxfoundation.org>
References: <20240327132001.30576-1-dorine.a.tipo@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240327132001.30576-1-dorine.a.tipo@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/27/24 07:20, Dorine Tipo wrote:
> This patch expands Landlock test coverage to include io_uring operations.
> It introduces a test for IORING_OP_OPENAT with Landlock rules, verifying
> allowed and disallowed access. This mitigates potential security
> vulnerabilities by ensuring Landlock controls access through io_uring.
> 
> It also updates the Makefile to include -luring in the LDLIBS.
> This ensures the test code has access to the necessary liburing
> library for io_uring operations.
> 
> Signed-off-by: Dorine Tipo <dorine.a.tipo@gmail.com>

You are missing linux-kselftest and linux-kernel mailing lists
when you send kselftest patches.

cc linux-kernel-metees since you are a LFX mentee

Adding missing lists
   
> ---
> Changes since V1:
> V2: - Consolidated two dependent patches in the V1 series into one patch
>        as suggested by <fabio.maria.de.francesco@linux.intel.com>
>      - Updated the subject line to be more descriptive.
> 
>   tools/testing/selftests/landlock/Makefile  |   4 +-
>   tools/testing/selftests/landlock/fs_test.c | 132 +++++++++++++++++++++
>   2 files changed, 134 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/Makefile b/tools/testing/selftests/landlock/Makefile
> index 348e2dbdb4e0..ab47d1dadb62 100644
> --- a/tools/testing/selftests/landlock/Makefile
> +++ b/tools/testing/selftests/landlock/Makefile
> @@ -13,11 +13,11 @@ TEST_GEN_PROGS := $(src_test:.c=)
>   TEST_GEN_PROGS_EXTENDED := true
> 
>   # Short targets:
> -$(TEST_GEN_PROGS): LDLIBS += -lcap
> +$(TEST_GEN_PROGS): LDLIBS += -lcap -luring

Check if .gitignore needs updates since you are adding
a new executable.

The rest look good to me.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

