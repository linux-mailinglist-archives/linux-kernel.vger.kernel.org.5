Return-Path: <linux-kernel+bounces-143150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A86E08A3509
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 19:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA3051C22182
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D43E14E2DA;
	Fri, 12 Apr 2024 17:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CbL6TWIv"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE7414B08C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 17:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712943808; cv=none; b=TP5Rbj8yHUgnHMNsKVXfwG+Qo8a02GZFsEdNJPKegbFaTuGuc0tZblbyi2JtxMXU8z0fKdZi0DUfyQh9J+OfCmHu0cBMGJk1o2KSu2bUJ0Sq1wD7D2eo2T0jaQmg/uUSwRUGN3xO2CwmMtTQgqim2vN/9Gryry9XlPKO/5kMTsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712943808; c=relaxed/simple;
	bh=BDTZoNZVl2PCqBUJe9bYbdgMaaniF90lPpDoy6XNomw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pkCOKxspkFFzIvTE4muLI6JaXQ9n/tVe/I0NGy5ymQcfTsq4+TAFD39w6dwRd48h5EjT46s/0khozF1o6li0pDzMR67grwimrskkA+DWSmMccTE1GGn9q918HmRqEQh3tN2AW325y9lGWpClWwAssHzvj1yw4Y4m0V56UeE3dx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=CbL6TWIv; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-56e2c1650d8so1209205a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 10:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712943805; x=1713548605; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pghq2XHCUSd3iCPX6kNZHrLa4n2jPknvo2Vf4i7b6Ik=;
        b=CbL6TWIvN3McNIqmNFn0A9nMd5OqF30JoRS0cjrNXe126vz0OTXhhulr/MdcKXeHoD
         baDUZcleFWJqFSp5xyddHQmMR2xPtQELn+tNN1Xj95GEgKthFV/oSGUqckRZByDnqccA
         SJFHVvQgR3sFIdOUXg56B8juSgaHCw2FqFgu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712943805; x=1713548605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pghq2XHCUSd3iCPX6kNZHrLa4n2jPknvo2Vf4i7b6Ik=;
        b=UVLCV/pTLu8w2VlLDuQKRsQnrBpdtTDxMJVGdwFYOxk7ksLzxt9D5pC8QlGvC8vr8/
         LKq4oFzA1gXCdltzidNI3bdHp91BVrgi7TPvfbJsz2gtqBEWumIULhWbCdPIyi2dNdiI
         rrESBMjW3s4CPLXFD+zVvzsccUedEuGpfymAm7qi3LzR8mYY7HmXeSD4El4Yto2z2e88
         C8mt0P6pUl6epUbP+lbszOZ9wNLwH071GzOKNPYyBcDZhFJgNTY6/VouA67lzfhcO5l0
         Nr55cQz3Z9sZfluApuq2rdAohbWix/nXr/N1O+vunEBzLnqcEI1nUYQzRFK19Wkyh/v+
         zzOA==
X-Forwarded-Encrypted: i=1; AJvYcCWqURsrLk7RZdhBc075kryfmYdqa5MyLwMx0EOFAQAg0S182kykP+jmcU6vb0ajugzOZRJwSEpvsxAp4DHOMKx6yKOEt1Xw59JS/0G5
X-Gm-Message-State: AOJu0Yxf3Tc4x9hBSWFV/kWJ6MfFG5eLb7ZZlbinTIxtVdg6AMftP/KR
	qMMb3D/p7uZz2FmYu4Zc0D6SjVRBpZInIGJLaW/MqZnEV+XNH+iRr5qGrox8SnfoKw2Rh3bhStt
	fB0TLDw==
X-Google-Smtp-Source: AGHT+IGxBj1kEQeXa4VTOOLLkqjxBIR3ePFBnJ3p3L5L7PF1zlXWWmI/y61UWys5RrR2L/Cf6Dr3UQ==
X-Received: by 2002:a50:d4cb:0:b0:56e:2e41:3c39 with SMTP id e11-20020a50d4cb000000b0056e2e413c39mr2436383edj.19.1712943804696;
        Fri, 12 Apr 2024 10:43:24 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id fj11-20020a0564022b8b00b0056e6a0ec702sm1861768edb.65.2024.04.12.10.43.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 10:43:24 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56829f41f81so1680745a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 10:43:23 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUOW5Zd0G0Vc6gDu/2+GFwMdlxCOTYLecRKXMlhQetVj+m+QQouOvEjrmFymgUsF4HUriBK6w5XzXzGamMzitBC5xlCgNAgNh2aZBEF
X-Received: by 2002:a17:906:755:b0:a52:2441:99c with SMTP id
 z21-20020a170906075500b00a522441099cmr1872379ejb.69.1712943803548; Fri, 12
 Apr 2024 10:43:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411001012.12513-1-torvalds@linux-foundation.org> <20240412-vegetarisch-installieren-1152433bd1a7@brauner>
In-Reply-To: <20240412-vegetarisch-installieren-1152433bd1a7@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 12 Apr 2024 10:43:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiYnnv7Kw7v+Cp2xU6_Fd-qxQMZuuxZ61LgA2=Gtftw-A@mail.gmail.com>
Message-ID: <CAHk-=wiYnnv7Kw7v+Cp2xU6_Fd-qxQMZuuxZ61LgA2=Gtftw-A@mail.gmail.com>
Subject: Re: [PATCH] vfs: relax linkat() AT_EMPTY_PATH - aka flink() - requirements
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Andrew Lutomirski <luto@kernel.org>, Peter Anvin <hpa@zytor.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"

Side note: I'd really like to relax another unrelated AT_EMPTY_PATH
issue: we should just allow a NULL path for that case.

The requirement that you pass an actual empty string is insane. It's
wrong. And it adds a noticeable amount of expense to this path,
because just getting the single byte and looking it up is fairly
expensive.

This was more noticeable because glibc at one point (still?) did

        newfstatat(6, "", buf, AT_EMPTY_PATH)

when it should have just done a simple "fstat()".

So there were (are?) a *LOT* of AT_EMPTY_PATH users, and they all do a
pointless "let's copy a string from user space".

And yes, I know exactly why AT_EMPTY_PATH exists: because POSIX
traditionally says that a path of "" has to return -ENOENT, not the
current working directory. So AT_EMPTY_PATH basically says "allow the
empty path for lookup".

But while it *allows* the empty path, it does't *force* it, so it
doesn't mean "avoid the lookup", and we really end up doing a lot of
extra work just for this case. Just the user string copy is a big deal
because of the whole overhead of accessing user space, but it's also
the whole "allocate memory for the path etc".

If we either said "a NULL path with AT_EMPTY_PATH means empty", or
even just added a new AT_NULL_PATH thing that means "path has to be
NULL, and it means the same as AT_EMPTY_PATH with an empty path", we'd
be able to avoid quite a bit of pointless work.

                  Linus

