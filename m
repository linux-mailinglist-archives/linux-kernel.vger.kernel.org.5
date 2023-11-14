Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD707EAEC4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 12:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbjKNLZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 06:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbjKNLZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 06:25:46 -0500
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A008CC;
        Tue, 14 Nov 2023 03:25:41 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AE9mwrw007654;
        Tue, 14 Nov 2023 11:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=Qav6ZWCWGSiJGFNSSRMMm2Kymuvi6DkVPSo2UfttrdU=;
 b=PcOmywdVKbSFrvBdXeRrNKX7w9GV+NwgTU0lY8g8n0cx6j77dV3+fTF+dhmH9zTqAioi
 0VvGHQzFAKc1Nl2Wy1fprPKjj/GQnNYWIFWJirqlnafnGrBB+tD7i87ecHEUuZoMSBEH
 2DvM7VKGexJ92BZJpzomdyWweeKJbMSNs3nVQJCbmAEL3H0hohfkiHOqrh2ZEYbep6MD
 RAmVtYCCo2UIRFPhFnDerNtZ8A1bLp8KAxdBWq+gx1IJCN1LFu/JYxdr1+URER88NUUT
 2/s8FT+GmboibCECOJssQkGh7aXEk4F8vd0VYrYrmTrK+KgEY1ZiKy14MSNwu+0Ww3vk Aw== 
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ubqvt9yt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 11:25:32 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AEBPVO6023866
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Nov 2023 11:25:31 GMT
Received: from hu-akakum-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Tue, 14 Nov 2023 03:25:27 -0800
From:   Akash Kumar <quic_akakum@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jing Leng <jleng@ambarella.com>,
        Felipe Balbi <balbi@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     =?UTF-8?q?Pratham=20Pratap=C2=A0?= <quic_ppratap@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Akash Kumar <quic_akakum@quicinc.com>
Subject: [PATCH] usb: gadget: uvc: Add framebased frame format support
Date:   Tue, 14 Nov 2023 16:55:16 +0530
Message-ID: <20231114112516.2723-1-quic_akakum@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1YC2Mkv-LyvpkCyi_WXjTJUBm3Ac2wsi
X-Proofpoint-GUID: 1YC2Mkv-LyvpkCyi_WXjTJUBm3Ac2wsi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_10,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=815 clxscore=1011 spamscore=0 impostorscore=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140087
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for framebased frame format which can be used to support
multiple formats like H264 or H265 other than mjpeg and YUV frames.

Framebased format is set to H264 by default, which can be updated to
other formats by updating the GUID through guid configfs attribute.

Also,add UVC 1.5 extension to support H264 format and different camera
controls, adding support for Exposure, Zoom, Pan, tilt.

