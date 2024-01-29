Return-Path: <linux-kernel+bounces-42785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 815FB8406BC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 158E7B252FB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25C26312F;
	Mon, 29 Jan 2024 13:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NchS+6Nw"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3417E62A03
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 13:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706534590; cv=none; b=TJ/ODFWvmev2r//Oh4rLla1NqNvX6gsVm8armycNWSvV7zg4dl31M/yr/GZvpHKWhiht6Bbs548YiJ+W5LHFstBzGPZ6Oe3Cb6ITPS2NpnmEuLeq7NFMGMdF30GQ9pytmiP8QnJlNyQMmxpPk4vf2p/qiu+z6/Ek9VbKCBbGjgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706534590; c=relaxed/simple;
	bh=GOL4CLf7NJSi1+Yl6Eux39JaESbVEoPmfBFe2dFCDvc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JMVP6gVwCvAlc1uSnK4/EOpw9MpcLLmXGx2SX4op+ISAdVXU+wkX9410rbAQJGYX+A81zQwNc8eGgbzCq2ETNK2rgK9o6mez6kFc673452E63sfWUa/7DUWEW8qkiAeZm9Hs5MowPhfgLf34e53+NudAjfzIAKRg/Vs74WZKezU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NchS+6Nw; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55eda7c5bffso8495a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 05:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706534586; x=1707139386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GOL4CLf7NJSi1+Yl6Eux39JaESbVEoPmfBFe2dFCDvc=;
        b=NchS+6NwDS6r4IRefpKVS2LqB+DEKBdMPk/o6EJzgCS5qiU5GJ/+2zpUFUvTs366Bp
         K6Fd/27iPgaSvVbZZQdOlswH8tZ2/tKeasamnTFwcpFXemiQLl2+bMv/4H/XoQE9v5MF
         +LQQdUcZNWgfKBeI7t1fSLD3aHMl6kafZtlti8eS7UKBiuFYPLciO8wTPrnfHRTSHzzw
         xE082tsC+J+e6GpUtI0Fs/7KSFG6zno3nF8EWrhnymU/r87FSTdh1RA58ezb4Jci8/Ww
         IWjcfjToVuhAYCLLNEfb5ZFtXncb5/MwbooDB9LKorUgSXzbGsmAi3mpHMGZN7JglTxn
         jJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706534586; x=1707139386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOL4CLf7NJSi1+Yl6Eux39JaESbVEoPmfBFe2dFCDvc=;
        b=vBm50A1WUi5jdMVGxfsjZUQ2hOyIUlyxcwqgE+rvMH2hEkepLHvMNe+/uvT3H+IkDQ
         xZliN64QRvp25aWBhja3Rqpn5219ZsZGKTY6ZtWnH3kPx5Blpv//00tfWEMKVyUTkXon
         qOcHcXrokmF7HxAhie0pIgrqbjvsdn6UiUWmzQqGWx9QovAkfNrXRDqeSEne6VysCCxy
         1YHEJFl25Rv9g2CAVlvbTABqd+hVqQGuAi9nXf1OJN0/akaocrmUTWsBjhX7UvjYzsXl
         YkwXIeGGRPrzr5eGIQAyukzdVlbbprnc/HnYfdpyuRvTftpn4RbDqqH233r+VAPU75CR
         s32A==
X-Gm-Message-State: AOJu0Yya5qJhMSB/M/Q16SCRhJpHjeFGTWMM1hdIgmv2bCBktK37Jrkq
	86+SuKOqNJsPjyTX5akkbAtpcMTOEiJYG6w7agDU+aAUbu4BMoAYdbHr9eebxZWY8rRGenYIClG
	6Pj89R+j+oQrtCC7hWBUMhz1eGBAjuZ1xrazqPFKlojRFFn7msA==
X-Google-Smtp-Source: AGHT+IG1astNKH1/HDc0wBTVk6TC8yGv+pvI7UwKY5UN/sQS0hwFaBZIZw8cIgMPOsBKIZYZeMT8luqWWhKHlR6S/3c=
X-Received: by 2002:a05:6402:b9d:b0:55c:ebca:e69e with SMTP id
 cf29-20020a0564020b9d00b0055cebcae69emr482056edb.5.1706534586055; Mon, 29 Jan
 2024 05:23:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129091017.2938835-1-alexious@zju.edu.cn>
In-Reply-To: <20240129091017.2938835-1-alexious@zju.edu.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 29 Jan 2024 14:22:55 +0100
Message-ID: <CANn89i+eR_WHdndbCWCgZymB=QnmMaURKeVj-by-+=fXJNgDxg@mail.gmail.com>
Subject: Re: [PATCH] [v2] net: ipv4: fix a memleak in ip_setup_cork
To: Zhipeng Lu <alexious@zju.edu.cn>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 10:23=E2=80=AFAM Zhipeng Lu <alexious@zju.edu.cn> w=
rote:
>
> When inetdev_valid_mtu fails, cork->opt should be freed if it is
> allocated in ip_setup_cork. Otherwise there could be a memleak.
>
> Fixes: 501a90c94510 ("inet: protect against too small mtu values.")
> Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
> ---

Okay, although the changelog is a bit confusing, since we do not free
cork->opt anymore in V2...

Reviewed-by: Eric Dumazet <edumazet@google.com>

