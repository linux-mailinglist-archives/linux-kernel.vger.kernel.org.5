Return-Path: <linux-kernel+bounces-67458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D61856BCF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D5EB28E419
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0B6138481;
	Thu, 15 Feb 2024 18:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GmbKBNpT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7B7136644
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 18:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708020030; cv=none; b=KzJX267bIndBletA5D6pa0PWcweOwRVkB/7qyyvZ0lRvLNtymxivDqWwM/3fU+hfv0EdTNez5iFMXmW8SpMds/33y1bVnfH29neIu1+IOO6KP2tBx82FZ611Ur2BP48RuXAb2wym/7UZV5RPntdi80WJFEsY9efjvnT5egBB7ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708020030; c=relaxed/simple;
	bh=Ewks1KSKMZE/5FKOLwqiLlEnmGTEup08tVXYlkkXo/Y=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a1r8RcT+G03FXG7eK949DADLXFQqU8GC2cRyMH9mqYHoP1NXBFueluIF9YfPpPA7wqS//cBKRkELFO/AW0ewMh9D3UD+aL0xTYLKE24OS8ua5eGQIjHniuYGJMmGlepAnbWRTSATAryqmyZj5XlS9o4j5VzZY+W6jtB+EHZSxMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GmbKBNpT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708020027;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/G5lguk93gTD6qpeik1vqHfX1oWMt+Ae5AYgN6rGWcE=;
	b=GmbKBNpT4FKYxhgGwKHH2/tr9YRrN913tu7GCxWGu57H611yQvDNO/YfiAcExLg/CRcMmx
	DxBdRZOyNSvBsLkU3qqUJGlMVydXV9Vx4FOVNZU50KHDgnXeGwLUJqKR4BStgSQdZFZ9FT
	95nbgIz6GHAdCwi35o1G1pHjy0JwIlM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-9bFbDpNnNeyZiVjFBAEHnQ-1; Thu, 15 Feb 2024 13:00:25 -0500
X-MC-Unique: 9bFbDpNnNeyZiVjFBAEHnQ-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-561601cca8eso773097a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 10:00:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708020024; x=1708624824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/G5lguk93gTD6qpeik1vqHfX1oWMt+Ae5AYgN6rGWcE=;
        b=Emi88nWVwV+Kg72nBoZAYW13sNYPneJ7qUsC4IIY+wTIBXgsTBFDWa8JiRGuGgfvS+
         DxckMgZ0jHpd1THJeHYebabWwkRTCWPOew4C3bTW6pNc4hBVtKYdBqKiDWay5e+ctIcZ
         H8gv5YAivxr7gETKh4TD4LuDA4Xbvsp51B/ngwHuWM6ZzuOnDGjxEXjeOYh+n7q3sXJH
         4Nba+mDZ6UHuVE7B+CSHubxEIh8Nbgzu1UnyZtInDdKzFX36eF9tl6N8a3ys5vtGe5Zp
         E1G6z7K9DZUkucxgNElM+Pmy8qRC+MWNwT2/6J15CicHRVoyUbpSPH13h1lvdP2T9T37
         QU0w==
X-Forwarded-Encrypted: i=1; AJvYcCXIYdLdI1wMv3Qk9YXVZes0H/fRpVkjX5LcSMV6xCQHCorVlbtv7/KP64CS29vHtEwOUzKTwz80m1ePd9ttYcdGiqBI3G8EkGHOJHbF
X-Gm-Message-State: AOJu0YyyNgcjnoetZ/j7YJML4k4r9wPN0b+9lEFs7Xphd8YfY2r9ZMJG
	zCxxsInhrTKsrtVHsf9bAg1aQPswS10Kthz1EdGwDwByXfK5BeKKSWQMAv9VyPrK+q3EzJs8g03
	C+8PRJiK8WQmgcY1fJDDHPh8Ew5NVQX+7LHbtz1rxfD6IJLGWM2On1++BEWMsbXhQOwCWK5gT7o
	BINmwk2ixhTcEkJezFl6uqN3FYXhRuoX+4MQul
X-Received: by 2002:a50:ef0c:0:b0:55f:fc6f:835a with SMTP id m12-20020a50ef0c000000b0055ffc6f835amr1945638eds.31.1708020024810;
        Thu, 15 Feb 2024 10:00:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGt5/2XZHqnW+bw+e2xQmI5SA0wHRscwwZ8k8k+My0Czfk4P01c6nuWd39BUwAH29EiSVWVAM2AqF5Up0waUHA=
X-Received: by 2002:a50:ef0c:0:b0:55f:fc6f:835a with SMTP id
 m12-20020a50ef0c000000b0055ffc6f835amr1945614eds.31.1708020024507; Thu, 15
 Feb 2024 10:00:24 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 15 Feb 2024 10:00:23 -0800
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20240215160458.1727237-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240215160458.1727237-1-ast@fiberby.net>
Date: Thu, 15 Feb 2024 10:00:23 -0800
Message-ID: <CALnP8ZZYftDYCVFQ18a8+GN8-n_YsWkXOWeCVAoVZFfjLezK2Q@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] make skip_sw actually skip software
To: =?UTF-8?B?QXNiasO4cm4gU2xvdGggVMO4bm5lc2Vu?= <ast@fiberby.net>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llu@fiberby.dk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 15, 2024 at 04:04:41PM +0000, Asbj=C3=B8rn Sloth T=C3=B8nnesen =
wrote:
..
> Since we use TC flower offload for the hottest
> prefixes, and leave the long tail to Linux / the CPU.
> we therefore need both the hardware and software
> datapath to perform well.
>
> I found that skip_sw rules, are quite expensive
> in the kernel datapath, sice they must be evaluated
> and matched upon, before the kernel checks the
> skip_sw flag.
>
> This patchset optimizes the case where all rules
> are skip_sw.

The talk is interesting. Yet, I don't get how it is set up.
How do you use a dedicated block for skip_sw, and then have a
catch-all on sw again please?

I'm missing which traffic is being matched against the sw datapath. In
theory, you have all the heavy duty filters offloaded, so the sw
datapath should be seeing only a few packets, right?

  Marcelo