Signed-off-by: Akash Kumar <quic_akakum@quicinc.com>
---
 drivers/usb/gadget/function/f_uvc.c        |  13 +-
 drivers/usb/gadget/function/uvc_configfs.c | 565 ++++++++++++++++++---
 drivers/usb/gadget/function/uvc_v4l2.c     |   1 +
 include/uapi/linux/usb/video.h             |  60 ++-
 4 files changed, 560 insertions(+), 79 deletions(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index 0b9712616455..17299735c1ff 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -802,9 +802,9 @@ static struct usb_function_instance *uvc_alloc_inst(void)
 	cd->wObjectiveFocalLengthMax	= cpu_to_le16(0);
 	cd->wOcularFocalLength		= cpu_to_le16(0);
 	cd->bControlSize		= 3;
-	cd->bmControls[0]		= 2;
-	cd->bmControls[1]		= 0;
-	cd->bmControls[2]		= 0;
+	cd->bmControls[0]		= 62;
+	cd->bmControls[1]		= 126;
+	cd->bmControls[2]		= 10;
 
 	pd = &opts->uvc_processing;
 	pd->bLength			= UVC_DT_PROCESSING_UNIT_SIZE(2);
@@ -813,9 +813,10 @@ static struct usb_function_instance *uvc_alloc_inst(void)
 	pd->bUnitID			= 2;
 	pd->bSourceID			= 1;
 	pd->wMaxMultiplier		= cpu_to_le16(16*1024);
-	pd->bControlSize		= 2;
-	pd->bmControls[0]		= 1;
-	pd->bmControls[1]		= 0;
+	pd->bControlSize		= 3;
+	pd->bmControls[0]		= 91;
+	pd->bmControls[1]		= 23;
+	pd->bmControls[2]		= 4;
 	pd->iProcessing			= 0;
 
 	od = &opts->uvc_output_terminal;
diff --git a/drivers/usb/gadget/function/uvc_configfs.c b/drivers/usb/gadget/function/uvc_configfs.c
index 00fb58e50a15..7e05fcec9fb1 100644
--- a/drivers/usb/gadget/function/uvc_configfs.c
+++ b/drivers/usb/gadget/function/uvc_configfs.c
@@ -231,7 +231,7 @@ static struct config_item *uvcg_control_header_make(struct config_group *group,
 	h->desc.bLength			= UVC_DT_HEADER_SIZE(1);
 	h->desc.bDescriptorType		= USB_DT_CS_INTERFACE;
 	h->desc.bDescriptorSubType	= UVC_VC_HEADER;
-	h->desc.bcdUVC			= cpu_to_le16(0x0100);
+	h->desc.bcdUVC			= cpu_to_le16(0x0150);
 	h->desc.dwClockFrequency	= cpu_to_le32(48000000);
 
 	config_item_init_type_name(&h->item, name, &uvcg_control_header_type);
@@ -767,11 +767,13 @@ static const struct uvcg_config_group_type uvcg_control_grp_type = {
 static const char * const uvcg_format_names[] = {
 	"uncompressed",
 	"mjpeg",
+	"h264",
 };
 
 enum uvcg_format_type {
 	UVCG_UNCOMPRESSED = 0,
 	UVCG_MJPEG,
+	UVCG_FRAMEBASED,
 };
 
 struct uvcg_format {
@@ -1067,20 +1069,11 @@ static const struct uvcg_config_group_type uvcg_streaming_header_grp_type = {
 struct uvcg_frame {
 	struct config_item	item;
 	enum uvcg_format_type	fmt_type;
-	struct {
-		u8	b_length;
-		u8	b_descriptor_type;
-		u8	b_descriptor_subtype;
-		u8	b_frame_index;
-		u8	bm_capabilities;
-		u16	w_width;
-		u16	w_height;
-		u32	dw_min_bit_rate;
-		u32	dw_max_bit_rate;
-		u32	dw_max_video_frame_buffer_size;
-		u32	dw_default_frame_interval;
-		u8	b_frame_interval_type;
-	} __attribute__((packed)) frame;
+	union {
+		struct uvc_frame_uncompressed uf;
+		struct uvc_frame_mjpeg mf;
+		struct uvc_frame_framebased hf;
+	} frame;
 	u32 *dw_frame_interval;
 };
 
@@ -1089,8 +1082,8 @@ static struct uvcg_frame *to_uvcg_frame(struct config_item *item)
 	return container_of(item, struct uvcg_frame, item);
 }
 
-#define UVCG_FRAME_ATTR(cname, aname, bits) \
-static ssize_t uvcg_frame_##cname##_show(struct config_item *item, char *page)\
+#define UVCG_FRAME_ATTR(cname, fname, bits) \
+static ssize_t uvcg_frame_##fname##_##cname##_show(struct config_item *item, char *page)\
 {									\
 	struct uvcg_frame *f = to_uvcg_frame(item);			\
 	struct f_uvc_opts *opts;					\
@@ -1104,14 +1097,14 @@ static ssize_t uvcg_frame_##cname##_show(struct config_item *item, char *page)\
 	opts = to_f_uvc_opts(opts_item);				\
 									\
 	mutex_lock(&opts->lock);					\
-	result = sprintf(page, "%u\n", f->frame.cname);			\
+	result = scnprintf(page, PAGE_SIZE, "%u\n", f->frame.fname.cname);\
 	mutex_unlock(&opts->lock);					\
 									\
 	mutex_unlock(su_mutex);						\
 	return result;							\
 }									\
 									\
-static ssize_t  uvcg_frame_##cname##_store(struct config_item *item,	\
+static ssize_t  uvcg_frame_##fname##_##cname##_store(struct config_item *item,	\
 					   const char *page, size_t len)\
 {									\
 	struct uvcg_frame *f = to_uvcg_frame(item);			\
@@ -1119,7 +1112,7 @@ static ssize_t  uvcg_frame_##cname##_store(struct config_item *item,	\
 	struct config_item *opts_item;					\
 	struct uvcg_format *fmt;					\
 	struct mutex *su_mutex = &f->item.ci_group->cg_subsys->su_mutex;\
-	typeof(f->frame.cname) num;					\
+	typeof(f->frame.fname.cname) num;					\
 	int ret;							\
 									\
 	ret = kstrtou##bits(page, 0, &num);				\
@@ -1138,7 +1131,7 @@ static ssize_t  uvcg_frame_##cname##_store(struct config_item *item,	\
 		goto end;						\
 	}								\
 									\
-	f->frame.cname = num;						\
+	f->frame.fname.cname = num;					\
 	ret = len;							\
 end:									\
 	mutex_unlock(&opts->lock);					\
@@ -1146,7 +1139,7 @@ end:									\
 	return ret;							\
 }									\
 									\
-UVC_ATTR(uvcg_frame_, cname, aname);
+UVC_ATTR(uvcg_frame_, fname##_##cname, cname);
 
 static ssize_t uvcg_frame_b_frame_index_show(struct config_item *item,
 					     char *page)
@@ -1158,6 +1151,7 @@ static ssize_t uvcg_frame_b_frame_index_show(struct config_item *item,
 	struct config_item *fmt_item;
 	struct mutex *su_mutex = &f->item.ci_group->cg_subsys->su_mutex;
 	int result;
+	u8 frame_index = 0;
 
 	mutex_lock(su_mutex); /* for navigating configfs hierarchy */
 
@@ -1173,7 +1167,13 @@ static ssize_t uvcg_frame_b_frame_index_show(struct config_item *item,
 	opts = to_f_uvc_opts(opts_item);
 
 	mutex_lock(&opts->lock);
-	result = sprintf(page, "%u\n", f->frame.b_frame_index);
+	if (f->fmt_type == UVCG_UNCOMPRESSED)
+		frame_index = f->frame.uf.bFrameIndex;
+	else if (f->fmt_type == UVCG_MJPEG)
+		frame_index = f->frame.mf.bFrameIndex;
+	else if (f->fmt_type == UVCG_FRAMEBASED)
+		frame_index = f->frame.hf.bFrameIndex;
+	result = scnprintf(page, PAGE_SIZE, "%u\n", frame_index);
 	mutex_unlock(&opts->lock);
 
 out:
@@ -1183,13 +1183,32 @@ static ssize_t uvcg_frame_b_frame_index_show(struct config_item *item,
 
 UVC_ATTR_RO(uvcg_frame_, b_frame_index, bFrameIndex);
 
-UVCG_FRAME_ATTR(bm_capabilities, bmCapabilities, 8);
-UVCG_FRAME_ATTR(w_width, wWidth, 16);
-UVCG_FRAME_ATTR(w_height, wHeight, 16);
-UVCG_FRAME_ATTR(dw_min_bit_rate, dwMinBitRate, 32);
-UVCG_FRAME_ATTR(dw_max_bit_rate, dwMaxBitRate, 32);
-UVCG_FRAME_ATTR(dw_max_video_frame_buffer_size, dwMaxVideoFrameBufferSize, 32);
-UVCG_FRAME_ATTR(dw_default_frame_interval, dwDefaultFrameInterval, 32);
+/* Declare configurable frame attributes for uncompressed format */
+UVCG_FRAME_ATTR(bmCapabilities, uf, 8);
+UVCG_FRAME_ATTR(wWidth, uf, 16);
+UVCG_FRAME_ATTR(wHeight, uf, 16);
+UVCG_FRAME_ATTR(dwMinBitRate, uf, 32);
+UVCG_FRAME_ATTR(dwMaxBitRate, uf, 32);
+UVCG_FRAME_ATTR(dwMaxVideoFrameBufferSize, uf, 32);
+UVCG_FRAME_ATTR(dwDefaultFrameInterval, uf, 32);
+
+/* Declare configurable frame attributes for mjpeg format */
+UVCG_FRAME_ATTR(bmCapabilities, mf, 8);
+UVCG_FRAME_ATTR(wWidth, mf, 16);
+UVCG_FRAME_ATTR(wHeight, mf, 16);
+UVCG_FRAME_ATTR(dwMinBitRate, mf, 32);
+UVCG_FRAME_ATTR(dwMaxBitRate, mf, 32);
+UVCG_FRAME_ATTR(dwMaxVideoFrameBufferSize, mf, 32);
+UVCG_FRAME_ATTR(dwDefaultFrameInterval, mf, 32);
+
+/* Declare configurable frame attributes for framebased format */
+UVCG_FRAME_ATTR(bmCapabilities, hf, 8);
+UVCG_FRAME_ATTR(wWidth, hf, 16);
+UVCG_FRAME_ATTR(wHeight, hf, 16);
+UVCG_FRAME_ATTR(dwMinBitRate, hf, 32);
+UVCG_FRAME_ATTR(dwMaxBitRate, hf, 32);
+UVCG_FRAME_ATTR(dwDefaultFrameInterval, hf, 32);
+UVCG_FRAME_ATTR(dwBytesPerLine, hf, 32);
 
 #undef UVCG_FRAME_ATTR
 
@@ -1200,7 +1219,7 @@ static ssize_t uvcg_frame_dw_frame_interval_show(struct config_item *item,
 	struct f_uvc_opts *opts;
 	struct config_item *opts_item;
 	struct mutex *su_mutex = &frm->item.ci_group->cg_subsys->su_mutex;
-	int result, i;
+	int result, i, n;
 	char *pg = page;
 
 	mutex_lock(su_mutex); /* for navigating configfs hierarchy */
@@ -1209,7 +1228,15 @@ static ssize_t uvcg_frame_dw_frame_interval_show(struct config_item *item,
 	opts = to_f_uvc_opts(opts_item);
 
 	mutex_lock(&opts->lock);
-	for (result = 0, i = 0; i < frm->frame.b_frame_interval_type; ++i) {
+	n = 0;
+	if (frm->fmt_type == UVCG_UNCOMPRESSED)
+		n = frm->frame.uf.bFrameIntervalType;
+	else if (frm->fmt_type == UVCG_MJPEG)
+		n = frm->frame.mf.bFrameIntervalType;
+	else if (frm->fmt_type == UVCG_FRAMEBASED)
+		n = frm->frame.hf.bFrameIntervalType;
+
+	for (result = 0, i = 0; i < n; ++i) {
 		result += sprintf(pg, "%u\n", frm->dw_frame_interval[i]);
 		pg = page + result;
 	}
@@ -1311,7 +1338,13 @@ static ssize_t uvcg_frame_dw_frame_interval_store(struct config_item *item,
 
 	kfree(ch->dw_frame_interval);
 	ch->dw_frame_interval = frm_intrv;
-	ch->frame.b_frame_interval_type = n;
+	if (ch->fmt_type == UVCG_UNCOMPRESSED)
+		ch->frame.uf.bFrameIntervalType = n;
+	else if (ch->fmt_type == UVCG_MJPEG)
+		ch->frame.mf.bFrameIntervalType = n;
+	else if (ch->fmt_type == UVCG_FRAMEBASED)
+		ch->frame.hf.bFrameIntervalType = n;
+
 	sort(ch->dw_frame_interval, n, sizeof(*ch->dw_frame_interval),
 	     uvcg_config_compare_u32, NULL);
 	ret = len;
@@ -1324,22 +1357,57 @@ static ssize_t uvcg_frame_dw_frame_interval_store(struct config_item *item,
 
 UVC_ATTR(uvcg_frame_, dw_frame_interval, dwFrameInterval);
 
-static struct configfs_attribute *uvcg_frame_attrs[] = {
+static struct configfs_attribute *uvcg_uncompressed_frame_attrs[] = {
 	&uvcg_frame_attr_b_frame_index,
-	&uvcg_frame_attr_bm_capabilities,
-	&uvcg_frame_attr_w_width,
-	&uvcg_frame_attr_w_height,
-	&uvcg_frame_attr_dw_min_bit_rate,
-	&uvcg_frame_attr_dw_max_bit_rate,
-	&uvcg_frame_attr_dw_max_video_frame_buffer_size,
-	&uvcg_frame_attr_dw_default_frame_interval,
+	&uvcg_frame_attr_uf_bmCapabilities,
+	&uvcg_frame_attr_uf_wWidth,
+	&uvcg_frame_attr_uf_wHeight,
+	&uvcg_frame_attr_uf_dwMinBitRate,
+	&uvcg_frame_attr_uf_dwMaxBitRate,
+	&uvcg_frame_attr_uf_dwMaxVideoFrameBufferSize,
+	&uvcg_frame_attr_uf_dwDefaultFrameInterval,
 	&uvcg_frame_attr_dw_frame_interval,
 	NULL,
 };
 
-static const struct config_item_type uvcg_frame_type = {
-	.ct_item_ops	= &uvcg_config_item_ops,
-	.ct_attrs	= uvcg_frame_attrs,
+static struct configfs_attribute *uvcg_mjpeg_frame_attrs[] = {
+	&uvcg_frame_attr_b_frame_index,
+	&uvcg_frame_attr_mf_bmCapabilities,
+	&uvcg_frame_attr_mf_wWidth,
+	&uvcg_frame_attr_mf_wHeight,
+	&uvcg_frame_attr_mf_dwMinBitRate,
+	&uvcg_frame_attr_mf_dwMaxBitRate,
+	&uvcg_frame_attr_mf_dwMaxVideoFrameBufferSize,
+	&uvcg_frame_attr_mf_dwDefaultFrameInterval,
+	&uvcg_frame_attr_dw_frame_interval,
+	NULL,
+};
+
+static struct configfs_attribute *uvcg_framebased_frame_attrs[] = {
+	&uvcg_frame_attr_b_frame_index,
+	&uvcg_frame_attr_hf_bmCapabilities,
+	&uvcg_frame_attr_hf_wWidth,
+	&uvcg_frame_attr_hf_wHeight,
+	&uvcg_frame_attr_hf_dwMinBitRate,
+	&uvcg_frame_attr_hf_dwMaxBitRate,
+	&uvcg_frame_attr_hf_dwDefaultFrameInterval,
+	&uvcg_frame_attr_dw_frame_interval,
+	&uvcg_frame_attr_hf_dwBytesPerLine,
+	NULL,
+};
+
+static struct config_item_type uvcg_uncompressed_frame_type = {
+	.ct_attrs	= uvcg_uncompressed_frame_attrs,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct config_item_type uvcg_mjpeg_frame_type = {
+	.ct_attrs	= uvcg_mjpeg_frame_attrs,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct config_item_type uvcg_framebased_frame_type = {
+	.ct_attrs	= uvcg_framebased_frame_attrs,
 	.ct_owner	= THIS_MODULE,
 };
 
@@ -1350,19 +1418,17 @@ static struct config_item *uvcg_frame_make(struct config_group *group,
 	struct uvcg_format *fmt;
 	struct f_uvc_opts *opts;
 	struct config_item *opts_item;
+	struct config_item_type *uvcg_frame_config_item;
+	struct uvc_frame_uncompressed *uf;
 
 	h = kzalloc(sizeof(*h), GFP_KERNEL);
 	if (!h)
 		return ERR_PTR(-ENOMEM);
 
-	h->frame.b_descriptor_type		= USB_DT_CS_INTERFACE;
-	h->frame.b_frame_index			= 1;
-	h->frame.w_width			= 640;
-	h->frame.w_height			= 360;
-	h->frame.dw_min_bit_rate		= 18432000;
-	h->frame.dw_max_bit_rate		= 55296000;
-	h->frame.dw_max_video_frame_buffer_size	= 460800;
-	h->frame.dw_default_frame_interval	= 666666;
+	uf = &h->frame.uf;
+
+	uf->bDescriptorType		= USB_DT_CS_INTERFACE;
+	uf->bFrameIndex			= 1;
 
 	opts_item = group->cg_item.ci_parent->ci_parent->ci_parent;
 	opts = to_f_uvc_opts(opts_item);
@@ -1370,11 +1436,47 @@ static struct config_item *uvcg_frame_make(struct config_group *group,
 	mutex_lock(&opts->lock);
 	fmt = to_uvcg_format(&group->cg_item);
 	if (fmt->type == UVCG_UNCOMPRESSED) {
-		h->frame.b_descriptor_subtype = UVC_VS_FRAME_UNCOMPRESSED;
+		uf->bDescriptorSubType	= UVC_VS_FRAME_UNCOMPRESSED;
+		uf->wWidth			= cpu_to_le16(640);
+		uf->wHeight			= cpu_to_le16(360);
+		uf->dwMinBitRate		= cpu_to_le32(18432000);
+		uf->dwMaxBitRate		= cpu_to_le32(55296000);
+		uf->dwMaxVideoFrameBufferSize	= cpu_to_le32(460800);
+		uf->dwDefaultFrameInterval	= cpu_to_le32(666666);
+
 		h->fmt_type = UVCG_UNCOMPRESSED;
+		uvcg_frame_config_item = &uvcg_uncompressed_frame_type;
 	} else if (fmt->type == UVCG_MJPEG) {
-		h->frame.b_descriptor_subtype = UVC_VS_FRAME_MJPEG;
+		struct uvc_frame_mjpeg *mf = &h->frame.mf;
+
+		mf->bDescriptorType		= USB_DT_CS_INTERFACE;
+		mf->bFrameIndex			= 1;
+		mf->bDescriptorSubType	= UVC_VS_FRAME_MJPEG;
+		mf->wWidth			= cpu_to_le16(640);
+		mf->wHeight			= cpu_to_le16(360);
+		mf->dwMinBitRate		= cpu_to_le32(18432000);
+		mf->dwMaxBitRate		= cpu_to_le32(55296000);
+		mf->dwMaxVideoFrameBufferSize	= cpu_to_le32(460800);
+		mf->dwDefaultFrameInterval	= cpu_to_le32(666666);
+
 		h->fmt_type = UVCG_MJPEG;
+		uvcg_frame_config_item = &uvcg_mjpeg_frame_type;
+	} else if (fmt->type == UVCG_FRAMEBASED) {
+		struct uvc_frame_framebased *hf = &h->frame.hf;
+
+		hf->bDescriptorType		= USB_DT_CS_INTERFACE;
+		hf->bDescriptorSubType		= UVC_VS_FRAME_FRAME_BASED;
+		hf->bFrameIndex			= 1;
+		hf->wWidth			= cpu_to_le16(640);
+		hf->wHeight			= cpu_to_le16(360);
+		hf->dwMinBitRate		= cpu_to_le32(12288000);
+		hf->dwMaxBitRate		= cpu_to_le32(36864000);
+		hf->dwDefaultFrameInterval	= cpu_to_le32(333667);
+		hf->bmCapabilities	= 0x00;
+		hf->dwBytesPerLine	= 0;
+
+		h->fmt_type = UVCG_FRAMEBASED;
+		uvcg_frame_config_item = &uvcg_framebased_frame_type;
 	} else {
 		mutex_unlock(&opts->lock);
 		kfree(h);
@@ -1383,7 +1485,7 @@ static struct config_item *uvcg_frame_make(struct config_group *group,
 	++fmt->num_frames;
 	mutex_unlock(&opts->lock);
 
-	config_item_init_type_name(&h->item, name, &uvcg_frame_type);
+	config_item_init_type_name(&h->item, name, uvcg_frame_config_item);
 
 	return &h->item;
 }
@@ -1413,11 +1515,20 @@ static void uvcg_format_set_indices(struct config_group *fmt)
 	list_for_each_entry(ci, &fmt->cg_children, ci_entry) {
 		struct uvcg_frame *frm;
 
-		if (ci->ci_type != &uvcg_frame_type)
+		if ((ci->ci_type != &uvcg_uncompressed_frame_type) ||
+				(ci->ci_type != &uvcg_mjpeg_frame_type) ||
+				(ci->ci_type != &uvcg_framebased_frame_type))
 			continue;
 
 		frm = to_uvcg_frame(ci);
-		frm->frame.b_frame_index = i++;
+		if (frm->fmt_type == UVCG_UNCOMPRESSED)
+			frm->frame.uf.bFrameIndex = i;
+		else if (frm->fmt_type == UVCG_MJPEG)
+			frm->frame.mf.bFrameIndex = i;
+		else if (frm->fmt_type == UVCG_FRAMEBASED)
+			frm->frame.hf.bFrameIndex = i;
+
+		i++;
 	}
 }
 
@@ -1856,6 +1967,263 @@ static const struct uvcg_config_group_type uvcg_mjpeg_grp_type = {
 	.name = "mjpeg",
 };
 
+/* -----------------------------------------------------------------------------
+ * streaming/framebased/<NAME>
+ */
+
+struct uvcg_framebased {
+	struct uvcg_format		fmt;
+	struct uvc_format_framebased		desc;
+};
+
+static struct uvcg_framebased *to_uvcg_framebased(struct config_item *item)
+{
+	return container_of(
+		container_of(to_config_group(item), struct uvcg_format, group),
+		struct uvcg_framebased, fmt);
+}
+
+static struct configfs_group_operations uvcg_framebased_group_ops = {
+	.make_item		= uvcg_frame_make,
+	.drop_item		= uvcg_frame_drop,
+};
+
+#define UVCG_FRAMEBASED_ATTR_RO(cname, aname, bits)				\
+static ssize_t uvcg_framebased_##cname##_show(struct config_item *item, char *page)\
+{									\
+	struct uvcg_framebased *u = to_uvcg_framebased(item);			\
+	struct f_uvc_opts *opts;					\
+	struct config_item *opts_item;					\
+	struct mutex *su_mutex = &u->fmt.group.cg_subsys->su_mutex;	\
+	int result;							\
+									\
+	mutex_lock(su_mutex); /* for navigating configfs hierarchy */	\
+									\
+	opts_item = u->fmt.group.cg_item.ci_parent->ci_parent->ci_parent;\
+	opts = to_f_uvc_opts(opts_item);				\
+									\
+	mutex_lock(&opts->lock);					\
+	result = scnprintf(page, PAGE_SIZE, "%u\n",			\
+			le##bits##_to_cpu(u->desc.aname));		\
+	mutex_unlock(&opts->lock);					\
+									\
+	mutex_unlock(su_mutex);						\
+	return result;							\
+}									\
+									\
+UVC_ATTR_RO(uvcg_framebased_, cname, aname)
+
+#define UVCG_FRAMEBASED_ATTR(cname, aname, bits)				\
+static ssize_t uvcg_framebased_##cname##_show(struct config_item *item, char *page)\
+{									\
+	struct uvcg_framebased *u = to_uvcg_framebased(item);			\
+	struct f_uvc_opts *opts;					\
+	struct config_item *opts_item;					\
+	struct mutex *su_mutex = &u->fmt.group.cg_subsys->su_mutex;	\
+	int result;							\
+									\
+	mutex_lock(su_mutex); /* for navigating configfs hierarchy */	\
+									\
+	opts_item = u->fmt.group.cg_item.ci_parent->ci_parent->ci_parent;\
+	opts = to_f_uvc_opts(opts_item);				\
+									\
+	mutex_lock(&opts->lock);					\
+	result = scnprintf(page, PAGE_SIZE, "%u\n",			\
+			le##bits##_to_cpu(u->desc.aname));		\
+	mutex_unlock(&opts->lock);					\
+									\
+	mutex_unlock(su_mutex);						\
+	return result;							\
+}									\
+									\
+static ssize_t								\
+uvcg_framebased_##cname##_store(struct config_item *item,			\
+			   const char *page, size_t len)		\
+{									\
+	struct uvcg_framebased *u = to_uvcg_framebased(item);			\
+	struct f_uvc_opts *opts;					\
+	struct config_item *opts_item;					\
+	struct mutex *su_mutex = &u->fmt.group.cg_subsys->su_mutex;	\
+	int ret;							\
+	u8 num;								\
+									\
+	mutex_lock(su_mutex); /* for navigating configfs hierarchy */	\
+									\
+	opts_item = u->fmt.group.cg_item.ci_parent->ci_parent->ci_parent;\
+	opts = to_f_uvc_opts(opts_item);				\
+									\
+	mutex_lock(&opts->lock);					\
+	if (u->fmt.linked || opts->refcnt) {				\
+		ret = -EBUSY;						\
+		goto end;						\
+	}								\
+									\
+	ret = kstrtou8(page, 0, &num);					\
+	if (ret)							\
+		goto end;						\
+									\
+	if (num > 255) {						\
+		ret = -EINVAL;						\
+		goto end;						\
+	}								\
+	u->desc.aname = num;						\
+	ret = len;							\
+end:									\
+	mutex_unlock(&opts->lock);					\
+	mutex_unlock(su_mutex);						\
+	return ret;							\
+}									\
+									\
+UVC_ATTR(uvcg_framebased_, cname, aname)
+
+UVCG_FRAMEBASED_ATTR_RO(b_format_index, bFormatIndex, 8);
+UVCG_FRAMEBASED_ATTR_RO(b_bits_per_pixel, bBitsPerPixel, 8);
+UVCG_FRAMEBASED_ATTR(b_default_frame_index, bDefaultFrameIndex, 8);
+UVCG_FRAMEBASED_ATTR_RO(b_aspect_ratio_x, bAspectRatioX, 8);
+UVCG_FRAMEBASED_ATTR_RO(b_aspect_ratio_y, bAspectRatioY, 8);
+UVCG_FRAMEBASED_ATTR_RO(bm_interface_flags, bmInterfaceFlags, 8);
+
+#undef UVCG_FRAMEBASED_ATTR
+#undef UVCG_FRAMEBASED_ATTR_RO
+
+static ssize_t uvcg_framebased_guid_format_show(struct config_item *item,
+		char *page)
+{
+	struct uvcg_framebased *u = to_uvcg_framebased(item);
+	struct f_uvc_opts *opts;
+	struct config_item *opts_item;
+	struct mutex *su_mutex = &u->fmt.group.cg_subsys->su_mutex;
+
+	mutex_lock(su_mutex); /* for navigating configfs hierarchy */
+
+	opts_item = u->fmt.group.cg_item.ci_parent->ci_parent->ci_parent;
+	opts = to_f_uvc_opts(opts_item);
+
+	mutex_lock(&opts->lock);
+	memcpy(page, u->desc.guidFormat, sizeof(u->desc.guidFormat));
+	mutex_unlock(&opts->lock);
+
+	mutex_unlock(su_mutex);
+
+	return sizeof(u->desc.guidFormat);
+}
+
+static ssize_t uvcg_framebased_guid_format_store(struct config_item *item,
+		const char *page, size_t len)
+{
+	struct uvcg_framebased *u = to_uvcg_framebased(item);
+	struct f_uvc_opts *opts;
+	struct config_item *opts_item;
+	struct mutex *su_mutex = &u->fmt.group.cg_subsys->su_mutex;
+	int ret;
+
+	mutex_lock(su_mutex); /* for navigating configfs hierarchy */
+
+	opts_item = u->fmt.group.cg_item.ci_parent->ci_parent->ci_parent;
+	opts = to_f_uvc_opts(opts_item);
+
+	mutex_lock(&opts->lock);
+	if (u->fmt.linked || opts->refcnt) {
+		ret = -EBUSY;
+		goto end;
+	}
+
+	memcpy(u->desc.guidFormat, page,
+			min(sizeof(u->desc.guidFormat), len));
+	ret = sizeof(u->desc.guidFormat);
+
+end:
+	mutex_unlock(&opts->lock);
+	mutex_unlock(su_mutex);
+	return ret;
+}
+
+UVC_ATTR(uvcg_framebased_, guid_format, guidFormat);
+
+static inline ssize_t
+uvcg_framebased_bma_controls_show(struct config_item *item, char *page)
+{
+	struct uvcg_framebased *u = to_uvcg_framebased(item);
+
+	return uvcg_format_bma_controls_show(&u->fmt, page);
+}
+
+static inline ssize_t
+uvcg_framebased_bma_controls_store(struct config_item *item,
+				     const char *page, size_t len)
+{
+	struct uvcg_framebased *u = to_uvcg_framebased(item);
+
+	return uvcg_format_bma_controls_store(&u->fmt, page, len);
+}
+
+UVC_ATTR(uvcg_framebased_, bma_controls, bmaControls);
+
+static struct configfs_attribute *uvcg_framebased_attrs[] = {
+	&uvcg_framebased_attr_b_format_index,
+	&uvcg_framebased_attr_b_default_frame_index,
+	&uvcg_framebased_attr_b_bits_per_pixel,
+	&uvcg_framebased_attr_b_aspect_ratio_x,
+	&uvcg_framebased_attr_b_aspect_ratio_y,
+	&uvcg_framebased_attr_bm_interface_flags,
+	&uvcg_framebased_attr_bma_controls,
+	&uvcg_framebased_attr_guid_format,
+	NULL,
+};
+
+static struct config_item_type uvcg_framebased_type = {
+	.ct_item_ops	= &uvcg_config_item_ops,
+	.ct_group_ops	= &uvcg_framebased_group_ops,
+	.ct_attrs	= uvcg_framebased_attrs,
+	.ct_owner	= THIS_MODULE,
+};
+
+static struct config_group *uvcg_framebased_make(struct config_group *group,
+						   const char *name)
+{
+	struct uvcg_framebased *h;
+	static char guid[] = { /*Declare frame based as H264*/
+		'H',  '2',  '6',  '4', 0x00, 0x00, 0x10, 0x00,
+		0x80, 0x00, 0x00, 0xaa, 0x00, 0x38, 0x9b, 0x71
+	};
+
+	h = kzalloc(sizeof(*h), GFP_KERNEL);
+	if (!h)
+		return ERR_PTR(-ENOMEM);
+
+	h->desc.bLength			= UVC_DT_FORMAT_FRAMEBASED_SIZE;
+	h->desc.bDescriptorType		= USB_DT_CS_INTERFACE;
+	h->desc.bDescriptorSubType	= UVC_VS_FORMAT_FRAME_BASED;
+	memcpy(h->desc.guidFormat, guid, sizeof(guid));
+	h->desc.bBitsPerPixel		= 16;
+	h->desc.bDefaultFrameIndex	= 1;
+	h->desc.bAspectRatioX		= 0;
+	h->desc.bAspectRatioY		= 0;
+	h->desc.bmInterfaceFlags	= 0;
+	h->desc.bCopyProtect		= 0;
+	h->desc.bVariableSize		= 1;
+
+	h->fmt.type = UVCG_FRAMEBASED;
+	config_group_init_type_name(&h->fmt.group, name,
+				    &uvcg_framebased_type);
+
+	return &h->fmt.group;
+}
+
+static struct configfs_group_operations uvcg_framebased_grp_ops = {
+	.make_group		= uvcg_framebased_make,
+};
+
+static const struct uvcg_config_group_type uvcg_framebased_grp_type = {
+	.type = {
+		.ct_item_ops	= &uvcg_config_item_ops,
+		.ct_group_ops	= &uvcg_framebased_grp_ops,
+		.ct_owner	= THIS_MODULE,
+	},
+	.name = "h264",
+};
+
+
 /* -----------------------------------------------------------------------------
  * streaming/color_matching/default
  */
@@ -2001,6 +2369,7 @@ static int __uvcg_iter_strm_cls(struct uvcg_streaming_header *h,
 		if (ret)
 			return ret;
 		grp = &f->fmt->group;
+		j = 0;
 		list_for_each_entry(item, &grp->cg_children, ci_entry) {
 			frm = to_uvcg_frame(item);
 			ret = fun(frm, priv2, priv3, j++, UVCG_FRAME);
@@ -2049,6 +2418,11 @@ static int __uvcg_cnt_strm(void *priv1, void *priv2, void *priv3, int n,
 				container_of(fmt, struct uvcg_mjpeg, fmt);
 
 			*size += sizeof(m->desc);
+		} else if (fmt->type == UVCG_FRAMEBASED) {
+			struct uvcg_framebased *h =
+				container_of(fmt, struct uvcg_framebased, fmt);
+
+			*size += sizeof(h->desc);
 		} else {
 			return -EINVAL;
 		}
@@ -2056,10 +2430,23 @@ static int __uvcg_cnt_strm(void *priv1, void *priv2, void *priv3, int n,
 	break;
 	case UVCG_FRAME: {
 		struct uvcg_frame *frm = priv1;
-		int sz = sizeof(frm->dw_frame_interval);
 
-		*size += sizeof(frm->frame);
-		*size += frm->frame.b_frame_interval_type * sz;
+		if (frm->fmt_type == UVCG_UNCOMPRESSED) {
+			struct uvc_frame_uncompressed uf =
+				frm->frame.uf;
+			*size +=
+			UVC_DT_FRAME_UNCOMPRESSED_SIZE(uf.bFrameIntervalType);
+		} else if (frm->fmt_type == UVCG_MJPEG) {
+			struct uvc_frame_mjpeg mf =
+				frm->frame.mf;
+			*size +=
+			UVC_DT_FRAME_MJPEG_SIZE(mf.bFrameIntervalType);
+		} else if (frm->fmt_type == UVCG_FRAMEBASED) {
+			struct uvc_frame_framebased hf =
+				frm->frame.hf;
+			*size +=
+			UVC_DT_FRAME_FRAMEBASED_SIZE(hf.bFrameIntervalType);
+		}
 	}
 	break;
 	}
@@ -2123,6 +2510,14 @@ static int __uvcg_fill_strm(void *priv1, void *priv2, void *priv3, int n,
 			m->desc.bNumFrameDescriptors = fmt->num_frames;
 			memcpy(*dest, &m->desc, sizeof(m->desc));
 			*dest += sizeof(m->desc);
+		} else if (fmt->type == UVCG_FRAMEBASED) {
+			struct uvcg_framebased *h =
+				container_of(fmt, struct uvcg_framebased, fmt);
+
+			h->desc.bFormatIndex = n + 1;
+			h->desc.bNumFrameDescriptors = fmt->num_frames;
+			memcpy(*dest, &h->desc, sizeof(h->desc));
+			*dest += sizeof(h->desc);
 		} else {
 			return -EINVAL;
 		}
@@ -2130,21 +2525,46 @@ static int __uvcg_fill_strm(void *priv1, void *priv2, void *priv3, int n,
 	break;
 	case UVCG_FRAME: {
 		struct uvcg_frame *frm = priv1;
-		struct uvc_descriptor_header *h = *dest;
 
-		sz = sizeof(frm->frame);
-		memcpy(*dest, &frm->frame, sz);
-		*dest += sz;
-		sz = frm->frame.b_frame_interval_type *
-			sizeof(*frm->dw_frame_interval);
+		if (frm->fmt_type == UVCG_UNCOMPRESSED) {
+			struct uvc_frame_uncompressed *uf =
+				&frm->frame.uf;
+			uf->bLength = UVC_DT_FRAME_UNCOMPRESSED_SIZE(
+				uf->bFrameIntervalType);
+			uf->bFrameIndex = n+1;
+			sz = UVC_DT_FRAME_UNCOMPRESSED_SIZE(0);
+			memcpy(*dest, uf, sz);
+			*dest += sz;
+			sz = uf->bFrameIntervalType *
+				sizeof(*frm->dw_frame_interval);
+		} else if (frm->fmt_type == UVCG_MJPEG) {
+			struct uvc_frame_mjpeg *mf =
+				&frm->frame.mf;
+			mf->bLength = UVC_DT_FRAME_MJPEG_SIZE(
+				mf->bFrameIntervalType);
+			mf->bFrameIndex = n+1;
+			sz = UVC_DT_FRAME_MJPEG_SIZE(0);
+			memcpy(*dest, mf, sz);
+			*dest += sz;
+			sz = mf->bFrameIntervalType *
+				sizeof(*frm->dw_frame_interval);
+		} else if (frm->fmt_type == UVCG_FRAMEBASED) {
+			struct uvc_frame_framebased *hf =
+				&frm->frame.hf;
+			hf->bLength = UVC_DT_FRAME_FRAMEBASED_SIZE(
+				hf->bFrameIntervalType);
+			hf->bFrameIndex = n+1;
+			sz = UVC_DT_FRAME_FRAMEBASED_SIZE(0);
+			memcpy(*dest, hf, sz);
+			*dest += sz;
+			sz = hf->bFrameIntervalType *
+				sizeof(*frm->dw_frame_interval);
+		} else {
+			return -EINVAL;
+		}
+
 		memcpy(*dest, frm->dw_frame_interval, sz);
 		*dest += sz;
-		if (frm->fmt_type == UVCG_UNCOMPRESSED)
-			h->bLength = UVC_DT_FRAME_UNCOMPRESSED_SIZE(
-				frm->frame.b_frame_interval_type);
-		else if (frm->fmt_type == UVCG_MJPEG)
-			h->bLength = UVC_DT_FRAME_MJPEG_SIZE(
-				frm->frame.b_frame_interval_type);
 	}
 	break;
 	}
@@ -2357,6 +2777,7 @@ static const struct uvcg_config_group_type uvcg_streaming_grp_type = {
 		&uvcg_streaming_header_grp_type,
 		&uvcg_uncompressed_grp_type,
 		&uvcg_mjpeg_grp_type,
+		&uvcg_framebased_grp_type,
 		&uvcg_color_matching_grp_type,
 		&uvcg_streaming_class_grp_type,
 		NULL,
diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
index 4ca89eab6159..1056c8048720 100644
--- a/drivers/usb/gadget/function/uvc_v4l2.c
+++ b/drivers/usb/gadget/function/uvc_v4l2.c
@@ -58,6 +58,7 @@ struct uvc_format {
 static struct uvc_format uvc_formats[] = {
 	{ 16, V4L2_PIX_FMT_YUYV  },
 	{ 0,  V4L2_PIX_FMT_MJPEG },
+	{ 0,  V4L2_PIX_FMT_H264 },
 };
 
 static int
diff --git a/include/uapi/linux/usb/video.h b/include/uapi/linux/usb/video.h
index d854cb19c42c..dd17a3a17018 100644
--- a/include/uapi/linux/usb/video.h
+++ b/include/uapi/linux/usb/video.h
@@ -300,7 +300,7 @@ struct uvc_processing_unit_descriptor {
 	__u8   bSourceID;
 	__le16 wMaxMultiplier;
 	__u8   bControlSize;
-	__u8   bmControls[2];
+	__u8   bmControls[3];
 	__u8   iProcessing;
 } __attribute__((__packed__));
 
@@ -566,5 +566,63 @@ struct UVC_FRAME_MJPEG(n) {				\
 	__le32 dwFrameInterval[n];			\
 } __attribute__ ((packed))
 
+/* FRAMEBASED Payload - 3.1.1. FRAMEBASED Video Format Descriptor */
+struct uvc_format_framebased {
+	__u8  bLength;
+	__u8  bDescriptorType;
+	__u8  bDescriptorSubType;
+	__u8  bFormatIndex;
+	__u8  bNumFrameDescriptors;
+	__u8  guidFormat[16];
+	__u8  bBitsPerPixel;
+	__u8  bDefaultFrameIndex;
+	__u8  bAspectRatioX;
+	__u8  bAspectRatioY;
+	__u8  bmInterfaceFlags;
+	__u8  bCopyProtect;
+	__u8  bVariableSize;
+} __attribute__((__packed__));
+
+#define UVC_DT_FORMAT_FRAMEBASED_SIZE			28
+
+/* H264 Payload - 3.1.2. H264 Video Frame Descriptor */
+struct uvc_frame_framebased {
+	__u8  bLength;
+	__u8  bDescriptorType;
+	__u8  bDescriptorSubType;
+	__u8  bFrameIndex;
+	__u8  bmCapabilities;
+	__u16 wWidth;
+	__u16 wHeight;
+	__u32 dwMinBitRate;
+	__u32 dwMaxBitRate;
+	__u32 dwDefaultFrameInterval;
+	__u8  bNumFrameIntervals;
+	__u32 dwBytesPerLine;
+	__u32 dwFrameInterval[];
+} __attribute__((__packed__));
+
+#define UVC_DT_FRAME_FRAMEBASED_SIZE(n)			(26+4*(n))
+
+#define UVC_FRAME_FRAMEBASED(n)	\
+	uvc_frame_framebased_##n
+
+#define DECLARE_UVC_FRAME_FRAMEBASED(n)			\
+struct UVC_FRAME_FRAMEBASED(n) {			\
+	__u8  bLength;					\
+	__u8  bDescriptorType;				\
+	__u8  bDescriptorSubType;			\
+	__u8  bFrameIndex;				\
+	__u8  bmCapabilities;				\
+	__u16 wWidth;					\
+	__u16 wHeight;					\
+	__u32 dwMinBitRate;				\
+	__u32 dwMaxBitRate;				\
+	__u32 dwDefaultFrameInterval;			\
+	__u8  bNumFrameIntervals;			\
+	__u32 dwBytesPerLine;				\
+	__u32 dwFrameInterval[n];			\
+} __attribute__ ((packed))
+
 #endif /* __LINUX_USB_VIDEO_H */
 
-- 
2.17.1

