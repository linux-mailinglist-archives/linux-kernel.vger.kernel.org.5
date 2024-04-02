Return-Path: <linux-kernel+bounces-128723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F05B895EA7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1AE41F27488
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7AF15E7EC;
	Tue,  2 Apr 2024 21:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UeIFc6fw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35B115E5B4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 21:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712092909; cv=none; b=oQ1lhVhgBtqshFl+d9DJNlZeUQhGKZYSYgoOpOdangca81whxTQcguQBS6XDu6ANizGTBiUnnY6qCwjMaXiD18JCR0e/v8PfzXCuOwZSrVoawkb/OQ/DKwiEsj43OmeH8XBipgYYF5OTAC0HSd2+CPLaTinIQg+wbJ4OFpGuqbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712092909; c=relaxed/simple;
	bh=CeTf1GnLqEGbq7mpbpnjAmCKKQFZ0fqT+cHVafZlASk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jwTK4PU0EpR5GFZEizMQN9YgCS9HZLkkYaFFCBU96HKNyFfJiB1RBS648A2cE+yZGni+8QjE8vzof8wCAx4bOZVLjQRZ4ChmrZkl96heRsW0n5TCGfALFEV4WDDCBDsxBNzD8CX3jGfyCCaGYIoT2+GIv2m7HT8eVJpKqTh2DB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UeIFc6fw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712092907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=L+alDoiqMN7Nxu8CAo+qwAjzO+OBQsTVsBJwYvjZdYY=;
	b=UeIFc6fwYIzxEDooXktWKvLWRu3yElmxkF5UzcwOZz3OJri2OD06FpmgmNPOSQD0mET50N
	575QL8pcmr7/6QtzVq0QzEkqT0lqVTWqTlG4+0yGBx0WmIj0BZon54UpRDSUMKe1ICwR4k
	u+ejoAkmxpEIDoZ37K0zMCPiNIYtTg4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-SNP7sRo2M46N3pa6IHErUw-1; Tue, 02 Apr 2024 17:21:45 -0400
X-MC-Unique: SNP7sRo2M46N3pa6IHErUw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3437574111dso391756f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 14:21:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712092904; x=1712697704;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L+alDoiqMN7Nxu8CAo+qwAjzO+OBQsTVsBJwYvjZdYY=;
        b=BS/t5f1pTN8N7VQMWy4pc2VUEMVOuhUHON84G/qMq9uXGKnQUL9fvPSxt4kJWHYgIM
         JATz7Y36wy7GAh8CIkttwAN/OwDjIyOb3rFNMfyMNUjcFRPHXceAzTAfA1eX/84zN5Ph
         cx0yuPR/NCaiXOc7i1onj8f4FmrZPkDP+PvjKUIx/pBiwTQLfg1YAuuqE+B8zfUNcpmn
         cOZH6ppyx6XHoPyRcVauEsDQWK4KzVfJygqnXRX4zvhAjEgb/ii2L2ZCibuKjf2OItfc
         8GtfUfDTbsUhepNgPqVQtq2yL1Vbw9/996XFy1KEsHoa/x8+mmZtcjHN7ZBA1jjXxpPx
         MzPw==
X-Gm-Message-State: AOJu0Yy7vN6X9V7rpBWisP2C04/2Jdhynm4nCZPlA7mp+pRqvzCz3uxh
	a1P5Q+iIhMdMqu7xZNVRrmidZIVUk8v57bHcEoNw1OmR+GYt5qOYNqKcM7OMlR/eitgk2gLCOfw
	7cUAJw4oR6eqH/VgZoqQ2Cgm9fVbQqGQx75lh+Nn6CdcZNAYzZA3jP+c744iSXe7lb6ivjPeqaW
	q/ZIKIvrLjTUKlFvX6SeIP7GGX4Hh09WGeoSTswCjUeg==
