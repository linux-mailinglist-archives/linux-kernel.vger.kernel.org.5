Return-Path: <linux-kernel+bounces-80072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CF0862A71
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 14:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24002281B32
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 13:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607D2125CD;
	Sun, 25 Feb 2024 13:23:08 +0000 (UTC)
Received: from zju.edu.cn (mail.zju.edu.cn [61.164.42.155])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CFF469E
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 13:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.164.42.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708867388; cv=none; b=LqpY8YW2g0LVsFrgYxGhNFWG4fW9dnWKcpKXHV5Js6kplVFh6YphPoJ3J1PfOCrzREzywtv5pu6KAAmsHBA/autC7vZyS+GhYY4cu/4/C0Xseln0jOT8Fw3p+GNWJuKYyJ+LUtUCYzNu4BJ2TIY5Dpf3GJDb1Jq07L79ihd8uXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708867388; c=relaxed/simple;
	bh=60sYbWBmge7Xzbh8egiim6S9WHR7I+xSNbMjGS+ranA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=NWfzRNWRggJMM2okbCObrh3ne6+NkBztP/WMeUuCZIkwNfJh1I6pXk5KEaBMkzzvCk/Ffy2i0aQE2pdkmlY6SYmDIjQPCfcTkhSXYy7TnlFprtJUoGxAz3OrzKIJXHW9EYvTeCZPYIJxy96J1fwLqj+gJCBhAVVq2ao9fjYot/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=61.164.42.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from duoming$zju.edu.cn ( [218.12.16.226] ) by
 ajax-webmail-mail-app2 (Coremail) ; Sun, 25 Feb 2024 21:20:07 +0800
 (GMT+08:00)
Date: Sun, 25 Feb 2024 21:20:07 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: duoming@zju.edu.cn
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	andrew@lunn.ch, gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com
Subject: Re: [PATCH] ARM: mvebu: Add check in coherency.c to prevent null
 pointer dereference
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT5 build
 20231205(37e20f0e) Copyright (c) 2002-2024 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <Zdsky9nVdwP6Ry0E@shell.armlinux.org.uk>
References: <20240225060450.53044-1-duoming@zju.edu.cn>
 <Zdsky9nVdwP6Ry0E@shell.armlinux.org.uk>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <38bb64c0.1341f.18de06c41e0.Coremail.duoming@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:by_KCgBnja2HPttl+S40Ag--.37794W
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwICAWXaOtIIuQACsm
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

T24gU3VuLCAyNSBGZWIgMjAyNCAxMTozMDoyMCArMDAwMCBSdXNzZWxsIEtpbmcgKE9yYWNsZSkg
d3JvdGU6Cj4gPiBUaGUga3phbGxvYygpIGluIGFybWFkYV8zNzVfMzgwX2NvaGVyZW5jeV9pbml0
KCkgd2lsbCByZXR1cm4KPiA+IG51bGwgaWYgdGhlIHBoeXNpY2FsIG1lbW9yeSBoYXMgcnVuIG91
dC4gQXMgYSByZXN1bHQsIGlmIHdlCj4gPiBkZXJlZmVyZW5jZSB0aGUgcHJvcGVydHkgcG9pbnRl
ciwgdGhlIG51bGwgcG9pbnRlciBkZXJlZmVyZW5jZQo+ID4gYnVnIHdpbGwgaGFwcGVuLgo+ID4g
Cj4gPiBUaGlzIHBhdGNoIGFkZHMgYSBjaGVjayB0byBhdm9pZCBudWxsIHBvaW50ZXIgZGVyZWZl
cmVuY2UuCj4gCj4gQWdhaW4sIHdoYXQgaWYga3N0cmR1cCgpIGZhaWxzPwoKVGhhbmsgeW91IGZv
ciB5b3VyIHN1Z2dlc3Rpb25zLCBJIHdpbGwgYWxzbyBhZGQgYSBjaGVjayB0byBqdWRnZQp3aGV0
aGVyIGtzdHJkdXAoKSBmYWlscy4KCkJlc3QgcmVnYXJkcywKRHVvbWluZyBaaG91Cg==

