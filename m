Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1626797918
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238418AbjIGRBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239200AbjIGRBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:01:02 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226E5210C;
        Thu,  7 Sep 2023 10:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1694106039;
  x=1725642039;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=0HShL49IKdWXDbTEKh+qaXy8Z/aZhrAVPA9VeReGrAc=;
  b=lAB9g4T6hc+g4diDHVNgGPUx+74Bxe9oq5ZVmi7tpDaoovAg6bZ6g76e
   JR5UQ3plUS4gZJfKPwzqRrm5j4RC0hc+Tc8LZQHd+DK1OvYhM3j1XoeHD
   KQeOQDPzIs9n8k6+UGzXWzEWvKGIW1iaHymIFNCNFxV2RnIFBeXXtwhsz
   34ghl0jwxaUWPUhQaIYK2qXelShM3HkVl1kYsGJfR6PuBsUCFFF4DQC4t
   q99ej3KXYApDy4+ORwD6TTGPPuCLwhB4WXbNtW1W6fVEHoRtAB7ID2pvs
   03Monjp46xgIPN9nQdJ6NaX9VIC6hQc+Vw0pzmb2lLfxL3LrujBLsEbBg
   A==;
From:   =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
Date:   Thu, 7 Sep 2023 12:53:14 +0200
Subject: [PATCH] iio: light: vcnl4000: Don't power on/off chip in config
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20230907-vcnl4000-pm-fix-v1-1-58a11c1d5a6c@axis.com>
X-B4-Tracking: v=1; b=H4sIAJmr+WQC/x2NywqDQAxFf0WybiC1Sh+/UrqYyWRqoE4lESmI/
 97R5eHcw13BxVQcHs0KJou6fkuF86kBHkJ5C2qqDC21F7rTFRcun46IcBox6w9jf0tMKefYM9Q
 qBheMFgoPezcGn8V2MZnU/XH1fG3bHyqK8ox6AAAA
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@axis.com>,
        =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694084004; l=1611;
 i=marten.lindahl@axis.com; s=20230329; h=from:subject:message-id;
 bh=H8tOJOL2nRLx5d0MtZXPuLd64FZ4lHUshLXSHdTT7Qk=;
 b=ZZ+1HZwpikOf0sWcyA54MEu7XZG5ISi0v9ruQLLyqWNz48A3EUNTYHk+F6ZwfZ6kYIbN9m9Kn
 4IDrVezUB7jBXv3l7TltaIGXHUjEihgeenvdUEHF2sQV31qPuyX9Gtw
X-Developer-Key: i=marten.lindahl@axis.com; a=ed25519;
 pk=JfbjqFPJnIDIQOkJBeatC8+S3Ax3N0RIdmN+fL3wXgw=
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After enabling/disabling interrupts on the vcnl4040 chip the als and/or
ps sensor is powered on or off depending on the interrupt enable bits.
This is made as a last step in write_event_config.

But there is no reason to do this as the runtime PM handles the power
state of the sensors. Interfering with this may impact sensor readings.

Consider the following:
 1. Userspace makes sensor data reading which triggers 2000ms RPM resume
    (sensor powered on) timeout
 2. Userspace disables interrupts => powers sensor off
 3. Userspace reads sensor data = 0 because sensor is off and RPM didn't
    power on the sensor as resume timeout is still active
 4. RPM resume timeout passed

Powering sensor off in (2) risks a time window of close to 2000ms where
sensor data readings are disabled as in (3).

Skip setting power state when writing new event config.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---
 drivers/iio/light/vcnl4000.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 3a52b09c2823..fdf763a04b0b 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -1513,7 +1513,6 @@ static int vcnl4040_write_event_config(struct iio_dev *indio_dev,
 
 out:
 	mutex_unlock(&data->vcnl4000_lock);
-	data->chip_spec->set_power_state(data, data->ps_int || data->als_int);
 
 	return ret;
 }

---
base-commit: 7ba2090ca64ea1aa435744884124387db1fac70f
change-id: 20230907-vcnl4000-pm-fix-b58dc0dffb5c

Best regards,
-- 
Mårten Lindahl <marten.lindahl@axis.com>

