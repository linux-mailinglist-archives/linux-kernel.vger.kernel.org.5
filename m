Return-Path: <linux-kernel+bounces-146461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9ADE8A65AF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0670A1C223D7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B079130482;
	Tue, 16 Apr 2024 08:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="lW+z02Fm"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BDC82C8E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713254769; cv=none; b=MQPEriefnaWC28MCMXZ91NBYmQV5DAXbgbIJjwV8UxYlZNR4n+jNypUxbl6jtDNGTw+qePrgCwcxjE0BvFdYZfcmNSOLE8iBBaCsjI4jyoJ7CLlMY6PpJNUx6GER7BAL8gBSWVQXcKOnQPOK7Aa8L0qTeIbaT1GdLcRTVrJZpn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713254769; c=relaxed/simple;
	bh=fg5enCRClFzMv6bdvt1Y6X9xAUZhUI7GAdZthN4hE2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ftcq9587qXI7aG78UKRg7w3PtBtv9C1atBUkDDd+lAQn/JhX0Ycs0EmS9C9vjMoN0gKCB+MKZFk9WkwPRa+Gn/sEUmgl7SrYSgIuelF+7PiFgI6X7flTTJpMP0qhIn3QylAOd1k0e6+2EFUxgObrPUO194fUAySFWZxgo1D761A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=lW+z02Fm; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a44f2d894b7so446841566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 01:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1713254765; x=1713859565; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FoqNTXSVJxVnoomAkAmOc0tpYIUt/Fr7OUpds6qVicI=;
        b=lW+z02FmKq2sZrwkzqdQlSM1VKdoHe5jjC9Gz/OwrTy6u4O/FMmR9coVMiyFXICn8Y
         amwCmXQ/ug01YvFqjKGk4bLfeSP6+Xuhua4GLocF3DCxrHEWiApPHn9hqUvGc5DbetzL
         5ZyvE49GLf6EsCAsbFuzohmUu2zf0VLHGnjX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713254765; x=1713859565;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FoqNTXSVJxVnoomAkAmOc0tpYIUt/Fr7OUpds6qVicI=;
        b=Ey0H4DgqjTwUtnpV3MxQecipdVCvXVzPBF0NXteoXDEgXOTRRxxCzGuXaVutwP5025
         DitDku92hpiJJtYHLd2LZyQOZ4iud1ctHYdMeL/lzR4kFRkq+bsKjN+mIWxNpxFDpC/z
         SARktmNue+LolR1eIVd+jOen6GWpd8OCO6ARb7PYcWB/nebF7u2+cMHRGczNXeixzOFw
         YYOr2MUscceN3YV4R6aq42eXeNzltzvgRMDlwmejh4txbys+vGHBYH5fkVnLmunbJHUJ
         zbu8IaRi5gcKbo8QWk6qcaOMU0O8YnxAEk6Peq9lBaBW8kkBegXyVm0SzMeD41Z/MHs8
         J71g==
X-Forwarded-Encrypted: i=1; AJvYcCX20YHuD/X8v7V4r+vwpCh5r8IHkgG6CYeY5M2s64k7z+PFqv7o08o7Ap58dmIAqGVv+9X+YSVVDw7S2dtuy+/ph1XPUTk1RpUi/aey
X-Gm-Message-State: AOJu0YzpLoZ7Ag4mYNmMHWtjZ82TQo/4a8jZH4d5o3V5oyG6geGnySxy
	ZGWfWIklHkdpywXOgKy9nYLv2PDnGhGR+ffv1Qz2PaJM+MAvp2On36NqHkVd3qtOY9wdsErGZzF
	NEKSFDuc68qGUiaWfCHa93zGE58/9lLT7EjVxZg==
X-Google-Smtp-Source: AGHT+IFUt+TdRo5/lwa0iU7eIPcfQR2RMazKfVpGy4W16qNguCkLvu3MteqG74P0Dv9xqS7zJrT0nlKrob2NRz5PBhk=
X-Received: by 2002:a17:907:6d18:b0:a51:e2a9:97c with SMTP id
 sa24-20020a1709076d1800b00a51e2a9097cmr12053296ejc.6.1713254765520; Tue, 16
 Apr 2024 01:06:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412140122.2607743-1-stefanb@linux.ibm.com>
 <20240412140122.2607743-3-stefanb@linux.ibm.com> <CAOQ4uxjDQO91cjA0sgyPStkwc_7+NxAOhyve94qUvXSM3ytk1g@mail.gmail.com>
 <89b4fb29-5906-4b21-8b5b-6b340701ffe4@linux.ibm.com> <CAJfpeguctirEYECoigcAsJwpGPCX2NyfMZ8H8GHGW-0UyKfjgg@mail.gmail.com>
 <b74a9a3edc52d96a7a34d6ba327fdb2a5a79a80d.camel@linux.ibm.com>
 <CAJfpegvPwpS5_S4qrrVbeC1RovP8jeNuDCYLbdcZ_XDFgfgftQ@mail.gmail.com> <52645fb25b424e10e68f0bde3b80906bbf8b9a37.camel@linux.ibm.com>
In-Reply-To: <52645fb25b424e10e68f0bde3b80906bbf8b9a37.camel@linux.ibm.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 16 Apr 2024 10:05:54 +0200
Message-ID: <CAJfpegsHJ1JsM3SxNk5gnUM+aucqOqNm3RTrsYgePkcQYR4EEw@mail.gmail.com>
Subject: Re: [RFC 2/2] ima: Fix detection of read/write violations on stacked filesystems
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Stefan Berger <stefanb@linux.ibm.com>, Amir Goldstein <amir73il@gmail.com>, 
	linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, roberto.sassu@huawei.com, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Apr 2024 at 20:35, Mimi Zohar <zohar@linux.ibm.com> wrote:

> Although "Changes to the underlying filesystems while part of a mounted overlay
> filesystem are not allowed.", from an integrity perspective these changes might
> affect overlay files.  So they need to be detected and possibly re-measured, re-
> appraised, and/or re-audited [1, 2].

How are changes of non-overlay files detected?

Thanks,
Miklos

