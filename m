Return-Path: <linux-kernel+bounces-49625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2F7846D27
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55020B2CC42
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A0F7CF05;
	Fri,  2 Feb 2024 09:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2ZrE8+qS"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EA87C099
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706867808; cv=none; b=czV9hA8M5s+WAsA/Vt1afbDMDlWd/9eH9uL7QQH/+CTlGUu4NXku6sfSEIx/L0zip0qJhRToH74Nxd8S4AUObPqcHnII639Fg3gVEt42TYJpKnwX4PaSi+PF4ObWJd+9ktd7IqBVpw3OvDVQQNeHTqYA6OFmPka859R3Z/K6L5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706867808; c=relaxed/simple;
	bh=dd+eXX+dl1OWEzo7/glw3RkA/h5jaC3FxhfWglqWQKw=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=cypZZ3z7odqz2+ExPA2Ne6TbOPNAwGssQq3AW0VZ9WwODd7FnCifHfe7/f7dK7MBDv5jNUlBwGJ/0xfBMEPtQw90gTo3Ea8b8xsXIvHDpzm5HdduslAvV/jmSYRTLAopG27Mqu2ZL391URKo36RMgOzfd+W1x+/tHMbbPkTBhpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2ZrE8+qS; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-603cbb4f06dso36340457b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 01:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706867805; x=1707472605; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=r5YNJyMo7T6ZuM5rJpTOCCSH+s00uoF+8fpfMCUPszE=;
        b=2ZrE8+qSkIyhdbDoG737h+0JS5YkKVsCS5Rhj0dxzoB1Rr3yzonOo1O18/T2jt4ter
         1o7z6GfoL85yfkOB7dK3kHDqc2jru1hPger6V2mvFwfxTL6B2Xd5GGwDD+Tvo+4R38hp
         xYzygVDKrA9BfBApM3z+rd14UWEFfznx0cO1GFTURNS/RjB2/tNo3VXI4MYQk6s98oQH
         JY+QwmrLVIoKAERWZbsgNKGjHJTIW2JmI1XOIufcbmWqCdJKdb57VzbAnSuqx66xLXz8
         o7lo1WrMK4mnelGypTssM6t2JzTljsJbs4RcG6lB/MyeYUUCDf+Np2RB8RZBY2fcceih
         XZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706867805; x=1707472605;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r5YNJyMo7T6ZuM5rJpTOCCSH+s00uoF+8fpfMCUPszE=;
        b=HuYQ+8JIlH9S2bIj/0c/pU9PWhXlFYwCcASPBbDcXCf2/HM31YNpKoDebu2ymoHz1P
         WgqIOhcbeEJi8AX2NoZ1icNOtU3F5X7JG8irkrETEzWdCEZkW35Chg2U29g9fB9eUcLH
         FmcfWEEGpHskRmq8kR4TzTBa8mNN36hL3UqX55DyoNYWfamVM9vfRIWzH86znUudB81i
         hYjFVyIwD+WxHTCmR5pRP/JMxRj+89FBNgsGzQy2+9f6v+HEUG/sDkV6PnQ+HVj6faP9
         WHZ+NGmtoRRx2HuS1nQueJSCruDuTS/KTsskwo1P/oGfzYapniOpvm5OcL3gMExKUaFh
         wepA==
X-Gm-Message-State: AOJu0YyBDMvKd0tJHeVlXv36IzqSaOolt215H6RGMlwGdCb25IMfkSch
	XKbn6n1UyAHX9gekWd+OuPfr0Mc75SiqqPA7luUWd8prxOw2wpbcTprM9eng25HWVohmZBRAbGg
	fEhr7AO97Tuj5Yg==
X-Google-Smtp-Source: AGHT+IGXUw6ToiQ17gHgBca2nj0+dTWZYHjZvLemamAXt3vYuMtbN2MEqKONzAR13JHowe6PXoFGK8KNWnZ/AKE=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:6f0:da10:9cb3:5b3])
 (user=saravanak job=sendgmr) by 2002:a81:7905:0:b0:604:1dc3:122c with SMTP id
 u5-20020a817905000000b006041dc3122cmr954235ywc.5.1706867805547; Fri, 02 Feb
 2024 01:56:45 -0800 (PST)
