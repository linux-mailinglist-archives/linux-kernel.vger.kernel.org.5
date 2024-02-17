Return-Path: <linux-kernel+bounces-70040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F4B85922F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 20:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17E7E1C21734
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 19:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDB57E58A;
	Sat, 17 Feb 2024 19:45:03 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B4B7CF2C;
	Sat, 17 Feb 2024 19:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708199103; cv=none; b=CsEqrxcKthYz8q1IF+3uV9id8f9g+4hhrj658x9FsF86PSSYxjYmlMDcHgqGqYJNkerabgFiuYmWaN0JPM7iMb71M0SX5J0mih0h7vNeSZiRdHg7Mn4qXS3hW4t/kiTQJJzI3tw8vfq8jIJweSJN1LQgar6/WJWJ9w6CLn9YWes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708199103; c=relaxed/simple;
	bh=/ClP/g3jt0iF43oyMub7Rq699tZLH1yRu5G6Rpzq7Ks=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=Gd2UvcgVTUpU1oILqZA1FuH6oh6u13jSMrHP9HLLDVlPv/h16U5qNzFHhKdBKCT38BJEDk6gfsyTaaBIcIwV08Uv++3HRVehBmcE+aox7yaToBGZ5pwTgKUJOxwZo363fe+Ssrh19g7UFTsMnUvDg24SWFIxTSM8Nx/gE+yEU6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id C5D281C0269;
	Sat, 17 Feb 2024 19:44:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id 0EEA320025;
	Sat, 17 Feb 2024 19:44:56 +0000 (UTC)
Message-ID: <102e5c65e07ebdade5400ca711fba131a37027a8.camel@perches.com>
Subject: mediatek: media: Missing alloc null test
From: Joe Perches <joe@perches.com>
To: Tiffany Lin <tiffany.lin@mediatek.com>, Andrew-CT Chen
	 <andrew-ct.chen@mediatek.com>, Yunfei Dong <yunfei.dong@mediatek.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Matthias Brugger
	 <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	 <angelogioacchino.delregno@collabora.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek <linux-mediatek@lists.infradead.org>
Date: Sat, 17 Feb 2024 11:44:56 -0800
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 0EEA320025
X-Rspamd-Server: rspamout08
X-Stat-Signature: jtj5gxkjrn6psxqbp7ktoek7c5w55gzq
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/mi3Mj5scL1ByOsIwBfWZOxpOvRRYeA7Y=
X-HE-Tag: 1708199096-891621
X-HE-Meta: U2FsdGVkX193Saf57q9yIF6MDuyE5/FDuYOW0Jg6+JkwL2LwrgbYynYObJBWcqCClxlv4MeR25Rb48n5OI1kDPWQaZCTPjJiFzlCnThe+luGs/P1grkpEswA4zNaoAOWJxt6LVHEq7FF5DaqtJLR0sBuNMMuwYV8MGShqen58zm0lAaMXpzxFzD6FKbX3KYS+ux3tYQQhalVyv3kB3KbJ8nJknEFY08TAGSN/kxcfcmejaBHtHI5ngt+k8fiLwu8iRg67fftVlJHRv53JNdp9oAWcLtn5U/CnNtuWtijsWOJPl/z7AUNDgM4zaNPSQQ+

There's a missing NULL alloc test here:

It doesn't appear obvious what a proper fix is.

diff -u -p ./drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_sc=
p.c /tmp/nothing/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_f=
w_scp.c
--- ./drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_scp.c
+++ /tmp/nothing/drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_f=
w_scp.c
@@ -79,7 +79,6 @@ struct mtk_vcodec_fw *mtk_vcodec_fw_scp_
 	}
=20
 	fw =3D devm_kzalloc(&plat_dev->dev, sizeof(*fw), GFP_KERNEL);
-	fw->type =3D SCP;
 	fw->ops =3D &mtk_vcodec_rproc_msg;
 	fw->scp =3D scp;


