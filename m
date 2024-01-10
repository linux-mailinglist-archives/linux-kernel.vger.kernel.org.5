Return-Path: <linux-kernel+bounces-21716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F62D82932F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 06:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30CE61F268EE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 05:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8373AD51D;
	Wed, 10 Jan 2024 05:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VualP6Tk"
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867B1DDAB
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 05:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-20400d5b54eso2546420fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 21:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1704863412; x=1705468212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hqYcNWY0+b4B+ZSOG0sn5MgB4C9W0WVUcXjDmWofD1Y=;
        b=VualP6TkUfHsIjmRB07FzILzkiQk8aUT4StQEsGMZPVngz6NTLiejhQpAcjItTlTMX
         gDycuVtkj3RPxxCrCYCdgkEPjQ2+wKvj7C8GOU2VucCbkjsBy5Wt4N7ALv9KgW7XCnTK
         moSDemU4A5teYf3TFFZnUoprQW7a4FjdL/vUw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704863412; x=1705468212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hqYcNWY0+b4B+ZSOG0sn5MgB4C9W0WVUcXjDmWofD1Y=;
        b=IUP5xjCdfhlXLjM4NKLrACjD2yMjgBrxukIMTI6R2SgnPZFMExQICuFhkdSKdhiHlq
         RP7w2JFHGQyU1q1NDKpG91swhoQwLq5DKhkK7xGTGuCsBXtwt8N9002/HvN9Q+dYhbxL
         h9WugA5YIGAuMvB2/5MQZBM3LoqHvK1RTEfnHMRhsSzuAs46qvcqwWzFBPDAhXri7yM2
         a5/aasG9DIhdJ3JIaFRxzveYzeQ/pR/FhJBYYRQMfgRQqgEVWfLa2JbvVeKFYOj/Pl04
         c1UdBsag7bPt608ai8oOjhAFXKtaSSXKXnEMMwMBZZQe3K9hfMtGva2PhXfg5W0+ZtxZ
         KAXg==
X-Gm-Message-State: AOJu0YyPOXsy7L9SLO906jnfb/9r1L+HVb7dHepIun42N2S8IMiRh46A
	sdxISpUO0MGYKEom5jUChLK6vzD1WTJVx3WIn25lVMwlPy8j
X-Google-Smtp-Source: AGHT+IGNsvR7puufHhdh8BMcPQbS0gnnOxM0dRuq29mQYdK8iwWzGA1wLv0fQE2MxP5JUCfTd+Ie7pgIvAzCeOBeYqE=
X-Received: by 2002:a05:6870:1b8e:b0:203:ea22:4d98 with SMTP id
 hm14-20020a0568701b8e00b00203ea224d98mr235952oab.87.1704863412576; Tue, 09
 Jan 2024 21:10:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109154547.1839886-1-jeffxu@chromium.org> <202401091144.2C203AA7@keescook>
In-Reply-To: <202401091144.2C203AA7@keescook>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 9 Jan 2024 21:10:01 -0800
Message-ID: <CABi2SkVGW5n0NJqa_1RHnXt=GEizm0ixvGiu+F_mStFwx7pjQw@mail.gmail.com>
Subject: Re: [RFC PATCH v5 0/4] Introduce mseal()
To: Kees Cook <keescook@chromium.org>
Cc: akpm@linux-foundation.org, jannh@google.com, sroettger@google.com, 
	willy@infradead.org, gregkh@linuxfoundation.org, 
	torvalds@linux-foundation.org, usama.anjum@collabora.com, jeffxu@google.com, 
	jorgelo@chromium.org, groeck@chromium.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, pedro.falcato@gmail.com, 
	dave.hansen@intel.com, linux-hardening@vger.kernel.org, deraadt@openbsd.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 11:47=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Tue, Jan 09, 2024 at 03:45:38PM +0000, jeffxu@chromium.org wrote:
> > This patchset proposes a new mseal() syscall for the Linux kernel.
>
> Thanks for continuing to work on this! Given Linus's general approval
> on the v4, I think this series can also drop the "RFC" part -- this code
> is looking to land. :)
>
OK.

> Since we're in the merge window right now, it'll likely be a couple
> weeks before akpm will consider putting this in -next. But given timing,
> this means it'll have a long time to bake in -next, which is good.
>
Thanks for the heads up.
-Jeff

> -Kees

>
> --
> Kees Cook

