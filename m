Return-Path: <linux-kernel+bounces-159842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A389E8B350B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:14:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25DEB1F21E47
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F11D143C6F;
	Fri, 26 Apr 2024 10:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nc9Zjp7K"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9B613D53C
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714126434; cv=none; b=OFVU9qYqUoMghMVhAwBRpRPzAyn8vN89vwu0tEIXmU6V/RmsRWpH31WDyvsCiLvNyP30HdGbtcZ6Dd6R9VGobkglaZAMQXAOiPjlYGg4LEkUUar9ZlwhsZak7lY8p/GWI5C3yyBAT8PF6aqwTq6QHI8j+E8lWLB3NzzU0udeB0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714126434; c=relaxed/simple;
	bh=24kJE+8eVc4ogyRndMk8jZL6OfEUwakFZ92WxqX0NX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s59bvOHzJeJy4qBXNiF+DXgFCpIoTd0BpIM4T0XL8kfFmNxDVSRJZ3bESOvLSy3KNLX8k3q7oZguLrQ1vuYbbpTnvbH5iY0mGXNZiFR+sPgGmr3cNwE9TMjPRjEdJ6aw+9k8dWVCdgEgN1h8ti3y97AKdvL3fudEH/72cmpxhy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nc9Zjp7K; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-439b1c72676so317141cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 03:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714126432; x=1714731232; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J/LwG0GvPr9JWPbmW+g/6YHRZg+/MP5hxVTSkmO9J3A=;
        b=nc9Zjp7KEi7GifK5+kHhBitePNyV57j3EF376yI7+L1kSzLORc7SqsJtWfLJm0/9p4
         710HrGm+SsjrBqmr9KBiDL+pSJyerwp4v5rTSW5meWDdgv6kABoFFOfYWccQahrz67Tb
         ZN5xb4M2knfSGnFyX/QY7C++mS6F2PCXctYzK0q7Ffx9LJ9tEHicbZ9cT4zHfBAzLl8/
         LxG0ualS0gqM6n1GtPZQN7IVtw/yIzNMzmeHTvRx6MhYE0j6W3txybUOYDO5amzMEeA3
         Q3+hbR9De/eZ2utXaPGDTINvSNmPFLyecOOPS1KL2Ctub76ckHXHD0HNi0qILF5INxKV
         nb+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714126432; x=1714731232;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J/LwG0GvPr9JWPbmW+g/6YHRZg+/MP5hxVTSkmO9J3A=;
        b=px/mDggZouYkX7mB2nxWx8SBDBaBYChXys6+uKJl9mUlsG93iSGWHktrZgkHHh1aUF
         CtHNvfhVeoueaGvfj//rdaIm6EebeyK9VAYN6e0j5f1wVeH9mggYEKAotoOdU++P31he
         qaKqCFiEivkAnjKZuvV5F66zbV3+aUisU/0TmKBrD1fXDRftlrFIzgVP31Lu1YP69e97
         t0438AuHzjbGLGURowSLTOEx6Ljn3S6ecbSCkpzpvGaNGMkuJrFnFRkuEV/LJqLDJklX
         wUx1XIlSCmLHXuIjVGhmqqEc9u9UB1jdRneUgWuimqSuP5o/J7AuubSoZNQ1f76Zir38
         mrjA==
X-Forwarded-Encrypted: i=1; AJvYcCVpF2aJR5p3qpQhfd9fpHjY1tFrfkxedfd1AJjHao04KSQ5cp0aaIPnj1K9FNMExk/4O3YwCUb42HU+r51CKBl96taSApFLBOYBz9/Y
X-Gm-Message-State: AOJu0YxyCiQIASzO4qn9w65ueU6pKKf9W+e43bsxQMRHj9n0Kp42Fsnz
	W4FsObecWR3dLnT1mVnDtWHxD/XGlM9KyqiHrEpLP1aReFkm5wEkocesTiJcQKPizd5talYEqO4
	zlCwSOLvWf1yGBGSfnsE6G8UHs9NrkY5AUTRh
X-Google-Smtp-Source: AGHT+IHi71L9eDaKtkraqMxL4gEt3ivysSLcXt8Ec3WGJM26HKGhUUS6XNYPVxaBjwiR90EFu0IelSE7k4TA7wxOP9M=
X-Received: by 2002:ac8:5809:0:b0:437:8ba1:ee1 with SMTP id
 g9-20020ac85809000000b004378ba10ee1mr225334qtg.5.1714126432301; Fri, 26 Apr
 2024 03:13:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240415-kvm-selftests-no-sudo-v1-1-95153ad5f470@google.com> <Ziri424B_R9GXA9Q@google.com>
In-Reply-To: <Ziri424B_R9GXA9Q@google.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Fri, 26 Apr 2024 12:13:38 +0200
Message-ID: <CA+i-1C1SoXugro50OO3BJx17Ea4VtmGNZ29YcatHVAQ3YO+sKA@mail.gmail.com>
Subject: Re: [PATCH] KVM: selftests: Avoid assuming "sudo" exists
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Apr 2024 at 01:10, Sean Christopherson <seanjc@google.com> wrote:
>
> On Mon, Apr 15, 2024, Brendan Jackman wrote:
[...]
> > +     function maybe_sudo () {
>
> Any objection to do_sudo instead of maybe_sudo?  I can fixup when applying if
> that works for you.

Sounds good to me :)

