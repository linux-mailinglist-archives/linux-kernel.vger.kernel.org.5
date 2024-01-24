Return-Path: <linux-kernel+bounces-37362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 292B683AECA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32B86B265C2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E267E591;
	Wed, 24 Jan 2024 16:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bQGuxd9P"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D0F7E56D
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115322; cv=none; b=Fp08NozcL9kSLi2tC4BUMRV7vBsmcYffTsH1ujjQ4cMKkP+O081M3qtkwWW2GSg969IQ41BOb3Wi6V+E2jy0jUZjLC/Yvpi38L2OT9RJdAQCvbfiUqfl4+hsJMYAl9G0X5Zrc/opU92XvxsAqk7rFRrtBenKEMrB8oXyb/1gMHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115322; c=relaxed/simple;
	bh=YImQJ7siYYOCy8HRvG07XXg2YFYJXgcsNfV6voSQuBo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sL3Ia4RskgFZV/npCtVFwm/0/Myt7m160mykwwudZNPIKPvaibCUCUmFsoJ7z56uhSqKVwe4lr9OhhH1S/fDgMxUy8CiVGdCLqqfMxcVy8pYy7B9jEGaQfMHe+Z6TKaDsR9J2ZldkMLIhIQyYItkxGQocwhbvyEe58/fw3Nx6Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bQGuxd9P; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-50eabd1c701so6502834e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706115318; x=1706720118; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sPdCGKuEWKXJWP2sfaXpzZkS4P7GnOGZQJx21so96qE=;
        b=bQGuxd9Pd5Eu251gHRY/VYhrZRVfccrxjdaR9APocEm/kH+j2088ARnUJEed/jyFca
         JuLOBigSgn05DcSlLsGj+BS5/VWjKL6xsG+GBZz6PE56D15v9RPUYwz/6q7jRhUS+1Mo
         CzaoXyOR4ynFgPo1x/FbQkkXmywjuzh8hAYkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706115318; x=1706720118;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sPdCGKuEWKXJWP2sfaXpzZkS4P7GnOGZQJx21so96qE=;
        b=ewfp/F3HV7nWmIOfpLioMIesuIgd9LAP3gr7YMtV1KtOSYiIlfyhCC6Sj+RxoWCaJb
         u9W+E7G40e8Tw0nZWNz8DT+eW2PIP+BTbik1JM1cL/4u2P68jTRk13zWKM3e3Tk8s6BK
         hSNB/4au9NX/KvXDzF+unQnAP73nhuHnp7kSlHndl13yhMtrEvu5+0brFNCYExYNzKsb
         t2uJ2CJvJ4hDTVnWL17boGeuGIjFsYH3hv3ghc6HeJ+bSd92dBfL/J2M8RS6PWcZy86K
         JKyQLUBN6kJ6/KPOhwrxeBARu7CncitgD3f2FZIDKbaCkvATHbzVIyixnuRrkryX+rg0
         BhKw==
X-Gm-Message-State: AOJu0Yyl/0Gor6d9zs7VEVCzX9lcsLlJ/iGcYR81MKrSw8C4ZOYOiIKL
	9KlyvRMawMt+WkyI6QTxg4BXpIoG2P29ADBmM27VpxmKDewpFdoQ4z8mEWXYHexudCK/ADT30if
	DRaFTvw==
X-Google-Smtp-Source: AGHT+IH5JpjEqwrsVc6CUwbIELEpZhT+e8unFgTKKIRUMB1EmonuRhJ/fWQr63pjh7xq4oJeGxVgfw==
X-Received: by 2002:a05:6512:3d05:b0:50e:7b02:a82a with SMTP id d5-20020a0565123d0500b0050e7b02a82amr4779427lfv.89.1706115318596;
        Wed, 24 Jan 2024 08:55:18 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id z19-20020ac24193000000b005100699daa6sm526926lfh.126.2024.01.24.08.55.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 08:55:17 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5100fdd37f7so1363265e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:55:17 -0800 (PST)
X-Received: by 2002:a05:651c:1043:b0:2cf:155e:2567 with SMTP id
 x3-20020a05651c104300b002cf155e2567mr1158083ljm.95.1706115317480; Wed, 24 Jan
 2024 08:55:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZbE4qn9_h14OqADK@kevinlocke.name> <202401240832.02940B1A@keescook>
 <CAHk-=wgJmDuYOQ+m_urRzrTTrQoobCJXnSYMovpwKckGgTyMxA@mail.gmail.com>
In-Reply-To: <CAHk-=wgJmDuYOQ+m_urRzrTTrQoobCJXnSYMovpwKckGgTyMxA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 24 Jan 2024 08:54:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wijSFE6+vjv7vCrhFJw=y36RY6zApCA07uD1jMpmmFBfA@mail.gmail.com>
Message-ID: <CAHk-=wijSFE6+vjv7vCrhFJw=y36RY6zApCA07uD1jMpmmFBfA@mail.gmail.com>
Subject: Re: [6.8-rc1 Regression] Unable to exec apparmor_parser from virt-aa-helper
To: Kees Cook <keescook@chromium.org>
Cc: Kevin Locke <kevin@kevinlocke.name>, John Johansen <john.johansen@canonical.com>, 
	Josh Triplett <josh@joshtriplett.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 08:46, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> If the code ends up deciding "is this an exec" based on some state
> flag that hasn't been set, that would explain it.
>
> Something like "current->in_execve", perhaps?

Yeah, that looks like exactly what some of the security layer is testing.

Hmm. That whole thing is disgusting. I think it should have checked
FMODE_EXEC, and I have no idea why it doesn't.

                 Linus

