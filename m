Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154A27A69C0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 19:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjISRln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 13:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbjISRla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 13:41:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF4CCAD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 10:41:24 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6D40143D;
        Tue, 19 Sep 2023 10:42:01 -0700 (PDT)
Received: from e103737-lin.cambridge.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9A08E3F5A1;
        Tue, 19 Sep 2023 10:41:23 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
Date:   Tue, 19 Sep 2023 18:40:53 +0100
Subject: [PATCH RFT v2 05/18] firmware: arm_ffa: Implement the
 FFA_NOTIFICATION_SET interface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230919-ffa_v1-1_notif-v2-5-6f3a3ca3923c@arm.com>
References: <20230919-ffa_v1-1_notif-v2-0-6f3a3ca3923c@arm.com>
In-Reply-To: <20230919-ffa_v1-1_notif-v2-0-6f3a3ca3923c@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Marc Bonnici <marc.bonnici@arm.com>,
        Coboy Chen <coboy.chen@mediatek.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Olivier Deprez <olivier.deprez@arm.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1504; i=sudeep.holla@arm.com;
 h=from:subject:message-id; bh=PMF7W8gP08NmJpWmNAG8MEfkwerfmt6TtimmzyfxT6Q=;
 b=owEBbQKS/ZANAwAIAQBBurwxfuKYAcsmYgBlCd062+rtFD+44yL0Ekw5PGXXJ+O+CH2hxDgPl
 oo7XyQZC7+JAjMEAAEIAB0WIQS6ceUSBvMeskPdk+EAQbq8MX7imAUCZQndOgAKCRAAQbq8MX7i
 mMz3D/978oazRdsQBQ1CfVAgN3UMUwEFY2s+U2EOyTnNCCkLb08bn2TmY2Ul4Q8yulS8Z/d1yEF
 ryXH87x53jlhDFOUOoVxQWBx1ZGsYXbWr9SS4uc17T8VTQPZ/Yj2Zs7m5ErtJn7kJ3vgOvYJUY2
 mko5cDfNqAzdB9dHEXdTaO3FcKFaYlTFU+W003LnYIh8Yo29I16e1YgasLGcuvalBfGOcdVedRM
 66m2ZXyT+gYg0Hj4mjPR08uYczTQJgSQWVPvL818HDQP6VRABdd3SS2NqKK4B/dajuzs2Ox05yI
 l92A8zoQSSgjnmj8DJ84mDGx0GdX+cOaDDrUfBsYKo0E84BeCoJOctELSMOWEpwt03n07/nBW6L
 /h9ttmhBiv4Nq73pxfn6MhR9PswwrFy5N7VYXb4Kn2DhqcQdcAn2DHcWBgfWGVA5l16L0VzNOrF
 ncBqYr9daRg8RsR0RYjMju005j/a1mKUKWUEiA94M/KfwPvs7PMKu6/GL2I08ZbO+ptfevIEVC3
 j4a7B6ZQBSL657Jsi3TuCDcqH5kEO9zMVI3KqciVFyfvoChioz64DaksuJWS8YTN1i4mzG2yyYq
 bq3dMS2llQLJnJsMyS6kB4t6bRwZHST1A/iI05lAn9t/kk8RNFkPVsCYjnvVnTTcjJ7mfR37Zx/
 MKPBzzt1GqU5hqw==
X-Developer-Key: i=sudeep.holla@arm.com; a=openpgp;
 fpr=7360A21742ADF5A11767C1C139CFD4755FE2D5B4
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The framework provides an interface to the sender to specify the
notification to signal to the receiver. A sender signals a notification
by requesting its partition manager to set the corresponding bit in the
notifications bitmap of the receiver invoking FFA_NOTIFICATION_SET.

Implement the FFA_NOTIFICATION_SET to enable the caller(sender) to send
the notifications for any other partitions in the system.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_ffa/driver.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index ebe1ecc57099..2aae838ba46a 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -604,6 +604,26 @@ static int ffa_notification_bind_common(u16 dst_id, u64 bitmap,
 	return 0;
 }
 
+static
+int ffa_notification_set(u16 src_id, u16 dst_id, u32 flags, u64 bitmap)
+{
+	ffa_value_t ret;
+	u32 src_dst_ids = PACK_TARGET_INFO(src_id, dst_id);
+
+	invoke_ffa_fn((ffa_value_t) {
+		  .a0 = FFA_NOTIFICATION_SET, .a1 = src_dst_ids, .a2 = flags,
+		  .a3 = NOTIFICATION_BITMAP_LOW(bitmap),
+		  .a4 = NOTIFICATION_BITMAP_HIGH(bitmap),
+		  }, &ret);
+
+	if (ret.a0 == FFA_ERROR)
+		return ffa_to_linux_errno((int)ret.a2);
+	else if (ret.a0 != FFA_SUCCESS)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int ffa_run(struct ffa_device *dev, u16 vcpu)
 {
 	ffa_value_t ret;

-- 
2.42.0

