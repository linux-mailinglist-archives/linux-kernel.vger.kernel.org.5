Return-Path: <linux-kernel+bounces-144912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEC28A4C8A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B32A1C21F3F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FAB5A0F3;
	Mon, 15 Apr 2024 10:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TnH1Nvnn"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD1859B69
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 10:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713176975; cv=none; b=NjNzfVXnbA13j/spdkMF0o8uaRGnCkf5Ux7WrY9NKe/TIhVj51FS2ZKknLm06E16Ad9xPugZ+SMRHg8odnDfk4vp/HTz8eEMME/mdKy8XRq0wEEEwA0tHaB7ZqoYqxNFvJ9bmbVIP+9FSUr07C+EyeJDFfoKezghFKEuhBwmIac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713176975; c=relaxed/simple;
	bh=76ZZdVJJ6myI99pZLu7VEcOdF24dR7trRSqFyStvLBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZwhPesAWXC6rlcPH2FsJR2rDyH26cSt/k++XezPDJjKVhfa/0uErlTegm5EZkY4E+MMkpkPcFU/RyqmqcWCSHNSI5bHJrmA4LU7tJ0TtCxTnHcwkvnq54UEKCCNvCEy64uQh9Uid0LN/b7hWIE5HIL9EwTV2672Bh/uECXexdPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TnH1Nvnn; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-78d743f3654so293020385a.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 03:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713176971; x=1713781771; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lehrUz7hWetCgF2KGx9B8DKUV7UgKBSK5jeKW82WGc=;
        b=TnH1NvnnIxaa1aZrkObX8dw8NIiaj1Rmw1grGrPKI52mIv0BFOc2hFy7bEYnItBazm
         AQnSYWFp8sXmabcPFSuWthxFhhRFDYGNNcHu8ImQACehXLUYQs+glWPpJxTEQAFf3coJ
         JMqiF8vsaijH8H6bBovkK8MM1ALA1z+3Je5Wk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713176971; x=1713781771;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/lehrUz7hWetCgF2KGx9B8DKUV7UgKBSK5jeKW82WGc=;
        b=u5B7CS7IOQMf8m4n7kzSAnOBdQRJeZ2JhtMtKgzB1IKdV7XFYfBXLr7ZK7gjazXppc
         YLWqOXANMwRQXCTgSeJxeR8ZcRjv8ba+dxuUXr9g/3H5MEs70M8/TZnZNhviVA7z/Rci
         5EBe6cDcLfUbsPuWotXju6PJ+cb2FZyu1gVzXuGqOxvBfDrI8H1d2ygOHueh33Dzu77K
         M1Bq6UDabUoDkKnb6JtKDhIAi1XqUtpGb8MbeTNWjgBcMxCCmyv5xva9JL3p3FJNnLUm
         gWihX8B/tReolPTjGOh2Pvl9yuWOxOHSTyHJqhfZR7PG6lUdHmHM5YUVPU6MupMidvJp
         29ww==
X-Forwarded-Encrypted: i=1; AJvYcCUVv9XTmYHY1dj6YezB3ihceKNfULtm0/9e285ykgDRRlCYjRt/9fMbaGMih5WmgnWNKcpoPcNf0URiwJww1tfEjpHeJ4zzJp91f1NV
X-Gm-Message-State: AOJu0YzgMOyCY3PLAGAbmqHglTeM7MN7K7fmYIGMgASUC0RJP00K+LyK
	1wFpnNKqeljhRD/sKRfiPeJ0zYcoujtHD/62jQYw3qbxv0FSMsjWQMb/6ONd+lTT+ROnimaqFOA
	=
X-Google-Smtp-Source: AGHT+IEEWA3uCggiRxhkz2T/aNAu61IYcY8NjLKR+8r2GlkV9sSWYxdgXk3JLz1BhMp7xCkSdagmpA==
X-Received: by 2002:a0c:e60c:0:b0:69b:2839:b477 with SMTP id z12-20020a0ce60c000000b0069b2839b477mr9769370qvm.27.1713176971227;
        Mon, 15 Apr 2024 03:29:31 -0700 (PDT)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com. [209.85.219.48])
        by smtp.gmail.com with ESMTPSA id r10-20020a056214212a00b006994394017dsm2437155qvc.27.2024.04.15.03.29.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 03:29:31 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-69b137d09e3so15460806d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 03:29:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUi9KiTrnJYSqdfn6mcibyyKMnT6f3UHQxypGmdiMCKP8f2um8XHA9gSwaCgQcaB0Fxd8TbTsoqWNFzJFutlWZFDtr/I/61jBarIKi3
X-Received: by 2002:ad4:4f41:0:b0:69b:5476:3220 with SMTP id
 eu1-20020ad44f41000000b0069b54763220mr9634610qvb.38.1713176970016; Mon, 15
 Apr 2024 03:29:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410-pack-v1-0-70f287dd8a66@chromium.org> <20240410-pack-v1-2-70f287dd8a66@chromium.org>
 <f7ca4107-0341-4631-8d8d-b9677782ac2f@xs4all.nl> <CANiDSCvkRWZXuG7dfw0WXvgT+LHQqG3fx9F1M2P0_9dkB9VOKA@mail.gmail.com>
 <3f8660b0-e29c-47e2-b877-10da058388f9@xs4all.nl>
