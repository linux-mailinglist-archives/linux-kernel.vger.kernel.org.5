Return-Path: <linux-kernel+bounces-87419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F3686D42E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 070FE1F230D6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED801428F8;
	Thu, 29 Feb 2024 20:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P9k+x1g7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA8C13F44D
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 20:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709238520; cv=none; b=r8nglsoJUWlVH0RlIa085Ot80Zg1F7PAaXi+HFcaKQChTmacOExiKT9wQ0/OXilFmXhOCaZCgs3bke+A7+HBah2+m7cS9ryySxP7thL3ORG2dPJnpOojEXomx4nhsfes7AH+OZA0oYeDeQG7ffkArlbZVVdfFOMccQXs2wOiiMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709238520; c=relaxed/simple;
	bh=NVxrcJoo12TU3qZCW+W6Vd8nOd2A/gUPkg/bJzxkS/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QC1O4YOwrCHDZ4USUy7Zfe36OOIyOyEQC8yPoVONxnvoutvC9dzsNSMwLn2VATLgLd/+0UZY2mF3meGPid+307fHB7oIPzdEycVRw0hIJUuRcrfntPwlO8Fx7IMnT8xQ4BHuqP2AZhMgcgzNf+g55XHX4TOVn2QCsxXMPNXnPdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P9k+x1g7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709238518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SmIHX6Y7vZxIL5GaMIQETwxnKgF7XXugu9W+eqW/pI8=;
	b=P9k+x1g7FLcb86nhUU0l4dlXS146KIiU/YXbvSgppcy1OGKqGqE2ACOlBepGtZbgEgmIUS
	X99h4M96YoQs81ZDlfh+6GAlxKOOUdo8S3XC8Qy1PKfrUTS5nhb05cphMXl6otw4meEXHL
	d1dB4pmYCihz+kAg/2dG5bwBFCEWiQ0=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-VEXKNPvAMhSU0gMSG5yUHg-1; Thu, 29 Feb 2024 15:28:36 -0500
X-MC-Unique: VEXKNPvAMhSU0gMSG5yUHg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33e0d943844so466380f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 12:28:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709238515; x=1709843315;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SmIHX6Y7vZxIL5GaMIQETwxnKgF7XXugu9W+eqW/pI8=;
        b=Sb+blhIEFmmw64xEZHp9meTgUnBVlne1ipldQymulFs5Zf6slq+/GLs5kGYFSvZ7SR
         IqbswFEwPFnrA2SbcFm6Si2vCNB9TBc+GcDiD1gcrHFpvwvqSAbLkrVdIQPVH7osUaNh
         dJgUng6/ST7X7dKHjpj1E8YvMNLZn5G/MdpNwmL9G9V6gIC8YLHwo3/51jW51Bmk/PdM
         UxfoLmAlJ7cJ1Ctiq401jy1YbR8+T5rD7iDPK8BB/saGF7EEASICNKByZyeppBIwFhcM
         p9gD5OHo6NxRToFBLV5Z6SijnMlLAiyqo0bko6cB28v6x2Ru0cR81Wq8qRI1siFEqc9S
         OI5g==
X-Forwarded-Encrypted: i=1; AJvYcCUiAo2HGjIOKIo9If1G6nksdRYL2OkUWcMwIAaRl1S5vnbQ+hIYXy/ciwzt/xVvooNbPar1I/5Yz09AYBLQJ5QqrjfR6HhVU/XGPtlM
X-Gm-Message-State: AOJu0YyaVGJQHEX7NsXM5iwKkSoRQOaX2tuFMI1mbHZtdDKcsTWvHhIp
	JJQCEw2BkcBV5O/TvQTfzOhVh1heBzVEXNyPGwvh4DV8Ax+EFIcCr0CUn4ougbfUQVE49hF0swx
	9L0ndgc2jYMeAkz1eMDZTtrW3Ew+YJIAg7aSFtznw+Irfv34pd1bQ6KiVi6IuyA==
X-Received: by 2002:a5d:49cb:0:b0:33e:1818:7956 with SMTP id t11-20020a5d49cb000000b0033e18187956mr86352wrs.5.1709238515381;
        Thu, 29 Feb 2024 12:28:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5Jx2+Irv/obGwjeP9whbDMr+s9YId14EB3u4zXUdHLaSwpMrti0IWA9JKGqUMoV8obWO77Q==
X-Received: by 2002:a5d:49cb:0:b0:33e:1818:7956 with SMTP id t11-20020a5d49cb000000b0033e18187956mr86343wrs.5.1709238515052;
        Thu, 29 Feb 2024 12:28:35 -0800 (PST)
Received: from toolbox.fritz.box ([2001:9e8:8984:bd00:2340:7b35:5e60:4abd])
        by smtp.gmail.com with ESMTPSA id h5-20020adf9cc5000000b0033dd9b050f9sm2604385wre.14.2024.02.29.12.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 12:28:34 -0800 (PST)
From: Sebastian Wick <sebastian.wick@redhat.com>
To: 
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Jonathan Corbet <corbet@lwn.net>,
	dri-devel@lists.freedesktop.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm: Document requirements for driver-specific KMS props in new drivers
Date: Thu, 29 Feb 2024 21:28:31 +0100
Message-ID: <20240229202833.198691-1-sebastian.wick@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When extending support for a driver-specific KMS property to additional
drivers, we should apply all the requirements for new properties and
make sure the semantics are the same and documented.

Signed-off-by: Sebastian Wick <sebastian.wick@redhat.com>
---
 Documentation/gpu/drm-kms.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/gpu/drm-kms.rst b/Documentation/gpu/drm-kms.rst
index 13d3627d8bc0..afa10a28035f 100644
--- a/Documentation/gpu/drm-kms.rst
+++ b/Documentation/gpu/drm-kms.rst
@@ -496,6 +496,11 @@ addition to the one mentioned above:
 
 * An IGT test must be submitted where reasonable.
 
+For historical reasons, non-standard, driver-specific properties exist. If a KMS
+driver wants to add support for one of those properties, the requirements for
+new properties apply where possible. Additionally, the documented behavior must
+match the de facto semantics of the existing property to ensure compatibility.
+
 Property Types and Blob Property Support
 ----------------------------------------
 
-- 
2.43.0


