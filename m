Return-Path: <linux-kernel+bounces-75065-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AED085E27C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8EC02878BB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEDD82D6D;
	Wed, 21 Feb 2024 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wYlIP/FE"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AD782894
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 16:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708531359; cv=none; b=lE3zEWGkDNP00K758gSQDzqpijDfbzQahgXQDZ/NFqHCN2omprO8at/iI9kjUZRleMcP5Ry57iCSXeHogfarI+cm42L3Cj/embeMplTMmmQ8/6ENCvP0Z2NA00K0x26T3GguWZseie5uqlcp/S13CYWl/mPH2+PulWYl0u79oUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708531359; c=relaxed/simple;
	bh=IfIe0+cKBxE7MYQIQQutmhi8Y9tPlYUBJizB1VdA06Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MzU9IIx7bD6LIWpZEp7ncAjmcTHl2uWNMIR3nOA7oqXCyoIbpZVFHMJ2b5usohndJWQLB0mTQRQBqWvR3YOI5JDn4AKTLoPDfqKOhMrBUybQrdoxIE1spevcnL3iNqkKIRfYMT+XW6fRnTpoy8CxtKOgN1wht2sOUv1cXmNI+cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wYlIP/FE; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--panikiel.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60853aafd93so46953387b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 08:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708531356; x=1709136156; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6GqDF1XxC6NbNqO7+hvGUSypuC0sArcRU5AE95pSF3o=;
        b=wYlIP/FE4lGJ7ZZiBuwUPPYVVMWZWB8S6Yzz0dvJ1AibNpJRlDBe47WDoP9IDEpg1F
         p+7FAwWBdVwP5XYdwd4rg9xmOWXEn/d9ngXgVxqPG2fxjq5Wxrty0jIzoRzFm9vwXhB3
         t8289pYjyYWB08Yg9G6wVSMHKJ5QIftVcjuuJsrUGrZj/RvdV0WRPrQjIb53TMhdR9Wa
         Icq48CdHMtOgfr/0aWH3eUV6JLh8HiBjdgdnHFF1ud5AS01I6LtmM0DQ66rO0ZR2h9Xx
         ilN1YMXtUUnlTwc+j45lIqnS4klQmicJ99F/LWS0+7BhZVPQm1bejA2Ff3k8tDT51pBv
         kmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708531356; x=1709136156;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6GqDF1XxC6NbNqO7+hvGUSypuC0sArcRU5AE95pSF3o=;
        b=cPOJA8+3YzfN386A7zAGOKwP328qxaTr/FcN8r3EyhA9sY1qUA8YGhi2Tztcbz/Olz
         7lGncHU0KrTc0DHl3gOWwMfhbntNv3NE68q+vSFiQVnK0ereFkFinKdZ1+ufjYsy8RL+
         ud/QcXIRdQiKvdsD/sV2amUWMpSrKZr/dOctmvA4m7psmyzUUc55h4neeibJauk9suMA
         1HY2cwyYtQ6t7n3vkZWKZ32XMmwsdYOE1Re/gZ2JAC6SN42mYlL+Un3cpNjLApswmJ5y
         ho69Ci5cE0XdHo6+y9+gTxtpBjghT/u0XcJV7Rt1dGKiqBDVVuN5vufYSt3dWYrPUM/g
         pdoA==
X-Forwarded-Encrypted: i=1; AJvYcCU8WhaX9+wj4P/ZMCaStq7lhaXZ7R9s22TOeTlz88aJaw2pJmIkn+5P5Uq2OTHZ37DMb5XtDmQmO7ywbVRBJCgC30TtojyxOPZU0REa
X-Gm-Message-State: AOJu0YyK7IC6xD+yIs0dk/ns3K/F+BsjO+Je+Ja6pZFks0hBNt1nWrHr
	X5ml5Lx/6ems/niAISaco8gKQFgEwBtTmtnMQniTuc2ioGnGNw4/mVt9WBdkqx7yUaTpxthqnm9
	6uSvElCAKuQ==
X-Google-Smtp-Source: AGHT+IE15fpbMFd2+klVkaOV0wZ176nPcRy4bfHoPVLk9ITtVK4GdhPyCoQxhROmCOF4HOMWEFKhNWIy0ZPmFA==
X-Received: from szatan.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2d83])
 (user=panikiel job=sendgmr) by 2002:a05:690c:f90:b0:607:fa38:382 with SMTP id
 df16-20020a05690c0f9000b00607fa380382mr3792840ywb.5.1708531356586; Wed, 21
 Feb 2024 08:02:36 -0800 (PST)
