Return-Path: <linux-kernel+bounces-45469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6BB843127
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86DDE1F254AC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AFB7AE7E;
	Tue, 30 Jan 2024 23:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EW+aAlpU"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6361B7EEFD
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 23:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706657129; cv=none; b=Lqhtk4+Ypu+L26NAbUb1p4JKr6tw1NZtdhFtTNDFxaGKoTrBNZaNA1+XAJZmX2izbgIr8uwAsUkza45b/DDVw/sb8GGMWYbvu8g0Rrz+qDI2P7cTR3+lw2hHml7cMlB+db48IJzbhDIwa2c2S4DbW23Imyz0jqdSW8LpDU6jYcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706657129; c=relaxed/simple;
	bh=1UtYXCS2vfDZ/wH9mjGbxM9COQFwJYC4XgbeYbzWnpo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PpOrNckrOv2ZbaEfO0sVeF4uHgfDYrPcDFhK7mn8LaSwxJOvcJrG2T1VNsjDJvDZhMQzjRIRqlSfDbAeXw/JCT8pnvs5MlwJBu4yGm3KCTHL8qj2JIKb4obgubFbC0sHkDLpe/X0wlUpvDS+KHKL5f1Oxm+AZQReekyMy83c00A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EW+aAlpU; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a357cba4a32so404639966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706657125; x=1707261925; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YSO2ChDnlAH86gKOgqytEYfVHkZEABWvmQ0LHebtTDM=;
        b=EW+aAlpU14rULpscwfxihdBCwFMRHB2diGRDjwNkvk5gSgJIl9cTPV4T7Z/op1/yo+
         JjluqXO5Wj2ew2MEXy0kV3Rxmh37yVcfHooCPF8SwAf6OS71uKup0hdTLQVoZdYSwjoR
         8AjIq0IdUJFlfoWamA5+ykBD67P6O2BT7kFKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706657125; x=1707261925;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YSO2ChDnlAH86gKOgqytEYfVHkZEABWvmQ0LHebtTDM=;
        b=vQCtT+A1m2SV/bHri3lmlXOUkNVShKgX9YQ6ppCAGtunLVYBaFooXk8xq+HUpBj2HE
         cmSRccrryrXP8AKW9ZyN7qMds5HW4wMZNLUuInxzVTNLatT34p9IJwucIC56H/7tobCV
         IcftGppo31b816womlNv9ZDWNm5KBhU/QbVZ1+PUxmhai6NKSycH9ttsR+FU0BxcUf0r
         VmvBmiuelvXMgcaELVGWmvtJlEtpwKyPwCv2P+lV/+HDuULv9uWcVYouWABkvvH5JhvJ
         v92L6haDEFFIWwp6mOaDxFO8lE0Yuat+4Zou9E41NKK/OOgSrS7r9OB/Gf2il0xP4TaA
         LtFA==
X-Gm-Message-State: AOJu0Yy8EqJLXdy2JTJKWJhziq8CsxRfxOP3GvUcG6P3+CsT1iE3c6LQ
	YZcnDJ+/lLR3cM/ImG69xD8mYL6njR09EJhT8dvcHjg8GH5Q2TJsIx2TFyZi7va/P4/jpHtWL3C
	tfVRyOA==
X-Google-Smtp-Source: AGHT+IHhJjEOdl0n054DDurQLoQxcz9VAoBfiUJEWoAPQ4KjY6Zc7BMD+B2kYh5Slf7THUQ2mEh+mA==
X-Received: by 2002:a17:906:8da:b0:a34:b006:72ce with SMTP id o26-20020a17090608da00b00a34b00672cemr7452292eje.44.1706657125301;
        Tue, 30 Jan 2024 15:25:25 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id vi1-20020a170907d40100b00a2f48a43c3esm5554775ejc.7.2024.01.30.15.25.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 15:25:24 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55ef0465507so3815002a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:25:24 -0800 (PST)
X-Received: by 2002:aa7:c614:0:b0:55f:4bd8:499 with SMTP id
 h20-20020aa7c614000000b0055f4bd80499mr1595483edq.5.1706657124478; Tue, 30 Jan
 2024 15:25:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
 <20240130190355.11486-5-torvalds@linux-foundation.org> <20240130155550.4881d558@gandalf.local.home>
 <CAHk-=whD=9qTfhYVhH+d44KbwefC_vnRAjqz-pthcSn1p5zZLA@mail.gmail.com>
 <CAHk-=wg=tFFTep3dDTVHKYZBdNj0+PV4a0-UR1sVR3K7RHPGFg@mail.gmail.com>
 <CAHk-=wiPWaiD5fwyXXHX-qgk6t2+0NM_KHzwiecvCBiNWZacHA@mail.gmail.com> <20240130181057.278ac05c@gandalf.local.home>
In-Reply-To: <20240130181057.278ac05c@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Jan 2024 15:25:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgtX3aLPVLeSbyXEz7BGJGFbhXeH-788Nad=swajW72Wg@mail.gmail.com>
Message-ID: <CAHk-=wgtX3aLPVLeSbyXEz7BGJGFbhXeH-788Nad=swajW72Wg@mail.gmail.com>
Subject: Re: [PATCH 5/6] eventfs: get rid of dentry pointers without refcounts
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 30 Jan 2024 at 15:10, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > At which point a name pointer would *just* fit in 96 bytes.
>
> Does that mean I should keep the kstrdup_const()?

You should check that my math matches reality and relevant
configurations, but yes, at 96 bytes that should fit exactly in one
slab entry on both x86-64 and arm64 (now that arm finally does sane
kmalloc sizes - for the longest time they were all 128-byte aligned
due to historical horrible DMA coherency issues).

But you might also add a comment to the eventfs_inode definition,
because if that ever changes, the math changes again. For example,
adding just one more attribute data would make it all fall apart.

If you *really* want to optimize that data structure, I think you can
make the child list be a 'hlist'. That makes the list head ('children'
becomes a 'hlist_head') smaller, even if the list entry ('list'
becomes a 'hlist_node') stays the same size.

             Linus

