Return-Path: <linux-kernel+bounces-160622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4A38B4032
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9072C1C22C41
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1604218C36;
	Fri, 26 Apr 2024 19:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Hil+eIBn"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B082231F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 19:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714160437; cv=none; b=dcz24yNDNsTuTiht9bryXvck4U4x//RMZkrUX1j2TssOiN6pjE6J1rUOY/Aa2NqUNtc8XUl5aVoOleauqQKixn1bPBez9O1k7G8yrHg3aIz+7WNCaOZp/TY6ICTya8MIiNajpvkmYgFc+UU7iSvOJJDjTs82Qy3K2Sh9/hhGafo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714160437; c=relaxed/simple;
	bh=LcwyKWwPX6z34F0Gb9soBrF9DmV/UB27hHsQADFPmmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMJY0ZU/oADhDRYG4BCzvgkSGhsIQBCfjYf5XFUF7vVGFUqfxFMISXgwpDjTzkOrXfOqCVB4ypdBSP0b4iRbng7A9AdesMXiP7t7cBvhsOuIKpPJl+sNo7A7XzbLp3t82bFsNDI/FDql0XO1dkiDAXhtXe4C+9PXYckAfmZqqhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Hil+eIBn; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6ecff9df447so2540036b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 12:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714160434; x=1714765234; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KLztx8KYJnj7bEhi+e9Rs8Zsig7zBXXhW5ZdjWyfVfw=;
        b=Hil+eIBn1mLXz4OMGsRwfez3O9X0dkL7bAZBdzqaT8xBBAUOznEMC4VkJjMThUbDi6
         JyJeyXLFw3+2ojVolbnlEyCs5IVmLnh0qKDyb7Yy3mefTDlcR9J9Q8yUGmBhsi3s2TB9
         A4HdofcnvmaZF8MjpDxO2PWLmMA/rLchMR6VY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714160434; x=1714765234;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KLztx8KYJnj7bEhi+e9Rs8Zsig7zBXXhW5ZdjWyfVfw=;
        b=KyPIFY8oDu0j2x0Jh86N4pwQGzhQqnLI6eNNDJzYp4kT3ePmLwFvDC+fDAteagz1Ec
         zVh5oANh9IoWfZT0M0YC2fCkQ9UBWqP7tLWJZvQmooR4A+/UHnwwibavTWk5E77jCT+H
         Ba5VUTVx3W3lU/A06Hf3MUJ0psvy1WoAKngwafR80+bJC93MBhkD6kstYbQK9oLF55IB
         WdS3oW+yq6bxgBjxLdRo045MB8SlCgnq7+BnVbTulPZcBqrDooiwxf+R/AMNLv+XSGuC
         oP9GqfsO9IwPd/+SHJuYx6lFygjT+LWt6vTAx1bKb4kDs8CGJIt49Irei+kBl9KV0oAT
         ZXPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIPBvSjNtuk29qy2qas6BAFyiwMRL+rTKG0WAxg1owpD6Kiejue+x7aItUQovqwxZRUC2xdsJ5kBgXpedYKLdjvKuDQ4ra7yP0qHzE
X-Gm-Message-State: AOJu0YxEHBfQFLYY3goUFFGrg7b8a9E0hVSqE2UxIaGIx7BGQ2w1Fl+Y
	yPAZanS9W4D/iGQO7XVL380NIZh0pU/9FppN99TPIxXLRKvzgwiow1yOph9kJg==
X-Google-Smtp-Source: AGHT+IEVck8/DhxISBA3th436oPnjrKXPkbS4uqXM8nzquMCPo0gI3q/3yYVFDOH76WDU9eJlzL8Kg==
X-Received: by 2002:a05:6a00:22ca:b0:6ed:8798:3fa3 with SMTP id f10-20020a056a0022ca00b006ed87983fa3mr4863802pfj.15.1714160433840;
        Fri, 26 Apr 2024 12:40:33 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fc4-20020a056a002e0400b006eb058b2703sm13561886pfb.187.2024.04.26.12.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 12:40:32 -0700 (PDT)
Date: Fri, 26 Apr 2024 12:40:32 -0700
From: Kees Cook <keescook@chromium.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Mark Brown <broonie@kernel.org>,
	Shengyu Li <shengyu.li.evgeny@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Will Drewry <wad@chromium.org>,
	kernel test robot <oliver.sang@intel.com>,
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v1 3/5] selftests/harness: Fix fixture teardown
Message-ID: <202404261240.78AD73958@keescook>
References: <20240426172252.1862930-1-mic@digikod.net>
 <20240426172252.1862930-4-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240426172252.1862930-4-mic@digikod.net>

On Fri, Apr 26, 2024 at 07:22:50PM +0200, Mickaël Salaün wrote:
> Make sure fixture teardowns are run when test cases failed, including
> when _metadata->teardown_parent is set to true.
> 
> Make sure only one fixture teardown is run per test case, handling the
> case where the test child forks.

I had to go look up __sync_bool_compare_and_swap(). :)

> 
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Shengyu Li <shengyu.li.evgeny@gmail.com>
> Fixes: 72d7cb5c190b ("selftests/harness: Prevent infinite loop due to Assert in FIXTURE_TEARDOWN")
> Fixes: 0710a1a73fb4 ("selftests/harness: Merge TEST_F_FORK() into TEST_F()")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20240426172252.1862930-4-mic@digikod.net

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  tools/testing/selftests/kselftest_harness.h | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index ba3ddeda24bf..73491efbae9e 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -383,7 +383,10 @@
>  		FIXTURE_DATA(fixture_name) self; \
>  		pid_t child = 1; \
>  		int status = 0; \
> -		bool jmp = false; \
> +		/* Makes sure there is only one teardown, even when child forks again. */ \
> +		bool *teardown = mmap(NULL, sizeof(*teardown), \
> +			PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0); \
> +		*teardown = false; \
>  		memset(&self, 0, sizeof(FIXTURE_DATA(fixture_name))); \
>  		if (setjmp(_metadata->env) == 0) { \
>  			/* Use the same _metadata. */ \
> @@ -400,15 +403,16 @@
>  				_metadata->exit_code = KSFT_FAIL; \
>  			} \
>  		} \
> -		else \
> -			jmp = true; \
>  		if (child == 0) { \
> -			if (_metadata->setup_completed && !_metadata->teardown_parent && !jmp) \
> +			if (_metadata->setup_completed && !_metadata->teardown_parent && \
> +					__sync_bool_compare_and_swap(teardown, false, true)) \
>  				fixture_name##_teardown(_metadata, &self, variant->data); \
>  			_exit(0); \
>  		} \
> -		if (_metadata->setup_completed && _metadata->teardown_parent) \
> +		if (_metadata->setup_completed && _metadata->teardown_parent && \
> +				__sync_bool_compare_and_swap(teardown, false, true)) \
>  			fixture_name##_teardown(_metadata, &self, variant->data); \
> +		munmap(teardown, sizeof(*teardown)); \
>  		if (!WIFEXITED(status) && WIFSIGNALED(status)) \
>  			/* Forward signal to __wait_for_test(). */ \
>  			kill(getpid(), WTERMSIG(status)); \
> -- 
> 2.44.0
> 

-- 
Kees Cook

