Return-Path: <linux-kernel+bounces-128713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E5A895E86
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 522091C23A22
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B02E15E7FA;
	Tue,  2 Apr 2024 21:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="Di+SrmgW"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9070C15E5D4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 21:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712092621; cv=none; b=H6EQc/hK1K9fXdgMqhc4Sx/+nXrv3N0GiugE6ovLrAGD6vMsCBdFt0edm8CFmWQ/2goRIBfTZmIVOfxBfZgvQbBt6XkrYODxfgCpdzPai8ze50JKOmG+d9qnkjzrlVUZmq0ZSmUxU+SZ/alk/g6ucBtXOBM4TWvF6a7PPyER1L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712092621; c=relaxed/simple;
	bh=kCy/Wy416R2rVioMdi/DEMNv60kp/brycrF56GzT6Zs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K8qR6Rt6Q+yOf1o1Mc65Ui8FXJL99CvXh2pAlMXhXaXv9/dR9491SSDGVci47tl4hE1NT7Q04ORrMceDHipvOraApnQw5pps7WW2raf7rAwT2XkD9/Ho/HWjSl+kDGjiyD80aaf1kfZ+jOxyBsZCUcOfhYpoHtc942yHL0/Xn4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Di+SrmgW; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4161bd0a4ecso8101755e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 14:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712092618; x=1712697418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OAizWUKAAnKBZ/2O8nQbOOvDnazCRfTEF/N4t89OGY=;
        b=Di+SrmgWXOiBHfJ8I0xwFoJ1ZUDTUE8RmXyPmGDISmH4oKe6R7UmsCzmqOB7GMPrda
         PrO1fL1YFywWpPTFeBMTyy/XQhsh8rU2ii6+a5x+wS0fndq+AIQmMUINyLpbxCQqZHC0
         cYYquKYbILoVybCTlP2GROsxApXLoJL9c/JT/Hoc8cO2CkYZBCtWPgux7/2HsqwNzZ+Q
         yWgWvqG5bAouyp0JovtBi+9M3Pgp//9wTMHtojuNbJPKkEyBf5nzstOtiY2bT5OLyY4e
         aBaBKk9Udfo5q2fDJRuGwzCFaUmFSdw1npTKKbXtkNWpaer+4TS9FCiFCmfp+qCfsWgN
         KRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712092618; x=1712697418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/OAizWUKAAnKBZ/2O8nQbOOvDnazCRfTEF/N4t89OGY=;
        b=j1mJ5IErjfm/3HahxaYkMxHhVRpKv4AhYctK7KDfyk59/knGoO5nPPTDCIwjIv7piT
         SXA0Kul4siLw4ToHUnpiN4pW+A7xg5oVhrNm0OWJwQlvS1x2KfL1UyQsV4quCevrirtq
         8lEmY3UzvrV1A8YRiDK9RzVMyEWfBvRwYpysa8tZ0mcCvXYPlf17PVSJ5z21gbteQrsl
         L8Tfghsy3y8w698vbRpgNrKOnmsbNdyp47US0zU2W310Bve9E4fxf+XJrrPltgJJZy/B
         /g/BlRsK3WzernPiphDy6e8x4ygNFQQlYb/9zryCG5LntZ1wWXsB0xPtZBmI2EesGD6C
         p1lA==
X-Forwarded-Encrypted: i=1; AJvYcCVUsoPynXtJQ4Tzd5ZY6cSe2i0uJAJ144CpTwpcG/W8UPMlenL87d22om6Z7q8OjYRIK9qS5vpuXKW2oL4MH9lrvfJ+86NZqJgy1lwL
X-Gm-Message-State: AOJu0YyVsMWRsnXZuPMOVpc1T60zYeUFj0jwUQIA/vxcXFpzqER0H96T
	YDXHl+u7+nR2NhY7WgK9lQXL+ktcufo8pZl2+2oilCt4Ur8lQ3Mh6UBHD5i7F+my4B4QyOgGvX/
	EJu8grpONHe41YOJ/1Q6HapW917VfKqNpWgcW
