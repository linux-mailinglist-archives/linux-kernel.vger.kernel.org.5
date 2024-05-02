Return-Path: <linux-kernel+bounces-166839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEEF08BA095
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C1AA1C22350
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A38A174EDF;
	Thu,  2 May 2024 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="CGXQvnFq"
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE5A174EC6
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 18:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714674882; cv=none; b=l25BTUlCEnvkOjZRlIAO5AW1D2m1hWHRGIqNIZ3zpbFYBONrVbXtSN11Wt9zHYClFvlfLsqTv+4FQADCJA14gFhMsA1KrVRsy4unUrlrJNIh94xpoo1qp2U8UpumOeb7xbxms9BwHwY5W7MFg2FFTTk+RWIcp8949LyznRjeI84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714674882; c=relaxed/simple;
	bh=hkUdLfPttpQ9Uizzjig3dHmfdmmvYzwn26n5H3T3jCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mJ3s5BDZmP3Nxr+4jVNT1/THGS10xR+XxmWEwL3LAi7/jrXzUB1oOIPmZQ1KAKtV6Asx+q0mbnSCUiJ23H9Fz4d4+E4RR7UMSwKbmRTc6ZxvPwfEj8VrXoo3nzcF8Yyl7zLisvdhSDu2T0Vh41+Ryb1tNBLTuGKDklymFv3LWrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=CGXQvnFq; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2b346712919so1299882a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 11:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1714674880; x=1715279680; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+25HyXOoGfU3yjmqt9OUckjepNjR3C/KJDAxWQF5ZQM=;
        b=CGXQvnFqZsvP5ZzwsDHTs5ZFXeMn7t0PGgM+nEv7urTzHdMq7FcX+6grEIM5pjPa5a
         mPJbK6mvkArrCxE372YstWSkK3XmvGAoRdQ7wtnI2Et8sqdnkWcWhTWorweh6rv3rXLp
         OnDsbBKYD6Nd+R1Trb4zRreMHBnLbVgMqIPUd6WX5yf7QubfrfLLMfDSdscTcoSAZFgC
         11x89bt4AqLNhsJOXSsvIKPpwLw1nfmDXxK6t2zK47IJKmtW6dRSv84ySUeR937NUsNW
         9JCIQQFxV0HU8h7WjV7DfwrXTfn1VIZwAlme7s0HDC7q37c9Wpsrde4gT5TOuULP9Pdx
         ecnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714674880; x=1715279680;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+25HyXOoGfU3yjmqt9OUckjepNjR3C/KJDAxWQF5ZQM=;
        b=YBHT22pRIqBuhG+374Jn2wYdoFych7fBjtrOedzEihdXnO0RT+JOuEglGd+J7uPyDj
         QGWYbbhYAjAqG6FG06sC7b0kIMD0uH3vrNtgoyR1ly0UTWS5CW1/+sf93hmMLy6Je70L
         dmsApXWWZHKMbFNJgJxiwpnADEbD3OBwcOjCWCg/x85iHPtqcK8neFP1fy4One4MBW5X
         EXBuxQ2u3ChZhSIjf0wJ/C2OeK1foysIpP0y5f5u+j8rFw79ys/pnp7Wai0dYZ/Airi/
         fzVv9nDy/Y91VwkNGfB+zWY368c/7yul4L8qAg3WklPkGY/1Xe4IUKYcqrmVl4xJRj+I
         YvzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXUFMWaNctBxAETBMyiEyRV+eKLHTXmf2SAk7MARLWsjMwV2dy5eoOmgGazq3ybrDXg965Rqnw5E9hpnydZgqlLVi8GbYGTn1ONVpBz
X-Gm-Message-State: AOJu0YzkFBMlPUfxvgEXzeaa9P+2xDM4w3ucl4RalVLWD6rhYWKK9GBV
	93P1m29zxuQ6ntiCoSh+nq1f1vKWNh09v6gI31cmczyp5lQB6qzV0Vz0KIJWf8cH+wGyEFd0Y5y
	hhIHzkXR2h94vOS9OIBsJwlRVmLH+YJnjgTw2Dw==
X-Google-Smtp-Source: AGHT+IF5E4mgToLIMVVlH/f2iwR1VecRyVXaYV+aFS7iLb6nTGbXf4HJT0JlfGzSaOychD89ASCLwngz5CgMoxT3z+E=
X-Received: by 2002:a17:90b:4388:b0:2a6:9c5f:828e with SMTP id
 in8-20020a17090b438800b002a69c5f828emr700244pjb.22.1714674880502; Thu, 02 May
 2024 11:34:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430210539.935040-1-naresh.solanki@9elements.com>
 <52e7692c-abaa-4201-8248-3f42bb250335@roeck-us.net> <CABqG17j2kMEK98T90eudb_ZWftaV2L4_MdA8ML+v_cm3MHFs1w@mail.gmail.com>
 <af66ac87-32ff-48a6-bf1c-d7ac578ceb4c@roeck-us.net>
In-Reply-To: <af66ac87-32ff-48a6-bf1c-d7ac578ceb4c@roeck-us.net>
From: Naresh Solanki <naresh.solanki@9elements.com>
Date: Fri, 3 May 2024 00:04:29 +0530
Message-ID: <CABqG17hE+2F9y1=JZFRuJtLecFtx0XJBzt-a0HSyE3VRoqdzCQ@mail.gmail.com>
Subject: Re: [PATCH v2] hwmon (max6639): Use regmap
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Guenter,

On Thu, 2 May 2024 at 23:52, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 5/2/24 10:25, Naresh Solanki wrote:
> [ ... ]
>
> >>> +     u8 pwm[MAX6639_NDEV];           /* Register value: Duty cycle 0..120 */
> >>
> >> pwm caching needs to be dropped as well. It is no longer initialized in
> >> max6639_init_client(), but updated and later used in pwm_store() and
> >> pwm_show(). Looking at the datasheet, the pwm registers are volatile
> >> and should not be cached in the first place.
> > Yes. I did that but found that the register is write only. i.e.,
>
> Odd. The datasheet says that it is r/w or, rather, that reading it returns
> the _current_ pwm value and writing it sets the target pwm value in pwm mode.
>
> What happens when the register is read ?
Upon revisiting the datasheet and conducting further testing, it appears that
my previous response was inaccurate.
After testing, it's clear that it reads what is being written & hence
it's perfectly
fine to remove variable pwm[] from local caching.
Verified using below command:
----
i2cset -f -y 130 0x2e 0x26 0x10; i2cget -f -y 130 0x2e 0x26
0x10
----

Regards,
Naresh

>
> Thanks,
> Guenter
>

