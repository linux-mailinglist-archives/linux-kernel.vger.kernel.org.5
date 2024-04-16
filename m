Return-Path: <linux-kernel+bounces-147308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D54C58A7245
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6701F22AA1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7031332B6;
	Tue, 16 Apr 2024 17:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="T3Jz4KJm"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B25713280C
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 17:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713288485; cv=none; b=laWV4IDC2ozt4MPkguPaybRIh353H7VD+yMslGC3iN9Er+0IV17ALTOwpy3Vdne9PxeyLh8ZtLK6lW1al5PlEoK/oxBKIaXRrWMuRo9UANX2zCqoG+osQvuPHb0u4sonwcQghTbIeWdGKVUMBLH4UnfFZoPGndzIo0MMHhDkUcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713288485; c=relaxed/simple;
	bh=P9tX21C2H32XeRZpclyE1jUdcQxT5hx7EiLUM0Xs90o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvdWRHdi62cHm/MPFtbTyIvV3KVJMqby4rAD+LABt1Rb/wau2rgJGRKquPmCix3sYIg7092DJCrSmQ1XUOHY9SyZm4zQgFM6ta2e1kao96xYiU3UzolMd8rmsRg+GDydldOWf2Qf8P2qN0NYJUgnIlUOWq8pg5Ppc+VWj9TOxCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=T3Jz4KJm; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5cddfe0cb64so2677528a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 10:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713288484; x=1713893284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CbYixWM2CqQRL1wOMDrzHbCtgA+kuvvqBpiFHzx5mPI=;
        b=T3Jz4KJmnyq/mTIRQ0mnFEDpa8wKySv7YgYqQnu9UivT9y7iBBrKCtqCHQ9AwQcjcI
         46vAdaph0tV8XogvavUwHlrPVsiXkEa8VxHf4SauwBJFTdvRYB3+CFHAheCf4HilFJ2u
         iqGTZAHqZZto8HFgVIoteloaIQ3+r4azZG3YI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713288484; x=1713893284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbYixWM2CqQRL1wOMDrzHbCtgA+kuvvqBpiFHzx5mPI=;
        b=T1ZcPdWvn16MIvqKFaDAM3Y/37V72tncJLyjjrWOjiBfWJnJIblNZGL8wMkzd8Aaib
         AgLaldecYsnWInQK+ugPBMJXpri5yGyLe5U6EU+GhQh+JBRLJh0qGxLfg28r2vBK21nW
         /x4tfN2kZJTuHzwosDddYoeW+3BrirXexH/j18QYV0ZBnx1JyHOA21xW5Iu737AspTSq
         krf3uuFGrN/cMGwfY8bW11E1O6tyeqbzPYsUXgx0c8Dfb6b7dxuFEozfO1lo4jxKCgXK
         1BSdTL33s7jQDqDIBbbmzA4C9D3td58CbvZm6iOMt8H4GP9Ldf+1v0ewERvRMbdv0uOa
         kjJA==
X-Forwarded-Encrypted: i=1; AJvYcCXbkSLyjirOKr3BCBH6G/r9jHt19xtFUPTehIc9vR44ifzqgFPQWDPYIKaezqt08xPspAsZREOJ6oMLofVYRYqAuqT5npCMU0rnXPCG
X-Gm-Message-State: AOJu0YxGzEN38ghoBlPIgwmWxLxswaoDwyOW1te+m8UR3Z/h+38u7Zml
	ivEoOrdQBSa77LIiIkzsBnc0SBxf5uOp1TWS4jhzDkYy75RJCew3Qizd0OomJw==
X-Google-Smtp-Source: AGHT+IHbN76rCh1Qe3W01Nc2eeKTGXKJ8Gpa83X/WpafmSVHalfqd6xohNVPAcA7T0vL3gX2KQ5VZA==
X-Received: by 2002:a17:90b:3bc7:b0:2a2:672f:ef6d with SMTP id ph7-20020a17090b3bc700b002a2672fef6dmr10647646pjb.49.1713288483774;
        Tue, 16 Apr 2024 10:28:03 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h16-20020a17090a051000b002a2e4b593cdsm11862530pjh.51.2024.04.16.10.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 10:28:03 -0700 (PDT)
Date: Tue, 16 Apr 2024 10:28:02 -0700
From: Kees Cook <keescook@chromium.org>
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Shuah Khan <shuah@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yang Yingliang <yangyingliang@huawei.com>, kernel@collabora.com,
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2] selftests: exec: make binaries position independent
Message-ID: <202404161027.63F4D4FDEB@keescook>
References: <20240416152831.3199999-1-usama.anjum@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416152831.3199999-1-usama.anjum@collabora.com>

On Tue, Apr 16, 2024 at 08:28:29PM +0500, Muhammad Usama Anjum wrote:
> The -static overrides the -pie and binaries aren't position independent
> anymore. Use -static-pie instead which would produce a static and
> position independent binary. This has been caught by clang's warnings:
> 
>   clang: warning: argument unused during compilation: '-pie'
>   [-Wunused-command-line-argument]
> 
> Tested with both gcc and clang after this change.
> 
> Fixes: 4d1cd3b2c5c1 ("tools/testing/selftests/exec: fix link error")
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Thanks for this!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

