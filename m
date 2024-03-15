Return-Path: <linux-kernel+bounces-104249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C7D87CB39
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BC4AB2211A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CC8918EA1;
	Fri, 15 Mar 2024 10:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YhfWaWrM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B1718651
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 10:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710497588; cv=none; b=SBdN1719CSOR6rcldKs5109kUMZK0CmofR0sPhIkkGRKgPzmmYMxd+19LyIzcz/Nq8EQ9q8TAc4QfWhWbI0kjkGWiJ5uUmAqeQnVt4tr/x2WzSBQMDTPF/NfgudBWF+lxU4KJXqguYZBDE2WXiCIPVtTOaRJJMRwKfTjrNGDaV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710497588; c=relaxed/simple;
	bh=PmSNqJzLauqVuWOI//trxf4ztsCJtP19qj3RPpas/J0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z0tfYTws9fhnvMlAnDTKsvuzm7wMvmJtDoi4Fbtljttfnbk4Z8XfEmWT+0Rt7U/T1Fy2/Pvmbn+aortJs1ps45C1nnX66gTMguddtCH5vIz3pRfJxIA4DkPuv1KpfUTo2d6zZDoP7fVUTdWCG6lEY/l8pcqh7m8nasbymPkDYU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YhfWaWrM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710497585;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dGgBiaNjRI6L5nPHxVT3+aLEqiuZe1OVUV710AgZry4=;
	b=YhfWaWrMg4cZgo1AGzRGHzlk27gOBtbpPpCPChLMq5iZmmd39QnH3anzsHfYzNWO2XVnGg
	3U3Pm+hNEdW0RwIHbvc+sR7MTrQ9ui6E1fRtC5okb8P21MQDFYs9Ti7LedegqF2lj84lMU
	MLqxWjfMkW/bWaLB/JGU8UfBMgAj7Mk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-yQMYDf6DNYiBRSl__Ueamw-1; Fri, 15 Mar 2024 06:13:04 -0400
X-MC-Unique: yQMYDf6DNYiBRSl__Ueamw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a466c77307eso191625166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 03:13:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710497583; x=1711102383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGgBiaNjRI6L5nPHxVT3+aLEqiuZe1OVUV710AgZry4=;
        b=CssRiGRwhsEYrR3ovPKbCgNgoPXJvWRlZQ75euM1HZq7NRbsqKsAxQLE7x/OrzgP2J
         N2RoUABGaUSAC73I3SjC2O9rCj2lQZEuMnqU77rboh6KxHSJq1RCMWh54kkvJe3kuzrN
         F2IjgVnEJJcgtfbPrmkQC8AdthJcc9wChTNZ2YUzwEKO3i3wKw7EarIlAwq3DWa0zGYx
         G4vVG4X7vPvIWxSLXBuL9VncBhNPpUYE4pA/e0/ktpAuud/jCUpQSMJVMTuq1q5EH86m
         z3OM1GmAnkIyJjwCL6EIPO271uFos41dXGdeQpqPODv5tmu+SexbNXp5yxKHWhrhXtrh
         Hb4g==
X-Forwarded-Encrypted: i=1; AJvYcCXUljiZYrXLFZljd1dMVdqM+RLwmLLdgEBKL1ORX1JEA7OUQSb7dbIJ2sqpHnjEpTo1equaxjXf8/cSZwVKiAswxTW+l7UPGlcOueRR
X-Gm-Message-State: AOJu0YxZEo1RaUDFy4lu66Tr2WqlZnKanqSgnPPXUpyBgPURAV99q56Z
	D9M+InIg0DzsT+8RdQUWnXh2Ejb/tyyhkLfmPT1bIcAgRVGb4b4/MFD+mX6HytGDwBvDgqSVhNo
	KRmiVJ1SjDAr3cnXpm5pcsrxwbjYwm9xgaxv4T4QKYKS6NXj0aMjA0BNO2mq0tXO6uUAFg1nU2H
	e8IwX67ME7Mi9uCISKPZC4YqQ2KLhaNo5ZMV2E
