Return-Path: <linux-kernel+bounces-52500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA5F84990D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E10DB1C2177D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB67199BC;
	Mon,  5 Feb 2024 11:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="hUONy5p/"
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8A31947D
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 11:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707133305; cv=none; b=WSkn4JxLtBmVhb5Zjv5TIQg2puriQUD98yjQsNtkn99MX2mXOJz8HUJFG3E7MdinSxaYHMyCi1zW3n+rDgBg8Q/f3Hu2IlfuJfaPq+3M2RT431XG1oI0OutLYdY/FdtQtiG1+HHAZ1d5jamUCZRCaLQEi/pvhQHjuFg6FFRkFNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707133305; c=relaxed/simple;
	bh=HZ0nvGaBN5Wk8A4XWPCkZFffRcIQnmcMCoXMFKcitgE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 References; b=S74hS3jfDAIQfVnIzUcc8FZ+6bakgx4qzNtvq2bC1Kk8ng+rfqkCRBcFRCeQ5CoOuwysRleeXyLhri1rEbu+a+WXqLOtzJBQzkd2WVY397ZkYkpj9O+gIdN4tuttjcOUtuQZvezIHbcjBv90ulqxCQl+V5hwFRWxeZM8ZvJ/254=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=hUONy5p/; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20240205114139epoutp03c5e42521f5e0b42192ab59e9738c7c80~w9LDugxvm2972129721epoutp03w
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 11:41:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20240205114139epoutp03c5e42521f5e0b42192ab59e9738c7c80~w9LDugxvm2972129721epoutp03w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1707133299;
	bh=EOGLXpG9HMEKocHPZBogLBBCsSl2pNgppt6+gMxaTpU=;
	h=From:To:Cc:Subject:Date:References:From;
	b=hUONy5p/n5cO3CZKPUNfxh4B3VSAnVKPCRHe6JbMqFW+KYmVmoL+RCClGCd+pfv3n
	 yIF5mwJnpoAGa9kE9B8PMvdi9M8lotcHA1ETnHkKYew15bU46vbemeYenkbbvd0dRR
	 HWnhsRBcURbA9kahftdLgcQfdpX9YkxfBUJnSYN0=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240205114138epcas5p2ad8001def351e326ca13516349412c4d~w9LC8gp0K2986229862epcas5p2_;
	Mon,  5 Feb 2024 11:41:38 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	67.6E.09634.279C0C56; Mon,  5 Feb 2024 20:41:38 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240205111208epcas5p4775d540854dd8778388065a574b7862b~w8xSX8cPM3247232472epcas5p4L;
	Mon,  5 Feb 2024 11:12:08 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240205111208epsmtrp2795d08284788a0322be86253dec2151a~w8xSXIiRI2233822338epsmtrp2T;
	Mon,  5 Feb 2024 11:12:08 +0000 (GMT)
X-AuditID: b6c32a49-159fd700000025a2-b7-65c0c9721711
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	C3.97.07368.882C0C56; Mon,  5 Feb 2024 20:12:08 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.44]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240205111206epsmtip2b4840220644a39cb4b591bc7a2ff1469~w8xQspkMX3117131171epsmtip2K;
	Mon,  5 Feb 2024 11:12:06 +0000 (GMT)
From: Onkarnarth <onkarnath.1@samsung.com>
To: paulburton@kernel.org, mturquette@baylibre.com, sboyd@kernel.org
Cc: linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org, r.thapliyal@samsung.com, Onkarnath
	<onkarnath.1@samsung.com>, Maninder singh <maninder1.s@samsung.com>
Subject: [PATCH 1/1] clk: imgtec: use %pe for better readability of errors
 while printing
