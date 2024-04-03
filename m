Return-Path: <linux-kernel+bounces-128930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FBC8961F9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B6060B2474C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD70134CC;
	Wed,  3 Apr 2024 01:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oJJKNcFm"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC7310A0D
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 01:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712107676; cv=none; b=dGrvvBVzfneqXZ2TxlVtmyMux2em7dPFzVSNk0AXKAujHKnryvCwQB47DqqmhCRGMNsDmhbwQEsa+eUHAeK5izT50JbkNz3shn8WIDgUcQsfpdwJe+Tjw7wKWNpup0AxNA52S7ZTNXyJZbuTGACoL+Xs9p/nkfDfTaCCGlwiMkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712107676; c=relaxed/simple;
	bh=MXLp3yp77JMMPgahmQKYx1uyysH5rs6wUobTgSMnXMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cjfjqZA3ix9Ob4PMjAzz/3qJTawJ9dj2ErqinvFK5k4bZ4ZvUTHxyOSfdGrACl1aKmu6GT04gVD1qo9NKTFVwIXxcVI9gHDCAdZaBoc4JwpOPfGX8R1aSXEWWwvYMZ2G3RQOa29N2uKChyjwIdbROvl1o0NXd9LRdVce4jE1vgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oJJKNcFm; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41549a13fabso22425e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 18:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712107673; x=1712712473; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ub2lEOHS3NTrD00AoqMzwICEXywrzBRjo8LYWU2Psto=;
        b=oJJKNcFm5B7OhWjBlM1y2qs8dlvHeFTBJag6jkyS+eAcjnevPKcgREx8+WLk0FJ/VJ
         5IBtFw526D7UdMehPv0sjYHjpW3kkLlD/+UQEs+Wwfb4WWeKMTpt5VHYpS7xSyTNAmbR
         Y2wnsRi3Vr8dXoyJtTUXCBQvZnPvcPi7OA4/nx/zH7NIUeOZBSs7XtsuoGWmL+0k7yCU
         Cofp5iSI89WvWF2Pi/Ag6sgKEdKI91YAn1ShIB7ZvKwxBzx5FIQKEqHWdxn2P7XOPzet
         vOg1fepZF25+tI/waU3dgfvegnPdB77DAaH43bF3r7kvuWwasXHgChB9sclNdcoNqsIL
         sy/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712107673; x=1712712473;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ub2lEOHS3NTrD00AoqMzwICEXywrzBRjo8LYWU2Psto=;
        b=URR72K1Ep4gzEMKPUJRjjRyatOh0KdDMn4fHAdopB/3htgbfIaHsUH7NCfuS9X0Z0R
         JJd0pe6g95BUwdklnmrhJlPMVfb1Qr2E7XAlcM85zI9gFeNAN0rzuLGYQY9OtKtPwHSx
         w2SmHLWRz5Nys3FP4dVlcBF1vZMr/pC/VijN8+yMbKOtYye1cC9Qj+/u2Zo4+6R0g9iZ
         NKhdREBuIYD+6hA152qIxd1x0QIMxa1zZAKfKM4QaoFOpU/2mqKgpiLw0ZZ04lpaI57X
         Xpnb0tP+L09uYINbNQIrOQcw0sf3RngFvzqqjtzbLEie2PwugECyXAr2+lgZi6RnIamo
         wBzQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/oaxQoh3XoQW0RjAlRAWbI0WJYwqaTgjxmLPTqDJ7tAdTsIf199Gi2kNVUzzbRPiF7uQsj2TekKJJhuf9xNmggFF8rOmLaeIgVwjN
X-Gm-Message-State: AOJu0YznP/WmwwJTY2iQclT3HNwpPJUmWnY78cScKlZH6PHBLHh6EU+h
	YRNDGIzB9FlgQW+D/5Mnqp3xS0JCsfn2bs6JR7c+nrYaCk3tm5Uai1BIzuNrBKxqehCl664lliD
	C4cVNQ2VAeleqsPkWNRYpDY5vbE0aW7JpiPY=
