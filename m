Return-Path: <linux-kernel+bounces-106782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A3B87F370
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 23:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C190B1C20DCB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 22:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746B45B1FE;
	Mon, 18 Mar 2024 22:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ERpHChNg"
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C985A7B6
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 22:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710802732; cv=none; b=iRW4TFUUp1sLp1coX4BjjsyZ1wnOUoq4qxsBC5prwCNwSTTqRz2xK3FFgppgKFu/Qd43RNZdvTKACqpf+PpV+w8JmWKPLJb9ib7jKwIsAdOCRyf38PqXtNBmR6YqsgiR/F3bkPUbbBvJzFHHryJ4M379r0z508Y2+VI/FOCDHdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710802732; c=relaxed/simple;
	bh=XpG2kSRofAl3NkOaIeuLvJRqhwJ9TaXGDO0v2jaOGZ8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q+/ibkSNnRfDzsf/hkouemWihpvuLEhFdPce3sZzXJutXWFhOB8TN2lPQVeVId+++N+1nYw8qYjZ9oNbMCr0nCKwKs6KlP/To0Vsb+vOkfuXK3uJnXM2CLwxXg/RInhIwTN/H3yUCc1dQVP1TqVTS8q7qO7OzsrQQ5xJlBUU/IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ERpHChNg; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-5ce63e72bc3so3714166a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710802731; x=1711407531; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0sJMOtFGq7WkF8rVYfo/qr9MADE42xQ88HW95MgGMw8=;
        b=ERpHChNg8DUytQFfECbnUohdiK6rrJ+aDhfIDMF7fW0NTlLXslEzSP6xmONJfOgouh
         xh90p565kIgBZQS8TFt2ALlvP5ezfycuuBGBlfKsYLfLwcEVUu0YwMwFEoBGheDCwver
         zLMAAqtrKVlQdi35FQzPzFX/3rBGWg8DHcL/Mr6AOryKdW1xlmQa0qLmWIjTXP0vCJX9
         POPqmephQBDkSrFA3hoA6iJPZtqtJs0oqw0DIZfvCM6+zW+uaW5a/obc0L/D0lGC4EKY
         yd3XgRntYXpkncILe6vAgTKDaWrbhsrXAzejWHrTU/o9vVC5w92Auhs8Vo59wwJjoOTL
         JvEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710802731; x=1711407531;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0sJMOtFGq7WkF8rVYfo/qr9MADE42xQ88HW95MgGMw8=;
        b=TTlfcxBlS7aCpeaal5ctwSvqKVwIDhVNCAbw6tPPGXP679EXe3PWe2UPaoYNJ4kRQ9
         yAvX54XLqv0vbFtlc/ILVZZ/oIi7Dvim53jfy1Qd9w5N921G56Alf8I7fcqSPRprXZqv
         E+0SvA+AkYj2aOeUKctbcWgrf1Yksak+eoFlyvYxWE6e+ZFrRk5e4NIpikUqozNLAQ4V
         7wxiDNibWqtYKY3dxWv3aCN2dpoj4jsKyIJuPELryCN0gogVnMAQViF63pe+IgU7rfrt
         hgdgpmCCWB44l1dpbfaizjnrfD2ynAef7czPaZ/CHDVYR82qqx5lGmX7muQyshWsDfFI
         LpeA==
X-Gm-Message-State: AOJu0Yy14oi+/2XitA6QmtvZoARYB8KRZqJth/9pdnXRDmWlcjeqBU6e
	TcwFQhWcDSYVBhS/OgFN5sV1hVTHrzELvcb0EyxD3h+1hhShikCRfCJ7Y0Zix8DVuJRMZVi+flc
	klg==
X-Google-Smtp-Source: AGHT+IFngwIyErUsM4r9Kqyfs0aknFLxhEci+pydGzsloeh1G6wncRzgE3yzA2vPrEWmTDMy5X92pZcBpzM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a65:4546:0:b0:5e8:3853:d260 with SMTP id
 x6-20020a654546000000b005e83853d260mr18547pgr.11.1710802730721; Mon, 18 Mar
 2024 15:58:50 -0700 (PDT)
Date: Mon, 18 Mar 2024 15:58:49 -0700
In-Reply-To: <20240318221002.2712738-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240318221002.2712738-1-pbonzini@redhat.com>
Message-ID: <ZfjHKdx3PNqQfkne@google.com>
Subject: Re: [PATCH 0/7] KVM: SEV fixes for 6.9
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Mon, Mar 18, 2024, Paolo Bonzini wrote:
> A small bugfix and documentation extract of my SEV_INIT2 series, plus
> 4 patches from Ashish and Sean that I thought would be in the 6.9 pull
> requests.

Heh, they were in the 6.9 pull requests, but I sent the SVM PR early[1].  Looks
like another small PR for an async #PF ABI cleanup[2] got missed too.

[1] https://lore.kernel.org/all/20240227192451.3792233-1-seanjc@google.com
[2] https://lore.kernel.org/all/20240223211621.3348855-3-seanjc@google.com

