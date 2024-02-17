Return-Path: <linux-kernel+bounces-70053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D983859262
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 21:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6B04B2221B
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 20:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887A47E76D;
	Sat, 17 Feb 2024 20:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="JqNilKw+"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6462F7F465;
	Sat, 17 Feb 2024 20:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708200783; cv=none; b=WWcGKQhrkti+EtiyDzsTVsMtJSYBisR/c9gaxo54caUkq6GR3E/O+jcO6VlE/Fek7jVYfhftUbbYCMEqrj3JPLOoROn7OwySWglir5t2T4oP6QB2XQ2ffL386h5cstFN9rUI2kY8dYYQ0tHS1Gk4L7t/x3Yl5zABS3g05OrG7YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708200783; c=relaxed/simple;
	bh=se30nhUuFONi/uLGCt1oGU+KS30rvXjwHshvsRJBdW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t0wByAV6hG0/lMDlWbY5Dt0jS4FE6Dj+tF0VaSOzeTRYrkYq2p6p7o7admk8Q4ypxEG76lJKHj6WgAmXzQwxvTTR4ibTdOlQNq0f2dMCUQaViRu7fAi/ICCPMhcRSASVMvQceDQV1cnSJnQ4kvj/oE0AawRpDXzA3QrtBkqQ4vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=JqNilKw+; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2907a17fa34so1490019a91.1;
        Sat, 17 Feb 2024 12:13:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708200782; x=1708805582;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:dkim-signature:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PBOYLPxL42yes/PWt0k3rULnYxEYTLijjIvk20QuDbY=;
        b=mN00kAG+/S+g915xTCnYNz0m6ot9pKS7pXzVwOingNOVR8pvkQtCMexaa07YFR7lnm
         hzpVNkQyD51JqAh172tFcph3/Wc/ncPCLih22nVyZOJ8yDEZGGubd9dAJolhGbh/qUrT
         NYyuxST9ArFpa4L7XbiJTiBubogU3xQD3l9PNKVSXX973kSHIXlkYdSm2mwr4vHEPfu8
         WQg0PORoTNs+yh5nAq+16JSV4wiRNli5qXMkV4on1BWJqhCxB25NZYqt2mcVHLdI7FRL
         +i+2THEJDd7nR+ASHezJCMdLBI/ylQc33cP+Fv5RCkebhtI2aBe2CsTcGdiwyMYX6QRp
         O7pA==
X-Forwarded-Encrypted: i=1; AJvYcCXGbXbZq/Uq0wvNk5gK3mjVoGj+oGsjMi2JlptOnztHUiWCBnn7a9hNBe3Xjez3C4igEEuxlPyvBRZWGLfvzKvynsOgkuQW9T/dHhyq4WjlhpWIOccKzKS+d2xk61ym1lKEHdJx1QkM8b5jYbljjI4C5cirBZESwvSRUHFmJvGKHcgt
X-Gm-Message-State: AOJu0YwSeRRMk/UV/k+kOKz41+MEUkchlyEof8il0XAb8pDgl+YZYY/j
	QOIPc1m1bZn1a4V3ZVJFX1h/s3OGyCT/3Qnk0RrfFqHPlEsx78DY
X-Google-Smtp-Source: AGHT+IGH9zvr0co3d5o5vWao4dRSzpuMZZKrFjpMQb3zg05GpPcxoqIB4QJJURIfa1KbVo/JLqPtGg==
X-Received: by 2002:a17:90b:3104:b0:299:4a62:548a with SMTP id gc4-20020a17090b310400b002994a62548amr3305069pjb.34.1708200781761;
        Sat, 17 Feb 2024 12:13:01 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id sw8-20020a17090b2c8800b0029732fc0154sm2250531pjb.3.2024.02.17.12.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 12:13:01 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708200780;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PBOYLPxL42yes/PWt0k3rULnYxEYTLijjIvk20QuDbY=;
	b=JqNilKw+JiKmfz0GVkhgq7XpaNJI6HKcCgz/uOViUOJ1FNMCAD1/gTJu+aDUBLKDXajmmN
	w1/CmMciuHZS4LFZ4I21EhcmZ1OovQ5coDXE3e56vhsJp8/EOE2CxHCRE3ebMao1X1tesl
	kWxA4nUJMwUxsF00drryb5FRq2OaIXZMU22YVwwrY8oXA+9fx7JNqWimTwrrdkAY6IYMvX
	Fh2kzJLq8yRtujM3VqU48+AKZVaoeAjB8rB3iqhAon4YBqXa3erp3EyNDkU2jjARI1N+fz
	zwE6NCwlGhpXtChCThiVK1PsUP3z4UIpe6hK2nJe3o35yjk2ckY6eskEOPBf4g==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sat, 17 Feb 2024 17:13:24 -0300
