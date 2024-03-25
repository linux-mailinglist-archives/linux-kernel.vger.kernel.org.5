Return-Path: <linux-kernel+bounces-117684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CCB88AE65
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:34:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 790CA2A494E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294C55B5A6;
	Mon, 25 Mar 2024 18:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dtM7z5lh"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7DE29A0
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 18:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711390458; cv=none; b=fGZk3lSQxoxRqTe4Mp3ZcXSVZ9ugwIq3KqQS7tIoucKz7lLaVQj5v8NPCG7pjyp0JZgee/dSyQr0/Nnhjoh0bkDfc4pTxU3xKKVvI+KTWkcvFYX+gbuJSQnDmbYbHWSoSR5bH+PIr/vA9URMTWqCNLf0RQY5MQHXrsaz85hrznE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711390458; c=relaxed/simple;
	bh=6xj3eREHMBqw87b1bb5FAQJ7E59vrPblQ8gdNkMRsgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLSTvb4wdosYeG2fcLYa0h6kwVKaCGw1ZjaOv6NBxozDbpF2VKWstpm7Bg9f/MCd1QTVsTUq2tA/rxsKM5YVoXAEeQJwY9qQvTiE9AdgHEw+In8pUESksvBI9YizNCHoQDirxVG2E9y+wIUXrFEy5xgNij5A3mfwZItt61qee84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dtM7z5lh; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e0d82d441bso4695375ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 11:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711390456; x=1711995256; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lFLinlW0ir8IPFTfjDbZ7GfnDQ36jMrfkiPSgIoDlfU=;
        b=dtM7z5lh2z0fqC4DU4zNBJmf+ebmQL8b07Ohoe8uqgD/vLXG0kx8/06IqKMPbF2SL/
         hPC5kKJDo+UdbjQ7nHqzcGcIy6SCC9CJ48N361+Ap/Mu52F17vjCWyqLxbuZRkrkW+t4
         U/cJNWw+Xzy/If6kNkADAklY/2+zUeQIqnvIgObqa9nEXQd+1jCMcNEsdW86sUAQjQ6U
         xr25yy4XycDEcsKwKJPXMWUqTEh7HZ27xRzpLCrA06Shro9yterf9HXAkU5WYLM8gaaY
         jtT3l0UsPlJDcEX3M1bRD5jfzUDo7yZ6TwR84Qti9/z7V8tylF/uAVDtOSKoMNwy0GxY
         Ljfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711390456; x=1711995256;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lFLinlW0ir8IPFTfjDbZ7GfnDQ36jMrfkiPSgIoDlfU=;
        b=GhyaQu/mM72JwkRIYHv48AZMo9mSbm7mxa6eTEeWk3YSr+Tr4Nf0cDk86BxYYCoaF2
         HXH+r2oaE/MnE9dIYPCWrvdAjk4sUvHYBYvz9etBma57MfXpQcVoJDz3SLhOP96F1e2F
         L1NRx1n2YUhw+WRas2djw+a+ec6kIQDZKEexa49uJVenvWrhCjHEhIF7KzFJMdMSQQgB
         kKm/xukukXxpyXVw1LHh90KkeN4g+hyztsEkGSlb9bSr02DLnpgGdU/kJyUBoYP+Lhfp
         BPnfKhQk3AXDibaIrciinbOIggriCPD+i2ljD2usyBe/V+gdMD0FuE2C5ue+CrOUD9kt
         78Hg==
X-Forwarded-Encrypted: i=1; AJvYcCXd92a/HRPxeWKldKiJL9NChqFF9pHUaN2sBcx0aGGPQm7ayRQaf0VKVrqj7M0p57jmenwxyJhWpFs5DR0ALdy1yKGwEPlXZHxERbvn
X-Gm-Message-State: AOJu0YzBK6b5OOJwsy2UviJcd/hG1T7VWQ/h0utSF0lBesSTukoFXhFN
	31hCwKdsesTOEKtJXPRbeJBDjhz54PqbEeMZoDsmPn/7BPM24SCesKfWdCOCfw==
X-Google-Smtp-Source: AGHT+IH1Q0j9FLcWxX/yBRNNnxq6h37S48bdtQ+O3PZdJqg/oaidTl7D5R/z1SlHaHzX6l1Rib60PQ==
X-Received: by 2002:a17:902:e746:b0:1e0:b54d:8ca5 with SMTP id p6-20020a170902e74600b001e0b54d8ca5mr6637708plf.66.1711390455573;
        Mon, 25 Mar 2024 11:14:15 -0700 (PDT)
