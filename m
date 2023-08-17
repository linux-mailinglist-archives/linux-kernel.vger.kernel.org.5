Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B86577F376
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349687AbjHQJdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349710AbjHQJdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:33:01 -0400
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FADD30E3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:32:58 -0700 (PDT)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202308170932557b34351c87b6bbb38a
        for <linux-kernel@vger.kernel.org>;
        Thu, 17 Aug 2023 11:32:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=y2NADA2JaCbTWC/UJl5Xtu3c4/+YvFtAr15iH/sM9Nk=;
 b=iIRHub8/6ZPXwaBc6AiYDxlP/7D4IZd+tIdSgYLnGMnpQ6gOrMvOyTXtikUmrQLSKuh+XV
 RNbUYriABtqUk+BULxu0IJAGIEi4Baod8BGsS5RRrLwoXZ+qntSj8dE3t3FBJu96kZP4ivBf
 iT4Rzi07IH5ExNM7WUv7L8/WfOEeA=;
From:   "D. Starke" <daniel.starke@siemens.com>
To:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, ilpo.jarvinen@linux.intel.com
Cc:     linux-kernel@vger.kernel.org,
        Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH v6 2/9] tty: n_gsm: add missing description to structs in gsmmux.h
Date:   Thu, 17 Aug 2023 11:32:24 +0200
Message-Id: <20230817093231.2317-2-daniel.starke@siemens.com>
In-Reply-To: <20230817093231.2317-1-daniel.starke@siemens.com>
References: <20230817093231.2317-1-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Starke <daniel.starke@siemens.com>

Currently, all available structure fields in gsmmux.h except those
for gsm_config are commented. Furthermore, no kernel doc comments are used.

Fix this by adding appropriate comments to the not commented fields of
gsm_config. Convert the comments of the other structs to kernel doc format.

Note that 'mru' and 'mtu' refer to the size without basic/advanced option
mode header and byte stuffing as defined in the standard in chapter 5.7.2.

Link: https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1516
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 include/uapi/linux/gsmmux.h | 104 +++++++++++++++++++++++++++++-------
 1 file changed, 84 insertions(+), 20 deletions(-)

v5 -> v6:
No changes.

Link: https://lore.kernel.org/all/20230517155704.5701-2-daniel.starke@siemens.com/

diff --git a/include/uapi/linux/gsmmux.h b/include/uapi/linux/gsmmux.h
index e56e2d7ea6eb..3bd6f03a8293 100644
--- a/include/uapi/linux/gsmmux.h
+++ b/include/uapi/linux/gsmmux.h
@@ -18,6 +18,28 @@
  */
 #define GSM_FL_RESTART	_BITUL(0)
 
+/**
+ * struct gsm_config - n_gsm basic configuration parameters
+ *
+ * This structure is used in combination with GSMIOC_GETCONF and GSMIOC_SETCONF
+ * to retrieve and set the basic parameters of an n_gsm ldisc.
+ * struct gsm_config_ext can be used to configure extended ldisc parameters.
+ *
+ * All timers are in units of 1/100th of a second.
+ *
+ * @adaption:      Convergence layer type
+ * @encapsulation: Framing (0 = basic option, 1 = advanced option)
+ * @initiator:     Initiator or responder
+ * @t1:            Acknowledgment timer
+ * @t2:            Response timer for multiplexer control channel
+ * @t3:            Response timer for wake-up procedure
+ * @n2:            Maximum number of retransmissions
+ * @mru:           Maximum incoming frame payload size
+ * @mtu:           Maximum outgoing frame payload size
+ * @k:             Window size
+ * @i:             Frame type (1 = UIH, 2 = UI)
+ * @unused:        Can not be used
+ */
 struct gsm_config
 {
 	unsigned int adaption;
@@ -31,18 +53,32 @@ struct gsm_config
 	unsigned int mtu;
 	unsigned int k;
 	unsigned int i;
-	unsigned int unused[8];	/* Can not be used */
+	unsigned int unused[8];
 };
 
 #define GSMIOC_GETCONF		_IOR('G', 0, struct gsm_config)
 #define GSMIOC_SETCONF		_IOW('G', 1, struct gsm_config)
 
