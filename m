Return-Path: <linux-kernel+bounces-145209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497488A50D5
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0599328CE64
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C32D85286;
	Mon, 15 Apr 2024 12:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="hTkoK1AK"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC7E76045
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185890; cv=none; b=DW9cN5bKkFpS2JapwOCp348xTGzJMaYbRm0iqEObx3OwlZu6O1bWjEs/kgZar18k9iZLRwtOCrUOLyWQZOHAUKPHHNA86aFqlGsiA66Ex4p4bsweHr6KckpqZCryT5KJtDDdS66YCLpKZyLk6R7K6sl5VMGX9ubElQWR3777LVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185890; c=relaxed/simple;
	bh=PtRDKTQTDzhoQ+/JuLQ9JmFXYTTE6omhjNyTnWio4Ng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jm2GMy61lgRRlC0AMkCyY18qLKhb/MFxSyWh3jAevG83khf8SytjY94XyOdtrS52mpAjUrzRtTF61L33yI+WGRVNjKLppX/Famexl21E2dpmoHb0GGBP5FvoaPMMkMq7kyVcCRDmHa2sMhHttM/8zDG2p6eZfAzfiT0f5PVsH7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=hTkoK1AK; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-518a3e0d2ecso3277011e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 05:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1713185887; x=1713790687; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PtRDKTQTDzhoQ+/JuLQ9JmFXYTTE6omhjNyTnWio4Ng=;
        b=hTkoK1AKs8h/tfzw25yar9T/oUhRWWMZYagLeKSpRvP2wC4DmwzN19cZCdAC1OMQ3y
         SU9XUoCsyxkAbikK+hTmmwvk3rmnxhnfyNKpOMP0WJJNdfb8rdEwhfhtiwAS9MwyLe4Q
         2fOAE1rJ0lqGAG4mBgjIrsHwwpOoJEqeVBfe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713185887; x=1713790687;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PtRDKTQTDzhoQ+/JuLQ9JmFXYTTE6omhjNyTnWio4Ng=;
        b=P6r30FP/Ysh05g9ZF2mdGS9d4JJxaRJO8h+3HBDbwH9AOV4rgRYi7ayzSiMTiSKwuv
         Dks0BBTOfxItWVMjSk+CfZuWJz45klGmutPoL1WCh5paOlcemkJG/GSBU5xy5lOca6OY
         9ZNQoGF3Kaaov7TN1/RsqpkuGVJz5cltGTNyw6MJcmlKupqpUXdrIiV9Lmo+9dTnfhOP
         oiDQwSfgAcIKeXgDu1gvsg9FYiryR3UUAX7eygoFwxN9zRzO8jVVlvTHCWtZdvnUxSTf
         s2hY+pi5PiXrGWYGzlLHDWRK9cwf8Gx+mS01l20nKWAbpFecODsSViMTPy0N0rSV4+3t
         drrA==
X-Forwarded-Encrypted: i=1; AJvYcCX7NBKYOxopvtSQ1olTFc+IID52JQpaFt+3dQ2KrqUDEc5vJqIMsImoec+yRu/7LQ4Zpd1kHEnMP6d1IV82vbe3/hbvIWxOpCqz4eDi
X-Gm-Message-State: AOJu0YwiyacCTMo5xCtGaAVrkcUTW40RyhRlRVxDtgF0tgzpRbohgGeO
	h/8L7qGrOFD6v5VYIcZy07Xm1TeqC/Wc7bVYSgMcD6zvyeE36P0jRL2I75udEg6hLjlYpiR9cLH
	7JHUWGTST75lJkKII9EjTORfMYqb369g6aZR03/AJhwok8bBh
X-Google-Smtp-Source: AGHT+IHOnuRHFKR2HVCzMc8TC81Qg4Ae2NPHkxHjQfyNtYIEy4o0Y2sPyHQsY5jkjxH1hi2Cm7TUt4zaFYsDNFeRRJc=
X-Received: by 2002:a19:9112:0:b0:516:9f03:6a92 with SMTP id
 t18-20020a199112000000b005169f036a92mr6833604lfd.43.1713185886774; Mon, 15
 Apr 2024 05:58:06 -0700 (PDT)
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
In-Reply-To: <b74a9a3edc52d96a7a34d6ba327fdb2a5a79a80d.camel@linux.ibm.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 15 Apr 2024 14:57:55 +0200
Message-ID: <CAJfpegvPwpS5_S4qrrVbeC1RovP8jeNuDCYLbdcZ_XDFgfgftQ@mail.gmail.com>
Subject: Re: [RFC 2/2] ima: Fix detection of read/write violations on stacked filesystems
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: Stefan Berger <stefanb@linux.ibm.com>, Amir Goldstein <amir73il@gmail.com>, 
	linux-integrity@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, roberto.sassu@huawei.com, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 15 Apr 2024 at 12:47, Mimi Zohar <zohar@linux.ibm.com> wrote:
> It's queued in
> https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/ next-
> integrity branch and should be linux-next.

Is there a document about ima/evm vs. overlayfs?

What exactly is it trying to achieve and how?

Thanks,
Miklos

