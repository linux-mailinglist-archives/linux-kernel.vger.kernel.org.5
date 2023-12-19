Return-Path: <linux-kernel+bounces-5890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2A8819113
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59AD428710B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07EC39875;
	Tue, 19 Dec 2023 19:57:14 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EB539AC2;
	Tue, 19 Dec 2023 19:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6d9d6f8485eso1085807a34.0;
        Tue, 19 Dec 2023 11:57:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703015832; x=1703620632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5oCP0nwQO5wEOvgfd+3H9DFTIgN90szcGpyE0ltIP50=;
        b=gXDfyhqxzZcOKk3NzejaQK6CqiB+8kF2nQ6/tpKJm3EAS9YUDz5FX+YfuxW09DOlxm
         PQUzix9T8Rj1k2dLARm7FFqTA8+V0x3ztb08KgZ9351prSnQHWrQGQub2mhtI7Q45IsB
         XHec35lGdtyzE5Gsdz5hqUZbJ56MTMU6Oyzlo2nYrjJN/lQSRePW2iC+PFfZq/TFM41z
         072vP6YgxONEZtX/6X4VjUCQ+xroYHAIG3I3YRwNHhJvVkeTcDKYPyHLV+VV+HzRToGi
         U/vvCuc92Ti8a3TPbPLX02q6a3IJt2fC0XFCo6BA/zhvpBG+hNV5aDxte8QkDfQnzi7/
         cpiQ==
X-Gm-Message-State: AOJu0YzDe8KTSnPnsI8EqvmNhQVeDPbdevQISf7hJsETH5HmoTnzuQwH
	5GouunlYtaQ2HEN0+eyGFZw9t6esIrbDgasoNe8=
X-Google-Smtp-Source: AGHT+IG/27mWFk+fxLspMdQiyn7v922FtI1ORMFRxzYdCCTS1VVUxHsTa/1lmO2CBWy6NwwA/0Yh5rNTV7WH8bwT9Eo=
X-Received: by 2002:a05:6870:b149:b0:203:bb0a:ea7f with SMTP id
 a9-20020a056870b14900b00203bb0aea7fmr8331289oal.5.1703015832187; Tue, 19 Dec
 2023 11:57:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <19e305896a2357d305f955fa14cc379e40e512bd.1702977429.git.chen.haonan2@zte.com.cn>
In-Reply-To: <19e305896a2357d305f955fa14cc379e40e512bd.1702977429.git.chen.haonan2@zte.com.cn>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 19 Dec 2023 20:57:01 +0100
Message-ID: <CAJZ5v0g3mkga3++RR-z4uHk2wAt6DYAi+h0rPAu4PurTugdkuQ@mail.gmail.com>
Subject: Re: [PATCH linux-next v2] kernel/power: Use kmap_local_page() in snapshot.c
To: chenguanxi11234@163.com
Cc: rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Chen Haonan <chen.haonan2@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 2:19=E2=80=AFPM <chenguanxi11234@163.com> wrote:
>
> From: Chen Haonan <chen.haonan2@zte.com.cn>
>
> kmap_atomic() has been deprecated in favor of kmap_local_page().
>
> kmap_atomic() disables page-faults and preemption (the latter
> only for !PREEMPT_RT kernels).The code between the mapping and
> un-mapping in this patch does not depend on the above-mentioned
> side effects.So simply replaced kmap_atomic() with kmap_local_page().
>
> Signed-off-by: Chen Haonan <chen.haonan2@zte.com.cn>
> ---
>  kernel/power/snapshot.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
> index e3e8f1c6e75f..5c96ff067c64 100644
> --- a/kernel/power/snapshot.c
> +++ b/kernel/power/snapshot.c
> @@ -1487,11 +1487,11 @@ static bool copy_data_page(unsigned long dst_pfn,=
 unsigned long src_pfn)
>         s_page =3D pfn_to_page(src_pfn);
>         d_page =3D pfn_to_page(dst_pfn);
>         if (PageHighMem(s_page)) {
> -               src =3D kmap_atomic(s_page);
> -               dst =3D kmap_atomic(d_page);
> +               src =3D kmap_local_page(s_page);
> +               dst =3D kmap_local_page(d_page);
>                 zeros_only =3D do_copy_page(dst, src);
> -               kunmap_atomic(dst);
> -               kunmap_atomic(src);
> +               kunmap_local(dst);
> +               kunmap_local(src);
>         } else {
>                 if (PageHighMem(d_page)) {
>                         /*
> @@ -1499,9 +1499,9 @@ static bool copy_data_page(unsigned long dst_pfn, u=
nsigned long src_pfn)
>                          * data modified by kmap_atomic()
>                          */
>                         zeros_only =3D safe_copy_page(buffer, s_page);
> -                       dst =3D kmap_atomic(d_page);
> +                       dst =3D kmap_local_page(d_page);
>                         copy_page(dst, buffer);
> -                       kunmap_atomic(dst);
> +                       kunmap_local(dst);
>                 } else {
>                         zeros_only =3D safe_copy_page(page_address(d_page=
), s_page);
>                 }
> --

Applied (under edited subject) as 6.8 material, thanks!

