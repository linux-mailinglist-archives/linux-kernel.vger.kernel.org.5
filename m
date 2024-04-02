Return-Path: <linux-kernel+bounces-128837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3895896045
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78FC2286AE6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CE058AD4;
	Tue,  2 Apr 2024 23:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="OAYCq5yZ"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970992260B
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 23:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712101080; cv=none; b=K6iX0mp238QAqUit+zS9fDQl3ahOKLBt8R8oRTttQUyaPlirPESwFEZMDo2QKU9BUjiFF0z7fZIsRNvFRxuG2sfSk4alRqiU8XgNSdDcLxWcBlqGwDPyE/ztxjMCuG9U5Es0lmxDXBklKclRNCRki5U3bwvMXcmSAWNyDJHGA1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712101080; c=relaxed/simple;
	bh=hvPiRv3KsQLdWizngJXKCVUmWxlr4l53whIB5Ke5SX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IdTn1bh4T8CqeKBv67E7sn9zvJRu4aCJWJzxTe+79jWfcHtjfsFQhnnTcSpMF51qpj59b/Z2ZakTJtDDU1YLYq8kn4fW8sHrNsLXCb6jWUuHFi256RuD/LUBb33F5oHsqaAKFPdM3YNXPB9JENcFOGyzNPsg15nsUHITtcm+gDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OAYCq5yZ; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3437efea0ecso470076f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 16:37:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712101076; x=1712705876; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OwZit2uJpb4ATUGreTeGd8J2lZLTvOZvhInFnpA6D9M=;
        b=OAYCq5yZsYKnB1/1amKdWQOUlqgBLRJ5y/n0bbdyw0XqHzr+Y1PpkES5anenyeOIr4
         OF1vd9gZWAXGtvrEi++Iwjtu/3yZhs8E9DT76dYfH0zJpFOCDCLDroX7JtREk/moj3Pn
         7QJK7ClPQo3+B0FF3z/XFUf2u+AftlYWqURuxR5Pi3RTU+pqiS4xPCad730H7YZTwAbj
         5Zmas056bqCpa0ZgFtiYci9EzB8gRdhkamdOmyFAjifT/bhKOrkIiEexzeJzgQFIwMZo
         NNgrjV891sQqFxgcEymOAvjACF37HbXbc9MsGyLTAnXHXeIGOSF8azcJIM67yulFWiCr
         giWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712101076; x=1712705876;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OwZit2uJpb4ATUGreTeGd8J2lZLTvOZvhInFnpA6D9M=;
        b=iWmtcSAXZjy/QALDTEOp/W0aiqFDyV03rGZr2+QqmcqgkRU7mYfYQLAV5tZI8miQzZ
         P02B3oazfkKaVXvxcEQudFMv+/YbUOQKdaJC3hKfMS4hJwhRiYZuzka43gU0fzuITAA+
         siqhk0sYqA6lIoXdf8IhSBObbV5jUdKvxk1YbOA+r95RI0ki71IPbTWoIV17TmVPLLuS
         nA8ETTvmKwMgKnWLUXtheJCON9yoPsVyjW4dP90uAch9jiMAhD/6LKfkweEijofsREBw
         grflQFF+iwkq0MzIfs3ZGiRxIL6bnQA5hm9XzUTvhhFCbgOV1N5GwjEKTloUGhpWyLyI
         jCXw==
X-Forwarded-Encrypted: i=1; AJvYcCUuWgLY767NztUuZqRM2mHNEcMr7tyULBlutscix2drnl9AWtp/XSEyF1oSvjD962hDi0YbbKHXDk2L823GwwmnewZQFO7rG61PH7il
X-Gm-Message-State: AOJu0YykaMhAuvpS4FAFz+RaMvBJxDfqPOkT/qVTMaksTLnQDl7MJT1o
	bx2NFrT7PFPokog/d7jZUqVxon5OyUN0dLpg0k0s4+g37rtPS8gDoqkYVc+O9ez+JYq4X2BEf8v
	FzCh1u1XY+3zXGCtl3Q7tvSXk6qaooHnWn5eh
X-Google-Smtp-Source: AGHT+IGUuktUVDBrbWL9KEuXP/v3yRKNY56LFpGqSgsq21J6mATQaiBUxxvdh3kRU5kUGsDQRG842ENwNRmL6shqRPw=
X-Received: by 2002:a5d:5221:0:b0:343:823c:6d57 with SMTP id
 i1-20020a5d5221000000b00343823c6d57mr1092726wra.45.1712101075793; Tue, 02 Apr
 2024 16:37:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMuE1bHBky9NGP22PVHKdi2+WniwxiLSmMnwRM6wm36sU8W4jA@mail.gmail.com>
 <878r29hjds.ffs@tglx> <CAMuE1bF9ioo39_08Eh26X4WOtnvJ1geJ=WRVt5DhU8gEbYJNdA@mail.gmail.com>
 <87o7asdd65.ffs@tglx> <CAF2d9jjA8iM1AoPUhQPK62tdd7gPnCnt51f_NMhOAs546rU3dA@mail.gmail.com>
 <87il10ce1g.ffs@tglx> <CAF2d9jj6km7aVSqgcOE-b-A-WDH2TJNGzGy-5MRyw5HrzbqhaA@mail.gmail.com>
 <877chfcrx3.ffs@tglx>