Date: Wed, 21 Feb 2024 16:02:09 +0000
In-Reply-To: <20240221160215.484151-1-panikiel@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240221160215.484151-1-panikiel@google.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221160215.484151-4-panikiel@google.com>
Subject: [PATCH v2 3/9] drm/dp_mst: Move DRM-independent structures to
 separate header
From: "=?UTF-8?q?Pawe=C5=82=20Anikiel?=" <panikiel@google.com>
To: airlied@gmail.com, akpm@linux-foundation.org, conor+dt@kernel.org, 
	daniel@ffwll.ch, dinguyen@kernel.org, hverkuil-cisco@xs4all.nl, 
	krzysztof.kozlowski+dt@linaro.org, maarten.lankhorst@linux.intel.com, 
	mchehab@kernel.org, mripard@kernel.org, robh+dt@kernel.org, 
	tzimmermann@suse.de
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	chromeos-krk-upstreaming@google.com, ribalda@chromium.org, 
	"=?UTF-8?q?Pawe=C5=82=20Anikiel?=" <panikiel@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Move structures describing MST sideband messages into a separate header
so that non-DRM code can use them.

Signed-off-by: Pawe=C5=82 Anikiel <panikiel@google.com>
---
 include/drm/display/drm_dp_mst.h        | 238 ++++++++++++++++++++++++
 include/drm/display/drm_dp_mst_helper.h | 232 +----------------------
 2 files changed, 239 insertions(+), 231 deletions(-)
 create mode 100644 include/drm/display/drm_dp_mst.h

