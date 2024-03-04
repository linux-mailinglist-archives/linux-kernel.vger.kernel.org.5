Return-Path: <linux-kernel+bounces-90109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDB586FA77
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 996111F2164D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EFA134C8;
	Mon,  4 Mar 2024 07:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZFF8td0"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5695911713;
	Mon,  4 Mar 2024 07:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709535983; cv=none; b=A6hDM9i3OJHDZToChUFseZlQGK0SCZYnA5ewgzqfUfIlQxcI8BcM0Vq6i3DImMFPD23JvbTa2v8/dKBubZ8LOsD4rr5srJ71ggDckeZn8zfZ2m/9tM+US+VJUUSO3M9mGXmVQ0s16jQh4D5f9Mlsem6eTiEFf3nuvdNHFz0vUgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709535983; c=relaxed/simple;
	bh=bu/CNzq/D3hnEEr3AOVp/iiwUc8F/2qAm4XX6DSlh/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=bzyCi6ardLGrmnGEDj7eNq6Ts8xNYLpS8UtlFCzv6iPJVvjE0gzwRFhWXq35dLyq1FYs/BieZM0H9I/SbclTMhNinauuQe0OoJxbUKpGWWzGJLstO7dJz5zU0iK9mhn6J2sz7jPIww8aMnCAy1TMUdx8sNIcr+d6e4Vc8K5/2tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZFF8td0; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-564fd9eea75so5904967a12.3;
        Sun, 03 Mar 2024 23:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709535980; x=1710140780; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bu/CNzq/D3hnEEr3AOVp/iiwUc8F/2qAm4XX6DSlh/o=;
        b=gZFF8td0dWiSNPJd00QnbzsrsZvQf0WGbxpreTEjrykWKPcfP8FlLBTZJjx59j76z3
         5klS565ryZ/hScCJe6uyyv6yrZ/o7wWZjvsmxZryni/K5k797q6GXX0Tz8o0Ju0IcVBv
         EsVCEYZ1R/xnpvpLiH+tQXioJBL21bHpi78wiuQXPDpnTOXJCuZ4UgmYVCucnyeqyNzn
         dRjkk4q2bmk0Xs4DdXqyWTLf/Hpi1XJfEJ4i93fspqyKG66c5YFNpjPtS5Dxea7weazL
         eI5kqw6i3+e5f3fS4S8n4Zbj/f4XlvbgRiFbB97+y9wj3tfi/wXSFGl5u4FhEYYXh138
         Iw4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709535980; x=1710140780;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bu/CNzq/D3hnEEr3AOVp/iiwUc8F/2qAm4XX6DSlh/o=;
        b=CoTrPUOo9XE0om33+LDQCicDy3OVjaCJbjxsNMg+/AYjgFQ8RYPJd8rRajUk/R5O5d
         jGeLv9Rn5EwkbOUtHy/F9EuCKrFxUu+OZ6d8mY5hELWQJcQhZmJze0In71MD6imMmcTK
         KeJSpfiD+lxHPJPdjT66D5o0Gc94xPIq54K6HHXino2OK0UDgOW+7q+jRyJ2yQAMWh7A
         eToA+fBt2EyuB3U0SugRv0LPphH1l63CIDsVWMdL+I2Z2/UZixTf09VSpxX9wmJdWD8a
         giHtV4eCjIHZK1KIfbFEMeU9ELvH4sL4HZbBdveCrPR0mwfNxtdg9kFPV4QhCEG50mt7
         +Kig==
X-Forwarded-Encrypted: i=1; AJvYcCVnB2OMcEUvbLfokZU4JNGiOWKHuUlkc5IMpEKO+A3u9imoYDn+IKkbJY36/E6eGJCB2eLviRxm4WXppqyPX451fPy7guPxO6YroHFeapKUaLiChbAySg9AObsIq+OEgggnjY/Dt4RAQ1Be8cC1rS3M2kxh2l65q3sZDvAzqPUnbW08zKljPF1S
X-Gm-Message-State: AOJu0YyIlBi8mABJfj7OD/feI+1CoqhWlf0aYomDGULgiK/WsDpcVM9f
	klLrROpB4PNu8Fb+clGR8IKepjbfvhawnRUEGn51WRTZHye7bSr4l95yO7ACaSVOY18qgfbSg3R
	LOeAOxRGzBPGrgSj5+X5rImkuk10=
X-Google-Smtp-Source: AGHT+IF7R4mdCSpEefF4n6saDdKVfyULSPlhKZqpG1teF+3r9bzzsrYNTGStc3z3IQjOySZ9x9xzBe2sNH5+7cPFfmU=
X-Received: by 2002:a17:906:4108:b0:a45:4416:1fa4 with SMTP id
 j8-20020a170906410800b00a4544161fa4mr1102563ejk.40.1709535979561; Sun, 03 Mar
 2024 23:06:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240304034632.GA21357@didi-ThinkCentre-M920t-N000>
In-Reply-To: <20240304034632.GA21357@didi-ThinkCentre-M920t-N000>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 4 Mar 2024 15:05:43 +0800
Message-ID: <CAL+tcoBbBgubwcghyT30Zk7g8SZYbTx1fKCvPDYqcJjQ8eGbOQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] tcp: Add skb addr and sock addr to arguments
 of tracepoint tcp_probe.
To: edumazet@google.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	fuyuanli@didiglobal.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 11:46=E2=80=AFAM fuyuanli <fuyuanli@didiglobal.com> =
wrote:
>
> It is useful to expose skb addr and sock addr to user in tracepoint
> tcp_probe, so that we can get more information while monitoring
> receiving of tcp data, by ebpf or other ways.
>
> For example, we need to identify a packet by seq and end_seq when
> calculate transmit latency between lay 2 and lay 4 by ebpf, but which is
> not available in tcp_probe, so we can only use kprobe hooking
> tcp_rcv_esatblised to get them. But we can use tcp_probe directly if skb
> addr and sock addr are available, which is more efficient.
>
> Signed-off-by: fuyuanli <fuyuanli@didiglobal.com>
> Link: https://lore.kernel.org/netdev/20240229052813.GA23899@didi-ThinkCen=
tre-M920t-N000/

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