X-Received: by 2002:a17:906:53ce:b0:a46:4918:327 with SMTP id p14-20020a17090653ce00b00a4649180327mr3327895ejo.37.1710497583141;
        Fri, 15 Mar 2024 03:13:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAIkU4uTzpq17jIbC+WboSgKGptA6C8KEBnsOxk42/ys+EaEU6YfyUzDI3e5IfG3SR1vFat6JsW/OzSY9b2rE=
X-Received: by 2002:a17:906:53ce:b0:a46:4918:327 with SMTP id
 p14-20020a17090653ce00b00a4649180327mr3327874ejo.37.1710497582712; Fri, 15
 Mar 2024 03:13:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315092042.145669-1-ivecera@redhat.com>
In-Reply-To: <20240315092042.145669-1-ivecera@redhat.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Fri, 15 Mar 2024 11:12:51 +0100
Message-ID: <CADEbmW1FzbrmZfdptdkLkzZ5KGz4rAy1CWHscZeEeG_jYARCew@mail.gmail.com>
Subject: Re: [PATCH net v3] i40e: Enforce software interrupt during busy-poll exit
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, pawel.chmielewski@intel.com, 
	aleksandr.loktionov@intel.com, Hugo Ferreira <hferreir@redhat.com>, 
	Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, 
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 10:20=E2=80=AFAM Ivan Vecera <ivecera@redhat.com> w=
rote:
> As for ice bug fixed by commit b7306b42beaf ("ice: manage interrupts
> during poll exit") followed by commit 23be7075b318 ("ice: fix software
> generating extra interrupts") I'm seeing the similar issue also with
> i40e driver.
>
> In certain situation when busy-loop is enabled together with adaptive
> coalescing, the driver occasionally misses that there are outstanding
> descriptors to clean when exiting busy poll.
>
> Try to catch the remaining work by triggering a software interrupt
> when exiting busy poll. No extra interrupts will be generated when
> busy polling is not used.
>
> The issue was found when running sockperf ping-pong tcp test with
> adaptive coalescing and busy poll enabled (50 as value busy_pool
> and busy_read sysctl knobs) and results in huge latency spikes
> with more than 100000us.
>
> The fix is inspired from the ice driver and do the following:
> 1) During napi poll exit in case of busy-poll (napo_complete_done()
>    returns false) this is recorded to q_vector that we were in busy
>    loop.
> 2) Extends i40e_buildreg_itr() to be able to add an enforced software
>    interrupt into built value
> 2) In i40e_update_enable_itr() enforces a software interrupt trigger
>    if we are exiting busy poll to catch any pending clean-ups
> 3) Reuses unused 3rd ITR (interrupt throttle) index and set it to
>    20K interrupts per second to limit the number of these sw interrupts.
>
> Test results
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Prior:
> [root@dell-per640-07 net]# sockperf ping-pong -i 10.9.9.1 --tcp -m 1000 -=
-mps=3Dmax -t 120
> sockperf: =3D=3D version #3.10-no.git =3D=3D
> sockperf[CLIENT] send on:sockperf: using recvfrom() to block on socket(s)
>
> [ 0] IP =3D 10.9.9.1        PORT =3D 11111 # TCP
> sockperf: Warmup stage (sending a few dummy messages)...
> sockperf: Starting test...
> sockperf: Test end (interrupted by timer)
> sockperf: Test ended
> sockperf: [Total Run] RunTime=3D119.999 sec; Warm up time=3D400 msec; Sen=
tMessages=3D2438563; ReceivedMessages=3D2438562
> sockperf: =3D=3D=3D=3D=3D=3D=3D=3D=3D Printing statistics for Server No: =
0
> sockperf: [Valid Duration] RunTime=3D119.549 sec; SentMessages=3D2429473;=
 ReceivedMessages=3D2429473