In-Reply-To: <877chfcrx3.ffs@tglx>
From: =?UTF-8?B?TWFoZXNoIEJhbmRld2FyICjgpK7gpLngpYfgpLYg4KSs4KSC4KSh4KWH4KS14KS+4KSwKQ==?= <maheshb@google.com>
Date: Tue, 2 Apr 2024 16:37:27 -0700
Message-ID: <CAF2d9jjg0PEgPorXdrBHVkvz-fmUV7UXUPqnpQGVEvgXTpHY0A@mail.gmail.com>
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

On Tue, Apr 2, 2024 at 3:37=E2=80=AFPM Thomas Gleixner <tglx@linutronix.de>=
 wrote:
>
> On Tue, Apr 02 2024 at 14:16, Mahesh Bandewar (=E0=A4=AE=E0=A4=B9=E0=A5=
=87=E0=A4=B6 =E0=A4=AC=E0=A4=82=E0=A4=A1=E0=A5=87=E0=A4=B5=E0=A4=BE=E0=A4=
=B0) wrote:
> > On Tue, Apr 2, 2024 at 2:25=E2=80=AFAM Thomas Gleixner <tglx@linutronix=
de> wrote:
> >> Works as well. I'm not seing the point for CLOCK_MONOTONIC and the
> >> change logs are not really telling anything about the problem being
> >> solved....
> >>
> > https://lore.kernel.org/lkml/20240104212431.3275688-1-maheshb@google.co=
m/T/#:~:text=3D*%20[PATCHv3%20net%2Dnext%200/3]%20add%20ptp_gettimex64any()=
%20API,21:24%20Mahesh%20Bandewar%200%20siblings%2C%200%20replies;
> >
> > This is the cover letter where I tried to explain the need for this.
>
> The justification for a patch needs to be in the change log and not in
> the cover letter because the cover letter is not part of the git
> history.
>
ack

> > Granted, my current use case is for CLOCK_MONOTONIC_RAW but just
> > because I don't have a use case doesn't mean someone else may not have
> > it and hence added it.
>
> Then why did you not five other clock IDs? Someone else might have a
> use case, no?
>
> While a syscall/ioctl should be flexible for future use, the kernel does
> not add features just because there might be some use case. It's
> documented how this works.
>
I see your point. I don't mind removing the CLOCK_MONOTONIC for now
and just have CLOCK_REALTIME and CLOCK_MONOTONIC_RAW support. Also as
I mentioned, it will be just a matter of adding new clock-ids and
support for the pre/post-ts for respective clock-ids if needed in the
future.

The modification that you have proposed (in a couple of posts back)
would work but it's still not ideal since the pre/post ts are not
close enough as they are currently  (properly implemented!)
gettimex64() would have. The only way to do that would be to have
another ioctl as I have proposed which is a superset of current
gettimex64 and pre-post collection is the closest possible.

Here is my sample mlx4 (since I use that) of the new ioctl method
(just for the reference)

--- a/drivers/net/ethernet/mellanox/mlx4/main.c
+++ b/drivers/net/ethernet/mellanox/mlx4/main.c
@@ -43,6 +43,7 @@
 #include <linux/io-mapping.h>
 #include <linux/delay.h>
 #include <linux/etherdevice.h>
+#include <linux/ptp_clock_kernel.h>
 #include <net/devlink.h>

 #include <uapi/rdma/mlx4-abi.h>
@@ -1929,7 +1930,7 @@ static void unmap_bf_area(struct mlx4_dev *dev)
                io_mapping_free(mlx4_priv(dev)->bf_mapping);
 }

-u64 mlx4_read_clock(struct mlx4_dev *dev)
+u64 mlx4_read_clock(struct mlx4_dev *dev, struct ptp_system_timestamp
*sts, int clkid)
 {
        u32 clockhi, clocklo, clockhi1;
        u64 cycles;
@@ -1937,7 +1938,13 @@ u64 mlx4_read_clock(struct mlx4_dev *dev)
        struct mlx4_priv *priv =3D mlx4_priv(dev);

        for (i =3D 0; i < 10; i++) {
-               clockhi =3D swab32(readl(priv->clock_mapping));
+               if (sts) {
+                       ptp_read_any_prets(sts, clkid);
+                       clockhi =3D swab32(readl(priv->clock_mapping));
+                       ptp_read_any_postts(sts, clkid);
+               } else {
+                       clockhi =3D swab32(readl(priv->clock_mapping));
+               }
                clocklo =3D swab32(readl(priv->clock_mapping + 4));
                clockhi1 =3D swab32(readl(priv->clock_mapping));
                if (clockhi =3D=3D clockhi1)

Having said that, the 'flag' modification proposal is a good backup
for the drivers that don't have good implementation (close enough but
not ideal). Also, you don't need a new ioctl-op. So if we really want
precision, I believe, we need a new ioctl op (with supporting
implementation similar to the mlx4 code above). but we want to save
the new ioctl-op and have less precision then proposed modification
would work fine.

> Thanks,
>
>         tglx
>