Subject: [PATCH 02/12] net: dsa: constify the struct device_type usage
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240217-device_cleanup-net-v1-2-1eb31fb689f7@marliere.net>
References: <20240217-device_cleanup-net-v1-0-1eb31fb689f7@marliere.net>
In-Reply-To: <20240217-device_cleanup-net-v1-0-1eb31fb689f7@marliere.net>
To: Oliver Neukum <oneukum@suse.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, Roopa Prabhu <roopa@nvidia.com>, 
 Nikolay Aleksandrov <razor@blackwall.org>, 
 Loic Poulain <loic.poulain@linaro.org>, 
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, 
 Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bridge@lists.linux.dev, 
 linux-ppp@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=865; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=se30nhUuFONi/uLGCt1oGU+KS30rvXjwHshvsRJBdW0=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl0RNssKuhjoSlZTHECtiMIBdkIEL28xUnFQ38I
 2zmenOBuNWJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdETbAAKCRDJC4p8Y4ZY
 prBdD/9iyEhb8C4N0+XlW3uqQ0xH+mL4ImMhFfh9kTu7FUUegRqrSbGwM3ZBFeeyxnRURCE39q2
 MyiwIsVfpHzke7X/+mUHa5qgvaj6N8Dzm4D1nx5+u38mC2BEps9ADFpTePIltG3ppcdHaGT5iph
 lSRn102lBOGujFj9EOXNOf0FnCynoKUrzJkI/dOvfHkrxLMt/H5SaHxAZ+S0skhRi9ELs+l0CPZ
 fKpimJe8iie2cn7ZuwwVNovf+5Df5MUXVjBvk0Hn89I1RmR7Y09pZgHtvTdbZRfK6Cgp2YTE17Z
 TGBYzdgfe/Fu1k7NjbXcqMXR7AgoLH2gkAq092wObtav53JL3OWBblFY+y3mIRbSiXll4Tkd3fR
 Tw089lRUtqgiKY13rj1RHIGHJqmwImEkGCTdti8fdf8AVuzir8O+v+/ZoihaHOZkhqHZwtYrL/V
 0gbqdhWKRw8h0yXFSpwa9D3oZXCMaam14yO6mpJHGxb+33pejg0FjuHnolAtXgehm17w5qfEXOG
 UreSUahijZAmJqBaGbz0lqbVTXeSmKs7S6HnuNKbcO16AKvZ6Z3o8uBMG72rnlOh0s+QWdrKmXH
 Aw4NRjoubGBlaWG1oYzJ7+UnzBz0xStTtot/eFUP1fWheXTbaIHlfOQgwCmPctV6qVbxH5iBJyz
 C3vc2a0HMEEBY0Q==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Move the dsa_type
variable to be a constant structure as well, placing it into read-only
memory which can not be modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 net/dsa/user.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index 5d666dfb317d..4d53c76a9840 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -2429,7 +2429,7 @@ static const struct net_device_ops dsa_user_netdev_ops = {
 	.ndo_fill_forward_path	= dsa_user_fill_forward_path,
 };
 
-static struct device_type dsa_type = {
+static const struct device_type dsa_type = {
 	.name	= "dsa",
 };
 

-- 
2.43.0


