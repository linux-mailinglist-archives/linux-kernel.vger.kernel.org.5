Return-Path: <linux-kernel+bounces-118477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E15D688BB7E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D01229F2FF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 07:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77E6132C1B;
	Tue, 26 Mar 2024 07:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YumBn6wW"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636FC132C1A;
	Tue, 26 Mar 2024 07:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711438840; cv=none; b=JYQVpcBJBnq7XK6OLSdzSp/0xG6nxQL483E8qC5mXrfYh4K2NHtnHQugT3rx95OFkm5UiwXaSGBJsj1UCch9qK5wvLeq2IPVtN4rJxlbOZhT8eMqEd+SkbXODeNGeZGTeV4xlBb9Qbq7vJQ0aTxp58a8E0q0Z9rVKh8CLRVOdig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711438840; c=relaxed/simple;
	bh=OAj5vxYqi6Ox2sML1jx38TUCq3UEOLTHQ91aVzdlpNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ObFnfSaza4APr5ftHr0onZDZmikvwWovzcW9aWQnjGA+P3XLk2F9CLXaNxwTDKo8PVCmqX9UU9N1UG8/wz2HSV2nPW+0+gxh6tFfuqZbO6Sqdp6xJ2PvQWiAbv/PLNozBllTLj4rES537i5S1HrkrAZkHv0SIlj8QZvPg1ZcQI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YumBn6wW; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a468226e135so611068166b.0;
        Tue, 26 Mar 2024 00:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711438836; x=1712043636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAj5vxYqi6Ox2sML1jx38TUCq3UEOLTHQ91aVzdlpNg=;
        b=YumBn6wWfNNSkEFDvbiReFlVYZttlcO51m/C3OvjH8jfT9GtpegrcrjpopFMWIbrKI
         AMf8KWHMcdpLWI+TZcZ/YXqVZfati0j+Kbz9tZPs6gVmU/B4tU/vAuUoRNxsKwNTLd8+
         t1Qn2os57NDdjQBNPHKwZDDiEjDQXHSrXEEAwsUrKdCc+tdfHVWaPJzPmOQCmlnEnhKr
         E7tq1VgIpRoMjtRWkLhicyx5vTEuJB2xiMMCba2fC+N6z+PPN5JMh+ZsP/rtmEVyb/6B
         FtQ4+F9EJMtoNuSo3LQ67NLNMR19M5PyZmTcqiBNJUsHfKC5m4AMgBLkZNg49ueUzUAJ
         KJQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711438836; x=1712043636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OAj5vxYqi6Ox2sML1jx38TUCq3UEOLTHQ91aVzdlpNg=;
        b=pLy6IC4HgL1E/7MplhAafzvWiVjjkE+bEzoWGk7w1BEO03ipnjUR4rxc9SbVst/lDj
         p8iI7PFH2muVCmglSKy5ZqU5j8mO9O5v2a5DpdNTyxuBajDzR9X8s42EYVfJgPlNwaQi
         DvzB8TAyPZNrGSXsCsepF+Fd/MbAANZYvb3hr14OJupUjrmB57euqGko/62RT1RVF4Si
         2cR76Fxc9IEOUqiXHzpWoIyzuXy5aMgUrxkAQMzAbn8mTdamqTEvpF/sL3QVuICctUSh
         /9pFm6AM7XgqEw1U90Jyn9OP3olQgIdXYbiIcgHPBXehXocJtExD81V+LhJ4JP0KL1r2
         iOhw==
X-Forwarded-Encrypted: i=1; AJvYcCX0RNgZtDVlm4CUL76rEtOqGxvutS5xM93lvDRs9P47FWX5GJkGoRH8LOIqeXME+ZQ4aaSMlc8EmxQcZpKI6dUEq2YYVF3NjZSdsomuvtjqUdouS80iPSyZjUKILBqS4fXG4G2gmomRMiyOTve/4evHko7l9SwpE4YEbFhYV5atFrgbInqz3tLq
X-Gm-Message-State: AOJu0YyM93us54ziIfMbz9HBzY00lTU4x8ebFypNat7V4Iu0Jo20VRZe
	SjTljFZ2xOiRgtRfscqmkavc1oVFXGGc779wASg4N0Na8XAnxQhb56Oeb46/gyI1Rq/hYYIOtrM
	FoEzplp2WKHJbdAYfJ001JwxiKkw=
X-Google-Smtp-Source: AGHT+IHbX3kmzaNoi1M3/W6E/dw1Eaqf4aZjwDqSHfT7En//8qJqco2N34zqAyns+BUh/I9QdZy4LnL3WpYehcgpQ8c=
X-Received: by 2002:a17:906:52ca:b0:a46:be82:f478 with SMTP id
 w10-20020a17090652ca00b00a46be82f478mr1191938ejn.68.1711438836491; Tue, 26
 Mar 2024 00:40:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1711361723.git.balazs.scheidler@axoflow.com> <394f9d55197681e910d104dbd35e62fb4098712b.1711361723.git.balazs.scheidler@axoflow.com>
In-Reply-To: <394f9d55197681e910d104dbd35e62fb4098712b.1711361723.git.balazs.scheidler@axoflow.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 26 Mar 2024 15:39:59 +0800
Message-ID: <CAL+tcoAy1VU6-pMOsqSCU8EUkyo5q9SEkM=GeDWjW9Mw6os=RQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 1/2] net: port TP_STORE_ADDR_PORTS_SKB macro
 to be tcp/udp independent
To: Balazs Scheidler <bazsi77@gmail.com>
Cc: kuniyu@amazon.com, netdev@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Eric Dumazet <edumazet@google.com>, 
	Balazs Scheidler <balazs.scheidler@axoflow.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 6:29=E2=80=AFPM Balazs Scheidler <bazsi77@gmail.com=
> wrote:
>
> This patch moves TP_STORE_ADDR_PORTS_SKB() to a common header and removes
> the TCP specific implementation details.
>
> Previously the macro assumed the skb passed as an argument is a
> TCP packet, the implementation now uses an argument to the L4 header and
> uses that to extract the source/destination ports, which happen
> to be named the same in "struct tcphdr" and "struct udphdr"
>
> Signed-off-by: Balazs Scheidler <balazs.scheidler@axoflow.com>

The patch itself looks good to me, feel free to add:
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