> sockperf: =3D=3D=3D=3D> avg-latency=3D24.571 (std-dev=3D93.297, mean-ad=
=3D4.904, median-ad=3D1.510, siqr=3D1.063, cv=3D3.797, std-error=3D0.060, 9=
9.0% ci=3D[24.417, 24.725])
> sockperf: # dropped messages =3D 0; # duplicated messages =3D 0; # out-of=
-order messages =3D 0
> sockperf: Summary: Latency is 24.571 usec
> sockperf: Total 2429473 observations; each percentile contains 24294.73 o=
bservations
> sockperf: ---> <MAX> observation =3D 103294.331
> sockperf: ---> percentile 99.999 =3D   45.633
> sockperf: ---> percentile 99.990 =3D   37.013
> sockperf: ---> percentile 99.900 =3D   35.910
> sockperf: ---> percentile 99.000 =3D   33.390
> sockperf: ---> percentile 90.000 =3D   28.626
> sockperf: ---> percentile 75.000 =3D   27.741
> sockperf: ---> percentile 50.000 =3D   26.743
> sockperf: ---> percentile 25.000 =3D   25.614
> sockperf: ---> <MIN> observation =3D   12.220
>
> After:
> [root@dell-per640-07 net]# sockperf ping-pong -i 10.9.9.1 --tcp -m 1000 -=
-mps=3Dmax -t 120
> sockperf: =3D=3D version #3.10-no.git =3D=3D
> sockperf[CLIENT] send on:sockperf: using recvfrom() to block on socket(s)
>
> [ 0] IP =3D 10.9.9.1        PORT =3D 11111 # TCP
> sockperf: Warmup stage (sending a few dummy messages)...
> sockperf: Starting test...
> sockperf: Test end (interrupted by timer)
> sockperf: Test ended
> sockperf: [Total Run] RunTime=3D119.999 sec; Warm up time=3D400 msec; Sen=
tMessages=3D2400055; ReceivedMessages=3D2400054
> sockperf: =3D=3D=3D=3D=3D=3D=3D=3D=3D Printing statistics for Server No: =
0
> sockperf: [Valid Duration] RunTime=3D119.549 sec; SentMessages=3D2391186;=
 ReceivedMessages=3D2391186
> sockperf: =3D=3D=3D=3D> avg-latency=3D24.965 (std-dev=3D5.934, mean-ad=3D=
4.642, median-ad=3D1.485, siqr=3D1.067, cv=3D0.238, std-error=3D0.004, 99.0=
% ci=3D[24.955, 24.975])
> sockperf: # dropped messages =3D 0; # duplicated messages =3D 0; # out-of=
-order messages =3D 0
> sockperf: Summary: Latency is 24.965 usec
> sockperf: Total 2391186 observations; each percentile contains 23911.86 o=
bservations
> sockperf: ---> <MAX> observation =3D  195.841
> sockperf: ---> percentile 99.999 =3D   45.026
> sockperf: ---> percentile 99.990 =3D   39.009
> sockperf: ---> percentile 99.900 =3D   35.922
> sockperf: ---> percentile 99.000 =3D   33.482
> sockperf: ---> percentile 90.000 =3D   28.902
> sockperf: ---> percentile 75.000 =3D   27.821
> sockperf: ---> percentile 50.000 =3D   26.860
> sockperf: ---> percentile 25.000 =3D   25.685
> sockperf: ---> <MIN> observation =3D   12.277

Those are the numbers from the original measurements, but I confirmed
with Ivan that he re-tested with v3 and the overall picture was the
same.

> Fixes: 0bcd952feec7 ("ethernet/intel: consolidate NAPI and NAPI exit")
> Reported-by: Hugo Ferreira <hferreir@redhat.com>
> Reviewed-by: Michal Schmidt <mschmidt@redhat.com>

Yeah.

> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
> Changes since v2
>  - eliminated two writes in hot-path (thx Jesse)

I like this improvement.
Michal


