Return-Path: <linux-kernel+bounces-123613-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF732890BBD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:43:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89E252A20F1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF34D13B78F;
	Thu, 28 Mar 2024 20:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="vUxXwm9o"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CA413A890
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 20:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711658552; cv=none; b=prDwpuOPhnEnPKJfReT1fvXTy+zEvgAiXCDKgNIUehiPInYG3mlzcyMRsi4isARSXLdtz+fUTdfsfp7oJxzeMizfaUmXHjrvtmdLlEge0GSDhP55E19E/qwyufabD/BpRj3I5nfWbE1dcuUjGt3Kl0tRiAZktIM7MEe0s0qSvJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711658552; c=relaxed/simple;
	bh=Xvp2uzp/QTshAzSCZHYKZUXilg18C3KOX1kGmd5mi/k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VtuE3AuGz+GiN0/0Fvx1/l4oAptc5PGXv5YFlv7DEUH4hcpe7VudazaahoEzo1FseutazksO20gvyGP46tMORNel+OSzmY30aK6eAg6iKCviRRSWHpjDsRMFkiitbUfvHrkqk7E7jtdv/MGXhMGWBkXloltSO5HKTXMEgL0J1fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vUxXwm9o; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a44665605f3so155114266b.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 13:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711658547; x=1712263347; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xvp2uzp/QTshAzSCZHYKZUXilg18C3KOX1kGmd5mi/k=;
        b=vUxXwm9oJsnXRK86vLRxRSCc8vaNnRtf5+2D6eOe01lrXh8yQq7frJWjr7debMq6al
         LS76w0JG256Zxn7GgaQXYrlPhwD7O9sq0czcbsIu7ny8RSp3UbAGsepCS8ysppufD55s
         3muCOk9S53P7+K/cfzP3jzF8lSQDSD1DakmAGdGlMPAvcdrk1x1enhsBylWCVwMqD13j
         DDIM1A4VHUwCgFqoX403FF8xTSpUfYOxuLXaY5NsG//MLxmqPAfTZGeJThe7TkKudYDq
         WGm4lG/k1U4QMeiqhjzkYcw2ylF/0bONGrmQWUkT9mHpbrCB1PLtuKxS3GkglzpGMkHz
         KfHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711658547; x=1712263347;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xvp2uzp/QTshAzSCZHYKZUXilg18C3KOX1kGmd5mi/k=;
        b=BSMLoHvYMPa4ImDejTQ+/4E44xZ7TDiEEhT0XyH3hfVgXMVvPqlgenF4wyRQ9iPcbH
         4IOYO2D0IwgDfT1+zorj0lUYxWzxOLNzpTzALT6g2ZiFe27Odkaw1HKWPbQl5k9zYV1S
         Fr4O+ypFdijsX12BavKMYR2pLq5Pam/jarXP9d1xfZJNzaCFmxVlGHWi16lBRwKIa6dK
         sihc5tZvyC4HiIxIK+mTCdjDxzKgECnfZ3ihcLNorL3yk994CiRawmB8xEkZ2vkbxIF0
         2ZneE8UnaR1cpETLS+GWZy3MAIt+2rVN6oZYKO2AaeDY+djNpBGZY/9qhQyGN9m9AeY+
         RUPg==
X-Forwarded-Encrypted: i=1; AJvYcCXLeXsJyqscl9qoKuCBByaGsfbHsz8oCbsvgqiWQV9EHSFBlQaVI8bzyPkRlO9iXHcv0wsDjFWbU2ND3tS5PF1qnm4HACEMHfH23sKn
X-Gm-Message-State: AOJu0YzLJSnyP68soO/TooiPzVLEuMLNporxaooVh1/eEUECjCJP270/
	CEInGwBjvo8a8TcyeKojgizuwsbdu1kZqzcCAuYzOr0Pm8fK4PZ6z3Yyd5Hw++v5mGgg2jpWv/T
	Q2TG0n7X8+VcVB5NUuOhg4//sB9uHhCW9W5qn
X-Google-Smtp-Source: AGHT+IH8/usAUioO+qTpOeTXvg7l2hto6OnlgP6NOT2Q0qO008pCvTP/WT/jXd9Z+X+Kqw0CBmjAO9+FEscgo7LRR4o=
X-Received: by 2002:a17:906:594:b0:a47:32b3:18c5 with SMTP id
 20-20020a170906059400b00a4732b318c5mr203139ejn.68.1711658547456; Thu, 28 Mar
 2024 13:42:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327-strncpy-fs-proc-vmcore-c-v1-1-e025ed08b1b0@google.com> <ZgTMZ1HYheBMDbei@MiWiFi-R3L-srv>
In-Reply-To: <ZgTMZ1HYheBMDbei@MiWiFi-R3L-srv>
From: Justin Stitt <justinstitt@google.com>
Date: Thu, 28 Mar 2024 13:42:15 -0700
Message-ID: <CAFhGd8pU-utbgHhU5s_20pC_aNK7xtsJDbf+Ayg4Dck2K=4kag@mail.gmail.com>
Subject: Re: [PATCH] vmcore: replace strncpy with strtomem
To: Baoquan He <bhe@redhat.com>
Cc: Vivek Goyal <vgoyal@redhat.com>, Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 27, 2024 at 6:48=E2=80=AFPM Baoquan He <bhe@redhat.com> wrote:
> > Mark these buffers as __nonstring and use strtomem_pad.
>
> Thanks.
>
> I didn't build, wondering if '__nonstring' has to be set so that
> strtomem_pad() can be used.

I do not believe marking buffers as __nonstring is strictly a
requirement. However, the documentation from string.h +302 says we
should do it:
/**
 * strtomem_pad - Copy NUL-terminated string to non-NUL-terminated buffer
 *
 * @dest: Pointer of destination character array (marked as __nonstring)
..

and so does [1] ... "mark the destination buffer variable (or
structure member) with the __nonstring attribute..."

FWIW, this builds just fine without the __nonstring attribute but we
should use it :)

>
> Thanks
> Baoquan
>

[1] https://github.com/KSPP/linux/issues/90

Thanks
Justin

