Return-Path: <linux-kernel+bounces-135079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87ED389BADB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:50:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 282D71F244CF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1531B482EA;
	Mon,  8 Apr 2024 08:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NjVMjrrg"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA1C3CF6E
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712566149; cv=none; b=sijaSEx6WDwdkwnFDeKInHZ/M6TltnqHcvaE8fc3Ms1Dr9yd+YM0ki8ntw+hpigkF+4Xzw18LWix7UPucn65sqKsYF0MICGsGXeWrv30byfkA3i06h48cx141S/46KBDArCoIagAWwe51epJuyyZxY+pMSmffBU8AL0Akt2erug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712566149; c=relaxed/simple;
	bh=qk384UZkGNLLAsDD8kmEMmFKNuSIOzMeOWQVc+z0NsI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u1tgXB44U4JQIu1S9PtfSmoDb4csQGyWPocW695Y1Q481+uo7tQ+9J79yHpeZcO3rYKyVB2kHAcvhnutuFLfDLGypRop+2LKVUqJKZrsgVHximtiAs/n9OYh/cqOzJmQ7lDiHJSW+I4IDY9wDTCukB06Uk7XsnmbPH8Weorjmiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NjVMjrrg; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-56e67402a3fso3453a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 01:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712566146; x=1713170946; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qk384UZkGNLLAsDD8kmEMmFKNuSIOzMeOWQVc+z0NsI=;
        b=NjVMjrrgAYcUbAQbDcF2cD1cx04DKZiLHBmMva/472603Ya8XPok1ngsOJ4yn9x6Mz
         +a6mzGCV9kQScBi30tqBJ/AAlp5vExKkvuAWbKBA3qDsRPq15GawToPkndvoPpdEyuL8
         QsOd9ZRw0OssyeDQ/2wygvJnunbW4wqhNHTh2ScLA4UUqcK/uwR4h0ygIkS+f0gBJBZQ
         QfehSLJgo1Fq2uW4h9T3fzYvEwovlS4wQXuW8N2WBAwKfO3cBtiUctU/xkohZXKb23bt
         qPSC00FZwe3PlAyPEUejLssibFx2Wl31I+ttq/pCUM00U8CXtRtExXvw8tzsKF7JHyxX
         ElUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712566146; x=1713170946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qk384UZkGNLLAsDD8kmEMmFKNuSIOzMeOWQVc+z0NsI=;
        b=Wu7fakjV+pCFEkH6wVQZ0772Gn9LI4gVotsB1YPWO7P5szkISFXNwXnxe1vI9/ZXfX
         G0K0pWS1vDF4i0du8h0KG4FxX6VnJ8Pas2ESmQy7SPs/ipJtSoD4xCJ208BR+VfrXG98
         FV053h2M6KHTykqUqjKCfCpJ8zBDobyz6puLU2fEK32Z+qnz2171EcoVNlYwqOSy1bR5
         9qMWXGyBSQsSgmGUsN2SW9bFZlO7zy1PImMEqIptqJWa89uTENK/FRquqC4Q986B4IpL
         bbsbp+Uo9No3b9mESDts7JBPQKz/+ao8ANPeMPOaxkMQ/H8qQ4qxBcc73wdg3IW0pKdJ
         64UA==
X-Forwarded-Encrypted: i=1; AJvYcCXVZrG7qgD9h/mJuCF7bhN/M0b+OBrjcf2A1PstMtxeC+ahJPQa9zPRUdLjmJQ9x/+Opq0J411ZTyBnrWkiKhJJLKTfHnaDSfw3XkfR
X-Gm-Message-State: AOJu0YxFB60hgPFlnZpm4a9t6qwByNon9VQI+YG6EQavn+Q+kX3YLDk7
	bU4mzO9BUV4hoYROBWuCwHUuwTa4AgUYpUQBuICgUIfByXLtdbzF05L1USowmyO0P5zmaJDASuT
	OSJqyczTS2o1KryxAmdsib/q9XFXAsiC6EGx+
X-Google-Smtp-Source: AGHT+IHGcxWs46ANJxw2uSFRtg8bF/2lxfPwMjb+NDh5MifxPLfuFRphUKD9AyWL3/zuCKZmIYndURJdF+eAmw7MBH0=
X-Received: by 2002:a05:6402:542:b0:56e:ac4:e1f3 with SMTP id
 i2-20020a056402054200b0056e0ac4e1f3mr207761edx.7.1712566145676; Mon, 08 Apr
 2024 01:49:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408074219.3030256-1-arnd@kernel.org>
In-Reply-To: <20240408074219.3030256-1-arnd@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Apr 2024 10:48:54 +0200
Message-ID: <CANn89iJ8h+RTAnZv5EKFg6+fNU_AaH_cYOv=o2RJxtMuYWJiDQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ipv6: fib: hide unused 'pn' variable
To: Arnd Bergmann <arnd@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Arnd Bergmann <arnd@arndb.de>, 
	Breno Leitao <leitao@debian.org>, Kui-Feng Lee <thinker.li@gmail.com>, 
	Kunwu Chan <chentao@kylinos.cn>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Ville Nuorvala <vnuorval@tcs.hut.fi>, YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 9:42=E2=80=AFAM Arnd Bergmann <arnd@kernel.org> wrot=
e:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> When CONFIG_IPV6_SUBTREES is disabled, the only user is hidden, causing
> a 'make W=3D1' warning:
>
> net/ipv6/ip6_fib.c: In function 'fib6_add':
> net/ipv6/ip6_fib.c:1388:32: error: variable 'pn' set but not used [-Werro=
r=3Dunused-but-set-variable]
>
> Add another #ifdef around the variable declaration, matching the other
> uses in this file.
>
> Fixes: 66729e18df08 ("[IPV6] ROUTE: Make sure we have fn->leaf when addin=
g a node on subtree.")
> Link: https://lore.kernel.org/netdev/20240322131746.904943-1-arnd@kernel.=
org/
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

It is unfortunate we add an #ifdef just to avoid a warning.

Reviewed-by: Eric Dumazet <edumazet@google.com>

