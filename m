Return-Path: <linux-kernel+bounces-8667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5632881BAD3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:32:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D05F286179
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32DA539F2;
	Thu, 21 Dec 2023 15:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EPOlLkFY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931E2539E6;
	Thu, 21 Dec 2023 15:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BLE52L6014601;
	Thu, 21 Dec 2023 15:32:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=r2eajES
	iH3ZLCXG80R1YRJE+/6dxGjQt9PsMJiwCzc8=; b=EPOlLkFYE7UCwzDw1KVnS6L
	MPMXBshaMm1aOvkNRMn4xqWJ/XRLLdo4rm59d0CVeJYfMAohw4f4P6TQ18QpNZh3
	TBJPQb+0wOEKhTqvWWyKG7tzdhXtejmWgP2gBGFh2mpXVBjI6q9rbiuuxa2aDKJc
	2uSzBqs33Oe1RmxkL3LRYe5wlcJ4YnvCQjKGeS/rMU8SeE+30Fz7/XAQ+VkGisVc
	oPr3Dd+kBF6PotdN2FIe1HUaETielmlAqM3nTo3QKTWIdvS+Vrt8tDARCawHnk/O
	NfrWZJLYJJR+ha55r36tXkQ3OecnpWeLbWKKqigUpmi5jndTLxIZy5A14EnCY6A=
	=
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v4pte077p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 15:32:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BLFWSmL031684
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Dec 2023 15:32:28 GMT
Received: from hu-kriskura-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 21 Dec 2023 07:32:25 -0800
From: Krishna Kurapati <quic_kriskura@quicinc.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet
	<corbet@lwn.net>,
        =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
        Hardik Gajjar <hgajjar@de.adit-jv.com>
CC: <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <quic_ppratap@quicinc.com>,
        <quic_jackp@quicinc.com>, Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: [PATCH v2] usb: gadget: ncm: Add support to update wMaxSegmentSize via configfs
Date: Thu, 21 Dec 2023 21:02:16 +0530
Message-ID: <20231221153216.18657-1-quic_kriskura@quicinc.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OiI5g155Wochpovj5LFAQssmCeM82dGU
X-Proofpoint-ORIG-GUID: OiI5g155Wochpovj5LFAQssmCeM82dGU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 clxscore=1011 priorityscore=1501 malwarescore=0 impostorscore=0
 phishscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312210117

The max segment size is currently limited to the ethernet frame length of
the kernel which happens to be 1514 at this point in time. However the NCM
specification limits it to 64K for sixtenn bit NTB's. For peer to peer
connections, increasing the segment size gives better throughput.

Add support to configure this value before configfs symlink is created.
Also since the NTB Out/In buffer sizes are fixed at 16384 bytes, limit the
segment size to an upper cap of 8000 to allow at least a minimum of 2 MTU
sized datagrams to be aggregated.

Set the default MTU size for the ncm interface during function bind before
network interface is registered allowing MTU to be set in parity with
wMaxSegmentSize.

Update gadget documentation describing the new configfs property.

Signed-off-by: Krishna Kurapati <quic_kriskura@quicinc.com>
---
Changes in v2:
Commit text updated as per reviews on v1.
Documenation and driver code merged into one patch.

Link to v1:
https://lore.kernel.org/all/20231009142005.21338-1-quic_kriskura@quicinc.com/

 Documentation/usb/gadget-testing.rst | 20 ++++----
 drivers/usb/gadget/function/f_ncm.c  | 69 ++++++++++++++++++++++++++--
 drivers/usb/gadget/function/u_ncm.h  |  2 +
 3 files changed, 79 insertions(+), 12 deletions(-)

diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gadget-testing.rst
index 29072c166d23..8cd62c466d20 100644
--- a/Documentation/usb/gadget-testing.rst
+++ b/Documentation/usb/gadget-testing.rst
@@ -448,15 +448,17 @@ Function-specific configfs interface
 The function name to use when creating the function directory is "ncm".
 The NCM function provides these attributes in its function directory:
 
-	=============== ==================================================
-	ifname		network device interface name associated with this
-			function instance
-	qmult		queue length multiplier for high and super speed
-	host_addr	MAC address of host's end of this
-			Ethernet over USB link
-	dev_addr	MAC address of device's end of this
-			Ethernet over USB link
-	=============== ==================================================
+	===============   ==================================================
+	ifname		  network device interface name associated with this
+			  function instance
+	qmult		  queue length multiplier for high and super speed
+	host_addr	  MAC address of host's end of this
+			  Ethernet over USB link
+	dev_addr	  MAC address of device's end of this
+			  Ethernet over USB link
+	max_segment_size  Segment size required for P2P connections. This
+			  will set MTU to (max_segment_size - 14 bytes)
+	===============   ==================================================
 
 and after creating the functions/ncm.<instance name> they contain default
 values: qmult is 5, dev_addr and host_addr are randomly selected.
diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index cc0ed29a4adc..a1575a0ca568 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -103,6 +103,16 @@ static inline struct f_ncm *func_to_ncm(struct usb_function *f)
 /* Delay for the transmit to wait before sending an unfilled NTB frame. */
 #define TX_TIMEOUT_NSECS	300000
 
