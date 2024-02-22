Return-Path: <linux-kernel+bounces-77464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F9DB8605AE
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3D6B1F2250E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA770137903;
	Thu, 22 Feb 2024 22:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k1mq7Hhm"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CEE32C84
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 22:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708640846; cv=none; b=G1pCvog9npote9N39t8gzb5sadM7hxC+h3o79ZDKQZCU/8UDXUmdwXx7edqburVZDwVsfKIoLrkiovSshGQGCU4W0mSydaKuQ08yNYwlbwAypFEeObhQvoH5MBoRN7S+qJKuxwcoFqtuPKpEfl5M2WThTS0rdnUHwPn+Tl9rFTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708640846; c=relaxed/simple;
	bh=pgcUne6M9h/g/xtzSZCXPX8cqVSbwEa25baWijTpl3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JH/PZJjJipiwLAJd6RQTFaJtrjpug1JFYV6nPNFMgI5Vm2N1RuzYAOe3J6N28x1F0a1m/nbMBqRLhawmNtqp5+EKxeew5PFGlhzoOiZbciyYPTLxxBbFx21Q/ZpIEer3Cp7iSj1u3ZVbMhzDMctBrRUuRzSTS1lJS6EAoxqcXYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k1mq7Hhm; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41277b9ef37so9035e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 14:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708640842; x=1709245642; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pgcUne6M9h/g/xtzSZCXPX8cqVSbwEa25baWijTpl3w=;
        b=k1mq7HhmVjBXx8RYTxBgzIfXmCP8ywkrqNfEPTZvx0gKRL2ZVU+Oa4wnPxftnFtYR1
         PaDnhGBgEi3cpL2wxxp7OS4pKt6kofIEO6klaPzD7B1VNwmHJUIhf5qlXewq1VF/U7XR
         RkHpZdJ4iwZwivvE+01wCjyEYeRvxXGJzVSPlAQes+R10jLITgLwwiEECbZ5apPH1tca
         OhmWtY4sPi/dFpHdPzWs7rFkdQWJ6NhVuoHQuGK9iVReg7yEtOiD5/6Ik7R7QKkvHnsP
         0rjZQPAfyIKJed43ZX1Zt+K058m88TNb1IGz3qBJn53F7Nonl/4xgAVlrFJQXOsfkJRr
         6JRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708640842; x=1709245642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pgcUne6M9h/g/xtzSZCXPX8cqVSbwEa25baWijTpl3w=;
        b=pojfU7/5edbJRIHYICbqzmXAuFYvAL3jyF66zF+uN1MSwpEf+wnMqSx5m6nQCesmhl
         JwtlJhgBYvRU1Vv3nJ53jGx7Y+yABZJTqqdNBEWTG3UIslYclekro9fQ6Yb403Q7OCll
         Fla/QVMHqj61ymioYLkGvz+DN4vE2ZPjqzlpahZydyA2tZiZiuaFoR5ybgogN/AnejXk
         nIoopGqYaK0dt/F/JIFagm67Fg8KBtMeCmt8cvx0AJ1uDQWKpMiE9/WxahQVtpCR7jAm
         I7od4+RDj++lvWE8GmYkqEJeqHVlKjMuh59m4fkXNGNIbd4sfJrlVvjgqzGgYoNLyon8
         L4cQ==
X-Gm-Message-State: AOJu0YxXebDZaVGY8PxlsmJdhdPYpus5LvV9QrBW/7d7NfO/s79nNqr7
	wFmmF00FKrwUWKX7jluBtnG/SdjGAIOGg9vH7/A0e0SAEncRrNcbRrsddBfYITHpPRc64PB97z6
	LMtN0LSmROk3+DVydhOe+73pd4Cp8175Szy0=
X-Google-Smtp-Source: AGHT+IFBGtemsP1bM44wO5E01WKHh8GHVWrdWM4JBV6WS9B9W45GiSWrkYLSYjP1T3xpspqn2MRITn89UqjLsCf0c5s=
X-Received: by 2002:a05:600c:5192:b0:412:909a:d3fd with SMTP id
 fa18-20020a05600c519200b00412909ad3fdmr52237wmb.0.1708640842161; Thu, 22 Feb
 2024 14:27:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222204917.1719153-1-jstultz@google.com> <20240222212409.GA396872@lorien.usersys.redhat.com>
In-Reply-To: <20240222212409.GA396872@lorien.usersys.redhat.com>
From: John Stultz <jstultz@google.com>
Date: Thu, 22 Feb 2024 14:27:09 -0800
Message-ID: <CANDhNCrmu1CkynQ_NZ=Mhh1mySGejabUwvOQdvOMKVDJJSrURg@mail.gmail.com>
Subject: Re: [PATCH] [RFC] sched: Add trace_sched_waking() tracepoint to sched_ttwu_pending()
To: Phil Auld <pauld@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Daniel Bristot de Oliveira <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>, kernel-team@android.com, 
	Zimuzo Ezeozue <zezeozue@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 1:24=E2=80=AFPM Phil Auld <pauld@redhat.com> wrote:
> Maybe s/this patch adds/add/. Otherwise the changelog is nice and
> complete.

Ah, yes, I'm still terrible about using the imperative mood! Will fix for v=
2.

Thanks for taking the time to look this over and to share your reviewed-by =
tag!
-john

