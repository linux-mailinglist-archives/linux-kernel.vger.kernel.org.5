Return-Path: <linux-kernel+bounces-78252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5728610CD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:52:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D9DF1C23482
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DBC7A731;
	Fri, 23 Feb 2024 11:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sht5ZwHj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29DDA692E0
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 11:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708689119; cv=none; b=Adxo1ySSjUT1TnQu5ZuHkLKVD/IC24RqU+EFBNDl77S5bm6iQcZb7VjOEBDTnUBTZZTU5sd4J2OvNiY8ZsGayiPEAI2yEq/1xrewpOOa8c4kebweZqReTx4sVLCp5e8G3mCO8DnxYthavLUnxyL6452Y7h8COnNnTWqBPrH0aVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708689119; c=relaxed/simple;
	bh=v/IYgrsTfauy5qjfc9IS9CKoqO7gauf6fJVHxS4uPDw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cz7ihqNxQlCOg8exYa5oRseBo7BHzjQTO/6Bw5NFLaxQeXj9Nq7cXEKWX8hbqXfwCScUppWyyjXIxZW8gvG2DKjnZnbozyJxbyvu669TocMtdtcyy4CSrGbl+lgK3Vu1OhzJ0Z1+glWyhhoNZ943mvOg7quVxMMrzE3UdhAGkPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sht5ZwHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67EFC43390;
	Fri, 23 Feb 2024 11:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708689118;
	bh=v/IYgrsTfauy5qjfc9IS9CKoqO7gauf6fJVHxS4uPDw=;
	h=From:To:Cc:Subject:Date:From;
	b=Sht5ZwHjntGAxj9BtZU08wMvSwAvZ23py0Kp5DAfZ77xcfZ14w7W9VfU7AL6axZ2T
	 S/VsHWfrByX/jVZYv4MNV2sHJOXGrSKlaLBhwrXvXx8M06HCIHIjW37tMMPjjQVlS7
	 pOrMpgUH/aRrFgE1dt78Zlq3d1ytEeXhY1EGP4ktzEtwUTnMZih6ZCM7vB+XNFv9/D
	 3MQghG+Zm3UvPwama+wrOB8Fq5w7VSOSqO0mmAg3ZFXad1wkcnkQYIYiN6nNcnqM8m
	 nK7PQ3VGT0ne+XWrx3eJceCEHbFou9KuKj4lU0N6Fktj7lSwkVGXKHoQF/w4QovvPO
	 KtExGB2jKX1aQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: stefani@seibold.net
Cc: linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 0/4] kfifo: small cleanup + linear and skip helpers
Date: Fri, 23 Feb 2024 12:51:51 +0100
Message-ID: <20240223115155.8806-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

this is a small cleanup of kfifo.

More importantly, it introduces three helpers: kfifo_skip_count(),
kfifo_out_linear() and kfifo_out_linear_ptr(). They allow using kfifo in
the serial layer.

They are needed as up to now, there is no way to "peek" the data without
actually copying to a temporary buffer. kfifo_out_linear*() allow that
and kfifo_skip_count() then allows for tail moving after the copy is
done. Note the copy is usually performed directly to hardware e.g. via
outb(), hence the need for peek without copying anywhere.

Jiri Slaby (SUSE) (4):
  kfifo: drop __kfifo_dma_out_finish_r()
  kfifo: introduce and use kfifo_skip_count()
  kfifo: add kfifo_out_linear{,_ptr}()
  kfifo: fix typos in kernel-doc

 include/linux/kfifo.h | 105 +++++++++++++++++++++++++++++++++---------
 lib/kfifo.c           |  36 +++++++++++----
 2 files changed, 111 insertions(+), 30 deletions(-)

-- 
2.43.2


