Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623F27FE864
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 05:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbjK3Eka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 23:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjK3Ek2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 23:40:28 -0500
X-Greylist: delayed 434 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Nov 2023 20:40:34 PST
Received: from relay.smtp-ext.broadcom.com (lpdvsmtp09.broadcom.com [192.19.166.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE305D6C
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 20:40:34 -0800 (PST)
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id F33B7C0070B2;
        Wed, 29 Nov 2023 20:33:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com F33B7C0070B2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1701318800;
        bh=Kl08Peu9NjmNJqmZtJUhrVzlCW+5eOcIx3ZsxvfCSLQ=;
        h=From:To:Cc:Subject:Date:From;
        b=otDyjmr/nHrcyxA4SoLIQJSqlC2sTum0jKcdUbIMjvudJCum0EzQiYRXoS8PvTEFe
         jAXRBhguijR0ImHUKk2KmepvC0MyYsF95IZQ7vKVoc7YkxejyI9Xj6PyP/3yK55ySm
         oImEbalWR5KYw7cDMbw6dR2yM6ASP3xSwcO1b2Oo=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id B9ADE18041CAC4;
        Wed, 29 Nov 2023 20:33:18 -0800 (PST)
From:   Florian Fainelli <florian.fainelli@broadcom.com>
To:     linux-kernel@vger.kernel.org
Cc:     akpm@linux-foundation.org, Kuan-Ying.Lee@mediatek.com,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] scripts/gdb: Fix lx-device-list-bus and lx-device-list-class
Date:   Wed, 29 Nov 2023 20:33:16 -0800
Message-Id: <20231130043317.174188-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the conversion to bus_to_subsys() and class_to_subsys(), the gdb
scripts listing the system buses and classes respectively was broken,
fix those by returning the subsys_priv pointer and have the various
caller de-reference either the 'bus' or 'class' structure members
accordingly.

Fixes: 83b9148df2c9 ("driver core: bus: bus iterator cleanups")
Fixes: 7b884b7f24b4 ("driver core: class.c: convert to only use class_to_subsys")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 scripts/gdb/linux/device.py | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/scripts/gdb/linux/device.py b/scripts/gdb/linux/device.py
index 16376c5cfec6..0eabc5f4f8ca 100644
--- a/scripts/gdb/linux/device.py
+++ b/scripts/gdb/linux/device.py
@@ -36,26 +36,26 @@ def for_each_bus():
     for kobj in kset_for_each_object(gdb.parse_and_eval('bus_kset')):
         subsys = container_of(kobj, kset_type.get_type().pointer(), 'kobj')
         subsys_priv = container_of(subsys, subsys_private_type.get_type().pointer(), 'subsys')
-        yield subsys_priv['bus']
+        yield subsys_priv
 
 
 def for_each_class():
     for kobj in kset_for_each_object(gdb.parse_and_eval('class_kset')):
         subsys = container_of(kobj, kset_type.get_type().pointer(), 'kobj')
         subsys_priv = container_of(subsys, subsys_private_type.get_type().pointer(), 'subsys')
-        yield subsys_priv['class']
+        yield subsys_priv
 
 
 def get_bus_by_name(name):
     for item in for_each_bus():
-        if item['name'].string() == name:
+        if item['bus']['name'].string() == name:
             return item
     raise gdb.GdbError("Can't find bus type {!r}".format(name))
 
 
 def get_class_by_name(name):
     for item in for_each_class():
-        if item['name'].string() == name:
+        if item['class']['name'].string() == name:
             return item
     raise gdb.GdbError("Can't find device class {!r}".format(name))
 
@@ -70,13 +70,13 @@ def klist_for_each(klist):
 
 
 def bus_for_each_device(bus):
-    for kn in klist_for_each(bus['p']['klist_devices']):
+    for kn in klist_for_each(bus['klist_devices']):
         dp = container_of(kn, device_private_type.get_type().pointer(), 'knode_bus')
         yield dp['device']
 
 
 def class_for_each_device(cls):
-    for kn in klist_for_each(cls['p']['klist_devices']):
+    for kn in klist_for_each(cls['klist_devices']):
         dp = container_of(kn, device_private_type.get_type().pointer(), 'knode_class')
         yield dp['device']
 
@@ -103,7 +103,7 @@ class LxDeviceListBus(gdb.Command):
     def invoke(self, arg, from_tty):
         if not arg:
             for bus in for_each_bus():
-                gdb.write('bus {}:\t{}\n'.format(bus['name'].string(), bus))
+                gdb.write('bus {}:\t{}\n'.format(bus['bus']['name'].string(), bus))
                 for dev in bus_for_each_device(bus):
                     _show_device(dev, level=1)
         else:
@@ -123,7 +123,7 @@ class LxDeviceListClass(gdb.Command):
     def invoke(self, arg, from_tty):
         if not arg:
             for cls in for_each_class():
-                gdb.write("class {}:\t{}\n".format(cls['name'].string(), cls))
+                gdb.write("class {}:\t{}\n".format(cls['class']['name'].string(), cls))
                 for dev in class_for_each_device(cls):
                     _show_device(dev, level=1)
         else:
-- 
2.34.1

