Return-Path: <linux-kernel+bounces-87544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B1E86D5BA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:09:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 930291C2381C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB70154E85;
	Thu, 29 Feb 2024 20:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WZlyskx2"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74522154C1D
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 20:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709240202; cv=none; b=s5raDSmgnUml0ad6kREjzpt7qEau6j1O0084QTHsB6eXil+n9ZBP81ySlae7kI3alv2jFpf1GfHw31HMWt+I81yVpp4WJ31osRJTNl8jmezJ5ABiQY7Zq3I1eI0vyn7zboOXucfpTon+n8kC8PBJwR2Uytn0krGmXoLKDaJkfDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709240202; c=relaxed/simple;
	bh=y/PBEgT7ogzDQ/urnqR6G19WU2LN1p109s1hDqmO6oM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JBTNvu42m4VgnngA2UNPZl2GZoGpZQaH/tCnlXsllKB+GYsZ6wibx32q8os5BfWaiY6SMv4F4LmZoFh919FA4zqMvzur/JbwFytuHDhW7c6XxtCRO6NGyRTzQZSzkFrVoTv61Gtp1zjwph2XSAwhVQkOpJpH4NlSM4E9VXnZYZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WZlyskx2; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-563b7b3e3ecso2302096a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 12:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709240198; x=1709844998; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SbiT+3jQ0ttBc0H4Cz/BNQ+s/TCQJGrbtGrlFN7KUM0=;
        b=WZlyskx2LN9gbuLSAejuGCFL6C+JLTkBU0Vn5W7SgkoCsKOTelTTHb365VMVXbjgXq
         xy4M30IslrKGLEXww0LDLQBMvH/WLxIElr2sx5ywIse1rb2gj2+9llIOO7U7krH6QMcU
         5IEmYSswdvs6X8jioeqVJI8F4sHna+4/VZIbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709240198; x=1709844998;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SbiT+3jQ0ttBc0H4Cz/BNQ+s/TCQJGrbtGrlFN7KUM0=;
        b=QKWZS/rVSevX01JxDZZhgS5i3SJOqzsMI5Hl8B1pRGP/mTMKa6r86t3xnodEPb0iLR
         xyix4hJ8j6EffA9mH1j+zC4f7+h2mH49TG7ZKXjFbNY7bLUvV/OXMmRUcsqSYS2hdMwG
         RVDARC5EJAJKukGfJWe6PstAS23P40rycW08KQOBKxOIMczGvMn+XC30mVucs5yvXE6r
         WrJq2yxbvkzjgl156mhSiRTCzJBS3//PSHVSLjClncTzf1sgWCOabKM3C72dyTMc7+BZ
         gDdKeF+2VFVJVktpRBnyor48Bu02tAlmCBoX5Z5mqIT6U0k80qFczWoX7Xvpgt0O0xzU
         xQPA==
X-Forwarded-Encrypted: i=1; AJvYcCVWR6ffm2u74NxFB9rWUu6ouomA5KrFOVjTfwtyHkKJXzKAGIuWnak+k7E/H0WyozjMJhxXl3Ll8JDFk7PsU1wzmkzCIDWQ/5qJtdu1
X-Gm-Message-State: AOJu0YyJIWWsc39kwfsfRqptfR1Jz9j8OZKYtw76sDdrIjT+Di1ED4BJ
	PzTVtok6vFAu5xQMBENHkiMh8CIO7N5oRVOkhVlBFjfHXMnSzP49cSyRCCTEcSUnl4hekyGm6Ff
	XOSqWLQ==
X-Google-Smtp-Source: AGHT+IEpzcvW4v4lMfNVFmL/2XXke421bqaiedDFcaGuua3ZFAzD02qnA0rO0ro57/kahYku+pieXg==
X-Received: by 2002:a17:907:bb92:b0:a3f:4eaf:ec66 with SMTP id xo18-20020a170907bb9200b00a3f4eafec66mr70440ejc.25.1709240198603;
        Thu, 29 Feb 2024 12:56:38 -0800 (PST)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id j12-20020a170906094c00b00a3e5adf11c7sm1020269ejd.157.2024.02.29.12.56.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 12:56:38 -0800 (PST)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5658082d2c4so2109415a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 12:56:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU1HOeDIZiMKFVvjqRmYAe8AAbMg4djMdFkOvRFB3ILmiTwq5KYOWlu3OrPtFt0Xnv+plZdlwsGAxZM5eb3bbqdZJt2lBnaiSQoGOTJ
X-Received: by 2002:a17:906:40d4:b0:a44:4d9b:9062 with SMTP id
 a20-20020a17090640d400b00a444d9b9062mr58037ejk.69.1709240197809; Thu, 29 Feb
 2024 12:56:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229203921.3037023-1-kuba@kernel.org>
In-Reply-To: <20240229203921.3037023-1-kuba@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 29 Feb 2024 12:56:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wizM+YawbbsvdRnFXLipMXS+iwgD3fahUu4DeyQCKzSWA@mail.gmail.com>
Message-ID: <CAHk-=wizM+YawbbsvdRnFXLipMXS+iwgD3fahUu4DeyQCKzSWA@mail.gmail.com>
Subject: Re: [GIT PULL] Networking for v6.8-rc7
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 29 Feb 2024 at 12:39, Jakub Kicinski <kuba@kernel.org> wrote:
>
> A few hours late, the commit on top fixes an odd "rcu_dereference()
> needs to know full type" build issue I can't repro..

Ugfh. That change literally makes a single load instruction be a
function call. Pretty sad, particularly with all the crazy CPU
mitigations causing that to be even more expensive than it is already.

I really don't see how that error can happen, it sounds very odd.

Oh well.

          Linus

