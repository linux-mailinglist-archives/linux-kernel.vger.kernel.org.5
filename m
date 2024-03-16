Return-Path: <linux-kernel+bounces-105269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E31C87DB3A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 19:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91912281C29
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 18:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17291BF5C;
	Sat, 16 Mar 2024 18:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MIyd5Sb7"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0D11BC31
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 18:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710613436; cv=none; b=JCOxzF2GVU3EfcmMUiktqSmgWpBSzVShptz8dwkCWEcjlAPzL2VZAj7tD7MjWdKjA73/CAOeanBe0qcO0w298mNjLq++PNDqUDyEk8VUqxQFYmwQR7X7twfJylB4xz2tGqaWcAO5dLSlt4IUcGFYW4BBHaRyGMQjUDjt5PP7Czw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710613436; c=relaxed/simple;
	bh=xHkBjs3WnO68wDBvgyjXnQ9cRz2tnrgWOxSV9aPKk48=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bbOMnQpZY2bZj9nvsECnCUX2qdFG6UWQnBFf6271wMww4XxqjhlgFonX4sAFkoGAY2ahl49vkyHHYXb9YIerrmePoFAsXKTCHxOksV3BCTYvMjQVwfVO0SLpoKFswGIji3Sxr4mdv4my9qiPzmDpkHl9+XPUOcbdJZGuRctaoY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MIyd5Sb7; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a45f257b81fso410823266b.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 11:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710613432; x=1711218232; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=w3nUdDugdRvemNPtJgjZ8jhZaKS9WzQY9Zv+4c0bWLM=;
        b=MIyd5Sb7n429xkqCLXy6aUmTdNuwJS12ZwdQHoHv29k5ODzVFQeJCeqMd4f73It2NX
         c0ql62VMjLSxx4B557yhTV1pZH0FCQCpX/emfXwVJXH8vbwJKKhw/e1ocLnVLzuVkz/K
         k091DADoYqBChaNXOV2FSE70wfB/aqGo1bz/w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710613432; x=1711218232;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w3nUdDugdRvemNPtJgjZ8jhZaKS9WzQY9Zv+4c0bWLM=;
        b=Aajcc4pP1Slq8B8S3+T7YoR7eTnxyEGkFvGowDLs0lx19eywpWsGpNJ8GbG8kQ1LOD
         poAoCHogFb2xW9v3HgWdsN2QjsM0s5se/3Ef2MIC7huqlt8oQilx/UWPZV3nQlMHbTGL
         aQgxu50i8kDkjYBzBkCqjY/fMzXtxpz2vA53CWH6yksXrKJRrfIIC5+PKCknu8Y98h5S
         35jZuk4DjTbbN5XBlPPc8Dx9OkV8LhaXCVkVHAstu2kM9yRxrrVLAJYhOW/ZhGx4GMCY
         vqSj+IbQNKnq1t+psDJAXT6IcH28GMNDlOPsKC94ONcP1o9zKmjuztbub+RwsWfMnCO2
         Tb9w==
X-Gm-Message-State: AOJu0Yxbrbemt/2BoRC9XVDbCQpA7euye8d1zvwclkN6m2VyZelI1acl
	/Ph84tEwFElqFIBZrPblpsvl2XYe+08/1zIvObFCMuHQRG62r8DJbMZ4hnRewHLTWPH+Mf71wWp
	SA4W68w==
X-Google-Smtp-Source: AGHT+IF957GeHnm9wdVYRXgZcCAZogThyb97Vi9xlvXckmDwRUqmZ3kR7qlRxGnr80Qe05AXqG7RxA==
X-Received: by 2002:a17:907:7d8f:b0:a46:960d:7534 with SMTP id oz15-20020a1709077d8f00b00a46960d7534mr3286013ejc.27.1710613432183;
        Sat, 16 Mar 2024 11:23:52 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id wp12-20020a170907060c00b00a3edb758561sm2971733ejb.129.2024.03.16.11.23.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Mar 2024 11:23:51 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a46966e9d30so182845966b.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 11:23:51 -0700 (PDT)
X-Received: by 2002:a17:907:10d7:b0:a46:b0b8:6acc with SMTP id
 rv23-20020a17090710d700b00a46b0b86accmr138031ejb.42.1710613431402; Sat, 16
 Mar 2024 11:23:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZfQrAdJodRKKXeBj@matsya> <CAHk-=wi1DTEQpOokQRXeKoAhSgyFJbs3jDKV9r0rc0M7aHDO0g@mail.gmail.com>
 <ZfXfdTFjbHEoIdXr@matsya>
In-Reply-To: <ZfXfdTFjbHEoIdXr@matsya>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 16 Mar 2024 11:23:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi14FKNFrHXCB8AFzyMcBn1MeWKLv0W4b0tChp5m_mj+A@mail.gmail.com>
Message-ID: <CAHk-=wi14FKNFrHXCB8AFzyMcBn1MeWKLv0W4b0tChp5m_mj+A@mail.gmail.com>
Subject: Re: [GIT PULL]: Generic phy updates for v6.9
To: Vinod Koul <vkoul@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 16 Mar 2024 at 11:05, Vinod Koul <vkoul@kernel.org> wrote:
>
> On 15-03-24, 12:22, Linus Torvalds wrote:
> >
> > That is not a valid signed tag, and I can't find one in that repo.
>
> It was pushed: tags/phy-for-6.9, I erred in generating the request for
> sure

Ahh. I did do a "git ls-remote" to try to find it, but I must have
messed up searching for it.

>   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-6.9

Thanks, now pulled.

                Linus

