Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3324F77F415
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 12:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349118AbjHQKKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 06:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349948AbjHQKKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 06:10:34 -0400
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE4A2D50;
        Thu, 17 Aug 2023 03:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
        Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=BJBMwVveP96hnQK3S7Atkwvtxibqop3ntHsUHjU+YeQ=; b=JxL7LlusdKm/FS1T8CitMQoZ8L
        +H1jsVkAn3kIMtXHiJYvrlV6H6hGLNbyMJkrCj+DWarmEE3VBxUqTQuNVg5nOYBEDqG6J8fGWQUgc
        Pq4k2D6FjChqamlj6LveN59WBat1uorNzyKwbArOs5eKuvo2ONPD1v+gw+ngA2DL++aBR8OLp9Y1Q
        ON2/1w4NVQ53Jw7SvttuXzph+wwgBr5LAjcZLIe4dRCvmRuRbwS0PuUhTPbmRr5o6qi+PCXnCHNIt
        a3ii1cRJo5hVkORR3UxWC4t7KKtRv4lz7tN8gVc9sbjOctSVkMF6Taf/UrpBXf00zWivexhEdn45Q
        tkP1O+qw==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <martin@geanix.com>)
        id 1qWZxV-0009wg-4I; Thu, 17 Aug 2023 12:10:29 +0200
Received: from [185.17.218.86] (helo=zen..)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <martin@geanix.com>)
        id 1qWZxU-000TfR-K9; Thu, 17 Aug 2023 12:10:28 +0200
From:   =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>
Cc:     linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Martin=20Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: [PATCH 0/2] can: per-device hardware filter support
Date:   Thu, 17 Aug 2023 12:10:12 +0200
Message-ID: <20230817101014.3484715-1-martin@geanix.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: martin@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.8/27003/Thu Aug 17 09:42:42 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Based on the prior discussions on hardware filtering in CAN devices[0],
I've implemented such support in the m_can driver.

The first patch is almost entirely identical to Oliver Hartkopp's patch
from 2018[1] - I've just rebased it to v6.6 and fixed a checkpatch
warning. Not sure what to do about the "Not-Signed-off-by" tag though?

The second patch is new. I've tested it with a tcan4550 device together
with Oliver's proof-of-concept change in iproute2[2].

Has anyone tried this approach with other devices, e.g. sja1000 ?

Thanks,
Martin

[0] https://lore.kernel.org/linux-can/6B05F8DE-7FF3-4065-9828-530BB9C91D1B@vanille.de/T/
[1] https://git.kernel.org/pub/scm/linux/kernel/git/mkl/linux-can-next.git/commit/?h=can-hw-filter&id=87128f7a953ef2eef5f2d2a02ce354350e2c4f7f
[2] https://marc.info/?l=linux-can&m=151949929522529

Martin Hundebøll (2):
  can: netlink: support setting hardware filters
  can: m_can: support setting hw filters

 drivers/net/can/dev/dev.c        |   3 +
 drivers/net/can/dev/netlink.c    |  33 ++++++++
 drivers/net/can/m_can/m_can.c    | 137 ++++++++++++++++++++++++++++++-
 include/linux/can/dev.h          |   5 ++
 include/uapi/linux/can/netlink.h |   1 +
 5 files changed, 175 insertions(+), 4 deletions(-)

-- 
2.41.0

