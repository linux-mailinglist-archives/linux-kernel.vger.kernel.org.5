Return-Path: <linux-kernel+bounces-154000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA3F8AD5FB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51DD21C20C9A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EF51BC2A;
	Mon, 22 Apr 2024 20:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CF7UODGd"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24AD1B949
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 20:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713818410; cv=none; b=sarHfk4yLLSVFoCtHdwGlalWVKyyw7Wt1s7bElp/2STT4inX94xpuGPKHuN7ZCVAD3aOHgV1mka6RkelWptCHrJbiGO/O7IoRAAoPdKhuJTcQ0Nm7C1dNZVtlPbjhJuMS+3Qrm8+7GGJJgJHdPWuZcwgQCmAzVGk9TU9f0twQC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713818410; c=relaxed/simple;
	bh=s9Rtmcw81GSG9zCbjUh61wEXkhKo/qPRbnRkT6JvNhg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGHXLuUWZmVp9rdu3GPQ0xDyUBq54Q4TXaWGQj+fIT0VAFXqzCcAIH+Wqush/vFsZnYYNQO+UWRDFKhC09/ELOBEV2N9xkXTBZ+PGsgYwMagLMnwJZFQdYFfn1H0MoDLdHSgswEyjSEVMEWw6JYyKFwBnicIlcybt+xcKkKPvx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CF7UODGd; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-344047ac7e4so3458822f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 13:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713818407; x=1714423207; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9Rtmcw81GSG9zCbjUh61wEXkhKo/qPRbnRkT6JvNhg=;
        b=CF7UODGdJq4G8nS+2bbjoW8HN6gtIRyIF17nwbgAhfri55vggwO2ykyTDUYDNu6bYc
         KbShJRwfgPxXqF4/lZjWYDvpUr5N38IJ5GWW7toYQVb+oCDqmLsdLHFhea+fZO6vo2mF
         LG0U6eLLJRu8bZlgcuahu2AJ7K0PQPUeRE9IWjByPEF/1MgyCtOrWquC4ESl++4bIrXb
         ORNoXP53dqi2Q5TIhvLaEKsvboyBNv+tLg1LzdyUO2OhxKVCYIz5TfO1en/dhupdBgki
         IjRSH0pvNiU+WRWyD1dndxIfMNZP25+x0Mn5PZf2H5oSJtz7QL5EvFAiyB06+aXHVDQn
         Vm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713818407; x=1714423207;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9Rtmcw81GSG9zCbjUh61wEXkhKo/qPRbnRkT6JvNhg=;
        b=G2qku8zN0KvjoQ1zFy8TtGWdVjC2OWJrpRJZL8+ZfKBYFtj5ejsFvK5wwLw8NBSKDr
         IwJs4YUwXwsRLBFP98fZAcDCpkrLaTMKMHzd/dykVkkFpzt2DX6dfOj20DU7y8/N4b/f
         av1hsZa6oR3G/AB/xFxSBUSlhzrmjLscU5/ytiwoVpgdk+Rl+9X9yroYQH75zauCTHxj
         n2nzp8ZqAhEfFubfXgbcXAas+wWeLOTY+mY27smIJK1yEsqCjsrDR5ueLXn6PymkWFLD
         tt8tCWYleo5v3T8xjpcyPIPVFCuSDfwN70+vMS59tuTucRxbeSovDcT8D5NrSmfhk+7K
         S5YA==
X-Forwarded-Encrypted: i=1; AJvYcCUUYsVIIsG39P0X27gBgZ3aiIKNEI2yJQm8rRzLoFM2FjjNZGDgPGfFAFBLGLERjpHWOWuVC4S63hZnuNX4xug5aCUYeke5jNwBzi46
X-Gm-Message-State: AOJu0YwYxUrwarUhUYNc9XjqV46E2f81sALpdLjctwNwsAN20sBEEIYa
	3d52vMdNertLrMOKjMSk7xuGrOQfjXBH9EIHO3TXYE4+/c1sKxSIN/UdDacOn8RPDLRau8Xx8oK
	Ti/v9SGIZRQ4DJ80aq4vl25+INLnYoW3Bm69K02BrXybSLRnNWJBN
X-Google-Smtp-Source: AGHT+IF7rFm9mITo1Vmn1L9OtqNa4/FBUTwSXrEKXV+NRexmqy2sVD4twe62Ho8ckMl9s4IIedPmaRUcauWYnCOdQWM=
X-Received: by 2002:a5d:5985:0:b0:34a:4b4b:7f4b with SMTP id
 n5-20020a5d5985000000b0034a4b4b7f4bmr573264wri.19.1713818407006; Mon, 22 Apr
 2024 13:40:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326073750.726636-1-surenb@google.com> <95819052.15033.1713816660761.JavaMail.zimbra@nod.at>
 <CAJuCfpHnM6L-7s8cd90XKiawhw9LZaRfMfeDm54OshLQdV5YmA@mail.gmail.com> <1375034928.15114.1713817899712.JavaMail.zimbra@nod.at>
In-Reply-To: <1375034928.15114.1713817899712.JavaMail.zimbra@nod.at>
From: Suren Baghdasaryan <surenb@google.com>
Date: Mon, 22 Apr 2024 13:39:52 -0700
Message-ID: <CAJuCfpFsrQxa2CX66xQtxp=Y-=R5_YkJMMX9VQ-g32rdCrukeg@mail.gmail.com>
Subject: Re: [PATCH 1/1] arch/um: fix forward declaration for vmalloc
To: Richard Weinberger <richard@nod.at>
Cc: Andrew Morton <akpm@linux-foundation.org>, Stephen Rothwell <sfr@canb.auug.org.au>, 
	kent overstreet <kent.overstreet@linux.dev>, SeongJae Park <sj@kernel.org>, 
	anton ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-mm <linux-mm@kvack.org>, linux-um <linux-um@lists.infradead.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 1:31=E2=80=AFPM Richard Weinberger <richard@nod.at>=
 wrote:
>
> ----- Urspr=C3=BCngliche Mail -----
> > Von: "Suren Baghdasaryan" <surenb@google.com>
> >> > Fixes: 576477564ede ("mm: vmalloc: enable memory allocation profilin=
g")
> >>
> >> This commit id is not in Linus tree.
> >> Do I miss something?
> >
> > It's in mm-unstable under dc26c7e79daf2fc11169b23c150862f0e878ee5a. I
> > think it just didn't reach Linus' tree yet.
>
> Hmm, so we better postpone this path until said commit hits Linus tree,
> or you carry it together with the commit in mm-unstable.

Oh, sorry, I didn't realize you were talking about the `Fixes:
576477564ede` part... Yeah, unfortunately SHAs in mm-unstable are
unstable, so the change being fixed is under
edf0a25633bda1e5b7844478dd13b4326a3d5d09 now. I think Andrew placed
this fix right after the change it fixes with intention to merge them
together later on.

>
> Thanks,
> //richard