X-Google-Smtp-Source: AGHT+IGGzjjDQSyBqgXW5Gs7aSrbhSY/kEUyYRVCszg/ViujJY8ofkYLgT3+mmyX/91+QpIk0ednyCKCH9hyRgZjnd8=
X-Received: by 2002:a05:600c:3b18:b0:414:800f:f9b1 with SMTP id
 m24-20020a05600c3b1800b00414800ff9b1mr64974wms.2.1712107673236; Tue, 02 Apr
 2024 18:27:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20230901010734epcas2p4aadced02d68d3db407fda23de34601d2@epcas2p4.samsung.com>
 <20230901010704.18493-1-bongkyu7.kim@samsung.com> <CANDhNCoFRr=qizswLm-dzxJK0fHuCx98Z2B1pUspdwGqBEejYg@mail.gmail.com>
 <20240403012132.GA460@KORCO045595.samsungds.net>
In-Reply-To: <20240403012132.GA460@KORCO045595.samsungds.net>
From: John Stultz <jstultz@google.com>
Date: Tue, 2 Apr 2024 18:27:40 -0700
Message-ID: <CANDhNCpvKj6Swer-8DtQEotdnOiqfAg43oZLw_HZs6ogwqPwzg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Make reader optimistic spinning optional
To: Bongkyu Kim <bongkyu7.kim@samsung.com>
Cc: peterz@infradead.org, mingo@redhat.com, will@kernel.org, 
	longman@redhat.com, boqun.feng@gmail.com, linux-kernel@vger.kernel.org, 
	gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 6:21=E2=80=AFPM Bongkyu Kim <bongkyu7.kim@samsung.co=
m> wrote:
> On Tue, Apr 02, 2024 at 04:46:06PM -0700, John Stultz wrote:
> > On Thu, Aug 31, 2023 at 6:07=E2=80=AFPM Bongkyu Kim <bongkyu7.kim@samsu=
ng.com> wrote:
> > >
> > > This is rework of the following discussed patch.
> > > https://lore.kernel.org/all/20230613043308.GA1027@KORCO045595.samsung=
ds.net/
> > >
> > > Changes from the previous patch
> > > - Split to revert and modify patches
> > > - Change according to Waiman Long's review
> > >     More wording to documentation part
> > >     Change module_param to early_param
> > >     Code change by Waiman Long's suggestion
> > >
> > > In mobile environment, reader optimistic spinning is still useful
> > > because there're not many readers. In my test result at android devic=
e,
> > > it improves application startup time about 3.8%
> > > App startup time is most important factor for android user expriences=
.
> > > So, re-enable reader optimistic spinning by this commit. And,
> > > make it optional feature by cmdline.
> > >
> > > Test result:
> > > This is 15 application startup performance in our exynos soc.
> > > - Cortex A78*2 + Cortex A55*6
> > > - unit: ms (lower is better)
> > >
> > > Application             base  opt_rspin  Diff  Diff(%)
> > > --------------------  ------  ---------  ----  -------
> > > * Total(geomean)         343        330   -13    +3.8%
> > > --------------------  ------  ---------  ----  -------
> > > helloworld               110        108    -2    +1.8%
> > > Amazon_Seller            397        388    -9    +2.3%
> > > Whatsapp                 311        304    -7    +2.3%
> > > Simple_PDF_Reader        500        463   -37    +7.4%
> > > FaceApp                  330        317   -13    +3.9%
> > > Timestamp_Camera_Free    451        443    -8    +1.8%
> > > Kindle                   629        597   -32    +5.1%
> > > Coinbase                 243        233   -10    +4.1%
> > > Firefox                  425        399   -26    +6.1%
> > > Candy_Crush_Soda         552        538   -14    +2.5%
> > > Hill_Climb_Racing        245        230   -15    +6.1%
> > > Call_Recorder            437        426   -11    +2.5%
> > > Color_Fill_3D            190        180   -10    +5.3%
> > > eToro                    512        505    -7    +1.4%
> > > GroupMe                  281        266   -15    +5.3%
> > >
> >
> > Hey Bongkyu,
> >   I wanted to reach out to see what the current status of this patch
> > set? I'm seeing other parties trying to work around the loss of the
> > optimistic spinning functionality since commit 617f3ef95177
> > ("locking/rwsem: Remove reader optimistic spinning") as well, with
> > their own custom variants (providing some substantial gains), and
> > would really like to have a common solution.
> >
>
> I didn't get an reply, so I've been waiting.
> Could you let me know about their patch?

I don't have insight/access to any other implementations, but I have
nudged folks to test your patch and chime in here.

Mostly I just wanted to share that others are also seeing performance
trouble from the loss of optimistic spinning, so it would be good to
get some sort of shared solution upstream.

thanks
-john

