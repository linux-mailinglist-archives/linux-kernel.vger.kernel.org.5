Return-Path: <linux-kernel+bounces-62306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 583C0851E55
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9C87B24167
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09C94CE17;
	Mon, 12 Feb 2024 20:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="c4zIn2tb"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2C84CB46
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 20:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707768280; cv=none; b=DO6fwgPcKuOI2XLlJ0QLJjIAHumpH6G6R8c64X1XZRdt404Mwl5OpfinCsp8i1PDn0+SrloeixtRj2VZZACjDd0cdkQ8DJyrhJMMRdBy/GfQPW3Z8ssDUDnKf/N7rERcWxrxTLCPfR6mX+ti8SvP51wNa+gBpr+4CnMrhZkk+mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707768280; c=relaxed/simple;
	bh=4ZVBO+ZZ7qJwYsFNWtQW7anbtRxiXhpsOjP25YzoSmg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pPg+IksD9v45u31jtMDY23mRU9KC2nQWMK/kqWlaZkcyyVVsLf/lS4mVwLamZaJsBsilIb5R8VoBjG5iRUj6S/nVNjXqSe9PNUQeKy4ICBiaNp8Xs1p5NWowY3V4p9aOGXNavEEDcE0lKl+3k5Nv2pPxLdH9FwmIFT98KGqyby0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=c4zIn2tb; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d76671e5a4so29911465ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 12:04:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707768279; x=1708373079;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IRMd3DmLaPwuNfy5qvMqAI9wlvK5phDwU9Cy7L0yCdE=;
        b=VsD8yadLuUeSW1Uxu0h1JExm7tYbwEjWB86Qp6MjLvEF/H+jmBOklC39ZkUzU7bU95
         LPNAxZ9AlOmZhbaMadZHht8UXxMYUbRzvhNLddSs+FnNOFzV1vT134uq/PzA6gTmNl9x
         NPfRTGArEw/XImJzYuuGe0BsVjHYppTt6mO/77sAmbJEJQuwr5QjrUlZhFZgaLtWwOkq
         q4Ee8cB8pceWbM0huUG7kFFzwJcwMdYtku4SL8l2FmjtXlP9GB6Q5PJo5qAA1eXepzbH
         f7tOptN/UtyWeQyECOgS34OdWnRt72z9J6J/jcl49k7RQmhcR9dLgoHZ6ZaHlZ30Jzkh
         MPrA==
X-Forwarded-Encrypted: i=1; AJvYcCWy63SuJ3NKmRaeYdjRt7ijSWCdaC6rlUOukhToA6dpAWV8Ylt4v5djp5g1ui83tq/rjjdoVH/i+E5hIKrAEPyIaIE7SXPgPyufMZmm
X-Gm-Message-State: AOJu0Yx0gVzURaYUTcN469Cxe0riFANudgQWaFa1dSAgng3s5cHhzsLu
	0H7sb/cru0VGXsyAaB4U5HHq1tVC8+HU/JmQy9E+Rd4AHGdHnC2F
X-Google-Smtp-Source: AGHT+IFKbcCkA7hnAphfFgB3xshq8pHJCg/OH5SAQH4+dskke83Nn5QL5JYsJy04y/+28TkJejXDUA==
X-Received: by 2002:a17:902:e88a:b0:1db:29c2:b695 with SMTP id w10-20020a170902e88a00b001db29c2b695mr1426718plg.41.1707768278917;
        Mon, 12 Feb 2024 12:04:38 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXIOq0hF/hPZhlh32fYalDvFXC50l3uTYP7hWSp53+wbYCWPD2U7Vnt2zNEe0fbKw/ztcM5EpHruheRt4S22jq14gk7kSPwNdXAd1xZd/3ugxhg+bZZtGsKQIvXGpXPEw5ot+K28yTs5goz5anrzjYvZHlhfXgHmE60+plzST2cGcJjO0FTHpNyKvxPdYLf5QPXp4DMTfwacyxhS9A1MSzNK8wWioUVDLtt6kaNqvEdET6EkP9On3OZd0FMVjvDBi4YZcL0cCvtShqWxNuA
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id l4-20020a170903244400b001d8aadaa7easm722394pls.96.2024.02.12.12.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 12:04:38 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707768277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IRMd3DmLaPwuNfy5qvMqAI9wlvK5phDwU9Cy7L0yCdE=;
	b=c4zIn2tbz7DFJpPM+h4TYSt72F581hIWGPMZ+GP0MavbXRgsAwG9eiMvW1/B3iNTvx+Ph5
	shCbkAJuNCo1mRxMWL9VNjqDhSBJFKPiaU7uuFd5i8JttlVeJP6cypsUewlXtv2GdO8tRC
	OpGan+0/nF2g10lB62EDjACYeT4I6vMv1sqmih/drcSfZd0tcZnAndH9kUk9EsBZpzz4P+
	RepKnvlD4Ra8SiHFIR75HIA9z6TVQm5FqO82oepZZjDnacdHRjHbx1CglO3hq0AyOIQLe6
	azQ0zyyWA9Qw+jQMNsJl8fxC/G5t3wGSyL23nJEFzN4GgfFm3nqpOdj43M0XBw==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Mon, 12 Feb 2024 17:05:02 -0300
