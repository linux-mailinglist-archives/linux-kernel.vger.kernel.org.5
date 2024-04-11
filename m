Return-Path: <linux-kernel+bounces-139583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B91CE8A04C1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 02:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EFCB1F2547B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1141113;
	Thu, 11 Apr 2024 00:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Klz/PE8L"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAA863B
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 00:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712794868; cv=none; b=uRnmqjpvzY3kaJ5/u8hBm0Tu4yuWBh7gPxD8Kps9DWrwqPK4LRq6P52bYPlOkREcID7IP4M3lVp+h+Q778bc+UZBTc2t6O663qPBi92lCEJ/O00g4zMiUPjKVCw4TQbRBVsG4CTAS9EzGkrFZcbT/kzKxOcJ/RZza84h7v/j5eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712794868; c=relaxed/simple;
	bh=dPs4r908+OxuV3XTEJi5fKHrHGqtIvKelez5+yi+JLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F1wvJ4r/wUYYV+Mt+OslmrGMHWCFFqueBqOd7wRy0P/OhA6ea4eq7q2EArqQQsLhsuFTy/K5AYzlAp4hynaT4iYNQTJdVSI6ne7BDJoBI1hvt8PIPUQePViflqHqVm5tY2tOBa1qNVe4odtHbtdLZoGP681QQ/OYEozpe/d8xtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Klz/PE8L; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a4702457ccbso930025566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 17:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712794864; x=1713399664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D53dlX+N0OwY316dEgjLrCd5tFTXcxUOaqixuP9aphk=;
        b=Klz/PE8LBY2qexUxcZqYSuatsxrUVp7pIoEcmtZ2nyUtzEHHgsWalkntpE21fXDank
         McqInEIgpL/rucV1H7pVNqkUCdP1Oq4irmtb5ddqmemqYqtKKxHsLXMFZ2HNs2STRGGY
         Cz1mrjn5ntdUQ5F5BMYgRzS/pxszmR2blGKyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712794864; x=1713399664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D53dlX+N0OwY316dEgjLrCd5tFTXcxUOaqixuP9aphk=;
        b=gCpYnqG2/s2thYuoe2q/3L4lmQKQ6MuOtY4vHhybZpKD/z499WS25T0IjQIPXWwXG5
         8UiT+dWzuo4nBrPaePQ0fRpoFMqIUM6o7FSQLcDhBCR9/E8SlFmNzpVk2wX5uCo0npOy
         9EEQJfSdY8aCyfalmoMKZbEPh7JoPwhTB/lyP0FBeou7g2UjEMRoJvmv6v5twvf9uO1p
         U5TuqrtynNOD0SrJJkwDmCwEJAtx4eNmOED56xcZnTp9m47BBvd8uFZo/NW6tvEU0CIL
         yFFvA/tUHFSbfNEHB2x7GMIaZLn7qPyBhBNruvBp2m4GjuTbD+jQd7BRX2Qt6Rp5PWSy
         /Txg==
X-Forwarded-Encrypted: i=1; AJvYcCXgrp+IS68geDaL0Fmcz55/cSmI91l85kVjDSWam8ACc4dHceibYk14YeqE2ihDL+tuA2JwddfrFAUINXJnI/25MROrEkzALdvS0PD5
X-Gm-Message-State: AOJu0YyseVqUG5tPTcEZi/aYAzx2vJ9TmfATQyifMLE9Kfezh1AYMX2R
	877FBXCMytAtNp3xM6hZ/kM+G1FCnsOYmWuGoLEtumeV8k9M/x3YFHpUMOEM6UmZY6uvCg+ivux
	jBNSW9w==
X-Google-Smtp-Source: AGHT+IH/MX+dzPl9vd52riyl8gm68UtNX2mKTBrxjrjkUCsIRRdepqyohEnbYEOGxiiCPw45FBMZmg==
X-Received: by 2002:a17:906:2b0f:b0:a52:16c4:ab02 with SMTP id a15-20020a1709062b0f00b00a5216c4ab02mr1158392ejg.50.1712794864149;
        Wed, 10 Apr 2024 17:21:04 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id ku21-20020a170907789500b00a517e505e3bsm193099ejc.204.2024.04.10.17.21.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 17:21:03 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56e346224bdso5426913a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 17:21:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWdwy2nWvyGWnLSLVK64qTGhbyvwsfIMNweVLRWhC9XH5PCErXNopfzZmoPC5mwl9kKEghwq+JrYIhBPPBcZGkZj17TZxxtiiqHdXsi
X-Received: by 2002:a17:906:cccf:b0:a47:2087:c26f with SMTP id
 ot15-20020a170906cccf00b00a472087c26fmr2601353ejb.73.1712794863170; Wed, 10
 Apr 2024 17:21:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411001012.12513-1-torvalds@linux-foundation.org>
In-Reply-To: <20240411001012.12513-1-torvalds@linux-foundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 10 Apr 2024 17:20:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wguGg0Eirx7gA81Gm1qdkviHbAaF_zJbF2qMqLBG8zkyw@mail.gmail.com>
Message-ID: <CAHk-=wguGg0Eirx7gA81Gm1qdkviHbAaF_zJbF2qMqLBG8zkyw@mail.gmail.com>
Subject: Re: [PATCH] vfs: relax linkat() AT_EMPTY_PATH - aka flink() - requirements
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Lutomirski <luto@kernel.org>, Peter Anvin <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 10 Apr 2024 at 17:10, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>    "The definition of insanity is doing the same thing over and over
>     again and expecting different results=E2=80=9D

Note that I'm sending this patch out not because I plan to commit it,
but to see if people can shoot holes in the concept.

There's a reason why people have tried to do this for decades.

There's also a reason why it has not worked out well.

             Linus

