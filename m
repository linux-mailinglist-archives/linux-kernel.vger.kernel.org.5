Return-Path: <linux-kernel+bounces-68561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F5AB857C6A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3342A2856B7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143ED78B46;
	Fri, 16 Feb 2024 12:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5AGVNKz"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21F542058;
	Fri, 16 Feb 2024 12:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708085858; cv=none; b=MfFqkqDVtldGmbg4kqxryItfmQBsEuYqfCgT4mopazdhrynS7F2w3UEOYqtYDXmQH2JxaE9bkPmO+yxdCkRQrcldB5XBI0vcWcR1do1th7iEmR1qx/F+jFP5NzuUlf7R/cqorZo0E+w/iFSGjM1+u34Pe58dZYDLOVg27t72e7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708085858; c=relaxed/simple;
	bh=EzOW3x3gVnYOhnoD8fJVmX2+gYMXuzA35LTvLRE3IDI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=MXchx7iRpPqf6CexkTAlmjwPwrH2OJsWmIdaPQCfRDcmF74ta3hKr8PR8dz+p62leZpR6bkXFyKv4etnBbP+Y85dRUsz+0oZB9bpBcpyO22+rpCQp+gTg3TmJdliSoQAJdSlIXaTZyGHbkQU39IUzpiN76/E5DMnYWKyFbP53P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5AGVNKz; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d0cdbd67f0so27162441fa.3;
        Fri, 16 Feb 2024 04:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708085855; x=1708690655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vCcSEYQFfWGrEBM70pI2JzIuUCSCvsJQwxWS/MFzK1Q=;
        b=D5AGVNKzmWWFAtpH7xErkXQVJZQt2z3WAx53VwWz6yJ+y+DOQEGwXXK/HlbEvc03Eo
         3nLidpEq1VCxDG81d/Y6rErOt1UwSLi8a2kF8jCy3fi0/naXihNwaLwTFQ4F2RoRUZC3
         18tiIRORo7g9afr/2BTm4T373zLEaPa8T0vipjQZ3fGIiNnG+GMermQAGmx89PUi76Ie
         bZfGFPRllIxOUZoOQtggOp0sxH998v6rs6bFgw+1GrOHWwBuiOnmvmomyU4BEV4nOruK
         fNpJNzksNCCVbqTZUkSedvbhF/Q+PjSCndT8biXT1J0GVzvcoLS0YtIHROpDcLjDfkwc
         Ufng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708085855; x=1708690655;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vCcSEYQFfWGrEBM70pI2JzIuUCSCvsJQwxWS/MFzK1Q=;
        b=h+31hQes009endopkok0DDFwkPRmWDZl93T2qa4qwiYgswj7NALBYKe8QfvzLoPeWj
         VnjWRz/rU5Vf3cfB+fjESrP4D5XqQpFbO9iXUQfmS23eyQW4TRbTkg5NmoEH2WleNhvv
         iWN+zVHHfNyFfr9KD0xUmx9SJc+5JsqbyhC2mMJyhlBp4WUQr4TtvuY9fjIRSOPO0KhD
         YKqWoH4N+q8Ulc5sEoTqCtZDHKuZLAr7Hfx7ihp5qgnCuJTp20x8fBeq8jJ/Bcb4oe9r
         m6vfzUbZhHE8v5TydsyrScR8K8k69dCCytG5oxNiqcwWixEaX6i4bW4FG0fgeRSG9mHu
         XHAA==
X-Forwarded-Encrypted: i=1; AJvYcCUBTKlUTYrFTE1uaVbVIsDbK5p25pq9DIBbK8bmWp1PKEb6HjOHecHH+WVFcLV89T29fFfP10tIQugwnbaeFi7TWBCdUsyECHGaVB7qIjNdoNmnmtuIqKqHgx6ifA5H7hS4vY9KUBBb2ZEj
X-Gm-Message-State: AOJu0YwLlhUJlBIw9yMZfswGU0RT9AAz1XQhuPgDcm3IFQn2BNP89PvE
	V3mgHbpCGwABlZ7CG5NeSirqH9ktH3fNiqlr6H96T+JDZkG8HDhy
X-Google-Smtp-Source: AGHT+IHdjn0jnJ75b0yCD8M/8GWFTP13Rdn5O8VBmqM5NxyxzeqvjQaZnLfom+qYJnrXzCj/ZiSWZg==
X-Received: by 2002:a2e:8807:0:b0:2d0:a3b3:e39e with SMTP id x7-20020a2e8807000000b002d0a3b3e39emr3542805ljh.28.1708085854391;
        Fri, 16 Feb 2024 04:17:34 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id p17-20020a05600c469100b004120b4c57c9sm2223584wmo.4.2024.02.16.04.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 04:17:33 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] tty: jsm: Remove redundant assignment to variable linestatus
Date: Fri, 16 Feb 2024 12:17:32 +0000
Message-Id: <20240216121732.2106445-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable linestate being assigned a value that is never read, the
following continue statement jumps to the end of the while-loop and then
it is re-assigned a new value. The assignment is redundant and can be
removed.

Cleans up clang scan build warning:
drivers/tty/serial/jsm/jsm_cls.c:398:4: warning: Value stored
to 'linestatus' is never read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/tty/serial/jsm/jsm_cls.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/tty/serial/jsm/jsm_cls.c b/drivers/tty/serial/jsm/jsm_cls.c
index 1eda48964c0b..ddbd42c09637 100644
--- a/drivers/tty/serial/jsm/jsm_cls.c
+++ b/drivers/tty/serial/jsm/jsm_cls.c
@@ -395,7 +395,6 @@ static void cls_copy_data_from_uart_to_queue(struct jsm_channel *ch)
 		 * which in this case is the break signal.
 		 */
 		if (linestatus & error_mask)  {
-			linestatus = 0;
 			readb(&ch->ch_cls_uart->txrx);
 			continue;
 		}
-- 
2.39.2


