Return-Path: <linux-kernel+bounces-23292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F7BB82AA8E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 850B91F21DB2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC48F101DA;
	Thu, 11 Jan 2024 09:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KRG7sMkk"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47DFFC1D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dbf2b5556f9so1371924276.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 01:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704964205; x=1705569005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXjcPmzG/A7mlaieQ9giQPRodlEupSyhDif0JeD6lQU=;
        b=KRG7sMkkw9MO86lsNRzo0dsgMN1fgnO9f2MqL3qQ8ZHcdkCOLnBxL4NZ9eGnHayLh6
         J/G7gHv9DNAc5AKJhXxWlK4fA6bEMvtM8gV5dQPajrN8ckob4TLbQzkqzz0PbO6xU4CL
         I00Q0WqB0u9WWmBbI+u6iwwumQuUzGJZ4Zr2dy9pgN6eUzoA3RPTriM5ecgqXOLt4j9e
         TyDmNwS0wdzNZLaCEpvjUA7yywcUH+77c6AtNNd7H5NUpgL7Uu6wRr+c9/joFARTYjbP
         bQdr/pCtADJULYO9tZkd+qMTuutsWY7TsiNTTFVQan+HSKrLoFeq9TXJOjYSlHcPL+Cm
         jLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704964205; x=1705569005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oXjcPmzG/A7mlaieQ9giQPRodlEupSyhDif0JeD6lQU=;
        b=G0rK/F/jD2bWxbLJcalGODXIa1PSF853fMiEUQlaxxsH2Ijb2770wlQgvLsd1DPaH7
         EcP7nqwBjet70gibsfGH/bhPojsErHS0WqtB7J2ZSEOyIjnvcyPdP97SK2FceGZblGmt
         /vkxJWh421JABgCpXckGoteNIjVqYc95b7F28fFha2K26JG9KOPkXNI8YiycxYi7zKhw
         c5BHdqUiU7g4qW75I9AyUakUX5ZedFagJob2qz5tUSRwgCUxI2w8fYKBrl2PK5UHa++q
         3IQSRlrQWOi8QcUioq/l9ssDpY31U55l2oP1BE26TDf/F4UcKYOLK7xSJVaZhTRT6hNg
         KHVA==
X-Gm-Message-State: AOJu0YwORxw6TpoowlDaxOLbDvjb4WjBX3U/0sgvobFHC/vl2bTk8RTu
	SFdO39Fdci5HV+1CYIbuooV50Yqsw8HFW3ykmHP7Zc4bgXA01fy9
X-Google-Smtp-Source: AGHT+IE4mcy7QGOY4i1Yr3rQGg5S+FuyePKgtStKpiklcSlnUuoIo4BONjaCFhJ0DazKy1raPRL1X2pu+KuJC2vd4U0=
X-Received: by 2002:a25:8005:0:b0:dbc:b48e:6426 with SMTP id
 m5-20020a258005000000b00dbcb48e6426mr789726ybk.110.1704964205393; Thu, 11 Jan
 2024 01:10:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111070652.71717-1-pranavsubbu@gmail.com> <2024011144-silica-viral-9e79@gregkh>
 <CAP1Lp88vEZJtd69Njf9uZ5VXypwZ-5vLdBHf2xoLSpqmeyEQiA@mail.gmail.com>
In-Reply-To: <CAP1Lp88vEZJtd69Njf9uZ5VXypwZ-5vLdBHf2xoLSpqmeyEQiA@mail.gmail.com>
From: Pranav Athreya <pranavsubbu@gmail.com>
Date: Thu, 11 Jan 2024 14:39:54 +0530
Message-ID: <CAP1Lp8-CP-uELVam=18oADOEvL_13wXkTyDLHKbjQe1ZyxiG9g@mail.gmail.com>
Subject: Re: [PATCH] staging: vt6655: Remove extra blank lines between code blocks
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Forest Bond <forest@alittletooquiet.net>, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

