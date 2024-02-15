Return-Path: <linux-kernel+bounces-67582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FA8856DB8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 20:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 249F9B2629A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 19:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F6A13959E;
	Thu, 15 Feb 2024 19:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="GcUv1pz8"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF14139565
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 19:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708025434; cv=none; b=hbnP6Bj41Z0kSX+pKAaiGF/8adyMpniGv+w3qYq5f49AkFy8ZAgx+lKXjXgxvr5yF4hCzs73SYmdqOWp2MIgApx0N6nn9DyxvmkVjCQ1n+wRt1iZkbvTGJCNd498FxFv3JtAQmhcs6dXW91AUQK2bBBR+mT/w4Z3ir8W5HI9WXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708025434; c=relaxed/simple;
	bh=D8T2SJDL8xpg5Ce5qnRxYaSAjt3itpBBhWs91ZpZhOA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HCHAS82dnRIHAmktmaAt0KaHUnvBYT95bJzaC6mo89UPZ/dmf+OJ2QmvHEbU9CyOn59bjJFrJsmobxSO/XhVIj1KzpdLDRF5vHS/hal7k6ihhcx7VL6fFZxpixSsS/k7gddmHCUliXvUWGH4vWhrTb0XejjtKADRlqEhDRBEK74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=GcUv1pz8; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d11c55d7f2so18371461fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 11:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1708025430; x=1708630230; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8T2SJDL8xpg5Ce5qnRxYaSAjt3itpBBhWs91ZpZhOA=;
        b=GcUv1pz8WIL5XxQFzMA/xol534T4Rf2QTjPK5mJZrDNeoJtJFaN3Baeh3jGuBfX+ar
         aouCkWFbsDlvnVB96BuWi++ho5xVtOs1rSaysNdAdxDO6FMQ0hdqN25CFwkIDtgw5kDd
         vZH0oVsNJz07fAM0z4xDfs1vmA8ifFCr23KDsf5OniezQdJTdvbsD5jVdnVGVQSLX3SN
         TJB54IU+b09ATp30vpV5pz/40h8KpxngHhb0kfLMIZp3y+jYs30Go/cQhBdhaG/fdURJ
         aH1h8tG/gGMP/TeITTEeOO7mJfPHoCqj6pkk94xQIz4d0LCRIHTsvE7OkMXlOFQx9Z7C
         AmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708025430; x=1708630230;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D8T2SJDL8xpg5Ce5qnRxYaSAjt3itpBBhWs91ZpZhOA=;
        b=fl+Ci3oMujNZRfWz5y7X/bBkB2GKIZQBmb8bYVxHY60d7zzbsmLuzGrrF68cUsnZYo
         KQq+Dr1PDPrxrT6tHnQrW2bJsLppF9pfeee7kNb5+B+mocrFojcm05VLNAahshz1kk9d
         uguSkFuos2stDv1EySV6BaVetVFJpWeMbngXrT7K20BEfc+3ljPq6s+BnNXgdkcWLY96
         PiVEDelVe3578ZznGlXTHzuyEEAK0fb4FiVezcMjh1QLo8yd88FoHme/TG+4l7dmf1GZ
         9DAIMY0RPIvgQyfUTY0eUzY7t2qSC4wYJe6SMmHrXcGmvcUqp2puocMbSGJRE1YBlxTP
         +6zg==
X-Forwarded-Encrypted: i=1; AJvYcCU1feoq0VHi5I6iaGecgN23+nGzjfS1d2qAhhkQuWai4OmRl9NhJzOxUzXp2wvezjGmncjVw0Ly41JibAt84GGEoOe9ftxhmkvtRU3P
X-Gm-Message-State: AOJu0Ywv0JuF1/hZ+n9+avKWmnIkGCHXQx5N1BCmwTHbTXIG9sl0NXEF
	QfItxY4osw7EwTFBXslO3WkOOWSjn0VXzKvW33u+VR3I/EqurJ6dt67w26DZbkveMTfHS5jUhUT
	uxfTBP4jM2gB+YsO3EJ26a17svpWskblpgs2nmp16rQsYcZcATuk=
X-Google-Smtp-Source: AGHT+IHsExOz4DZbL+fzQgs708JGEG45IfM90wTSWwklEaO47wa4dBM+CsGomfyrZXKUXFxYP6SkHEvT/kAY7g/8AnE=
X-Received: by 2002:a2e:3501:0:b0:2d0:b3c3:d8d8 with SMTP id
 z1-20020a2e3501000000b002d0b3c3d8d8mr1856929ljz.43.1708025430372; Thu, 15 Feb
 2024 11:30:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215133631.136538-1-max.kellermann@ionos.com> <f2f06960-86aa-4e79-afe6-c53ee7cbfabe@zytor.com>
In-Reply-To: <f2f06960-86aa-4e79-afe6-c53ee7cbfabe@zytor.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Thu, 15 Feb 2024 20:30:19 +0100
Message-ID: <CAKPOu+9oqRHJTpxd4+yoNYLPP6fNihuivCfNKfOD=f-X2WD04g@mail.gmail.com>
Subject: Re: [PATCH] arch/x86/entry_fred: don't set up KVM IRQs if KVM is disabled
To: Xin Li <xin@zytor.com>
Cc: hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2024 at 7:23=E2=80=AFPM Xin Li <xin@zytor.com> wrote:
> The POSTED_INTR_* macros are under CONFIG_HAVE_KVM, which is 'selected'
> under CONFIG_X86.

Sorry, I should have said that I found this bug on linux-next master,
which has this commit:

https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next/+/=
dcf0926e9b899eca754a07c4064de69815b85a38%5E%21/

. which changes CONFIG_HAVE_KVM to CONFIG_KVM. I was not aware that
this commit hadn't been merged upstream yet.

You can easily reproduce with with "defconfig" plus CONFIG_X86_FRED
(on linux-next/master).

Max

