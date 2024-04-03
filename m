Return-Path: <linux-kernel+bounces-130389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7093F89776F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2643C1F326C3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50CFA15622D;
	Wed,  3 Apr 2024 17:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OGC9k7vD"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2105C1DFD6
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 17:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712166426; cv=none; b=jWfDzlawL/oLTWLLAr8cM5pfCvnJgFB8+xJ/JjwHk6rkAw3Zb+T2tqDNlq5xejxT8YcxMsoD/wxKR9qnqacDpaZ/fsok85WZVEFcNZjw9XUgWI45kHFClBlAFyVlA9JkLfg8xb9tgH1Gts9JuvAONioIoPRcrBRsMiCf09UC9q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712166426; c=relaxed/simple;
	bh=2JeOLqt6iFkrlIcYwbpDrQbQoAoYiMHND8+3QmCr6qo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CyJRRj6gESwwrGzw72bfMIcU8i+Y1gjTJrwSKQSAFk/hoDJQ874JNhA7+lxNlFefUv0aIjv9KNELkpY2ZGozIFdG2wQCHhVwf09BHLgcedozcAP1GJml67GqEl0YKVb7VNpp/S6HueAOmAvQC8ZuJnBvhb/wynHSWm1leb2YkV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OGC9k7vD; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a517a492055so21205766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 10:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712166423; x=1712771223; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JqrURadVh6bfrB2uLbLqnbQWG9RW9Mp6NnYEctBPd/0=;
        b=OGC9k7vD778aAa5ZsyGKYQntGnNcYoEoBo0bLXUPQh+y8Q24/HMc+w/8cVM46cO3cp
         ugV0wo+hwY99pD2rNxKVxO6+bcs3uRDkgzAr/4Rv2VFZ8ZLaviYJNaAYgmgSPJwIHHbq
         R2oeNe1n01wScP3PJp1fxu/ALO09Z4tZDg0+ESDcpP9TcQHxEY/21lBiuPTi8vZVoR1U
         9JLDo4ZKLEBhAy7oWG9vxkFnlVRSa6nEBQ8eZFC7DFdjQFcvyZ2jJvdtxCt0QyfkzUhc
         rb0tTcLeUi8xHnUGE8vRogTTwYBTe5yRV6NfFj0IqqpI6F646Kb0ov8zcvsz4+prUnKd
         64WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712166423; x=1712771223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JqrURadVh6bfrB2uLbLqnbQWG9RW9Mp6NnYEctBPd/0=;
        b=l8guc1bKZ7mrtakRRAR+vPx0NXr6P2aYoupK8LziBeXTsHRfr6bYsxXgfkqwps/tIM
         LfF4lGlhlGfm/F5QyMgsi7lZ9ICDTfiOhwpjcmVx8ac2imjUpNzeReTmelSJSTSilfyN
         +egyro0dTU+/lkWFLM+kzfax9ULyOTgz5lmUQjJSGA0cJXhzlyn/Xt+ronxLezten5+v
         cGWBK5Fx0lVFnpH18LmCcbRqQRza+CTyV8P0XIcCSl526Fiq0TxeipTpLhaC9IF9NNTx
         oNScBmTl28p9fmxzgLt+hSqgd8cZ/NfT0RY0USJfd7228M6xSnBBKU0CofA7z5gpYj/M
         kxIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcpf1LfAaH9HFA2KHYtcJclrtn8IyYbGZf8lJu9hFM+RIDQCjl9eGaSAUVvV1AaxMN4jsFbiPM90M8kr7/7ioW6uW0yLlGNgqYBSx5
X-Gm-Message-State: AOJu0Yxs3+oo2chsKK3JJc7khXVALQEKsQZiO2E6hl8BWZHJeYBvSjed
	RGmxbPLbzZEPW0mHNobxOIHj9UK8tPYOO1rkcyR7rWZmPloQ0VtowKuSpSkgLr+2ocWRwBcPsC7
	iYPAQxpcd3km16kn2QiyStwyx2HZvWLhm57lCOt6ggaWrXJyHDxUK
X-Google-Smtp-Source: AGHT+IGSZh3cGZaqkR61KLJvDstkfMIgQgaXFfkZwJhOF9eaxuv59oIjbf/wbWZywUuB5lPZKadWGDHsD804an1EBCw=
X-Received: by 2002:a17:906:aadb:b0:a4d:ffcb:1f4e with SMTP id
 kt27-20020a170906aadb00b00a4dffcb1f4emr11402ejb.75.1712166423477; Wed, 03 Apr
 2024 10:47:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403-strncpy-kernel-debug-kdb-kdb_io-c-v1-1-7f78a08e9ff4@google.com>
 <20240403112336.GD25200@aspen.lan>
In-Reply-To: <20240403112336.GD25200@aspen.lan>
From: Justin Stitt <justinstitt@google.com>
Date: Wed, 3 Apr 2024 10:46:50 -0700
Message-ID: <CAFhGd8rjDRTY8JjWx_zt8xBHGcJYzp5VpFf_sN+s-kRcr1JKBw@mail.gmail.com>
Subject: Re: [PATCH] kdb: replace deprecated strncpy
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jason Wessel <jason.wessel@windriver.com>, Douglas Anderson <dianders@chromium.org>, 
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 4:23=E2=80=AFAM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
> > -                     strncpy(cp, p_tmp+len, len_tmp-len + 1);
> > +                     memcpy(cp, p_tmp+len, len_tmp-len + 1);
>
> Roughly the same question here. The original coded is obviously wrong
> so trusting it did the boundary checks properly seems unwise.
>
> Are you sure it is OK to make this copy with checking against bufend?
>

I am going to revisit this and find a better solution. Thanks Daniel.

>
> Daniel.

