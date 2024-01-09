Return-Path: <linux-kernel+bounces-21407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2DB5828EBB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:08:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81A271F24C30
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEEA3D99C;
	Tue,  9 Jan 2024 21:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UWlSS6Yx"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371153D985
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 21:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50eaa8b447bso3604620e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 13:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704834497; x=1705439297; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n5OP/fkUpA71bK1KZM2DjGPMtohQ3KQSJyVNV5c2Cc4=;
        b=UWlSS6Yxl1p5721X8eP93FRoIWlkp5L5CYtgFZoMHT9P/aOafWpLOMJqTd3ZY/NPzb
         V5+jTMqeNMgWvAJY6xBtCQzMkFnwm6Snt3CIXGH0qewqwbODL5LYrCogFBOafLxsw4pF
         W5rriunfCkUIz9wnz98DglfZih3Jz3LN08K0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704834497; x=1705439297;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n5OP/fkUpA71bK1KZM2DjGPMtohQ3KQSJyVNV5c2Cc4=;
        b=gkHpGxlMlnfe14N2hB/N6Z4EdGFq3UEQZEtd4DiH/HxpizJ5N8Yvt1dj2yC3l7nbsE
         ek1l7CQ36ZaKkQuYxrjgrqsonn2u1y/60eAiAxOA1GflhB5WXAlNRbO4Nu2gBtDWg53y
         xSnmwtCIDu2yaZkEeCAMuHxLlUC82iPaMCg/63tzM78qggg9MTI1FLT8WeVQ4eih7aWY
         vkey2LD3M8TX3ZTbqk0grsWj5dG/xjpsjOsa9jniA9YEMSpnIyca/oOL6uK7bnT/oIPI
         O5rDdhMFb4E+cKE0F12GZVf+DuuQWcNEXLNqotfUda8j+WKRgcSNmdmiMhllHKmOj7Vf
         QfKQ==
X-Gm-Message-State: AOJu0YxYQxref0OdboGy8/lDZzoE0Iedp5CcTzhzuJXa5ETXtii5bSQn
	49WRzyRRpv4zWvcNwd7TH8D5kU9ItbIi9WH5ALLgNw+sMxpzdGck
X-Google-Smtp-Source: AGHT+IGIZ2/4U0y7HKZEsTNgYTGAg66gCh+qtyMKFwN0lPolRPL5wqvURAcUSQ9DZEeq33OQj6Ev1Q==
X-Received: by 2002:a05:6512:2212:b0:50e:80fd:8dd5 with SMTP id h18-20020a056512221200b0050e80fd8dd5mr1602878lfu.234.1704834497024;
        Tue, 09 Jan 2024 13:08:17 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id q25-20020a056402041900b00557d839727esm1319655edv.7.2024.01.09.13.08.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 13:08:16 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-553ba2f0c8fso3927339a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 13:08:16 -0800 (PST)
X-Received: by 2002:a17:906:f599:b0:a27:a00a:bd8a with SMTP id
 cm25-20020a170906f59900b00a27a00abd8amr37454ejd.151.1704834496115; Tue, 09
 Jan 2024 13:08:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3f5a7bc467d221543444a268dd1a1fe0@paul-moore.com>
In-Reply-To: <3f5a7bc467d221543444a268dd1a1fe0@paul-moore.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 9 Jan 2024 13:07:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=whb9anXdo4odpP-ybYbmQs0UaPp1fmDjsWFiGxV5aOmig@mail.gmail.com>
Message-ID: <CAHk-=whb9anXdo4odpP-ybYbmQs0UaPp1fmDjsWFiGxV5aOmig@mail.gmail.com>
Subject: Re: [GIT PULL] lsm/lsm-pr-20240105
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jan 2024 at 15:21, Paul Moore <paul@paul-moore.com> wrote:
>
>             The hightlights of the LSM pull
> request are below, but before we get to that I want to mention that I
> expect you will hit merge conflicts in the arch-specific syscall
> tables as well as in the doc userspace-api documentation index.  Some
> of these conflicts exist in your tree now (syscall tables), with some
> others likely depending on what is submitted from linux-next and the
> order in which you merge things.  All of the conflicts that I've seen
> have been rather trivial and easily resolved, but I wanted to give you
> a heads-up; if you want me to resolve any of these let me know.

The tooling header file updates by the LSM tree were particularly annoying.

Not because the conflicts were hard per se, but because you had done
the header files wrong in the first place.

Your version of the tooling header files just didn't match the real
ones, as you had added your new system calls at the end mindlessly,
without noticing that others had *not* done so, so all your tooling
header system call number additions were just the wrong numbers
entirely.

I fixed it up, but it added an extra layer of "this is just annoying".
You'd have been better off not touching the tooling headers at all,
rather than touch them incorrectly.

            Linus

