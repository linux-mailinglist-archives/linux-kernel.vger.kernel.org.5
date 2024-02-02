Return-Path: <linux-kernel+bounces-49981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AABD84727A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 006F82954D3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64192145349;
	Fri,  2 Feb 2024 15:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nj+niDgM"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E317144631;
	Fri,  2 Feb 2024 15:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706886026; cv=none; b=W1xK3Jd0C2BrMDa2XN/8CNj1kz/LKIyD8cTmy0zkS/foyDmCm7W+BBv9MQm+RsOUJL6mXsGtOFQj5QDj+HMbeydHWSoMj2FWID9nkBL2KUuutX0b30bz5NFynaSGXi3oonQbCAzrNpJBUO8j4Vww4t5mo90On0fj1PHi/f+dI8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706886026; c=relaxed/simple;
	bh=WZbP1dLaPMutcUZzasREpZP2p3rGSsCcBc+Uq979q1g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ck1wptpAIsKe69JvjJLwvo20/UmBBC+1nlT1XuUzVVSbUFoB3HU0BSkZYdWMjOREGlnYkfOiij6aKcymM1cqouSh/3LZCXHryXcbNewlEZFKncGqYtl8fUOjtLMtGfmnxvt/N3rSSu0YRtmI9PsjrdErXhZQioFEaM0XpYZhXmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nj+niDgM; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-68c4fb9e7ccso9009906d6.3;
        Fri, 02 Feb 2024 07:00:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706886024; x=1707490824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vqcFL9LcfGi8Mj9pGSzuHfjmAGi7kYAZJayAhZuK0CY=;
        b=nj+niDgMuWt879984HpaepronxAUPhe9OHva1sia83WV1LmceiJstmxCgwkm0lplJy
         w5EFl1hchfaLWkEFfiM4t4algNS4FrytT9FMQJRteel1477mTFmM9i+Dsr2mfgYwVKBV
         P4yvX/6jC6dNOJg4i9qNcOsn/7Kce7tJsz/jP2gf0VdOQxFgnQux7AyV45YrwXRbSMb+
         15gZVSw82tkZTEH6JIk9slU7tNuZyapkVOmB/0plY4WApVjZxBBUCymaV6G8Z+XYelo6
         9Ga66VcSJeOzAAuuP3Zome6qBv+Yx/M6N7Fep5RqrclRxxRrbu2CeGz1EiR3BLpKV54X
         6X6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706886024; x=1707490824;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vqcFL9LcfGi8Mj9pGSzuHfjmAGi7kYAZJayAhZuK0CY=;
        b=uViPKocz+9qApMnLrjRItJJgjhBWKYR3CHbpszs88dz4sxkifEEY0Hz9lNcdCZWBlB
         p6qf5r6j28wg2Cul6N/xG938lC6GQuFa0KozzHC+pztSfrgR0qLACrH/mU5jbHfsOytL
         pZtyjuaBLrReCnPzGrBARhCy+494r221mEdptnG89ABObynjn5Rl3NBuWwJ0wGznAJHs
         HAV8G3M68zpc7lWRRdWj0KpwfBVnYOtA90occk/JNKgBqWTvjwjn8moVg72lhYvMcLsM
         kCHp7GpCdGTl0m34vr1ac+T1imVzVMFdbPYZ0jNbCsVNkQ0Dyeox2xLaWKjiWpZ359hS
         CH5Q==
X-Gm-Message-State: AOJu0Ywa+UX5GwuGJ63DEV/MqMYouEm2HiKXDLu6Od3lUbZ5qWWEl9Bz
	09n3AMkyhOanh2xvoNjLlu3iDidQZzDNGh619PwhkdJent/UIPQ8
X-Google-Smtp-Source: AGHT+IGEguFVMaYEdMMhCjLVqcDY/3oxkXuCJHqK7/OB3r6k+oBUsd6Pl5F9R0eypC9I+gP+xfowDw==
X-Received: by 2002:a05:6214:5011:b0:686:ad84:8af6 with SMTP id jo17-20020a056214501100b00686ad848af6mr3287483qvb.24.1706886024089;
        Fri, 02 Feb 2024 07:00:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVg0H2l2gg9HQ7ue/58yPHeiIkcO335IigbdTch9YQmW78i1+M7lrXped1P5XrNgLdm+S+ClsPg4xWD5iKFxOUjEV3wSHmedVvxfu5KK1rSGr7IoxmHQTQAQ5CWJBnS1CAT0WVXUD47gBvkgw03/S/W2RbM+yYJr2kT6GwFcP70CR5AEa/yZC3ZNoehW0gKYqAqgv1MI6ctQTOPnpBO3NatNLaR3wWwyDwkslQ/8HlIv6w4FVM/krAWA+fEEXzwd/0UpjBirb2DDXjYTv4=
Received: from localhost (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id y4-20020a0cf144000000b0068c524a70fbsm866969qvl.66.2024.02.02.07.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 07:00:23 -0800 (PST)
Date: Fri, 02 Feb 2024 10:00:23 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>, 
 Yunjian Wang <wangyunjian@huawei.com>
Cc: willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com, 
 kuba@kernel.org, 
 davem@davemloft.net, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 xudingke@huawei.com
Message-ID: <65bd03875823b_2ef2a92946f@willemb.c.googlers.com.notmuch>
In-Reply-To: <Zbyrhnt9yAFwegSI@nanopsycho>
References: <1706858755-47204-1-git-send-email-wangyunjian@huawei.com>
 <Zbyrhnt9yAFwegSI@nanopsycho>
Subject: Re: [PATCH net-next v2] tun: Fix code style issues in
 <linux/if_tun.h>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jiri Pirko wrote:
> Fri, Feb 02, 2024 at 08:25:55AM CET, wangyunjian@huawei.com wrote:
> >This fixes the following code style problem:
> >- WARNING: please, no spaces at the start of a line
> >- CHECK: Please use a blank line after
> >         function/struct/union/enum declarations
> >
> >Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> 
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

