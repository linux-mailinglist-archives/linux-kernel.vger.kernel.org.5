Return-Path: <linux-kernel+bounces-99324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A6587869D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 18:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97BCC28191A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2161524AE;
	Mon, 11 Mar 2024 17:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B33ToAQ9"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7423853E0D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 17:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710179287; cv=none; b=HWRi8VaoNyUt5DxnampowbK24XjawOeBVp37INa/AjLnrSqIpnEE5xfY01oNprDF8aPymcHiR3DFE91WtI4A7kr9Ean33fwlmDg7xWkHI1M2ErVNyO7PXp/QxuGRWOp93BQ7TYzFIqBp3HINY18A7cDg6rCvbhfC4Xf5VzH6SPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710179287; c=relaxed/simple;
	bh=QpOspqS1sUE0IbYuXAACK5NlHXEDQgmm6lMqvlqIAUc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=id1zaCOyZUaPkcyQ+mehpnrNQahZe3vSbN4/wWJT+M/NnT5uUAFoKwH+yLddmxpmvMfb7H20F2zsU6plIVXtmB5GNaBHlEr1aT6zvz/UcCGFABejVz34hdB/cqX+jinES0TbYU6Q8rTFCeMoqpAky3omGiahptpOWJ521f0TVDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B33ToAQ9; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-56838e00367so3457669a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 10:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710179284; x=1710784084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rNZf2SCv2RklLk9YcBHwBHEt4OlXPV3XYvDGnMvMDSE=;
        b=B33ToAQ9/VzPjElWLzki8ihodR7YBO0BYNeL11jiz2do+idtRSSxWPpc+Xxg6Cq/Rl
         rBqthFDYUk6n9qi5milxgh8ilNBvf5PWzyIFj+qKDUAFvyBchjNniHECTJhx72GunmBy
         aVYhJJPy08+uBo22mPcqXBsyUEJmKv+0wO5IRNhERlZ+DbFeledykIYArVzmlZdmurKU
         rL0sfslzFUP8tb7AzD4ZC8+P//Ih/B5E3JxRjbrqNOHrYRCWOyuXncqnv4C7jG7FbkAQ
         u4fyOiJ5PfW8kVf33z4sEjwHpJkjCtFp7Mg2OYvUBP41KiQS0/8Tcqd4Ew94p3//iUZt
         WiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710179284; x=1710784084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNZf2SCv2RklLk9YcBHwBHEt4OlXPV3XYvDGnMvMDSE=;
        b=Fv/yIv3FcKXQan0SQx9DoELOfVfpRnjvusI+61kqXUHJJT4jXfEm3E++E9xJ9td9FS
         sqgqHECPgahMWj+b1lgz7nXBg7CPC7TlHBes2dlmSGv8bZZ4F2nZvXwsKmlzBqOKLuzH
         qAQwAINyfCZvNXcNdj+MF4VbJr+SVi0uaqk9ckK3uDwcYgjLZnrrcKqdCs1mLtFbQb1y
         IWBZchBAKnBTnmNnLYxvqQOZfrZp8eRVyWlFvbewswIaDsv30sfvZOeOFY6P313zVGJS
         gIhRWZYEVKggyGhgNwXKkwLv4akeMhMb9btBlk8N/cunGUqaHRPEGYj1RBvfyxaJClVm
         IkTw==
X-Forwarded-Encrypted: i=1; AJvYcCXW0GRXmTCr3RwAzS+OxYM2HiBRgwFhl5bpT6VOMwvUdIFdbio30LmOSntXarjdEcxw91p4X1iC0huf7Ei1WGZPZwP6HBLe4jcVRH4i
X-Gm-Message-State: AOJu0Yygs+qDe12iAZgVfrZ52C7OseTMFi2WBLW4Ec21oYJroFNY3VCb
	vQESWekCYrz/F4xovTLTOc5Wa/avxPcXRxAlP2PBcN+LZdyOSllS
X-Google-Smtp-Source: AGHT+IEfEpXQwgYNY3cU0+74crCvKEyvf16zoIYvSnDxGZ9ZsZ7oxhece1/qUyzG7NgURAtrn4p4CA==
X-Received: by 2002:a50:cd4d:0:b0:566:ac89:b7d5 with SMTP id d13-20020a50cd4d000000b00566ac89b7d5mr776040edj.28.1710179283586;
        Mon, 11 Mar 2024 10:48:03 -0700 (PDT)
Received: from localhost.localdomain (89-76-44-138.dynamic.chello.pl. [89.76.44.138])
        by smtp.gmail.com with ESMTPSA id r24-20020aa7d158000000b00568525ab2e8sm1757060edo.55.2024.03.11.10.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 10:48:03 -0700 (PDT)
From: Kamil Kasperski <ressetkk@gmail.com>
To: wens@csie.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Kamil Kasperski <ressetkk@gmail.com>
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: sunxi: add T95 string
Date: Mon, 11 Mar 2024 18:47:48 +0100
Message-Id: <20240311174750.6428-2-ressetkk@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311174750.6428-1-ressetkk@gmail.com>
References: <20240311174750.6428-1-ressetkk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

T95 is a commonly known as series of cheap chinese TV Boxes with unknown brand.
Since their Android OS is built from Google Pixel 2 sources, all footprints metadata contain Google strings.
Let's assume the vendor of these boxes is t95.

Signed-off-by: Kamil Kasperski <ressetkk@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index dfb834a9279f..b9b6a72545a5 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1381,6 +1381,8 @@ patternProperties:
   "^synopsys,.*":
     description: Synopsys, Inc. (deprecated, use snps)
     deprecated: true
+  "^t95,.*":
+    description: T95
   "^tbs,.*":
     description: TBS Technologies
   "^tbs-biometrics,.*":
-- 
2.34.1


