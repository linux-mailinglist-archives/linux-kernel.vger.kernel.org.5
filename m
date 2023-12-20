Return-Path: <linux-kernel+bounces-6624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 307A2819B27
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62CE61C2160A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3F11D6BC;
	Wed, 20 Dec 2023 09:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kZKl2bv/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1359E1D6A6
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 09:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 45BCFFF803;
	Wed, 20 Dec 2023 09:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1703063562;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3mCR1Dvkv7wQjJFGFcVOYbaNhzlOz828ZxpONDrKsmM=;
	b=kZKl2bv/JZArh4wgtRB1PTgVMI++06p/qE65ClLqBtmLOgYiGaw6yJMamCd9sQNcly8xAh
	JgJ2MppHZH36qamAt81YoGAYCg1EBViWzIlOfvnLfW8BhjH8a+zG6FaTFzi2xDrsXS6osZ
	Au5eHDhwNgnuGdoi6Z7JF5piHSNg0tliX3KHCHzxS4Ke9R4SoXiR8GCR7OOqvLo+ajEbWv
	fl4bmJBtmWR1+rcJEUPsA4v2uyAejUvZOCNA6hIKM3qsDqoqa9/ocJeWV/33gzmbtrplKG
	S3b+4kyo70MchMFYwXr/qL0FlRbKpPEoXBqFMzv9JfQ+Gusl9WGO+J5v+fLvaw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: ZhaoLong Wang <wangzhaolong1@huawei.com>,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	dpervushin@embeddedalley.com,
	Artem.Bityutskiy@nokia.com
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	chengzhihao1@huawei.com,
	yi.zhang@huawei.com,
	yangerkun@huawei.com
Subject: Re: [PATCH V4] mtd: Fix gluebi NULL pointer dereference caused by ftl notifier
Date: Wed, 20 Dec 2023 10:12:40 +0100
Message-Id: <20231220091240.655350-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220024619.2138625-1-wangzhaolong1@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'2fb802a9c52d326d0d9c32962fb701fe0ed3eb39'
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com

On Wed, 2023-12-20 at 02:46:19 UTC, ZhaoLong Wang wrote:
> If both ftl.ko and gluebi.ko are loaded, the notifier of ftl
> triggers NULL pointer dereference when trying to access
> ‘gluebi->desc’ in gluebi_read().
> 
> ubi_gluebi_init
>   ubi_register_volume_notifier
>     ubi_enumerate_volumes
>       ubi_notify_all
>         gluebi_notify    nb->notifier_call()
>           gluebi_create
>             mtd_device_register
>               mtd_device_parse_register
>                 add_mtd_device
>                   blktrans_notify_add   not->add()
>                     ftl_add_mtd         tr->add_mtd()
>                       scan_header
>                         mtd_read
>                           mtd_read_oob
>                             mtd_read_oob_std
>                               gluebi_read   mtd->read()
>                                 gluebi->desc - NULL
> 
> Detailed reproduction information available at the Link [1],
> 
> In the normal case, obtain gluebi->desc in the gluebi_get_device(),
> and access gluebi->desc in the gluebi_read(). However,
> gluebi_get_device() is not executed in advance in the
> ftl_add_mtd() process, which leads to NULL pointer dereference.
> 
> The solution for the gluebi module is to run jffs2 on the UBI
> volume without considering working with ftl or mtdblock [2].
> Therefore, this problem can be avoided by preventing gluebi from
> creating the mtdblock device after creating mtd partition of the
> type MTD_UBIVOLUME.
> 
> Fixes: 2ba3d76a1e29 ("UBI: make gluebi a separate module")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217992 [1]
> Link: https://lore.kernel.org/lkml/441107100.23734.1697904580252.JavaMail.zimbra@nod.at/ [2]
> Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>
> Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Acked-by: Richard Weinberger <richard@nod.at>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel

