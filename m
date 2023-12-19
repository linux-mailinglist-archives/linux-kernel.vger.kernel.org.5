Return-Path: <linux-kernel+bounces-5038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F148185BF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B59FB2839B8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B6F214F82;
	Tue, 19 Dec 2023 10:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="X+Km4emo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 017BF14AA5;
	Tue, 19 Dec 2023 10:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1702983332;
	bh=iOGS8KTi6FaODnR4ZId4OaEZT91XmT9apSzLGmTKjtU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=X+Km4emorWJJEvkdcSuMCT1aKHzTK9HTmAPLP6D8PPautMVen+tfGNA5449kO29Zv
	 U8+OyfhxoPdJj2TLana6gHOcnYRwCed7T/tPKBrDARAkDmxyFZ/QxQXPl659/sx53l
	 I3MonnRDfPfSZR0kgUX55RPbSMN4/gnR0/NGhjr0XivWpemyINp9NYTR1VaFroyb6e
	 Q3J7s/BM3639dqZrztTJo8Scp1Q15fmWKJDRsEjRrAKmengZ3J4Hyv7JhpOqVIOrKI
	 0yege23FjUthwxZrSV4NyXOO/hvGaiIWBk9GkCLVQ0Dw6FvzsDE0OfRZNGHzBFezF0
	 M13iyvff5cCzw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5875A3781476;
	Tue, 19 Dec 2023 10:55:31 +0000 (UTC)
Message-ID: <716db737-940a-4a28-bd54-b1dce76174d2@collabora.com>
Date: Tue, 19 Dec 2023 11:55:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mmc: add wp_grp_size node
Content-Language: en-US
To: Bo Ye <bo.ye@mediatek.com>, avri.altman@wdc.com,
 dominique.martinet@atmark-techno.com, rafael.beims@toradex.com,
 vincent.whitchurch@axis.com, Ulf Hansson <ulf.hansson@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>
Cc: yongdong.zhang@mediatek.com, "lin.gui" <lin.gui@mediatek.com>,
 linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20231218224832.81347-1-bo.ye@mediatek.com>
 <20231218230532.82427-1-bo.ye@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20231218230532.82427-1-bo.ye@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 19/12/23 00:05, Bo Ye ha scritto:
> From: "lin.gui" <lin.gui@mediatek.com>
> 
> Detail:
> Add node "wp_grp_size", corresponding to WP_GRP_SIZE
> (write protect group size) of eMMC's CSD register.
> 
> Scenario:
> The eMMC card can be set into write-protected mode to
> prevent data from being accidentally modified or deleted.
> Wp_grp_size (Write Protect Group Size) refers to an
> attribute of the eMMC card, used to manage write protection,
> and is the CSD register  [36:32] of the eMMC device.
> Wp_grp_size (Write Protect Group Size) indicates how many
> eMMC blocks are contained in each write protection group on the eMMC card.
> 
> Final rendered file:
> "/sys/class/mmc_host/mmc0/mmc0:0001/wp_grp_size"
> 
> Signed-off-by: Lin Gui <lin.gui@mediatek.com>
> Signed-off-by: Bo Ye <bo.ye@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



