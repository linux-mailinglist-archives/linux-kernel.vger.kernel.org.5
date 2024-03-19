Return-Path: <linux-kernel+bounces-107347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E2F87FB4E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:57:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E9B01F2271F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5282F8063E;
	Tue, 19 Mar 2024 09:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VuTCHN7X"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A96B7E11A
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710842045; cv=none; b=QcqmoANskMDcmGLETRRKVcW9aCTOxMXXA8nmQ2P+ZwcDYlqHNALI6sRFUKJ6gy0iaKxg5PedHLm4MBDjR49BsX08g+7P5l772xRE0NmxYMCjfEfls72usUxNPyDwsTUoBe/B5+u9f6y+673iAzlo9Zox80uEkOaYty10gbpshKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710842045; c=relaxed/simple;
	bh=MQ9HHbdPS8+JI63xBWLs9D0CqR4PIpQVUXpwbFb8Yp0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p00B65vurtXptMFEeeG2/ZCkfUrIjiy6Beo1SJ9T2kuyKcMMxJu19Zt1c5vsdHt2QK4TtWn+2rS12ov3qSqlZHBtj9i2kY1aqIgeowKWJKMHp4m74unCEqnVh8VSMcHb2a391pNXxV6T7jnl0HzjK9ufINep+7ubnCdkWraWwkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VuTCHN7X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710842041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=huubYUDUToyqq9krPzQhPuLvY5vBhK3/v+f/Pk52wRI=;
	b=VuTCHN7X2/ayUGAUs55hxA6lLobiIE4XGdxOxNMCeoDjg4X6qpm+YaYGujV2Xt1sxNe5d3
	vtlZB3zjR4m9quk8cLY5cUt7rbFmj/BM62JgVWuZC9slnEdPCo5uRX0TzztyY+gl/dhRFf
	sFBMbsW+eJVKITXR+BoaTYkhOUiJL20=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-JIREjtCrPPy12nfWRGBZ2Q-1; Tue, 19 Mar 2024 05:53:58 -0400
X-MC-Unique: JIREjtCrPPy12nfWRGBZ2Q-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a468895a00dso269456266b.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 02:53:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710842037; x=1711446837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=huubYUDUToyqq9krPzQhPuLvY5vBhK3/v+f/Pk52wRI=;
        b=OccrXktYOz1kNcO/ic02cWOUWpjXuE2QxbslI4ovi7jrUC2VJ5FUWs0OJ92kHQxLbN
         sK3oFsH7SaqfFQdt2sVutjjXq/bEpyJj0g5s9S+Ip2JvUw+BFCkPO+CKm8apsG7aMg0v
         kiGRJCMIQvidJU0wCnJluqPvAmlBBRjzZX1zwx+BHIJLbvheO4yu1SLBLCYMkMde3vsE
         TFjCDShmPDFsIQ0/+JjxSy/K9glWDxwKB7FvBJljGGUBU5f4DrTnFrJKFwOASd8N6PGa
         okFsGJEVhS61Px4+vJcsKuECU9X0pFDSwSlBC6ApVLEBZPjUyJeJEV5sN+3wIlxDJqE3
         JjfA==
X-Forwarded-Encrypted: i=1; AJvYcCUeCqaiEB+9ScnolVx5soUnISdHX3jRC5EkO/Ow0aO+5KX5XFvfRMJx+21Oma1ImujW94EUu/vQBX15bWJ8Cb2mhg99eNTWlj2MYJEn
X-Gm-Message-State: AOJu0YxgWuqLCY8P9JFX2Jz4wliXTeavwkAHOUH5vre94fFGab2Nvi/v
	K/8m6XRZ1impc+FDjxVStTJR7bV0lQoxQVEdswutMOVOP+ifuskOoNXjXbpzEIkBwmBqRrOe37F
	m36FRYVu1BMEo6JLJLWNNfeV1zVI3ENsxhLWlbtX8tFdGHuO/lfJoQ9+9FHSMFcMuZocdgIhSd0
	AK1GkzMjAvPUW5Er+Q3cLtHUCpZgMs/IAg0HjP
X-Received: by 2002:a17:906:c1c5:b0:a46:6faa:2b8 with SMTP id bw5-20020a170906c1c500b00a466faa02b8mr1279785ejb.68.1710842037239;
        Tue, 19 Mar 2024 02:53:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEi0AFEaSTgIutppuvHx8wkcKGVsW13LDh2HlG2CLXtPRG0kWeJmpUyYDwazcub07/XGqzu503Rc/iLvyeHG9c=
X-Received: by 2002:a17:906:c1c5:b0:a46:6faa:2b8 with SMTP id
 bw5-20020a170906c1c500b00a466faa02b8mr1279769ejb.68.1710842036919; Tue, 19
 Mar 2024 02:53:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240316113830.230718-1-ivecera@redhat.com>
In-Reply-To: <20240316113830.230718-1-ivecera@redhat.com>
From: Michal Schmidt <mschmidt@redhat.com>
Date: Tue, 19 Mar 2024 10:53:45 +0100
Message-ID: <CADEbmW3C5y4gFzRsNW-V_DTUZimxh_AT5Ohr-KH8R7DXz38EGg@mail.gmail.com>
Subject: Re: [PATCH net v4] i40e: Enforce software interrupt during busy-poll exit
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

On Sat, Mar 16, 2024 at 12:38=E2=80=AFPM Ivan Vecera <ivecera@redhat.com> w=
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
>
> Fixes: 0bcd952feec7 ("ethernet/intel: consolidate NAPI and NAPI exit")
> Reported-by: Hugo Ferreira <hferreir@redhat.com>
> Reviewed-by: Michal Schmidt <mschmidt@redhat.com>

Yes, I am OK with v4.
Michal

> Signed-off-by: Ivan Vecera <ivecera@redhat.com>


