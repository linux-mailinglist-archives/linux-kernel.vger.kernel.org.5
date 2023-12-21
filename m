Return-Path: <linux-kernel+bounces-8561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F56981B96B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFCCF286C1C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EC96D6EF;
	Thu, 21 Dec 2023 14:17:44 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A506D6C0;
	Thu, 21 Dec 2023 14:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6dbb9d03b5eso100008a34.1;
        Thu, 21 Dec 2023 06:17:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703168260; x=1703773060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBHSazj3p+MLo+y/uvsliBm5vLXGA+IDGINMZnlhLjU=;
        b=b0YdAvzTy8XW9rHfrp9OvDcG6df+eCtjbwRZSopAewKrlsz5LV3X2iK6ZpX1kmxsS+
         vxtRNGhBCGPrMN4i4qQP+HKrMIuxWWTP5h9GPaFjJC6pvJ0yWYZbgIhF+JCf85IKeP8U
         Q6UUPbpwxVBLAmJNIcozoWXo8QWkwbq/XLqo266MSPqddIPpqy6qbsWe74zsNSnd9VxV
         Nnh9DGoamR5OHQ8PMERoJdGtdK/HMY6Izq/SNbl/RXFXh8PDX7UDY8jvKzTJ5QvQ3PRL
         lhoKvHW8vB06eCwWEd/KPGk8YZNN4NC/Zs3fbqnAD0GU6LgAE265cXkOUr1xWui0eaeq
         IAKA==
X-Gm-Message-State: AOJu0YygwXY4+3BLWsXDWxMz0o+oYf3c/7H+e8xm16gPisBVhfPUKvvw
	u4mjqGjaMbPx8XCblt6T4KbQJbQBu8xWLLDP7XZOhZDzuvM=
X-Google-Smtp-Source: AGHT+IEj20FBnmLZ/ARdh0C0RK0hJmU/LJkWL9Ggrx3TW+UsEGgW147R1BWJygWWzB9l/UjKt/sx9R3eMBp8DiHLGNY=
X-Received: by 2002:a05:6820:258a:b0:593:e53b:2df1 with SMTP id
 cs10-20020a056820258a00b00593e53b2df1mr7893445oob.1.1703168260730; Thu, 21
 Dec 2023 06:17:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231215072405.65887-1-luoxueqin@kylinos.cn>
In-Reply-To: <20231215072405.65887-1-luoxueqin@kylinos.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 21 Dec 2023 15:17:29 +0100
Message-ID: <CAJZ5v0g5PdOiRVB08zvi1gBqFU5LKm4O0FaFdH-FC=eQKyNNGA@mail.gmail.com>
Subject: Re: [PATCH -next] ACPICA: Replace strncpy() with strscpy_pad() for dest
To: xueqin Luo <luoxueqin@kylinos.cn>
Cc: robert.moore@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 15, 2023 at 8:24=E2=80=AFAM xueqin Luo <luoxueqin@kylinos.cn> w=
rote:
>
> While it is safe to use strncpy in this case, the advice is to move to
> strscpy_pad[1].
>
> Link: https://www.kernel.org/doc/html/latest/process/deprec:qated.html#st=
rncpy-on-nul-terminated-strings [1]
> Signed-off-by: xueqin Luo <luoxueqin@kylinos.cn>
> ---
>  drivers/acpi/acpica/utnonansi.c | 3 +--

ACPICA code comes from an external project.  The proper way of
modifying it is to submit a pull request to the upstream ACPICA
project on GitHub.  Once this pull request has been merged upstream, a
Linux patch containing a Link: tag to the corresponding upstream pull
request can be submitted.

Thanks!

>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/acpica/utnonansi.c b/drivers/acpi/acpica/utnona=
nsi.c
> index ff0802ace19b..3a7952be6545 100644
> --- a/drivers/acpi/acpica/utnonansi.c
> +++ b/drivers/acpi/acpica/utnonansi.c
> @@ -168,8 +168,7 @@ void acpi_ut_safe_strncpy(char *dest, char *source, a=
cpi_size dest_size)
>  {
>         /* Always terminate destination string */
>
> -       strncpy(dest, source, dest_size);
> -       dest[dest_size - 1] =3D 0;
> +       strscpy_pad(dest, source, dest_size);
>  }
>
>  #endif
> --
> 2.34.1
>
>