diff --git a/include/drm/display/drm_dp_mst.h b/include/drm/display/drm_dp_=
mst.h
new file mode 100644
index 000000000000..4e398bfd3ee3
--- /dev/null
+++ b/include/drm/display/drm_dp_mst.h
@@ -0,0 +1,238 @@
+/* SPDX-License-Identifier: MIT */
+
+#ifndef _DRM_DP_MST_H_
+#define _DRM_DP_MST_H_
+
+#include <linux/types.h>
+
+struct drm_dp_nak_reply {
+	u8 guid[16];
+	u8 reason;
+	u8 nak_data;
+};
+
+struct drm_dp_link_address_ack_reply {
+	u8 guid[16];
+	u8 nports;
+	struct drm_dp_link_addr_reply_port {
+		bool input_port;
+		u8 peer_device_type;
+		u8 port_number;
+		bool mcs;
+		bool ddps;
+		bool legacy_device_plug_status;
+		u8 dpcd_revision;
+		u8 peer_guid[16];
+		u8 num_sdp_streams;
+		u8 num_sdp_stream_sinks;
+	} ports[16];
+};
+
+struct drm_dp_remote_dpcd_read_ack_reply {
+	u8 port_number;
+	u8 num_bytes;
+	u8 bytes[255];
+};
+
+struct drm_dp_remote_dpcd_write_ack_reply {
+	u8 port_number;
+};
+
+struct drm_dp_remote_dpcd_write_nak_reply {
+	u8 port_number;
+	u8 reason;
+	u8 bytes_written_before_failure;
+};
+
+struct drm_dp_remote_i2c_read_ack_reply {
+	u8 port_number;
+	u8 num_bytes;
+	u8 bytes[255];
+};
+
+struct drm_dp_remote_i2c_read_nak_reply {
+	u8 port_number;
+	u8 nak_reason;
+	u8 i2c_nak_transaction;
+};
+
+struct drm_dp_remote_i2c_write_ack_reply {
+	u8 port_number;
+};
+
+struct drm_dp_query_stream_enc_status_ack_reply {
+	/* Bit[23:16]- Stream Id */
+	u8 stream_id;
+
+	/* Bit[15]- Signed */
+	bool reply_signed;
+
+	/* Bit[10:8]- Stream Output Sink Type */
+	bool unauthorizable_device_present;
+	bool legacy_device_present;
+	bool query_capable_device_present;
+
+	/* Bit[12:11]- Stream Output CP Type */
+	bool hdcp_1x_device_present;
+	bool hdcp_2x_device_present;
+
+	/* Bit[4]- Stream Authentication */
+	bool auth_completed;
+
+	/* Bit[3]- Stream Encryption */
+	bool encryption_enabled;
+
+	/* Bit[2]- Stream Repeater Function Present */
+	bool repeater_present;
+
+	/* Bit[1:0]- Stream State */
+	u8 state;
+};
+
+#define DRM_DP_MAX_SDP_STREAMS 16
+struct drm_dp_allocate_payload {
+	u8 port_number;
+	u8 number_sdp_streams;
+	u8 vcpi;
+	u16 pbn;
+	u8 sdp_stream_sink[DRM_DP_MAX_SDP_STREAMS];
+};
+
+struct drm_dp_allocate_payload_ack_reply {
+	u8 port_number;
+	u8 vcpi;
+	u16 allocated_pbn;
+};
+
+struct drm_dp_connection_status_notify {
+	u8 guid[16];
+	u8 port_number;
+	bool legacy_device_plug_status;
+	bool displayport_device_plug_status;
+	bool message_capability_status;
+	bool input_port;
+	u8 peer_device_type;
+};
+
+struct drm_dp_remote_dpcd_read {
+	u8 port_number;
+	u32 dpcd_address;
+	u8 num_bytes;
+};
+
+struct drm_dp_remote_dpcd_write {
+	u8 port_number;
+	u32 dpcd_address;
+	u8 num_bytes;
+	u8 *bytes;
+};
+
+#define DP_REMOTE_I2C_READ_MAX_TRANSACTIONS 4
+struct drm_dp_remote_i2c_read {
+	u8 num_transactions;
+	u8 port_number;
+	struct drm_dp_remote_i2c_read_tx {
+		u8 i2c_dev_id;
+		u8 num_bytes;
+		u8 *bytes;
+		u8 no_stop_bit;
+		u8 i2c_transaction_delay;
+	} transactions[DP_REMOTE_I2C_READ_MAX_TRANSACTIONS];
+	u8 read_i2c_device_id;
+	u8 num_bytes_read;
+};
+
+struct drm_dp_remote_i2c_write {
+	u8 port_number;
+	u8 write_i2c_device_id;
+	u8 num_bytes;
+	u8 *bytes;
+};
+
+struct drm_dp_query_stream_enc_status {
+	u8 stream_id;
+	u8 client_id[7];	/* 56-bit nonce */
+	u8 stream_event;
+	bool valid_stream_event;
+	u8 stream_behavior;
+	u8 valid_stream_behavior;
+};
+
+/* this covers ENUM_RESOURCES, POWER_DOWN_PHY, POWER_UP_PHY */
+struct drm_dp_port_number_req {
+	u8 port_number;
+};
+
+struct drm_dp_enum_path_resources_ack_reply {
+	u8 port_number;
+	bool fec_capable;
+	u16 full_payload_bw_number;
+	u16 avail_payload_bw_number;
+};
+
+/* covers POWER_DOWN_PHY, POWER_UP_PHY */
+struct drm_dp_port_number_rep {
+	u8 port_number;
+};
+
+struct drm_dp_query_payload {
+	u8 port_number;
+	u8 vcpi;
+};
+
+struct drm_dp_resource_status_notify {
+	u8 port_number;
+	u8 guid[16];
+	u16 available_pbn;
+};
+
+struct drm_dp_query_payload_ack_reply {
+	u8 port_number;
+	u16 allocated_pbn;
+};
+
+struct drm_dp_sideband_msg_req_body {
+	u8 req_type;
+	union ack_req {
+		struct drm_dp_connection_status_notify conn_stat;
+		struct drm_dp_port_number_req port_num;
+		struct drm_dp_resource_status_notify resource_stat;
+
+		struct drm_dp_query_payload query_payload;
+		struct drm_dp_allocate_payload allocate_payload;
+
+		struct drm_dp_remote_dpcd_read dpcd_read;
+		struct drm_dp_remote_dpcd_write dpcd_write;
+
+		struct drm_dp_remote_i2c_read i2c_read;
+		struct drm_dp_remote_i2c_write i2c_write;
+
+		struct drm_dp_query_stream_enc_status enc_status;
+	} u;
+};
+
+struct drm_dp_sideband_msg_reply_body {
+	u8 reply_type;
+	u8 req_type;
+	union ack_replies {
+		struct drm_dp_nak_reply nak;
+		struct drm_dp_link_address_ack_reply link_addr;
+		struct drm_dp_port_number_rep port_number;
+
+		struct drm_dp_enum_path_resources_ack_reply path_resources;
+		struct drm_dp_allocate_payload_ack_reply allocate_payload;
+		struct drm_dp_query_payload_ack_reply query_payload;
+
+		struct drm_dp_remote_dpcd_read_ack_reply remote_dpcd_read_ack;
+		struct drm_dp_remote_dpcd_write_ack_reply remote_dpcd_write_ack;
+		struct drm_dp_remote_dpcd_write_nak_reply remote_dpcd_write_nack;
+
+		struct drm_dp_remote_i2c_read_ack_reply remote_i2c_read_ack;
+		struct drm_dp_remote_i2c_read_nak_reply remote_i2c_read_nack;
+		struct drm_dp_remote_i2c_write_ack_reply remote_i2c_write_ack;
+
+		struct drm_dp_query_stream_enc_status_ack_reply enc_status;
+	} u;
+};
+
+#endif
diff --git a/include/drm/display/drm_dp_mst_helper.h b/include/drm/display/=
drm_dp_mst_helper.h
index 9b19d8bd520a..61add6f6accd 100644
--- a/include/drm/display/drm_dp_mst_helper.h
+++ b/include/drm/display/drm_dp_mst_helper.h
@@ -23,6 +23,7 @@
 #define _DRM_DP_MST_HELPER_H_
