Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422C77E50D2
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 08:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbjKHHNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 02:13:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbjKHHNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 02:13:44 -0500
X-Greylist: delayed 1071 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Nov 2023 23:13:41 PST
Received: from 9.mo575.mail-out.ovh.net (9.mo575.mail-out.ovh.net [46.105.78.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F911BE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 23:13:41 -0800 (PST)
Received: from director4.ghost.mail-out.ovh.net (unknown [10.108.20.212])
        by mo575.mail-out.ovh.net (Postfix) with ESMTP id 4602428D29
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 06:55:49 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-v2f9h (unknown [10.110.208.162])
        by director4.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 0DFBC1FD69;
        Wed,  8 Nov 2023 06:55:45 +0000 (UTC)
Received: from foxhound.fi ([37.59.142.96])
        by ghost-submission-6684bf9d7b-v2f9h with ESMTPSA
        id V/SvOPEwS2WlSQsAsZoO1Q
        (envelope-from <jose.pekkarinen@foxhound.fi>); Wed, 08 Nov 2023 06:55:45 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-96R001fd1c432e-144d-4186-b8a9-dc0114c8abac,
                    CA30051851D9204B2894E18F048F6C805596AA31) smtp.auth=jose.pekkarinen@foxhound.fi
X-OVh-ClientIp: 87.94.109.40
From:   =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>
To:     evan.quan@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        skhan@linuxfoundation.org
Cc:     =?UTF-8?q?Jos=C3=A9=20Pekkarinen?= <jose.pekkarinen@foxhound.fi>,
        airlied@gmail.com, daniel@ffwll.ch, sunran001@208suo.com,
        lijo.lazar@amd.com, colin.i.king@gmail.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: [PATCH] drm/amd/pm: replace 1-element arrays with flexible-array members
Date:   Wed,  8 Nov 2023 08:55:39 +0200
Message-Id: <20231108065539.14223-1-jose.pekkarinen@foxhound.fi>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 3527725884123096769
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedruddukedguddttdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhephffvvefufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpeflohhsrocurfgvkhhkrghrihhnvghnuceojhhoshgvrdhpvghkkhgrrhhinhgvnhesfhhogihhohhunhgurdhfiheqnecuggftrfgrthhtvghrnheptddutefhgefhgeffhfdtueehudekudduueeiieetgeektddugedvkeetffetvdffnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepuddvjedrtddrtddruddpkeejrdelgedruddtledrgedtpdefjedrheelrddugedvrdelieenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheejhedpmhhouggvpehsmhhtphhouhht
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the structures affected seems to be unused along the driver the
following patch will care of replacing their members to flexible array,
removing the following warnings:

drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h:169:47-54: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h:174:47-54: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h:179:48-55: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h:184:47-54: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)
drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h:518:32-39: WARNING use flexible-array member instead (https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays)

Signed-off-by: José Pekkarinen <jose.pekkarinen@foxhound.fi>
---
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
index 81650727a5de..082d0bb79277 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
@@ -166,22 +166,22 @@ struct phm_phase_shedding_limits_table {
 
 struct phm_vceclock_voltage_dependency_table {
 	uint8_t count;                                    /* Number of entries. */
-	struct phm_vceclock_voltage_dependency_record entries[1]; /* Dynamically allocate count entries. */
+	struct phm_vceclock_voltage_dependency_record entries[]; /* Dynamically allocate count entries. */
 };
 
 struct phm_uvdclock_voltage_dependency_table {
 	uint8_t count;                                    /* Number of entries. */
-	struct phm_uvdclock_voltage_dependency_record entries[1]; /* Dynamically allocate count entries. */
+	struct phm_uvdclock_voltage_dependency_record entries[]; /* Dynamically allocate count entries. */
 };
 
 struct phm_samuclock_voltage_dependency_table {
 	uint8_t count;                                    /* Number of entries. */
-	struct phm_samuclock_voltage_dependency_record entries[1]; /* Dynamically allocate count entries. */
+	struct phm_samuclock_voltage_dependency_record entries[]; /* Dynamically allocate count entries. */
 };
 
 struct phm_acpclock_voltage_dependency_table {
 	uint32_t count;                                    /* Number of entries. */
-	struct phm_acpclock_voltage_dependency_record entries[1]; /* Dynamically allocate count entries. */
+	struct phm_acpclock_voltage_dependency_record entries[]; /* Dynamically allocate count entries. */
 };
 
 struct phm_vce_clock_voltage_dependency_table {
-- 
2.39.2

