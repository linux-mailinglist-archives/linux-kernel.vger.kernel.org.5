Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439327F3B0C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 02:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjKVBKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 20:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235008AbjKVBJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 20:09:57 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C278E1731;
        Tue, 21 Nov 2023 17:09:17 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 5045D81BB6;
        Wed, 22 Nov 2023 01:01:22 +0000 (UTC)
Received: from pdx1-sub0-mail-a211.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 60E9681AF4;
        Wed, 22 Nov 2023 01:01:20 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1700614880; a=rsa-sha256;
        cv=none;
        b=uDrlXBrGErJayNHHMxGqLoqHrW+Crrh0EwSeMwROyucg2k9wpmk43KMVDnlIKiBIk/CRcM
        hmeKsvsOC1HjOD+kZdYj7mDlXZzMzj5Pk60zPrP/kb39xv5KN/Ccb3XUKha5I3WXaqJoP3
        ZoG4WKuh4q+LUHn7p0SlRNolWYNe8H0QrE68yiGo0TrXSH1a/AoAV3VTDe9MgfPaoTfgG6
        IkQCP3CR0F/vYX8l+qs8Mn5v8AEm1sTrInPbV6VwQVsbzOO3GsOmqOzdsnKXqVW3jFcP0C
        IjRQ7plBDwnoOQT2N6+vhmckLlyD4bS/2gSBYQypsaWA9OE+BrJ3BxNSYbjwoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1700614880;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=pBG5QBQev1WUx8qgrxc7+absFmgUQXr+R05r/UhTqT8=;
        b=ktwRbYz9T60ih0byWBdI5OZr2RotJMLyXo2/Crla3sDBX5jvfzTPwI1/OsParfKZRQBlnQ
        VMDojCSZ4BFu0Fo7MuTbVWOQGa2W0Pzf8k+Nnp3shodc5XXgH1WC7jZqEHSFDx31HETeXv
        X6/sgAZKAMCwINAUz63viKngVrUzuNZieOWJg00EGoj5bW1dk5/uYuPux0vqHk8NVjNk69
        nSbzPmn7yYbP4Kfpm4cx4Vui0kygLSQ8YMCCuqEsgzznVuohnneI+V/12qlJF9goEy8HF7
        6vROcvAUQQxgXm2ww2IbKznmsCxQneV9Xoh+xqWlMTwWlKPYVwX7Jgs924nBmw==
ARC-Authentication-Results: i=1;
        rspamd-645fb96b5-hzw8k;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Absorbed-Abortive: 11f349ac07025e80_1700614882126_1858017920
X-MC-Loop-Signature: 1700614882126:3891613807
X-MC-Ingress-Time: 1700614882126
Received: from pdx1-sub0-mail-a211.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.104.134.218 (trex/6.9.2);
        Wed, 22 Nov 2023 01:01:22 +0000
Received: from offworld (unknown [104.36.30.214])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a211.dreamhost.com (Postfix) with ESMTPSA id 4SZjcG0xmwzXs;
        Tue, 21 Nov 2023 17:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1700614880;
        bh=pBG5QBQev1WUx8qgrxc7+absFmgUQXr+R05r/UhTqT8=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=NTu6l2dendzv7UQwdOaVWOyt3UvJbIAWI8OJeKZ1PqMdooZF3s1umV2DF3UcQPOfn
         +RSExkcNV9UZdGM/iJVp8HTDbmsCALUjDIo3F9jycbP3sha6EQIREVcynth+TrOTAU
         PEC65yyHactoisFgWMl/UvprSu22zfPNe4OCugP0POhgQleUBNd/QuDvQqCZ9ew04w
         915OPd2aYtAvcWcsAS9BvTQkp5RCKluB/hqPmFdr+jQk2yu/qJ2HrzAnj2I2PBZxEC
         5sylbnjLL1lzUaNf2SJsI40vpJY2vpQqRr331is/JKTb6er8bisuuqUJ6pEW9FaADW
         sJYLkNlqvcpAg==