In-Reply-To: <3f8660b0-e29c-47e2-b877-10da058388f9@xs4all.nl>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 15 Apr 2024 12:29:13 +0200
X-Gmail-Original-Message-ID: <CANiDSCuQoN0AKBDjYakHE6rhpBYymd_r8Gv-AEaOGiZmijN3Eg@mail.gmail.com>
Message-ID: <CANiDSCuQoN0AKBDjYakHE6rhpBYymd_r8Gv-AEaOGiZmijN3Eg@mail.gmail.com>
Subject: Re: [PATCH 2/3] media: dvb: Fix dtvs_stats packing.
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hans

On Mon, 15 Apr 2024 at 11:51, Hans Verkuil <hverkuil-cisco@xs4all.nl> wrote=
:
>
> Hi Ricardo,
>
> On 12/04/2024 17:00, Ricardo Ribalda wrote:
> > Hi Hans
> >
> > On Fri, 12 Apr 2024 at 16:21, Hans Verkuil <hverkuil-cisco@xs4all.nl> w=
rote:
> >>
> >> On 10/04/2024 14:24, Ricardo Ribalda wrote:
> >>> The structure is packed, which requires that all its fields need to b=
e
> >>> also packed.
> >>>
> >>> ./include/uapi/linux/dvb/frontend.h:854:2: warning: field  within 'st=
ruct dtv_stats' is less aligned than 'union dtv_stats::(anonymous at ./incl=
ude/uapi/linux/dvb/frontend.h:854:2)' and is usually due to 'struct dtv_sta=
ts' being packed, which can lead to unaligned accesses [-Wunaligned-access]
> >>>
> >>> Explicitly set the inner union as packed.
> >>>
> >>> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> >>> ---
> >>>  include/uapi/linux/dvb/frontend.h | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/include/uapi/linux/dvb/frontend.h b/include/uapi/linux/d=
vb/frontend.h
> >>> index 7e0983b987c2d..8d38c6befda8d 100644
> >>> --- a/include/uapi/linux/dvb/frontend.h
> >>> +++ b/include/uapi/linux/dvb/frontend.h
> >>> @@ -854,7 +854,7 @@ struct dtv_stats {
> >>>       union {
> >>>               __u64 uvalue;   /* for counters and relative scales */
> >>>               __s64 svalue;   /* for 0.001 dB measures */
> >>> -     };
> >>> +     }  __attribute__ ((packed));
> >>>  } __attribute__ ((packed));
> >>
> >> This is used in the public API, and I think this change can cause ABI =
changes.
> >>
> >> Can you compare the layouts? Also between gcc and llvm since gcc never=
 warned
> >> about this.
> >
> > The pahole output looks the same in both cases:
> >
> > https://godbolt.org/z/oK4desv7Y
> > vs
> > https://godbolt.org/z/E36MjPr7v
> >
> > And it is also the same for all the compiler versions that I tried.
> >
> >
> > struct dtv_stats {
> > uint8_t                    scale;                /*     0     1 */
> > union {
> > uint64_t           uvalue;               /*     1     8 */
> > int64_t            svalue;               /*     1     8 */
> > };                                               /*     1     8 */
> >
> > /* size: 9, cachelines: 1, members: 2 */
> > /* last cacheline: 9 bytes */
> > } __attribute__((__packed__));
> >
> >
> >
> > struct dtv_stats {
> > uint8_t scale; /* 0 1 */
> > union {
> > uint64_t uvalue; /* 1 8 */
> > int64_t svalue; /* 1 8 */
> > }; /* 1 8 */
> >
> > /* size: 9, cachelines: 1, members: 2 */
> > /* last cacheline: 9 bytes */
> > } __attribute__((__packed__));
> >
> >
> >>
> >> I'm not going to accept this unless it is clear that there are no ABI =
changes.
> >
> > Is there something else that I can try?
>
> No, that's what I needed. I also found some clang discussions here:
>
> https://github.com/llvm/llvm-project/issues/55520
>
> I propose that I add the following sentence to these three packing patche=
s:
>
> "Marking the inner union as 'packed' does not change the layout, since th=
e
> whole struct is already packed, it just silences the clang warning. See
> also this llvm discussion: https://github.com/llvm/llvm-project/issues/55=
520"
>
> If you are OK with that, then I can add that to your patches.

That sounds great. Thanks!

>
> Related to this: I added CEC and DVB support to the ABI checks in the bui=
ld
> scripts. And fixed a bunch of mistakes there (e.g. 'false=3Dtrue' where I=
 meant
> to write 'fail=3Dtrue'!) that made the ABI checks useless.

Ferpect!, I will update it in media-ci

Thanks!
>
> I updated the abi/* files accordingly as well.
>
> Regards,
>
>         Hans
>
> >
> > Regards!
> >
> >>
> >> Note that the ABI test in the build scripts only tests V4L2 at the mom=
ent,
> >> not the DVB API.
> >>
> >> Regards,
> >>
> >>         Hans
> >>
> >
> >
>


--=20
Ricardo Ribalda

