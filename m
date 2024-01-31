Return-Path: <linux-kernel+bounces-45586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC708432BC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C52331F273AE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59981865;
	Wed, 31 Jan 2024 01:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bw1V2JY2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A750FEDD
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 01:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706664557; cv=none; b=SUPTB0lAqciiDZh49HcWRzFeGOLcP1oWN4CpOFqbMm/fRGYK7vbuuu8LGYl/xQ+rTCJzaHRco/ENEMPBe2ZZ29Xv/Yqk3/JXTGdzMy/tr/3leJzRt1GW5Lrf1ZobCGH86almbG+hFC2dbmrrdlssuYxOsffqPmpBOR4l+ZgXNjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706664557; c=relaxed/simple;
	bh=aJlhUnCAcl/yigpRuUE3FKFXJmobkfI0YtXFMKt6Ne4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PKLqAQBVOctHFEloigZLJwrTByn1/g1yh5JnLiXCKma7eINdyFy0ykKRfG1vIXEgSGYybY1YVKsIq7FmjzYROQYJ+xfvdkDF3K1ENxn4z3fxQZtlGkGhQ6e7PsEekZQvIaQzwBvUdeSNi1xVCvATI9Z0sAVlQPJeOteewhWENiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bw1V2JY2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706664554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JNqnrWYNhsbLxXIHidmeYKuJLzR8cqpFCLs5iG5NUIg=;
	b=Bw1V2JY2zbVaVYoV9hoGzEaByePkanfQ+LBazaTojlck6vvAcuZSx3viXRCS2xu2peUmGa
	khuSPboQiKH2GURiEEkEiMikgndkgOKtnVXVz3kafqHdSeHCn3K6uD7CaNpNXZ+SK/4O8A
	5n7lGQhwrQ6jxCiAnGVGAY0I/3dFf8Q=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-tHWMj-DlN0az4Np7593JLA-1; Tue, 30 Jan 2024 20:29:12 -0500
X-MC-Unique: tHWMj-DlN0az4Np7593JLA-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6dde011a87eso2562701b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 17:29:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706664551; x=1707269351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JNqnrWYNhsbLxXIHidmeYKuJLzR8cqpFCLs5iG5NUIg=;
        b=cnbNniBrTM2bgMXvm3nWtMJ+SCH8NgbDQ0LCgin0AVMq5sPn+bKdF8g2+Hi2JzGonf
         PGxpjXM4KmwokdqMIFd6bEgtfbxNv5TptYxojebZWXFjHiSxiNLO/+PzzRO2y4/HESTZ
         T4m1zeP4O6AVCrovULmB5+yBDg36SlVZSnMqahuIsTZdsvJhHvN4Qg6CpO68AjjPrxcZ
         4vmOyROa7dp7V+pr+mW5hkEMW/DCKE5onrFLyTYsowK+hM5pAiqMAmbomAlg5tIJETtX
         DLEBqBWuoRrx6QlzfVxVg56/cMrqXVQRMki7/54oGftA8YoeRwoaNwHMjj4NVd/Penmo
         UHrQ==
X-Gm-Message-State: AOJu0YzHilN/zppggoc9FIvAerJouD7rkmg4B7mzyANzZFzoo3Zb2z4u
	YzeyE9aZK7BOAWxp3kLjbvtaNJP0v9NUNLXzxn5xldHXvKnPnQ2mKiR1qV+Bch4mj8XKqe9vnT6
	B0KiS4R2nLr+2UeIr9AN6A3P4v9Y8us2m6ktelQMr0ov4TXucgkud3wbTIlAfiZqK0TMr0UqKBi
	ArZyvp6H7tKU9ayNd7RwTL0JFdM2oZZjfOPPzc
X-Received: by 2002:a05:6a00:c8b:b0:6db:d4f8:bb1d with SMTP id a11-20020a056a000c8b00b006dbd4f8bb1dmr431531pfv.2.1706664550909;
        Tue, 30 Jan 2024 17:29:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFr+2mKU7NfBaA1rJF29186UvNGqzXqI+b2lGNzCcEvEyxDyhvBbMJiH6oHf82morLlvpAekP+aQ15hJyqjlbo=
X-Received: by 2002:a05:6a00:c8b:b0:6db:d4f8:bb1d with SMTP id
 a11-20020a056a000c8b00b006dbd4f8bb1dmr431511pfv.2.1706664550628; Tue, 30 Jan
 2024 17:29:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130021843.3608859-1-yukuai1@huaweicloud.com>
 <CALTww29QO5kzmN6Vd+jT=-8W5F52tJjHKSgrfUc1Z1ZAeRKHHA@mail.gmail.com> <78016a94-737a-af4d-446b-c9fbef967895@huaweicloud.com>
In-Reply-To: <78016a94-737a-af4d-446b-c9fbef967895@huaweicloud.com>
From: Xiao Ni <xni@redhat.com>
Date: Wed, 31 Jan 2024 09:28:59 +0800
Message-ID: <CALTww29UKCJcvJB2BvGTbCcpvD4Y-J+Bg1WgE0nOijLNMv=RGg@mail.gmail.com>
Subject: Re: [PATCH v4 00/14] dm-raid: fix v6.7 regressions
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: mpatocka@redhat.com, heinzm@redhat.com, agk@redhat.com, snitzer@kernel.org, 
	dm-devel@lists.linux.dev, song@kernel.org, jbrassow@f14.redhat.com, 
	neilb@suse.de, shli@fb.com, akpm@osdl.org, linux-kernel@vger.kernel.org, 
	linux-raid@vger.kernel.org, yi.zhang@huawei.com, yangerkun@huawei.com, 
	"yukuai (C)" <yukuai3@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 9:25=E2=80=AFAM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi, Xiao Ni!
>
> =E5=9C=A8 2024/01/31 8:29, Xiao Ni =E5=86=99=E9=81=93:
> > In my environment, the lvm2 regression test has passed. There are only
> > three failed cases which also fail in kernel 6.6.
> >
> > ###       failed: [ndev-vanilla] shell/lvresize-fs-crypt.sh
> > ###       failed: [ndev-vanilla] shell/pvck-dump.sh
> > ###       failed: [ndev-vanilla] shell/select-report.sh
> > ### 426 tests: 346 passed, 70 skipped, 0 timed out, 7 warned, 3 failed
> >    in 89:26.073
>
> Thanks for the test, this is greate news.
>
> Kuai
>

Hi Kuai

Have you run mdadm regression tests based on this patch set?

Regards
Xiao


