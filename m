Return-Path: <linux-kernel+bounces-137493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8841189E2DE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 21:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BABB71C2289C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AE615749C;
	Tue,  9 Apr 2024 19:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="O3H6unne"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385A0157A48
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 19:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712689227; cv=none; b=p1BzVZGJxg70ga8slR4rl1f+RpgcEfkhvFRL0N4UoFDwIoFM+3/1zFY7zIQZGZY8g/7JaUEXwcc3oN0KsrZlA+SDtg6qfoHwEkisbqIk2aHEt1hxNWwHbBdJ6gXhLXpAQseTpD7PbHrcL+TMltghq3x3fxnLjBk7hFqWnlBZwok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712689227; c=relaxed/simple;
	bh=sKjDn1VUyv3xKTnhS+ZfRKeoso++HGRzElJEX6ZqbIo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MgOsU91YFgbjGPC223GzuI/l57yhK2uPQ1bmYZvcJpy/2r3aMAtvJg/SCRIFXRdzvnzaUEkmVfmUpyRbxWYOl1cPoyG7nFNcmlk7tDEJDi9IyJrtuJsbqDK+LM4ReNBf1fVJdUbKgvnWEmdy7ZfUCSd8fdQ6td7/RzGfNls1x8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=O3H6unne; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dcc80d6006aso5830940276.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 12:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1712689217; x=1713294017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5CBvcfp0rqG8/aCbqDf2QUOPCz/n3wHa5btTw1mm84E=;
        b=O3H6unneIn+4CDzcZC1LjwiFyECB8Vz7OKk6wL5bgUrlWs0LMzYoPUA4oIXYu1O65C
         NEKsMM5NJT7p1tgRO2sOzRUB8IAIF6oNd/zpUvEdFSAVIHNhbMxSAH2eDaujD1sNEzo4
         cgkhPLt1FULr6NChXj8ow2Chfa6OyCWlMMxGEwaBxl1AJvUGWdSjMC8K3ajZAWwCJXu5
         xUU3jfhkQUwjPhG7ZK66GKvzERTx7c4MjJqIPsnzZFhkfl2nr4pp31JIfBp56TBl75Md
         bxPBZeczAQ2+8P9AxPg4zboCWV2yVXwOXn3O0RJUJkzFTj4EGytYCjWIL9H5ICu9tlx7
         rwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712689217; x=1713294017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5CBvcfp0rqG8/aCbqDf2QUOPCz/n3wHa5btTw1mm84E=;
        b=n8qfSGKxrUHDH8W82lqlqgv4qWmI9BuojHCn4jMrJA7sT872sWscd/q0W3KCbtVNHF
         ZG1GPF1Jqq4mEN2qPB4H/dy0PTl1Ut+kzMLk58VS9Ye1I37UpZg9cGoyaMCuiGN5gsvt
         /dvCnsLnigBMfteCHcYV1syXCykv3MCAOnCHATUBm4sNBaQMjQe2kJtu5as9NCGmHuhb
         tE5hJkMYB5/H1xEUingQaMwEO2hvgtfH3Vm/osqY0ZDdkSdufAHAIfi4zrVB3SYTPDJf
         jMgde0MSEfvL70LhQClQvrlY9jHyXhsS4PCladXmEemos5Lu47CwbRJK7rWceI1hXScD
         OplQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdNekihXWD1T4ADpIEwAkEOpS5kGIOPWz0zD0MdUJARmugslcpJYDqcebOnL8FB/e+kgNU2D/9A5BVi2WpGz0q3EGHpTjD6BZJ4Pwi
X-Gm-Message-State: AOJu0YxFGoYs9TXpMoBARsjQYAZFBIZDDK/1cV8MI8evkb4vpcx0mENP
	Ww2oelnmTpVg4ssaOj6vpJzuhka/akzuRi8IXKb0XwqQep3ZdSFs1mmukkLhjNLFN5WWPwgFOsv
	YsM8pUvHRE9Ro2lSlif7zExcBTHJMpq4+TmwytQ==
X-Google-Smtp-Source: AGHT+IGW6ppz/qE4BrLvmNCRDbTF9xfQE/vBrRFhezaSlxNTiNANoYpDGSEDGNZJ8OzMKjviuEREaTWu0J3o1ZesD1c=
X-Received: by 2002:a25:2748:0:b0:dcd:ba5a:8704 with SMTP id
 n69-20020a252748000000b00dcdba5a8704mr700084ybn.24.1712689217227; Tue, 09 Apr
 2024 12:00:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405000707.2670063-1-horenchuang@bytedance.com>
 <20240405000707.2670063-2-horenchuang@bytedance.com> <20240405145624.00000b31@Huawei.com>
In-Reply-To: <20240405145624.00000b31@Huawei.com>
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Date: Tue, 9 Apr 2024 12:00:06 -0700
Message-ID: <CAKPbEqrTvY4bsRjc=wBWpGtJM5_ZfH50-EX4Zq2O_ram9_0WbQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v11 1/2] memory tier: dax/kmem: introduce
 an abstract layer for finding, allocating, and putting memory types
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, Gregory Price <gourry.memverge@gmail.com>, 
	aneesh.kumar@linux.ibm.com, mhocko@suse.com, tj@kernel.org, 
	john@jagalactic.com, Eishan Mirakhur <emirakhur@micron.com>, 
	Vinicius Tavares Petrucci <vtavarespetr@micron.com>, Ravis OpenSrc <Ravis.OpenSrc@micron.com>, 
	Alistair Popple <apopple@nvidia.com>, Srinivasulu Thanneeru <sthanneeru@micron.com>, 
	SeongJae Park <sj@kernel.org>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	"Ho-Ren (Jack) Chuang" <horenc@vt.edu>, "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Fri, Apr 5, 2024 at 6:56=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri,  5 Apr 2024 00:07:05 +0000
> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> wrote:
>
> > Since different memory devices require finding, allocating, and putting
> > memory types, these common steps are abstracted in this patch,
> > enhancing the scalability and conciseness of the code.
> >
> > Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> > Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawie.com>
>
Thank you for reviewing and for adding your "Reviewed-by"!
I was wondering if I need to send a v12 and manually add
this to the commit description, or if this is sufficient.

--=20
Best regards,
Ho-Ren (Jack) Chuang
=E8=8E=8A=E8=B3=80=E4=BB=BB

