Return-Path: <linux-kernel+bounces-101407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA7287A6BA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 12:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBE40284043
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 11:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A9A46542;
	Wed, 13 Mar 2024 11:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="TPwjM3jM"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81C243AAE
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 11:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710327971; cv=none; b=ABXzAIU0qnPlNBSwLAAec7Db2loSTJNgN6pYqT5w6RCQRQX0GrsMzwkGP86aS0MGm6YxcVLJaoDLAAO2p+c+z83quMmYJPKyIMT9AzaqcPmXeyQMoS0V+xzc6Xoa3uB6YjtNxNhEeSVpZHDzubGf5EVBTcI9lKdKU3SDMe09CIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710327971; c=relaxed/simple;
	bh=poKb8VxBrFQtoK1H4oQ1UgXa3OWgewJdw+oLXHq0Dns=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cjFe2n4StlEAVqw8Eby4HSdT8yskZmB5lrwc+i5njJ8P4yMOX7/QiALl89ZWhTnSAXTiENxQm3g2dtqOlh0KBRyRWDM3zlhy7qFVBhbSpgRtPK2J7MV8UZK66Z+oaQAbpG62WB0A4zkmmlNJA6AlSV3G5moqCpz7RGd0zJfwsUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=TPwjM3jM; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56847d9b002so5382775a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 04:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1710327968; x=1710932768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJhpLaBye+vDxABkGVxNk0R4/Je1BHTggYd+F9CS0JE=;
        b=TPwjM3jMqw80NkaKsRfTJcf8kAhvMWN4NrwL/mKZKZBzeEAgNwWUAEH2UFzY1ZyFXZ
         95PP6VA5FBk8NGCFWrMiLp16CF2UmGsZD1jK+R+JLTbxOfIR2Vwfe5F1dH3Dqo+HhMHn
         DD1fvIA98FBH17Zqga8Axn7fuwA1xpTqo8pc2cBRDFDPbqTgw0Zyzl6PLQw/oma9M/pK
         oR1guAO0pF+al7Z7EObuYOMOYhWuFljZuwULxSJEOKgCC+dLdD//C6Vt0PZnoFoOg4W9
         1IcWM42+GtYqxJVpl+imHtn7MK/0ORqFThIS00vHmONRFldclB2xPughk+iFTdAxBwvF
         xgvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710327968; x=1710932768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJhpLaBye+vDxABkGVxNk0R4/Je1BHTggYd+F9CS0JE=;
        b=UFardWq6rwxLjbNngxjBnz6iC46Vfh6AXzOMvv11Y1yQ1cEKH17GeOL7aNJwuWPjKk
         B3q61LT6IIyglgEYiEv9iBynVkb3pyA4QCiKb92QKjt0uM18yYkc+GoNt/DkeV5R7Tin
         lgXSfi75hGVPpO5BI6nrxOMtRtHPGZ/NIqPDi7C1CHO+IRolNhPiW0xkPBznxBj2fEM4
         xNV5MVOg9uUxIWqA4FCsko2I/kCUDm6j3yi8uiw8ccllPOukaJnYwrOer3gB3WteFDxk
         thO4gZNbNGA25bgMcXA0V6lImTXhOo9AZCn4watwtoVNJIHrc7UQGhOYkTpgHKQYPboS
         S5IA==
X-Forwarded-Encrypted: i=1; AJvYcCXv9q81U521pzudc+qsfwpvNlYDQJXCAoxEgOLcbT65Z3X/8Vou/WXx8MpATPmuMbJicMz1+jJW4wYznFMAKKpFSpJCTs8/dqf9PP7n
X-Gm-Message-State: AOJu0YwApxxUrhkWcpq+xlHTQUI9Dt6zV1d2YOqKfJQZHHwOp4jSJR9+
	keB2p8hPNPhGIg96ys8rU+/u1YKXwoz83ZAMLClbYbTMw+0BALny28of/kO/Lfo=
X-Google-Smtp-Source: AGHT+IH2kW+8cJvn0ZC8fmOzX8cVltqW6h1KgZezqvXcb0+MfBFkrVtJmrcgIoAGxQxFO9AZ2LURKQ==
X-Received: by 2002:a17:907:8a85:b0:a46:5dc4:dab9 with SMTP id sf5-20020a1709078a8500b00a465dc4dab9mr951325ejc.38.1710327968092;
        Wed, 13 Mar 2024 04:06:08 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id bf2-20020a170907098200b00a461e206c00sm3397412ejc.20.2024.03.13.04.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 04:06:06 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Hannes Reinecke <hare@suse.de>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Andreas Hindborg <a.hindborg@samsung.com>,
	Niklas Cassel <Niklas.Cassel@wdc.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Alice Ryhl <aliceryhl@google.com>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Yexuan Yang <1182282462@bupt.edu.cn>,
	=?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>,
	Joel Granados <j.granados@samsung.com>,
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	open list <linux-kernel@vger.kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"gost.dev@samsung.com" <gost.dev@samsung.com>
Subject: [RFC PATCH 5/5] MAINTAINERS: add entry for Rust block device driver API
Date: Wed, 13 Mar 2024 12:05:12 +0100
Message-ID: <20240313110515.70088-6-nmi@metaspace.dk>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240313110515.70088-1-nmi@metaspace.dk>
References: <20240313110515.70088-1-nmi@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andreas Hindborg <a.hindborg@samsung.com>

Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
---
 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1aabf1c15bb3..031198967782 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3623,6 +3623,20 @@ F:	include/linux/blk*
 F:	kernel/trace/blktrace.c
 F:	lib/sbitmap.c
 
+BLOCK LAYER DEVICE DRIVER API [RUST]
+M:	Andreas Hindborg <a.hindborg@samsung.com>
+R:	Boqun Feng <boqun.feng@gmail.com>
+L:	linux-block@vger.kernel.org
+L:	rust-for-linux@vger.kernel.org
+S:	Supported
+W:	https://rust-for-linux.com
+B:	https://github.com/Rust-for-Linux/linux/issues
+C:	https://rust-for-linux.zulipchat.com/#narrow/stream/Block
+T:	git https://github.com/Rust-for-Linux/linux.git rust-block-next
+F:	drivers/block/rnull.rs
+F:	rust/kernel/block.rs
+F:	rust/kernel/block/
+
 BLOCK2MTD DRIVER
 M:	Joern Engel <joern@lazybastard.org>
 L:	linux-mtd@lists.infradead.org
-- 
2.44.0


