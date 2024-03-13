Return-Path: <linux-kernel+bounces-101232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 758C487A453
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CE3F1F228A3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B61A1B59B;
	Wed, 13 Mar 2024 08:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOZPVISl"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BCC1B965;
	Wed, 13 Mar 2024 08:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710320180; cv=none; b=ZHT427iv9mPnb6mpZFv0TlMKpKvEsIiknBVFaC8mOknyg4klVLW160GmTxX1T3nraaH/reqnLQq/Z5djAkA5DNFK9RYjbnUsp8wzOab4gRNmB5RTi4DSMKkx01GSoQ4DChznh6cGSB8RF9lyO6m8SV8QxOdeKuDl3xUfiW1gqvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710320180; c=relaxed/simple;
	bh=Db5VWsrKGzEZDK9pD+LBmGjlxK6z26zYbHNc0/tNv0k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cImocCmErE+hAhRDJle50hdy9zZfOIR/OsXSUPGPeVqr64w+9mVxV+mANB5hxNf77pbQt9d8rpC4grwnP6ueolNiQ1lg6sFgZLw7beqlWKqwn1IJoC8oNQS6EEGGlt+ejAigGBnhGRO29wKRhmvndX91sAdyRp5qQ+MkTOjkFJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOZPVISl; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5654f700705so967518a12.1;
        Wed, 13 Mar 2024 01:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710320177; x=1710924977; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+mO86kMfMWDJIo9fRORC6334q4eXYxL4m5tAq3xCEk=;
        b=jOZPVISlJ5PWA3UGAKR3muRGpjHUIax85JQUC+PG872jD9F0iF5mk+MZm3l6lNKJJI
         dAhOKxfHqv/WO523rTg56o6hbd8no7LZvjupzOo9XqA6nEiiDQN44Ga9WvDyXhAqtisw
         NYzi/u+Vhv+s9DmwiQuo/DImYmRqZwq6l7AUfLEWuekGvYz4NmEMp6jC/+/ilb1/Ei/i
         AQEwrL2U1P7/uI7eO8h3D1Jmtx1t+OOWqNIPvpw/BJ5A2QaGMWu3C24ndql4yA2iKEXS
         WBDMsLAagh7OxNbuvflbMynbRirkHyoWoqpcEVyEbBD0N5Ou4XTqngUxVgXQ/g4jzteB
         l6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710320177; x=1710924977;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+mO86kMfMWDJIo9fRORC6334q4eXYxL4m5tAq3xCEk=;
        b=MKntWNxcGOD1Xr+t3nLVXz1tebrBhJ2UBIrt0ZE8Fqd/d2vG/LNUJRkF5nLTRnDIJz
         i30/LbV55WCu2qhiV/tJqmRe7p/wc/gYbVunSjoiU+ffUjqK5TAqaNw+kYyRGCdCje1H
         lqztbO2Z1cprWtXa8LXtdsNndZO1Z2VfkgcYH4XnJ5daoSzq5gH7YDCCWou+qNN4NfAL
         /i0kyNy3ocXjrPVDcCSxq/g+RAebJOYBBiGthhP0udCCOCKA96aRj9v4uxf2Ijh/iSR0
         FBJnikENUFVxBWasWtCd1tt1DbeTT0oVWRvMEL0xrwUtB9MsFERWFvCMpUQqwbeg/F0K
         B//A==
X-Forwarded-Encrypted: i=1; AJvYcCWzJG2WEZOvmqb0ImTs5fgPuWwU8rUnSagvVcGCdHj+OqXtWqdqCruC5Uu0O+BqOgmgyZ5PnerQSzvqMgfPJ+khM/UyyJeh8hhPXocc
X-Gm-Message-State: AOJu0YwjR7Ny+j8bdnaukUJVauVesIW2Fh172GuLu46RdYXXXtWUixPM
	p3eXOMN2N57DdgEMk5I6ffmLyojhINbihxFx5T1HjxS7dE9ZkRFw8Vnqcsl/NwonNxUFbXd220W
	086WRLVCWAbvpLAUXKfo0CR3FOwU=
X-Google-Smtp-Source: AGHT+IGNRJNpkCuB1o+4v+BYFzZP0XtP8y73twDHUCnGXIa7pEfKd+ZuHmpzhScwTAmnqSCY2V/DvEdFUrwnHXCwgMY=
X-Received: by 2002:a17:906:4481:b0:a46:1b3f:ccbf with SMTP id
 y1-20020a170906448100b00a461b3fccbfmr4047748ejo.25.1710320177469; Wed, 13 Mar
 2024 01:56:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313070705.91140-1-umang.jain@ideasonboard.com> <20240313070705.91140-3-umang.jain@ideasonboard.com>
In-Reply-To: <20240313070705.91140-3-umang.jain@ideasonboard.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 13 Mar 2024 10:55:41 +0200
Message-ID: <CAHp75VcdcQbF76=j=xTtDRgkQNwVdCJ+0oD7KX4TbTfndX_5fA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] media: i2c: Add imx283 camera sensor driver
To: Umang Jain <umang.jain@ideasonboard.com>
Cc: linux-media@vger.kernel.org, 
	Kieran Bingham <kieran.bingham@ideasonboard.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, willl will <will@willwhang.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, tomi.valkeinen@ideasonboard.com, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Hans de Goede <hdegoede@redhat.com>, Alain Volmat <alain.volmat@foss.st.com>, 
	Paul Elder <paul.elder@ideasonboard.com>, Mehdi Djait <mehdi.djait@bootlin.com>, 
	Bingbu Cao <bingbu.cao@intel.com>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 9:08=E2=80=AFAM Umang Jain <umang.jain@ideasonboard=
com> wrote:
>
> From: Kieran Bingham <kieran.bingham@ideasonboard.com>
>
> Add a v4l2 subdevice driver for the Sony IMX283 image sensor.
>
> The IMX283 is a 20MP Diagonal 15.86 mm (Type 1) CMOS Image Sensor with
> Square Pixel for Color Cameras.
>
> The following features are supported:
> - Manual exposure an gain control support
> - vblank/hblank/link freq control support
> - Test pattern support control
> - Arbitrary horizontal and vertical cropping
> - Supported resolution:
>   - 5472x3648 @ 20fps (SRGGB12)
>   - 5472x3648 @ 25fps (SRGGB10)
>   - 2736x1824 @ 50fps (SRGGB12)

I have got only this patch and there is no word about changes. Please,
either make sure you Cc'ed people in cover letter to all reviewers,
and/or use a comment area (after '---' line to list the changes
related to this patch).

--=20
With Best Regards,
Andy Shevchenko

