Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC787DE5E4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 19:13:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344627AbjKASNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 14:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbjKASNB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 14:13:01 -0400
Received: from 8.mo560.mail-out.ovh.net (8.mo560.mail-out.ovh.net [188.165.52.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A40D6F
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 11:12:23 -0700 (PDT)
Received: from director4.ghost.mail-out.ovh.net (unknown [10.109.143.79])
        by mo560.mail-out.ovh.net (Postfix) with ESMTP id BDEA127B2D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 17:36:38 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-k8p4s (unknown [10.108.4.11])
        by director4.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 3EE021FD7A;
        Wed,  1 Nov 2023 17:36:37 +0000 (UTC)
Received: from foxhound.fi ([37.59.142.103])
        by ghost-submission-6684bf9d7b-k8p4s with ESMTPSA
        id Yc+/CaWMQmUEEgAAHOvW/w
        (envelope-from <jose.pekkarinen@foxhound.fi>); Wed, 01 Nov 2023 17:36:37 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-103G0057af23061-cf36-4f4c-8b48-a29c5d4dfc4c,
                    E3092659390FA2EDB47E70EC17E7DF57E79FF282) smtp.auth=jose.pekkarinen@foxhound.fi
X-OVh-ClientIp: 87.94.110.27
From:   =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>
To:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
        gregkh@linuxfoundation.org, skhan@linuxfoundation.org
Cc:     =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+95f2e2439b97575ec3c0@syzkaller.appspotmail.com
Subject: [PATCH] drivers core: lookup sysfs power group before removal
Date:   Wed,  1 Nov 2023 19:36:27 +0200
Message-Id: <20231101173627.2658-1-jose.pekkarinen@foxhound.fi>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10134788012345763331
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedruddtgedguddtvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeflohhsrocurfgvkhhkrghrihhnvghnuceojhhoshgvrdhpvghkkhgrrhhinhgvnhesfhhogihhohhunhgurdhfiheqnecuggftrfgrthhtvghrnhepfedtleeuteeitedvtedtteeuieevudejfeffvdetfeekleehhfelleefteetjeejnecukfhppeduvdejrddtrddtrddupdekjedrleegrdduuddtrddvjedpfeejrdehledrudegvddruddtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheeitddpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hinted by syzboot, there is a few cases where the sysfs power group may
not be there, like the failure while adding it, or adding its runtime
group, or when the sysfs firmware loader fallback fail to populate. In
the last case, the device_del function will be called leading to attempt
to remove the sysfs group. This patch will lookup for it in advance to
grant that it is effectively there before cleaning it up.

Reported-by: syzbot+95f2e2439b97575ec3c0@syzkaller.appspotmail.com

Signed-off-by: José Pekkarinen <jose.pekkarinen@foxhound.fi>
---
 drivers/base/power/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index a1474fb67db9..6601729c4698 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -834,5 +834,7 @@ void dpm_sysfs_remove(struct device *dev)
 	dev_pm_qos_constraints_destroy(dev);
 	rpm_sysfs_remove(dev);
 	sysfs_unmerge_group(&dev->kobj, &pm_wakeup_attr_group);
-	sysfs_remove_group(&dev->kobj, &pm_attr_group);
+
+	if (kernfs_find_and_get((&dev->kobj)->sd, pm_attr_group.name))
+		sysfs_remove_group(&dev->kobj, &pm_attr_group);
 }
-- 
2.39.2

