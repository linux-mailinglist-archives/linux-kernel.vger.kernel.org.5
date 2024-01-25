Return-Path: <linux-kernel+bounces-38905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAA083C832
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44FA5B23884
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 16:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8781012FF8C;
	Thu, 25 Jan 2024 16:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1x5+3VZQ"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427907CF13
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 16:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200607; cv=none; b=lA0yLm7NyRJ6baIgpeI980fUbiOeuen4unymlvWcGaXW/nTPJHV1cX/Lw1Wv8mS+khXIKWtTVT1rNkGFco9B3D9UGtgxpYGaS7riKEizHmQNUm36RP9B3Sk+d/6l9olhm/bt10QIu6cJJ55GK0Ac3Dp6vhhvfhEj9GLqyUHd0Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200607; c=relaxed/simple;
	bh=TgqytwWp7U4K2K/6mjOcV2/y4Ac8tA/cTLPLmfZOm0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h8ijG0utiy/lyPcQkWtNVhVn7dT2VQVLmDt8Rg1WVPaiw3mhmZZRzjSCrFamrxlmOWfnabI1ShyL0x+BiFCdTZzcPnxSEu7CNlGBo2Czv39ruHuTDZtxbxnAIWbjVTxkFSwS6MSZJz1qWG55rSLqPef5n7n8Xj6UVvG+7AxkZgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1x5+3VZQ; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55818b7053eso19164a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 08:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706200604; x=1706805404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PzhKLh+3d9yOMQ6X8ivbWXymcJAfh+tVgCfjU+pI7Kk=;
        b=1x5+3VZQnUG2x27UCEDs/pdGO4igqEnhd+viSfAEfCuRIZPYyk7UwDBOsQoFhNaN1b
         86EkB+Q2P7e6SWGKdrPzXA1QTZ9piIfK+zgdOkfg9dzjBa4Wg92ZtouBRpByCT2ThTV5
         p1s67Sw2eZvc8gA1ptX+4yMnKQdd6tKDxUVuJOVwp9JckZCgY0XeY4HPQmUuzWAEb3wQ
         /1v3BDS2Y07fKoE5UsJ1hi6OzyWlgRREza89wcVDYV24CUcOiPrcfLu7bXxrQbiK/XDf
         nwsZKtivVFP/Dv8ZYZJu6lyngWLDFeGohSupF2S86J09+YtXqkIYj/zp0TEY/8lPnTck
         Fsuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706200604; x=1706805404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PzhKLh+3d9yOMQ6X8ivbWXymcJAfh+tVgCfjU+pI7Kk=;
        b=FBOFd3nOAPh7M4DB6RL6QQucq6DCUV3oJPljpQn5LuZ+U6X5AInHtrX7LSERIXpPha
         xrmHe9EBhHVzI41YMGBAxOZTyDQZTtnswB4h7Z/6bnx7T80C2HltrgaGTXfqRfkEdXdk
         i9MA6Qt81WmuplriTMpDW7lA4UXdwdulz1H3aX/rjj7J+o89EfodTzA3uTOXAcbIzfHp
         jJ9xBw0zqU2LSQijrBU9Ip14X4owpgGOsAnSMHg+T5szwA2Rq/QajizhlNTy/10wPpAh
         a+Zr85C+p9CR3TsPziOnjvOwgIeJ7Tso/lKZibBec0A25FT06O2uDEoV1DA1fvCtwhvN
         h/Xw==
X-Gm-Message-State: AOJu0Yy0fNl6LEx6IBfXDhijG6+Vw4QSpUZnTpYnfKKx3QelnLsWVYmC
	zndV6qeZ39Uapn9jC/ghRA3igqc6ha4LTEq0H2OMIxs8sI1ngT7UmE+x4RYff+TjeodnUAfoAKa
	/Fu7ka/MhS0JWnEw6aXZwVrj59s0sX/xsVyxG
X-Google-Smtp-Source: AGHT+IE8Ob3eSw97oGgRaHA4aa3G3QI4B9MxmUAXtlZVNaBjYW+O7d1zFhaIc8srSbGwvw91lb7d+tmh6zH4S3XN0xo=
X-Received: by 2002:a05:6402:1c92:b0:55c:eb69:979f with SMTP id
 cy18-20020a0564021c9200b0055ceb69979fmr185588edb.7.1706200604261; Thu, 25 Jan
 2024 08:36:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1699104759.git.quic_charante@quicinc.com>
 <a8e16f7eb295e1843f8edaa1ae1c68325c54c896.1699104759.git.quic_charante@quicinc.com>
 <ZUy1dNvbvHc6gquo@tiehlicka> <5c7f25f9-f86b-8e15-8603-e212b9911cac@quicinc.com>
 <ZVNQdQKQAMjgOK9y@tiehlicka> <342a8854-eef5-f68a-15e5-275de70e3f01@quicinc.com>
In-Reply-To: <342a8854-eef5-f68a-15e5-275de70e3f01@quicinc.com>
From: "Zach O'Keefe" <zokeefe@google.com>
Date: Thu, 25 Jan 2024 08:36:06 -0800
Message-ID: <CAAa6QmRnfTOCD0uaxVbbiDRWtwzC9y+gZDFOjYF2YWDTrXyMNQ@mail.gmail.com>
Subject: Re: [PATCH V3 3/3] mm: page_alloc: drain pcp lists before oom kill
To: Charan Teja Kalla <quic_charante@quicinc.com>
Cc: Michal Hocko <mhocko@suse.com>, akpm@linux-foundation.org, mgorman@techsingularity.net, 
	david@redhat.com, vbabka@suse.cz, hannes@cmpxchg.org, 
	quic_pkondeti@quicinc.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Axel Rasmussen <axelrasmussen@google.com>, Yosry Ahmed <yosryahmed@google.com>, 
	David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the patch, Charan, and thanks to Yosry for pointing me towards i=
t.

I took a look at data from our fleet, and there are many cases on
high-cpu-count machines where we find multi-GiB worth of data sitting
on pcpu free lists at the time of system oom-kill, when free memory
for the relevant zones are below min watermarks. I.e. clear cases
where this patch could have prevented OOM.

This kind of issue scales with the number of cpus, so presumably this
patch will only become increasingly valuable to both datacenters and
desktops alike going forward. Can we revamp it as a standalone patch?

Thanks,
Zach


On Tue, Nov 14, 2023 at 8:37=E2=80=AFAM Charan Teja Kalla
<quic_charante@quicinc.com> wrote:
>
> Thanks Michal!!
>
> On 11/14/2023 4:18 PM, Michal Hocko wrote:
> >> At least in my particular stress test case it just delayed the OOM as =
i
> >> can see that at the time of OOM kill, there are no free pcp pages. My
> >> understanding of the OOM is that it should be the last resort and only
> >> after doing the enough reclaim retries. CMIW here.
> > Yes it is a last resort but it is a heuristic as well. So the real
> > questoin is whether this makes any practical difference outside of
> > artificial workloads. I do not see anything particularly worrying to
> > drain the pcp cache but it should be noted that this won't be 100%
> > either as racing freeing of memory will end up on pcp lists first.
>
> Okay, I don't have any practical scenario where this helped me in
> avoiding the OOM.  Will comeback If I ever encounter this issue in
> practical scenario.
>
> Also If you have any comments on [PATCH V2 2/3] mm: page_alloc: correct
> high atomic reserve calculations will help me.
>
> Thanks.
>

