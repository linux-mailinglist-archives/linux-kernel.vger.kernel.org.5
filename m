Return-Path: <linux-kernel+bounces-104647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF0887D16C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 470B51F26932
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 16:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBB945BF0;
	Fri, 15 Mar 2024 16:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esJ8xRYY"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EF73BB28;
	Fri, 15 Mar 2024 16:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521207; cv=none; b=UbczALTBgVnkyBvssE5vZb3h9JvEoF8X73JGSpcmL+6Xu4yhFVETwjslaQtKSdH7h3YDwIm6cy4UBZlQKADyrZJ/jW/2ojdONTOsxpLkZjJ3KqQFnqyVClH7j9YGgmdo9IU/LccJsTCv6WTJdbHAperBwAJHdF/Kx+hcBZgyxSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521207; c=relaxed/simple;
	bh=3g09VzP14HL3LpuYq61SGTlbF9K14tVeVxGuc0vMR3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CqrMDNI2jWY31NFC4dFplyef22kchWyXtVd1tR1FBHHb3r0jlQ+1B+AQ/qO2c4vVhbT9+uTy3hM8ZsJyXS7OyjnIPGewTd5CqrpsyNQtbmEAwRO7zWLPtOduKjkYof+T6TTBzNXDbl33bFlc3FC9AsVRtsq1DcoP6BOE3zz/v3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esJ8xRYY; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1dcab44747bso15856605ad.1;
        Fri, 15 Mar 2024 09:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710521205; x=1711126005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4++5UV9ZvHpUQeROXztwV98cFhFDCUy45AERunpkiTA=;
        b=esJ8xRYY7fg2QzXf9sa5aqu9eUOptWD+MxjkA/tbdnwFQPVw2WEzNA/hTreyIFcQXZ
         lSVXsQ7eNyBZAx+4kddCBK5YPl6Uzk9mL9LIAOUVHEOGrxBbzlDlpng6kt0j/8yNpiER
         hb4Yms2VEvAC6/dvk+UNEzycoHKFUXRDDeT6G5g8D0UWDWZ+AtHW8bOBE/Ct3yfoevSm
         KVYLIz3cDPWy13Awlv+Jh0fkqP0xlyOjzWPAlNg1X943PifX5NI5aHRAFs9BJFnQGZHR
         20nIe0nqeycMTReJxLz7/QaWKVqBvrBWYEB0JO6L3Yg5AvPoBpasTfiHUW9Vt+5YILeq
         IQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710521205; x=1711126005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4++5UV9ZvHpUQeROXztwV98cFhFDCUy45AERunpkiTA=;
        b=Y1gRoBrZ4bjHZmLm0O8ohIz9wqPg7TuUz3aPvhOEO82Q/ZrCuU1LFazEOX1dMQdob3
         Q7lnyDCjwG/srEnmopoQiNA4hl2JwUJQYTbKiVxV3uMfRv/P3Df3CJi8S2qi0C1PeVf1
         rAGSklCxw8us1CqFOeqr5+lwBRHDrAW5XeXe5TZhr6Xdrz/PgR21BBJ1UJzIzJn4WEBH
         h4mCAgMCs/35Cvs5S9KJqCPZm/swEP0gtbwSrT07rbQLN/1KYZSFlQGvhgTSH75YjfiQ
         VPRi8cuGV3TesLuojF7yQ5E4HeoVCLlD8MjqZAAvEO9AUXETAe9uFwxdy3qz0HUNW8UM
         tXsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHYFFq4LdszCh/zOfNWG5QB7rMXULql3wavq8kPAvnB3RVXAP9kAF/I5QuVeCLpqfiaUuDIH2PUcsUffR7st4fY7MA8YHC/PmUQc6othTJSG4uwt5noGf4d22/QoCZhWE+
X-Gm-Message-State: AOJu0YywFQXksLfBvFL8ck2xh/7RktZPnkHShw7H9xmwM1SD6cDlr5uQ
	NHVpgWbX3Op/z4Jch44nFAk7fQbQ0Yt+IoRZC7lQRB67oScg6PXTmNWjZ70au0DZfj1ZcNah1iO
	M79l6qJmC4EOGv2uXgfdY2A3TYSA=
X-Google-Smtp-Source: AGHT+IGMoIsUO9ll4nNE0OZacMHWcN3oOBh4spXquRzu5/ktY6OjNKr3zWGrgrMK1aRQIm9atbHeM1iC4xdvcGsennE=
X-Received: by 2002:a17:903:24e:b0:1dd:b728:b890 with SMTP id
 j14-20020a170903024e00b001ddb728b890mr6824453plh.18.1710521204777; Fri, 15
 Mar 2024 09:46:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315113828.258005-1-cgzones@googlemail.com> <20240315113828.258005-3-cgzones@googlemail.com>
In-Reply-To: <20240315113828.258005-3-cgzones@googlemail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 15 Mar 2024 09:46:32 -0700
Message-ID: <CAEf4BzZvaWeFZFzonh_0pmhnRtm0AJdQPi7DYU1LpNytD6zHpQ@mail.gmail.com>
Subject: Re: [PATCH 03/10] capability: use new capable_any functionality
To: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc: linux-security-module@vger.kernel.org, Serge Hallyn <serge@hallyn.com>, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 4:39=E2=80=AFAM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> Use the new added capable_any function in appropriate cases, where a
> task is required to have any of two capabilities.
>
> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> ---
> v3:
>   - rename to capable_any()
>   - simplify checkpoint_restore_ns_capable()
> ---
>  include/linux/capability.h | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/include/linux/capability.h b/include/linux/capability.h
> index eeb958440656..4db0ffb47271 100644
> --- a/include/linux/capability.h
> +++ b/include/linux/capability.h
> @@ -204,18 +204,17 @@ extern bool file_ns_capable(const struct file *file=
, struct user_namespace *ns,
>  extern bool ptracer_capable(struct task_struct *tsk, struct user_namespa=
ce *ns);
>  static inline bool perfmon_capable(void)
>  {
> -       return capable(CAP_PERFMON) || capable(CAP_SYS_ADMIN);
> +       return capable_any(CAP_PERFMON, CAP_SYS_ADMIN);
>  }
>
>  static inline bool bpf_capable(void)
>  {
> -       return capable(CAP_BPF) || capable(CAP_SYS_ADMIN);
> +       return capable_any(CAP_BPF, CAP_SYS_ADMIN);
>  }
>
>  static inline bool checkpoint_restore_ns_capable(struct user_namespace *=
ns)
>  {
> -       return ns_capable(ns, CAP_CHECKPOINT_RESTORE) ||
> -               ns_capable(ns, CAP_SYS_ADMIN);
> +       return ns_capable_any(ns, CAP_CHECKPOINT_RESTORE, CAP_SYS_ADMIN);
>  }
>
>  /* audit system wants to get cap info from files as well */
> --
> 2.43.0
>
>

