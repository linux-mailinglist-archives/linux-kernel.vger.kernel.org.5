Return-Path: <linux-kernel+bounces-83242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0AA8690B6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07C27B264F4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107961386A4;
	Tue, 27 Feb 2024 12:38:45 +0000 (UTC)
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2800846C;
	Tue, 27 Feb 2024 12:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709037524; cv=none; b=RCswz7McYHa7fV1dG+iLUG9swsev+DFUww1/NdFzfKWu6sa8gXdzlELA3owXdItiHj8Z09VPdBjhGymyeYArkvWpPiJTVOES4Lgv52WZXlU7pPe4m/J37kjMrC59C//5RTLWO3pD8P24tCmPFf46IR4CeN2LsulY4yzvmcDT16c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709037524; c=relaxed/simple;
	bh=lsujM0mv8FITF/UZaPoIrOCMeB/1vyXYKbmZ+sN6L/c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=JoDlh59a+3UbB1bYygOIygdiucBjRK1AlnIT9/mJcKg9Gxim2vcggif54onxpwZWCgPg4cQBhKqlk3gZ6IWRHT0z3rkJ96yEugq3BBnc01/U1OfU6+1YvnQSsdM4iE1LtMeH5V327rIltPwszlXLDrIM99xvXN3NyGGlqNsLBUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from linma$zju.edu.cn ( [42.120.103.50] ) by
 ajax-webmail-mail-app3 (Coremail) ; Tue, 27 Feb 2024 20:38:15 +0800
 (GMT+08:00)
Date: Tue, 27 Feb 2024 20:38:15 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: "Lin Ma" <linma@zju.edu.cn>
To: "Jiri Pirko" <jiri@resnulli.us>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, idosch@nvidia.com, razor@blackwall.org,
	lucien.xin@gmail.com, edwin.peer@broadcom.com, amcohen@nvidia.com,
	pctammela@mojatatu.com, liuhangbin@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] rtnetlink: fix error logic of IFLA_BRIDGE_FLAGS
 writing back
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT5 build
 20231205(37e20f0e) Copyright (c) 2002-2024 www.mailtech.cn
 mispb-4df6dc2c-e274-4d1c-b502-72c5c3dfa9ce-zj.edu.cn
In-Reply-To: <Zd3WMs8-nw5SPTZE@nanopsycho>
References: <20240227121128.608110-1-linma@zju.edu.cn>
 <Zd3WMs8-nw5SPTZE@nanopsycho>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5c404af1.2163.18dea92a3e9.Coremail.linma@zju.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cC_KCgC3nzu4191laZahAQ--.39268W
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/1tbiAwUEEmXc3dIXPAACsP
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VW7Jw
	CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
	daVFxhVjvjDU=

PiAKPiBodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL3Y2LjYvcHJvY2Vzcy9tYWludGFp
bmVyLW5ldGRldi5odG1sP2hpZ2hsaWdodD1uZXR3b3JrI3RsLWRyCj4gCj4gImRvbid0IHJlcG9z
dCB5b3VyIHBhdGNoZXMgd2l0aGluIG9uZSAyNGggcGVyaW9kIgoKQXBvbG9naXplIGZvciB0aGlz
IG1pc3Rha2UsIGFuZCBJIHByb21pc2UgdG8gYmUgbW9yZSBjYXJlZnVsCmluIHRoZSBmdXR1cmUu
IFRoYW5rIHlvdSBmb3IgYnJpbmdpbmcgdGhpcyB0byBteSBhdHRlbnRpb24KClJlZ2FyZHMKTGlu


