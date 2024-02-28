Return-Path: <linux-kernel+bounces-85738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B724586BA23
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F91C1C246BF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912AB7004A;
	Wed, 28 Feb 2024 21:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jw59jCoB"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EA88625A;
	Wed, 28 Feb 2024 21:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709156624; cv=none; b=L0+VXR5LMm6jUlliSOYkeLVmQGoa2gCqsGmTvs7egjALRtpvUVToCeQ4Zzv0rxHjFfnkv9abGbkjN7bf28NOiVjQO1W/4SS2IVrp0PduFnFg1L9Lr2wkEaRPYIpXzXBRg56u2u4qwJyl4U199sNBqZA7i8LKqcyzoYLlZ5FAAL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709156624; c=relaxed/simple;
	bh=aM7XKGX0np7tp8gG7UR7aonJU+lXyXuJtFBlWXo9ZKw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V0JPfB9MDRwHQSNWp6oku7OssYyiEMJSeyZ5PAulFf0b5WLK3PzPVhckkFaHPeUQgG+pa4T1a84eFnbv4PO3O4AeYd4tM3/j4IyPGDQ07PBdWAxgCD2HLoyuxbALvdWfEU7JVdC1G7+4KezRN233AfmTew1uOHqTfiiJTy65Ocg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jw59jCoB; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5d3912c9a83so132581a12.3;
        Wed, 28 Feb 2024 13:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709156623; x=1709761423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4MROf+F57WlYpsW/TTfDlqwVn7p2q2yEa3HrwJ6r+kg=;
        b=Jw59jCoBap6tUSstSIEBKzbMuTEvTMkNRGNMaNQgdsddzqpdc1cZaBtmrsvng+/fjq
         XC0LMwiYEwnSP02aqOCZ2qKH1bkvhMY8OLcE/nRTwWRoCuc90UJ/NySsQkjNfD035Wt/
         S2p4f6AdnKR5lK3Zs7N2m1Pu9oahgo+5QNfs4C+sW6edUsvNTwAu9Zgwx4WBLfNi4hs3
         BewO+R894UOGvlWI2vpjLJ5scgBKHK3bjFNAbTWco83oddDFshUWlN3ScU+3LSbaNVwx
         RDACwdSrlThjt7ZMDr0wabrsGZmXkiVaj8SjFbFn8jkl6DTHImRQD2nkSTvRaEfqlIKY
         E3kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709156623; x=1709761423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4MROf+F57WlYpsW/TTfDlqwVn7p2q2yEa3HrwJ6r+kg=;
        b=g/N7AzboIQN1TSGkDWwGvu1EkjpFFp4W8gIA6z8vyiEwf8FjiHnjPTElZZUY88wYgE
         0pmL8hi8JGm7kJTDM1wRXvuOUYGqsDuweasSqulgI+x6mKyGf7pLheaLQXeyQAPueUMN
         k06g3dX5c0FqgCZ3Bz1ctaYAW1jVQW0BqUEyik6jfFHaiosiYGg5Kmr1g+RTPP5rL5D3
         AVxl65a+xMXVCPeN58OGiys7G81g2CWmXvPpY7BVycTYVcgCVe9cxKH6+zTy6LYYjt+Y
         y22TrDZI1nHY2uYiDOcg6OFKFkVVsF8Kay9tTMn0P3qanFw4H3tHSMtBYIlnD8W+zbcy
         kpdg==
X-Forwarded-Encrypted: i=1; AJvYcCXJauhuwY/iV8+iniW3oCfiNQZf8u0NGeiFV3b/EN+ElPTynZZ6kgq2xKgnDYLWDA2hxumiTQ22ivdYDYS8b7eAuM6uzFsnvvUp6oX4sL2AZfkG7/rlHQATCzQ9Xza+zIC4LYAbx1YKXhf2MHS2Eq9OHw==
X-Gm-Message-State: AOJu0YwcmaFjg154kGfQ9kYk8q6BSYLrG3SEd1FyoNMKMTcr9wWNBXe3
	bV06dZPW3H0qs/xXCYjx4SpcEPd4patFfrOT/fyInA0x+X5SD5V+Tx5iv5q6a4WTxhI3/Rt/TEL
	/03bn0SZDE59b+l+IASZGRSTU6kM=
X-Google-Smtp-Source: AGHT+IHYU/yGXd4MDshpKRx80tk5wSCpTZYb44+puq4sjffOz7w4cXohR+y1Cw54XwuCp12wOXwTWBNYsYnp3p6XwlA=
X-Received: by 2002:a17:90a:6c03:b0:29a:ee72:1058 with SMTP id
 x3-20020a17090a6c0300b0029aee721058mr417989pjj.35.1709156622437; Wed, 28 Feb
 2024 13:43:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228150149.4799-1-vishnuocv@gmail.com> <d6d0806e-5b5d-474c-affa-d43d88785275@redhat.com>
 <fdda6515-3b13-4727-9304-c740c77003ec@app.fastmail.com>
In-Reply-To: <fdda6515-3b13-4727-9304-c740c77003ec@app.fastmail.com>
From: Vishnu Sankar <vishnuocv@gmail.com>
Date: Thu, 29 Feb 2024 06:43:05 +0900
Message-ID: <CABxCQKtUFpiap-Zi5ihDD6W=NSd3Jn9RXykFPUz_Nj4WQ_qjWg@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Add more ThinkPads with
 non-standard reg address for fan
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	"platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	Vishnu Sankar <vsankar@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Hans and Mark,

Thanks for the review.
On Thu, Feb 29, 2024 at 5:19=E2=80=AFAM Mark Pearson <mpearson-lenovo@squeb=
b.ca> wrote:
>
> Hi Hans,
>
> On Wed, Feb 28, 2024, at 11:09 AM, Hans de Goede wrote:
> > Hi,
> >
> > On 2/28/24 16:01, Vishnu Sankar wrote:
> >> Add more ThinkPads with non-standard register addresses to read fan va=
lues.
> >>
> >> ThinkPads added are L13 Yoga Gen1, X13 Yoga Gen1, L380, L390, 11e Gen5=
 GL,
> >> 11e Gen5 GL-R, 11e Gen5 KL-Y.
> >>
> >> Signed-off-by: Vishnu Sankar <vishnuocv@gmail.com>
> >
> > Thanks, I have no objection against this patch:
> >
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> >
> > But this feels like it will become a game of whack-a-mole.
> >
> > Mark can you reach out to the ThinkPad firmware team and
> > figure out if there is some supported way to automatically detect
> > this ?
> >
> These are all older platforms and we're not expecting to see this on any =
newer platforms...if it shows up it's because they messed up (there is a sp=
ec and they're supposed to follow it).
> Vishnu did review with the FW team which platforms had used this implemen=
tation, and we believe the list below to be complete.
>
> Vishnu, please correct me if you've heard otherwise.
This is confirmed by the FW team.
The list of systems is complete and no more systems are expected (as of now=
).
>
> As a note, I did review this during an internal review, before Vishnu pus=
hed it, so I'll add:
>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>
> Mark



--=20

Regards,

      Vishnu Sankar
     +817015150407 (Japan)

