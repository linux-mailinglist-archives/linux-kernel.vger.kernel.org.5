Return-Path: <linux-kernel+bounces-157564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FC2C8B12EB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:54:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DB6D1C21EC2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAC81BF40;
	Wed, 24 Apr 2024 18:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D5earJn4"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D92B18E01
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 18:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713984837; cv=none; b=uvLgZMcvYSW1Tn7ZG00rI0sEKeNncbh6UgYO7WHmhEBGHITTlS05zfGHAFibLavV/8dqhGWRxGNX7lEsRd4JYgjNyMkQzFsaEuf3k+0hyAvg9zO0kLgB9cQGuWn2WEm68GrMTSysw4FWg6mt+EeYC/wT1v4BbGCugf/nxZraAfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713984837; c=relaxed/simple;
	bh=L6t8/1Otid03POwko1fB2t8xd2r0RXQVTBsaux3bVhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M5h8xw1oXqSdyjSooMeVLht02OkkrW2Bz0qokHOteLx3gCqcVi1f013awCr7/OaAqpMmsWqStMjzkSf2cjXH2WKnmvX0S2qT2yySrYrHBmHX5nAO3yNMY9wQPOxCkzxQXITPq4A3FsL4IFTi0/ijAmwYV3FH0bu0nhXIdeD6Yik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=D5earJn4; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2da01cb187cso2840311fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 11:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1713984833; x=1714589633; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AMR/e3F+Pk4bn/6/mhO/XEfDpxEpt87AN3boxF73T/M=;
        b=D5earJn4qMZSKQre1nzcqFmrosPLq1SnRAxkLa5HIADw/3gXoGHiE9HDIaRIIMpHLY
         LJnNwS/YBfMIce8mduRbjTOl6HuphMSBR8SZXUtIscWaGLLYfpIiXv+RCyEnmnHdexuP
         ap2ARIhS7Vo23MwneP+GL9IBxo3Uycx2pbZUg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713984833; x=1714589633;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AMR/e3F+Pk4bn/6/mhO/XEfDpxEpt87AN3boxF73T/M=;
        b=KYwMaoQA2VGfLkVgy0M+MyBD4+AIAum8u3NZtgs8xfKAKpgQP+ZZyGSuW1YmA0ht9m
         gKTvnqnTy72Ok+AGcqcJNC45X3c6kZBN1Y1X5clOIYCh2F3vYuaanoPtsDbS+uj4O2L8
         POZClJqoDo6Qe+PtrYMsuExVGecQAFjDzSbZJTZkNccW6PunBGRhpOJTtG4e4Ng1hTfe
         kgNgWiIEOAkoFUL6iHdgofDaREaENf/e3bMF7iv64IMhV8BAMAWCntYwy19LWqlX9qHg
         PI6fxrUI4c1BWazhwHeNMsgaZww1oB+UM6BpFERE8pXMdI0iVXdus8dxbh/hPe8TGIRZ
         KzwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUdBso/qPKCVguDvTif0rAWuyVOfivSZ8bRDJT3pxS07GzMfmFxooxaAoj2ujh2vjvqR9DlOdUYjCh4BJvIKtSEmPcI7tE9dhCOCSMg
X-Gm-Message-State: AOJu0YwWWOzmURPuzF8ZsmrTl9O6UUmh245uuNUGF558pdY7O06cRd4N
	anylnemOD1Th8kQs9RQ7yu8jwWsT/hx+dI1Q0nH48kjzSIlWxOrlePevwLPEJkgoGoSnbxbvh9Q
	EZMZjBA==
X-Google-Smtp-Source: AGHT+IEPKtxCV2pNro5xis+FxnVWRGlh4dhz+/0ErgvCZK0O4VbXKxJtxMRaKgpn579uaY3p8L6/1w==
X-Received: by 2002:a2e:7d11:0:b0:2d8:6a04:3bcd with SMTP id y17-20020a2e7d11000000b002d86a043bcdmr2654873ljc.3.1713984833556;
        Wed, 24 Apr 2024 11:53:53 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id q21-20020a2e9695000000b002da25e60918sm2130399lji.18.2024.04.24.11.53.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 11:53:52 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5176f217b7bso287168e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 11:53:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUE1UArMr7OFRg2yem3AI/KxYYlQQS0eeo+FmG9oaQwxIc3ihj6O6fCVHPJN3T4WAs/Zuisls5DMosUXJlgt8I2J/wKp45LKCuvpppV
X-Received: by 2002:ac2:5938:0:b0:51b:c43e:ea84 with SMTP id
 v24-20020ac25938000000b0051bc43eea84mr2412368lfi.55.1713984832182; Wed, 24
 Apr 2024 11:53:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240331182440.14477-1-kl@kl.wtf> <14d1b38e-0f11-4852-9c52-92b4bedb0a77@leemhuis.info>
 <CAO-hwJJtK2XRHK=HGaNUFb3mQhY5XbNGeCQwuAB0nmG2bjHX-Q@mail.gmail.com> <a810561a-14f3-412e-9903-acaba7a36160@leemhuis.info>
In-Reply-To: <a810561a-14f3-412e-9903-acaba7a36160@leemhuis.info>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 24 Apr 2024 11:53:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjy_ph9URuFt-pq+2AJ__p7gFDx=yzVSCsx16xAYvNw9g@mail.gmail.com>
Message-ID: <CAHk-=wjy_ph9URuFt-pq+2AJ__p7gFDx=yzVSCsx16xAYvNw9g@mail.gmail.com>
Subject: Re: regression fixes sitting in subsystem git trees for a week or
 longer (was: Re: [PATCH v2] HID: i2c-hid: Revert to await reset ACK before
 reading report descriptor)
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Jiri Kosina <jikos@kernel.org>, Douglas Anderson <dianders@chromium.org>, 
	Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kenny Levinsen <kl@kl.wtf>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, 
	Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Apr 2024 at 09:56, Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> out of interest: what's your stance on regression fixes sitting in
> subsystem git trees for a week or longer before being mainlined?

Annoying, but probably depends on circumstances. The fact that it took
a while to even be noticed presumably means it's not common or holding
anything up.

That said, th4e last HID pull I have is from March 14. If the issue is
just that there's nothing else happening, I think people should just
point me to the patch and say "can you apply this single fix?"

                         Linus