Received: from google.com ([2620:0:1000:2510:216e:aba9:9550:56ab])
        by smtp.gmail.com with ESMTPSA id x20-20020a170902821400b001ddd0ff99c6sm4968255pln.139.2024.03.25.11.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 11:14:15 -0700 (PDT)
Date: Mon, 25 Mar 2024 11:14:10 -0700
From: Sami Tolvanen <samitolvanen@google.com>
To: Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
	Palmer Dabbelt <palmer@dabbelt.com>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	florian.fainelli@broadcom.com, pavel@denx.de
Subject: Re: [PATCH 6.7 000/707] 6.7.11-rc2 review
Message-ID: <20240325181410.GA4122244@google.com>
References: <20240325120003.1767691-1-sashal@kernel.org>
 <56d3285a-ed22-44bd-8c22-ce51ad159a81@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <56d3285a-ed22-44bd-8c22-ce51ad159a81@linaro.org>

On Mon, Mar 25, 2024 at 11:43:48AM -0600, Daniel Díaz wrote:
> Hello!
> 
> On 25/03/24 6:00 a. m., Sasha Levin wrote:
> > This is the start of the stable review cycle for the 6.7.11 release.
> > There are 707 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Mar 27 12:00:02 PM UTC 2024.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> >          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.7.y&id2=v6.7.10
> > or in the git tree and branch at:
> >          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> > and the diffstat can be found below.
> > 
> > Thanks,
> > Sasha
> 
> We see *lots* of new warnings in RISC-V with Clang 17. Here's one:
> 
> -----8<-----
>   /builds/linux/mm/oom_kill.c:1195:1: warning: unused function '___se_sys_process_mrelease' [-Wunused-function]
>    1195 | SYSCALL_DEFINE2(process_mrelease, int, pidfd, unsigned int, flags)
>         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   /builds/linux/include/linux/syscalls.h:221:36: note: expanded from macro 'SYSCALL_DEFINE2'
>     221 | #define SYSCALL_DEFINE2(name, ...) SYSCALL_DEFINEx(2, _##name, __VA_ARGS__)
>         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   /builds/linux/include/linux/syscalls.h:231:2: note: expanded from macro 'SYSCALL_DEFINEx'
>     231 |         __SYSCALL_DEFINEx(x, sname, __VA_ARGS__)
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   /builds/linux/arch/riscv/include/asm/syscall_wrapper.h:81:2: note: expanded from macro '__SYSCALL_DEFINEx'
>      81 |         __SYSCALL_SE_DEFINEx(x, sys, name, __VA_ARGS__)                         \
>         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   /builds/linux/arch/riscv/include/asm/syscall_wrapper.h:40:14: note: expanded from macro '__SYSCALL_SE_DEFINEx'
>      40 |         static long ___se_##prefix##name(__MAP(x,__SC_LONG,__VA_ARGS__))
>         |                     ^~~~~~~~~~~~~~~~~~~~
>   <scratch space>:30:1: note: expanded from here
>      30 | ___se_sys_process_mrelease
>         | ^~~~~~~~~~~~~~~~~~~~~~~~~~
>   1 warning generated.
> ----->8-----

Yup, I can reproduce this with ToT Clang. It looks like the alias
isn't sufficient for Clang and we need to add an explicit __used
attribute. Can you confirm if this patch fixes the issue for you?

diff --git a/arch/riscv/include/asm/syscall_wrapper.h b/arch/riscv/include/asm/syscall_wrapper.h
index 980094c2e976..ac80216549ff 100644
--- a/arch/riscv/include/asm/syscall_wrapper.h
+++ b/arch/riscv/include/asm/syscall_wrapper.h
@@ -36,7 +36,8 @@ asmlinkage long __riscv_sys_ni_syscall(const struct pt_regs *);
                                        ulong)                                          \
                        __attribute__((alias(__stringify(___se_##prefix##name))));      \
        __diag_pop();                                                                   \
-       static long noinline ___se_##prefix##name(__MAP(x,__SC_LONG,__VA_ARGS__));      \
+       static long noinline ___se_##prefix##name(__MAP(x,__SC_LONG,__VA_ARGS__))       \
+                       __used;                                                         \
        static long ___se_##prefix##name(__MAP(x,__SC_LONG,__VA_ARGS__))


Palmer, how do you want to handle the fix? Should I send this as a
proper patch?

Sami

