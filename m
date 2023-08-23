Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633A078638D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 00:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238762AbjHWWqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 18:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238752AbjHWWqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 18:46:42 -0400
X-Greylist: delayed 902 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Aug 2023 15:46:40 PDT
Received: from s1-ba86.socketlabs.email-od.com (s1-ba86.socketlabs.email-od.com [142.0.186.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F68DA8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 15:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=email-od.com;i=@email-od.com;s=dkim;
        c=relaxed/relaxed; q=dns/txt; t=1692830800; x=1695422800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:x-thread-info:subject:to:from:cc:reply-to;
        bh=zSoy2eKylq3nOMR4MnNQX6r3SCc8r27eRGxcW46pl3g=;
        b=g1fqYAv/CfGHLHiP5pjh9IdBNJNZwvWxLwqaAWzPcId5HuJ6Rg0FzCeq5kwWNQkki+5+NoHVaTSBLxBSpq7UBdELrZvh0hyHpvlJHprvxZOmX2QgZ0TMJ+Exba2hijccai9hLPG74+/gyi+jQGngssdjivxL00XSYdp0/PD9Sys=
X-Thread-Info: NDUwNC4xMi4xNWZkOTAwMDE4MTM2OTkubGludXgta2VybmVsPXZnZXIua2VybmVsLm9yZw==
Received: from r1.us-east-1.aws.in.socketlabs.com (r1.us-east-1.aws.in.socketlabs.com [142.0.191.1]) by mxrs4.email-od.com
        with ESMTP(version=Tls12 cipher=Aes256 bits=256); Wed, 23 Aug 2023 18:31:37 -0400
Received: from nalramli.com (d14-69-55-117.try.wideopenwest.com [69.14.117.55]) by r1.us-east-1.aws.in.socketlabs.com
        with ESMTP; Wed, 23 Aug 2023 18:31:24 -0400
Received: from localhost.localdomain (d14-69-55-117.try.wideopenwest.com [69.14.117.55])
        by nalramli.com (Postfix) with ESMTPS id EEDA62CE0018;
        Wed, 23 Aug 2023 18:31:23 -0400 (EDT)
From:   "Nabil S. Alramli" <dev@nalramli.com>
To:     netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
        saeedm@nvidia.com, tariqt@nvidia.com, linux-kernel@vger.kernel.org,
        leon@kernel.org
Cc:     jdamato@fastly.com, nalramli@fastly.com,
        "Nabil S. Alramli" <dev@nalramli.com>
Subject: [net-next RFC 0/1] mlx5: support per queue coalesce settings
Date:   Wed, 23 Aug 2023 18:31:20 -0400
Message-Id: <20230823223121.58676-1-dev@nalramli.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-13.3 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_IADB_DK,RCVD_IN_IADB_LISTED,
        RCVD_IN_IADB_OPTIN,RCVD_IN_IADB_RDNS,RCVD_IN_IADB_SENDERID,
        RCVD_IN_IADB_SPF,RCVD_IN_IADB_VOUCHED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am Submitting this as an RFC to get feedback and to find out if the fol=
ks
at Mellanox would accept this change.

Currently, only gobal coalescing configuration queries or changes are
supported in the `mlx5` driver. However, per-queue operations are not, an=
d
result in `EOPNOTSUPP` errors when attempted with `ethtool`. This patch
adds support for per-queue coalesce operations, with a caveat described
below.

Here's an example use case:

- An mlx5 NIC is configured with 8 queues, each queue has its IRQ pinned
  to a unique CPU.
- Two custom RSS contexts are created: context 1 and context 2. Each
  context has a different set of queues where flows are distributed. For
  example, context 1 may distribute flows to queues 0-3, and context 2 ma=
y
  distribute flows to queues 4-7.
- A series of ntuple filters are installed which direct matching flows to
  RSS contexts. For example, perhaps port 80 is directed to context 1 and
  port 443 to context 2.
- Applications which receive network data associated with either context
  are pinned to the CPUs where the queues in the matching context have
  their IRQs pinned to maximize locality.

The apps themselves, however, may have different requirements on latency =
vs
CPU usage and so setting the per queue IRQ coalesce values would be very
helpful.

This patch would support this, with the caveat that DIM mode changes per
queue are not supported. DIM mode can only be changed NIC-wide. This is
because in the mlx5 driver, global operations that change the state of
adaptive-ex or adaptive-tx require a reset. So in the case of per-queue, =
we
reject such requests. This was done in the interest of simplicity for thi=
s
RFC as setting the DIM mode per queue appears to require significant
changes to mlx5 to be able to preserve the state of the indvidual channel=
s
through a reset.

IMO, if a user is going to set per-queue coalesce settings it might be
reasonable to assume that they will disable adaptive rx/tx NIC wide first
and then go through and apply their desired per-queue settings.

Here's an example:

$ ethtool --per-queue eth0 queue_mask 0x4 --show-coalesce
Queue: 2
Adaptive RX: on  TX: on
stats-block-usecs: 0
sample-interval: 0
pkt-rate-low: 0
pkt-rate-high: 0

rx-usecs: 8
rx-frames: 128
...

Now, let's try to set adaptive-rx off rx-usecs 16 for queue 2:

$ sudo ethtool --per-queue eth0 queue_mask 0x4 --coalesce adaptive-rx off=
 \
  rx-usecs 16
Cannot set device per queue parameters: Operation not supported

This is not supported; adaptive-rx must be disabled NIC wide first:

$ sudo ethtool -C eth0 adaptive-rx off

And now, queue_mask 0x4 can be applied to set rx-usecs:

$ sudo ethtool --per-queue eth0 queue_mask 0x4 --coalesce rx-usecs 16
$ ethtool --per-queue eth0 queue_mask 0x4 --show-coalesce
Queue: 2
Adaptive RX: off  TX: on
stats-block-usecs: 0
sample-interval: 0
pkt-rate-low: 0
pkt-rate-high: 0

rx-usecs: 16
rx-frames: 32
...

Previously a global `struct mlx5e_params` stored the options in
`struct mlx5e_priv.channels.params`. That was preserved, but a channel-
specific instance was added as well, in `struct mlx5e_channel.params`.

Note that setting global coalescing options will set the individual
channel settings to the same values as well.

Is Mellanox open to this change? What would be needed to get something li=
ke
this accepted?

Best Regards,

Nabil S. Alramli (1):
  mlx5: Add {get,set}_per_queue_coalesce()

 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   3 +-
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 212 ++++++++++++++----
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   4 +
 3 files changed, 173 insertions(+), 46 deletions(-)

--=20
2.35.1

