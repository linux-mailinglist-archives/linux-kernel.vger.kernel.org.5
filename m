Return-Path: <linux-kernel+bounces-63685-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5906853347
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 471141F23E9F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268011B299;
	Tue, 13 Feb 2024 14:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="aajLScVO"
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9C41E51E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707834987; cv=none; b=s0EHpgiLOIcFcuTS5PoGigY2NCulMzFwiriRdZKjVBxQgAPbesA7kBd0ySMUyrCIdaO81StVFIIEN2cjWlm4f8NtcoeTNteLL/vb+qfevwFoZqGGWKN51Iy9yxqdgi2OWH8K0Ig+dzgcGvdIQkfbhuEGyxPGeUqxMFNQpuIdkao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707834987; c=relaxed/simple;
	bh=x/FWpmXs+siXuzRbLc5xCsGrjSZxXzgMpFp8jCEzOjs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=peoQ8IrNYVBSQZsTEpmpd0oU4StrYa3yz8eKEe8lQbjtcwxs/D6C2+Wyn3TeZaTBJwnyHwmbjecQpiWo8Vr0X1rpsg+wi6un8JwTT40faT/M7+7H8D912BbNQpGskJ0/DoIBVTl62Sp696S6YrozzYl5liYt20KjT3Gw1SHCsQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=aajLScVO; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e0ac91e1e9so1831171b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:36:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707834984; x=1708439784;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YkAxiX5r+VqIkIVkIJIct9tXU0xaPqHrJhoy5Wg6JmQ=;
        b=LUtKHbwrtDaUTksGVgPRSiTwF+R0Sw2X6u9hZfFVMKCfYRAhDvJ2RKeCgg+HNcdpGD
         k7B6n44YO2krYQ3VixbrjYvdmEqZYO9DzO99jojmWMRuUfgcTkT6diBCpoxw5S1Gfswz
         0u26Tt6AYal4WU/b7oYjQPFyndaILcopN0LU2fIXLnOwb0sLA7ea4866LzN+jWMGdIUQ
         1/RBmsTR1dxWVesBSuZAi7PeLW6DaT77lXXF6b0M7p/36AI0jd0iy6C2rhiZkoWwNEj9
         DFTkAi/Ids9dHpLuNvnnm8v70hfR4O5n+j29FHQZFiB1CnTUR+Lh/zNk1IceLkbS0+WA
         JuMA==
X-Forwarded-Encrypted: i=1; AJvYcCUC3jxMTbKq6XQj7fxCLJO4zxebY7Lx3CA5LWSXLPAs41K0X14PXQmbLLBVUUzU//UK+4S964SCBlsKiXHWb/j7Ocie4IIp/Pvg/zD7
X-Gm-Message-State: AOJu0YzI4/+roinzGhe2rFFN0H0OsjJFSccb69sAyT1IJYgZwHc/NkDe
	w0qKylNBCjlhmbGVV3bzOHATwB8h4EYX0Lop6kHCj/+krtcUD1Uu
X-Google-Smtp-Source: AGHT+IFWNiOxtnLB/vhItTI5nJ+dnjka+iTBPwAaQ8p7fl/ouHrR/zhf2dsNYXwdM2v2Cf8fkWVKiQ==
X-Received: by 2002:a05:6a21:6315:b0:19c:8a1a:d9a8 with SMTP id wu21-20020a056a21631500b0019c8a1ad9a8mr7732353pzb.42.1707834984275;
        Tue, 13 Feb 2024 06:36:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVYoBI2HC6Ero9ydjm4RWT08l5qQp3ZaPPt2KWGygKLK3JnPpJ+7TgoqRdJEB+iSgJdTeW5gQFoJyh1QfeQUA8gcCXBucSx0y7ylWHj59empEYaCjeu2dayc9NM+lgOO9E5jQRpJABkG5k9nzeYu5IiGOASKwDuAFiC04z+huvEW2t2xo2EkPziNbFhq+CrXRoQ5h6ByHKq6erHpWs6v+2+PMymNAiu/bWk7nGGqiX8Bu8Lbisn1piX7vrlif86gvN1+HWD6yvzPw==
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id fm25-20020a056a002f9900b006de050cf904sm7506820pfb.22.2024.02.13.06.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 06:36:23 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1707834982;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YkAxiX5r+VqIkIVkIJIct9tXU0xaPqHrJhoy5Wg6JmQ=;
	b=aajLScVOulKlWmcSRQr3Nsc+qGxRAacWpO1TvOEjcogAyXCLWEvo5Fegu5Z3FSyMc2uWQ7
	fQB8cfPh8NjuY3zYvmMqs6GYN2nvgEEfG5sMAAg+MqM4r72UdAscbRMdgYOpjxqyuRKCkl
	RH5Bf+MhqdeLAMgYzvyHB+hAZ47n5FgTSZPuRpIDZccH1+JoD4kJAvQPQKX0SUXHNTFZBq
	Tu4sOSd78YMfvOPAcXKk3qa21u18I87Q4CNpuNw/GCwrWCaALOl7dDRCowtfzRVt/NAoOy
	KdgkS5U/Ht1Qj/PEm0MTEhln0zrdvh0coZIGQECZgD/QdqjiuMHDzVLKZlIn4Q==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Tue, 13 Feb 2024 11:36:56 -0300
