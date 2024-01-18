Return-Path: <linux-kernel+bounces-30049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A629F831868
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D953A1C2240E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 11:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C16241F6;
	Thu, 18 Jan 2024 11:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MAnaKp8m"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50A92375A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705576996; cv=none; b=NL7ZnJ5p9Dt+/fIsTk5BQW8p3S93SZ9PAmsWKHpfnw/vQZ/UuVtg5V8Q67AFRLu1wWJBNbHwP6aKOEB5ZQwpVpf5bE9o5CNbutz5vGD/lc+cGBgAplEn1KaaAPc0khrihk9DVrOcK6gynYkxSsL7TzJsolI/oBSsM/nr5ZSe7So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705576996; c=relaxed/simple;
	bh=3sL2EmU8cW4SsL2Qy7d1PwP+T0ksz+D0+24yHjcLJcI=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Received:X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding; b=C0ZU4Z2B/TQ5Q0cw2sPKKLEjrjqvC/6QzO8nyBnzVhyTDgJYoq6tRgSnrgHHjA1bCU/oA0AQ1LmTxk8zrxsTir3QzUlpLx/KOfVD0XQHCzjkp0lLZH9qJdLJCrBF4nhgrgNQhMaVQ1HUR3r+EzsDtG+9IozCdjx5PQf7Z48PKx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MAnaKp8m; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a298accc440so1481314666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 03:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705576992; x=1706181792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0qiEFj99shkY4wI4G2TO6hDOfA4IjYIaR73Xu8Zkp5w=;
        b=MAnaKp8mN17a2G1NCy4qTg1/WVYlDRNecPfBWGWQe8P1q2WmEY4yE1relBpHBsniVr
         /VSwVNtov7mNdN1KPwuIY3Q6FB7YQx8dWLHotg9pyN3Aj6WeaC9HlOaKaLWebLfyl3Aa
         dnWuluGL2SQPKBYVfcLFRUTbDoJ4inzy0CZUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705576992; x=1706181792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0qiEFj99shkY4wI4G2TO6hDOfA4IjYIaR73Xu8Zkp5w=;
        b=lsBCw0cJDJ4YYbX/ZwTqtHRaqSxSMIaK/KzdCOPXy7OGxPdn0EogKn4WlKIyQrM1gW
         /ZvlHfpiPQtXRNEwA+CIe6KYFLhQlgGiLsmDHBXG51W8JhBJfsixsUyvnKNvd1iAOu+d
         XOngCRtIat+8nyhv2yNeXeo/JzdB/37zn6pN0M0dK0mO66SbhF9ZkvOMDRmROTVfBNyE
         kskIIybfZcVW70gIeL0gThYMG/5hlPN5AFoYeESV45+1wTjZwq+MTeDRe+8lt1jwybt/
         aJi2SkLLr0Jerk5o1d1RM3z88SuKooeTyyRQPCnuTLtf8ijwDfjlyNizqi7xTwcPpqgW
         APHQ==
X-Gm-Message-State: AOJu0Yx7WzElZJUOhg4zjfQZ/zeotfR2/bVcPlltfhF5JuPPN6ufSlQR
	Ge6nFkpL8pmunKlptYaO7nQowldDplos34vW884968t+42K09aJ43dpzmQnYwm3rKQNVlMql05T
	Keg==
X-Google-Smtp-Source: AGHT+IHL9j77+wscMIsNarPjdi2oRe90Y3TgVGhuYhv28gdrnZmumtmg2IjTzNcmzfqZf3ABPtXDGQ==
X-Received: by 2002:a17:906:f1c6:b0:a2d:348b:bff6 with SMTP id gx6-20020a170906f1c600b00a2d348bbff6mr457959ejb.152.1705576992609;
        Thu, 18 Jan 2024 03:23:12 -0800 (PST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com. [209.85.221.50])
        by smtp.gmail.com with ESMTPSA id tk4-20020a170907c28400b00a2ce236ed71sm7567609ejc.43.2024.01.18.03.23.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 03:23:11 -0800 (PST)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-337ae00f39dso3405556f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 03:23:10 -0800 (PST)
X-Received: by 2002:a5d:658f:0:b0:333:c81:8f9d with SMTP id
 q15-20020a5d658f000000b003330c818f9dmr445080wru.2.1705576990413; Thu, 18 Jan
 2024 03:23:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115170826.214519-1-benjamin.gaignard@collabora.com>
 <20240115170826.214519-2-benjamin.gaignard@collabora.com> <c832da45-c818-420d-aaf8-05c15c1e5426@xs4all.nl>
 <521a2a44-9ec1-4898-aca7-721d07e12643@collabora.com>
In-Reply-To: <521a2a44-9ec1-4898-aca7-721d07e12643@collabora.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Thu, 18 Jan 2024 20:22:53 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DWOZwm2E8BwfONtjrcg289wPHJEe3TMZKsBvDcn3OfNw@mail.gmail.com>
Message-ID: <CAAFQd5DWOZwm2E8BwfONtjrcg289wPHJEe3TMZKsBvDcn3OfNw@mail.gmail.com>
Subject: Re: [PATCH] media: media videobuf2: Stop direct calls to queue
 num_buffers field
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>, m.szyprowski@samsung.com, mchehab@kernel.org, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 6:32=E2=80=AFPM Benjamin Gaignard
<benjamin.gaignard@collabora.com> wrote:
>
>
> Le 16/01/2024 =C3=A0 10:21, Hans Verkuil a =C3=A9crit :
> > On 15/01/2024 18:08, Benjamin Gaignard wrote:
> >> Use vb2_get_num_buffers() to avoid using queue num_buffers field direc=
tly.
> >> This allows us to change how the number of buffers is computed in the
> >> future.
> >>
> >> Fixes: c838530d230b ("media: media videobuf2: Be more flexible on the =
number of queue stored buffers")
> >> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> >> ---
> >>   drivers/media/common/videobuf2/videobuf2-core.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers=
/media/common/videobuf2/videobuf2-core.c
> >> index 41a832dd1426..b6bf8f232f48 100644
> >> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> >> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> >> @@ -989,7 +989,7 @@ int vb2_core_create_bufs(struct vb2_queue *q, enum=
 vb2_memory memory,
> >>      bool no_previous_buffers =3D !q_num_bufs;
> >>      int ret =3D 0;
> >>
> >> -    if (q->num_buffers =3D=3D q->max_num_buffers) {
> >> +    if (q_num_bufs =3D=3D q->max_num_buffers) {
> >>              dprintk(q, 1, "maximum number of buffers already allocate=
d\n");
> >>              return -ENOBUFS;
> >>      }
> > There is another case in vb2_ioctl_create_bufs() where num_buffers is a=
ccessed directly.
> > Can you fix that one as well?
>
> It is removed by the patch I have send just after this one:
> "media: core: Refactor vb2_ioctl_create_bufs() to always set capabilities=
 flags"

I'd prefer that to be also included in this fix, so that it's all
logically grouped together. Actually Hans also ended up including that
change in his patch, without the commit message mentioning it.

Best regards,
Tomasz

