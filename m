Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A090E7BE290
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377717AbjJIOVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377666AbjJIOVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:21:04 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFD1196;
        Mon,  9 Oct 2023 07:20:35 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 399Ce6ju023112;
        Mon, 9 Oct 2023 14:20:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=h3xSLnLHj6PnTHglmvRguWsZDsEuuAAN7I/QDS4mg38=;
 b=oaQt0vMFfNrTdcJgxYmzO2yeHqA6OlWM1fTDVGYvvgEP1xV/0qqzrf1F9VESHhXhEp2m
 isYbCAgTzq/Mt48gUk4VV95fwF8dhONWnTz4/tC8jSEe7fVplztDWax5cwsNWkU2vg4A
 ZXlGdsiGycGOiie/guFmKun4OuCzOomAYzbzY356ZY0IRXALrqVazGeayoLcD0tGx9kI
 DwnSGlmBVxvz95JjAk9JHCB0z5IFGjIyLLjspNMAy9n7w6YL1nu29NGFUSMaNWZ+EnzH
 LHKOypg6YQY3m2ILQC3xqgR0oOtcpAo79PY+l+djmALtSf2KBjrlz8yRTED072SqdDzN gA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tkh4dammp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 14:20:26 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 399EKPAC012200
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Oct 2023 14:20:25 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Mon, 9 Oct 2023 07:20:20 -0700
From:   Krishna Kurapati <quic_kriskura@quicinc.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
        onathan Corbet <corbet@lwn.net>,
        Linyu Yuan <quic_linyyuan@quicinc.com>
CC:     <linux-usb@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_wcheng@quicinc.com>, <quic_jackp@quicinc.com>,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH 2/2] usb: gadget: ncm: Add support to update wMaxSegmentSize via configfs
Date:   Mon, 9 Oct 2023 19:50:05 +0530
Message-ID: <20231009142005.21338-2-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009142005.21338-1-quic_kriskura@quicinc.com>
References: <20231009142005.21338-1-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Gj92zfE8xHz75HBo_vEiTv8jvkMcSNsr
X-Proofpoint-ORIG-GUID: Gj92zfE8xHz75HBo_vEiTv8jvkMcSNsr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_12,2023-10-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 phishscore=0
 spamscore=0 clxscore=1011 adultscore=0 impostorscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310090118
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the NCM driver restricts wMaxSegmentSize that indicates
the datagram size coming from network layer to 1514. However the
spec doesn't have any limitation. For P2P connections over NCM,
increasing MTU helps increasing throughput.

Add support to configure this value before configfs symlink is
created. Also since the NTB Out/In buffer sizes are fixed at 16384
bytes, limit the segment size to an upper cap of 15014. Set the
default MTU size for the ncm interface during function bind before
network interface is registered allowing MTU to be set in parity
with wMaxSegmentSize.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
 drivers/usb/gadget/function/f_ncm.c | 51 +++++++++++++++++++++++++++++
 drivers/usb/gadget/function/u_ncm.h |  2 ++
 2 files changed, 53 insertions(+)

diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index feccf4c8cc4f..eab297b22200 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -103,6 +103,8 @@ static inline struct f_ncm *func_to_ncm(struct usb_function *f)
 /* Delay for the transmit to wait before sending an unfilled NTB frame. */
 #define TX_TIMEOUT_NSECS	300000
 
+#define MAX_DATAGRAM_SIZE	15014
+
 #define FORMATS_SUPPORTED	(USB_CDC_NCM_NTB16_SUPPORTED |	\
 				 USB_CDC_NCM_NTB32_SUPPORTED)
 
@@ -1408,6 +1410,7 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 	ncm_opts = container_of(f->fi, struct f_ncm_opts, func_inst);
 
 	if (cdev->use_os_string) {
+		ncm_opts->net->mtu = (ncm_opts->max_segment_size - ETH_HLEN);
 		f->os_desc_table = kzalloc(sizeof(*f->os_desc_table),
 					   GFP_KERNEL);
 		if (!f->os_desc_table)
@@ -1469,6 +1472,8 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 
 	status = -ENODEV;
 
+	ecm_desc.wMaxSegmentSize = ncm_opts->max_segment_size;
+
 	/* allocate instance-specific endpoints */
 	ep = usb_ep_autoconfig(cdev->gadget, &fs_ncm_in_desc);
 	if (!ep)
@@ -1569,11 +1574,56 @@ USB_ETHERNET_CONFIGFS_ITEM_ATTR_QMULT(ncm);
 /* f_ncm_opts_ifname */
 USB_ETHERNET_CONFIGFS_ITEM_ATTR_IFNAME(ncm);
 
+static ssize_t ncm_opts_max_segment_size_show(struct config_item *item,
+					      char *page)
+{
+	struct f_ncm_opts *opts = to_f_ncm_opts(item);
+	u32 segment_size;
+
+	mutex_lock(&opts->lock);
+	segment_size = opts->max_segment_size;
+	mutex_unlock(&opts->lock);
+
+	return sprintf(page, "%u\n", segment_size);
+}
+
+static ssize_t ncm_opts_max_segment_size_store(struct config_item *item,
+					       const char *page, size_t len)
+{
+	struct f_ncm_opts *opts = to_f_ncm_opts(item);
+	int ret;
+	u32 segment_size;
+
+	mutex_lock(&opts->lock);
+	if (opts->refcnt) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	ret = kstrtou32(page, 0, &segment_size);
+	if (ret)
+		goto out;
+
+	if (segment_size > MAX_DATAGRAM_SIZE) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	opts->max_segment_size = segment_size;
+	ret = len;
+out:
+	mutex_unlock(&opts->lock);
+	return ret;
+}
+
+CONFIGFS_ATTR(ncm_opts_, max_segment_size);
+
 static struct configfs_attribute *ncm_attrs[] = {
 	&ncm_opts_attr_dev_addr,
 	&ncm_opts_attr_host_addr,
 	&ncm_opts_attr_qmult,
 	&ncm_opts_attr_ifname,
+	&ncm_opts_attr_max_segment_size,
 	NULL,
 };
 
@@ -1616,6 +1666,7 @@ static struct usb_function_instance *ncm_alloc_inst(void)
 		kfree(opts);
 		return ERR_CAST(net);
 	}
+	opts->max_segment_size = cpu_to_le16(ETH_FRAME_LEN);
 	INIT_LIST_HEAD(&opts->ncm_os_desc.ext_prop);
 
 	descs[0] = &opts->ncm_os_desc;
diff --git a/drivers/usb/gadget/function/u_ncm.h b/drivers/usb/gadget/function/u_ncm.h
index 5408854d8407..d3403cf13f17 100644
--- a/drivers/usb/gadget/function/u_ncm.h
+++ b/drivers/usb/gadget/function/u_ncm.h
@@ -31,6 +31,8 @@ struct f_ncm_opts {
 	 */
 	struct mutex			lock;
 	int				refcnt;
+
+	u32				max_segment_size;
 };
 
 #endif /* U_NCM_H */
-- 
2.42.0

