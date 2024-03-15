Return-Path: <linux-kernel+bounces-104702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6438287D28F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:18:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 932C7B207DB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748A145C1C;
	Fri, 15 Mar 2024 17:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GExzbu7E"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47DD3B18C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 17:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710523090; cv=none; b=n7/e3gkjpMXQZviPFeVSglISiZswnfc/zi5JHKsRJHFmCCXfJgLWYiC5PAsuujjd3o9zNvBlB9Eb36vR+18i240MkFe2O5u8d7yDcabbazAY1UdZMroEvaboKyYGqPdkTX34nawXKDU3IIIi0WTyl4shqtVsPzPKJ6KA+g/Cwnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710523090; c=relaxed/simple;
	bh=3vWfh0H5SxVCroF08gpjZrm2nJHf5wITsVROD33t7GA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vjl6dkeQYt99AVkuCrhuIooul/ozoNV7K5gmparrnSOghdnmhyKWKXV6rO5bqOZzu+ARWNG3Cl/UNl3wzE8h+Pn/GluEgl0D7VqDyBYIQfBkgWtJTgHCdCFckViJ6Mf/khO1IkGYrOekcFHH2SjBDdrEZsVJqX2EkUu2staj2xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GExzbu7E; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d28387db09so31916451fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 10:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710523087; x=1711127887; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YXJYJHH6Vt4w4K0aX4imlYYQDBwG04/7jCU5kd/9Afg=;
        b=GExzbu7EwRpC64mkrdvYkjW+ya7a9MRFY7KoDfOjji56PIhXvOSg2k5RrcMLGCfreh
         Wp5friQcJFe+g4VnAtLXVFzOMriLIt2fx+IvyZ1afqDK78ouw81v9lMJFGTFBTXV7GcC
         0+DAS8qNDyVBMi4d4R6khuR6dxYYIvE6Pc8KI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710523087; x=1711127887;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YXJYJHH6Vt4w4K0aX4imlYYQDBwG04/7jCU5kd/9Afg=;
        b=w8sdhMloD3KkvIMhcVXODAOr0LtpGwfP4MedjMOTq2V0DkDvlJFZo4eyAsxBJyUdpB
         1SGE+8sMtGSeGkBVMMVZWi3VrLFY2XS+y4LfuIadUD1uYlKOX+no6uR6Dc/dM1OdK36j
         GlzPggzll18/Q8uYvlNZUNRlBmDtqBu+JhrBH7TstoQuCVKxCOGJnBiYh0YBmD4YBzer
         64qzjJI1nnHi5+Zt4zD+CXlHAoGd+UFd00avMjWGZmqzLI12bPcMMjw7qsGy+0lNacuf
         +WHQzYpK2kcWZhUYZJVouRXB1DWQ8/SoyV2mdIXpfyPSSLrle1siYqTS4bqUKum5YcL3
         FJWA==
X-Forwarded-Encrypted: i=1; AJvYcCXurXSptJh1/vpumPA2LHDKEXc+BnRdw+83kmHBalU2o8ZhWoONLV5CQBbaLC4Z0xHMxMgPdvPN/pPJAyPCTijz9C0RWZNshEu3/MpL
X-Gm-Message-State: AOJu0Yzb0qZ92AS+tIgMpRTMuBDlCJrjs5VRZjHGvCKjmSujkc9jMLqt
	R/ikupSUKMmkTKkahVH+ju3uHEEoz44UDGJN7F1T3ecTaVOGtOgRgijtd++f0b4EjqJ/uoZUm6H
	py3s=
X-Google-Smtp-Source: AGHT+IHrcpu38S7t6lAWg0QKrX7lKZkExOrofnaJHHcho3zvBULARSVQfPUGCUVzd0G7Fdxsrl+rsA==
X-Received: by 2002:a2e:a9a7:0:b0:2d4:1700:34a2 with SMTP id x39-20020a2ea9a7000000b002d4170034a2mr3425282ljq.33.1710523087085;
        Fri, 15 Mar 2024 10:18:07 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id a8-20020a05651c210800b002d471f9270asm562461ljq.0.2024.03.15.10.18.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 10:18:06 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-513dd2d2415so592021e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 10:18:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVAcCi7pcD/OThVIz83yBzzET57Pi9mOMjDOZ2k/rV8MXPQHA3DptC2tstDMOaCuuXTYkdRSRW61AjfPrkGZ0IjCGC5MTrKkY4nNbc+
X-Received: by 2002:a05:6512:61c:b0:513:cff9:46b0 with SMTP id
 b28-20020a056512061c00b00513cff946b0mr2642514lfe.16.1710523085726; Fri, 15
 Mar 2024 10:18:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZfRkyxUf8TIgsYjA@1149290c588b>
In-Reply-To: <ZfRkyxUf8TIgsYjA@1149290c588b>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 15 Mar 2024 10:17:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj+=Bb8XYAexzaKWuf_6k93Xqi1OxqPw+SPf6JGTGCqdg@mail.gmail.com>
Message-ID: <CAHk-=wj+=Bb8XYAexzaKWuf_6k93Xqi1OxqPw+SPf6JGTGCqdg@mail.gmail.com>
Subject: Re: [GIT PULL] fs/9p patches for 6.9 merge window
To: Eric Van Hensbergen <ericvh@kernel.org>
Cc: v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Mar 2024 at 08:10, Eric Van Hensbergen <ericvh@kernel.org> wrote:
>
> fs/9p changes for the 6.9 merge window

Entirely tangential, but your pgp key drives me insane, and it finally
drove me over the edge.

One of your uid's has your own name mis-spelled. This is not new.

Please tell me there's a reason for it.

          Linus

