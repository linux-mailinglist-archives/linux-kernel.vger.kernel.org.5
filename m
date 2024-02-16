Return-Path: <linux-kernel+bounces-68785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D88858062
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56B3C1F22A03
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBD412F5A1;
	Fri, 16 Feb 2024 15:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2hN3pdbz"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A82412F58E
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 15:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096434; cv=none; b=cl+49QbDnf6gq15yQTIi/8ssHG1ZQLrdSGDLKrCRG/Ke/BJ2K209SvkDgoH9ql12gqR6gZ6JiSVwBYs9osVNnQrK2f7OFHRnDcEeOE1ibDRhSXqh7pgNEQR8gGSCX1l0Dzc7DtYPMlbEwpSMnkB43YZBGg9uqdlDYX3SGU4DjhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096434; c=relaxed/simple;
	bh=iAXmVR2EdKQ3QMpwU3Q1n+bECH3oE8QWZEMs6vIgsS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oEmGH+BPapkh2DJWxZX1ukvzic5WKxo905fd3tmhI2f8LltWXg9ThRp6yzGpRukoz12yLAHy442MrR1O7hZ2BdtwxC135/klxKWJt6Loz+GrSK+VuVRj6wvc4+TsK8M32Rz3YXmQW3dvNthjAdfTOoQxfev8KXgAblWoCsGzx0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2hN3pdbz; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-561f0f116ecso9265a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 07:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708096431; x=1708701231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZlzUsxX5xRqjM0C+rrFrgpdfv7K4hAD7PeqQ9NvpPdw=;
        b=2hN3pdbzRjrT2t6hzS4zACpsQkZhboFMeGnxxXZjgFi4fUDzNiFB9YdvKyAvNR+Bsj
         QpfoTZHwxjmRPnn0FhCdannbyMQtGU5JfSlqGu3O3JEysA5KKqQjEfuW+gS7MiBNJ6wi
         ghNeOB3Jox2M734YStEK7Ss0e39WHanr7Vlu1JKGgJkUzR/UZSZ1eyKgYzHxS4eAU0/O
         uQtECZOHstWRp+JEoxqHKcNX3nQdK1jKtukzMbjiSKLNfjRnftmmyKzwbJHbmXmePtKj
         yOgsG/XIs3YiiIZhuAWnoE5Jmq9drt7IqMX1TTcJac38JWJgV9FITIpId5S+k0+3yxsF
         ImcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708096431; x=1708701231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZlzUsxX5xRqjM0C+rrFrgpdfv7K4hAD7PeqQ9NvpPdw=;
        b=Zfv7BgAMrMQr1FZILaTFG7Zrs3NG3K4HGuLcUCGQkcKhTIF6pmbGDXA+A/NcfCjczD
         7WNVf4lOi+TU9POZ1MgrDMXXsabmlKX9oUntBuQW8g480PqjTqQTxF8Qfkbtjf1lc9PN
         hZLxZPjnY+7dz8PneKmLvj0OcaOfCO++PkbiQB+YYK0B/HTvGYPQDqPBBbE6V0kRcbwh
         rxg54OOOdCKC1ZAbfJxtN9ZmReq9s5oXLnB3X+eSWAEVCYtr4Rzul94yHPNNQvUOSGlX
         Q25jVdSEjQL/cvxVVaxf+pCilh7Lrv1JvNICzlBkHzcuWbsJqSstrePr7IyxO+/D8SyB
         4vtw==
X-Gm-Message-State: AOJu0Yzbs8fWSeuPhbxWDCYCcYduO3SCKh1hWGL1w8ZTZtcr4iSujP5/
	2EthPBN1gISFxq/6tuTrt3857y4qq8SCNGWZWyxGVoXaAQhEpVQzLUQJnnnennxL8vQRTPjhxhg
	iMcmNhW1rh1kXTcjlFfWK8DAff2bzjkipXw74
X-Google-Smtp-Source: AGHT+IG+M7deEBxxkgFpHNs5JAXWJcmAQfWeqbNiMRsLv9An5XTtHQYV8EX86maNUeI326aH8IvAOSL2GhZTR4AwF7c=
X-Received: by 2002:a50:9b1a:0:b0:562:a438:47ff with SMTP id
 o26-20020a509b1a000000b00562a43847ffmr179726edi.6.1708096430980; Fri, 16 Feb
 2024 07:13:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zc9493j46rZMRIDv@tpad>
In-Reply-To: <Zc9493j46rZMRIDv@tpad>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 16 Feb 2024 16:13:36 +0100
Message-ID: <CANn89iJkjrBr-giBTA3=5t5-EMhc76X1gG6jha3rmm90NriEpw@mail.gmail.com>
Subject: Re: [PATCH] net/core/dev.c: enable timestamp static key if CPU
 isolation is configured
To: Marcelo Tosatti <mtosatti@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Valentin Schneider <vschneid@redhat.com>, 
	netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 4:02=E2=80=AFPM Marcelo Tosatti <mtosatti@redhat.co=
m> wrote:
>
>
> For systems that use CPU isolation (via nohz_full), creating or destroyin=
g
> a socket with  timestamping (SOF_TIMESTAMPING_OPT_TX_SWHW) might cause a
> static key to be enabled/disabled. This in turn causes undesired
> IPIs to isolated CPUs.
>
> So enable the static key unconditionally, if CPU isolation is enabled,
> thus avoiding the IPIs.
>
> Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 0d548431f3fa..cc9a77b4aa4e 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -153,6 +153,7 @@
>  #include <linux/prandom.h>
>  #include <linux/once_lite.h>
>  #include <net/netdev_rx_queue.h>
> +#include <linux/sched/isolation.h>
>
>  #include "dev.h"
>  #include "net-sysfs.h"
> @@ -11601,3 +11602,14 @@ static int __init net_dev_init(void)
>  }
>
>  subsys_initcall(net_dev_init);
> +
> +static int __init net_dev_late_init(void)
> +{
> +       /* avoid static key IPIs to isolated CPUs */
> +       if (housekeeping_enabled(HK_TYPE_MISC))
> +               net_enable_timestamp();
> +
> +       return 0;
> +}
> +
> +late_initcall(net_dev_late_init);
>

CC netdev@

SGTM, but could you please add netdev@ when sending patches for network tre=
es ?

Thanks.

