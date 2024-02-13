Return-Path: <linux-kernel+bounces-63764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F5585342F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57389B299BE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6027360268;
	Tue, 13 Feb 2024 15:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3VPLkMO6"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371166026B
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836595; cv=none; b=rUhZ4HSGU5a7ERS4S1FOAtSRGDapi2f+KZwp4QVd4aRwn7a5jk4+0WyIxeRMFWdU2pJzW2SKmfFV8cJu5eNhltTC2cL4Ge8PgOWN6SNhEPvmc+wSXmh/RFzrDTnrjXTWUqxWy1mYARBqAP5lzvMKrKjNr1bQ31Yik11JQxm6VU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836595; c=relaxed/simple;
	bh=ui8WDjx34aKpSMyeoVcPjCFl0yhzJKOg6D2NImhmAF4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p6WR/3C1F2bm0nZ1x0qXEuCDqmBIvKFl4X7ccWzpnp/4a3fGJXsBSBi2/G5DMv0JxNa0AaAsMbORQLbir0B+Lt9yxQU+UeA4347jc930VI14IrpdeHFqF2HXmbvZD7vpTUEuyGTlU/FQFA8qj9t8bQvRsd3MDqvgOZ4Qt56bQ4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3VPLkMO6; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b269686aso7104715276.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 07:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707836593; x=1708441393; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=t7FsuJV64CawsinrLvyO7glO7FRW444919z354YbA2w=;
        b=3VPLkMO6CmsIicrxEuzxzS5CqadM4WNUF7a/tJA9Cc3d1hz4LRGwhDOL2VYjJpJV7k
         ANn7+M5s61xF1pTvHZOEKLk3iWgDMcvhTcwP977kfLE/zBXUBftkyVViJM6xe9C13p1A
         +SbrhVEW8v2PLwGG57Oiuc+cEGKYtTNUoA5LdHK3WduWRWgFKlLfDhvzmXFR++0E+L0u
         /lafe1qITbmdmrYJtqGi8/jvP0HAFY7Xc/tk5oPhoaYVLlBr+Uj8Avrp4wLTfSA4H4Gu
         kpiDpBS445izFIgtQAUFI0SafZb6LogMQBub6LacgiWoXBFX55mc+g5Xh7ee4/OFf3c3
         VvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707836593; x=1708441393;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t7FsuJV64CawsinrLvyO7glO7FRW444919z354YbA2w=;
        b=QqxgpIUXPrL1pR3WSdFfKbIuhAGT+4RxWTj+0ZQOEj+IKIpD7EhQgR1sR0tfkKjlp9
         kRjczEb/Xq6x3Pqg8spukCySq/zOVar99IcdC1vn400Z7VTXLv/FpJ1GTvDrb6rJ3F9j
         YOo6wAU5hTqsoVXKDPd5KsXIONaOv17dRtoDAVEF9Rwz/KH6X4zZy+ZmPsRJ9XrbIMUy
         lBjG4+VnN8hP27lTqAPeOW5id1tJZFrG0jXwUyczBxkHlvtj+pzUH8JuqjjQrqCrJurh
         5GHh44vgHejgkEGIVSRSiDkw5xWpkOXUBhb8vuazUfHXvnpCGcaYoS+AzObBWVsr7kS5
         0KOw==
X-Forwarded-Encrypted: i=1; AJvYcCXdbYTPBCUyQfv5UlQdp/WnjrRVVpUvvpti+Wq/tCOQzLdsIx/ABUTIWoQjQ6+54r9bdFWFvQin5qxJXSlUH40tNqiUJuy5R4frCS4H
X-Gm-Message-State: AOJu0YxmefwXKGLggG52umUCIXRZejQm0MQKcGAmJE/lye8h4J2fpqV6
	/icOvOVu35mElSFSTnCkj1aQe8Drc2KDvB3p4ZcY6xYT30SWZY6sZssSx4tbdq27zR64pcM/GUH
	q0pXa9QKzDz/y8usDuw==
X-Google-Smtp-Source: AGHT+IHt98x+ca2z3v4AKP+J76FiBBL6a2IyfEdm+GmtAaSsTOTJCpAsnIW8kZghoanSUU8fucgHOps/Fvor/cca
X-Received: from ericchancf.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:4139])
 (user=ericchancf job=sendgmr) by 2002:a05:6902:1005:b0:dcb:c2c0:b319 with
 SMTP id w5-20020a056902100500b00dcbc2c0b319mr142381ybt.9.1707836593127; Tue,
 13 Feb 2024 07:03:13 -0800 (PST)
Date: Tue, 13 Feb 2024 15:03:06 +0000
In-Reply-To: <20240212-projector-dangle-7815fa2f7415@wendy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240212-projector-dangle-7815fa2f7415@wendy>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213150306.2424991-1-ericchancf@google.com>
Subject: Re: [PATCH] riscv/fence: Consolidate fence definitions and define __{mb,rmb,wmb}
From: Eric Chan <ericchancf@google.com>
To: conor.dooley@microchip.com
Cc: aou@eecs.berkeley.edu, ericchancf@google.com, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, palmer@dabbelt.com, paul.walmsley@sifive.com
Content-Type: text/plain; charset="UTF-8"

Hi Conor,

  Thank you, I should not have just used defconfig without allesconfig.
  It has been corrected in PATCH v2 [0] as follows.

  v1 -> v2: makes compilation pass with allyesconfig instead of
  defconfig only, also satisfy scripts/checkpatch.pl.
  - (__asm__ __volatile__ (RISCV_FENCE_ASM(p, s) : : : "memory"))
  + ({ __asm__ __volatile__ (RISCV_FENCE_ASM(p, s) : : : "memory"); })

  I've updated patch v3[https://marc.info/?l=linux-kernel&m=170783431129245]
  Please let me know if you have any further questions or suggestions.

  [0] https://lore.kernel.org/lkml/20240212105946.1241100-1-ericchancf@google.com/

Sincerely,
  Eric Chan