+/**
+ * struct gsm_netconfig - n_gsm network configuration parameters
+ *
+ * This structure is used in combination with GSMIOC_ENABLE_NET and
+ * GSMIOC_DISABLE_NET to enable or disable a network data connection
+ * over a mux virtual tty channel. This is for modems that support
+ * data connections with raw IP frames instead of PPP.
+ *
+ * @adaption: Adaption to use in network mode.
+ * @protocol: Protocol to use - only ETH_P_IP supported.
+ * @unused2:  Can not be used.
+ * @if_name:  Interface name format string.
+ * @unused:   Can not be used.
+ */
 struct gsm_netconfig {
-	unsigned int adaption;  /* Adaption to use in network mode */
-	unsigned short protocol;/* Protocol to use - only ETH_P_IP supported */
-	unsigned short unused2;	/* Can not be used */
-	char if_name[IFNAMSIZ];	/* interface name format string */
-	__u8 unused[28];        /* Can not be used */
+	unsigned int adaption;
+	unsigned short protocol;
+	unsigned short unused2;
+	char if_name[IFNAMSIZ];
+	__u8 unused[28];
 };
 
 #define GSMIOC_ENABLE_NET      _IOW('G', 2, struct gsm_netconfig)
@@ -51,27 +87,55 @@ struct gsm_netconfig {
 /* get the base tty number for a configured gsmmux tty */
 #define GSMIOC_GETFIRST		_IOR('G', 4, __u32)
 
+/**
+ * struct gsm_config_ext - n_gsm extended configuration parameters
+ *
+ * This structure is used in combination with GSMIOC_GETCONF_EXT and
+ * GSMIOC_SETCONF_EXT to retrieve and set the extended parameters of an
+ * n_gsm ldisc.
+ *
+ * All timers are in units of 1/100th of a second.
+ *
+ * @keep_alive:  Control channel keep-alive in 1/100th of a second (0 to disable).
+ * @wait_config: Wait for DLCI config before opening virtual link?
+ * @reserved:    For future use, must be initialized to zero.
+ */
 struct gsm_config_ext {
-	__u32 keep_alive;	/* Control channel keep-alive in 1/100th of a
-				 * second (0 to disable)
-				 */
-	__u32 wait_config;	/* Wait for DLCI config before opening virtual link? */
-	__u32 reserved[6];	/* For future use, must be initialized to zero */
+	__u32 keep_alive;
+	__u32 wait_config;
+	__u32 reserved[6];
 };
 
 #define GSMIOC_GETCONF_EXT	_IOR('G', 5, struct gsm_config_ext)
 #define GSMIOC_SETCONF_EXT	_IOW('G', 6, struct gsm_config_ext)
 
-/* Set channel accordingly before calling GSMIOC_GETCONF_DLCI. */
+/**
+ * struct gsm_dlci_config - n_gsm channel configuration parameters
+ *
+ * This structure is used in combination with GSMIOC_GETCONF_DLCI and
+ * GSMIOC_SETCONF_DLCI to retrieve and set the channel specific parameters
+ * of an n_gsm ldisc.
+ *
+ * Set the channel accordingly before calling GSMIOC_GETCONF_DLCI.
+ *
+ * @channel:  DLCI (0 for the associated DLCI).
+ * @adaption: Convergence layer type.
+ * @mtu:      Maximum transfer unit.
+ * @priority: Priority (0 for default value).
+ * @i:        Frame type (1 = UIH, 2 = UI).
+ * @k:        Window size (0 for default value).
+ * @flags:    DLCI specific flags.
+ * @reserved: For future use, must be initialized to zero.
+ */
 struct gsm_dlci_config {
-	__u32 channel;		/* DLCI (0 for the associated DLCI) */
-	__u32 adaption;		/* Convergence layer type */
-	__u32 mtu;		/* Maximum transfer unit */
-	__u32 priority;		/* Priority (0 for default value) */
-	__u32 i;		/* Frame type (1 = UIH, 2 = UI) */
-	__u32 k;		/* Window size (0 for default value) */
-	__u32 flags;		/* DLCI specific flags. */
-	__u32 reserved[7];	/* For future use, must be initialized to zero */
+	__u32 channel;
+	__u32 adaption;
+	__u32 mtu;
+	__u32 priority;
+	__u32 i;
+	__u32 k;
+	__u32 flags;
+	__u32 reserved[7];
 };
 
 #define GSMIOC_GETCONF_DLCI	_IOWR('G', 7, struct gsm_dlci_config)
-- 
2.34.1

