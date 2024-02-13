Return-Path: <linux-kernel+bounces-63673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0475185330E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61901285154
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CBD25810C;
	Tue, 13 Feb 2024 14:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iC4on0MO"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D16158105
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707834401; cv=none; b=Tp32VblZPjkNyjGSBbpmQEITUwwDwXSrOaPWWWmN1xX0W5e9oSKjl8pnMWDmh1TuVliL7o+SijW5lBUYVPnqG9frXb9ndDaK+Kcy4O2F6+ZTnOEKsimV4ABfm3vZHHm3kWyEgmy4v6UvQLqBNQFfxNvpB0ZDi64G9Wx200KRQhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707834401; c=relaxed/simple;
	bh=qASUrS+vOBVFIIQET0iuHRIXBWXJrlz2fHoqjkLMSmo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=s/MZs7mh/Tun2m7bvXFSF7CaJGa9pRP+MeuSrrb76anITzInJQ31OhtKLvvf5OoJpW03mmRpVEUqe9p4gJ94yFpuOLJR8T5QdF1lARA/Qfrwg5mZwtF+5BTDwotB9Ou6OWTIeflqXMy488hFfd4ko0Ow/juuyurNEWmBrrI0PFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iC4on0MO; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b5d1899eso7081828276.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707834399; x=1708439199; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BXEQKabWvB1bJJHi91N778ioTs4M81H6SuoVCunbpKI=;
        b=iC4on0MOXWKUZIhN7mW8sYPwRmMZ0uQCP+Z7JTWrQXkG3qO8PhdFR/QY5n2Q8LSnJa
         gY4eT5LAfTu/bXEqqXEVTdAxrfM3idO/9DNoe6aKnUB5iXMNdsrXa0L765DQUdY9JWdj
         qyqocX4Fva9WyBXTGL87bWeyHqN7uZYj3Oast9l8ez2nZDXELm3s8kBtJeR3VBbmneCG
         gYF9LlPptRyimrMtBcSB6YIHAok8YQua1iQXB9S7lrKR1Hg2D8LUXNE3bGjdB9iFVfFz
         HKXdA6m6D0VDTlED8uQ38v1HAT88p5jYXETQaFeX0UZEKnWyYS7vi/ba/GRndYOrz87u
         V4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707834399; x=1708439199;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BXEQKabWvB1bJJHi91N778ioTs4M81H6SuoVCunbpKI=;
        b=MEGM1fAAXA6mO/rgZ3gEIM2niH4DspJGfgWfEdHKARU8i9bSH96hTYLJKeH88ZWQgB
         9n5eYg8SRz1VHyDdhOWcHwsKyKGkM3SAPWTbl7ieOhaoswPiuG2xrlYyCi6lVHTnvhKL
         wkH50kW8WC1Bvisu2APdq22anETQCfTTnK/L58kzgo5gvQRCdqBFIEeLYpZg7JJUJKXU
         x4zA9BKbRHcspJ0dUtQFbAxiEyBjcK1xzCp3LCpb+3VXYxKMfno/ymrfgHpTbVwvtRuC
         PtA07fZW+OXOFqMYnj0reiTx+3MDYgKD8iVjI2dC33iurB/sOkbr5n7es0NPjrQl+FDd
         CvdA==
X-Forwarded-Encrypted: i=1; AJvYcCXaF8+IXvsLnep51J4I/hGr9Qt4huDz/tK+xfqYrkJd03K0eEUa8SnPpk/sSH+/XYRbo64r7Qv2zI27WqvbboK+cZgDTUTlHZmYKvgr
X-Gm-Message-State: AOJu0YwN11BNIVU10WJoNtRJ64nOlJXBoKTY3v8+D2euxwW8pPapBmEz
	3zI/aEA6kV9rkOBi+v3RYustdDiT3dHm2/CFIG31RlAj3FrvsK59TzxiuSd9i5TI/Tysrc1R2BP
	5IY8fXXnYDa+I53dAtw==
X-Google-Smtp-Source: AGHT+IHea2Q/ymFpGwvd1rep/akiLkqQzrKrZSAjVHimm9/M2Ji6KNJv8IiH8r9fY0dWo/q7kKW4wkes3yOj8Nq0
X-Received: from ericchancf.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:4139])
 (user=ericchancf job=sendgmr) by 2002:a05:6902:1109:b0:dbf:4359:326a with
 SMTP id o9-20020a056902110900b00dbf4359326amr632590ybu.1.1707834399195; Tue,
 13 Feb 2024 06:26:39 -0800 (PST)
Date: Tue, 13 Feb 2024 14:26:31 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213142632.2415127-1-ericchancf@google.com>
Subject: [PATCH v3 0/4] riscv/barrier: tidying up barrier-related macro
From: Eric Chan <ericchancf@google.com>
To: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	ericchancf@google.com
Content-Type: text/plain; charset="UTF-8"

This series makes barrier-related macro more neat and clear.
This is a follow-up to [0], change to multiple patches,
for readability, create new message thread.

v2 -> v3: split the patch into multiple patches for one problem per patch.
Also review the changelog to make the description more precise.

v1 -> v2: makes compilation pass with allyesconfig instead of
defconfig only, also satisfy scripts/checkpatch.pl.
- (__asm__ __volatile__ (RISCV_FENCE_ASM(p, s) : : : "memory"))
+ ({ __asm__ __volatile__ (RISCV_FENCE_ASM(p, s) : : : "memory"); })

[0] https://lore.kernel.org/lkml/20240209125048.4078639-1-ericchancf@google.com/

Eric Chan (4):
  riscv/barrier: Define __{mb,rmb,wmb}
  riscv/barrier: Define RISCV_FULL_BARRIER
  riscv/barrier: Consolidate fence definitions
  riscv/barrier: Resolve checkpath.pl error

 arch/riscv/include/asm/atomic.h  | 24 ++++++++++--------------
 arch/riscv/include/asm/barrier.h | 21 ++++++++++-----------
 arch/riscv/include/asm/cmpxchg.h |  5 ++---
 arch/riscv/include/asm/fence.h   | 10 ++++++++--
 arch/riscv/include/asm/io.h      |  8 ++++----
 arch/riscv/include/asm/mmio.h    |  5 +++--
 arch/riscv/include/asm/mmiowb.h  |  2 +-
 7 files changed, 38 insertions(+), 37 deletions(-)

--
2.43.0.687.g38aa6559b0-goog