Date: Mon,  5 Feb 2024 16:41:55 +0530
Message-Id: <20240205111155.3939125-1-onkarnath.1@samsung.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupileLIzCtJLcpLzFFi42LZdlhTS7fo5IFUg3VNahYfe+6xWlzeNYfN
	onPTVkaLw/PbWCwunnK1WNHzgdWi49tcFouN97It/l3byOLA6fH+Riu7x6ZVnWwefVtWMXp8
	3iQXwBLFZZOSmpNZllqkb5fAlfF6SS9rwX3uihtb1rM0MD7g7GLk4JAQMJFY2h/TxcjFISSw
	m1Fiau8TFgjnE6PE3s4nrBDON6DMm+/MXYycYB27XvyHqtrLKPHn1U+oqi+MEtsXf2UFqWIT
	0JKYcecAE4gtIuAi0btuFyOIzSxwmFHizBF+EFtYIFqi/9pKFhCbRUBVYtbZRnYQm1fATmLR
	mq+MENvkJWZe+g4VF5Q4OfMJC8QceYnmrbOZQRZLCFxjl1j65hQLRIOLxJcjD1khbGGJV8e3
	sEPYUhKf3+1lg7DzJVpmz2KGBECNxNWnqhBhe4knFxeygoSZBTQl1u/ShwjLSkw9tY4JYi2f
	RO/vJ0wQcV6JHfNgbFWJX1OmQl0gLXH/91yoTR4SHZ0fwWqEBGIleq5PY5/AKD8LyTezkHwz
	C2HzAkbmVYySqQXFuempxaYFhnmp5XrFibnFpXnpesn5uZsYwclFy3MH490HH/QOMTJxMB5i
	lOBgVhLhNdtxIFWINyWxsiq1KD++qDQntfgQozQHi5I47+vWuSlCAumJJanZqakFqUUwWSYO
	TqkGJoa1E29IybRGRq+uW+P0sb9JavveG+tY7K6HzPn0SKh42SWzfTJ1a/rmK0SfYtJ/sbpI
	vI9v+uYGxeKc1QkKWxkqcrfznNrrp6l7bdZrscjYSbeTpyg+cKmXPfdHLSfk59+6iz1lO1mO
	v5bS2W8wNeXd9aMhs9LcN3wx8S6e67voY/Dqaxc9Bdl96/8aOvxiZD41JTd4d5vyUuutRbM/
	znh5S7XEmiHm8u2tco2FzX2e0aoGf54GP01ZsyWgZGbz+k3Wc8/kV5T9LUlctTwmfW5C9hmV
	bx0JshP2ntyzWah7+mYX/3LWiU7TV1VJT0+Xb+rrXhNX2tIaE+NmN13vSce0HbWz7CccXHX6
	vi/DOyWW4oxEQy3mouJEAOg5FtGdAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMLMWRmVeSWpSXmKPExsWy7bCSvG7HoQOpBpuOSVl87LnHanF51xw2
	i85NWxktDs9vY7G4eMrVYkXPB1aLjm9zWSw23su2+HdtI4sDp8f7G63sHptWdbJ59G1Zxejx
	eZNcAEsUl01Kak5mWWqRvl0CV8brJb2sBfe5K25sWc/SwPiAs4uRk0NCwERi14v/LF2MXBxC
	ArsZJY59Ws0KkZCW+HR5DjuELSyx8t9zdoiiT4wSrQumMIMk2AS0JGbcOcAEYosIeEjsOvKG
	GaSIWeAko8SdRbdYQBLCApESc7c0gzWwCKhKzDrbCDaVV8BOYtGar4wQG+QlZl76DhUXlDg5
	8wlYLzNQvHnrbOYJjHyzkKRmIUktYGRaxSiZWlCcm56bbFhgmJdarlecmFtcmpeul5yfu4kR
	HK5aGjsY783/p3eIkYmD8RCjBAezkgiv2Y4DqUK8KYmVValF+fFFpTmpxYcYpTlYlMR5DWfM
	ThESSE8sSc1OTS1ILYLJMnFwSjUwJes9t+1luXfhxTLnZXMeVcku8Y0Jv/LlRtkOljcfTZZJ
	SWUKiXud+HCRaeKLBG/HgwmdK1ds6lp/iXP36rq1TLvSQ41C5vyO678T8XDmua9Bd6V+8Mtd
	ZTmVmySyM9J+Bl/zzLSSsMbVb1bufl52P3xTgWFSCKfk+ktMV+4GHE0usVz/4TFX4P7VFpu1
	jXuZvBtT513doD/Bc9PkopxZfir3vtmo7t7DurnjwNQ93yv0Hh1/vvjfuqsFyytfvOPQXOD3
	TrVSV+6694Klqey6Wyv4tDkWp//Z1CAfsshn7urlG+Ps+e94Luo+mb1NvWWazedjy4xKQkJL
	NWz2SOq+vM/ytTooWzvJY+HKBSfPrlBiKc5INNRiLipOBADdWwUnxgIAAA==
X-CMS-MailID: 20240205111208epcas5p4775d540854dd8778388065a574b7862b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20240205111208epcas5p4775d540854dd8778388065a574b7862b
References: <CGME20240205111208epcas5p4775d540854dd8778388065a574b7862b@epcas5p4.samsung.com>

From: Onkarnath <onkarnath.1@samsung.com>

instead of printing errros as a number(%ld), it's better to print in string
format for better readability of logs

Signed-off-by: Maninder singh <maninder1.s@samsung.com>
Signed-off-by: Onkarnath <onkarnath.1@samsung.com>
---
 drivers/clk/imgtec/clk-boston.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/imgtec/clk-boston.c b/drivers/clk/imgtec/clk-boston.c
index b00cbd045af5..db96f8bea630 100644
--- a/drivers/clk/imgtec/clk-boston.c
+++ b/drivers/clk/imgtec/clk-boston.c
@@ -67,21 +67,21 @@ static void __init clk_boston_setup(struct device_node *np)
 
 	hw = clk_hw_register_fixed_rate(NULL, "input", NULL, 0, in_freq);
 	if (IS_ERR(hw)) {
-		pr_err("failed to register input clock: %ld\n", PTR_ERR(hw));
+		pr_err("failed to register input clock: %pe\n", hw);
 		goto fail_input;
 	}
 	onecell->hws[BOSTON_CLK_INPUT] = hw;
 
 	hw = clk_hw_register_fixed_rate(NULL, "sys", "input", 0, sys_freq);
 	if (IS_ERR(hw)) {
-		pr_err("failed to register sys clock: %ld\n", PTR_ERR(hw));
+		pr_err("failed to register sys clock: %pe\n", hw);
 		goto fail_sys;
 	}
 	onecell->hws[BOSTON_CLK_SYS] = hw;
 
 	hw = clk_hw_register_fixed_rate(NULL, "cpu", "input", 0, cpu_freq);
 	if (IS_ERR(hw)) {
-		pr_err("failed to register cpu clock: %ld\n", PTR_ERR(hw));
+		pr_err("failed to register cpu clock: %pe\n", hw);
 		goto fail_cpu;
 	}
 	onecell->hws[BOSTON_CLK_CPU] = hw;
-- 
2.25.1


