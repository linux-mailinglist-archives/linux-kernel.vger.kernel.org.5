Return-Path: <linux-kernel+bounces-43256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6DD84117D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8160E1C24AC2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7226F07F;
	Mon, 29 Jan 2024 18:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="N3TmFZYQ"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6B43F9CE
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 18:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706551241; cv=none; b=ncRl0AUYkwJX9RWTtsu8Q9BsLlkSMLcnaBS5D9puZdZXiEXf4575t4yrhRjL0Z/8mm881duil55j52FNmBstswgAOiOj6DlcgL8PAnDHrS+zggurvgUTSGh8Vopcd7EYgphrrd0gDE0178ZZ2J1taGrptumXeglnkESAMX6NFAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706551241; c=relaxed/simple;
	bh=+2/eN+UB7DM5N4Kf88sZcovmSGYJHUxZ8t0rDt3dSZE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mY2KtIql5484ECpZg3heX3Mj75GrQVfwNsev/hbfJUX3o4NDeqkQFJNHtOUGqB3pseqmokhT5AIvbl7lEfCeLOL09YwbpDmnDk0Qpb7JzcjFuCc8lh9Qebo2jJfajJPl7s/8Qauo6x7Gqd2iDX00vqF5ODGQMsAm55NAvpsuyWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=N3TmFZYQ; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0E4433FDA6
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 18:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1706551236;
	bh=z/8e33kWm7ly4Fe64ik4Gfk0k1+G3TvDCuRamGvQ+i8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=N3TmFZYQMWpiiOfx7Q1ArB9Z/OBbk9VsG4mhex84Xfud9MKmw9m9ceRMAsfREyAj8
	 6Mn03jj5c9xIVF0Z00KSH2cBIKSbvaYwNe+RiEOGhbKVZnOGdGCdUArY2kjUZzS/xM
	 52L/KNoayvWYG09gXg6EvkrNHh5hmGmtOpjYWZode2tczWze3OrSF5SDHK/hWn0PPz
	 pHZ+VJodANfbq0p4TIRgPAXHoJfRcMtdyyspo32Ah1GUd64kMjfMLdUBOiSEMB/ws0
	 vgROaO4o9GFz0XDawJIxanNp2ktIUcTwrxj/LNf9/winu803zJi5RFSs0KekV0Ygfl
	 GNot8MnNq0a7w==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a35902091bfso74309866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:00:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706551235; x=1707156035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z/8e33kWm7ly4Fe64ik4Gfk0k1+G3TvDCuRamGvQ+i8=;
        b=mgyO/6uP7iMulqtew778FgxFP8vOOgPcMuY9lGFSt/Kmnd4YMWaChMggRQBBjXj+ij
         ojntezuEbGNB1xPJsf5+87jFRMBDoUOLA+uJS7A1g2nSu3V3soypGJjPHejtVqCoXyN0
         DUEeLovXMleuGGCcuRjSvnu6m6KzpulRLNiDPHyh6jUdcHXVBk00xEClWiMEB8Ddp8XW
         9UH5S4LZUtwze7HMkpK5Ejbo+OsFh5UisK7Nmn5XxNmCd9/aBnBC2Leev+2MGMRWKKoS
         59QjGbpv77WhtGDDt8vYduquyhf8GrmM9icq3utBy3qqc4kHQwBwkMVAAhHT7MrzIiHi
         1JAw==
X-Gm-Message-State: AOJu0YwNT+KK/orYxjqt+1atrB9cPGLBvdRf0ak7zTFQvcIiWIhpNZgn
	nj8jqBUB2Qn8GeN4MueVM8jHZZjXh/R9oXiSuVNm2b0d8Tc1yISWWvNS/VChzfTWc8N/u+xIoEW
	Srdae6WLvODQvtNrfyke6BztQlEhjEtaKYBQqeIbus6EoWdY01Wf24KLKzvdjaafyH2y1nKa/yd
	5+7w==
X-Received: by 2002:a17:906:480f:b0:a35:91dd:b824 with SMTP id w15-20020a170906480f00b00a3591ddb824mr3549748ejq.56.1706551235619;
        Mon, 29 Jan 2024 10:00:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHjepICdEjZ9sgpgf/utgdmkB4ffLgrf/oOsuPIdoXPCQXZXk/cnB662HBR3ndXC7rEEqGFOQ==
X-Received: by 2002:a17:906:480f:b0:a35:91dd:b824 with SMTP id w15-20020a170906480f00b00a3591ddb824mr3549738ejq.56.1706551235336;
        Mon, 29 Jan 2024 10:00:35 -0800 (PST)
Received: from localhost.localdomain ([91.64.72.41])
        by smtp.gmail.com with ESMTPSA id un8-20020a170907cb8800b00a2fb9c0337esm4147500ejc.112.2024.01.29.10.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 10:00:34 -0800 (PST)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: brauner@kernel.org
Cc: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Jens Axboe <axboe@kernel.dk>,
	Pavel Begunkov <asml.silence@gmail.com>,
	io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] io_uring: use file_mnt_idmap helper
Date: Mon, 29 Jan 2024 19:00:24 +0100
Message-Id: <20240129180024.219766-2-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240129180024.219766-1-aleksandr.mikhalitsyn@canonical.com>
References: <20240129180024.219766-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's use file_mnt_idmap() as we do that across the tree.

No functional impact.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Pavel Begunkov <asml.silence@gmail.com>
Cc: <io-uring@vger.kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>
Cc: <linux-kernel@vger.kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 io_uring/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/xattr.c b/io_uring/xattr.c
index e1c810e0b85a..44905b82eea8 100644
--- a/io_uring/xattr.c
+++ b/io_uring/xattr.c
@@ -112,7 +112,7 @@ int io_fgetxattr(struct io_kiocb *req, unsigned int issue_flags)
 
 	WARN_ON_ONCE(issue_flags & IO_URING_F_NONBLOCK);
 
-	ret = do_getxattr(mnt_idmap(req->file->f_path.mnt),
+	ret = do_getxattr(file_mnt_idmap(req->file),
 			req->file->f_path.dentry,
 			&ix->ctx);
 
-- 
2.34.1


