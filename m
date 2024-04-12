Return-Path: <linux-kernel+bounces-142768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C208A2FE3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:52:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAEEE1C20DAD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFA785940;
	Fri, 12 Apr 2024 13:52:22 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D77684A37;
	Fri, 12 Apr 2024 13:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712929942; cv=none; b=JlhJwm0ZSlGzaap/PHiRrFKa6MhMZ8E83wFkzOJxNd5lHhk5NQRDzRQf8vKBQDO3IR1AMaw8QZh8oxtlyFA7TNFOuwWS9+Zl8TtCygphfRZ8c1oF6FGMAhamj5TWfU9WsXMC5OVaAtQoGsV09PA9Su71XF+ZvxgL6YAW8hvW9Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712929942; c=relaxed/simple;
	bh=55RiW4BEfu5Env7yZxccHZdVTi6u77GwAhH6ejdUMXo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uk7f5gB438b4lVT8/YzqNPkFxNd9gWiWdZl0MGV/ff0wtvW8uTvITGzVyO8RnDnfQUmJY6gyoACW5mIO7gBUiJE/9/mTEBmfVtbCymfufREX0ttysLqnJSX19U5eOX9L/yjiGfYtrH3Dqyt98SfGV/iGqbai4hAugwoizFljxMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VGHww2wX3z2CcCF;
	Fri, 12 Apr 2024 21:49:20 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (unknown [7.185.36.15])
	by mail.maildlp.com (Postfix) with ESMTPS id 348DC140554;
	Fri, 12 Apr 2024 21:52:14 +0800 (CST)
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 12 Apr 2024 21:52:13 +0800
From: Zheng Yejian <zhengyejian1@huawei.com>
To: <mchehab@kernel.org>
CC: <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhengyejian1@huawei.com>
Subject: [PATCH] media: dvb-usb: Fix unexpected infinite loop in dvb_usb_read_remote_control()
Date: Fri, 12 Apr 2024 21:52:56 +0800
Message-ID: <20240412135256.1546051-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500012.china.huawei.com (7.185.36.15)

Infinite log printing occurs during fuzz test:

  rc rc1: DViCO FusionHDTV DVB-T USB (LGZ201) as ...
  ...
  dvb-usb: schedule remote query interval to 100 msecs.
  dvb-usb: DViCO FusionHDTV DVB-T USB (LGZ201) successfully initialized ...
  dvb-usb: bulk message failed: -22 (1/0)
  dvb-usb: bulk message failed: -22 (1/0)
  dvb-usb: bulk message failed: -22 (1/0)
  ...
  dvb-usb: bulk message failed: -22 (1/0)

Looking into the codes, there is a loop in dvb_usb_read_remote_control(),
that is in rc_core_dvb_usb_remote_init() create a work that will call
dvb_usb_read_remote_control(), and this work will reschedule itself at
'rc_interval' intervals to recursively call dvb_usb_read_remote_control(),
see following code snippet:

  rc_core_dvb_usb_remote_init() {
    ...
    INIT_DELAYED_WORK(&d->rc_query_work, dvb_usb_read_remote_control);
    schedule_delayed_work(&d->rc_query_work,
                          msecs_to_jiffies(rc_interval));
    ...
  }

  dvb_usb_read_remote_control() {
    ...
    err = d->props.rc.core.rc_query(d);
    if (err)
      err(...)  // Did not return even if query failed
    schedule_delayed_work(&d->rc_query_work,
                          msecs_to_jiffies(rc_interval));
  }

When the infinite log printing occurs, the query callback
'd->props.rc.core.rc_query' is cxusb_rc_query(). And the log is due to
the failure of finding a valid 'generic_bulk_ctrl_endpoint'
in usb_bulk_msg(), see following code snippet:

  cxusb_rc_query() {
    cxusb_ctrl_msg() {
      dvb_usb_generic_rw() {
        ret = usb_bulk_msg(d->udev, usb_sndbulkpipe(d->udev,
                           d->props.generic_bulk_ctrl_endpoint),...);
        if (ret)
          err("bulk message failed: %d (%d/%d)",ret,wlen,actlen);
          ...
      }
  ...
  }

By analyzing the corresponding USB descriptor, it shows that the
bNumEndpoints is 0 in its interface descriptor, but
the 'generic_bulk_ctrl_endpoint' is 1, that means user don't configure
a valid endpoint for 'generic_bulk_ctrl_endpoint', therefore this
'invalid' USB device should be rejected before it calls into
dvb_usb_read_remote_control().

To fix it, iiuc, we can add endpoint check in dvb_usb_adapter_init().

Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
---
 drivers/media/usb/dvb-usb/dvb-usb-init.c | 8 ++++++++
 1 file changed, 8 insertions(+)

Hi, I'm not very familiar with USB driver, and I'm not sure the
type check is appropriate or not here. Would be any device properties
that allow 'generic_bulk_ctrl_endpoint' not being configured, or would
it be configured late after init ? :)

diff --git a/drivers/media/usb/dvb-usb/dvb-usb-init.c b/drivers/media/usb/dvb-usb/dvb-usb-init.c
index fbf58012becd..48e7b9fb93dd 100644
--- a/drivers/media/usb/dvb-usb/dvb-usb-init.c
+++ b/drivers/media/usb/dvb-usb/dvb-usb-init.c
@@ -104,6 +104,14 @@ static int dvb_usb_adapter_init(struct dvb_usb_device *d, short *adapter_nrs)
 	 * sometimes a timeout occurs, this helps
 	 */
 	if (d->props.generic_bulk_ctrl_endpoint != 0) {
+		ret = usb_pipe_type_check(d->udev, usb_sndbulkpipe(d->udev,
+					  d->props.generic_bulk_ctrl_endpoint));
+		if (ret)
+			goto frontend_init_err;
+		ret = usb_pipe_type_check(d->udev, usb_rcvbulkpipe(d->udev,
+					  d->props.generic_bulk_ctrl_endpoint));
+		if (ret)
+			goto frontend_init_err;
 		usb_clear_halt(d->udev, usb_sndbulkpipe(d->udev, d->props.generic_bulk_ctrl_endpoint));
 		usb_clear_halt(d->udev, usb_rcvbulkpipe(d->udev, d->props.generic_bulk_ctrl_endpoint));
 	}
-- 
2.25.1


