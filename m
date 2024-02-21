Return-Path: <linux-kernel+bounces-73949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F1785CDE9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AF6B28367B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE165232;
	Wed, 21 Feb 2024 02:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8t0v/VQ"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC97C46BF;
	Wed, 21 Feb 2024 02:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708482150; cv=none; b=MQ3bmr/ibyyGSOWEI/fKIG4M1SxJZpCiO+Ku7VK94nsCHfa8Cni92wvGCF9NaiNcGLK0Pl2RCq4wjWF2/hXdwM7tyL6L1MbXQfZmUIqyysCJkSCvxuuyccsISmbvG6MA/4xtGMeNFCBrMBKZYyFXZYp52RugpCztuxoknqyJbP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708482150; c=relaxed/simple;
	bh=3KahlIpMvWJWOVfz3J0b1jo1fgdXtR++9nbG39MWiAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jhdvbAseYL+AnAgfWQukCZeaZ5PTJ/jr6kMtFQyO4EctTstGc9Yz8SUIG18trZqAcWX8lzmLbOf2yPRa0SqrZcuY9kRJqeMKhEaBA09smcSrCRHcCDszYgV2QXboY5tfqVkywaRJ/JttbuMXx5O6mxGUcV8LKp+bO7eqkNz3USg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8t0v/VQ; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7c490498729so6286539f.1;
        Tue, 20 Feb 2024 18:22:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708482148; x=1709086948; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mhk0q27X8GinCZy7XzzdW389DBQpazGkJTGn+SAUaKg=;
        b=W8t0v/VQ3oUAFjcieqzqP6Jyyfp5yZ3rrHoMmkPVPsvWyMI44U+UEZI58KsqAuxB1C
         YtdxtRnGI0Ua9SH+5CwzlxWudSMUt/AglSUNgRoWdCwmk9CyPFO9TNEZlz4JyLMoV3v7
         sta9bs+FPI7Cm4MoizyG15BPGxpJAAcRlMNrMdqisHOSSno6Fs+mJo26TSWyebXNwu45
         PmixupQ7KQwYejvicQehizzBwZnCMHVm5LUSGI9TP9S4BWGqnytgthfhl8WqSfyimdUY
         vRI5AQCw7FzaTj9WSZqJe80gJNyL1XWDgdVqxma+uzQ4M6yqjv2rG6Df44lz0OCKE/mh
         1PQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708482148; x=1709086948;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mhk0q27X8GinCZy7XzzdW389DBQpazGkJTGn+SAUaKg=;
        b=nojeWnb4PFuFQr62WsZi1Ht+70RBDFXi6RGNxpXKlM5GoqH1JZyAH5XdL2fXM6BTOq
         C4r/fKQJAiTfLmKfAPSCUuYX25mrSbe62TqDJ7nBkyk7/uJjIsSwAWLR8hzxMU3w7OZc
         goGKj/N3B22jX9QDIHAUzPuTr7ur51wHNanYHe8sOX0oo26kqA6owvEppir7lNYGC3eq
         dSApY0VR2fHm96tiCFdZP1/utO976EynuK6TpislSz8AfLk2zR9nHFaLuZZcauz7XAfb
         mTQ8DRe4jMMo5ag8DBxb6AfDuo5HIv2siJnQCc1ja3Q0DhE79pX8YeWR8iTuEHdA2lyQ
         YopQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQFoIGGoO7KBq316bUVK5VCQZyreXqUVptnAhVygShQosFfBrzXPHzfJDTj1uthHOiGQXbXK6cIHGG+WERyYT7Id63D8e6wmh9CM0G3FdOwyhAv3LuexMBhdy593dHtckOkZ9dp0G5oZ5KiMhG0VE1yiVIaScFs8aX19Ai/HvS8/QGEKoQWPDwEmT8qwZeIMuTodUDIqoOokFMLN6QBazx
X-Gm-Message-State: AOJu0Yz62Bci2z/XE6Q1ab7Pt4koNNaTSFrPHygxghU0e0/TSQz3ADB8
	FWDakDaIazIqpoukLqTetB8BYKINYoGE0ZicBkmTG+DF4sOwv8BdpD2bRZ/Zr1/cA70RLuPrlhB
	i+w46L2Atgyrg4mZSX5McFhd8dS4=
X-Google-Smtp-Source: AGHT+IF2VfDZBoX5pQjaflh73V91CMTptpS/eM0zxZ1Rx/DhA1L5dll99owOM9lN68Xa6i3gE5uApl5W+PVF+WaNdlc=
X-Received: by 2002:a05:6602:3f92:b0:7c7:2e6a:9bbe with SMTP id
 fb18-20020a0566023f9200b007c72e6a9bbemr16676784iob.10.1708482147782; Tue, 20
 Feb 2024 18:22:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222013352.3873689-1-kcfeng0@nuvoton.com> <20231222013352.3873689-2-kcfeng0@nuvoton.com>
 <5dd9d5f8-c909-4245-b37f-cfb0a8096a50@roeck-us.net>
In-Reply-To: <5dd9d5f8-c909-4245-b37f-cfb0a8096a50@roeck-us.net>
From: Ban Feng <baneric926@gmail.com>
Date: Wed, 21 Feb 2024 10:22:16 +0800
Message-ID: <CALz278Z_YgY6J3SqfnMad1tcw-SQquhSsOJjdA6Okpb5vz78Qw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] dt-bindings: hwmon: fan: Add fan binding to schema
To: Guenter Roeck <linux@roeck-us.net>
Cc: jdelvare@suse.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
	conor+dt@kernel.org, corbet@lwn.net, linux-hwmon@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, openbmc@lists.ozlabs.org, kwliu@nuvoton.com, 
	kcfeng0@nuvoton.com, DELPHINE_CHIU@wiwynn.com, Bonnie_Lo@wiwynn.com, 
	naresh.solanki@9elements.com, billy_tsai@aspeedtech.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Guenter,

On Sat, Feb 3, 2024 at 11:09=E2=80=AFPM Guenter Roeck <linux@roeck-us.net> =
wrote:
>
> On Fri, Dec 22, 2023 at 09:33:50AM +0800, baneric926@gmail.com wrote:
> > From: Naresh Solanki <naresh.solanki@9elements.com>
> >
> > Add common fan properties bindings to a schema.
> >
> > Bindings for fan controllers can reference the common schema for the
> > fan
> >
> > child nodes:
> >
> >   patternProperties:
> >     "^fan@[0-2]":
> >       type: object
> >       $ref: fan-common.yaml#
> >       unevaluatedProperties: false
> >
> > Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
> > Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
> > Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>
>
> Unfortunately the dt maintainer's Reviewed-by: tag on the latest version
> of the fan schema patch got lost. I am not sure if I can add that back
> in on my own without violating some rules. That will need to get resolved
> before we can move forward with these patches.
>
> Guenter

Owner will add 'Reviewed-by: tag from Rob' in the next version.

Thanks,
Ban

