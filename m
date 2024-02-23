Return-Path: <linux-kernel+bounces-78348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C6A861245
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4E9D1F238BF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 898A17E77F;
	Fri, 23 Feb 2024 13:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4FcaqgB+"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A357CF02
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 13:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708693754; cv=none; b=Z3wGkYY5zC9IIOpACbNpT0D5xDPG/DY3I+q/xnbHYRo2jZyyrZtBrQFsixt2Vij11crup2YJo8SA1l+RjN/dYNHwYQsvgI/3CwZF+rc0Sby85IgJnNw2I7Tjuv9HqQPWBUZQVabwP7fM/AOP50OqTcgPdkbqiJbe4o64JtZqpbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708693754; c=relaxed/simple;
	bh=5oxnAR9jOd/xn82V3EZsBR2nFCo/zbhDKEhxECbBMz4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2i0bbV8Gakvz+9mv4bWy4+eK1NnIsJ7fU30CJJRXYzEYYEAIUwyKt5LSEWx8qSD7xKzy2Qz49MUUYuM+PbObXOtxRglCLpKMAtVbcLCO8e+Fpkn3NMTtcu9gvjUxzC1m98x3Kyg1vLodDuFqwMO1deXy278f9dfyFbJ9e28z7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4FcaqgB+; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-564e4477b7cso9960a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 05:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708693751; x=1709298551; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5oxnAR9jOd/xn82V3EZsBR2nFCo/zbhDKEhxECbBMz4=;
        b=4FcaqgB+1C078eAoaafRDL4fqu4DIzPKbAx3ENigfkSUQp0m2u6lXWpMtVcuGuQEeA
         aGc4FDqO7AxjO/eSMc6FX7QDMyQ62QV3/KKiLEd6+i6YTCKC2Cr1HchCU1dbmjUztVGZ
         huAQvTGQRl8bP0XMhiMLoXolKWRUBpFhvP7xzBuDbFGsTEb/EzC62cXsXgpgvZK1Jiki
         HyGdWFURDKfh7UppE7q12/NqFAg6iHgMLdGtCeMGQjCXn261QMOyhixXM6fwVHCJBYFA
         g3u7UAyzktOSWIU6V1dPIoEpBrIVf9cUediXE3Mvcd/uc8NXgs2/kn92xs4odXcZtKCf
         z+gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708693751; x=1709298551;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5oxnAR9jOd/xn82V3EZsBR2nFCo/zbhDKEhxECbBMz4=;
        b=L4VdQNgIQ40gxqN7YFyd8ooBzirNJIZyqaXZxBrYzWKzIL/W03r3HOEluSfQVgr3qM
         G5lE+ghgAa3e2SdMMiunvPmVzGj8pi9T1Uqv6KXDdKuE0Nx0lSLBRBcazuHJQAlNIySH
         B00dILH7uD0UwDoBk1shYSOyrJzi+/PiuVne7v8nQNaJLUPGYtIc8zQjVe3rbEJBAUT/
         7FFjHwmpxRfXXOq+cjOM38v9Iw5ahXX0TZoYYrLLbHqkWO/IxfjmiH0dlKXSCeMR1CBz
         fKTU6ekHz5Pr4100gG6pyej7uNNSKs76Eopai/qfvQCjlAcu9CC94vTWIMURm8NarcHW
         cJ9A==
X-Forwarded-Encrypted: i=1; AJvYcCXTmYd10wIW4Bxk+OpDHdx7Pgieh3MtYxOVw3aVIHpkWzORxCVE9Tb93ca/MFKQz5ZhH9XLze1N8mjHBxZawtJxRKTUIzzR2hMF1h6t
X-Gm-Message-State: AOJu0Yyreh9llqs3RDYkSMKsLvA86XU1XWnSwP9s1YWsFLumPsYOeDcP
	wOlA/iTTf6LoVrkDO6Ub8Sa/trgnYKaOkdoPVge3m4BCgTfkghKEX6/boh5Kicjb9bSpuyGZyVJ
	gjd26VJBwW7yz8LYmsasTB7vWcEPO5TYQF2eO
X-Google-Smtp-Source: AGHT+IFTFVekIAS/syom6ama+ratNO4vACdmLnCwK3G2sDq+DMZJbrVO0ynz19qzO8cib1qXIYaUCR67YLUqPfbyCLA=
X-Received: by 2002:a50:9f04:0:b0:562:9d2:8857 with SMTP id
 b4-20020a509f04000000b0056209d28857mr700687edf.6.1708693751255; Fri, 23 Feb
 2024 05:09:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223115839.3572852-1-leitao@debian.org> <20240223115839.3572852-2-leitao@debian.org>
In-Reply-To: <20240223115839.3572852-2-leitao@debian.org>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 23 Feb 2024 14:08:57 +0100
Message-ID: <CANn89iLKdX1owfY3w2Bh=E0rb0v8pJVF2Z3ZtXRE0osAVKtuQw@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] net/vsockmon: Do not set zeroed statistics
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	Stefano Garzarella <sgarzare@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	horms@kernel.org, 
	"open list:VM SOCKETS (AF_VSOCK)" <virtualization@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 12:58=E2=80=AFPM Breno Leitao <leitao@debian.org> w=
rote:
>
> Do not set rtnl_link_stats64 fields to zero, since they are zeroed
> before ops->ndo_get_stats64 is called in core dev_get_stats() function.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