Subject: [PATCH] soundwire: bus_type: make sdw_bus_type const
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-bus_cleanup-soundwire-v1-1-3878b00f6f57@marliere.net>
X-B4-Tracking: v=1; b=H4sIAId+y2UC/x3MQQqAIBBA0avErBPSSqKrRITpWANh4WAF0d2Tl
 m/x/wOMkZChLx6IeBLTHjJkWYBdTVhQkMsGVammUrIWc+LJbmhCOgTvKbiLIopubrXVnVboJeT
 2iOjp/r/D+L4fPwmJqmcAAAA=
To: Vinod Koul <vkoul@kernel.org>, 
 Bard Liao <yung-chuan.liao@linux.intel.com>, 
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, 
 Sanyog Kale <sanyog.r.kale@intel.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1698; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=x/FWpmXs+siXuzRbLc5xCsGrjSZxXzgMpFp8jCEzOjs=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBly36KrVxI+PQGmAsH0w2t1jeZA2FxQ6MOj2qEK
 2oGW2jj4EqJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZct+igAKCRDJC4p8Y4ZY
 pltbEACoPQZ26lL/izzlySfi4VuAnNfVsedcSulBaj0v6Ea02cKw2/Ov5fkJ33ocppgQWB3YSMo
 LG5XLMoN7+vlkXfTKM3sWCG77bgACP0O01pqgNj+16zL7iOnh9JQoIfyyAYCivsUyBF1P9Ly4sK
 KtUvSBRogxPm3he5aQuwA6JKHP6ijTyi9qihAO5k9wtmtP2E5ig1d5EbsS/flA3zYB9y+PuHiTK
 sfjiTmNi0UybAqayGTt+MhsjDOZ9/UnPiNJI0in5FRF3//sAYz1WJPtV8ibPc7k/NOkq9W1QIzX
 jglIarP6/kfsaMEYeJCB6X/8pEqQGPiV++FFBbdI8YS3OViEZLeRY+OvyYCfOeendzje3qd+aVZ
 z+SX7WnlWHMfIQK0faD9Li20vtWkqiGl6wgIgMozotUFlp0QjbbGUI8h4RXZ8IrvYw8iiUvYzak
 IADSS/YUKuFyu2qEUy+BVG5yKihzv0DPVda9va038hdaTmGnSmBtbFUwxttX3PmjiLT5iVIV2sd
 im8BgqYBGkvTzF5qv48SvOm9RuOkOqc5T2R5pXUoJFYTTIdBbCecV6OTjnRvKXP9UqJTeFHXTaJ
 41liBO+jg3frKWvUm/q2rc0E6lB7lJI3D4JP9Emz1XcWok/sDlaS8ZFt57lJG/w3Qppt2uBuzB5
 O/kZXaxuWCUG1/Q==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit d492cc2573a0 ("driver core: device.h: make struct
bus_type a const *"), the driver core can properly handle constant
struct bus_type, move the sdw_bus_type variable to be a constant
structure as well, placing it into read-only memory which can not be
modified at runtime.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 drivers/soundwire/bus_type.c       | 2 +-
 include/linux/soundwire/sdw_type.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/bus_type.c b/drivers/soundwire/bus_type.c
index 9fa93bb923d7..fd65b2360fc1 100644
--- a/drivers/soundwire/bus_type.c
+++ b/drivers/soundwire/bus_type.c
@@ -72,7 +72,7 @@ int sdw_slave_uevent(const struct device *dev, struct kobj_uevent_env *env)
 	return 0;
 }
 
-struct bus_type sdw_bus_type = {
+const struct bus_type sdw_bus_type = {
 	.name = "soundwire",
 	.match = sdw_bus_match,
 };
diff --git a/include/linux/soundwire/sdw_type.h b/include/linux/soundwire/sdw_type.h
index d8c27f1e5559..b445f7200f06 100644
--- a/include/linux/soundwire/sdw_type.h
+++ b/include/linux/soundwire/sdw_type.h
@@ -4,7 +4,7 @@
 #ifndef __SOUNDWIRE_TYPES_H
 #define __SOUNDWIRE_TYPES_H
 
-extern struct bus_type sdw_bus_type;
+extern const struct bus_type sdw_bus_type;
 extern struct device_type sdw_slave_type;
 extern struct device_type sdw_master_type;
 

---
base-commit: 9282cfa2eb080e3bbb95f488af35618b614cdf76
change-id: 20240213-bus_cleanup-soundwire-8b56c6862ef1

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


