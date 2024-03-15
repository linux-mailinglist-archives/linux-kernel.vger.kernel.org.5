Return-Path: <linux-kernel+bounces-104949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E8D87D662
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 22:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22CEB1C21C02
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACDE25491F;
	Fri, 15 Mar 2024 21:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VMVFqIX5"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC26411CBD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 21:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710539530; cv=none; b=iNMubeC3Wv4NN/BjvcGp8KXUIPXs7WYx/ACsTrvQhP9UFzJu3/vuYRpbcwbsbcby1s2e2HeS41qjMslhz3YGEasuqKOVejD+RVN/mOcJmEpyOSCF+EPFZNB4hrPZtINLZ0EmrRixmEUd3Skk8QzP61VBRN1fXDmygm8TJT8FHUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710539530; c=relaxed/simple;
	bh=IyIpIH288LBLHuUuNbtFcXDqgJgXrcBCDbQP3frm8Wo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KXbiOtK1mQFvgwks70lkiaZ7QO7aTQQl5IGN1PvaIsMYse7fAaB55SLA34cwES123mSzNx2tuWZ7vL5V82uuMWzDsA/qSw30mUnbBSkusnDx1FK6M7foFvR4sjBzX8x96cFGK+zFYgiKWOkGBYpKNRZ2eW10i7p0LB3KC+n+EQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VMVFqIX5; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a3fb8b0b7acso277511966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 14:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710539525; x=1711144325; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mTlz3zPOeF7VRKW7iDziXL9MnFItMolhxGcmkvxBX3k=;
        b=VMVFqIX5ZDR+2tOoMCYzsx0dn2fQhH5+58WSp+xRyFiaFVJCVm7Pxtf9qy0Jh8ZYt2
         xAFsmIFLEy6q4O6SdvSfz67fgdLPsH+zxFid0KBNJWOC6ftZ7qEJAuCScUZHHoDWGQ4J
         jcXBFN7mqQJzm9eMQRBMFbBMk3nsrJkfG2fKc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710539525; x=1711144325;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mTlz3zPOeF7VRKW7iDziXL9MnFItMolhxGcmkvxBX3k=;
        b=oCM/bU9y8FRCa7jibohcvMsn9cdwALvOtNdjNmjx+fWiENNWeIGAAQSNpALX0TNqeV
         Rhz+uN0QbN6onApdwpJCjOAL37p9zhvkcBpeR/gS7su4DpULhq9nDQYIgrW0C4P6ZdWP
         yS+pgfzARnd2qq1xviHNp5H0G++TKHFC4QbjbOAnPcRTAATG6zndxOy/XLtekQXcFv1s
         EFbQYsbnHEE7rxB0VHruUVPZOzvThQD6Y6ILpjMviaPJ/QO5Sd15V9bJmzi/EA2zoFTn
         Zecdrhszksc7FnfprUjp9NwH1TSCtUaiqTS8bHMdo/I22KSynh9EAARz79NfBaWvMFuZ
         DAKA==
X-Forwarded-Encrypted: i=1; AJvYcCVVhmgUyFrU2EEHfXXgsIacq2AxRAjxWNw8y1J6ZCW7kIdEVnvvcHPf5jTGxCuNhdDbOiszcXebRjA4V2ipPc2GDgSlOrvbJvgCZvDg
X-Gm-Message-State: AOJu0YxbKRlX0BD/6G1PAh4IKVAsmIx+GTi0yaIFcWA9SkvCnIorYx5w
	3L4eGYE8hzUBvEIZnlXH/0Vfa6SfsOX3pKCIgv8rk4x3b3URNq1ebW0vjaVPybcPgRxZgYuVKLM
	WES/AyQ==
X-Google-Smtp-Source: AGHT+IGz4/2WzFiL5Xg/nnezi5882uKK5Eb8um6nzyqbj0DSEZoD/rAcDFxpMsDz2CR6Ygym9trHKg==
X-Received: by 2002:a17:906:f75a:b0:a44:1fcf:9b97 with SMTP id jp26-20020a170906f75a00b00a441fcf9b97mr3620307ejb.24.1710539524838;
        Fri, 15 Mar 2024 14:52:04 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id ox7-20020a170907100700b00a464ff4a0e6sm2070506ejb.29.2024.03.15.14.52.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 14:52:04 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a466fc8fcccso296863666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 14:52:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVJncySHQo7gir9scBIfXmQJTgyUl0CRzgzqdXuNTby+vaxGBA+EKuDYLZywDz6bTQP6CU7ekyPmUXUIEs5ZE5WVoi6YXgyKfaQ75dR
X-Received: by 2002:a17:906:d104:b0:a45:7946:8782 with SMTP id
 b4-20020a170906d10400b00a4579468782mr4083903ejz.1.1710539523611; Fri, 15 Mar
 2024 14:52:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <YpC1/rWeVgMoA5X1@gondor.apana.org.au> <Yui+kNeY+Qg4fKVl@gondor.apana.org.au>
 <Yzv0wXi4Uu2WND37@gondor.apana.org.au> <Y5mGGrBJaDL6mnQJ@gondor.apana.org.au>
 <Y/MDmL02XYfSz8XX@gondor.apana.org.au> <ZEYLC6QsKnqlEQzW@gondor.apana.org.au>
 <ZJ0RSuWLwzikFr9r@gondor.apana.org.au> <ZOxnTFhchkTvKpZV@gondor.apana.org.au>
 <ZUNIBcBJ0VeZRmT9@gondor.apana.org.au> <ZZ3F/Pp1pxkdqfiD@gondor.apana.org.au> <ZfO6zKtvp2jSO4vF@gondor.apana.org.au>
In-Reply-To: <ZfO6zKtvp2jSO4vF@gondor.apana.org.au>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 15 Mar 2024 14:51:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wirkYjV=-R0bdtSTLXSAf=SkcsXKCsQeKd0eSbue1AoDA@mail.gmail.com>
Message-ID: <CAHk-=wirkYjV=-R0bdtSTLXSAf=SkcsXKCsQeKd0eSbue1AoDA@mail.gmail.com>
Subject: Re: [GIT PULL] Crypto Update for 6.9
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Mar 2024 at 20:04, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> Drivers:
>
> - Add queue stop/query debugfs support in hisilicon/qm.

There's a lot more than that in there. Fairl ybig Intel qat updates
from what I can see, for example.

           Linus

