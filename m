Return-Path: <linux-kernel+bounces-137687-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AB589E5F1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 01:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A72051F241A3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 23:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC338564F;
	Tue,  9 Apr 2024 23:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="lHXtJi8P"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA731158A35
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 23:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712704205; cv=none; b=Tnts1D4C1rnKtAyPiTiM0y0ECZ4F9ssJsjlv+v5pKigWqF8lJRXnFIIu2M5o6AvBSlwZkamcYfYldR2d91j+QoazxXUdrsS6A2NCpTWPVx6wf8JI5yAMWYvbzY501H84++GD5yyS+h+hM30Pc444fSI99RtUqwrMXA2L8v4Ynu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712704205; c=relaxed/simple;
	bh=MnSBREf1/ZfgMhsdgHA0pvIo22AgghcA4rYn6itMmko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GwCf5cB996+Ukts8i0haPDQJFr0xOAdGu0v+JW7LAanii2vHQtAowzd+0uEWrKMbFyttQN1boPAfYURJmhaEGMW3+/zMfL3DtNVYtX3GM+UzsGsdWOFxrtNtzdCwTgzgRZr2BWYVY1E+RHx3CyX+ncTxSFqmkPNH9fBsbfxuhhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=lHXtJi8P; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc6cbe1ac75so4666669276.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 16:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1712704203; x=1713309003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBQMpIqEurG8MF/tPT1PXk9SqhO/wjdruY1OsEdLqVc=;
        b=lHXtJi8PI+x57bhfWrfVxHMmH5ZBk4DrD5/0lSFHvimPxy/HahcG/uX4eCJWs/+gQU
         rEn3i5g/mZBbrrWslTTH8obEeJcXwbUxmUzMeqniC3mfG4x0/3IXWYkIG+XEXaTgHPs6
         KTZAWCuPBlwp06JLkBk/wtmmM/9ZZoNI4ELsdcUxCyXy8etcE9/T0Jso4oxj/oJ4PMWS
         /J8DnhmD8qIZCN7jZXaL4z6gE06SUpw/xS3q58o9k91ByOYQSKdQ6lD12bTZTRW/dQWT
         li/AGe7rxB+cwDYV56Q5Iif6Hiu5L5Arl4K4kkX/k/1Nf17HDE8EeL4fPevNzjAB30uQ
         YjMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712704203; x=1713309003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBQMpIqEurG8MF/tPT1PXk9SqhO/wjdruY1OsEdLqVc=;
        b=evI9i5Sso24KLo8zFSvGtvnFD20IpMbMM9TfvscF/FlY0k0yOoKXUTPLIdWXJqWqON
         qSEE3zFFbSuXv/Yv18ZhbM1AZbXojNEQGGBbJPHYeL5YoL9+yjsybzB0rtdT8qF/Gpuf
         5vghPLZoZsKHbqoQ3czSmoH2y/G+S/S4AkdEM6GFKLkLdovVBjYeMwnDJFRrwaJBWyEr
         CXq89b8lvhhKO+m6vbdiHc93ykEsUZTYIZMxH6pIuN8LnTRa6CH8B/crd4rloBhDBdUc
         Z87TdiTJQpnXeyKobo4u0iYQbv0XjsuwHf9ln9vJct1Gg9F0Mn/Ox/4TfIYkUanBL1uN
         xuZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVt94ig6l1Ul7JW4Lrrd5EfEEoW5L8xrSBohBltMT+c9IhXIx/2/3GEvYJa/CWqIn+hC1xS7lYdBjYwFlDJd5DPMldEiKiN4Yd/X3Rr
X-Gm-Message-State: AOJu0YxpXgYWBWqcyLc/nkGv7Bbev6MmWCj0uocNckZBCOGykGTzwZdy
	P/OsyAMTEJF/JRhBp6twGIt0OAUbuEK38LA3rs0EQxqjn4iacuxtlZXhLaBrLVphZP0p8Q615VB
	c/rPb0wneq/UQFo0/JuUnT+ACbSA2oskEB6A/dA==
X-Google-Smtp-Source: AGHT+IGKj70giI0uSMILbO3VPM9mbHT4HM6rigAIadI6TUaytzdkRQBEfqv4b6oKHX4IAAJuxwSf30E0yhjaCwWCgiY=
X-Received: by 2002:a25:f306:0:b0:de0:cd0f:e9ac with SMTP id
 c6-20020a25f306000000b00de0cd0fe9acmr2372195ybs.31.1712704202827; Tue, 09 Apr
 2024 16:10:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240405000707.2670063-1-horenchuang@bytedance.com>
 <20240405000707.2670063-2-horenchuang@bytedance.com> <20240405145624.00000b31@Huawei.com>
 <CAKPbEqrTvY4bsRjc=wBWpGtJM5_ZfH50-EX4Zq2O_ram9_0WbQ@mail.gmail.com> <20240409145018.e2d240f9a742cc15ff7bc11e@linux-foundation.org>
In-Reply-To: <20240409145018.e2d240f9a742cc15ff7bc11e@linux-foundation.org>
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Date: Tue, 9 Apr 2024 16:09:52 -0700
Message-ID: <CAKPbEqqWLrD-bJiyE9Yc0CYLh_8_uMtf+9nD_eenXh3S=Ro=pQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v11 1/2] memory tier: dax/kmem: introduce
 an abstract layer for finding, allocating, and putting memory types
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, "Huang, Ying" <ying.huang@intel.com>, 
	Gregory Price <gourry.memverge@gmail.com>, aneesh.kumar@linux.ibm.com, mhocko@suse.com, 
	tj@kernel.org, john@jagalactic.com, Eishan Mirakhur <emirakhur@micron.com>, 
	Vinicius Tavares Petrucci <vtavarespetr@micron.com>, Ravis OpenSrc <Ravis.OpenSrc@micron.com>, 
	Alistair Popple <apopple@nvidia.com>, Srinivasulu Thanneeru <sthanneeru@micron.com>, 
	SeongJae Park <sj@kernel.org>, Dan Williams <dan.j.williams@intel.com>, 
	Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, nvdimm@lists.linux.dev, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	"Ho-Ren (Jack) Chuang" <horenc@vt.edu>, "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 2:50=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
org> wrote:
>
> On Tue, 9 Apr 2024 12:00:06 -0700 "Ho-Ren (Jack) Chuang" <horenchuang@byt=
edance.com> wrote:
>
> > Hi Jonathan,
> >
> > On Fri, Apr 5, 2024 at 6:56=E2=80=AFAM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > >
> > > On Fri,  5 Apr 2024 00:07:05 +0000
> > > "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> wrote:
> > >
> > > > Since different memory devices require finding, allocating, and put=
ting
> > > > memory types, these common steps are abstracted in this patch,
> > > > enhancing the scalability and conciseness of the code.
> > > >
> > > > Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> > > > Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawie.com>
> > >
> > Thank you for reviewing and for adding your "Reviewed-by"!
> > I was wondering if I need to send a v12 and manually add
> > this to the commit description, or if this is sufficient.
>
> I had added Jonathan's r-b to the mm.git copy of this patch.

Got it~ Thank you Andrew!

--=20
Best regards,
Ho-Ren (Jack) Chuang
=E8=8E=8A=E8=B3=80=E4=BB=BB

