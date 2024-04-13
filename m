Return-Path: <linux-kernel+bounces-143534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED6D8A3A9D
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 05:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9DF91F2428B
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 03:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D3F1AAA5;
	Sat, 13 Apr 2024 03:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqXA9OJu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2FAEEA9;
	Sat, 13 Apr 2024 03:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712978478; cv=none; b=ZT3xVCm+RkMKJpoc/NE1iowk/5k+p1EiYwPEC/XwACZEb9Qubiex2Kd4jnnfuiq/IZsAnWtaQKDE328zbDjrhID3Qp2efcy/f6ONIZDY5g+EwurTZMXkil64s0yrTdEbRDM6Our3ocWA25JC6MG0Ir0FKYAAJZr7iqKKyrgHvbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712978478; c=relaxed/simple;
	bh=yXkbm8Fr67JsVDN8OfJjD71dztaeqMaCwwNSpoaG/Ow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c80pkopgEE+MioEek0lfWB4JvR6YF31xUDwsCPEbpep7eRHtZTe4lFod9lN4lonuJyCBqcKDOk9400dTw8VIuVpi/Hiwzy5l/W+93UO+s4/RyyRtbxGY5CmwN+SU5rGSbKD/93//tLuwMzbZOdbE+gpSWup0xFzM0djFKvIATek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqXA9OJu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F64C113CC;
	Sat, 13 Apr 2024 03:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712978478;
	bh=yXkbm8Fr67JsVDN8OfJjD71dztaeqMaCwwNSpoaG/Ow=;
	h=From:To:Cc:Subject:Date:From;
	b=hqXA9OJuIlNUGKevdmwqHru6p8wP+JCDe6EWz0LD1ST6wo6HauvK8j7a8gJcCFU3f
	 FQIAmk+9NHrTvsQuTSFQpLrVs2ujC6YZsLmcjBPwuQh2OesIN4Jh3MwDe+23rWfXVd
	 CsfvNAPc+50DwOIkcxgooDep8apL00+6YrIZ5upppoJnlX3vKg0+I1gbaMmTV84Be0
	 dWdpyObR/DwsfO2Xjs0VfxPtzagh/gFT8dMdZ3+476Tk2Tu9JCwx4JZAcNx+TumTDG
	 fH6VJ2Z1d2lf7LAGVZWIufVVakR8xshCWdp0Pa/t+Fw9rt7kH86y1h6pOpaQy05Nfz
	 3daTqvEqBDYrQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	"Chang S . Bae" <chang.seok.bae@intel.com>
Subject: [PATCH 0/3] crypto: x86/aes-xts - additional tuning
Date: Fri, 12 Apr 2024 20:17:25 -0700
Message-ID: <20240413031728.159495-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series does some more fine-tuning of the new AES-XTS code.

It applies to cryptodev commit 751fb2528c12 plus the two pending patches
https://lore.kernel.org/linux-crypto/20240409000154.29799-1-ebiggers@kernel.org/
and
https://lore.kernel.org/linux-crypto/20240412154559.91807-1-ebiggers@kernel.org/

Eric Biggers (3):
  crypto: x86/aes-xts - handle AES-128 and AES-192 more efficiently
  crypto: x86/aes-xts - eliminate a few more instructions
  crypto: x86/aes-xts - optimize size of instructions operating on
    lengths

 arch/x86/crypto/aes-xts-avx-x86_64.S | 249 +++++++++++++--------------
 arch/x86/crypto/aesni-intel_glue.c   |  18 +-
 2 files changed, 131 insertions(+), 136 deletions(-)


base-commit: 751fb2528c12ef64d1e863efb196cdc968b384f6
prerequisite-patch-id: 5c1ca8ffe87136eb7bfe74d996f5e6cac01e2768
prerequisite-patch-id: a72a872736c8e0876c4b44a9e5792dcaa02d4e0e
-- 
2.44.0


