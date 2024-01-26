Return-Path: <linux-kernel+bounces-39675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0727583D4EB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:52:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 357921C24BDB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 08:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61A720B3B;
	Fri, 26 Jan 2024 06:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gC6Q9Voz"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B466520B3D
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 06:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706252082; cv=none; b=L23d/pue06UNk18Ok9MQply1hlCPTcD7tCfiqWCU68Yw/a4KDYG+1jbQvt2cFlTn9vg6Ee5UL329txTeGyCalG52wyq6ofLq3JpOjjYgXeBX/HZ2qumK0BrBp4CLchMKDSSHeuEa5X+Xc1OeCIm1HoE8Mi/zQ71QapBCwRRqts8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706252082; c=relaxed/simple;
	bh=uoG58qsUIuPrJgiWfC5zhkPTEKjA9Xh2r2kKMwvbji8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WtKTu3A47L3DIc7JxMNa9Cz/7fLSGut/mVqa+5jnYD64Qpv2bdhsspk2pKGJj2UGZTK8ScWQ77eFKTZ3iCISreglyHn+TJX9vtp+DET8bbd0H9Z/lvGhNw9b/nrjGkhjC9ZV/b9HbUVX307wJwTf6Lv3GIwD925peCQo+mKAYqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gC6Q9Voz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706252079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ixVxFEqIR9qHljjoQEl4g5MmPcyEPhBU2r2mCNibjNE=;
	b=gC6Q9VozXpQnegqM6IIoqkrysv89ishxXZnuBzeJ8e5tZZACBb+iO5WkiN0EZtWwi6aIUI
	qOu+/L4ozcdWutimfkB329GnRWdXJr4FMj62lUKU6S459IdCq1/yGYJS5j5zYo1Ki09GhY
	6UFeQSVJq1iv6I+8q/+/ze1TZj+Ge9I=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-MfyQ4f7dMOu5aN1W_1VUaQ-1; Fri, 26 Jan 2024 01:54:38 -0500
X-MC-Unique: MfyQ4f7dMOu5aN1W_1VUaQ-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6ddda3da46dso226924b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 22:54:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706252077; x=1706856877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ixVxFEqIR9qHljjoQEl4g5MmPcyEPhBU2r2mCNibjNE=;
        b=hs0cbUSoHa71GuUM3/uHkJqXg1YQb2fXIiIosVTjdJz7FgJNv/60+sU6oYIJXS+TuX
         lCzamJVwftztVlLG+xViGfmlN8I6S8b1tp+KpwYRpYXbMtsGXDhYmPR6MQrV4uC5/YZE
         8cmKV7nt7ouoOE6pVbs5IjVIC/3d+8s35DzIs8vPOC3yDWEssYWZc7TRxByMPFiDQkQe
         PE0K0ou3H7j4/HqnOCSRuV3n8jApHWswCbL1gNvfpytW09GGZ5HlOLg4iMdXHXPjLKrG
         W61NiJBhvvs2ARiUxFZmVV5k0mklZBxFOYGttKPHZaCaYyk2OXv3zvajkB7SzEqPL8QS
         LKxA==
X-Gm-Message-State: AOJu0YzmjSH9to3KXGUbeZU/gNSMcjSDNLo7dv5hlpLJYE2rvxDEmaQG
	fO6yDh7hlp0gjGgtzKV0YrrHIDohFqDeChqBFFIpGf/VpURf+oKdGIk5wAct7vQZM8NuFGOKKJt
	xImultzAxva/KfRdrXNcjU5MWUeOzMj/cRKGQtQ9HWE0ShFQJW9Rc9/5ZprXC2zsagww4nieg4y
	c5n1aBzU4Cvc3uDcX4vEhJALs9lAt9BWOxACA7
X-Received: by 2002:a05:6a00:3d4b:b0:6db:af73:bd9a with SMTP id lp11-20020a056a003d4b00b006dbaf73bd9amr779063pfb.30.1706252076905;
        Thu, 25 Jan 2024 22:54:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEkvjyZRZHVXgRsEU8lr2R5Dm/blrCJkBEkj8VqTTJXI87y6srCsSTHexV363ricMY1HODnu3VUd1JhtQ3tYbM=
X-Received: by 2002:a05:6a00:3d4b:b0:6db:af73:bd9a with SMTP id
 lp11-20020a056a003d4b00b006dbaf73bd9amr779048pfb.30.1706252076625; Thu, 25
 Jan 2024 22:54:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124091421.1261579-1-yukuai3@huawei.com> <20240124091421.1261579-6-yukuai3@huawei.com>
 <CALTww291wiYYMWuqUdDf1t7cKkHFs9gGQSRw+iPhUCsNv-Y6yg@mail.gmail.com> <CAPhsuW4kauNB8jAsXYjRohCBMDvY15y0CzzWYqzGvNsqAJ59jQ@mail.gmail.com>
In-Reply-To: <CAPhsuW4kauNB8jAsXYjRohCBMDvY15y0CzzWYqzGvNsqAJ59jQ@mail.gmail.com>
From: Xiao Ni <xni@redhat.com>
Date: Fri, 26 Jan 2024 14:54:25 +0800
Message-ID: <CALTww2_f_orkTXPDtA4AJsbX-UmwhAb-AF_tujH4Gw3cX3ObWg@mail.gmail.com>
Subject: Re: [PATCH v2 05/11] md: export helpers to stop sync_thread
To: Song Liu <song@kernel.org>
Cc: Yu Kuai <yukuai3@huawei.com>, agk@redhat.com, snitzer@kernel.org, 
	mpatocka@redhat.com, dm-devel@lists.linux.dev, jbrassow@f14.redhat.com, 
	neilb@suse.de, heinzm@redhat.com, shli@fb.com, akpm@osdl.org, 
	linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, 
	yukuai1@huaweicloud.com, yi.zhang@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 8:14=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> Hi Xiao,
>
> On Thu, Jan 25, 2024 at 5:33=E2=80=AFAM Xiao Ni <xni@redhat.com> wrote:
> >
> > Hi all
> >
> > I build the kernel 6.7.0-rc8 with this patch set. The lvm2 regression
> > test result:
>
> I believe the patchset is built on top of upstream (6.8-rc1). There are
> quite some md and dm changes between 6.7-rc8 and 6.8-rc1. Could
> you please rerun the test on top of 6.8-rc1? Once we identify the right
> set of fixes, we will see which ones to back port to older kernels.
>
> Thanks,
> Song

Hi all

I tried to run tests on 6.8-rc1, the failure number increases to 72.

And I ran the tests on 6.6, there are only 4 failed cases
###       failed: [ndev-vanilla] shell/lvconvert-cache-abort.sh
###       failed: [ndev-vanilla] shell/lvresize-fs-crypt.sh
###       failed: [ndev-vanilla] shell/pvck-dump.sh
###       failed: [ndev-vanilla] shell/select-report.sh

Best Regards
Xiao


