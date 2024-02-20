Return-Path: <linux-kernel+bounces-73322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CE485C0F4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D99E7284643
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BBB763F9;
	Tue, 20 Feb 2024 16:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="wQzC2tsk"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2A976056
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 16:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708445901; cv=none; b=rm0sRZs5EfecP4vruVRNvRGvj8Qr+Vmh2sISiM0vl1dDMzB0zfPghpDyoHubcu60nuIoe/v62u5vK/QdzPiKnU2FkWXiky1hVByn6utwmPoQDCqhEuedw3PF7+9NfyFi1t3E0GVlo+a2eLbw/uAZpOs82R2Nc35h/KIVEGS9JnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708445901; c=relaxed/simple;
	bh=L6sT39TG9iv6n5WF6EkqkYT75IXBf9GOciPgjE2xBOU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RAM8uQzE+Lo7c4++5ripdpWYJB3a2xTJ5ndUdkbgyXNu8+ueaTBm1OJGJv0MGdXNPMiDMhJoR5Dju3sKfdRE5LIWLSqVlKDLYFhpxkGjn/AvRHbICWR1oH12hT23IYOdf921M6kGNQrdhLSiG+7MewhqI56HTEANdq5rdQIXXCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wQzC2tsk; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b269686aso8438158276.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 08:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708445899; x=1709050699; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=S01UQlrgYNJvFJj+ZTGEynd8ASfgdRjDb+KMqQ76eBA=;
        b=wQzC2tsk0lTdICO11YX2GUWOXpjSInSvDMQ6HvgnFJH9H4Ey72qatRJxApGzKlWZgJ
         pGN7uFXd2z61Gnbws2IEHNG9eh4TK2Rq2KF6cZGtD2TDB/uDDv/X3bqRpWugxMKuGUah
         CzuTbqdkcw0jt3M+YC07KAJ5fcYrzqNrmOHjVTkqzb+xQouwtcOwjHLn1qh8cPLwS36E
         L88JCU1tXWvn8I50Zt85o2ZiFGZvX2sGecXNkssYj2nSuYlwdtw6EIGe6nOCsjp7OK/Z
         7BZi3fZotVlDkVch1tGD7iIza11vutUEkcQuQ48+wQkYVKcnTK66JOrBgveKAIezKYmZ
         R06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708445899; x=1709050699;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=S01UQlrgYNJvFJj+ZTGEynd8ASfgdRjDb+KMqQ76eBA=;
        b=dG4AZfiAn+S5ctnDCsVYIoKw4rBmXe5ewOgTBOQttK1nEfxrlr2GzbclOR6xEuDkKe
         HXj2Ywd5sx9i0/ndyIGfhl47UZHhkNXcU/X9OWJFJVFWcu9VM0jaXVxJyw0AnvKGjoxY
         ASGN6iEQfgKMsABPB31wBrLvJBomNocuG+5LFDtTmS1juhPO8D7lfIDPNUBrbM0uUJMK
         QtwcsKvSTyfxPL9+Kqrg4sm3WN3uB5MioRFeJLWssZaNcMV0yLkey+Ep351ILe5BcrWI
         Q9AaANWN+Ez89+QVJcsEgWZ5lLBR5cNPCBijXWydKhfGwUDYCRcfWv2Un738JGUIA0cZ
         gY9g==
X-Forwarded-Encrypted: i=1; AJvYcCUe8fYxWmy2yPdNLPSHfXzwh7iMOQ1Km77/V3jDGJJ5jf4qFWKpw275Q6Bx/snQHBqOe7fVLcC8kUV27e+nzF/AoU6/ohN5oETuQM9l
X-Gm-Message-State: AOJu0Yy4Rt81d10udMX322NQ+HEvupJiHdW1Vq8GLdkVU4BRVfruerph
	LywHLDHbt2Qb+ykFEVu+SN2l3DAyOcFkdZ4OKO8Uwluc5KLESRksjdsF6UUgJEfJNTrbbj0sWp/
	pFw==
X-Google-Smtp-Source: AGHT+IGQJNh30pNFUgfjDUxGFIU4BwxfHFn7Htyq/Tp3042C2P5MuaZm5+eAyS+98IWp3gYFcBVKnd9pFiY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1001:b0:dcc:79ab:e522 with SMTP id
 w1-20020a056902100100b00dcc79abe522mr641223ybt.11.1708445899208; Tue, 20 Feb
 2024 08:18:19 -0800 (PST)
Date: Tue, 20 Feb 2024 08:18:17 -0800
In-Reply-To: <20240219175735.33171-1-nsaenz@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240219175735.33171-1-nsaenz@amazon.com>
Message-ID: <ZdTQyb23KJEYqbcw@google.com>
Subject: Re: [RFC] cputime: Introduce option to force full dynticks accounting
 on NOHZ & NOHZ_IDLE CPUs
From: Sean Christopherson <seanjc@google.com>
To: Nicolas Saenz Julienne <nsaenz@amazon.com>
Cc: frederic@kernel.org, paulmck@kernel.org, jalliste@amazon.co.uk, 
	mhiramat@kernel.org, akpm@linux-foundation.org, pmladek@suse.com, 
	rdunlap@infradead.org, tsi@tuyoix.net, nphamcs@gmail.com, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	pbonzini@redhat.com
Content-Type: text/plain; charset="us-ascii"

On Mon, Feb 19, 2024, Nicolas Saenz Julienne wrote:
> Under certain extreme conditions, the tick-based cputime accounting may
> produce inaccurate data. For instance, guest CPU usage is sensitive to
> interrupts firing right before the tick's expiration. This forces the
> guest into kernel context, and has that time slice wrongly accounted as
> system time. This issue is exacerbated if the interrupt source is in
> sync with the tick, significantly skewing usage metrics towards system
> time.

..

> NOTE: This wasn't tested in depth, and it's mostly intended to highlight
> the issue we're trying to solve. Also ccing KVM folks, since it's
> relevant to guest CPU usage accounting.

How bad is the synchronization issue on upstream kernels?  We tried to address
that in commit 160457140187 ("KVM: x86: Defer vtime accounting 'til after IRQ handling").

I don't expect it to be foolproof, but it'd be good to know if there's a blatant
flaw and/or easily closed hole.