Date:   Tue, 21 Nov 2023 17:01:14 -0800
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     shiju.jose@huawei.com
Cc:     linux-cxl@vger.kernel.org, linux-mm@kvack.org,
        jonathan.cameron@huawei.com, dave.jiang@intel.com,
        alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, dan.j.williams@intel.com,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        david@redhat.com, Vilas.Sridharan@amd.com, leo.duran@amd.com,
        Yazen.Ghannam@amd.com, rientjes@google.com, jiaqiyan@google.com,
        tony.luck@intel.com, Jon.Grimm@amd.com,
        dave.hansen@linux.intel.com, rafael@kernel.org, lenb@kernel.org,
        naoya.horiguchi@nec.com, james.morse@arm.com,
        jthoughton@google.com, somasundaram.a@hpe.com,
        erdemaktas@google.com, pgonda@google.com, duenwen@google.com,
        mike.malvestuto@intel.com, gthelen@google.com,
        wschwartz@amperecomputing.com, dferguson@amperecomputing.com,
        tanxiaofei@huawei.com, prime.zeng@hisilicon.com,
        kangkang.shen@futurewei.com, wanghuiqiang@huawei.com,
        linuxarm@huawei.com, fan.ni@samsung.com, a.manzanares@samsung.com
Subject: Re: [PATCH v2 03/10] cxl/mbox: Add SET_FEATURE mailbox command
Message-ID: <l6spiq3w45fwswuz4adrhhll2w52sc3vj2gg57kys5aaulo6v4@i4pbbjzhm3aq>
Mail-Followup-To: shiju.jose@huawei.com, linux-cxl@vger.kernel.org, 
        linux-mm@kvack.org, jonathan.cameron@huawei.com, dave.jiang@intel.com, 
        alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com, 
        dan.j.williams@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
        david@redhat.com, Vilas.Sridharan@amd.com, leo.duran@amd.com, 
        Yazen.Ghannam@amd.com, rientjes@google.com, jiaqiyan@google.com, tony.luck@intel.com, 
        Jon.Grimm@amd.com, dave.hansen@linux.intel.com, rafael@kernel.org, lenb@kernel.org, 
        naoya.horiguchi@nec.com, james.morse@arm.com, jthoughton@google.com, 
        somasundaram.a@hpe.com, erdemaktas@google.com, pgonda@google.com, duenwen@google.com, 
        mike.malvestuto@intel.com, gthelen@google.com, wschwartz@amperecomputing.com, 
        dferguson@amperecomputing.com, tanxiaofei@huawei.com, prime.zeng@hisilicon.com, 
        kangkang.shen@futurewei.com, wanghuiqiang@huawei.com, linuxarm@huawei.com, fan.ni@samsung.com, 
        a.manzanares@samsung.com
References: <20231121101844.1161-1-shiju.jose@huawei.com>
 <20231121101844.1161-4-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231121101844.1161-4-shiju.jose@huawei.com>
User-Agent: NeoMutt/20231006
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023, shiju.jose@huawei.com wrote:

