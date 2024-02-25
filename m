Return-Path: <linux-kernel+bounces-80097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C70C862AB5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE4531F21503
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 14:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED8613AC5;
	Sun, 25 Feb 2024 14:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9VInWVb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DF7C2D0;
	Sun, 25 Feb 2024 14:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708871255; cv=none; b=hsBNPE37ofWWyk0I6XmBoMv1eUzZX9flivGuXfhwNPvkvHVhdVJW8bX4zfx/IOFZ6+wCnhTY6y7XUlfbXmwyL30BcmAxYJPrXj1ABHuTRSbe5HNT6ocCTmVQoHgOZCU374vpYyghm9t90KDcBPxep8L/cEAhVgrlSl8IBBxPngA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708871255; c=relaxed/simple;
	bh=YxLQapaQ7vM/KWmbNZ9Y8e8vat8a+7NhANYH7fHpT9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pAMWmT7FQVQz8HoKR5nfbBnZYr2ei/tbeFtKK1Dvov+NOP+AmVySkdfc/OOq0QJVG1NYN13vWf+GOTc3ZZCYpHfGvniB4c/yqjS85IdWu6j5JLNJ3nJSblsqV88iVdYx3bNtFkVA4/VtTuwXsEGmOdbmdBEkCHhrQSMNozzEdiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9VInWVb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D20C433F1;
	Sun, 25 Feb 2024 14:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708871254;
	bh=YxLQapaQ7vM/KWmbNZ9Y8e8vat8a+7NhANYH7fHpT9o=;
	h=From:To:Cc:Subject:Date:From;
	b=C9VInWVbwXhq7/VYYsr5CFe0MbZ/D3QJ11XJD8Ofysdo2Qy4HBJpzrWpvio5TO632
	 4zypRlIztvW/0Mmf4voX7SGP+gbOled8Jz7CIJk6FkE/aOZRgP/6SYsKU30K+Nnw8P
	 egT8P15d0dWwcdK54Pbb8m504gFgK67faJIPj/rTYCPksaSoLJBzQZ9omjn1/nLx6/
	 sWYqqNbMOPMS1aLhu07W0idkEmHdVGEarcoj/+9NVJVgjwhc6lOP8X+yiznxlH52UY
	 kMaDIy7pIx7W9ebs3SYr+ctnMcvZZUB1NAjWKmvTHqmItlXKHB1bGQHLgavKGvgv+X
	 RhHOuAkZLVM+Q==
From: Jonathan Cameron <jic23@kernel.org>
To: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	linux-kernel@vger.kernel.org,
	Julia Lawall <Julia.Lawall@inria.fr>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	marek.vasut@gmail.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RESEND PATCH v2 0/4] of: automate of_node_put() - new approach to loops.
Date: Sun, 25 Feb 2024 14:27:10 +0000
Message-ID: <20240225142714.286440-1-jic23@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Some discussion occured on previous posting.
https://lore.kernel.org/linux-iio/20240223124432.26443-1-Jonathan.Cameron@huawei.com/

Summary:
* fwnode conversions should be considered when applying this
  infrastructure to a driver. Perhaps better to move directly to
  the generic FW property handling rather than improve existing
  of specific code.
* There are lots of potential places to use this based on detections
  from Julia's coccinelle scripts linked below.

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
2.44.0


