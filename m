Return-Path: <linux-kernel+bounces-38794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D5C83C618
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 063BF1F2310A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB676EB5A;
	Thu, 25 Jan 2024 15:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="l12ah27m"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F056EB4C
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706195305; cv=none; b=X4KDRk3XO8cIyaA9xNqUSmaDDY22VGCQcuYF0d3N21GWoHfwXqT2mgVJoaBNWLVy67SqUMgImUIw5BIq2AFDtFOgSs5mUNq7RydF1RluZRvzmRdzf3Wz5mbHNJOyOf4yPD4UTsYQ4Y+TdUQxJNmw8gaN0NKtSNgQKR7Hn1vD4ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706195305; c=relaxed/simple;
	bh=deQcsu8h+S09RLv6P/V63j6+EULf/azDNuwFgrJE3dw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dNTgWElxsoeVMYmUflC2lUgDFHDahlBh3iU+v9HjqY0zKKJUvNl67crYhKdUmENuC2wXrrmEBXO97syquekd13Z/7w/YXkENW/Ks7Safv2M11U1ETicwTOdn4SQGpSSpHwVX9b/kfU2nQShPSwr4stcOP/ku+pOq/x9hM+BFWYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=l12ah27m; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55c33773c0aso4649667a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 07:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706195300; x=1706800100; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deQcsu8h+S09RLv6P/V63j6+EULf/azDNuwFgrJE3dw=;
        b=l12ah27mZPdxGxj2RGqUEhlgt5K1oNHVng3AIcwUviiG8PbL5ZhSVE4qDzwHrt1xxz
         lzbnkMaIwHYvmxihjbtTdcRRLA4DtC6+AYXbRalYGUGSjO2Y4bFXG8eFjBoJmk4mNals
         NmZizQ9CLqdnM1JJvm+WeENdG1BpSwEnD+tGw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706195300; x=1706800100;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=deQcsu8h+S09RLv6P/V63j6+EULf/azDNuwFgrJE3dw=;
        b=LcRL34Xb495ApqitLoWScIYXLHf9xUoNsI/Dv2wNRx9hefcuVDU1+z3a4JSJiUrNgr
         ezg5gNSjiI1fsf9rI9Rz5GhQRzXWGxDJWncL6K+iiBzi3xvX3lFWWZaj/nqccLbTA6Ps
         /zCPLYk5+AM2kJHhcPLNrUptXFgUDtrY0XR8zWfkv2quy8ysD6D2fY8oEDz/0Vl97Ovc
         ptTofxP1vT/fqFPmn3IKX/aSnYBFNDlLcgbrGcfaatV2pEhJa3eK6IBhUsX1yarY0nFQ
         2KdxmLDgKxHo6mDbsc5FrVP9G9mg0SAep7Tke/lRYEE0ts5oBD/a2DjF1V1WR1K5A5JI
         I3iA==
X-Gm-Message-State: AOJu0YzHfqdMn5s73o5jgbOtOjSwqfFenOiND1iEuYbjXi00UZCLt0Ek
	yuoSWlnY/nZnOxt3hFE7JVY7PyB+j5S1VHVWNSujZVQFlFn4I17dVg2+dKji6OzdVmJqYMB35ID
	Rww==
X-Google-Smtp-Source: AGHT+IHuNILUgMKBs+MWUrOvEv0sMivN+BlQJK9sDBy4dv+CfXo9cqs9hBIN7PrwbuYW2uEVrwJXog==
X-Received: by 2002:aa7:d991:0:b0:55c:a1c8:bad6 with SMTP id u17-20020aa7d991000000b0055ca1c8bad6mr765509eds.23.1706195300601;
        Thu, 25 Jan 2024 07:08:20 -0800 (PST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com. [209.85.128.54])
        by smtp.gmail.com with ESMTPSA id n19-20020aa7c693000000b0055d1a75bd0csm92566edq.57.2024.01.25.07.08.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 07:08:20 -0800 (PST)
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e865bccb4so51825e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 07:08:19 -0800 (PST)
X-Received: by 2002:a05:600c:4749:b0:40e:b21d:6c14 with SMTP id
 w9-20020a05600c474900b0040eb21d6c14mr166195wmo.6.1706195299047; Thu, 25 Jan
 2024 07:08:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123121223.22318-1-yaoma@linux.alibaba.com>
 <20240123121223.22318-2-yaoma@linux.alibaba.com> <CAD=FV=WEEQeKX=ec3Gr-8CKs2K0MaWN3V0-0yOsuret0qcB_AA@mail.gmail.com>
 <8c7ba29d-0e12-412f-b88f-347de237d1ad@linux.alibaba.com>
In-Reply-To: <8c7ba29d-0e12-412f-b88f-347de237d1ad@linux.alibaba.com>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 25 Jan 2024 07:08:02 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UfzLAxbKWUqhbt7iBEZzyuBqCkdaSJFnHGYAw-2mcAYA@mail.gmail.com>
Message-ID: <CAD=FV=UfzLAxbKWUqhbt7iBEZzyuBqCkdaSJFnHGYAw-2mcAYA@mail.gmail.com>
Subject: Re: [PATCH 1/3] watchdog/softlockup: low-overhead detection of
 interrupt storm
To: Bitao Hu <yaoma@linux.alibaba.com>
Cc: akpm@linux-foundation.org, pmladek@suse.com, tglx@linutronix.de, 
	maz@kernel.org, liusong@linux.alibaba.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jan 25, 2024 at 12:31=E2=80=AFAM Bitao Hu <yaoma@linux.alibaba.com>=
 wrote:
>
> > 2. Sum up all 11 of the stats to get a total. This should still fit
> > into 32-bits.
>
> >
> > 3. Do the math to get the integral percentages and store those in the t=
ail slot.
> >
> I'm a bit confused, why is there a need to sum up all 11 of the stats to
> get a total? I calculate the percentage using sample_period.

Oh, you're right! I saw you looping over NR_STATS in print_cpustat()
and assumed that was because you were totaling them. Yeah, using
sample_period should work.

-Doug

