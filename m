Return-Path: <linux-kernel+bounces-100509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 848568798E0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFD751F23334
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F13F7E57A;
	Tue, 12 Mar 2024 16:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hLhFbqVs"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9377C6DE
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 16:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710260656; cv=none; b=nQS3hVgV1+y/Iz5seaGRmR7xXkGWdLMe2omK8O3PIHHAIIL5Jv6WCL53Ba9dy9Wlgc3SL2tHHJgDt45ZZ7ZMW/R/z20MlipMcmwMHUMQBCOvJpnT30jYn5c+nhT8Dq2F9HcyBySacFxd38tTU30k99OQvpWKXiztktlwBjoJnug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710260656; c=relaxed/simple;
	bh=gUpiTTtVdCSdTNsFAXy4anMcCYBGsbVSB3nOkoY3sic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SN1owUCQD7UxTdhR+yXQrgTCa9v60OhiebQwprHiIdcemh3pjloL7Yk+0cFRum0QD90D4CADVAZTOYthP7cbhpzwp311QTRGPjRPtRrVW9HVeDEiL1YSYJOEyAUCjIlfLhoGLkM09D63kkAoui306rUnImq5iMqiBlzbY3VYaPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hLhFbqVs; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a461d0c90c1so18986466b.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710260653; x=1710865453; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=404ludRtPDabZjwWi280UhL8x7uLqEhd2I82RVxtiI0=;
        b=hLhFbqVsMVlqgpxJFVOrS4BTX3pmrSwCOHIskavf761fKdbdJZBD5SjTRqIV8rg3K/
         Dw63Lg/4TNEL76dHdjjQ3Wm3eq0cOotiXSXk1/k0LkMY77cnUFVn6yy86QFmmwVFK/sp
         DCDPjyVNrMpkMj/VttS8iberWiNGBrGTTeIPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710260653; x=1710865453;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=404ludRtPDabZjwWi280UhL8x7uLqEhd2I82RVxtiI0=;
        b=u9vMMXRAUxls+t9FJ49y3yf1S9yoxTsCKZVeqPii+m2VVi2YnVGPpJHwnqZYmOQBu5
         lMD1i5dOo+61ICUi/Fi1Sf5pu1omadrqeNO9GYkfdiv3eQ7ku1qsNZRNpUaUzct0Tj3t
         OzuHAtcMBF6X4Z6UeLuOPz56gt9OA6RTN2wewfqTKfG33wwslzwrpbDa1CKkmjz9hAZW
         z74SKLBFMtCtmKDyPpnFXteA9RwmDyl/SBGvKIyh2mdSAFk8GuibJ8hv6rN7K4Rt8jDa
         EW/9FSOoQIPGnnOKaIAvv4hsF/AirL8sG7WYL0CyBdokT+HbA3+098y5yhsnfiRj58zy
         bmTw==
X-Forwarded-Encrypted: i=1; AJvYcCUsO4BB/gWSD6HcHzpF2cTv/ieGncAgYFdUDkIJnDs8kcceyH36JUFKXLghSej26qECe0LHXdXhu8wmXKYop+srLfv9Ggfm6+F5xGGY
X-Gm-Message-State: AOJu0Ywo6Z11uWBbDxxNnMIQUoLeMgRmNOQBCFFjLNu6DgfxXsooPT/f
	vABNz6wHwhUUROVZvGruWZbz4WvjtByX7WVRRSo6C0gLnCmnLgq11mmN1Ni8zdaxwIWsZzKRi6y
	bM1Pt8Q==
X-Google-Smtp-Source: AGHT+IGfrrzmfX+gp0hWs1IDoW46EKZA38Gz3VGFWFaEI9wbpH5UPoyf8pDcrn0+NOS6yS73UWEkmg==
X-Received: by 2002:a17:906:f10a:b0:a44:4d9b:9062 with SMTP id gv10-20020a170906f10a00b00a444d9b9062mr591590ejb.69.1710260652708;
        Tue, 12 Mar 2024 09:24:12 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id oq26-20020a170906cc9a00b00a449fdfe27bsm807945ejb.170.2024.03.12.09.24.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 09:24:12 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a461c50deccso21919866b.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:24:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV5xWgeaiAmYbnvPTZW+OeqwC1Pg3L4FUMLzglH+t27meDcg48ecEWnd5x4dOOMbQMZVvZ8ki6j6YOveWlifcDDCWSrf010bnE5UtpG
X-Received: by 2002:a17:906:ba85:b0:a46:2a85:b37b with SMTP id
 cu5-20020a170906ba8500b00a462a85b37bmr685796ejd.51.1710260651798; Tue, 12 Mar
 2024 09:24:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240308-vfs-pidfd-b106369f5406@brauner> <CAHk-=wigcyOxVQuQrmk2Rgn_-B=1+oQhCnTTjynQs0CdYekEYg@mail.gmail.com>
 <20240312-dingo-sehnlich-b3ecc35c6de7@brauner>
In-Reply-To: <20240312-dingo-sehnlich-b3ecc35c6de7@brauner>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 12 Mar 2024 09:23:55 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgsjaakq1FFOXEKAdZKrkTgGafW9BedmWMP2NNka4bU-w@mail.gmail.com>
Message-ID: <CAHk-=wgsjaakq1FFOXEKAdZKrkTgGafW9BedmWMP2NNka4bU-w@mail.gmail.com>
Subject: Re: [GIT PULL] vfs pidfd
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Mar 2024 at 07:16, Christian Brauner <brauner@kernel.org> wrote:
>
> No, the size of struct pid was the main reason but I don't think it
> matters. A side-effect was that we could easily enforce 64bit inode
> numbers. But realistically it's trivial enough to workaround. Here's a
> patch for what I think is pretty simple appended. Does that work?

This looks eminently sane to me. Not that I actually _tested_it, but
since my testing would have compared it to my current setup (64-bit
and CONFIG_FS_PID=y) any testing would have been pointless because
that case didn't change.

Looking at the patch, I do wonder how much we even care about 64-bit
inodes. I'd like to point out how 'path_from_stashed()' only takes a
'unsigned long ino' anyway, and I don't think anything really cares
about either the high bits *or* the uniqueness of that inode number..

And similarly, i_ino isn't actually *used* for anything but naming to
user space.

So I'm not at all sure the whole 64-bit checks are worth it. Am I
missing something else?

                Linus

