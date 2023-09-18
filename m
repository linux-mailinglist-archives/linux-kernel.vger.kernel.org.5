Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3307A55DC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 00:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjIRWpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 18:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjIRWpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 18:45:15 -0400
X-Greylist: delayed 908 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Sep 2023 15:45:09 PDT
Received: from s1-ba86.socketlabs.email-od.com (s1-ba86.socketlabs.email-od.com [142.0.186.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85F491
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 15:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=email-od.com;i=@email-od.com;s=dkim;
        c=relaxed/relaxed; q=dns/txt; t=1695077110; x=1697669110;
        h=content-transfer-encoding:mime-version:references:in-reply-to:message-id:date:subject:cc:to:from:x-thread-info:subject:to:from:cc:reply-to;
        bh=XOK2VEZDzmL0bEQUI0LCK8qJ+0fQukkPLgiZxzaO7Nk=;
        b=epiOTTmHdnz99SIMdfoXvA7jRDDfAq4SJ7i7IQ7Phtt/XAE68aXRaAtKytcKFdRwN3KGaLbDOwLzRCi6TczL7/fR55KabNaFUQWLU/OWNhjDkgelxcVQ2NIkxb4xCz40iMEfA2gPeSv3B1RxbULI9ACsJL6WhPb8s5CHPALmMqM=
X-Thread-Info: NDUwNC4xMi4xNWZkOTAwMDc1Y2E1NDUubGludXgta2VybmVsPXZnZXIua2VybmVsLm9yZw==
Received: from r3.h.in.socketlabs.com (r3.h.in.socketlabs.com [142.0.180.13]) by mxrs4.email-od.com
        with ESMTP(version=Tls12 cipher=Aes256 bits=256); Mon, 18 Sep 2023 18:30:00 -0400
Received: from nalramli.com (d14-69-55-117.try.wideopenwest.com [69.14.117.55]) by r3.h.in.socketlabs.com
        with ESMTP; Mon, 18 Sep 2023 18:29:59 -0400
Received: from localhost.localdomain (d14-69-55-117.try.wideopenwest.com [69.14.117.55])
        by nalramli.com (Postfix) with ESMTPS id 79ACB2CE000F;
        Mon, 18 Sep 2023 18:29:58 -0400 (EDT)
From:   "Nabil S. Alramli" <dev@nalramli.com>
To:     netdev@vger.kernel.org, saeedm@nvidia.com, saeed@kernel.org,
        kuba@kernel.org, davem@davemloft.net, tariqt@nvidia.com,
        linux-kernel@vger.kernel.org, leon@kernel.org
Cc:     jdamato@fastly.com, sbhogavilli@fastly.com, nalramli@fastly.com,
        "Nabil S. Alramli" <dev@nalramli.com>
Subject: [net-next RFC v2 0/4] mlx5: support per queue coalesce settings
Date:   Mon, 18 Sep 2023 18:29:51 -0400
Message-Id: <20230918222955.2066-1-dev@nalramli.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <ZOemz1HLp95aGXXQ@x130>
References: <ZOemz1HLp95aGXXQ@x130>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-13.3 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_IADB_DK,RCVD_IN_IADB_LISTED,
        RCVD_IN_IADB_OPTIN,RCVD_IN_IADB_RDNS,RCVD_IN_IADB_SENDERID,
        RCVD_IN_IADB_SPF,RCVD_IN_IADB_VOUCHED,SPF_HELO_PASS,SPF_PASS,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is v2 of my previous patch:
https://lore.kernel.org/lkml/20230823223121.58676-1-dev@nalramli.com/.

Saeed: Thanks for reviewing v1. I made significant changes to support
per-channel DIM settings. Is this ready for an official v1 submission or
are there other major changes you'd like to see before I do that?

*************************************************************************=
**
Version History
---------------
* v1: Initial draft, individual channel DIM changes not supported.
* v2: Support individual channel DIM changes.
*************************************************************************=
**

Currently, only gobal coalescing configuration queries or changes are
supported in the `mlx5` driver. However, per-queue operations are not, an=
d
result in `EOPNOTSUPP` errors when attempted with `ethtool`. This patch
adds support for per-queue coalesce operations.

Here's an example use case:

- A mlx5 NIC is configured with 8 queues, each queue has its IRQ pinned t=
o
  a unique CPU.
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

This patch would support this. In v1 DIM mode changes could only be chang=
ed
NIC-wide. However, in this iteration, DIM mode changes are supported
globally as well as on a per-queue basis.

Here's an example:

```
$ sudo ethtool --per-queue eth0 queue_mask 0x4 --show-coalesce
Queue: 2
Adaptive RX: on  TX: on
stats-block-usecs: 0
sample-interval: 0
pkt-rate-low: 0
pkt-rate-high: 0

rx-usecs: 8
rx-frames: 128
rx-usecs-irq: 0
rx-frames-irq: 0

tx-usecs: 8
tx-frames: 128
tx-usecs-irq: 0
tx-frames-irq: 0
```

Now, let's try to set adaptive-rx off rx-usecs 16 for queue 2:

```
$ sudo ethtool --per-queue eth0 queue_mask 0x4 --coalesce adaptive-rx off
$ sudo ethtool --per-queue eth0 queue_mask 0x4 --coalesce rx-usecs 16
```

Confirm that the operation succeeded:

```
$ sudo ethtool --per-queue eth0 queue_mask 0x4 --show-coalesce
Queue: 2
Adaptive RX: off  TX: on
stats-block-usecs: 0
sample-interval: 0
pkt-rate-low: 0
pkt-rate-high: 0

rx-usecs: 16
rx-frames: 32
rx-usecs-irq: 0
rx-frames-irq: 0

tx-usecs: 8
tx-frames: 128
tx-usecs-irq: 0
tx-frames-irq: 0
```

The individual channel settings do not overwrite the global ones. However
Setting the global parameters will also reset all of the individual chann=
el
options. For example, after we set the options for queue 2, we'll see tha=
t
the global options remain unchanged:
```
$ sudo ethtool --show-coalesce eth0
Coalesce parameters for eth0:
Adaptive RX: on  TX: on
stats-block-usecs: 0
sample-interval: 0
pkt-rate-low: 0
pkt-rate-high: 0

rx-usecs: 8
rx-frames: 128
rx-usecs-irq: 0
rx-frames-irq: 0

tx-usecs: 16
tx-frames: 32
tx-usecs-irq: 0
tx-frames-irq: 0
```

But then if we set them, we'll see that the options for queue 2 have been
reset as well:
```
$ sudo ethtool --coalesce eth0 adaptive-tx off

$ sudo ethtool --show-coalesce eth0
Coalesce parameters for eth0:
Adaptive RX: on  TX: off
stats-block-usecs: 0
sample-interval: 0
pkt-rate-low: 0
pkt-rate-high: 0

rx-usecs: 8
rx-frames: 128
rx-usecs-irq: 0
rx-frames-irq: 0

tx-usecs: 16
tx-frames: 32
tx-usecs-irq: 0
tx-frames-irq: 0

$ sudo ethtool --per-queue eth0 queue_mask 0x4 --show-coalesce
Queue: 2
Adaptive RX: on  TX: off
stats-block-usecs: 0
sample-interval: 0
pkt-rate-low: 0
pkt-rate-high: 0

rx-usecs: 8
rx-frames: 128
rx-usecs-irq: 0
rx-frames-irq: 0

tx-usecs: 16
tx-frames: 32
tx-usecs-irq: 0
tx-frames-irq: 0
```

Previously a global `struct mlx5e_params` stored the options in
`struct mlx5e_priv.channels.params`. That was preserved, but a channel-
specific instance was added as well, in `struct mlx5e_channel.params`.

Best Regards,

*************************************************************************=
**

Nabil S. Alramli (4):
  mlx5: Add mlx5e_param to individual mlx5e_channel and preserve them
    through mlx5e_open_channels()
  mlx5: Add queue number parameter to mlx5e_safe_switch_params()
  mlx5: Implement mlx5e_ethtool_{get,set}_per_queue_coalesce() to
    support per-queue operations
  mlx5: Add {get,set}_per_queue_coalesce()

 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   6 +-
 .../ethernet/mellanox/mlx5/core/en_dcbnl.c    |   2 +-
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 214 +++++++++++++-----
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  76 +++++--
 .../ethernet/mellanox/mlx5/core/ipoib/ipoib.c |   2 +-
 5 files changed, 222 insertions(+), 78 deletions(-)

--=20
2.35.1

