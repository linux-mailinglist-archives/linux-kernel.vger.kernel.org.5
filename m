Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2962C7F12DE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 13:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbjKTMMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 07:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232251AbjKTMMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 07:12:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 789B7B8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 04:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700482365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I64jWnU/Xnimdff02D+xgUnCTeMcDBWpdYaPdS1SbPI=;
        b=KxwLOEL2SGcGjigPSvV2NluHSn6uh9b5Yop/UyUcslA0fFXiRJT9yx6nJ/KEBvaPxR9NTW
        Ioe/h5quNJrznfka2I2+/Nt1XiTT8qG6382nFIvSifhEcZEsLepTKWTkKj6aIjA6yefUlL
        iSfnaWrx8/ej5aR9yL35ApfFicj8rR4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-Zlf3hxatNHOdUUxfsOzwfw-1; Mon,
 20 Nov 2023 07:12:44 -0500
X-MC-Unique: Zlf3hxatNHOdUUxfsOzwfw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8FB271C0F473;
        Mon, 20 Nov 2023 12:12:43 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C64A41121306;
        Mon, 20 Nov 2023 12:12:41 +0000 (UTC)
From:   Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To:     pabeni@redhat.com
Cc:     davem@davemloft.net, edumazet@google.com, jtornosm@redhat.com,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        weihao.bj@ieisystem.com
Subject: [PATCH v2 2/2] net: usb: ax88179_178a: avoid two consecutive device resets
Date:   Mon, 20 Nov 2023 13:11:41 +0100
Message-ID: <20231120121239.54504-1-jtornosm@redhat.com>
In-Reply-To: <020ff11184bb22909287ef68d97c00f7d2c73bd6.camel@redhat.com>
References: <020ff11184bb22909287ef68d97c00f7d2c73bd6.camel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device is always reset two consecutive times (ax88179_reset is called
twice), one from usbnet_probe during the device binding and the other from
usbnet_open.

Remove the non-necessary reset during the device binding and let the reset
operation from open to keep the normal behavior (tested with generic ASIX
Electronics Corp. AX88179 Gigabit Ethernet device).

Fixes: e2ca90c276e1f ("ax88179_178a: ASIX AX88179_178A USB 3.0/2.0 to gigabit ethernet adapter driver")
Reported-by: Herb Wei <weihao.bj@ieisystem.com>
Tested-by: Herb Wei <weihao.bj@ieisystem.com>
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
V1 -> V2:
- Add Fixes tag.
- Follow Paolo Abeni's suggestion and remove the binding reset, not the
  reset operation to keep the normal behavior.

 drivers/net/usb/ax88179_178a.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 4ea0e155bb0d..8d835fbc4316 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1298,8 +1298,6 @@ static int ax88179_bind(struct usbnet *dev, struct usb_interface *intf)
 
 	netif_set_tso_max_size(dev->net, 16384);
 
-	ax88179_reset(dev);
-
 	return 0;
 }
 
-- 
2.42.0

