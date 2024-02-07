Return-Path: <linux-kernel+bounces-56852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DECE584D042
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39E89B2260D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F79383A1B;
	Wed,  7 Feb 2024 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="FOeTtVQT"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C387C839E1
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 17:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328672; cv=none; b=jGAVyWrU6v2ucmK+5SgmKos7e06aE1bN+opz4mGjUOU2TABjPktFuQrHzCRD/VWjYvFHvfbIqOXCcjcFyRtZq68CFqijRBYcgZHDvVcEWtyS0S+R1Ca5xYL/tZev+Eyuyb+LkhRb2DzhoovWnKvChQEDND++QE0BAGHIsh9SNfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328672; c=relaxed/simple;
	bh=cRRJoxkRzUXRvLL7R3KphPee6imOsA+kZBjZd4YXNoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sWzXrXX4T+hELMTXQ4FgCv9Y4s9yiH8k3xZWtNtlS4EiB1oEW9fh8CPPaxBCKoZ0FNPwIcnCBXhEnKZVDS7vxndadN6UnnSElFA15DocqE2VyBbUIbHAEpN+jWaKNGM5nsWp46RC+5/PQtmwtira1LfAJFsnwQ4LFezD12tLNKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=FOeTtVQT; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-511490772f6so1071112e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 09:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1707328664; x=1707933464; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+D67kFPKINWDXTANYzDAtf4PxKO+gh9QVFhv0sOkzl8=;
        b=FOeTtVQTlT1j82Z6IqQ0nDXwNu3pb+VHp7soJPOC5qzkldGPYb5qNTHHrQXNoEQil6
         ULlvuJYJDjM0i7x1bf8lhJFhzSYPjH+xRzOQNz4K66Epxd/vy1pNO8mDkIg+2f5X/kxZ
         kl6iu88kXjxVKOffUDOZ1XTT7FAh6UXhr93nA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707328664; x=1707933464;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+D67kFPKINWDXTANYzDAtf4PxKO+gh9QVFhv0sOkzl8=;
        b=SVHguiN1sbe5wMeT4K2kzZPopXCBQS8o8JwlDA8NmsqjI9qNBi5zVeiHVbE31y1bwG
         5+twJlZ2KcOIDqZwcarPbpQhjmaxPYFsominljSakouf+F31K8Rr16ghpprZ9BFz2aUe
         z0L7Lh/YYTRbjtBPhl+5uWbZ417bGYx3o4mdi9gJ9At0w4uoejMk7I3yp9CURRtuDKAO
         o+5w2pCO3DrceFeiDDz8V6BprnHZtxH8pxMDhtiA6WBwvQj9063yqZpEgpImOyW9AMbi
         Rw9yWh1xD0j5TFrI84k0EPlEUTnoWh9E/lqBGHSwqq3jZfQDjJ32fYMskbCkJUdCxRx3
         XytQ==
X-Gm-Message-State: AOJu0YxJid1uhut65vt98AGPRdOZL7JQpVYo26IImZWeoidLwoneMt7Q
	wt9Uj+4f6jlERX6dJdWDc7tRCn2hFdhlBrZnknAbslFwRasZlL0mvFbnm95Lh+MLuQDAKBwGrVq
	g
X-Google-Smtp-Source: AGHT+IH0NMfQWsShT4F2JN9lYML/bAp79Q0dWeDdbi0eE2kF0ltx5N6oLaPJDp+UACNiCd09dlHCAA==
X-Received: by 2002:a05:6512:2204:b0:511:62e0:21c3 with SMTP id h4-20020a056512220400b0051162e021c3mr3563658lfu.49.1707328664725;
        Wed, 07 Feb 2024 09:57:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXNA1Ay+Ck8/JNkwnK0bbSQFkJu/YLulLuQ6iSFQS7NShPrtoKMF9dJbbwgFd88eX32FfrJL2O291J9yStgcq3TtnAJpAntFt0VxLaP
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id d22-20020a05651233d600b0051161096100sm265744lfg.31.2024.02.07.09.57.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 09:57:43 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-511234430a4so1821247e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 09:57:43 -0800 (PST)
X-Received: by 2002:a2e:a792:0:b0:2d0:be0f:96ff with SMTP id
 c18-20020a2ea792000000b002d0be0f96ffmr4990992ljf.17.1707328662807; Wed, 07
 Feb 2024 09:57:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8fafb8e1-b6be-4d08-945f-b464e3a396c8@I-love.SAKURA.ne.jp>
 <999a4733-c554-43ca-a6e9-998c939fbeb8@I-love.SAKURA.ne.jp>
 <202402070622.D2DCD9C4@keescook> <CAHC9VhTJ85d6jBFBMYUoA4CrYgb6i9yHDC_tFce9ACKi7UTa6Q@mail.gmail.com>
 <202402070740.CFE981A4@keescook> <CAHC9VhT+eORkacqafT_5KWSgkRS-QLz89a2LEVJHvi7z7ts0MQ@mail.gmail.com>
In-Reply-To: <CAHC9VhT+eORkacqafT_5KWSgkRS-QLz89a2LEVJHvi7z7ts0MQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 7 Feb 2024 17:57:26 +0000
X-Gmail-Original-Message-ID: <CAHk-=whSMoFWCw=p1Nyu5DJ2hP2k=dYmPp-WjeY8xuc7O=ts7g@mail.gmail.com>
Message-ID: <CAHk-=whSMoFWCw=p1Nyu5DJ2hP2k=dYmPp-WjeY8xuc7O=ts7g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] LSM: add security_execve_abort() hook
To: Paul Moore <paul@paul-moore.com>
Cc: Kees Cook <keescook@chromium.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Eric Biederman <ebiederm@xmission.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Feb 2024 at 16:45, Paul Moore <paul@paul-moore.com> wrote:
>
> Okay, let's get confirmation from Tetsuo on the current state of
> TOMOYO in Linus' tree.  If it is currently broken [..]

As far as I understand, the current state is working, just the horrid
random flag.

So I think the series is a cleanup and worth doing, but also not
hugely urgent. But it would probably be good to just get this whole
thing over and done with, rather than leave it lingering for another
release for no reason.

                Linus

