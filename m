Return-Path: <linux-kernel+bounces-24113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F76082B743
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 23:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6801B1C23DDC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 22:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981B958212;
	Thu, 11 Jan 2024 22:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VgPOZI+4"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BB85475D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 22:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5574feb7958so6836604a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 14:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705013283; x=1705618083; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IVTa2Qk/zKb+/z6OaDyalzLK5VKuTWu2RGMKTC1CM0g=;
        b=VgPOZI+4f8i8Q09HOizwVMdrFwhgA5I0R7KP6rN9xZw8XQrr5ie2l3w4E7A+etrnMv
         lrUVNuYHG5Y4NZkHhAdGB/xMrsyrcqN9n0ZzOPQLVH/T6VosPVwyo/ZaFlvvHpFtQ/AY
         f0uqKaBAUTik9B/1q6i3Nbadl2AF3ZkOi9q78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705013283; x=1705618083;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IVTa2Qk/zKb+/z6OaDyalzLK5VKuTWu2RGMKTC1CM0g=;
        b=BixIHOlZHY4CYKlmdiBrXTadY9Tee0tPQ328EnGKYRSuHMLS2CRU5KZ1Pib87w9w27
         y0DQQv7fRMCCH9ifZTmALJ48LCqTdXxQ0+18mv2/+qjfyu9/XeaWN6HrNGiai9k0odSZ
         aIeMDi0FiymI61SpwPaIgpwXuANMNaMq7X/Fb1JEEWYMHm3VYtpXSauxGncMPDThygfD
         1tYAO8rJtxF86YEj7tVyoXh7u30QOvlU4nIpkB+t+38RQm6Ii3J4q8fl5K/Kt3gwXBOu
         fUgiQONMV4JbKxNq6TYDlfdH8ffKh0HpqJS5Bjb1gF5VV8wy+/BR2iKdr9qUDASjXQPP
         JJnA==
X-Gm-Message-State: AOJu0YzxChf6SEIjaWYuoFktNBok1tbvHYriC4Mo/mqmRmYuFOJY94Iy
	TZNRE5T8pVYYZmjnMEAdY7ScESSqxHDzdSrgcsND54KMh4fG6nRr
X-Google-Smtp-Source: AGHT+IFomqBgo8YsM2Em6BBHlGM3IWKTaYkB7XvvAPv+lwVb2p0YiIpbAEJNBx7KSGKgErJAWNBkMw==
X-Received: by 2002:a17:906:6d52:b0:a28:be7f:3ef4 with SMTP id a18-20020a1709066d5200b00a28be7f3ef4mr172727ejt.24.1705013282999;
        Thu, 11 Jan 2024 14:48:02 -0800 (PST)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id vs7-20020a170907a58700b00a2caa85c56csm179611ejc.38.2024.01.11.14.48.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 14:48:02 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a29a4f610b1so644188166b.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 14:48:02 -0800 (PST)
X-Received: by 2002:a17:906:7212:b0:a28:b659:cc89 with SMTP id
 m18-20020a170906721200b00a28b659cc89mr182790ejk.115.1705013281951; Thu, 11
 Jan 2024 14:48:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <c5ac3166f35bac3a618b126dabadaddc11c8512d.camel@HansenPartnership.com>
 <CAHk-=whKVgb27o3+jhSRzuZdpjWJiAvxeO8faMjHpb-asONE1g@mail.gmail.com>
In-Reply-To: <CAHk-=whKVgb27o3+jhSRzuZdpjWJiAvxeO8faMjHpb-asONE1g@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 Jan 2024 14:47:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiHCkxrMCOL+rSGuPxUoX0_GSMLjgs9v5NJg6okxc1NLw@mail.gmail.com>
Message-ID: <CAHk-=wiHCkxrMCOL+rSGuPxUoX0_GSMLjgs9v5NJg6okxc1NLw@mail.gmail.com>
Subject: Re: [GIT PULL] first round of SCSI updates for the 6.7+ merge window
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-scsi <linux-scsi@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jan 2024 at 14:36, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Stop making a bad pgp experience even worse - for no reason and
> absolutely zero upside.

Side note: even getting gpg to show the subkeys was just an exercise
in frustration.

For example, I'd expect that when you do

   gpg --list-key E76040DB76CA3D176708F9AAE742C94CEE98AC85

it would show the details of that key. No, it does not. It doesn't
even *mention* that key.

Because this is gpg, and the project motto was probably "pgp was
designed to be hard to use, and by golly, we'll take that to 11".

And no, adding "-vv" to get more verbose output doesn't help. That
just makes gpg show more *other* keys.

Now, obviously, in order to actually show the key I *asked* gpg to
list, I also have to use the "--with-subkey-fingerprint". OBVIOUSLY.

I can hear everybody go all Homer on me and say "Well, duh, dummy".

So yes, I realize that my frustration with pgp is because I'm just too
stupid to understand how wonderful the UX really is, but my point is
that you're really making it worse by using pointless features that
actively makes it all so much less usable than it already is.

Subkeys and expiration date make a bad experience worse.

Yes, I blame myself for thinking pgp was a good model for tag signing.
What can I say? I didn't expect people to actively try to use every
bad feature.

                Linus