+/*
+ * Although max mtu as dictated by u_ether is 15412 bytes, setting
+ * max_segment_sizeto 15426 would not be efficient. If user chooses segment
+ * size to be (>= 8192), then we can't aggregate more than one  buffer in each
+ * NTB (assuming each packet coming from network layer is >= 8192 bytes) as ep
+ * maxpacket limit is 16384. So let max_segment_size be limited to 8000 to allow
+ * at least 2 packets to be aggregated reducing wastage of NTB buffer space
+ */
+#define MAX_DATAGRAM_SIZE	8000
+
 #define FORMATS_SUPPORTED	(USB_CDC_NCM_NTB16_SUPPORTED |	\
 				 USB_CDC_NCM_NTB32_SUPPORTED)
 
@@ -179,7 +189,6 @@ static struct usb_cdc_ether_desc ecm_desc = {
 	/* this descriptor actually adds value, surprise! */
 	/* .iMACAddress = DYNAMIC */
 	.bmEthernetStatistics =	cpu_to_le32(0), /* no statistics */
-	.wMaxSegmentSize =	cpu_to_le16(ETH_FRAME_LEN),
 	.wNumberMCFilters =	cpu_to_le16(0),
 	.bNumberPowerFilters =	0,
 };
@@ -1166,11 +1175,15 @@ static int ncm_unwrap_ntb(struct gether *port,
 	struct sk_buff	*skb2;
 	int		ret = -EINVAL;
 	unsigned	ntb_max = le32_to_cpu(ntb_parameters.dwNtbOutMaxSize);
-	unsigned	frame_max = le16_to_cpu(ecm_desc.wMaxSegmentSize);
+	unsigned	frame_max;
 	const struct ndp_parser_opts *opts = ncm->parser_opts;
 	unsigned	crc_len = ncm->is_crc ? sizeof(uint32_t) : 0;
 	int		dgram_counter;
 	int		to_process = skb->len;
+	struct f_ncm_opts *ncm_opts;
+
+	ncm_opts = container_of(port->func.fi, struct f_ncm_opts, func_inst);
+	frame_max = ncm_opts->max_segment_size;
 
 parse_ntb:
 	tmp = (__le16 *)ntb_ptr;
@@ -1430,8 +1443,10 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 
 	mutex_lock(&ncm_opts->lock);
 	gether_set_gadget(ncm_opts->net, cdev->gadget);
-	if (!ncm_opts->bound)
+	if (!ncm_opts->bound) {
+		ncm_opts->net->mtu = (ncm_opts->max_segment_size - ETH_HLEN);
 		status = gether_register_netdev(ncm_opts->net);
+	}
 	mutex_unlock(&ncm_opts->lock);
 
 	if (status)
@@ -1474,6 +1489,8 @@ static int ncm_bind(struct usb_configuration *c, struct usb_function *f)
 	ncm_data_intf.bInterfaceNumber = status;
 	ncm_union_desc.bSlaveInterface0 = status;
 
+	ecm_desc.wMaxSegmentSize = ncm_opts->max_segment_size;
+
 	status = -ENODEV;
 
 	/* allocate instance-specific endpoints */
@@ -1576,11 +1593,56 @@ USB_ETHERNET_CONFIGFS_ITEM_ATTR_QMULT(ncm);
 /* f_ncm_opts_ifname */
 USB_ETHERNET_CONFIGFS_ITEM_ATTR_IFNAME(ncm);
 
+static ssize_t ncm_opts_max_segment_size_show(struct config_item *item,
+					      char *page)
+{
+	struct f_ncm_opts *opts = to_f_ncm_opts(item);
+	u16 segment_size;
+
+	mutex_lock(&opts->lock);
+	segment_size = opts->max_segment_size;
+	mutex_unlock(&opts->lock);
+
+	return sysfs_emit(page, "%u\n", segment_size);
+}
+
+static ssize_t ncm_opts_max_segment_size_store(struct config_item *item,
+					       const char *page, size_t len)
+{
+	struct f_ncm_opts *opts = to_f_ncm_opts(item);
+	u16 segment_size;
+	int ret;
+
+	mutex_lock(&opts->lock);
+	if (opts->refcnt) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	ret = kstrtou16(page, 0, &segment_size);
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
 
@@ -1623,6 +1685,7 @@ static struct usb_function_instance *ncm_alloc_inst(void)
 		kfree(opts);
 		return ERR_CAST(net);
 	}
+	opts->max_segment_size = cpu_to_le16(ETH_FRAME_LEN);
 	INIT_LIST_HEAD(&opts->ncm_os_desc.ext_prop);
 
 	descs[0] = &opts->ncm_os_desc;
diff --git a/drivers/usb/gadget/function/u_ncm.h b/drivers/usb/gadget/function/u_ncm.h
index 5408854d8407..49ec095cdb4b 100644
--- a/drivers/usb/gadget/function/u_ncm.h
+++ b/drivers/usb/gadget/function/u_ncm.h
@@ -31,6 +31,8 @@ struct f_ncm_opts {
 	 */
 	struct mutex			lock;
 	int				refcnt;
+
+	u16				max_segment_size;
 };
 
 #endif /* U_NCM_H */
-- 
2.42.0


