Return-Path: <linux-kernel+bounces-78313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1488611C2
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F6A2B213EA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC21B7B3F8;
	Fri, 23 Feb 2024 12:44:35 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D3B6FBF;
	Fri, 23 Feb 2024 12:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708692275; cv=none; b=FY8wDnJJEM+WUhhvYU2C+xGfhZKEIqATKCnipQzlOVKG065c8JRsw1/FN9dAOfvKzTD1zNoXXt323Ngkc2dgrx6tPIQmVpuKFkvWZ8FzJb5nvoFEezq0k7dRE1KSZcZ10GIrmdXVIMGcU7OpHxnmgs+vNlyu0wx9jtghW6ujje8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708692275; c=relaxed/simple;
	bh=Ql3pU3hgr/HBpSrJX8jkClVU8sHud/H6CmtnLarbOp0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iIOd3RDu4KKYxEue9J0LXjHnHHNYonnhsJbyx5M9YLv5g7wX2rM1YSoBDEb23xRBbAG5qHtBOGnBZlZkXNzIK7PHIg+/W7HUpeCTRq57TKEGCL4L0OS5YiwRBBam77dG04sTnvof7f+SLa49LIIwr9doy5JgmXz/A+qll7hKNcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Th8kW2Sfdz6K8q3;
	Fri, 23 Feb 2024 20:40:51 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 45E05140D5A;
	Fri, 23 Feb 2024 20:44:30 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 12:44:29 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-iio@vger.kernel.org>, Rob Herring <robh@kernel.org>, Frank Rowand
	<frowand.list@gmail.com>, <linux-kernel@vger.kernel.org>, Julia Lawall
	<Julia.Lawall@inria.fr>
CC: Peter Zijlstra <peterz@infradead.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, <marek.vasut@gmail.com>
Subject: [PATCH v2 0/4] of: automate of_node_put() - new approach to loops.
Date: Fri, 23 Feb 2024 12:44:28 +0000
Message-ID: <20240223124432.26443-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

The equivalent device_for_each_child_node_scoped() series for
fwnode will be queued up in IIO for the merge window shortly as
it has gathered sufficient tags. Hopefully the precdent set there
for the approach will reassure people that instantiating the
child variable inside the macro definition is the best approach.
https://lore.kernel.org/linux-iio/20240217164249.921878-1-jic23@kernel.org/

v2: Andy suggested most of the original converted set should move to
    generic fwnode / property.h handling.  Within IIO that was
    a reasonable observation given we've been trying to move away from
    firmware specific handling for some time. Patches making that change
    to appropriate drivers posted.
    As we discussed there are cases which are not suitable for such
    conversion and this infrastructure still provides clear benefits
    for them.

Ideally it would be good if this introductory series adding the
infrastructure makes the 6.9 merge window. There are no dependencies
on work queued in the IIO tree, so this can go via devicetree
if the maintainers would prefer. I've had some off list messages
asking when this would be merged, as there is interest in building
on it next cycle for other parts of the kernel (where conversion to
fwnode handling may be less appropriate).

The outputs of Julia's scripts linked below show how widely this can be
easily applied and give a conservative estimate of the complexity reduction
and code savings. In some cases those drivers should move to fwnode
and use the equivalent infrastructure there, but many will be unsuitable
for conversion so this is still good win.

Edited cover letter from v1:

Thanks to Julia Lawal who also posted coccinelle for both types (loop and
non loop cases)

https://lore.kernel.org/all/alpine.DEB.2.22.394.2401312234250.3245@hadrien/
https://lore.kernel.org/all/alpine.DEB.2.22.394.2401291455430.8649@hadrien/

The cover letter of the RFC includes information on the various approaches
considered.
https://lore.kernel.org/all/20240128160542.178315-1-jic23@kernel.org/

Whilst these macros produce nice reductions in complexity the loops
still have the unfortunate side effect of hiding the local declaration
of a struct device_node * which is then used inside the loop.

Julia suggested making that a little more visible via
 #define for_each_child_of_node_scoped(parent, struct device_node *, child)
but in discussion we both expressed that this doesn't really make things
all that clear either so I haven't adopted this suggestion.



Jonathan Cameron (4):
  of: Add cleanup.h based auto release via __free(device_node) markings.
  of: Introduce for_each_*_child_of_node_scoped() to automate
    of_node_put() handling
  of: unittest: Use for_each_child_of_node_scoped()
  iio: adc: rcar-gyroadc: use for_each_available_child_node_scoped()

 drivers/iio/adc/rcar-gyroadc.c | 21 ++++++---------------
 drivers/of/unittest.c          | 11 +++--------
 include/linux/of.h             | 15 +++++++++++++++
 3 files changed, 24 insertions(+), 23 deletions(-)

-- 
2.39.2