=20
 #include <linux/types.h>
+#include <drm/display/drm_dp_mst.h>
 #include <drm/display/drm_dp_helper.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_fixed.h>
@@ -248,237 +249,6 @@ struct drm_dp_mst_branch {
 	u8 guid[16];
 };
=20
-
-struct drm_dp_nak_reply {
-	u8 guid[16];
-	u8 reason;
-	u8 nak_data;
-};
-
-struct drm_dp_link_address_ack_reply {
-	u8 guid[16];
-	u8 nports;
-	struct drm_dp_link_addr_reply_port {
-		bool input_port;
-		u8 peer_device_type;
-		u8 port_number;
-		bool mcs;
-		bool ddps;
-		bool legacy_device_plug_status;
-		u8 dpcd_revision;
-		u8 peer_guid[16];
-		u8 num_sdp_streams;
-		u8 num_sdp_stream_sinks;
-	} ports[16];
-};
-
-struct drm_dp_remote_dpcd_read_ack_reply {
-	u8 port_number;
-	u8 num_bytes;
-	u8 bytes[255];
-};
-
-struct drm_dp_remote_dpcd_write_ack_reply {
-	u8 port_number;
-};
-
-struct drm_dp_remote_dpcd_write_nak_reply {
-	u8 port_number;
-	u8 reason;
-	u8 bytes_written_before_failure;
-};
-
-struct drm_dp_remote_i2c_read_ack_reply {
-	u8 port_number;
-	u8 num_bytes;
-	u8 bytes[255];
-};
-
-struct drm_dp_remote_i2c_read_nak_reply {
-	u8 port_number;
-	u8 nak_reason;
-	u8 i2c_nak_transaction;
-};
-
-struct drm_dp_remote_i2c_write_ack_reply {
-	u8 port_number;
-};
-
-struct drm_dp_query_stream_enc_status_ack_reply {
-	/* Bit[23:16]- Stream Id */
-	u8 stream_id;
-
-	/* Bit[15]- Signed */
-	bool reply_signed;
-
-	/* Bit[10:8]- Stream Output Sink Type */
-	bool unauthorizable_device_present;
-	bool legacy_device_present;
-	bool query_capable_device_present;
-
-	/* Bit[12:11]- Stream Output CP Type */
-	bool hdcp_1x_device_present;
-	bool hdcp_2x_device_present;
-
-	/* Bit[4]- Stream Authentication */
-	bool auth_completed;
-
-	/* Bit[3]- Stream Encryption */
-	bool encryption_enabled;
-
-	/* Bit[2]- Stream Repeater Function Present */
-	bool repeater_present;
-
-	/* Bit[1:0]- Stream State */
-	u8 state;
-};
-
-#define DRM_DP_MAX_SDP_STREAMS 16
-struct drm_dp_allocate_payload {
-	u8 port_number;
-	u8 number_sdp_streams;
-	u8 vcpi;
-	u16 pbn;
-	u8 sdp_stream_sink[DRM_DP_MAX_SDP_STREAMS];
-};
-
-struct drm_dp_allocate_payload_ack_reply {
-	u8 port_number;
-	u8 vcpi;
-	u16 allocated_pbn;
-};
-
-struct drm_dp_connection_status_notify {
-	u8 guid[16];
-	u8 port_number;
-	bool legacy_device_plug_status;
-	bool displayport_device_plug_status;
-	bool message_capability_status;
-	bool input_port;
-	u8 peer_device_type;
-};
-
-struct drm_dp_remote_dpcd_read {
-	u8 port_number;
-	u32 dpcd_address;
-	u8 num_bytes;
-};
-
-struct drm_dp_remote_dpcd_write {
-	u8 port_number;
-	u32 dpcd_address;
-	u8 num_bytes;
-	u8 *bytes;
-};
-
-#define DP_REMOTE_I2C_READ_MAX_TRANSACTIONS 4
-struct drm_dp_remote_i2c_read {
-	u8 num_transactions;
-	u8 port_number;
-	struct drm_dp_remote_i2c_read_tx {
-		u8 i2c_dev_id;
-		u8 num_bytes;
-		u8 *bytes;
-		u8 no_stop_bit;
-		u8 i2c_transaction_delay;
-	} transactions[DP_REMOTE_I2C_READ_MAX_TRANSACTIONS];
-	u8 read_i2c_device_id;
-	u8 num_bytes_read;
-};
-
-struct drm_dp_remote_i2c_write {
-	u8 port_number;
-	u8 write_i2c_device_id;
-	u8 num_bytes;
-	u8 *bytes;
-};
-
-struct drm_dp_query_stream_enc_status {
-	u8 stream_id;
-	u8 client_id[7];	/* 56-bit nonce */
-	u8 stream_event;
-	bool valid_stream_event;
-	u8 stream_behavior;
-	u8 valid_stream_behavior;
-};
-
-/* this covers ENUM_RESOURCES, POWER_DOWN_PHY, POWER_UP_PHY */
-struct drm_dp_port_number_req {
-	u8 port_number;
-};
-
-struct drm_dp_enum_path_resources_ack_reply {
-	u8 port_number;
-	bool fec_capable;
-	u16 full_payload_bw_number;
-	u16 avail_payload_bw_number;
-};
-
-/* covers POWER_DOWN_PHY, POWER_UP_PHY */
-struct drm_dp_port_number_rep {
-	u8 port_number;
-};
-
-struct drm_dp_query_payload {
-	u8 port_number;
-	u8 vcpi;
-};
-
-struct drm_dp_resource_status_notify {
-	u8 port_number;
-	u8 guid[16];
-	u16 available_pbn;
-};
-
-struct drm_dp_query_payload_ack_reply {
-	u8 port_number;
-	u16 allocated_pbn;
-};
-
-struct drm_dp_sideband_msg_req_body {
-	u8 req_type;
-	union ack_req {
-		struct drm_dp_connection_status_notify conn_stat;
-		struct drm_dp_port_number_req port_num;
-		struct drm_dp_resource_status_notify resource_stat;
-
-		struct drm_dp_query_payload query_payload;
-		struct drm_dp_allocate_payload allocate_payload;
-
-		struct drm_dp_remote_dpcd_read dpcd_read;
-		struct drm_dp_remote_dpcd_write dpcd_write;
-
-		struct drm_dp_remote_i2c_read i2c_read;
-		struct drm_dp_remote_i2c_write i2c_write;
-
-		struct drm_dp_query_stream_enc_status enc_status;
-	} u;
-};
-
-struct drm_dp_sideband_msg_reply_body {
-	u8 reply_type;
-	u8 req_type;
-	union ack_replies {
-		struct drm_dp_nak_reply nak;
-		struct drm_dp_link_address_ack_reply link_addr;
-		struct drm_dp_port_number_rep port_number;
-
-		struct drm_dp_enum_path_resources_ack_reply path_resources;
-		struct drm_dp_allocate_payload_ack_reply allocate_payload;
-		struct drm_dp_query_payload_ack_reply query_payload;
-
-		struct drm_dp_remote_dpcd_read_ack_reply remote_dpcd_read_ack;
-		struct drm_dp_remote_dpcd_write_ack_reply remote_dpcd_write_ack;
-		struct drm_dp_remote_dpcd_write_nak_reply remote_dpcd_write_nack;
-
-		struct drm_dp_remote_i2c_read_ack_reply remote_i2c_read_ack;
-		struct drm_dp_remote_i2c_read_nak_reply remote_i2c_read_nack;
-		struct drm_dp_remote_i2c_write_ack_reply remote_i2c_write_ack;
-
-		struct drm_dp_query_stream_enc_status_ack_reply enc_status;
-	} u;
-};
-
 /* msg is queued to be put into a slot */
 #define DRM_DP_SIDEBAND_TX_QUEUED 0
 /* msg has started transmitting on a slot - still on msgq */
--=20
2.44.0.rc0.258.g7320e95886-goog


