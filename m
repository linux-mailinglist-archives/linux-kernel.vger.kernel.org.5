Return-Path: <linux-kernel+bounces-96689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED53876006
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:47:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3CCD1F247E9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3271753E28;
	Fri,  8 Mar 2024 08:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmPwPTqp"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5615535C8;
	Fri,  8 Mar 2024 08:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709887503; cv=none; b=VQjRosF8Ep15CLno0MpfLKwtLn6OdqkgmxK61wPEc7WAaXX2t4edzGyW6M7GnCWGySirRkZdIhfc7pqwXgHRNtgP51T3kH4AQwIfRvQv/h26ISzMKuj5UVbVjISvgWP8Y6psOCcrT58H9BLf1pJYFpP2PkfMhrDUTNYA2i5iNIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709887503; c=relaxed/simple;
	bh=WIfKrII/q5Cy4fnBaoGorSTt/WCJneNDItG3lsR+aqM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=R4IpfzlDjlH8/x0q4qtzIA/CHVZV3Ou2lsBvYHGWAIl3jPQW+YF0XULz8FzoCLFlj8TcdwJxeGJyoEm//SrU8l7byTLJzJ6jqaKUlF4LObknJpCc3YRrSkOaoIgk3QSWG5UR1VQjzbINx0qgZFBExvQMyUH0pkA0WWWrdEB3YCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WmPwPTqp; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33e742ca96bso714365f8f.3;
        Fri, 08 Mar 2024 00:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709887500; x=1710492300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hHn/aiaeEqq5HNrZZ6UGDx6LpcyY5jbRWNKamKPcfsY=;
        b=WmPwPTqp8VCTqReQ0Bf9LWAnjsQvXtEuoe2AVTkr6FRcWQO+qvufNOx7TCQZ9CE7EN
         xLDYzvseEETs9/S5ftdm+YUD89bTE3B+76XUuVyCFV0xPi5BkM41lwVIwNNaoXQm4NcV
         qABMjXk8B6NKhLD96Dd2eDsBNhbI2XkX1z1cgI1KQMt4TdU6pngBjlEQmhl+ZMRvgcfk
         N1aFMIY7OhyePj52IvtMkkNFrP69MmTFfa+JzqM4YHR6t77AqHJHV6NGzYBBHX5BVC2x
         xel6n2Vtm6wcnGQIV5zIVOq/3TN+5gUABOr/UYA8pWhm77RbpW4PX+Puvf4fVAb24yRg
         tIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709887500; x=1710492300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hHn/aiaeEqq5HNrZZ6UGDx6LpcyY5jbRWNKamKPcfsY=;
        b=onzByKv5ncHKEKB9mBiqgtNJYrzYFxMJJ40h3GoxrBWqFgRo4qXIpFAl6AVXf0gbaq
         Hh1u/qLXiuI3Srn6adHJNI5hP9qPU6Dul7Cu2LUwa3MgEOARhUnMIT9PoUl/NPHzjSG6
         NQHqlXoPdPnT1bruS2GvvjNnv9psih5Ic8ujKchFCbSN09TsKx6YV9s22RUDbKNCYXGi
         oBkBkrFCk+NFPX8O4/HXw+qZ8AKSriVmnLT16Ap4l3w6Dtfkc4YaEOskmJ+etOuLVYYQ
         hoYj1AX09DOxyGEYGKh/QOVzllYe3xewMRtebDP5AbuchXGlOcXMDnT3Ur9mH9m7vScD
         5i+g==
X-Forwarded-Encrypted: i=1; AJvYcCUWP09oX875VT5JEsc95uKtS+2o0tEvXZzzqroNv56AAGWUE6uKpTvPoWx4Vuqid0uQdhO0+8rfEs/tyHIO2jHlEANQtpKku1GDzkC3eTvf4V5QtF785IH75YabLtKMzyEZV9xF
X-Gm-Message-State: AOJu0Ywh8hnc1WkaGvlx37j0Up+NucKlJaPqjrU4sla+p7ufM7NYXhaf
	b5pCxW3yr0INleKf11YDr77/LZb84O+LuqQ29l5oyYXtEBjpl1Ht
X-Google-Smtp-Source: AGHT+IEaPCezIBMexsJ1m8k8liW6LsShUPZYXPBXqhksit7ulmPugMafosBC+eD0gvo63Jc4wBZFvg==
X-Received: by 2002:a5d:4645:0:b0:33e:754e:7f75 with SMTP id j5-20020a5d4645000000b0033e754e7f75mr1108804wrs.16.1709887500073;
        Fri, 08 Mar 2024 00:45:00 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id y1-20020adff6c1000000b0033e699fc6b4sm3089078wrp.69.2024.03.08.00.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 00:44:59 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] tools: ynl: Fix spelling mistake "Constructred" -> "Constructed"
Date: Fri,  8 Mar 2024 08:44:58 +0000
Message-Id: <20240308084458.2045266-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in an error message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 tools/net/ynl/lib/ynl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/net/ynl/lib/ynl.c b/tools/net/ynl/lib/ynl.c
index b9e77af5af5f..4b9c091fc86b 100644
--- a/tools/net/ynl/lib/ynl.c
+++ b/tools/net/ynl/lib/ynl.c
@@ -423,7 +423,7 @@ static int ynl_msg_end(struct ynl_sock *ys, struct nlmsghdr *nlh)
 	}
 	if (nlh->nlmsg_pid == YNL_MSG_OVERFLOW) {
 		yerr(ys, YNL_ERROR_INPUT_TOO_BIG,
-		     "Constructred message longer than internal buffer");
+		     "Constructed message longer than internal buffer");
 		return -EMSGSIZE;
 	}
 
-- 
2.39.2


