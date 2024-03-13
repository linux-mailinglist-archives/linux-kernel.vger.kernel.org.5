Return-Path: <linux-kernel+bounces-100986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F20C687A07A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF1EB283467
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC174AD21;
	Wed, 13 Mar 2024 01:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="djrMq6cT"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558CF79C5
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 01:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710291668; cv=none; b=K7VI2omeWojVMJ6QDP1CBcTa+AwBy9mMBg5qN+6gWHL7/4Ynb5Xv5O0U9V6n8snIcwbRBqgHAqk4YJaloM+GDf1rvObdi3C2sZjs0QN10C3jXZjwfll+D6tsL6xYSI9tSygtIhemJideagoU6SHByYehQoeV9Fxk6oCVeEDUa28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710291668; c=relaxed/simple;
	bh=vod0Oteo/6Tbo55PLgkq1rrHpuWN6dhPTkJvDCvNrsY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NX22ys+pTj7Dj1Jw9iCnCIAS3d7GvEy68Yvg86A1laNC53xMWffGKAEXqZ0wi1PkrMKuBwr4ZlzN2XhbE6rmBsTUkRrO8H+YAjx37xbiAOTP2YuyJBzhf2nLprdQJUYNOvpGXn5dqxIZoQ2yioswWC1neF1K9lsOdzyGmXsrSbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=djrMq6cT; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso7195577a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 18:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710291664; x=1710896464; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3T4oJ3T2wQraOYexFpJYePqHAPHXrr02cgINFeasfxE=;
        b=djrMq6cT5gh89sVB78d38f7yZeGiv1u2vydaViH+yKsZlDYJx9x3EM923Nkmm4BWVE
         OzmNIY83Y1zKmJquGqH1WZBMiDyDGWyjaveStKuQt/9qBkUey8T7jqr6NYzeiML3CgVj
         xu8yHxpC3oFby6nFDygfBMdWKmq/NxBJdMkxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710291664; x=1710896464;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3T4oJ3T2wQraOYexFpJYePqHAPHXrr02cgINFeasfxE=;
        b=GFEsqaA4AfuRj5eyQmOrrAeRwBg4uxWZrKl++yFmiJPyphYMAYYM8APUBFA8PjnA3C
         XN3GYo5HpTc0wX6Ms265Xh0tSjRrkdpBdnP1YZjfKiLn3/MxkNjee6VKVQ2a11owDLXv
         3KBdN2XAjT6hK28a+7qmLpu9Z1jWHvAWsZnH4thTBggYKpxmA6Erm6B/u+ttvfskfQpp
         44MzFJZCoA3L0ZJ+DzCXnZe3L3txZdC4B3xTyixqtge73SRHDumDIIL4uMEEIIHCnJMV
         Shn5nLCz/FGYA9yPHI+lSQaMJB90kIeH5ACbW6z/34mic+uXDurw94uSrU5OSGNgrB9+
         2sTA==
X-Forwarded-Encrypted: i=1; AJvYcCW2xTte860Ngru54sM3Pat59dz0G8zYumANU/Qv/FTPtZ2AUitcq55Tk+PdtmEQsiDnVeTnF7aRKDcGXoSZMLLBapOqXvVKGv24bZvn
X-Gm-Message-State: AOJu0YwIDb0A6zV+UyZqr8WQtVcUqVXyGVfyonvgV4f6GW3STMDWREUd
	zuWo89SRvyeMDimMDh7wnxIlK5n3Zv1E4EG/45ZqJ2d/+0STwRnFbuG90QCfMp2zwdj86hgYY5I
	ezkyBNw==
X-Google-Smtp-Source: AGHT+IF3nZOIVCcSqV/TN+pb7IiWo9vwouLB/Riqs+Ck9QiwVrjRWJuMiL/qN8ARuZ4AB5O/r976CA==
X-Received: by 2002:a50:f61e:0:b0:566:4654:4fac with SMTP id c30-20020a50f61e000000b0056646544facmr7729892edn.5.1710291664675;
        Tue, 12 Mar 2024 18:01:04 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id g2-20020a056402320200b005687717d1f5sm999747eda.10.2024.03.12.18.01.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 18:01:04 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a45fd0a0980so487297066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 18:01:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXv+2cYR+LwnETlvjqJdUrGCFrhyNQ/KDzj0boml1BhkOYda3X7sjXEClG0lPmlfum8YORJSTiz00iO1xkaPjJVvtHVhstE1jvFf32r
X-Received: by 2002:a17:907:c247:b0:a45:5328:8432 with SMTP id
 tj7-20020a170907c24700b00a4553288432mr9215023ejc.50.1710291663582; Tue, 12
 Mar 2024 18:01:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312042504.1835743-1-kuba@kernel.org>
In-Reply-To: <20240312042504.1835743-1-kuba@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Mar 2024 18:00:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi0La3-L+WJ=vw7x7L=WYv0B_2YfeSuKD3YyCYJ6oAwKA@mail.gmail.com>
Message-ID: <CAHk-=wi0La3-L+WJ=vw7x7L=WYv0B_2YfeSuKD3YyCYJ6oAwKA@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.9
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pabeni@redhat.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 11 Mar 2024 at 21:25, Jakub Kicinski <kuba@kernel.org> wrote:
>
>  - Large effort by Eric to lower rtnl_lock pressure and remove locks:

W00t!

Pulled. The rtnl lock is probably my least favorite kernel lock. It's
been one of the few global locks we have left (at least that matters).

There are others (I'm not claiming tasklist_lock is great), but
rtnl_lock has certainly been "up there" with the worst of them.

            Linus

