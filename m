Return-Path: <linux-kernel+bounces-154215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 537578AD962
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:53:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 816891C212AC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1AD4655D;
	Mon, 22 Apr 2024 23:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iOiRWt24"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C231482FA
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 23:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713829974; cv=none; b=UIO+d8QaEX1H48M437ieOMuFiwjQQQulxoendCDTd7q8dX1zSNyInOxdWE7pHkrVN4d1afKj8lbVb9xqDcxGzFcdqHf9wevY7yoCpwlN7fAJYyECw5nJuhIqF87hj9bdzUe3KizBiqWtTquq/IDAd6Uu/HVlnK09oiO112HXtjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713829974; c=relaxed/simple;
	bh=dWdbtCbfXi5cjSaR1YgTS9QqEUHLJwTuwZvEoJKJ8aw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PyKTvC5S/jjrLsXjCBdfPU+a3fOP78Vvj5bLZsaKVK67L95YCTNiNMCI0js9MgRAHuiFFMkU1y0sXh9JD9aTpFuWJr45xiEClRbMYkM/jzdSeFaZ+0VmClhIgTEhX6Xrisu1ET7VRm4giOyBIKcAUO+5BFv+aWWIqed3qDuZW4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iOiRWt24; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4365c1451d4so29727491cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713829972; x=1714434772; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYcNw3oZL/qpooX0WCyBWjpCBFiURVUxekbnrDIkk5Q=;
        b=iOiRWt24AEvXGiBppqYB1x+GoZlx2jTP+39TVgGt63tORE7z0WunQh/JTOxEWu0luW
         OBrJXfr80niMUIbtjcMTFJwzdJfB16Fq/FEcOD0v6+hhVCt0m8ZvOf2JVzgNQWMqshw0
         3hZQ2DLcV4gIgD9l+H2z3unOXzLsu0toJ5eFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713829972; x=1714434772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vYcNw3oZL/qpooX0WCyBWjpCBFiURVUxekbnrDIkk5Q=;
        b=WOCdjju3eZQ2fFg33RftzLPvi+tifdGIjW3lUQ17hsulWZPCPCyGlZaQMmTwxo8wld
         QAMlCidO6RLP+AAURodGY31cRuf+WKtRDMbRGDoNS91OiUxCp2wtcxqm8LNtFA7JTBDc
         wTpaP8cSx84logzHnytT20e/7+oQmQ6IaUkN1bt5sENe1kIUw2mlL9FM/dA5ITJTQYwm
         TQcZBGzDXc89JMTRgCirq5XRwjQMns5Ga+0T3oUqL7TRhfqen3qSyfAL3dsqs4ctvFl7
         vvpzxdt3VniWwRUQIDspFYeRNX14XcnC4vLSnhjN8weUVhhfRpvS5+42zAqjBryvW24T
         DxZQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6ZLICbC6utHc6InXGgeLYvBWcFy0dIcVFKI5BsXmBBoETQrZr4RYKYfuiDt59Y/+J7UaDcEce29CiGERQ9cg+ARp4ftVcgCfytZjI
X-Gm-Message-State: AOJu0Yy6xcpx16SQ+YfT2XiJDWTkdO6VIjMth3ib8xL4iThVyh6ilpJg
	RPNU+drj4yNhfH8YNn9OBG3lPg80GjM3XQeZeeTAZ6Tlqu7Jht7D8Sl5xTRgtCGKXFVeZb5iXkt
	PNnGT
X-Google-Smtp-Source: AGHT+IHa5rNMGT5tbPUp6NsaiqKiCvYcwID9cSDLCW/Z6RuvwQ3E2XLR4FKU4wGpNl8NunEB1t3Vkg==
X-Received: by 2002:a05:622a:651:b0:437:b6a1:de30 with SMTP id a17-20020a05622a065100b00437b6a1de30mr11935753qtb.12.1713829971947;
        Mon, 22 Apr 2024 16:52:51 -0700 (PDT)
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com. [209.85.160.175])
        by smtp.gmail.com with ESMTPSA id kf22-20020a05622a2a9600b00434a041d310sm4689071qtb.16.2024.04.22.16.52.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 16:52:51 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-439b1c72676so101291cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 16:52:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUEpOG/hMGwd5eENqkNraaQZ0WcMYeVh+KdEBLIBwmiAzeUSFHCX1a9Ak1J528fnZSkWas+Je10Azof1r4eJ2uDGpAeqs/qDtSUzQuY
X-Received: by 2002:ac8:65c5:0:b0:437:ca6d:12bd with SMTP id
 t5-20020ac865c5000000b00437ca6d12bdmr64078qto.13.1713829970853; Mon, 22 Apr
 2024 16:52:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422-kgdb_read_refactor-v2-0-ed51f7d145fe@linaro.org> <20240422-kgdb_read_refactor-v2-6-ed51f7d145fe@linaro.org>
In-Reply-To: <20240422-kgdb_read_refactor-v2-6-ed51f7d145fe@linaro.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 22 Apr 2024 16:52:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WpHKRGdtnRpq+Bxj0CYX3wUvYV0OmRe0V=zMwVn1AHTQ@mail.gmail.com>
Message-ID: <CAD=FV=WpHKRGdtnRpq+Bxj0CYX3wUvYV0OmRe0V=zMwVn1AHTQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] kdb: Replace double memcpy() with memmove() in kdb_read()
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jason Wessel <jason.wessel@windriver.com>, kgdb-bugreport@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 22, 2024 at 9:38=E2=80=AFAM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> At several points in kdb_read() there are variants of the following
> code pattern (with offsets slightly altered):
>
>     memcpy(tmpbuffer, cp, lastchar - cp);
>     memcpy(cp-1, tmpbuffer, lastchar - cp);
>     *(--lastchar) =3D '\0';
>
> There is no need to use tmpbuffer here, since we can use memmove() instea=
d
> so refactor in the obvious way. Additionally the strings that are being
> copied are already properly terminated so let's also change the code so
> that the library calls also move the terminator.
>
> Changing how the terminators are managed has no functional effect for now
> but might allow us to retire lastchar at a later point. lastchar, althoug=
h
> stored as a pointer, is functionally equivalent to caching strlen(buffer)=
.
>
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  kernel/debug/kdb/kdb_io.c | 19 +++++++------------
>  1 file changed, 7 insertions(+), 12 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

