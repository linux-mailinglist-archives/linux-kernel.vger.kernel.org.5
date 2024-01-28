Return-Path: <linux-kernel+bounces-41568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3244E83F4AC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 09:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB8DC1F222C5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 08:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305F0DF4D;
	Sun, 28 Jan 2024 08:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9OkGm2k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA07DDC4;
	Sun, 28 Jan 2024 08:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706432040; cv=none; b=TmJF0vq3roFlv1K99RyB5wIsALo6vaBGLROA21VQT0tLrKM2XpMmCw7YwY7AJjFP4/r/5dCPCVsNXhNCu4greTXiyPfDUGF4odAdxMbbHNMS/Vz0FonKqWiZJlb8qnuyiSfvPJy3A2XLOhaL9s06k9PChW98iCPLOVO6pYvkGjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706432040; c=relaxed/simple;
	bh=qCDdwLKf3bT6cGGaU4frMAHoDwbySJE5/GyHOk7wHgg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CeX4DdbKGMDVvV1HZ/Q9dpkBpj6TmMx9FDZ/iob6z75+CzHlBzy8BbcrGFMS5EuvvmYWOFXTTN7ckcQz+R30XeQDyi47zmKtTwfvxKykRajzyqpyQNUkZJeXmFa0UAf/TEsVHxD5N1PFvCy1tCM1gcdf0pF9rrJcmEOOJ9hyA8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9OkGm2k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67774C433F1;
	Sun, 28 Jan 2024 08:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706432039;
	bh=qCDdwLKf3bT6cGGaU4frMAHoDwbySJE5/GyHOk7wHgg=;
	h=Date:From:To:Cc:Subject:From;
	b=G9OkGm2kEYH4gtzh31ggEe5BqfS6B6LMQy+ElheFFabiGciApVqloUDURStdBSnW3
	 uNO+cEx1HKbpoWvh4eqyuAPAIeug+LIN44/jPyOhBEXupka+3uz/j6S9bxhD+eoB5I
	 chR7MnQpwf0EQTRXcocVMpH2EzPmgncyohuGAWlyC50GAhmlDya6TmXxXIVEvD28gU
	 GHosdvIEkpa2e6P//D6gAF9zlyCjWh7Pl/Gwg7FC7ysTLL8GghiAO+bBCedE/8eBL+
	 O8XHg7E+q0x84A8VuZLxs62SCUhIggTsBya7pvK0ypqut7L09SXHaAvSyCH4bz1BH6
	 np+mscw0MUuFA==
Date: Sun, 28 Jan 2024 09:53:55 +0100
From: Helge Deller <deller@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	linux-bcachefs@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Subject: [PATCH] bcachefs: Fix build on parisc by avoiding __multi3()
Message-ID: <ZbYWI_s05yxbvubr@p100>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The gcc compiler on paric does support the __int128 type, although the
architecture does not have native 128-bit support.

The effect is, that the bcachefs u128_square() function will pull in the
libgcc __multi3() helper, which breaks the kernel build when bcachefs is
built as module since this function isn't currently exported in
arch/parisc/kernel/parisc_ksyms.c.
The build failure can be seen in the latest debian kernel build at:
https://buildd.debian.org/status/fetch.php?pkg=linux&arch=hppa&ver=6.7.1-1%7Eexp1&stamp=1706132569&raw=0

We prefer to not export that symbol, so fall back to the optional 64-bit
implementation provided by bcachefs and thus avoid usage of __multi3().

Signed-off-by: Helge Deller <deller@gmx.de>
Cc: Kent Overstreet <kent.overstreet@linux.dev>

diff --git a/fs/bcachefs/mean_and_variance.h b/fs/bcachefs/mean_and_variance.h
index b2be565bb8f2..64df11ab422b 100644
--- a/fs/bcachefs/mean_and_variance.h
+++ b/fs/bcachefs/mean_and_variance.h
@@ -17,7 +17,7 @@
  * Rust and rustc has issues with u128.
  */
 
-#if defined(__SIZEOF_INT128__) && defined(__KERNEL__)
+#if defined(__SIZEOF_INT128__) && defined(__KERNEL__) && !defined(CONFIG_PARISC)
 
 typedef struct {
 	unsigned __int128 v;

