Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 706367F77B1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 16:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345802AbjKXPYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 10:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345621AbjKXPY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 10:24:26 -0500
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Nov 2023 07:24:31 PST
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [IPv6:2001:41d0:203:375::b9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA1C1735
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 07:24:31 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqrs.dk; s=key1;
        t=1700838869;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=peq91xezvaQKWqcf4IslfnLpo00aDgps9HSfXps+xtk=;
        b=uT8OLHRNdk68+oUdZqQn4HY5lfrInyAaLq7rpzCI1VqxaHE4YZV0SrdUAX47q6Nk64tp/V
        qOtjqkhxqZv626Lnd7Gop6NVRUgiHOqSi2EfwENvKf1F0nesDQltPPOaEc2b4pmo41Pnp1
        mZ7BkzsrO+/TsP+uejLgBTEPZr3Qt5XocnRdt+JkXYXPz7jJy2ZcIDI0VP/Bpq1zX6+eTW
        cNtpdB6c59HkPgAA/EF/448k3PsyHwXD6baaGTolNLRIBWXnIRo0YN12QOjaRytLrBk4fj
        5MOUjdtSqvzkv7X+2ehPpN87OTU8h5vEXtlLrATfyKPj7ARfGZE+jMtVCy1rPQ==
From:   =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>
Subject: [PATCH v2 0/2] drm/bridge: adv7511: get edid in hpd_work to update
 CEC phys address
Date:   Fri, 24 Nov 2023 16:14:20 +0100
Message-Id: <20231124-adv7511-cec-edid-v2-0-f0e5eeafdfc2@bang-olufsen.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAMy9YGUC/32OQQrCMBBFr1Jm7UgmNcS68h7SRZpM7KC0kmhQS
 u9u7AFcvg///b9A5iSc4dQskLhIlnmqoHcN+NFNV0YJlUEr3ZKiA7pQrCFCzx45SMAYrRlC63y
 nO6i1R+Io70156SuPkp9z+mwLhX7pH1khJHTm6NmxGozl81BP4Hx/xczTPtygX9f1C/++WGu2A
 AAA
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes a small bug where the CEC adapter could have an
invalid CEC address even though we got a hotplug connect and could have
read it.

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
Changes in v2:
- Rearrange driver code to avoid the previous prototype of
  adv7511_get_edid(), per Laurent's feedback
- Free the returned EDID to prevent a memory leak, per Jani's comment
- Link to v1: https://lore.kernel.org/r/20231014-adv7511-cec-edid-v1-1-a58ceae0b57e@bang-olufsen.dk

---
Alvin Šipraga (2):
      drm/bridge: adv7511: rearrange hotplug work code
      drm/bridge: adv7511: get edid in hpd_work to update CEC phys address

 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 154 ++++++++++++++++-----------
 1 file changed, 90 insertions(+), 64 deletions(-)
---
base-commit: ab93edb2f94c3c0d5965be3815782472adbe3f52
change-id: 20231014-adv7511-cec-edid-ff75bd3ac929

