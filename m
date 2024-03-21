Return-Path: <linux-kernel+bounces-110462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A4A885F46
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 850D31C23FE5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F61116439;
	Thu, 21 Mar 2024 17:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="M+pn//Ef"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B0412B70
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 17:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711040836; cv=none; b=pzUaKwANMhmbpXZDryq9MQHJkYU4GVP4y1Km9OaREvWlkg452RB64tNRXkdlv/B6skW3hiB4sX50UYUK3o416K/AxNqmHxuq0vsvfO7XntLyKO1Z53H2pL9QEM9x/1OZavUBtBQjZOQQ0K0lCBL8e/96ImHcybEjAI5Dm5TPJaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711040836; c=relaxed/simple;
	bh=kJJk/+Zdsmcv1wL0Fg0q/2+f4j2RqoeS5rRQ6udYmmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cU/8BoM9Jnd8KhWdIN801DPeYSmtMMY1//yyoQALEH6FBCQjFKGgrVTDZPyKrRxeuITCENmC3s1eEgt8uKN5iFM5UGr2ZO2zpqKbS8ZG9R36w1NPmue1WW35Yd/MI5ZyNW6drIhOIVVv7+9dMoXlQK3Y5eiUqM5LMZR+75E2+Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=M+pn//Ef; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a46d0a8399aso391306166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 10:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711040833; x=1711645633; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MsVbd2140swEcLwTG+MF1x3NLhBkmZkIVQJKoZyOCjI=;
        b=M+pn//EfA1MuK4BF+Fbm2x/XNZD/iBfBiOSkkWOxn/vDiZEyVEz7dC59pY6xDsDsza
         s9STbnx/vqeuYsBSDBs4gFHkpgtR3j4LtIB5dFr/VhiWfEohJKdIwNnFDGuHRJop1u9r
         K8duH05tIn86hRvFiX118pvcTec4iQeUPFiVA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711040833; x=1711645633;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MsVbd2140swEcLwTG+MF1x3NLhBkmZkIVQJKoZyOCjI=;
        b=HQ6axJWKgY9w+UUywjedNFJtZlHT3KY+8vmJAfj2p+JBMyAmpDSC4YiK8ovvrCFdWt
         hKcNZFDMV1v7YlDXWmKwWio2aUMwPmcy37o8cy006V9MhpuE7UaQzyvNyvDzY6hMUeFF
         hPLzIswCRmYOhkLOG/jlnoJzwnVd3Tig+larTa+OfJZWXu50rag3jmqO4MzqhMFtiMV0
         aTdWgOshhAs8XT1yhOpfNN9x6TAUe4VodsV4jkQ6Z25HYhu26+ir7ZaWV/8qj4GxjEpL
         SD8/rC8PVqDbm/EhRckMw1hcDv1VadZEH9Tpod4NEkBYvilMm2X8Fxf4Dr1TdewcRLj1
         ErOw==
X-Gm-Message-State: AOJu0Yw0KUhO2OvGM219lh84pwoDRW6eieSjIGvy7+xpXX1aSfFmUXbr
	QsxNpAe7FOZNoforvURISRN/scDBycAXB6WmbX1qp62ZcXOI5qiU/VDe/7jMQic8hSlmK8cLp+m
	A6NSKIw==
X-Google-Smtp-Source: AGHT+IG84ngfCaKHrA1MWkTVSn/zGfDuEmT4wacopo9FjnuS1fWZAvlbRk1lupqFIWZg/+tBFVZhnQ==
X-Received: by 2002:a17:906:1b49:b0:a46:bcd6:b64f with SMTP id p9-20020a1709061b4900b00a46bcd6b64fmr89360ejg.12.1711040832813;
        Thu, 21 Mar 2024 10:07:12 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id js20-20020a170906ca9400b00a44ef54b6b6sm114850ejb.58.2024.03.21.10.07.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 10:07:10 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56bc7b07df7so1636128a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 10:07:10 -0700 (PDT)
X-Received: by 2002:a17:906:360e:b0:a47:1c5a:6577 with SMTP id
 q14-20020a170906360e00b00a471c5a6577mr1106916ejb.35.1711040830359; Thu, 21
 Mar 2024 10:07:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Zfuy5ZyocT7SRNCa@liuwe-devbox-debian-v2>
In-Reply-To: <Zfuy5ZyocT7SRNCa@liuwe-devbox-debian-v2>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 21 Mar 2024 10:06:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjCD994KKNL7LGTNpF4B6-E2_A13J2hjP-ufnYt0KJdCA@mail.gmail.com>
Message-ID: <CAHk-=wjCD994KKNL7LGTNpF4B6-E2_A13J2hjP-ufnYt0KJdCA@mail.gmail.com>
Subject: Re: [GIT PULL] Hyper-V commits for 6.9
To: Wei Liu <wei.liu@kernel.org>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, 
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, kys@microsoft.com, haiyangz@microsoft.com, 
	decui@microsoft.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 20 Mar 2024 at 21:09, Wei Liu <wei.liu@kernel.org> wrote:
>
>   ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20240320

Pulled, but...

Your pgp key expired two weeks ago. Please extend the expiration date
(and not something small!) and make sure to refresh the kernel.org
repo and/or other keyservers.

                 Linus

