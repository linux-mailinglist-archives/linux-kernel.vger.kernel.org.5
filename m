Return-Path: <linux-kernel+bounces-3459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 734B7816C9E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 12:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21AD3284704
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 11:42:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BA320327;
	Mon, 18 Dec 2023 11:38:14 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CA433CCD
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 11:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1rFBwX-0000Vp-EK; Mon, 18 Dec 2023 12:37:53 +0100
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: [PATCH RFC 0/4] virtio-net: add tx-hash, rx-tstamp, tx-tstamp and
 tx-time
Date: Mon, 18 Dec 2023 12:37:07 +0100
Message-Id: <20231218-v6-7-topic-virtio-net-ptp-v1-0-cac92b2d8532@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOMugGUC/x2MwQoCIRBAf0Xm3EC6UtE16AO6LnvYdKy5qKhII
 P77Dh0fvPcGVCpMFe5qQKHOlVMU0CcF7rvHDyF7YTBns2ijb9gveMWWMjvsXBonjNQwt4yLDyK
 9nQ3Wg/S5UODf/73C6/mAbc4DwNay03AAAAA=
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Willem de Bruijn <willemb@google.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1880;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=TKUejtEOd2oK/lH8xrpsJNcmj6/cscNhZ+kAb5XG3TM=;
 b=owGbwMvMwCUmvd38QH3grB+Mp9WSGFIb9H6W3p4j5SSVbV8ro7yis3W/8rtnSkbdT4v3P/jRofAn
 7c+KjlIWBjEuBlkxRZbItYc0Ngt/1vly/DwDzBxWJpAhDFycAjARfhuGv/KbBbzj91X9bL8To+bfGv
 ni3KRbC6vFzitrnmJfdE3ilgMjw6rFtquNA54uLmt0bnj/Vs63z+pb5kt1N/31kml5N9Rz2QA=
X-Developer-Key: i=s.trumtrar@pengutronix.de; a=openpgp;
 fpr=59ADC228B313F32CF4C7CF001BB737C07F519AF8
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

This series tries to pick up the work on the virtio-net timestamping
feature from Willem de Bruijn.

Original series
    Message-Id: 20210208185558.995292-1-willemdebruijn.kernel@gmail.com
    Subject: [PATCH RFC v2 0/4] virtio-net: add tx-hash, rx-tstamp,
    tx-tstamp and tx-time
    From: Willem de Bruijn <willemb@google.com>

    RFC for four new features to the virtio network device:

    1. pass tx flow state to host, for routing + telemetry
    2. pass rx tstamp to guest, for better RTT estimation
    3. pass tx tstamp to guest, idem
    3. pass tx delivery time to host, for accurate pacing

    All would introduce an extension to the virtio spec.

The original series consisted of a hack around the DMA API, which should
be fixed in this series.

The changes in this series are to the driver side. For the changes to qemu see:
    https://github.com/strumtrar/qemu/tree/v8.1.1/virtio-net-ptp

Currently only virtio-net is supported. The original series used
vhost-net as backend. However, the path through tun via sendmsg doesn't
allow us to write data back to the driver side without any hacks.
Therefore use the way via plain virtio-net without vhost albeit better
performance.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
Willem de Bruijn (4):
      virtio-net: support transmit hash report
      virtio-net: support receive timestamp
      virtio-net: support transmit timestamp
      virtio-net: support future packet transmit time

 drivers/net/virtio_net.c        | 211 ++++++++++++++++++++++++++++++++++++++--
 include/uapi/linux/virtio_net.h |  24 ++++-
 2 files changed, 228 insertions(+), 7 deletions(-)
---
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20231218-v6-7-topic-virtio-net-ptp-3df023bc4f4d

Best regards,
-- 
Steffen Trumtrar <s.trumtrar@pengutronix.de>


