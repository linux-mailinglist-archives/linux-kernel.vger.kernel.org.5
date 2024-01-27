Return-Path: <linux-kernel+bounces-41063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7902683EB10
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 05:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38B6F284668
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 04:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D9A13AF9;
	Sat, 27 Jan 2024 04:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IJxfGwe0"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB760134BC
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 04:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706330756; cv=none; b=G03mQYZgjXMtnakDaDJTfIJNGHxnMjsUa0h8TP0FkXzj7F9V3f9z52bBgHtKmWZcGnlWhPQ9HebMcRoO/JkmCDb2aPNKfVKOABObFwxgWb+dsxBABcic1hTr46Zp2o0jqaiKZQfuuS5UfLn0dlSiXyvHMuYMe/7nB9vviXlqZ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706330756; c=relaxed/simple;
	bh=V/NOwST42Jbm8oopgISrDQoI6wbLk6HT+/BOxPJdjFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i/lyjDJYhzPUEoywGLbxITr0ypbAAAGLWM/jMQb82NuIwF/YlxkIqJCRtsfDyczFbd1bY0jLf8C1rr0Ta448yB+vagfRlwWoz2r1YCRbnMZTX1lp1HoZ2eAWQFc/Vd3Uxtt+0nooxAotGj/rzGw9Pzdcif945cq14DEtfuJE9nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IJxfGwe0; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d5ce88b51cso86255ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 20:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706330754; x=1706935554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/NOwST42Jbm8oopgISrDQoI6wbLk6HT+/BOxPJdjFs=;
        b=IJxfGwe07HUv0t+/5Q+0XzkaCFvfhD1SH76mvI7x+3s2hhVcKzeiRWiSybreblJRC3
         4I7CwCkbcBJnbDqnwiX978lEqn5EoyZCDNTp4VJV4w6S5us0taYGoqztKAnwFSdynFgo
         7NwbSKJkz/KeA48CafuCQltRf8gGG9y2PGFAQsrMudnrPXbIb4khRhl+tctpOeK+A9Ny
         Q8wodwOw0uS3wmhoUU4o+3aczD6mz2UTIS7o+MPAQPm/mE4Uk1jSvvNs1GlbrjGpTB03
         T25U3OFATEcw97lY9JRx923TpSiJPPv6sX4dz7Dl8qYkpsCsExth9NRAA9qcJrv3y4mP
         kS7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706330754; x=1706935554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/NOwST42Jbm8oopgISrDQoI6wbLk6HT+/BOxPJdjFs=;
        b=DvhvPFcxsAJeb/ii4sT0PMLoBsLPEg33ybUbTniZKxs/YbtctkQf4NrtxkmRhPPt7v
         z8+PXifdVNNgKS6awim1G5Ia/qrrlh+oJ3NUYP7LzfOD4bDNi86zvqvLlF5st7MfxIYs
         9xzzBO3nT1wDJDOgNTdtN8KYzzOWO72UHVXjlbDM5dLvOL7VdyUfzi6HqDllT5ZEFv7k
         xGfI4o4G2hVPaP3TuUW/Bs2Ys7g9HY5ew8s0vedrF5mOwTqcib7yDCBFleoi6cifMSlr
         up2+pkLQuq7Vn2oQqVmUzDtLgfX6NJPgWuRkbkmV3c6VuirkJnK+JY/KRvOne1Cj0xb9
         HeLQ==
X-Gm-Message-State: AOJu0YweV2pgFqMGnWIpJFvNS+HSQ/IzJRzFTragrsQhubD8zC3f9PQo
	uhOKMeF99iZ0GotQusO5US3PeCJ6pNLP1YkSUK7YpdJ2jaQrT9voFONXYnPz4Sx6wa6MjUPJ1Hm
	kVHb5jAu1siNGpsNG6bRApeKC6PbHbj9jWBed
X-Google-Smtp-Source: AGHT+IHVc0d8RC8/2wTXxlYYW8JNKDWGOHCUaK7EIPlANHI9tnbz5U6dw1KFZGzncnNcVLYDOLaefR4xpMsEt37gzYY=
X-Received: by 2002:a17:902:c403:b0:1d4:55b3:45d9 with SMTP id
 k3-20020a170902c40300b001d455b345d9mr362931plk.6.1706330753913; Fri, 26 Jan
 2024 20:45:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127025756.4041808-1-yangjihong1@huawei.com>
In-Reply-To: <20240127025756.4041808-1-yangjihong1@huawei.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 26 Jan 2024 20:45:41 -0800
Message-ID: <CAP-5=fWDbxO83ajAAL6hwL8=eXA6GJAQcJS7sorF2kd7gW+nvw@mail.gmail.com>
Subject: Re: [PATCH] perf evsel: Fix duplicate initialization of data->id in evsel__parse_sample()
To: Yang Jihong <yangjihong1@huawei.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, adrian.hunter@intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 7:02=E2=80=AFPM Yang Jihong <yangjihong1@huawei.com=
> wrote:
>
> data->id has been initialized at line 2362, remove duplicate initializati=
on.
>
> Fixes: 3ad31d8a0df2 ("perf evsel: Centralize perf_sample initialization")
> Signed-off-by: Yang Jihong <yangjihong1@huawei.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

