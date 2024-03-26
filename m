Return-Path: <linux-kernel+bounces-118455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4458188BB2C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 007D22E2DEC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3A2130AD3;
	Tue, 26 Mar 2024 07:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KH8Ar3YA"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7CA84D29;
	Tue, 26 Mar 2024 07:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711437961; cv=none; b=IMf5QXRsnAaZdfZ7stMPxhxiP6oJOHHKC8n01imG9ZgAUInAmGjrm1T68NvK62D52r46juCoNhA0DwK4Zfaj59dXwTrFwOOCGx/ZYLxOQeTUBkBMR9VZo6XRX1X491YaN9NIBE6d3zBydQ51qFHbWXaZXHJZ8/1uLVfNbPFDLxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711437961; c=relaxed/simple;
	bh=SeCIcmLMOaUBgNiXSvNudTBS9oS1ouW0sGgPTGoroXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=egFdSA9Jj3dtWmMVcEJfBXKIkTE2lOw2bRAacU7ApKrMX+tv1zhe85GuoqCLWgahdo1yBXAvumhIyu6BRhgPaLM80WNSYzTrOOHDYGP7w5NI4YMgPeEZgBFQ8Etg3hPTM9D0gBfPxSwfNIt4tMdXnNbG7XZKNiIX1FqVI2jM5Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KH8Ar3YA; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so10363679a12.1;
        Tue, 26 Mar 2024 00:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711437958; x=1712042758; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4hi5QonY0g+Isq5nzA/ob2FDC2jX5Rj8a6cVlwQSo4=;
        b=KH8Ar3YAOqJQsv7FpVJtZk9PpVZT4f8NeqIv1ZIaafrBac6x1vklaFd2UUvWOcPNRI
         YRXdleNkEsngFueCoAAEYZbK9BDUBsf3TiuNBLlr2vvhi3cXYE4+brKVNv2xIw63ejTh
         M163g6GCv9WtJyGnCuft8EEs0H8Dkm5O+C3E2cFPwduKeWije36GA3g9ZuR9V5TyH7Kh
         sJbNMb2oROw91yOztBZ/JVBsvtRQxlbbPolqYmQzUEdJD4VZG4FidGXN/lMv+yPH0CUn
         P+hkXJlGJbiCk0etQ6WF2sLKtO1zRqufRdMrC/3EO69fedM9UWXbTqHEMhpF1iRGnYRr
         M7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711437958; x=1712042758;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r4hi5QonY0g+Isq5nzA/ob2FDC2jX5Rj8a6cVlwQSo4=;
        b=iC/2jRhNaNPQk9p8MgoJC+ZIrlpamSn5ZlLVkG0AWCaC0L5JHirlHPOp+/kxlrzEQa
         JvZ8lMD5wvZwY60UqkjNLJc/r41m/P2fCjK8gMe2PgWvLxhHxF4WI6KRKJKLb+4EqHkv
         zliF4hVb33WbEF723miiGeIIVEGNMsUb3B/+9OxGBiNiXA7EQfXCV9fufvYTWUYj1yma
         b2Ezr+/M/cpDu3e/AgiTG2EenJbkgzzbgTrkr+/UzuNB/+JeEpnlOSJT+YdrWbJD2tTf
         ubYJRUAJKAC1e7DAr6SYZHKXc8h8rrxGPcrCcBgLhjVW4hNs9QwaSKRIKzjf1/yszYIe
         jCbA==
X-Forwarded-Encrypted: i=1; AJvYcCXCxrnC0JJsACBdQD7GvQw8FjZ2KvACzLvpmw9yVMjR9D4Tm80Bqfl4R072g+x84okf6bJeYkvtu0QdSjnlsbY0tO3muVdHp34aznjjcEgY5jkQvfTE6YlyFVrjOYqjeoOVsh5Chy27eyNAfIX0b2k1iKjF89JS1T0INuP44NcVi2cVZgUGIBUj
X-Gm-Message-State: AOJu0YwsZq6+70gXVKKnG7yuIvvXiPmalnCRi6J24105H75IhEO7dpzG
	94gDK9ebE5ihIYJDl2HoVgGZMf2KYPPEyupTO+L8F5MBCT6Dhj9MZzp0DzfUJW3WwRJUHCup3q1
	p/peMKgxZGGhpwzsrc27DjB0uBAs=
X-Google-Smtp-Source: AGHT+IFYsWLrSSReNHOvPWayY/EjNwUNTMWpQJa/7aPbmuCl5KR+IqtJTsrAErsRVn1dbGfKDXHMYxGjGNbT8pQoL+M=
X-Received: by 2002:a17:906:b10d:b0:a46:ebe6:742e with SMTP id
 u13-20020a170906b10d00b00a46ebe6742emr469183ejy.23.1711437957891; Tue, 26 Mar
 2024 00:25:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1711361723.git.balazs.scheidler@axoflow.com>
 <34a9c221a6d644f18c826a1beddba58af6b7a64c.1711361723.git.balazs.scheidler@axoflow.com>
 <20240325192855.1fb3c331@kernel.org>
In-Reply-To: <20240325192855.1fb3c331@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 26 Mar 2024 15:25:21 +0800
Message-ID: <CAL+tcoDXHSMmqUeuMSSObco=_2Vr5tDSRFzXUSsAneOP314jqg@mail.gmail.com>
Subject: Re: [PATCH net-next v3 2/2] net: udp: add IP/port data to the
 tracepoint udp/udp_fail_queue_rcv_skb
To: Jakub Kicinski <kuba@kernel.org>
Cc: Balazs Scheidler <bazsi77@gmail.com>, kuniyu@amazon.com, netdev@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Balazs Scheidler <balazs.scheidler@axoflow.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 10:28=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Mon, 25 Mar 2024 11:29:18 +0100 Balazs Scheidler wrote:
> > +                memset(__entry->saddr, 0, sizeof(struct sockaddr_in6))=
;
> > +                memset(__entry->daddr, 0, sizeof(struct sockaddr_in6))=
;
>
> Indent with tabs please, checkpatch says:
>
> ERROR: code indent should use tabs where possible
> #59: FILE: include/trace/events/udp.h:38:
> +                memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));$
>
> WARNING: please, no spaces at the start of a line
> #59: FILE: include/trace/events/udp.h:38:
> +                memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));$
>
> ERROR: code indent should use tabs where possible
> #60: FILE: include/trace/events/udp.h:39:
> +                memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));$
>
> WARNING: please, no spaces at the start of a line
> #60: FILE: include/trace/events/udp.h:39:
> +                memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));$

More than this, it would be better to put "From Balazs Scheidler
<balazs.scheidler@axoflow.com>" in the first line of each patch to
eliminate the mismatched email address warning.

Link (Jakub referred to):
https://patchwork.kernel.org/project/netdevbpf/patch/34a9c221a6d644f18c826a=
1beddba58af6b7a64c.1711361723.git.balazs.scheidler@axoflow.com/
Detailed info: https://netdev.bots.linux.dev/static/nipa/837832/13601927/ch=
eckpatch/stdout

> --
> pw-bot: cr

