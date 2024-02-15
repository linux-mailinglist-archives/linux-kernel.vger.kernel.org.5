Return-Path: <linux-kernel+bounces-66948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD578563E7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEEC628A038
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6B412F392;
	Thu, 15 Feb 2024 13:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XRSmcQyy"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2FF12BF06
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 13:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708002143; cv=none; b=UDv5XSN/QpBfg5MHssJLS1mWRwqYt5mL5Ns+z8V957Tt9tH/M12cPJgWaDVYluMzMJKx/Q3kw0M7ATSTO28NPTvEKwh4JU9XOzfBgEQnj6HJwMP8+nQkJERSEophDb5RrqXIxaontQGgFyhjoDWR/8V5ppPbfFNOYuAm4tnf2MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708002143; c=relaxed/simple;
	bh=2agPtJl3v9niVpIiQlLbesjxGfDjfBKYPIlmRtWAQQg=;
	h=From:To:CC:Date:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=aB9SuiqwI34tsVb8KlIwt21zzxUGJ0+LcWuhGeecIXRkQoeDU/9b16peQ7SEDCv7Nv0/EB5gy0niPFqzPX0NTqjoFL3H3oHPzeN1E+SDbQcO2b+Ycu8O6flw2hyVnB6ePUfVB4Y/qjQ4eSxXCgqvZuECygzex0xppPxSEHKYQww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XRSmcQyy; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-783f553fdabso52883785a.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 05:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708002139; x=1708606939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2agPtJl3v9niVpIiQlLbesjxGfDjfBKYPIlmRtWAQQg=;
        b=XRSmcQyyL03rLtS3VvikblzeXgnjVle+cPooHiMTpSqCYxGtdPogrYx4e94aLpG9a3
         mlPF6S095uzEPFaMh9eFHLt94D2qehvCLO7K5ePpMlXpdwLIHxcIAw/B/6BVUcvvsbs6
         kDsTaaCyES02fsNI4BdSVAd97sEhNNOzCt9J3QibrU/NAfdPoSri1w3GjLTlhI/tkERt
         btBHYvk61sr3HPK0IxUbuBMDPBQ+xfUxxG8dvHUgjqPHmRdjwVQAVuxBOE3jePArorqF
         80mtq8ST85jd5p20eubUPllgeOC/EAWE/Fhps98X8n+YTCaXL5XQN6Ep4GNHVWWR+0N2
         di4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708002139; x=1708606939;
        h=content-transfer-encoding:mime-version:subject:user-agent
         :references:in-reply-to:message-id:date:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2agPtJl3v9niVpIiQlLbesjxGfDjfBKYPIlmRtWAQQg=;
        b=H9CoBtwiFwPrJylc5JKLEyKf+zuPcTIL67SZ7bpgQdDHC2OBTmygBgMQGeZJt0t69M
         J4UR27tJznAcqGsJO6oPWaTXCoP3OdPLB8/Q2glJaCCPvN/1gOf9JrbeuCth+ILHv056
         Kh5Di49OVQ4Sl+nZWfonYRFLdlNa6Dy1DW7STgZMJqALi0YGDZHbYLhPNQ8Ych/wxsbg
         N/n1OF4RtJPPUunVTeNIe659eJ2peXToGYdyOPkqfhoEHZM1phabQ3Pv1w0e2q9rJlG5
         9ND3nKyBzAG8X1dny98hjpeY+xcNv3qRDD1S+Nxdghrg7xhG/jbvUSuNatQxtqfw5GRp
         G1hQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKTq9/Ro+VjuWHU08cYJtbqKJ5H1WciDgQPtE5H78TvzDc8UM9ZJDxNBVlx5qNipJH10OjgmYsFuvL1/zJ01Neq+vtDUcgRWEN/E4A
X-Gm-Message-State: AOJu0YwCetZqlHlEqy+d6dVFig+JafE77V/8zMswBECci+t7SDLxTf1J
	Kk80REZF0+YwScZCqPmEcE71Ef/mN8m3/s+h4SDMgnIwRLeBOuV/MCbRidz5mg==
X-Google-Smtp-Source: AGHT+IGXRXkvIjtM2XptNphgmbdrAs5LHYnEl5lJFcxgwonSt9iT8GNqc5kaY+tfx3dBMBTZqxQN6g==
X-Received: by 2002:a05:620a:1d:b0:787:2529:6073 with SMTP id j29-20020a05620a001d00b0078725296073mr2061569qki.6.1708002139428;
        Thu, 15 Feb 2024 05:02:19 -0800 (PST)
Received: from [192.168.7.16] ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id i6-20020a05620a248600b0078723db4da9sm570760qkn.98.2024.02.15.05.02.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Feb 2024 05:02:19 -0800 (PST)
From: Paul Moore <paul@paul-moore.com>
To: Kees Cook <keescook@chromium.org>, Casey Schaufler <casey@schaufler-ca.com>
CC: Jann Horn <jannh@google.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, John Johansen <john.johansen@canonical.com>, <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Date: Thu, 15 Feb 2024 08:02:18 -0500
Message-ID: <18dacdbced8.28a4.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <202402141644.808307E71@keescook>
References: <20240214160538.1086089-1-jannh@google.com>
 <a4a77e0e-8d5e-4c9d-aff4-9fe0d8b89cf0@schaufler-ca.com>
 <202402141644.808307E71@keescook>
User-Agent: AquaMail/1.49.2 (build: 104902408)
Subject: Re: [PATCH] security: fix integer overflow in lsm_set_self_attr() syscall
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On February 14, 2024 7:45:43 PM Kees Cook <keescook@chromium.org> wrote:
> On Wed, Feb 14, 2024 at 08:53:52AM -0800, Casey Schaufler wrote:
>> On 2/14/2024 8:05 AM, Jann Horn wrote:
>>> security_setselfattr() has an integer overflow bug that leads to
>>> out-of-bounds access when userspace provides bogus input:
>>> `lctx->ctx_len + sizeof(*lctx)` is checked against `lctx->len` (and,
>>> redundantly, also against `size`), but there are no checks on
>>> `lctx->ctx_len`.
>>> Therefore, userspace can provide an `lsm_ctx` with `->ctx_len` set to a
>>> value between `-sizeof(struct lsm_ctx)` and -1, and this bogus `->ctx_len`
>>> will then be passed to an LSM module as a buffer length, causing LSM
>>> modules to perform out-of-bounds accesses.
>>>
>>> The following reproducer will demonstrate this under ASAN (if AppArmor is
>>> loaded as an LSM):
>>> ```
>>> #define _GNU_SOURCE
>>> #include <unistd.h>
>>> #include <stdint.h>
>>> #include <stdlib.h>
>>> #include <sys/syscall.h>
>>>
>>> struct lsm_ctx {
>>> uint64_t id;
>>> uint64_t flags;
>>> uint64_t len;
>>> uint64_t ctx_len;
>
> Do we want to take the opportunity to reduce this to u32 for len and u32
> for ctx_len? All FS operations are limited to INT_MAX anyway...

Not at this point, no.

--
paul-moore.com