Date: Fri,  2 Feb 2024 01:56:34 -0800
In-Reply-To: <20240202095636.868578-1-saravanak@google.com>
Message-Id: <20240202095636.868578-3-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240202095636.868578-1-saravanak@google.com>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v2 2/3] driver core: fw_devlink: Improve detection of
 overlapping cycles
From: Saravana Kannan <saravanak@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Saravana Kannan <saravanak@google.com>
Cc: Xu Yang <xu.yang_2@nxp.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

fw_devlink can detect most overlapping/intersecting cycles. However it was
missing a few corner cases because of an incorrect optimization logic that
tries to avoid repeating cycle detection for devices that are already
marked as part of a cycle.

Here's an example provided by Xu Yang (edited for clarity):

                    usb
                  +-----+
   tcpc           |     |
  +-----+         |  +--|
  |     |----------->|EP|
  |--+  |         |  +--|
  |EP|<-----------|     |
  |--+  |         |  B  |
  |     |         +-----+
  |  A  |            |
  +-----+            |
     ^     +-----+   |
     |     |     |   |
     +-----|  C  |<--+
           |     |
           +-----+
           usb-phy

Node A (tcpc) will be populated as device 1-0050.
Node B (usb) will be populated as device 38100000.usb.
Node C (usb-phy) will be populated as device 381f0040.usb-phy.

The description below uses the notation:
consumer --> supplier
child ==> parent

1. Node C is populated as device C. No cycles detected because cycle
   detection is only run when a fwnode link is converted to a device link.

2. Node B is populated as device B. As we convert B --> C into a device
   link we run cycle detection and find and mark the device link/fwnode
   link cycle:
   C--> A --> B.EP ==> B --> C

3. Node A is populated as device A. As we convert C --> A into a device
   link, we see it's already part of a cycle (from step 2) and don't run
   cycle detection. Thus we miss detecting the cycle:
   A --> B.EP ==> B --> A.EP ==> A

Looking at it another way, A depends on B in one way:
A --> B.EP ==> B

But B depends on A in two ways and we only detect the first:
B --> C --> A
B --> A.EP ==> A

To detect both of these, we remove the incorrect optimization attempt in
step 3 and run cycle detection even if the fwnode link from which the
device link is being created has already been marked as part of a cycle.

Reported-by: Xu Yang <xu.yang_2@nxp.com>
Closes: https://lore.kernel.org/lkml/DU2PR04MB8822693748725F85DC0CB86C8C792@DU2PR04MB8822.eurprd04.prod.outlook.com/
Fixes: 3fb16866b51d ("driver core: fw_devlink: Make cycle detection more robust")
Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 52215c4c7209..e3d666461835 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2060,9 +2060,14 @@ static int fw_devlink_create_devlink(struct device *con,
 
 	/*
 	 * SYNC_STATE_ONLY device links don't block probing and supports cycles.
-	 * So cycle detection isn't necessary and shouldn't be done.
+	 * So, one might expect that cycle detection isn't necessary for them.
+	 * However, if the device link was marked as SYNC_STATE_ONLY because
+	 * it's part of a cycle, then we still need to do cycle detection. This
+	 * is because the consumer and supplier might be part of multiple cycles
+	 * and we need to detect all those cycles.
 	 */
-	if (!(flags & DL_FLAG_SYNC_STATE_ONLY)) {
+	if (!device_link_flag_is_sync_state_only(flags) ||
+	    flags & DL_FLAG_CYCLE) {
 		device_links_write_lock();
 		if (__fw_devlink_relax_cycles(con, sup_handle)) {
 			__fwnode_link_cycle(link);
-- 
2.43.0.594.gd9cf4e227d-goog