X-Received: by 2002:a5d:598e:0:b0:343:4c43:b38a with SMTP id n14-20020a5d598e000000b003434c43b38amr6924841wri.17.1712092903894;
        Tue, 02 Apr 2024 14:21:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoLR2TiY4NlePQYEkpCrVsZpefzcsOU3LO3zWyGpNr1faKWUSZIEppdou1j4Es/gmuSNpz7Q==
X-Received: by 2002:a5d:598e:0:b0:343:4c43:b38a with SMTP id n14-20020a5d598e000000b003434c43b38amr6924812wri.17.1712092903398;
        Tue, 02 Apr 2024 14:21:43 -0700 (PDT)
Received: from redhat.com ([2.52.21.244])
        by smtp.gmail.com with ESMTPSA id f13-20020a1709062c4d00b00a4df82aa6a7sm6888784ejh.219.2024.04.02.14.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 14:21:42 -0700 (PDT)
Date: Tue, 2 Apr 2024 17:21:39 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Zhu Lingshan <lingshan.zhu@intel.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH] vhost-vdpa: change ioctl # for VDPA_GET_VRING_SIZE
Message-ID: <41c1c5489688abe5bfef9f7cf15584e3fb872ac5.1712092759.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent

VDPA_GET_VRING_SIZE by mistake uses the already occupied
ioctl # 0x80 and we never noticed - it happens to work
because the direction and size are different, but confuses
tools such as perf which like to look at just the number,
and breaks the extra robustness of the ioctl numbering macros.

To fix, sort the entries and renumber the ioctl - not too late
since it wasn't in any released kernels yet.

Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Reported-by: Namhyung Kim <namhyung@kernel.org>
Fixes: 1496c47065f9 ("vhost-vdpa: uapi to support reporting per vq size")
Cc: "Zhu Lingshan" <lingshan.zhu@intel.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Build tested only - userspace patches using this will have to adjust.
I will merge this in a week or so unless I hear otherwise,
and afterwards perf can update there header.

 include/uapi/linux/vhost.h | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/vhost.h b/include/uapi/linux/vhost.h
index bea697390613..b95dd84eef2d 100644
--- a/include/uapi/linux/vhost.h
+++ b/include/uapi/linux/vhost.h
@@ -179,12 +179,6 @@
 /* Get the config size */
 #define VHOST_VDPA_GET_CONFIG_SIZE	_IOR(VHOST_VIRTIO, 0x79, __u32)
 
-/* Get the count of all virtqueues */
-#define VHOST_VDPA_GET_VQS_COUNT	_IOR(VHOST_VIRTIO, 0x80, __u32)
-
-/* Get the number of virtqueue groups. */
-#define VHOST_VDPA_GET_GROUP_NUM	_IOR(VHOST_VIRTIO, 0x81, __u32)
-
 /* Get the number of address spaces. */
 #define VHOST_VDPA_GET_AS_NUM		_IOR(VHOST_VIRTIO, 0x7A, unsigned int)
 
@@ -228,10 +222,17 @@
 #define VHOST_VDPA_GET_VRING_DESC_GROUP	_IOWR(VHOST_VIRTIO, 0x7F,	\
 					      struct vhost_vring_state)
 
+
+/* Get the count of all virtqueues */
+#define VHOST_VDPA_GET_VQS_COUNT	_IOR(VHOST_VIRTIO, 0x80, __u32)
+
+/* Get the number of virtqueue groups. */
+#define VHOST_VDPA_GET_GROUP_NUM	_IOR(VHOST_VIRTIO, 0x81, __u32)
+
 /* Get the queue size of a specific virtqueue.
  * userspace set the vring index in vhost_vring_state.index
  * kernel set the queue size in vhost_vring_state.num
  */
-#define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x80,	\
+#define VHOST_VDPA_GET_VRING_SIZE	_IOWR(VHOST_VIRTIO, 0x82,	\
 					      struct vhost_vring_state)
 #endif
-- 
MST


