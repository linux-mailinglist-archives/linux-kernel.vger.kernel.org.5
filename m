Return-Path: <linux-kernel+bounces-92503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4838A872151
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:17:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69C1F1C21676
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AF68663E;
	Tue,  5 Mar 2024 14:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XnihEjqw"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED68285C73
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 14:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709648208; cv=none; b=cTFcGkwkfHDHtl4JN9QFbvr0L/qQnG+1kyf+ILpCQXyyWotHp0w90tp8Nz5MpHlTO7k210eoOCYvsmDeDD/cNy9OBSicsCSYAg9LgWWPdp55Ko4dfb2+df7dhCPqY3BfM8j5XwtYTnUez7BuYtP3iPuzV2LXGAD2qmOdp8G1qaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709648208; c=relaxed/simple;
	bh=5e8RyFZB6uK5xAt4LzJ2CHaCyI7HgnYjNdG/wsdLGUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sq7Mp4kFLM6C5mEghG0tGU/lYlHKB9IlaEUoX5dMRqT5+BAu0XHbfs8CPTTsxRq7NVZtLZN0OJxo2tG9ZqtQ+gw2gArT0R/oeZ1juIUMAYVoLlThJwxJJ9T/N4FpojWRwpQdPTC+vN3RgVITGjtUWN9Blq2xwsO9wM+2kdOgXDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XnihEjqw; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-608ccac1899so60934627b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 06:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709648206; x=1710253006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pH6ao14eXyStRIsXpQqXQUUaYQVBQF/CrmMchFPm6Y=;
        b=XnihEjqwoNincZDOGc7DDbRrAG+oiem+1EXxR1OumtK6iUVjcpJhAY9mYx10W/JICj
         nmLE9KqCx7bySQd1IvWLT8CqVACTiB1hHr0Jtr68uQdpn0POcA/MWO99EpI++G2/TcAS
         2wSvhQ16/jGfYQe2VZnuBtahW4ipNRpkeBvuKLq/ZMOeaoAher8AS4gZBLnO4nYVN5O5
         1MmnNh7tXNFRRmZR1GUznkJ58eA1y+j/9K6hMdKVHvidAQ5WBdL2PLVTEyOxDO+L0il/
         C2PWb4qaQP/9glmeMO4TAAhxKDZt86mrCOilDNmwPPZ8nEWClx9Y2p0b6vnos4zb1SIn
         TSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709648206; x=1710253006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2pH6ao14eXyStRIsXpQqXQUUaYQVBQF/CrmMchFPm6Y=;
        b=Ja7ttpd0m/AzGf74Uy9QRx9uDxkBausmonfpMOWkIwnZR/3bsXVbwy7fDJ+LvxfCWN
         eLq4h90AuI5n6VlwSV+G3KdVWItgJUc8th/eAa7fJOJiMl1at+mgzJvqvfcGgXle8J9R
         ScM8NCelqqoh/nWwBoW+unECkEf9cNXfMlqxKloXkmwY7YvICIxIItibNz0JL/T1Fy79
         zQUy5r3WBc637L7+bqDrpL2o99nCwRnnNDWI1vLWbyroLQ6Pxm04da2QHjZ9SbXVOir1
         5003KU1fQyQjVdqGJJac+vEnZ6Vv6NEMUz2eRXhaunLRNEPReSjWM9SA5GcU0CIl16JL
         mK7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXWdll54Gu01SdNY913StojeesjZfqvgGgLaIDDjM80Ho5GL1uBYCIBFl6bt0BzdK5yDas3ff6YcfzMmY1onLwyG0NjX81GgK1X1Lhj
X-Gm-Message-State: AOJu0YyaROUfTv5jJgPuRZsSeVsdgHuJGyX31mefssBX2jGwCdBMgqsH
	6NTKQ2diVPRleKSbcTGKn6u+D92JQayWw5unQi9A43C4+mqfQuxACJpg6HC8Yz6X0KhqUv8uKvd
	/P3QLOOR3TtHh0xAtI/w7wdHNZmSwV8sSlnbJMA==
X-Google-Smtp-Source: AGHT+IF0QE2eCgnKzPX7Lzulyl8LNxaoMkz8j136SkagCThiX4WET+LmP/hJRSwK65wX3P+LcjLSWXZvzp6Wx9/mLO0=
X-Received: by 2002:a05:6902:250d:b0:dcd:5187:a032 with SMTP id
 dt13-20020a056902250d00b00dcd5187a032mr10587042ybb.43.1709648205832; Tue, 05
 Mar 2024 06:16:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227153132.2611499-1-jens.wiklander@linaro.org>
 <20240227153132.2611499-2-jens.wiklander@linaro.org> <CACRpkdbhhZ9+Jy_tvWy1RSnyZMjqUhh0ARpS+WRtgWTH3AYCPw@mail.gmail.com>
 <PH7PR11MB7605493349915A168A80CDD8E5222@PH7PR11MB7605.namprd11.prod.outlook.com>
In-Reply-To: <PH7PR11MB7605493349915A168A80CDD8E5222@PH7PR11MB7605.namprd11.prod.outlook.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 5 Mar 2024 15:16:34 +0100
Message-ID: <CACRpkdaOnbUmk1q_BBWkPYGriNHfZBUmGxtH+sQmw6U0rxicMg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] rpmb: add Replay Protected Memory Block (RPMB) subsystem
To: "Winkler, Tomas" <tomas.winkler@intel.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, 
	"op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, 
	Shyam Saini <shyamsaini@linux.microsoft.com>, Ulf Hansson <ulf.hansson@linaro.org>, 
	Jerome Forissier <jerome.forissier@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bart Van Assche <bvanassche@acm.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 1:54=E2=80=AFPM Winkler, Tomas <tomas.winkler@intel.=
com> wrote:

> > On Tue, Feb 27, 2024 at 4:31=E2=80=AFPM Jens Wiklander <jens.wiklander@=
linaro.org>
> > wrote:
> >
> > > +struct rpmb_frame {
> > > +       u8     stuff[196];
> > > +       u8     key_mac[32];
> > > +       u8     data[256];
> > > +       u8     nonce[16];
> > > +       __be32 write_counter;
> > > +       __be16 addr;
> > > +       __be16 block_count;
> > > +       __be16 result;
> > > +       __be16 req_resp;
> > > +} __packed;
> >
> > I didn't quite get why these things are encoded big-endian?
>
> By the spec.

So a kerneldoc comment above the struct with a reference to the spec
it is mirroring should be appropriate?

As it stands now it will be misunderstood by people like me as "just some
other Linux struct".

Yours,
Linus Walleij