Subject: [PATCH v2 4/5] powerpc: pmac: make macio_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-bus_cleanup-powerpc2-v2-4-8441b3f77827@marliere.net>
References: <20240212-bus_cleanup-powerpc2-v2-0-8441b3f77827@marliere.net>
In-Reply-To: <20240212-bus_cleanup-powerpc2-v2-0-8441b3f77827@marliere.net>
To: Michael Ellerman <mpe@ellerman.id.au>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1614; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=4ZVBO+ZZ7qJwYsFNWtQW7anbtRxiXhpsOjP25YzoSmg=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBlynnv/PyVOgYd2KioAchyKJniQdC3OK4ih9i3z
 OsxAU/kd92JAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZcp57wAKCRDJC4p8Y4ZY
 ph/CD/0RYe4KY9dYDXRqeYmp4qRRSwGRmT9hPk6kjIJFbgBXGecdcHXlNKVqPQr9d7p4lPydOTO
 U83sQwz3r9UwkhC/yl2h9/2SoDTq2zyko5a34Ll+Iluxlr6BYlZNughubGVIJ9vZawZQKHaQtZs
 G4cSss9vMQSmSdm18aWOYTDhYJgYSdhVakInGFV3WqOKjNrOxhUI95lsYI8TYZrB5W1x0a3CGFY
 muRnV6/RzblkFVSGoU6R/vyJs/u1+X6Xp1cRVyr9MxMxJNqLuLH0NGbDnaHVVOcpPVbXA0FKHFH
 LSLJZ+s+bFuPCak+Iahex9CpyyQnxY3pfNKBnoQVdAe9QLuT6KyLsn5YtnsQRncNIz/Ni0OwMkP
 g0SodtetAf9V/l3MdY3SMjz2qKqLYgPP6uzScXbi7YN1XwzWTEmwzNkcLMbFwvLLv1pubhfVolu
 QRqiAqO7JkMLBQe7MsfTqdQ+mfev67du1MR4pePULICnFRBY7lBdVLjsDepRu5q1D5OaCDe56aM
 RPq0al7Iff/wG6oi/LdJJrONKHtBU+taar+xpcVYVyquc/PTQkxjrx03xq1Ec43Kiq8rJTopwYs
 1mJVkf/n3ywVGC/x153u6FzchRyTRn5//f2gzcyNZZ1448srkQZBO8uiEw0NQnvuyGKbEqAZfM/
 Vn++nulIlYLNpuA==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit d492cc2573a0 ("driver core: device.h: make struct
bus_type a const *"), the driver core can properly handle constant
struct bus_type, move the macio_bus_type variable to be a constant
structure as well, placing it into read-only memory which can not be
modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 arch/powerpc/include/asm/macio.h | 2 +-
 drivers/macintosh/macio_asic.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/macio.h b/arch/powerpc/include/asm/macio.h
index 3a07c62973aa..ab9608e63e40 100644
--- a/arch/powerpc/include/asm/macio.h
+++ b/arch/powerpc/include/asm/macio.h
@@ -6,7 +6,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 
-extern struct bus_type macio_bus_type;
+extern const struct bus_type macio_bus_type;
 
 /* MacIO device driver is defined later */
 struct macio_driver;
diff --git a/drivers/macintosh/macio_asic.c b/drivers/macintosh/macio_asic.c
index a5ee8f736a8e..565f1e21ff7d 100644
--- a/drivers/macintosh/macio_asic.c
+++ b/drivers/macintosh/macio_asic.c
@@ -136,7 +136,7 @@ static int macio_device_modalias(const struct device *dev, struct kobj_uevent_en
 
 extern const struct attribute_group *macio_dev_groups[];
 
-struct bus_type macio_bus_type = {
+const struct bus_type macio_bus_type = {
        .name	= "macio",
        .match	= macio_bus_match,
        .uevent	= macio_device_modalias,

-- 
2.43.0


