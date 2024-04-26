Return-Path: <linux-kernel+bounces-160620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6228B402F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 21:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFA1F1C20B97
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB6918026;
	Fri, 26 Apr 2024 19:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="McR9UwBY"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F63111A8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 19:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714160302; cv=none; b=FF9sQJK5DhI0h29Mg6JxC/0197OkZ4q4JDO5RgRc/6009B+cr9cNiuoGdEceZU8N8X8KhDfvxqgQX05AEMUDB/B6ztMP0d16ah/niiBiTdJ4wRUGsIGVOOR2WQTcmhqADUeB6pSmK18Y9XmAR96VikqyhPYAAJUJrrbK7bdb5gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714160302; c=relaxed/simple;
	bh=CwQga8irROKhKUwlkRdQGipQpGoVKl+lkJEs4kFKyZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LCyLU1RixgAoKP1SBHAMDMNFZyHM2pq2MJK00ZD7Mgqjf2lDEi+ASJu/d11n/LUC6vH963aloF+5ox7mAVLnOMjM0WZMv23x/NSNGdmtEY/4c0f53PJP2Eov+9aXn7gn7BySNuFsEESns5jPmYkwM0KnJGot/JUKFPEIMfYsFbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=McR9UwBY; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1e51398cc4eso23616155ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 12:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714160299; x=1714765099; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nVfDEkqQe4x33nULOMKWhaNum2xzJZB1iFAYb/EkXQU=;
        b=McR9UwBYA+Gr5rxhCeZO8bFGMMQsPvZdPQHH/CPeLnqhHWlemE8hGNp2vLcmoQPaCd
         j4Pv4YlcaN4eBkB+5O8qOxncLyq8tVaLX4Ezjq44dUPIzlDEek0AwgxfGiITNrxIdVQ9
         aYIO6Fei5iVSZqfDzLj+BU3UW15maGRMs9Vm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714160299; x=1714765099;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nVfDEkqQe4x33nULOMKWhaNum2xzJZB1iFAYb/EkXQU=;
        b=JF0fLYzO2H0z3JmjYpieXjgThif9UCVPlAf9L1CNdMa5VU/vDkowu7XvJM6Aj946Ci
         4IEEVLHkmBWZtU6s8cWj0yxAPQoUxSRiuoUfItipfk58uwBaQ4gD3d0jefyFjaezvcvZ
         b21fsBLzGJj7VAdEv5+eZd/IHBTmuzJkrLlidtayRXXqyPy0fuYYuHfc89BtCjY3yiOk
         33b/+yTnHVyaryPtMm7gezY2lvGCGHCXlHTiRIcqG826S4OJgNrMDHA+/4FpLEED4ey9
         ZRfNPCMBhhBh5b9S+dMG4iUUv3j4CM70cxkfTS6xfRL4cGqVVLh2ZhvqqfW+9ido1+F/
         qLXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR44B8KbBSBhE9+5Petibxan9Rn+5Kd7nBWnNNfTOmAt7Gej6MndmxwTi1PXt2KG7o6jsphL8C+KovgQu6xCFiDTfOAl2LIEOydPT6
X-Gm-Message-State: AOJu0YwFU3T6uYXSenvivQxuz6MHsvqSQvuka/7eb6yAkZDLKp1FU8T6
	J3FbEcFA4+uTF5vT1mBQ0Q3CoY70byAVWAg0avHgpsqmxHArYNLedy33Ep3DJjaQARMkA5tAR7Y
	=
X-Google-Smtp-Source: AGHT+IFlR35BuijKwTI8Ylp1DTbqbHWtrC7bRCA7f1PhwMicqBoZ4LfTkaxEVjKPLTqGnneQV9eFcw==
X-Received: by 2002:a17:902:e546:b0:1e5:b82:2f82 with SMTP id n6-20020a170902e54600b001e50b822f82mr5071693plf.42.1714160298724;
        Fri, 26 Apr 2024 12:38:18 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id k9-20020a170902c40900b001e431fb1336sm15816686plk.31.2024.04.26.12.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 12:38:18 -0700 (PDT)
Date: Fri, 26 Apr 2024 12:38:17 -0700
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
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 2/5] selftests/landlock: Fix FS tests when run on a
 private mount point
Message-ID: <202404261237.C703A7B1F4@keescook>
References: <20240426172252.1862930-1-mic@digikod.net>
 <20240426172252.1862930-3-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240426172252.1862930-3-mic@digikod.net>

On Fri, Apr 26, 2024 at 07:22:49PM +0200, Mickaël Salaün wrote:
> According to the test environment, the mount point of the test's working
> directory may be shared or not, which changes the visibility of the
> nested "tmp" mount point for the test's parent process calling
> umount("tmp").
> 
> This was spotted while running tests on different Linux distributions,
> with different mount point configurations.

Which distros did what?

> 
> Cc: Günther Noack <gnoack@google.com>
> Fixes: 41cca0542d7c ("selftests/harness: Fix TEST_F()'s vfork handling")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> Link: https://lore.kernel.org/r/20240426172252.1862930-3-mic@digikod.net

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  tools/testing/selftests/landlock/fs_test.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 9a6036fbf289..46b9effd53e4 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -293,7 +293,15 @@ static void prepare_layout(struct __test_metadata *const _metadata)
>  static void cleanup_layout(struct __test_metadata *const _metadata)
>  {
>  	set_cap(_metadata, CAP_SYS_ADMIN);
> -	EXPECT_EQ(0, umount(TMP_DIR));
> +	if (umount(TMP_DIR)) {
> +		/*
> +		 * According to the test environment, the mount point of the
> +		 * current directory may be shared or not, which changes the
> +		 * visibility of the nested TMP_DIR mount point for the test's
> +		 * parent process doing this cleanup.
> +		 */
> +		ASSERT_EQ(EINVAL, errno);
> +	}
>  	clear_cap(_metadata, CAP_SYS_ADMIN);
>  	EXPECT_EQ(0, remove_path(TMP_DIR));
>  }
> -- 
> 2.44.0
> 

-- 
Kees Cook

