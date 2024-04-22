Return-Path: <linux-kernel+bounces-153108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFCA8AC92E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E24B31C2129C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1881A12837C;
	Mon, 22 Apr 2024 09:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DpfVDwzM"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93BD4317E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713779042; cv=none; b=VThgER4ywKEQP58/MAiiwIpbHVDuhpxDC7q7CAj08t0VLlc4aN1WkcpPy9BGYiRR7S5l4oYMiafxAfYZRmbrJPkoUfu++F9U1FbPOx1RM4khdwbtW+GdZG6Ec3x5djJXxH92h9zfbvtCeutsXpHtPbza2j+DrqkLXkxkdWzSsZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713779042; c=relaxed/simple;
	bh=qU7j2eKzRzGdXHdu+v41VpmFqjyLjtsDGOhen0o7tWc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nrogxqd1h3tFlDo4+71l4gi5undLoiQpt4H8M7Vl5rxg24G/b+/vFmZXyc6jg4E6AihFbsIaRAs7hV8dy2PyYTKN/isTwDwiS33ksbKZzRzeNAz1iqTYljDRPeM8Uh1fUZGALLW0AfXoe4YYvycbPGlH9ecVXCnQ5DDpSTIkG1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DpfVDwzM; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-439b3cc8d91so3671811cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 02:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713779039; x=1714383839; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9VxCHy7J40of+JwGi5IlPyBYxiLpWTy7yUQsIy5MFME=;
        b=DpfVDwzMCRs96pKN/ZLYJz3tnxkVXAjGlxlPbL7i+c3cuKO/VvW5j4+tuKCRzi7qoQ
         xokFm8H/oGXJNmYdPh37bLtDFPUMuQAKicPQWtIFXEFqk1uxkU4Wj+POBiH9nYfvR2jE
         SwD6Qq6By/xCMY1u8DZJ4SI53DnEz6Ts5DatE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713779039; x=1714383839;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9VxCHy7J40of+JwGi5IlPyBYxiLpWTy7yUQsIy5MFME=;
        b=JDf4pjPM/fKVCSFOxXuMaI7qXN9Ik6xHpg1RcdyMQq/pCCsT53gPgqXpUitJwpq07l
         wuAKSGZYJK6YXbtFfn3NarGKwWEyQIAR+7s298gvqRNrYtCtaRDndM/f2jucHl5X/LxQ
         6zeF+Kwm5KM4Yk+ISN73AXq2+utHJk0gce1g7+hFJcnG8zUPmgTAYXAy4CzR0ekch8f4
         BXxoKKiJB5LCMuZp503zsKZvGIXBwN6oZ4hyG3T3cAci01XjcH+cRiSOST8EuMD3XF1R
         m3NLjK8e4okKQFjPdrkpxjP9toECBEXvYBSx7zq6KHChVzE+uWyMnSgbeZkeNJetevKI
         +oNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZlQ3+NCwPyRSASHcpPuWY+aANUgYzvssFzm2psGk9Iwlu4GS7Erl6WQ3bFr+PWwuy1Q1t26wekNuBgbPvZf1vIG/BD8aIfDOPYqRk
X-Gm-Message-State: AOJu0Yz2JiokG1oOhTyEnP/Vs+tCh7I+2OI/QYo/sLV6vNkssujlUXw0
	lhVwAo1416My8zbg1WoLX7bhFfQHlatysezr9SDhw65eeX8O3I9K3ozbgTx+TQBSaqpTssuloAw
	Dnw==
X-Google-Smtp-Source: AGHT+IEW5MPBgGyilinXVQZJ9W3CEDH8E3RvnqBPRqqp1mLpAm6ryrR5hV7JQt8MwXg9/yptp9w2Qw==
X-Received: by 2002:ac8:59d2:0:b0:439:b8cb:b54c with SMTP id f18-20020ac859d2000000b00439b8cbb54cmr2428508qtf.29.1713779039009;
        Mon, 22 Apr 2024 02:43:59 -0700 (PDT)
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com. [209.85.219.52])
        by smtp.gmail.com with ESMTPSA id kg25-20020a05622a761900b00436eacea78fsm4091894qtb.65.2024.04.22.02.43.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 02:43:58 -0700 (PDT)
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-69b514d3cf4so36874436d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 02:43:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX0uvfDt0T4xSwdx/4qFksJ9/V8AP80SP/yCWZUG30lY/ie7JD9doOJZHuys6YaTU0BLyLprMHkPm2AZE8E+lfZiuB8q5JEQHM4Yq0d
X-Received: by 2002:a0c:fe0d:0:b0:6a0:826b:cdea with SMTP id
 x13-20020a0cfe0d000000b006a0826bcdeamr1640823qvr.47.1713779037993; Mon, 22
 Apr 2024 02:43:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ab56c444-418a-423d-8528-cf04d5d458ef@moroto.mountain>
 <CANiDSCvGc2hv-6+THH28vE6uaTL+go7144hSYafkhp21uaM1Cg@mail.gmail.com> <f17042fd-890a-4a1e-b51e-6aead9986128@moroto.mountain>
