Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7888376711D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 17:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236857AbjG1Pxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 11:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236168AbjG1Pxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 11:53:39 -0400
Received: from mgamail.intel.com (unknown [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424743C1D;
        Fri, 28 Jul 2023 08:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690559618; x=1722095618;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k9V2394RCtvh3NTAt2WTSve+1zGj0J3twZowpzpftjU=;
  b=AjtlS8echpEDxlMtTtimGySWpAIqg8nQR7u67fD7OhPDZJiepkovxee3
   pfjCx2Lss/re/+P8VokcQmnPNz9F/pJWo+dzVMd/ZMO/BTpJbpyRHkLw/
   ZtU/or1co6xvrw2HDKcgC5CV6GrXwiUv/Gg6uEuSZxiPBvVLhGzrxi5qS
   YfMQphUK4TR8eH8l85t6MExGzV7vgwMFr0jS5mxL5jSIYNymC9y0T3llV
   rNfoDLTHddhaoSSNNI5iVW+RKRxk2DZ0CzeCKRIkQQZVvOp4WluNCf5eh
   SpIi1d/H3cutXzFuNlVUnu6Q2GMbhvUMMFC/MNKmi/SEfeK8bklWwgNC+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="372246663"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="372246663"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 08:53:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="727512165"
X-IronPort-AV: E=Sophos;i="6.01,237,1684825200"; 
   d="scan'208";a="727512165"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orsmga002.jf.intel.com with ESMTP; 28 Jul 2023 08:53:34 -0700
From:   Alexander Lobakin <aleksander.lobakin@intel.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org,
        linux-hardening@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/3] virtchnl: fix fake 1-elem arrays in structs allocated as `nents + 1` - 1
Date:   Fri, 28 Jul 2023 17:52:05 +0200
Message-ID: <20230728155207.10042-2-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230728155207.10042-1-aleksander.lobakin@intel.com>
References: <20230728155207.10042-1-aleksander.lobakin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two most problematic virtchnl structures are virtchnl_rss_key and
virtchnl_rss_lut. Their "flex" arrays have the type of u8, thus, when
allocating / checking, the actual size is calculated as `sizeof +
nents - 1 byte`. But their sizeof() is not 1 byte larger than the size
of such structure with proper flex array, it's two bytes larger due to
the padding. That said, their size is always 1 byte larger unless
there are no tail elements -- then it's +2 bytes.
Add virtchnl_struct_size() macro which will handle this case (and later
other cases as well). Make its calling conv the same as we call
struct_size() to allow it to be drop-in, even though it's unlikely to
become possible to switch to generic API. The macro will calculate a
proper size of a structure with a flex array at the end, so that it
becomes transparent for the compilers, but add the difference from the
old values, so that the real size of sorta-ABI-messages doesn't change.
Use it on the allocation side in IAVF and the receiving side (defined
as static inline in virtchnl.h) for the mentioned two structures.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   |  6 ++--
 include/linux/avf/virtchnl.h                  | 31 ++++++++++++++-----
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index be3c007ce90a..10f03054a603 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -1085,8 +1085,7 @@ void iavf_set_rss_key(struct iavf_adapter *adapter)
 			adapter->current_op);
 		return;
 	}
-	len = sizeof(struct virtchnl_rss_key) +
-	      (adapter->rss_key_size * sizeof(u8)) - 1;
+	len = virtchnl_struct_size(vrk, key, adapter->rss_key_size);
 	vrk = kzalloc(len, GFP_KERNEL);
 	if (!vrk)
 		return;
@@ -1117,8 +1116,7 @@ void iavf_set_rss_lut(struct iavf_adapter *adapter)
 			adapter->current_op);
 		return;
 	}
-	len = sizeof(struct virtchnl_rss_lut) +
-	      (adapter->rss_lut_size * sizeof(u8)) - 1;
+	len = virtchnl_struct_size(vrl, lut, adapter->rss_lut_size);
 	vrl = kzalloc(len, GFP_KERNEL);
 	if (!vrl)
 		return;
diff --git a/include/linux/avf/virtchnl.h b/include/linux/avf/virtchnl.h
index c15221dcb75e..3ab207c14809 100644
--- a/include/linux/avf/virtchnl.h
+++ b/include/linux/avf/virtchnl.h
@@ -866,18 +866,20 @@ VIRTCHNL_CHECK_STRUCT_LEN(4, virtchnl_promisc_info);
 struct virtchnl_rss_key {
 	u16 vsi_id;
 	u16 key_len;
-	u8 key[1];         /* RSS hash key, packed bytes */
+	u8 key[];          /* RSS hash key, packed bytes */
 };
 
-VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_key);
+VIRTCHNL_CHECK_STRUCT_LEN(4, virtchnl_rss_key);
+#define virtchnl_rss_key_LEGACY_SIZEOF	6
 
 struct virtchnl_rss_lut {
 	u16 vsi_id;
 	u16 lut_entries;
-	u8 lut[1];        /* RSS lookup table */
+	u8 lut[];         /* RSS lookup table */
 };
 
-VIRTCHNL_CHECK_STRUCT_LEN(6, virtchnl_rss_lut);
+VIRTCHNL_CHECK_STRUCT_LEN(4, virtchnl_rss_lut);
+#define virtchnl_rss_lut_LEGACY_SIZEOF	6
 
 /* VIRTCHNL_OP_GET_RSS_HENA_CAPS
  * VIRTCHNL_OP_SET_RSS_HENA
@@ -1367,6 +1369,17 @@ struct virtchnl_fdir_del {
 
 VIRTCHNL_CHECK_STRUCT_LEN(12, virtchnl_fdir_del);
 
+#define __vss_byone(p, member, count, old)				      \
+	(struct_size(p, member, count) + (old - 1 - struct_size(p, member, 0)))
+
+#define __vss(type, func, p, member, count)		\
+	struct type: func(p, member, count, type##_LEGACY_SIZEOF)
+
+#define virtchnl_struct_size(p, m, c)					      \
+	_Generic(*p,							      \
+		 __vss(virtchnl_rss_key, __vss_byone, p, m, c),		      \
+		 __vss(virtchnl_rss_lut, __vss_byone, p, m, c))
+
 /**
  * virtchnl_vc_validate_vf_msg
  * @ver: Virtchnl version info
@@ -1479,19 +1492,21 @@ virtchnl_vc_validate_vf_msg(struct virtchnl_version_info *ver, u32 v_opcode,
 		}
 		break;
 	case VIRTCHNL_OP_CONFIG_RSS_KEY:
-		valid_len = sizeof(struct virtchnl_rss_key);
+		valid_len = virtchnl_rss_key_LEGACY_SIZEOF;
 		if (msglen >= valid_len) {
 			struct virtchnl_rss_key *vrk =
 				(struct virtchnl_rss_key *)msg;
-			valid_len += vrk->key_len - 1;
+			valid_len = virtchnl_struct_size(vrk, key,
+							 vrk->key_len);
 		}
 		break;
 	case VIRTCHNL_OP_CONFIG_RSS_LUT:
-		valid_len = sizeof(struct virtchnl_rss_lut);
+		valid_len = virtchnl_rss_lut_LEGACY_SIZEOF;
 		if (msglen >= valid_len) {
 			struct virtchnl_rss_lut *vrl =
 				(struct virtchnl_rss_lut *)msg;
-			valid_len += vrl->lut_entries - 1;
+			valid_len = virtchnl_struct_size(vrl, lut,
+							 vrl->lut_entries);
 		}
 		break;
 	case VIRTCHNL_OP_GET_RSS_HENA_CAPS:
-- 
2.41.0

