Return-Path: <linux-kernel+bounces-126319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 727C589352E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133C41F21D56
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 17:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2C414534F;
	Sun, 31 Mar 2024 17:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="X9XckdoG"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBCF14534E
	for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 17:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711904492; cv=none; b=f5jzognbmfIwzz5l0HaRV1ND/JZ67YOIALRhw8oBZokCDF9Ei0LHo4xnYR9KiZ+DfPMYmDq7VpN9S/VHwHxBgPV0hSO42VAJlYcstiI1mtRcjC/P5BepkOiAVt19BF9Z/Jm7DNq3xN7d6tw8z8M0wdbKOGkTW1fCPxHVFg/YaxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711904492; c=relaxed/simple;
	bh=6uRCnk6Hmq5Dim0u91a9tFMVKCUDB8cTj8Vol5lOhkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EfDBfO9k8RKP4tVS3Fe3AXbsWMnKpxG2+awPp7oP0p5J3emDQOmLez52gcR4knylPaU1Ll+/9gggCH96JHsMBlCoKONu5iIJ9AVerHD0myH7HU73tKxRCa9wUge5U7gj8wQP39OifkDkHzbONsM55mGwPC5cqKFrHooENecZ1Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=X9XckdoG; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a468226e135so403282866b.0
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 10:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711904487; x=1712509287; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/YqF1343zKRwGc00uFMCul0bKtQh7G+6n9UiA2naOCg=;
        b=X9XckdoGZx/eAW1juL9m74q/3hbfb85c4azcgCAi8XUebGAvOMinqn4l7J2qUIWKLk
         oitwBtNTd/AYTwqIrbbA6kv8Fm69vquiYTdSGegZ6YxEXYTXFLY1uoBAy31zpcUBtFuD
         xcRMvIkxxYHt8m/uy9sjmQMZruMHjjzQRZ0Ug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711904487; x=1712509287;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/YqF1343zKRwGc00uFMCul0bKtQh7G+6n9UiA2naOCg=;
        b=EI+/M/0Lf49ZV/6pL9z7erq81JMkmkpY+46fy1v+D2H2ivbR4BcfsSvPrMQkaiI8d5
         diQI03O4r9kZz7GpVsZoUbhO4DZFJKgi25x2yODGKd7jMLNX17vb2fGu23Bw63ceR131
         DmrVFHklgfxMtM8l1/9mYwuCKyPxV+Fkh0Yd8XSZnmCXL4RPHgCsw3dkKtGO4GkEMAfM
         7+oZNKWW1l8i6qZJONV8aMHQEDBhmYF722HkXCr4uTEVfnUM4VqtkzYLEbow0zw98XsN
         2fEYmBtYT5wQHI89Vec0ed8YM+c1eb2wIkNZn3SKqm39WWkmTLREaRbSwCBKZPJemz0w
         zhIQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0BUdI9EFOy8GrgVBqd80n2BbHMm1kT827XuTxIndJoKgo6aHSazI/ACB0gggBPtp99j154/vZFrk37ruTTexX1gviQeTWUyEsnF/o
X-Gm-Message-State: AOJu0YzOYPvLPEbEgE5SE2VtUC0z7hmVHDTKnuSpaK4KQQRGMoQYJrDp
	l8PNNaYRNS/60I9z6I58k4mq39ulcaJFxiZ+24CswLada4yX7sQ8apxe4nTgTO2cejcAgLu031H
	inBsJqQ==
X-Google-Smtp-Source: AGHT+IEwP+E3u2dgtVMZEOlfxQ8VjpgVm7mo0TtZL1y5NTtfFnGuG/Iwz3NLCBTEITVVTFCrEBcLJg==
X-Received: by 2002:a17:907:72c6:b0:a47:30a1:4c1b with SMTP id du6-20020a17090772c600b00a4730a14c1bmr6003617ejc.55.1711904487560;
        Sun, 31 Mar 2024 10:01:27 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id u14-20020a170906780e00b00a46c8dbd5e4sm4326499ejm.7.2024.03.31.10.01.27
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Mar 2024 10:01:27 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56c08d1e900so3766564a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 10:01:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWl39nU/xs8xBl4XrQ0mgCpiPmoiGPj4KQClS9FMPNa5e7dek9RdlCN1csKcB6mIgNlhANfjIQ1lwcC28vADGhU9qfukT4PQf/QmDlM
X-Received: by 2002:a17:907:31ca:b0:a4e:44b7:50ef with SMTP id
 xf10-20020a17090731ca00b00a4e44b750efmr3944048ejb.9.1711904486771; Sun, 31
 Mar 2024 10:01:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326143838.15076-1-jarkko@kernel.org> <CAHk-=wgNpPQFJyLe5dwEVH66ubviuiwM1_tjbyzQv4BytPw7dQ@mail.gmail.com>
 <D07PD5NTOXSQ.30D5V19O6KMQS@kernel.org>
In-Reply-To: <D07PD5NTOXSQ.30D5V19O6KMQS@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 31 Mar 2024 10:01:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi-VWatwU5Gi6n74LF66dRWCo4dUozwj_DwTBRO-wDFcA@mail.gmail.com>
Message-ID: <CAHk-=wi-VWatwU5Gi6n74LF66dRWCo4dUozwj_DwTBRO-wDFcA@mail.gmail.com>
Subject: Re: [GIT PULL] tpmdd changes for v6.9-rc2
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	keyrings@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 30 Mar 2024 at 22:57, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> OK, point taken and it is evolutionary issue really but definitely
> needs to be fixed.
>
> I review and test most of the stuff that goes to keyring but other
> than trusted keys, I usually pick only few patches every now and
> then to my tree.

It's perfectly fine if you send me key updates - you're listed as
maintainer etc, that's not a problem.

But when I get a tag name that says "tpmdd" and a subject that says
"tpmdd", I'm noty expecting to then see key updates in the pull.

So that part of my issue was literally just that your subject line and
tag name didn't match the contents, and that just makes me go "there's
something wrong here".

So keys coming through your tree is fine per se, it's just that I want
the subject line etc to actually make sense.

                    Linus

