Return-Path: <linux-kernel+bounces-42691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59397840515
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 13:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF422B224B9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 12:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D47B60EED;
	Mon, 29 Jan 2024 12:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="g/TARmz4"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449F6241E1
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 12:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706531695; cv=none; b=NEGCd+XPdeHmKLklyDHCpZlXPMOIQqORFD2j+b399fOicG4f7rQJNtCfOoouQjr+piJJAwqRAiB5/CHnzrsZbzab7qN/fg7Zvki4tNEbi/hOdVpPtVc3x35KerP59JsrWTA48qHz1R8Q0/A5eT1R29OEHLOvZ49jJt2jpvHdf1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706531695; c=relaxed/simple;
	bh=WCznlEBsDcJ4w6nek8MJ0Kte80pdPo1Tji9v/NnQcTA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tBK/BG/4ytTWd9hjxitT/TFHgiUVXEgst4xj/axOWgHhNWhPjrEQJZg6AF+gmiZXKUNvVKi6oLIiIc5UL8uKt06p1eFPOjBLxInp3HkGUoIsm8RppHOA2hErTGURDvyQMmQ1R9HiZfEQ7ZX//QfAikPLiyWLl43RlC2j7CUGwOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g/TARmz4; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-55c24a32bf4so12719a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 04:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706531692; x=1707136492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RtTiJ+l2KgzEu48Tog5tRcF/hIqq1A5D/kAMV4wmY9g=;
        b=g/TARmz4LR3Xwd3PzoSQmEoaZ4J0ZVoLVZestpvQ3DPoTsxciQooymtBDL9aaq8caB
         tahQ5Tqh7kW8OLEGzYiVvYtuKl+IWf7rpdTX8XlE2D0ANMCNwigcidXgeDwobige/KSc
         0j9tBhMimPfdloj4oPwtviy22YQUkW3nHUw1rCzHobjXnwsBw7BTEFxA4OlD+hCXtADJ
         naltRW8YILSSpO5aC+unaGZxgb+N/TG8BXnyiTGwu5raIQ+/zgIn6ietWYYoo6FcHzSS
         d8SU41kvqeDa8rkAARCwdasAm3hPr9MaAMnrxhT17+VmbOkvDkHb3mCA3LTpfBJtrZLO
         qdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706531692; x=1707136492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RtTiJ+l2KgzEu48Tog5tRcF/hIqq1A5D/kAMV4wmY9g=;
        b=c+b8VV/lY/YgUt730el1KsuBz7H1mhjHNtmJLt01i4Ireshhd54ofDlOYj7RBef70B
         shqVMfyAGyl4vEXDbMrc98YTfOIxv1uJjXMMpAW3ehw/2GD5uwE3VNXh8fa3g1cA6pZT
         qdsLi6OyLAE5bnda6eoOHqmvv7jtcmp0/E/k6UgltFJXJlH/zNxbEiT3jolPqX2Uk4qU
         wZ1e3nhsgMJl4JnIluQd/TZ+J8oesx8cntrrYQppCe86Wp2EBC1e1d+AP9HdbMDI9RCT
         jz7hCFp5v3yDyiPYXgxaV1ecck0vzDDEguLaPqSt8VTRMxmj0/pFuha1ngk4u8Ull8zY
         kC2w==
X-Gm-Message-State: AOJu0YyVATq2Y/dmzdQqrN1nziJ4w8capEwad5+7JfEw6RLkAEqB0O0k
	xA5diNdS7JjjFQh2Vt/SMerJaDCWrssbLploOENBfR6cL3Sz48ybKfCFlA++vMztZqp9tw9icUS
	ctmtBUBoqMSk+58Yg71qYVzQ+VNhFmITCDnQx
X-Google-Smtp-Source: AGHT+IFac2cOSYnbtc5nL6f/ebKgEFYhurJcihUOwmwj6XVYapzlZkuj7gCxrZxRlkGppkax+HRVY5uuR0k9jncBC8U=
X-Received: by 2002:a05:6402:22cf:b0:55e:f115:3a95 with SMTP id
 dm15-20020a05640222cf00b0055ef1153a95mr141763edb.0.1706531692260; Mon, 29 Jan
 2024 04:34:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126040519.1846345-1-menglong8.dong@gmail.com>
In-Reply-To: <20240126040519.1846345-1-menglong8.dong@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 29 Jan 2024 13:34:38 +0100
Message-ID: <CANn89iLOx0R62gkTmk7Wq9OwnfB25a4xqtYkw712sqZeNyMRQg@mail.gmail.com>
Subject: Re: [PATCH net-next v3] net: tcp: accept old ack during closing
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 5:04=E2=80=AFAM Menglong Dong <menglong8.dong@gmail=
com> wrote:
>
> For now, the packet with an old ack is not accepted if we are in
> FIN_WAIT1 state, which can cause retransmission. Taking the following
> case as an example:
>
>     Client                               Server
>       |                                    |
>   FIN_WAIT1(Send FIN, seq=3D10)          FIN_WAIT1(Send FIN, seq=3D20, ac=
k=3D10)
>       |                                    |
>       |                                Send ACK(seq=3D21, ack=3D11)
>    Recv ACK(seq=3D21, ack=3D11)
>       |
>    Recv FIN(seq=3D20, ack=3D10)
>
> In the case above, simultaneous close is happening, and the FIN and ACK
> packet that send from the server is out of order. Then, the FIN will be
> dropped by the client, as it has an old ack. Then, the server has to
> retransmit the FIN, which can cause delay if the server has set the
> SO_LINGER on the socket.
>
> Old ack is accepted in the ESTABLISHED and TIME_WAIT state, and I think
> it should be better to keep the same logic.
>
> In this commit, we accept old ack in FIN_WAIT1/FIN_WAIT2/CLOSING/LAST_ACK
> states. Maybe we should limit it to FIN_WAIT1 for now?
>
> Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