X-Google-Smtp-Source: AGHT+IH5S3wHyM0LW8kSGJtaML71ldIEGY4qs+Y1EPNU4RCyS1cvM5MraL2y3w2xh6lWwiPJTbTpV1msXzG68jMUxAY=
X-Received: by 2002:a7b:c358:0:b0:415:4b1a:683b with SMTP id
 l24-20020a7bc358000000b004154b1a683bmr642867wmj.41.1712092617721; Tue, 02 Apr
 2024 14:16:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMuE1bHBky9NGP22PVHKdi2+WniwxiLSmMnwRM6wm36sU8W4jA@mail.gmail.com>
 <878r29hjds.ffs@tglx> <CAMuE1bF9ioo39_08Eh26X4WOtnvJ1geJ=WRVt5DhU8gEbYJNdA@mail.gmail.com>
 <87o7asdd65.ffs@tglx> <CAF2d9jjA8iM1AoPUhQPK62tdd7gPnCnt51f_NMhOAs546rU3dA@mail.gmail.com>
 <87il10ce1g.ffs@tglx>
In-Reply-To: <87il10ce1g.ffs@tglx>
From: =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= <maheshb@google.com>
Date: Tue, 2 Apr 2024 14:16:30 -0700
Message-ID: <CAF2d9jj6km7aVSqgcOE-b-A-WDH2TJNGzGy-5MRyw5HrzbqhaA@mail.gmail.com>
Subject: Re: [PATCH v7] posix-timers: add clock_compare system call
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Sagi Maimon <maimon.sagi@gmail.com>, richardcochran@gmail.com, luto@kernel.org, 
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, 
	hpa@zytor.com, arnd@arndb.de, geert@linux-m68k.org, peterz@infradead.org, 
	hannes@cmpxchg.org, sohil.mehta@intel.com, rick.p.edgecombe@intel.com, 
	nphamcs@gmail.com, palmer@sifive.com, keescook@chromium.org, 
	legion@kernel.org, mark.rutland@arm.com, mszeredi@redhat.com, 
	casey@schaufler-ca.com, reibax@gmail.com, davem@davemloft.net, 
	brauner@kernel.org, linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-arch@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 2:25=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> On Mon, Apr 01 2024 at 22:42, Mahesh Bandewar (=E0=A4=AE=E0=A4=B9=E0=A5=
=87=E0=A4=B6 =E0=A4=AC=E0=A4=82=E0=A4=A1=E0=A5=87=E0=A4=B5=E0=A4=BE=E0=A4=
=B0) wrote:
> > On Mon, Apr 1, 2024 at 1:46=E2=80=AFPM Thomas Gleixner <tglx@linutronix=
de> wrote:
> >> So if there is a backwards compability issue with PTP_SYS_OFFSET2, the=
n
> >> you need to introduce PTP_SYS_OFFSET3. The PTP_SYS_*2 variants were
> >> introduced to avoid backwards compatibility issues as well, but
> >> unfortunately that did not address the reserved fields problem for
> >> PTP_SYS_OFFSET2. PTP_SYS_OFFSET_EXTENDED2 should just work, but maybe
> >> the PTP maintainers want a full extension to '3'. Either way is fine.
> >>
> > https://patchwork.kernel.org/project/netdevbpf/patch/20240104212436.327=
6057-1-maheshb@google.com/
> >
> > This was my attempt to solve a similar issue with the new ioctl op to
> > avoid backward compatibility issues.  Instead of flags I used the
> > clockid_t in a similar fashion.
>
> Works as well. I'm not seing the point for CLOCK_MONOTONIC and the
> change logs are not really telling anything about the problem being
> solved....
>
https://lore.kernel.org/lkml/20240104212431.3275688-1-maheshb@google.com/T/=
#:~:text=3D*%20[PATCHv3%20net%2Dnext%200/3]%20add%20ptp_gettimex64any()%20A=
PI,21:24%20Mahesh%20Bandewar%200%20siblings%2C%200%20replies;

This is the cover letter where I tried to explain the need for this.

Granted, my current use case is for CLOCK_MONOTONIC_RAW but just
because I don't have a use case doesn't mean someone else may not have
it and hence added it. In either way it's just a matter of
adding/removing another flag/clock-id.

Thanks,
--mahesh..
> Thanks,
>
>         tglx