In-Reply-To: <f17042fd-890a-4a1e-b51e-6aead9986128@moroto.mountain>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 22 Apr 2024 17:43:44 +0800
X-Gmail-Original-Message-ID: <CANiDSCvmWnYVib4OqqE+tZuBmGVTOo0ULo57VXwY1ekzT3T2NQ@mail.gmail.com>
Message-ID: <CANiDSCvmWnYVib4OqqE+tZuBmGVTOo0ULo57VXwY1ekzT3T2NQ@mail.gmail.com>
Subject: Re: [PATCH] media: stk1160: fix some bounds checking in stk1160_copy_video()
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: =?UTF-8?Q?Ezequiel_Garc=C3=ADa?= <elezegarcia@gmail.com>, 
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Dan

On Mon, 22 Apr 2024 at 17:30, Dan Carpenter <dan.carpenter@linaro.org> wrote:
>
> On Wed, Apr 17, 2024 at 08:48:23PM +0200, Ricardo Ribalda wrote:
> > Hi Dan
> >
> > On Wed, 17 Apr 2024 at 19:51, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> > >
> > > The subtract in this condition is reversed.  The ->length is the length
> > > of the buffer.  The ->bytesused is how many bytes we have copied thus
> > > far.  When the condition is reversed that means the result of the
> > > subtraction is always negative but since it's unsigned then the result
> > > is a very high positive value.  That means the overflow check is never
> > > true.
> > >
> > > Fixes: 9cb2173e6ea8 ("[media] media: Add stk1160 new driver (easycap replacement)")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > ---
> > > This patch is untested, I just spotted it in review.
> > >
> > > When this bug is fixed, the two checks for negative values of "lencopy"
> > > could be removed.  I wrote a version of this patch which removed the
> > > checks, but in the end I decided to leave the checks.  They're harmless.
> > >
> > >  drivers/media/usb/stk1160/stk1160-video.c | 8 ++++----
> > >  1 file changed, 4 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/media/usb/stk1160/stk1160-video.c b/drivers/media/usb/stk1160/stk1160-video.c
> > > index 366f0e4a5dc0..bfb97ea352e7 100644
> > > --- a/drivers/media/usb/stk1160/stk1160-video.c
> > > +++ b/drivers/media/usb/stk1160/stk1160-video.c
> > > @@ -139,8 +139,8 @@ void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
> > >          * Check if we have enough space left in the buffer.
> > >          * In that case, we force loop exit after copy.
> > >          */
> > > -       if (lencopy > buf->bytesused - buf->length) {
> > > -               lencopy = buf->bytesused - buf->length;
> > > +       if (lencopy > buf->length - buf->bytesused) {
> > > +               lencopy = buf->length - buf->bytesused;
> > >                 remain = lencopy;
> > >         }
> >
> > I think it is a bit more complicated than bytesused.
> >
> > bytesused does not take into consideration the actual position where
> > it is going to write.
> >
> > What we really want to check is if
> >
> > offset = dst - buf->mem;
> > if (offset + lencopy > buf->length) {
> >   lencopy = buf->length - offset;
> >   remain = lencopy;
> > }
> >
>
> You're right...  There is a comment explaining why we multiply the
> number of lines written by two, but it doesn't really clarify anything
> for me:
>
>         /* Multiply linesdone by two, to take account of the other field */
>
> What's the "other field"?

I guess it p[0].


Looks like the device sends first the data for the even lines, and
then the data for the odd lines (or the other way around).
And we are descrambling the data in the kernel

The code uses p[0] to figure out if it is the beginning of a block of
odds/evens, and if it is odd or even

if (p[0] == 0xc0 || p[0] == 0x80) {
/* We set next packet parity and
* continue to get next one
*/
dev->isoc_ctl.buf->odd = *p & 0x40;
dev->isoc_ctl.buf->pos = 0;
continue;
}



>
> I kind of suspect that the stk1160_buffer_done() might be wrong as well.
>
>         vb2_set_plane_payload(&buf->vb.vb2_buf, 0, buf->bytesused);
>                                                    ^^^^^^^^^^^^^^
>
> We're calculating the space left based on ->pos which can be reset to
> zero in stk1160_process_isoc().  But ->bytesused isn't reset, so
> potentially we could end up in a situation where ->bytesused is greater
> than the ->length of the buffer.  Should stk1160_process_isoc() set
> ->bytesused to zero as well?

I do not think so. bytes->used is len(odd) + len(even). If you reset
bytesused then you are only returning 1/2 the size


>
> regards,
> dan carpenter
>


-- 
Ricardo Ribalda

