Return-Path: <linux-kernel+bounces-85267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6FB86B338
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EF50B21CBA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C32A15CD61;
	Wed, 28 Feb 2024 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HPm6C3Xx"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AC614D44E
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 15:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709134502; cv=none; b=PqALHkOyFjKhAxtlXWq2rhC0TVmAyMVKny1P8NgvBuGHZbfALFFrfyT+cVE9nsgatVlajGMS263T9r+BWp04n0ibnu7A3IfSAT9AgA1vnos+Wzbao8D6AXztymwltb50J5KeE0vg1unrlnHhzkTwVwmzEmGg7/RTg+f1yYklmzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709134502; c=relaxed/simple;
	bh=iNAvgyIqsVv/a99B/1dg7WEzlEY9khThv7cRxR59TPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QSrTmV1KVTYiJA1JwXeFok4l0oxYREzjM48ujAq0VCrCsyeYDl6SOmS/pnZrVJYPKRIWmt0Kh1pXUzrd2oTsBtv2HW0ACxNwcs/I2dvH189oIC6pjSFwl0hM5Yr9Hj1oQVRx07rfS/GFY0+NDbAM/cz4EIuX3zLZt1LmxhWtyG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HPm6C3Xx; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7c48e13e0d7so308093239f.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 07:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709134500; x=1709739300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNAvgyIqsVv/a99B/1dg7WEzlEY9khThv7cRxR59TPU=;
        b=HPm6C3XxwNfjszlsA1n/CowCufncjMuoBY7FmJY224uRb9Rog1S5Jy/CPK4ppcqYhc
         HHXiK9IP0gVRI558n7IbN+psZN/84HrMyuUuryIiPq+kYHFLfV/VwzGE9YGo1PfPQsDj
         fcAW+lB5IXyf9EyLS62MefSBNE680lGLroMHxqUWUTyO4hJba+HqSNAZ12j1X0J21VGs
         ZVsGinuuZdaOD+j3BXlepOMihbDI6+faOGE5AH9Cn/yDDW2OP+qCjAr+7nggzEd+2Y6C
         t/fSCyC0ulDIbOYVVs9ka6nyRMunYWVK8KENxZzoADJEjyXWa+pVxyhk6m7QzXfY1K/P
         dCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709134500; x=1709739300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iNAvgyIqsVv/a99B/1dg7WEzlEY9khThv7cRxR59TPU=;
        b=LNntWh2JS/YSDFmNDLS6M2KET0JJ8unZAL5Hix0eNFnQf1YbUTYUcfeYHlShXFVj2a
         4s2fI+wUEu1RlrA5z+JnyReVcHw8kIUTxbHg+ngDEw1w13BMzU+kr9cb+xuounM6jvuC
         mcDRrcCUmWzs/CEjDMzG/GkIlhVfu4IPqA9JTztmoBR5ksdJwx91liHv2r3LSKuhcS2L
         I1Ahj2bMf0jO1z/5bRBtti3Y1aK8BriwnoY4bDkAMOynZ8qYdUflZG5hBkryCyZiUh/c
         QUcmBwPGrKrBxPcK5Y0B1Pq7TTNNZ6GAarB2hMz0cUmA0Oeq61nOwRYnIdagCp6+lYpo
         wrZw==
X-Forwarded-Encrypted: i=1; AJvYcCVNPll9pMze64xYf7KOUALbjkkyOXlmF9epXpd49tVvw06uy0jlw/uG3ZDEAjl3KUlIgJJ4XlsoU+eQ+y2dQJ+dmh5TxTFWqqBILFyk
X-Gm-Message-State: AOJu0YwyaV1Q5GTRNRy4XHUmcjmdcmAH2fbqiz2kryw8SWJa1nTDnMES
	OJFFoU6xfCpH1MLOHtZBzrvDILHZoaMmoTywV2f75ZQ0wFUDsMBXgIRe65nH2c+LdfnjxOTS1Xt
	hj1+dVNwgh30G3wNfXfJ7efxb9rQkZtDQ1RNc
X-Google-Smtp-Source: AGHT+IEeVN3q9xNzpReeRZxijH7C6wt2a9IrbXxLntCsmJH6YSq6dIRXQNoD0I6sxRdNJtvS6Sw8zAyHk4q5Fcirhqk=
X-Received: by 2002:a6b:5a02:0:b0:7c7:b9bc:26ed with SMTP id
 o2-20020a6b5a02000000b007c7b9bc26edmr12066971iob.11.1709134500112; Wed, 28
 Feb 2024 07:35:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221160215.484151-1-panikiel@google.com> <20240221160215.484151-2-panikiel@google.com>
 <ce262cda-84ba-4d8f-a916-76488c94066d@xs4all.nl>
In-Reply-To: <ce262cda-84ba-4d8f-a916-76488c94066d@xs4all.nl>
From: =?UTF-8?Q?Pawe=C5=82_Anikiel?= <panikiel@google.com>
Date: Wed, 28 Feb 2024 16:34:49 +0100
Message-ID: <CAM5zL5qrMNfyiXMOJHUzLySm_U2U8kbD=D_Cyn0WjkvpikiYpQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] media: v4l2-subdev: Add a pad variant of .query_dv_timings()
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc: airlied@gmail.com, akpm@linux-foundation.org, conor+dt@kernel.org, 
	daniel@ffwll.ch, dinguyen@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	maarten.lankhorst@linux.intel.com, mchehab@kernel.org, mripard@kernel.org, 
	robh+dt@kernel.org, tzimmermann@suse.de, devicetree@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, chromeos-krk-upstreaming@google.com, 
	ribalda@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 12:25=E2=80=AFPM Hans Verkuil <hverkuil-cisco@xs4al=
l.nl> wrote:
>
> Hi Pawe=C5=82,
>
> On 21/02/2024 17:02, Pawe=C5=82 Anikiel wrote:
> > Currently, .query_dv_timings() is defined as a video callback without
> > a pad argument. This is a problem if the subdevice can have different
> > dv timings for each pad (e.g. a DisplayPort receiver with multiple
> > virtual channels).
> >
> > To solve this, add a pad variant of this callback which includes
> > the pad number as an argument.
>
> So now we have two query_dv_timings ops: one for video ops, and one
> for pad ops. That's not very maintainable. I would suggest switching
> all current users of the video op over to the pad op.

I agree it would be better if there was only one. However, I have some conc=
erns:
1. Isn't there a problem with backwards compatibility? For example, an
out-of-tree driver is likely to use this callback, which would break.
I'm asking because I'm not familiar with how such API changes are
handled.
2. If I do switch all current users to the pad op, I can't test those
changes. Isn't that a problem?
3. Would I need to get ACK from all the driver maintainers?

