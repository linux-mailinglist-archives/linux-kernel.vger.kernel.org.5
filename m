Return-Path: <linux-kernel+bounces-118062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CABD188B327
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 089471C3D32D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02816FE2D;
	Mon, 25 Mar 2024 21:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QZMpLRZ/"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5EA6FE05
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 21:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711403417; cv=none; b=kBbND8IS/HNFE7rz7SCDKcyCLEOpkRXUL3NYuFQ82v5zfDOakJbqiiKa40dx/IU6OFrODEFjdguNQZozlAzl5aCG0ljSu1lyTdGmQ05+pu/qyp+dVgexvjC0TiboiW+JqGTHRdrND67dDhIX+WfL+YY2wxULITI90JPYcilw1Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711403417; c=relaxed/simple;
	bh=oMwZrCFp8dMUvhWDn6c0mXIOD2/iSsSXxQYY8pZyntU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tSy49HqUQuSjsYIRKe4vEnj13//kWO5NCnLtIB8F3UYA0/YG2oexALXpmZP2/WxUWluY4DwTS7Gtm6deJhB1enxCcKaYneAtMw1inTMr8izabFgZrd89KsFXGhp0vMSLQwRbYyrbt+6OG9/0U1hYAJDBBX3xnOhrHmxwPNWJddQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QZMpLRZ/; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-430d3fcc511so39441cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711403414; x=1712008214; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OlpfV5Tydfz9QyOmPbOHYJo9SnZWGh9oswRld/5cI2o=;
        b=QZMpLRZ//70d8RXbaSbuDxlnhXIDjyOt8qjCz77lNLdDto/ARhSmVLxMKVpur7loyo
         xTK/MT6AWWqnreiRAzlyPumW2XZNdWYW84JOhK6Vs3f3GAkOF5+hbpX7zrtbfkcDMG53
         wAjEAQHY0vitEl4oYxbRTt0dTfN9L5N4w5AysbRffHQBgKYFSQ9iMeDfPQ5W95l7aKTY
         ism1R5sTfaeEbaaLQBthXv3zHyZNqseL5gdNDohXv71Zh3G41oDy6nXu1hqlnDJQ2w/5
         4vZGCFAfqiTgkPzrfFXtTp9fK+u9K1HVcoDLaTXj6iPc2XngWkkIzjRRgmVFxbU11fbV
         PxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711403414; x=1712008214;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OlpfV5Tydfz9QyOmPbOHYJo9SnZWGh9oswRld/5cI2o=;
        b=NUjkAD97PD+MS4zfPAYWAuTg55KCQeyfyxnpy/d/yqNCzZwskiiHISZqNxTF4rATPa
         t7y37USn+Tsu8uLDQw2hMkcsDBkMNgF3fEpyy95zsKzZ+KG+lgiIIZ1i59SStb643Cq0
         /kSbQB0QDvL7Quqqq6s+q+MPPhRJ0k6HudDe7AnXg058DKtYcZKjfAQN+eAtRBh3kWl9
         sEa3IzbeLT2zBxPa1vIGNLyVgLuFJFu2dy34SzIKUaXRd/BMiP26av5wZVMFLk+cy6im
         9laQvzmZovJnWwNhzp6QhHQO0x5YZ5EnXobBVB03nzX2SVGmCgGT5cVMdpCjAqfKmQxX
         OuxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYqrz1zhfFvCLl29YuNd9dcmDD7UO3En8KIfCon03aZdoE9y2b1VGinZpcYo6odk+E/TFbWQJwjR0paf/zs9s6qooxr61wPxSybDlo
X-Gm-Message-State: AOJu0YxTDM2m9dj8JjEDdkbvX4EbASVNTeTeBQ/xeB9GIG6wVQbi+n8k
	p/akt4SbA2x7NG+I/UvIBstBsIX3+EIYdezSfVOPtWMWRyxyJo00Skp63EzHtysmkmC8mRHPIFo
	a2R98sbh10Ae+s82wjyiFbLlmvgHU+2YdpDry
X-Google-Smtp-Source: AGHT+IHasoIaZGVqEl3+edaST5U18ERq0E2RdaIswtzIAMiCmx0wbzav9E6PID12WAD1iyP+5AzI3qWX/zPasJs4gH0=
X-Received: by 2002:a05:622a:40ca:b0:431:60bf:bba1 with SMTP id
 ch10-20020a05622a40ca00b0043160bfbba1mr24695qtb.15.1711403414204; Mon, 25 Mar
 2024 14:50:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325163831.203014-1-herve.codina@bootlin.com>
In-Reply-To: <20240325163831.203014-1-herve.codina@bootlin.com>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 25 Mar 2024 14:49:38 -0700
Message-ID: <CAGETcx9YpqNhnNgpVNCuxm_nbApVbdXgFRiLVNYP64DKcDEm8g@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND] driver core: Keep the supplier fwnode
 consistent with the device
To: Herve Codina <herve.codina@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-kernel@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, 
	Steen Hegelund <steen.hegelund@microchip.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 9:39=E2=80=AFAM Herve Codina <herve.codina@bootlin.=
com> wrote:
>
> The commit 3a2dbc510c43 ("driver core: fw_devlink: Don't purge child
> fwnode's consumer links") introduces the possibility to use the
> supplier's parent device instead of the supplier itself.
> In that case the supplier fwnode used is not updated and is no more
> consistent with the supplier device used.
>
> Use the fwnode consistent with the supplier device when checking flags.

Please drop this patch. It's unnecessary churn. fw_devlink took years
to get to where it is. There are lots of corner cases. So I'd rather
not touch something if it's not broken. If a particular case for you
is broken, start with describing the issue please and then we can
figure out if it needs a change and what's a good way to do it.

Nack.

-Saravana

>
> Fixes: 3a2dbc510c43 ("driver core: fw_devlink: Don't purge child fwnode's=
 consumer links")
> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
> Changes v2 -> v3:
>   Do not update the supplier handle in order to keep the original handle
>   for debug traces.
>
> Changes v1 -> v2:
>   Remove sup_handle check and related pr_debug() call as sup_handle canno=
t be
>   invalid if sup_dev is valid.
>
>  drivers/base/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index b93f3c5716ae..0d335b0dc396 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -2163,7 +2163,7 @@ static int fw_devlink_create_devlink(struct device =
*con,
>                  * supplier device indefinitely.
>                  */
>                 if (sup_dev->links.status =3D=3D DL_DEV_NO_DRIVER &&
> -                   sup_handle->flags & FWNODE_FLAG_INITIALIZED) {
> +                   sup_dev->fwnode->flags & FWNODE_FLAG_INITIALIZED) {
>                         dev_dbg(con,
>                                 "Not linking %pfwf - dev might never prob=
e\n",
>                                 sup_handle);
> --
> 2.44.0
>

