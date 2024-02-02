Return-Path: <linux-kernel+bounces-49983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A5A84727F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181BA1C209D1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CDE144632;
	Fri,  2 Feb 2024 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E8qfB/Bl"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432031C33
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 15:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706886174; cv=none; b=ekg8R2C/3pOJHYy5iI9TlQXCkmbms/9prjH+xoOyzY5DPn75FU1MwLnke3CzTsS9npiBqWFTABZsh10rFb5Bfbd7A22FiqhQbDzHxdPBDiANkgXkqMqbm0haUZ5ow+oazP6WtNBipqCFhlGlIYbp1oeDDOk3slisNCKnFWVahOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706886174; c=relaxed/simple;
	bh=BF0rKLp0CAObazdWaJhi76bZxUep3DtIUZG0cmUpKj4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CVNg4wt6EAi65xWcjO+ZlLD73gxxNhd6qa4SmoKbrsLXNGB0/7Q3mZJpSyxCe+0wavL2Vok6yoDpFmm9OXeOSJjh9A6sWg3DfsLAj4MxBdZQ/c86tS4I5YEf3iEm2BfpNUPTGywn3NHtOS4uGLkJVo9wphCh8dlfYkl3xeQNaog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=E8qfB/Bl; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55790581457so3243357a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 07:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706886170; x=1707490970; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYWCOU9DgZv0aOLEKyl0sfhg+hXx0KFrdjEqT/PU1CU=;
        b=E8qfB/BlHvxn896XaB6hH0/o08jbCFvWG4K8h/GICaN/fzmiyXpApTyBkBgmuk+ymI
         RLiNwZy+D5TP631xEbMJdpmgzwbW/fer8+IFyAU0OvEpdk5u+0GKTFLLtGg47zJjAsGm
         tK46xoLR/DF6VBwLO/Dl0ZJjelj/ueP6rK05o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706886170; x=1707490970;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SYWCOU9DgZv0aOLEKyl0sfhg+hXx0KFrdjEqT/PU1CU=;
        b=X9ERdOlSTaCuBEr1+XAvrhwX54pk+35hVvzZ2xe4XjzcT3RgYjqgzzL/XE7XtD30cR
         XKDx779g84adTgEVyjNE24fP/i+nsBYIazhDbkv5rtnQHVEzFSdoOamDhJWadFvFYx68
         58zk4Xd617iqLXAnXBNeBncBcUXnzMJDlaMbpZV2pYo1tTBnezTefSDayM0y3PTMJa2b
         Obc6/WvVDl855WwIcQ7LDOFsdPC32smfMOCJ/IZfJw2HpzNzD6xt9816Ni56umq0jBm6
         wBzjuKAUOjYr7/DuXsS/Mg+MpT6P1bMzIqmls9XNQZ/LTha3BYnlKtZFU/iHbGWZSNRX
         zkLg==
X-Gm-Message-State: AOJu0YzlApuMSe6mk1Qv12ZJeagDyc7ky+vLF1Jp2rSKFr0ilFDHBcsI
	qADQfGrqDNbf8jNplqgZYeTDIUALWa1LPAH1Kikrl4So8PK23cKMHEMRvu/4VSakNpEEreDIPZl
	OSkID
X-Google-Smtp-Source: AGHT+IE6J0t90HACJXdknupVrzx4T9Xrt46xyUtPYrmvzcr7TWLlSbDUCv3NBYb9m+sMUwXzAHkxuQ==
X-Received: by 2002:aa7:ca52:0:b0:55f:d880:b15b with SMTP id j18-20020aa7ca52000000b0055fd880b15bmr1314964edt.36.1706886169109;
        Fri, 02 Feb 2024 07:02:49 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWOYpQlfkGaxePH4Dw5HZFrzXpkAc8REjHNQDmWTaJKxmybnLn9y7sFRQpkZ1jUnJ7Vw9cMxjNppREqlPNQllnyoqKMbCJWISrgWa4d
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id z4-20020aa7cf84000000b0055d19c9daf2sm872534edx.15.2024.02.02.07.02.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 07:02:48 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55f5d62d024so8601a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 07:02:48 -0800 (PST)
X-Received: by 2002:a50:9ea6:0:b0:55f:88de:bb03 with SMTP id
 a35-20020a509ea6000000b0055f88debb03mr15670edf.4.1706886168388; Fri, 02 Feb
 2024 07:02:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131171738.35496-1-yaoma@linux.alibaba.com>
 <20240131171738.35496-3-yaoma@linux.alibaba.com> <CAD=FV=XFWjkvuJmeJjb_OLCPJOtshmr=1A66R_WukHv4FEXr8Q@mail.gmail.com>
 <8d350eb8-09e6-42cf-b664-442db2ac7801@linux.alibaba.com>
In-Reply-To: <8d350eb8-09e6-42cf-b664-442db2ac7801@linux.alibaba.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 2 Feb 2024 07:02:32 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VmTjvr6Lo+vj+wfCoXG5jKUYsQ8xSBxVR-caSSPeX-wA@mail.gmail.com>
Message-ID: <CAD=FV=VmTjvr6Lo+vj+wfCoXG5jKUYsQ8xSBxVR-caSSPeX-wA@mail.gmail.com>
Subject: Re: [PATCHv3 2/2] watchdog/softlockup: report the most frequent interrupts
To: Bitao Hu <yaoma@linux.alibaba.com>
Cc: akpm@linux-foundation.org, pmladek@suse.com, kernelfans@gmail.com, 
	liusong@linux.alibaba.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 2, 2024 at 6:22=E2=80=AFAM Bitao Hu <yaoma@linux.alibaba.com> w=
rote:
>
> > ...or maybe you don't need this "if" test at all since you're using
> > "need_record_irq_counts(STATS_HARDIRQ)" here. IMO that should be
> > pulled out here as well since it makes it more obvious...
> I agree with your this suggestion here. It is easier to understand:
>
> if (time_after_eq(now, period_ts + get_softlockup_thresh() / 5))
>    set_potential_softlockup_hardirq();
>
> Please let me explain the criteria for the judgment here. Under normal
> circumstances, "softlockup_fn" will be woken up every "sample_period" to
> update "period_ts", and the "time_after_eq" I written will be false. If
> "period_ts" has not been updated after a "sample_period" has passed,
> then the "time_after_eq" will be true. And I suspect that in the
> subsequent few "sample_period", "period_ts" might also not be updated,
> which could indicate a potential softlockup. At this point, I use
> "need_record_irq_counts" to determine if this phenomenon is caused by an
> interrupt storm.
>
> To summarize, my condition to start counting interrupts is that
> "period_ts" has not been updated during "sample_period" AND the
> proportion of hardirq time during "sample_period" exceeds 50%.
>
> What do you think?

OK, sounds reasonable. Given that this is non-obvious, it would be
great if your patch included a comment explaining it. :-)

