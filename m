Return-Path: <linux-kernel+bounces-84261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4400586A44A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70F7D1C23F7D
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A5F23B0;
	Wed, 28 Feb 2024 00:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D2Gb4ltS"
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86C37E8
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 00:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709079022; cv=none; b=FAAgkv+VbahnNxKc0Q49T9G8GZvFoL/ByQ0+DQL1Vee6re47e7AFo65owIq1wdwfFY2VTai0dQqa+I96JQYpjJQTrVHmT+Eh/poBaDHqwGxNWF80jbHPnyu+xO0Mt+xb8QKsjje5bOGdfpdQeRYnJ2QJHPi3RQ6wveN4e87R92Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709079022; c=relaxed/simple;
	bh=7Bibe+mApP2qw+Bwb89kIz1Vorq4HcJl2XyOfxCc+rI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C7mkxFNwsCaU4LgRpiBA5JI8k6T8zDOWMdsw4unXepJFJzbC6zJMOiXbhfioNwlH+qTz7Ws9l0mFpP8bhiEosk08N6amhRuP1cvIf/RFhwt/L9nV7+1SY2o2doK1LQYK3aHXXFi2q/2u58zfifgE+qXBkyITuUf2BW0LhRyUL60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D2Gb4ltS; arc=none smtp.client-ip=209.85.166.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-7c49c979b5dso99271539f.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 16:10:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1709079019; x=1709683819; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3uNCkE/Y4bucRwr/vs7c1ruuOADEG13u7lr08BZ4VNA=;
        b=D2Gb4ltSZBbw7GNcjBZZWXuvkDuJasDEjNQU6jiVVhbDbapAbLVi1ryZZx7vIM+Zhw
         DBaNdui24vVhN05VovPFFOC3VWlaiuW37K4tgOhoAFGc/2tHOoiisBmZk6rGFd2AYnrY
         7NlS96wYAGJd51AiEkVGeOB1wGejgP6BoGtfA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709079019; x=1709683819;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3uNCkE/Y4bucRwr/vs7c1ruuOADEG13u7lr08BZ4VNA=;
        b=VpFsE/MCnKW8CtJUccKDOAIGLBKmDPgoXo2Ta6lRayGFJWz1TO1F7BKKV/Gho1rSFP
         db3z9XKYgeiIO4E5lvJdoFPi3GuhfqEy9AItvW74FUy2Iuuw664/22BixggiYlkA+qnH
         k3GIIHzajoyjMlOPQf5izwpSGDAaYBsUWjPCsR6avxexS/fOoe5TKuf0AsAGv5rNPKmX
         G6fVhexPcaCOIHBGcVZTFHYrPw/jCBw+07g7lzSulrPv+g5ZZKd3baOEp4rP1uDpeM1A
         pi2iabLnL0OtgIZN+DWGu48zdAF/SJLtJ5yeL0XV/vaQ47TtkBDKhDOJJHPePlQDgwA6
         aSJA==
X-Forwarded-Encrypted: i=1; AJvYcCU6cPPP3k8pJ2tK4bO5KsbAGV2qjY5JYCG/G4WrxA0HED/dDPkiUDMYyYiOV0u300zyNJhm8LAJtyywxMhSY6YNqJz2jIsCLzB9GZbF
X-Gm-Message-State: AOJu0YxWZthu1ZfxbBPOo/QJQV8QZYS14m5OfI01Z+cbfsV8y4JTqSxr
	RB3rdeBiZi4K0TFaZ0OsKcqEN4vVDKt7FMTYC910Rq0LQZk3MKFILpvv0T7iC24=
X-Google-Smtp-Source: AGHT+IGrxhuv2/vozEcMAJsAG2BL6qpv5diYWB6ZxOntrxwP6jDQRasA2qEhpJhFBGgL0WngloEcfg==
X-Received: by 2002:a05:6e02:20e4:b0:365:1967:e665 with SMTP id q4-20020a056e0220e400b003651967e665mr11415974ilv.2.1709079018924;
        Tue, 27 Feb 2024 16:10:18 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id x14-20020a056e020f0e00b00364b66eb5e3sm2427560ilj.24.2024.02.27.16.10.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 16:10:18 -0800 (PST)
Message-ID: <76d006e1-aeb1-4622-aa9e-6bf4101a4e15@linuxfoundation.org>
Date: Tue, 27 Feb 2024 17:10:18 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Improvements to livepatch kselftests on top of
 kselftest-next
Content-Language: en-US
To: Marcos Paulo de Souza <mpdesouza@suse.com>, Shuah Khan
 <shuah@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>,
 Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 live-patching@vger.kernel.org, kernel test robot <lkp@intel.com>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240221-lp-selftests-fixes-v2-0-a19be1e029a7@suse.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240221-lp-selftests-fixes-v2-0-a19be1e029a7@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/21/24 10:17, Marcos Paulo de Souza wrote:
> The changes on lib.mk are both for simplification and also
> clarification, like in the case of not handling TEST_GEN_MODS_DIR
> directly. There is a new patch to solve one issue reported by build bot.
> 
> These changes apply on top of the current kselftest-next branch. Please
> review!
> 
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
> ---
> Changes in v2:
> - Added a new patch to avoid building the modules/running the tests if
>    kernel-devel is not installed. Resolving an issue reported by the
>    build bot.
> - Reordered the patches, showing the more simple ones first. Besides
>    patch 0002, all the other three didn't changed since v1.
> - Link to v1: https://lore.kernel.org/r/20240215-lp-selftests-fixes-v1-0-89f4a6f5cddc@suse.com
> 
> ---
> Marcos Paulo de Souza (4):
>        selftests: livepatch: Add initial .gitignore
>        selftests: livepatch: Avoid running the tests if kernel-devel is missing
>        selftests: lib.mk: Do not process TEST_GEN_MODS_DIR
>        selftests: lib.mk: Simplify TEST_GEN_MODS_DIR handling
> 
>   tools/testing/selftests/lib.mk                        | 19 +++++++------------
>   tools/testing/selftests/livepatch/.gitignore          |  1 +
>   tools/testing/selftests/livepatch/functions.sh        | 13 +++++++++++++
>   .../testing/selftests/livepatch/test_modules/Makefile |  6 ++++++
>   4 files changed, 27 insertions(+), 12 deletions(-)
> ---
> base-commit: 6f1a214d446b2f2f9c8c4b96755a8f0316ba4436
> change-id: 20240215-lp-selftests-fixes-7d4bab3c0712
> 
> Best regards,

Applied all except the last patch to linux-kelftest next for Linux 6.9-rc1

thanks,
-- Shuah


