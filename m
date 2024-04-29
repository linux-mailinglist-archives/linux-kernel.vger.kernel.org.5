Return-Path: <linux-kernel+bounces-162625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE038B5E38
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:56:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDD0E1C21845
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63663839FD;
	Mon, 29 Apr 2024 15:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SgLmpnxQ"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F74B82D8E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 15:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714406182; cv=none; b=RF7sqTfj/TkbxyV9rikg3COfr4nyWv1/TDC5HBtWcy/8QXVBkIqVXBK38JhhHWwr1O1BjiK5DDc9teW8+/8vBRXla2S5QN1ohm+hmMXnbLA0Nm+xy4XpUUNCpt/g3R2hOT7L8hCD3LMygZEbDe1Gg3v6qtSPl/O7UEtZHlMnw+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714406182; c=relaxed/simple;
	bh=ATY455EhGB1trAXJC1zlQW676b8T6ZW3Z87YtK/u72c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DumYAA2L0jfmXw3zJk7nSSI0KZ/gT8GcGinDoHBXuTnSyRXd1NAppxQ9Aw5taKEPXrpH+rixIIZ0C7BMEw846vL/b0XAOM3lzgs6QdsLYDdqa99tcOCW270T5LP89c3mOEAmV7zaEJrngPcuisYOfyDXsoqVuyzzEspyAKr/Eq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SgLmpnxQ; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso3265232a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 08:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714406181; x=1715010981; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kjGkCSeKh/CcNwm3m2uBf4bHFv/7owazitqwRQkEuUE=;
        b=SgLmpnxQ0lxawOMLyZWIQpPyCZSZ7fJXcSHPzxmXk74tG4zlVcZMECFZRRUKK3oRmo
         hLNszzTufGyx3aP+cpehy4+yT1YWF/sEEpWiGjofC8YvyRF1+VL4rHmvM2SrnA+rBKoS
         0Gq6bFt4yqVo/WZIO5OTle8oFYei8csCNJz6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714406181; x=1715010981;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kjGkCSeKh/CcNwm3m2uBf4bHFv/7owazitqwRQkEuUE=;
        b=jjTb/M6cG5QLIEY/eC1KrXKT81gb77gaaP5XplJgK4hrZxyhAMEvYjfcs8HT4ZEzwq
         R/2G9QKCxiloO6yfVCvJvMhouBhAzLVMF5AJeWIMkbMQPTA0XuoXe1EwMIkrEyYrLkvO
         Q8eh9p13qed5Av9LRmzpxV1nzd5W8zDJs1mNc+ngeXpzfYzZJKsh4V8aM5S79UP6GiW7
         fNwmfldjpeW1kc1iK34uYd4ii47qoseYCvFkxETGyUEow74V8hwcjWPqKbwoaF5znGJa
         6d7axbzEJlZgL4Gxg/j6+wwNG9Ro8niJCBCRq190ctIobby43+ZkPQUCDskWTrROxh2k
         AJBw==
X-Forwarded-Encrypted: i=1; AJvYcCWa8SzgTLhm7pZvMpCrsXlySht3cTChF6bPNSFNBoynIDJfIAyZ1QovzDYHf72/fWxwi/NU9HuQq1uYJh5lh3do5sOu76MwHnPkcfBf
X-Gm-Message-State: AOJu0Yy8ed7aESWyBgvb7qn9RamPDtKLY9A5+EHY4Sv0JlTU1ZJCQm5I
	aRsFrhP4ePGORFySWNP8ICEsG4bZjVM1gUOSm9hpPJJclcICo9zpqDIUgUCTCg==
X-Google-Smtp-Source: AGHT+IEEywzon9guDpWHAHMoP7E4pXBs+0uOQkQO23YAwbVpobMsPRalzKbOZoYrJ3hUqSG/EDAvIw==
X-Received: by 2002:a05:6a21:7885:b0:1ad:89e:21b5 with SMTP id bf5-20020a056a21788500b001ad089e21b5mr12953888pzc.15.1714406180782;
        Mon, 29 Apr 2024 08:56:20 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id lw4-20020a056a00750400b006ea9108ec12sm19390219pfb.115.2024.04.29.08.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 08:56:20 -0700 (PDT)
Date: Mon, 29 Apr 2024 08:56:19 -0700
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
Subject: Re: [PATCH v2 7/9] selftests/pidfd: Fix wrong expectation
Message-ID: <202404290855.34806C9@keescook>
References: <20240429130931.2394118-1-mic@digikod.net>
 <20240429130931.2394118-8-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240429130931.2394118-8-mic@digikod.net>

On Mon, Apr 29, 2024 at 03:09:29PM +0200, Mickaël Salaün wrote:
> Replace a wrong EXPECT_GT(self->child_pid_exited, 0) with EXPECT_GE(),
> which will be actually tested on the parent and child sides with a
> following commit.
> 
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Signed-off-by: Mickaël Salaün <mic@digikod.net>

I had to take a closer look at this one -- but yes, this should be just
checking for failure (negative). The parent/child separation is
afterwards.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

