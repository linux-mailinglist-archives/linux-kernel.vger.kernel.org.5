Return-Path: <linux-kernel+bounces-165963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8688B93E7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 06:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7CB81C20FDE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 04:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50C231CAB3;
	Thu,  2 May 2024 04:38:38 +0000 (UTC)
Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B811CA81;
	Thu,  2 May 2024 04:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714624717; cv=none; b=dLJl1tj07K9BisSnJVvzNvpEVbck6dEINwixO+vRQ3i9xB1vGdjIManw4n4sl4j+ii1yZgLBwAY0d4TjwLpwVN/flUbVaEcJ8ZkyGqxTMMCCyffRb9Fx6tk0lIXPa7PFvd3Azk4ge3Wdh3EBRqKruF5GUAoWj6nQdZjIv+2Uvi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714624717; c=relaxed/simple;
	bh=nZVEqM581s+S8x3I6mrUtERzOfAzZV17VSbW3Waw8yk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=hSPx7NcaRPKludtcKguK54eqJj8xPjTBk/6WOW1zJZegqdSNwphC/vn3y/tS3+CY7CZf+p2i1gTKx/jfmIt161UVZJ7uOTg8u6UvqKtqWjM0zD4Q7AmZ1iqJTVZuxVE8AVZ9wmurBVBI34qOzjVNjyRYx5IVui74nkZ7vM+3oUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from duoming$zju.edu.cn ( [221.192.181.50] ) by
 ajax-webmail-mail-app2 (Coremail) ; Thu, 2 May 2024 12:35:44 +0800
 (GMT+08:00)
Date: Thu, 2 May 2024 12:35:44 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: duoming@zju.edu.cn
To: "Dan Carpenter" <dan.carpenter@linaro.org>
Cc: linux-hams@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, jreuter@yaina.de,
	lars@oddbit.com, "Miroslav Skoric" <skoric@uns.ac.rs>
Subject: Re: [PATCH net] ax25: Fix refcount leak issues of ax25_dev
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT5 build
 20231205(37e20f0e) Copyright (c) 2002-2024 www.mailtech.cn zju.edu.cn
In-Reply-To: <7fcfdc9a-e3f3-49a1-9373-39b5ad745799@moroto.mountain>
References: <20240501060218.32898-1-duoming@zju.edu.cn>
 <7fcfdc9a-e3f3-49a1-9373-39b5ad745799@moroto.mountain>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1402dfc8.20a4b.18f37963e87.Coremail.duoming@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:by_KCgAHlIY0GDNmZQv9AQ--.34675W
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwMJAWYySJ0JcQABsw
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

T24gV2VkLCAxIE1heSAyMDI0IDIwOjQzOjM3ICswMzAwIERhbiBDYXJwZW50ZXIgd3JvdGU6Cj4g
SSdtIGFsd2F5cyBoYXBweSB0byB0YWtlIGNyZWRpdCBmb3Igc3R1ZmYgYnV0IHRoZSBSZXBvcnRl
ZCBieSBzaG91bGQgZ28KPiB0byBMYXJzIGFuZCBNaXJvc2xhdi4KPiAKPiBSZXBvcnRlZC1ieTog
TGFycyBLZWxsb2dnLVN0ZWRtYW4gPGxhcnNAb2RkYml0LmNvbT4KPiBSZXBvcnRlZC1ieTogTWly
b3NsYXYgU2tvcmljIDxza29yaWNAdW5zLmFjLnJzPgoKVGhpcyBwYXRjaCBpcyBub3QgcmVsYXRl
ZCB3aXRoIHRoZSBwcm9ibGVtIHJhaXNlZCBieSBMYXJzIEtlbGxvZ2ctU3RlZG1hbgphbmQgTWly
b3NsYXYgU2tvcmljLCBpdCBvbmx5IHNvbHZlcyB0aGUgcmVmZXJlbmNlIGNvdW50aW5nIGxlYWsg
aXNzdWVzIG9mCmF4MjVfZGV2IGluIGF4MjVfYWRkcl9heDI1ZGV2KCkgYW5kIGF4MjVfZGV2X2Rl
dmljZV9kb3duKCkuIFNvIEkgdGhpbmsKdGhlcmUgaXMgbm8gbmVlZCB0byBjaGFuZ2UgdGhlICJS
ZXBvcnRlZCBieSIgbGFiZWwuCgpCZXN0IHJlZ2FyZHMsCkR1b21pbmcgWmhvdQo=

