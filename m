Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8957F2A0C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 11:17:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233592AbjKUKRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 05:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbjKUKRX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 05:17:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E338116
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 02:17:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1E5F6C433C7;
        Tue, 21 Nov 2023 10:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700561839;
        bh=3Txu7PPyn6wb+lD0p7YfYmDJ0VmWJYBmGnKE5mN5Uvg=;
        h=From:Subject:Date:To:Cc:Reply-To:From;
        b=LXnuTG5n7NZmqLVz/xbnVhEDlUMwDubNfJp5fyxB9a0RMHcFKPiOwzksJlHKCHMqu
         /n/85LoOR/alm7hNAS+2zkPBzWm0zNKaYkUn8LcZbH8HZNoHjkTBwTkdMFwaKBvghu
         3Mgjnrlwl1a+d+8ZvQzvARKEf3paWHtn/zjAOLipA2tp7UplpT8SFdz9xdhHCzCwM2
         MKt+muGsgPbElglzoi6dfEJvV3S8wKrG43lA1iceWUs+OoVwaPqBAhTNADFPRyQEMX
         nSV2MzA1+d6na95i7PQ7noB7jYoTvjnPHI//IKwC/QFkfia+aXPPvJmhBA/azt6gGV
         pM8k4SvMtapnA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 04D2BC5ACB3;
        Tue, 21 Nov 2023 10:17:19 +0000 (UTC)
From:   Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Subject: [PATCH 00/12] iio: add new backend framework
Date:   Tue, 21 Nov 2023 11:20:13 +0100
Message-Id: <20231121-dev-iio-backend-v1-0-6a3d542eba35@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAF2EXGUC/x3MMQqAMAxA0atIZgOmFUSvIg6tiRqEVloQoXh3i
 +Mb/i+QJalkmJoCSW7NGkMFtQ2shwu7oHI1mM5YItMhy42qEb1bTwmMTL3vB+uIxw1qdSXZ9Pm
 P8/K+Hy4eIYhhAAAA
To:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Cc:     Olivier MOYSAN <olivier.moysan@foss.st.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno Sa <nuno.sa@analog.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700562016; l=5028;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=3Txu7PPyn6wb+lD0p7YfYmDJ0VmWJYBmGnKE5mN5Uvg=;
 b=EYGkUSMi6pIc/DEdOhknhZsaEsn+NJfPqBT/N8VADTcQg11HJ1dc4nH+Z+ZKHpoDtC2QnVjPt
 0JVB7uKlQpDD48SBIN3/sdFRETQkq0NV+e1CHRxJdXKFSS5piBFk26A
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: <nuno.sa@analog.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is a Framework to handle complex IIO aggregate devices.

The typical architecture is to have one device as the frontend device which
can be "linked" against one or multiple backend devices. All the IIO and
userspace interface is expected to be registers/managed by the frontend
device which will callback into the backends when needed (to get/set
some configuration that it does not directly control).

The basic framework interface is pretty simple:
 - Backends should register themselves with @devm_iio_backend_register()
 - Frontend devices should get backends with @devm_iio_backend_get()

(typical provider - consumer stuff)

This is the result of the discussions in [1] and [2]. In short, both ADI
and STM wanted some way to control/get configurations from a kind of
IIO aggregate device. So discussions were made to have something that
serves and can be used by everyone.

The main differences with the converter framework RFC [1]:

1) Dropped the component framework. One can get more overview about
the concerns on the references but the main reasons were: 
 * Relying on providing .remove() callbacks to be allowed to use device
   managed functions. I was not even totally sure about the correctness
   of it and in times where everyone tries to avoid that driver
   callback, it could lead to some maintenance burden.
 * Scalability issues. As mentioned in [2], to support backends defined
   in FW child nodes was not so straightforward with the component
   framework.
 * Device links can already do some of the things that made me
   try the component framework (eg: removing consumers on suppliers
   unbind).

2) Only support the minimal set of functionality to have the devices in
   the same state as before using the backend framework. New features
   will be added afterwards. 

3) Moved the API docs into the .c files.

4) Moved the framework to the IIO top dir and renamed it to
   industrialio-backend.c.

Also, as compared with the RFC in [2], I don't think there are that many
similarities other than the filename. However, it should now be pretty
straight for Olivier to build on top of it. Also to mention that I did
grabbed patch 1 ("of: property: add device link support for
io-backends") from that series and just did some minor changes:

1) Renamed the property from "io-backend" to "io-backends".
2) No '#io-backend-cells' as it's not supported/needed by the framework
(at least for now) .

Regarding the driver core patch
("driver: core: allow modifying device_links flags"), it is more like a
RFC one. I'm not really sure if the current behavior isn't just
expected/wanted. Since I could not really understand if it is or not
(or why the different handling DL_FLAG_AUTOREMOVE_CONSUMER vs
DL_FLAG_AUTOREMOVE_SUPPLIER), I'm sending out the patch.

Jonathan,

I also have some fixes and cleanups for the ad9467 driver. I added
Fixes tags but I'm not sure if it's really worth it to backport them (given
what we already discussed about these drivers). I'll leave that to you
:).

I'm also not sure if I'm missing some tags (even though the series
is frankly different from [2]). 

Olivier,

If you want to be included as a Reviewer let me know and I'll happily do
so in the next version.

Also regarding the new IIO fw schemas. Should I send patches/PR to:

https://github.com/devicetree-org/dt-schema/

? Or is there any other workflow for it?

[1]: https://lore.kernel.org/linux-iio/20230727150324.1157933-1-olivier.moysan@foss.st.com/
[2]: https://lore.kernel.org/linux-iio/20230727150324.1157933-1-olivier.moysan@foss.st.com/

---
Nuno Sa (11):
      driver: core: allow modifying device_links flags
      iio: add the IIO backend framework
      iio: adc: ad9467: fix reset gpio handling
      iio: adc: ad9467: don't ignore error codes
      iio: adc: ad9467: add mutex to struct ad9467_state
      iio: adc: ad9467: fix scale setting
      iio: adc: ad9467: use spi_get_device_match_data()
      iio: adc: ad9467: use chip_info variables instead of array
      iio: adc: ad9467: convert to backend framework
      iio: adc: adi-axi-adc: convert to regmap
      iio: adc: adi-axi-adc: move to backend framework

Olivier Moysan (1):
      of: property: add device link support for io-backends

 MAINTAINERS                         |   7 +
 drivers/base/core.c                 |  14 +-
 drivers/iio/Kconfig                 |   5 +
 drivers/iio/Makefile                |   1 +
 drivers/iio/adc/Kconfig             |   3 +-
 drivers/iio/adc/ad9467.c            | 382 +++++++++++++++++++++-----------
 drivers/iio/adc/adi-axi-adc.c       | 429 +++++++-----------------------------
 drivers/iio/industrialio-backend.c  | 302 +++++++++++++++++++++++++
 drivers/of/property.c               |   2 +
 include/linux/iio/adc/adi-axi-adc.h |   4 +
 include/linux/iio/backend.h         |  58 +++++
 11 files changed, 723 insertions(+), 484 deletions(-)

Thanks!
- Nuno Sá

