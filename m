Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6502F7AFA60
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 07:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjI0Fw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 01:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjI0Fvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 01:51:49 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 63645170E;
        Tue, 26 Sep 2023 22:49:53 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id AE48620B74C0;
        Tue, 26 Sep 2023 22:49:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AE48620B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1695793792;
        bh=zYLgfwVrqDBS5frwkU8WzeM8Y0joHuphXzHL6ORt8IQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Pp/754cU2V+m654v727QrXirT71pL8pHi7Htgxvk49n2VPSfi6SwI3wBlvLBbpSCN
         3ZZB1cSIoEW/kYqMfBTKoZKuQxBYc0jh6YwEuTmwktm9ATqCp5kw0OBa9pDTlNgGmq
         zcU46rYDR40PJ5T4AHo3KS2YJKRi6g2rRNqEndTs=
From:   Sonia Sharma <sosha@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
        sosha@microsoft.com, kys@microsoft.com, mikelley@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        longli@microsoft.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com
Subject: [PATCH v5 net-next] net: hv_netvsc: fix netvsc_send_completion to avoid multiple message length checks
Date:   Tue, 26 Sep 2023 22:49:47 -0700
Message-Id: <1695793787-21107-1-git-send-email-sosha@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sonia Sharma <sonia.sharma@linux.microsoft.com>

The switch statement in netvsc_send_completion() is incorrectly validating
the length of incoming network packets by falling through to the next case.
Avoid the fallthrough. Instead break after a case match and then process
the complete() call.
The current code has not caused any known failures. But nonetheless, the
code should be corrected as a different ordering of the switch cases might
cause a length check to fail when it should not.

Signed-off-by: Sonia Sharma <sonia.sharma@linux.microsoft.com>

---
Changes in v3:
* added return statement in default case as pointed by Michael Kelley.
Changes in v4:
* added fixes tag
* modified commit message to explain the issue fixed by patch.
Changes in v5:
* Dropped fixes tag as suggested by Simon Horman.
* fixed indentation
---
 drivers/net/hyperv/netvsc.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 82e9796c8f5e..0f7e4d377776 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -851,7 +851,7 @@ static void netvsc_send_completion(struct net_device *ndev,
 				   msglen);
 			return;
 		}
-		fallthrough;
+		break;
 
 	case NVSP_MSG1_TYPE_SEND_RECV_BUF_COMPLETE:
 		if (msglen < sizeof(struct nvsp_message_header) +
@@ -860,7 +860,7 @@ static void netvsc_send_completion(struct net_device *ndev,
 				   msglen);
 			return;
 		}
-		fallthrough;
+		break;
 
 	case NVSP_MSG1_TYPE_SEND_SEND_BUF_COMPLETE:
 		if (msglen < sizeof(struct nvsp_message_header) +
@@ -869,7 +869,7 @@ static void netvsc_send_completion(struct net_device *ndev,
 				   msglen);
 			return;
 		}
-		fallthrough;
+		break;
 
 	case NVSP_MSG5_TYPE_SUBCHANNEL:
 		if (msglen < sizeof(struct nvsp_message_header) +
@@ -878,10 +878,6 @@ static void netvsc_send_completion(struct net_device *ndev,
 				   msglen);
 			return;
 		}
-		/* Copy the response back */
-		memcpy(&net_device->channel_init_pkt, nvsp_packet,
-		       sizeof(struct nvsp_message));
-		complete(&net_device->channel_init_wait);
 		break;
 
 	case NVSP_MSG1_TYPE_SEND_RNDIS_PKT_COMPLETE:
@@ -904,13 +900,19 @@ static void netvsc_send_completion(struct net_device *ndev,
 
 		netvsc_send_tx_complete(ndev, net_device, incoming_channel,
 					desc, budget);
-		break;
+		return;
 
 	default:
 		netdev_err(ndev,
 			   "Unknown send completion type %d received!!\n",
 			   nvsp_packet->hdr.msg_type);
+		return;
 	}
+
+	/* Copy the response back */
+	memcpy(&net_device->channel_init_pkt, nvsp_packet,
+	   sizeof(struct nvsp_message));
+	complete(&net_device->channel_init_wait);
 }
 
 static u32 netvsc_get_next_send_section(struct netvsc_device *net_device)
-- 
2.25.1