>From: Shiju Jose <shiju.jose@huawei.com>
>
>Add support for SET_FEATURE mailbox command.
>
>CXL spec 3.0 section 8.2.9.6 describes optional device specific features.
>CXL devices supports features with changeable attributes.
>The settings of a feature can be optionally modified using Set Feature
>command.
>
>Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
>---
> drivers/cxl/core/mbox.c      | 15 +++++++++++++++
> drivers/cxl/cxlmem.h         | 27 +++++++++++++++++++++++++++
> include/uapi/linux/cxl_mem.h |  1 +
> 3 files changed, 43 insertions(+)
>
>diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>index 2675c616caec..d892b07446ca 100644
>--- a/drivers/cxl/core/mbox.c
>+++ b/drivers/cxl/core/mbox.c
>@@ -65,6 +65,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
> 	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
> 	CXL_CMD(GET_SUPPORTED_FEATURES, 0x8, CXL_VARIABLE_PAYLOAD, 0),
> 	CXL_CMD(GET_FEATURE, 0x15, CXL_VARIABLE_PAYLOAD, 0),
>+	CXL_CMD(SET_FEATURE, CXL_VARIABLE_PAYLOAD, 0, 0),
> };
>
> /*
>@@ -1350,6 +1351,20 @@ int cxl_get_feature(struct cxl_memdev_state *mds,
> }
> EXPORT_SYMBOL_NS_GPL(cxl_get_feature, CXL);
>
>+int cxl_set_feature(struct cxl_memdev_state *mds, void *feat_in, size_t size)
>+{
>+	struct cxl_mbox_cmd mbox_cmd;
>+
>+	mbox_cmd = (struct cxl_mbox_cmd) {
>+		.opcode = CXL_MBOX_OP_SET_FEATURE,
>+		.size_in = size,
>+		.payload_in = feat_in,
>+	};
>+
>+	return cxl_internal_send_cmd(mds, &mbox_cmd);
>+}
>+EXPORT_SYMBOL_NS_GPL(cxl_set_feature, CXL);
>+
> int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> 		       struct cxl_region *cxlr)
> {
>diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>index 92c1f2a44713..46131dcd0900 100644
>--- a/drivers/cxl/cxlmem.h
>+++ b/drivers/cxl/cxlmem.h
>@@ -508,6 +508,7 @@ enum cxl_opcode {
> 	CXL_MBOX_OP_GET_LOG		= 0x0401,
> 	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
> 	CXL_MBOX_OP_GET_FEATURE		= 0x0501,
>+	CXL_MBOX_OP_SET_FEATURE		= 0x0502,
> 	CXL_MBOX_OP_IDENTIFY		= 0x4000,
> 	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
> 	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
>@@ -817,6 +818,31 @@ struct cxl_mbox_get_feat_in {
> 	u8 selection;
> }  __packed;
>
>+/* Set Feature CXL 3.0 Spec 8.2.9.6.3 */
>+/*
>+ * Set Feature input payload
>+ * CXL rev 3.0 section 8.2.9.6.3; Table 8-81
>+ */
>+/* Set Feature : Payload in flags */
>+#define CXL_SET_FEAT_FLAG_DATA_TRANSFER_MASK	GENMASK(2, 0)
>+enum cxl_set_feat_flag_data_transfer {
>+	CXL_SET_FEAT_FLAG_FULL_DATA_TRANSFER = 0x0,
>+	CXL_SET_FEAT_FLAG_INITIATE_DATA_TRANSFER = 0x1,
>+	CXL_SET_FEAT_FLAG_CONTINUE_DATA_TRANSFER = 0x2,
>+	CXL_SET_FEAT_FLAG_FINISH_DATA_TRANSFER = 0x3,
>+	CXL_SET_FEAT_FLAG_ABORT_DATA_TRANSFER = 0x4,
>+	CXL_SET_FEAT_FLAG_DATA_TRANSFER_MAX
>+};
>+#define CXL_SET_FEAT_FLAG_MOD_VALUE_SAVED_ACROSS_RESET	BIT(3)
>+
>+struct cxl_mbox_set_feat_in {
>+	uuid_t uuid;
>+	__le32 flags;
>+	__le16 offset;
>+	u8 version;
>+	u8 rsvd[9];
>+}  __packed;
>+
> /* Get Poison List  CXL 3.0 Spec 8.2.9.8.4.1 */
> struct cxl_mbox_poison_in {
> 	__le64 offset;
>@@ -949,6 +975,7 @@ int cxl_get_supported_features(struct cxl_memdev_state *mds,
> 			       void *feats_out);
> int cxl_get_feature(struct cxl_memdev_state *mds,
> 		    struct cxl_mbox_get_feat_in *pi, void *feat_out);
>+int cxl_set_feature(struct cxl_memdev_state *mds, void *feat_in, size_t size);
> int cxl_poison_state_init(struct cxl_memdev_state *mds);
> int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> 		       struct cxl_region *cxlr);
>diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
>index b20de60bfc71..8c89d323cc41 100644
>--- a/include/uapi/linux/cxl_mem.h
>+++ b/include/uapi/linux/cxl_mem.h
>@@ -48,6 +48,7 @@
> 	___DEPRECATED(GET_SCAN_MEDIA, "Get Scan Media Results"),          \
> 	___C(GET_SUPPORTED_FEATURES, "Get Supported Features"),           \
> 	___C(GET_FEATURE, "Get Feature"),                                 \
>+	___C(SET_FEATURE, "Set Feature"),                                 \

I don't think we want to export this to userspace, and you are
already using the scrub driver for setting feat attributes.

> 	___C(MAX, "invalid / last command")
>
> #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
>-- 
>2.34.1
>
