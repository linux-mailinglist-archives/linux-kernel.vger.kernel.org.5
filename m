Return-Path: <linux-kernel+bounces-136879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6AC489D957
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A175D28904B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B95312E1D0;
	Tue,  9 Apr 2024 12:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMqgGDH0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF1012C552;
	Tue,  9 Apr 2024 12:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712666648; cv=none; b=OGH34Fei6mg1TaA3n7NEcyo8wfCirEvNmaG53b022wjmCDyCtjYKeGlxazFrlxfw8kaa9twJe67D4dEnxjG8bIdBy+LzwNXGukbMWMW/Lj+6j4LhR5tNAWDEws9BUAIaQr+0Gdthya31uNL7OC5qj1UV46s9zlAatgknAf/C2+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712666648; c=relaxed/simple;
	bh=Upe8YiMHNTXFEPMUM7GWFLBzjhh983uAQuW3hbvUoes=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d2UYlUstSIhziTrU8gl8RRQpIdPzsOXyD0SDwcT0yKoppnFRBL3iaPqFhHBL4etO+wr3bZmLfRtI0BOXekOCw4NjVE6/xcIkl/1HM2Dg+pS7lgdYOyG6mGWWvbeJgKJ6eqU7nmje8TpW30RhWpIGFrFf3vAp1SDWy5RZRt/AP14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMqgGDH0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 012F2C433C7;
	Tue,  9 Apr 2024 12:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712666648;
	bh=Upe8YiMHNTXFEPMUM7GWFLBzjhh983uAQuW3hbvUoes=;
	h=From:To:Cc:Subject:Date:From;
	b=CMqgGDH0e3Ow9YDIU+LALaq9unDyuqt3TKZg/iafB9+yD31OqUrH9LyEXn/kt/eX2
	 fONslsUr59UV4eIxKtUppW6EUTEkQ6z69zVNDAjav3QItyIUGUYlOnV8PomQRhqURk
	 FrFeopM5kmiR+MicgN1KZV2CpNx/Y1F92PW0qnuann9bWpqIfnOLqXLc5QFibt/bEp
	 fn0FR54w8eyQLhRGPVr8D5xWvaJ0nBLNr+oU1Ms5FAKSM9yftggbUTmEQZvH1AgxHI
	 70zM8Y4Ce1r9NYfWC514rMRCMZqymsAer/oMLB+EnMbI/07h/aM5lPyWMhc7jy7UK0
	 J3q+4ecNLP2pQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: Stefan Kanthak <stefan.kanthak@nexgo.de>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] crypto: x86/sha256-ni - cleanup and optimization
Date: Tue,  9 Apr 2024 08:42:14 -0400
Message-ID: <20240409124216.9261-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset reduces the amount of source code duplication in
sha256_ni_asm.S and also reduces the binary code size slightly.

Eric Biggers (2):
  crypto: x86/sha256-ni - convert to use rounds macros
  crypto: x86/sha256-ni - optimize code size

 arch/x86/crypto/sha256_ni_asm.S | 242 +++++++-------------------------
 1 file changed, 47 insertions(+), 195 deletions(-)


base-commit: 4ad27a8be9dbefd4820da0f60da879d512b2f659
-- 
2.44.0


