Return-Path: <linux-kernel+bounces-90530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5247F8700C2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7DDB1F21DF3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA1C63BB37;
	Mon,  4 Mar 2024 11:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zo+HMnDd"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D520E3A1A3
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 11:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709553017; cv=none; b=nCpUSOcBVAXu+bOAHs0PBjGYQo4gwzOlpQn9EXbXshODdvCM8mH3a+DD0QnRYD/a/EIHM6sbIOr59690kWF9w685pJawNOx6+gx/1zUPSCLzsLlBJp32aAaaJ6YlCT+E/y5DdWB7XwmyNiZdXCWBbWmi7rVr7XOj3aHrwwBrxeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709553017; c=relaxed/simple;
	bh=mJU5nUSzPa150Y2o3/O+RbOgbwdMmW8u0PeQCQN0sos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ivzu3UMdR3iU1LDoFidJfzkofmso/hZ9EggQrPDgtyfjtjqe6I/E6zJ47959MW1X+QZdRyRagoJ7maGMbUNEVKYFgkLsga5i03r28FMVDI+ShHqylAF49NBcTq1fs0ILm3NFquUCx9gYRSapydw2L9j75Sc7crrZub4ir4C2hR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zo+HMnDd; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5654ef0c61fso26204a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 03:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709553013; x=1710157813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mJU5nUSzPa150Y2o3/O+RbOgbwdMmW8u0PeQCQN0sos=;
        b=Zo+HMnDdQAgAtgSmcp62dOO9G29r+sj41JzHz0Vx5ppgJT2yDp6MvDidxa8rg7i1wl
         SbEd3CMNywvstlOfKHFXE8ytSwFuRPjvZ6r07rT/P5kiTN6v2GFKZgfeRyxPzKNg8Fap
         5AqgTx8Jv+Bb2AAv+6yRG5ZiKsN/fkygWpK9dy4NkqraPIzKTnoxK+JwaUQAvzlbidFo
         ghEtDulVJKTuTpeVMX6oq+ZIYiNwNNAOdPaB/aWHmvHaIhIRDxq9WsSbMEtNZ0n44jyK
         O/E7W3GY1Jmc54e63RQDLUtHAJ+qzpqD7vMf4/bycUqtG1/FgS5Pfaq0Grvy++IOw4Ec
         7otA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709553013; x=1710157813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mJU5nUSzPa150Y2o3/O+RbOgbwdMmW8u0PeQCQN0sos=;
        b=xRLdeAEE3gyK6KQzaNXFZlewAmzV+delBqpmarr19cTnacnyBWV4go8vaerySQu61x
         Iz1KJbbHwTC0Ej1tfmNcRJijL73zEabMYx4GZCxs65KMuS+BbE9LiLYXqDNdimnRRxZv
         uJcCE2dIUVHUM5aWNcdm5Cb9PahDNcEuN3eVBRwGJZna1LTSV1Y3IBRycOkHCJAdDo3y
         SdfkFnAE2RR9+mpKMMI6ji5wzC0BNXQ2L9vwKYKZBc6DalndtGQ0/FnGC96bPFlU+TYh
         ESj+tsI/reAlPQuSm9/IKVWCH7/+C2XT1wEEyXbhB1PXicFKwsnxpPSL6FCrXWNlX7pl
         Fx/w==
X-Forwarded-Encrypted: i=1; AJvYcCVsAQEiigvA1zNou8l6UH60Cs5o8D4N9cUG6J8+Q5vxZ+ehNyuaUJiHYkkYU1p/Mvw+hme4vKlzJR4b07PSpwcDIbo0bMmSfkXtMyf/
X-Gm-Message-State: AOJu0YzY1O2TWJHKK6cSfqY2hDza9WLDHU0Fs/qeX1OzUxA/s/QaKL0G
	ZcK+YMxIFfn56rjrcdbCbfqS8436xOp0Dvvi2gVQ4uoUZjEQpHH/eysT9A2xBxvPzeVJc+o/lHz
	JCo386sF9PSjdVbEfMdbBS6XOoHeZ9mVwXj02
X-Google-Smtp-Source: AGHT+IHGikDpAWPtkW1MHcYlpXQ+/3kLXkjdpmD5O5eEOjwLCn0HuYfwKgVPhe/cSnxiX0bo1EootWnAzHK3mn0uyYQ=
X-Received: by 2002:aa7:dcd6:0:b0:55f:8851:d03b with SMTP id
 w22-20020aa7dcd6000000b0055f8851d03bmr368842edu.5.1709553012918; Mon, 04 Mar
 2024 03:50:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AM6PR03MB5848BD89913195FF68DC625599232@AM6PR03MB5848.eurprd03.prod.outlook.com>
In-Reply-To: <AM6PR03MB5848BD89913195FF68DC625599232@AM6PR03MB5848.eurprd03.prod.outlook.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 4 Mar 2024 12:49:59 +0100
Message-ID: <CANn89iKzGS39jLrRszBLh6BMyYykX-d_n3egdDU77z_fcXbiXQ@mail.gmail.com>
Subject: Re: [PATCH] inet: Add getsockopt support for IP_ROUTER_ALERT and IPV6_ROUTER_ALERT
To: Juntong Deng <juntong.deng@outlook.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 12:33=E2=80=AFPM Juntong Deng <juntong.deng@outlook.=
com> wrote:
>
> Currently getsockopt does not support IP_ROUTER_ALERT and
> IPV6_ROUTER_ALERT, and we are unable to get the values of these two
> socket options through getsockopt.
>
> This patch adds getsockopt support for IP_ROUTER_ALERT and
> IPV6_ROUTER_ALERT.
>
> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
>

This looks good to me, thanks, assuming this is net-next material.

Make sure next time to include the target tree (net or net-next)

Reviewed-by: Eric Dumazet <edumazet@google.com>