My apologies, resending this as plain text.

Greg,

Thank you for reviewing my patch! Shall I amend the commit and send a
revision of the patch?
If I understand you correctly, I should remove all mention of the
mod.c file from the commit,
which will leave the new text as such:

Adhere to Linux kernel coding style.

Reported by checkpatch:

drivers/staging/vt6655/rxtx.h:22: CHECK: Please don't use multiple blank li=
nes

Signed-off-by: Pranav Athreya <pranavsubbu@gmail.com>
---
 drivers/staging/vt6655/rxtx.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/vt6655/rxtx.h b/drivers/staging/vt6655/rxtx.h
index a67757c9bb5c..be1e5180d57b 100644
--- a/drivers/staging/vt6655/rxtx.h
+++ b/drivers/staging/vt6655/rxtx.h
@@ -19,7 +19,6 @@
 #define DEFAULT_MSDU_LIFETIME_RES_64us 8000 /* 64us */
 #define DEFAULT_MGN_LIFETIME_RES_64us  125  /* 64us */

-
 /*---------------------  Export Definitions -------------------------*/

 /*---------------------  Export Variables  --------------------------*/

Yours Sincerely,

Pranav.

Yours Sincerely,

Pranav.


On Thu, Jan 11, 2024 at 2:33=E2=80=AFPM Pranav Athreya <pranavsubbu@gmail.c=
om> wrote:
>
> Greg,
>
> Thank you for reviewing my patch! Shall I amend the commit and send a rev=
ision of the patch?
> If I understand you correctly, I should remove all mention of the .mod.c =
file from the commit,
> which will leave the new text as such:
>
> Adhere to Linux kernel coding style.
>
> Reported by checkpatch:
>
> drivers/staging/vt6655/rxtx.h:22: CHECK: Please don't use multiple blank =
lines
>
> Signed-off-by: Pranav Athreya <pranavsubbu@gmail.com>
> ---
>  drivers/staging/vt6655/rxtx.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/staging/vt6655/rxtx.h b/drivers/staging/vt6655/rxtx.=
h
> index a67757c9bb5c..be1e5180d57b 100644
> --- a/drivers/staging/vt6655/rxtx.h
> +++ b/drivers/staging/vt6655/rxtx.h
> @@ -19,7 +19,6 @@
>  #define DEFAULT_MSDU_LIFETIME_RES_64us 8000 /* 64us */
>  #define DEFAULT_MGN_LIFETIME_RES_64us  125  /* 64us */
>
> -
>  /*---------------------  Export Definitions -------------------------*/
>
>  /*---------------------  Export Variables  --------------------------*/
>
>
> Yours Sincerely,
>
> Pranav.
>
>
> On Thu, Jan 11, 2024 at 12:52=E2=80=AFPM Greg Kroah-Hartman <gregkh@linux=
foundation.org> wrote:
>>
>> On Thu, Jan 11, 2024 at 12:36:52PM +0530, Pranav Athreya wrote:
>> > Adhere to Linux kernel coding style.
>> >
>> > Reported by checkpatch:
>> >
>> > drivers/staging/vt6655/rxtx.h:22: CHECK: Please don't use multiple bla=
nk lines
>> >
>> > drivers/staging/vt6655/vt6655_stage.mod.c:38: CHECK: Please don't use =
multiple blank lines
>> > ^Ignore the blank lines in vt6655_stage.mod.c since *.mod.c files
>> > are included in .gitignore.
>>
>> *.mod.c files are not something that you can change, and are not in your
>> patch either:
>>
>> > Signed-off-by: Pranav Athreya <pranavsubbu@gmail.com>
>> > ---
>> >  drivers/staging/vt6655/rxtx.h | 1 -
>> >  1 file changed, 1 deletion(-)
>>
>> So the text is not correct :(
>>
>> thanks,
>>
>> greg k-h

