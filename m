Return-Path: <linux-kernel+bounces-51545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 204F7848C5C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 10:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D11AF282053
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 09:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D69415AD0;
	Sun,  4 Feb 2024 09:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gncM030U"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6624614AA0
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 09:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707037778; cv=none; b=T2hs9FGPkm5FqZCjNNwg8CH957qibJykAsLUTDgCasO/NFLO+FXnu2LJabra3b7oGm/K1XTQSO0PjGYnp63eUrZ1Sy38HRF4c1eOFJcbOrM3wkB8qPb5mvrjLt8n+yBlLujk+pP+qtvOcbv+sT9ZIeIIOD+v2eARIB9Dxd3i9YY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707037778; c=relaxed/simple;
	bh=QBfO/fVBUGbd2B+gQQfdgwvVTKuSgWnOSx8bYhh8dmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N/mbnSLyM5p/i+X/mYpLCp0/b+IqytkwazOXjmKFW7Dr/39I9dmJ4Zf30mjhtHhB5XhUSkv2pAQTIvfGVwv6WRgRhVQO1H9h2YZgYx62zXrrnd7fcSyHeMg/ojWbSu5cjLfLil4CRe6pWieWVRm37c74HODodJi3K/Lc09MJseE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=gncM030U; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a359e6fde44so358039666b.3
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 01:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1707037774; x=1707642574; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x+bOGtvhSdoCBkpFP05S+UJkiX09M/YWlTNg9SFndfw=;
        b=gncM030UZAvl2LB2ccvmneHHmycj76VEuddzmT1PE7mWq/IrGHLGNa/KnJ9siLgn/p
         0Sv7PI8XZmDqhI7Qokokz4uOV7SoNpeiHmzVA1HwoyrYqu/CAtqlJGyz+vy8uSx87kh5
         /GQtFA/MzQIe8Ln0EqV4rStiC6A6ZF6MkOayk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707037774; x=1707642574;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x+bOGtvhSdoCBkpFP05S+UJkiX09M/YWlTNg9SFndfw=;
        b=VHqcbAxRlLKyxjb19kLrNHZq4NdrTFmwiEtL5OIAfolA9Z/7DT33JO0ZxJFXseLlYR
         Jy1JMkF6TpyCyDofSYyan5g8RSMnMxazXxi70ngJWyq6nfTWU2/LnpXn9AtNfk/Dqu5L
         0DXygH46FxJ+4fjIGpVtRcy/XxQ7dbCUYkGVei78cHn6IvfIqSk7K18dVgztS4IWQ189
         Cs5RAbnck6IXkUWq7HPh0QtI6zFfbwLMJdGOwBlREM4caw3xC3xRjjKCElsdCFW7asSj
         O621RGdAiDr1ql2sV3Tq3w5aNDrtVDhzojc2sYTD3W6zf4l4pWQMyF1Zvca4kYRqiLZ1
         rtIg==
X-Gm-Message-State: AOJu0YysAg/rUYo2EnII5OCv53M5oxt1ESWR0TvGZrJbeciHkLgP+tkh
	tcaUGfHMDOc2XC0fFbgEWEUZPANh/o+UOg0tqCh2j6rFIYyEBVO0fcvK6XJeiYl+Bu1WUYY2voP
	i170=
X-Google-Smtp-Source: AGHT+IFpDeGOADLd1n5XnCCdM49/S2LiTPsOVRh4/ToYxFYMxP/QWlr9wQu2eKxt8f8+J7s84+WSjQ==
X-Received: by 2002:a17:907:994a:b0:a36:5b3c:be40 with SMTP id kl10-20020a170907994a00b00a365b3cbe40mr10212115ejc.58.1707037774322;
        Sun, 04 Feb 2024 01:09:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUu5oPxkeCr0ZvH4X3YbotbcA6P4pIlPqrS0ChPpnGMuf9csOxZOTq5Pec0EAb8y0qDfOJ3bvMFyoiPjkMIlnI9szLLX9g6xsj0vOgk
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id ld4-20020a1709079c0400b00a3634a461f9sm2911307ejc.109.2024.02.04.01.09.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Feb 2024 01:09:33 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55783b7b47aso4687593a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Feb 2024 01:09:33 -0800 (PST)
X-Received: by 2002:aa7:d4d1:0:b0:55e:eb81:2db0 with SMTP id
 t17-20020aa7d4d1000000b0055eeb812db0mr2894600edr.38.1707037772839; Sun, 04
 Feb 2024 01:09:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240204085155.6745-1-sanpeqf@gmail.com>
In-Reply-To: <20240204085155.6745-1-sanpeqf@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 4 Feb 2024 09:09:16 +0000
X-Gmail-Original-Message-ID: <CAHk-=wgxkAgRPb7ZZ+w7UHhp2OuV=pc_C7D+hEYcA65ieMFt0g@mail.gmail.com>
Message-ID: <CAHk-=wgxkAgRPb7ZZ+w7UHhp2OuV=pc_C7D+hEYcA65ieMFt0g@mail.gmail.com>
Subject: Re: [PATCH] lib/bch.c: increase bitrev single conversion length
To: John Sanpe <sanpeqf@gmail.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, rdunlap@infradead.org, 
	unixbhaskar@gmail.com, mm-commits@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 4 Feb 2024 at 08:52, John Sanpe <sanpeqf@gmail.com> wrote:
>
> Optimized the performance of the three functions (load_ecc8 store_ecc8
> and bch_encode) using a larger calculation length.

Honestly, with any optimization, you should quote performance numbers.

Also, it's questionable how meaningful this is, considering that most
architectures dop the bit swap with a byte lookup, and the 32-bit bit
swap is just four byte lookups. For all we know, this only makes
things worse.

Finally, if you actually want to do things in bigger chunks, that
->swap_bits conditional should probably be moved out of the loops, not
just have that questionable 8->32 bit expansion.

            Linus

