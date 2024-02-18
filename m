Return-Path: <linux-kernel+bounces-70548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A879085990F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11574B21124
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8F26F52A;
	Sun, 18 Feb 2024 19:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="jESmVm97"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639EF1E86F
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 19:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708284312; cv=none; b=mvqsI2q4achz4JJmebHhOBqN6xYFI6UhJM4roh4LRDg+HLv0R4MJWzRWEmt3PjG3OS3K6O7SZDzQ8VNXilp7Q24TIaQRhgRh+Qdkg+mJforcJgktgCOJzbYwau8LHcFjrLRehJyFG4iF5ecjJi+skVOXIrZHjCUFHJTm/9RY9Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708284312; c=relaxed/simple;
	bh=QU2gBNz9Mdeys4gSZuq3IME+ETa6R0jLPNOeXyWCwFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bJaDgzYMudxmkI35GmPOWytYDdJE+dR7m2ze6HlAv90BV7MoGjjsM0XEbC8GGQcW4apOYCsPTnBnJiPUevXO11CYmUeYdvDtzSQyDRoRtXM+IvZ8DN8MrL5I6OJyYTPgWVF5ayvAgmlFxmkqmv5gnb+VNXC/Y2OaaruFlfBKbFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=jESmVm97; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2997a92e23bso275082a91.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 11:25:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708284309; x=1708889109;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:dkim-signature:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=viV015NiWL73QrpTuUpKGYi4PnbnYGJD41b4smPJKv0=;
        b=GpPq/zvwVo1N9YrvjdDOwKI/dsOxFJDxVDfbQ/BJtWGR6UTGADl5zW9JY8K1ZwKwhz
         2IX3CAJbrzDFRb6TqNdEYz8WMOMPPVasoMjlxfiDnIO0bXAY5BzLPZlZnVUoDvGvX9ZZ
         QX75l29XiEl6PzIIr2q6MyO89hufAAqvlnGK7jn+v+hNdOw9I0mVxXGvIm5gYeJ3OspR
         ujLVPPYkhKb8N48eel3LBL7oGqfR4ylLYfMW3wqCXCN3tLLpr7fYrh60k0u2r1+rZ1Gu
         SP1in44WrKBgTCbucbdzO+R1253d+M86g9Ra2jg1qxc01R7a4EhAs2Wyf3FPo2wWH9xE
         OsBw==
X-Gm-Message-State: AOJu0YwKYDoj7qjfwz1t7beRpKnUpA6n8Rp6GMdfJCUqJk4lngydCutn
	/UJjjXtZqgixR5Bld12LVvUWOoiy0RWQfd/gtDJYeblNyvZht+t9IW2Sr0SAQ+9mqQ==
X-Google-Smtp-Source: AGHT+IF2TwOdthXaMjY1EthCaqvVgA494jSRwP7C1PchoK0v+k+6l7MPuTu5X5R/l/vmkZAuiuq8Aw==
X-Received: by 2002:a05:6a21:440f:b0:19e:9d92:9bde with SMTP id vn15-20020a056a21440f00b0019e9d929bdemr6963008pzb.33.1708284309542;
        Sun, 18 Feb 2024 11:25:09 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id q18-20020a170902c9d200b001db9d2c1874sm3011281pld.29.2024.02.18.11.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 11:25:09 -0800 (PST)
From: "Ricardo B. Marliere" <ricardo@marliere.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708284307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=viV015NiWL73QrpTuUpKGYi4PnbnYGJD41b4smPJKv0=;
	b=jESmVm97+7jnRjdunAj0XyUGXNU1fB623IXkiorWqa5YyHGPxBDbBGmoOGDqF05rDCsdjf
	CNsH9ufBaZ/8UwvUATsoE/0pNQ3rDnMzvWgXOWpruzvUXmkWTarqJHMfGydkS1+AXylIxH
	7eQvJtidg+Bf5MHFauGNTMIjLCaYeuAXvzFKPVjNeIH1KrraaCNrlg7TbPCn6bsHRpznTF
	5QEL/DqA9qsEUY+kMwA+VmWSofTgABwDLgcsL2whNd5F8P62bK2ss10zZF2BqfLgkJjkN4
	enFrmBBEBdr839z3GKIgFbWlzki9jgzKVnNjTD/hI/pfex9vTpGy9T2iiIsApg==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
Date: Sun, 18 Feb 2024 16:25:51 -0300
Subject: [PATCH] const_structs.checkpatch: add device_type
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240218-device_cleanup-checkpatch-v1-1-8b0b89c4f6b1@marliere.net>
X-B4-Tracking: v=1; b=H4sIAL5Z0mUC/x2MUQrCMBAFr1L228A2VKK9ioiE7YtZLDEkrQihd
 zf4OTAzjSqKotI8NCr4aNV36jCeBpLo0xNGl85k2U5sx4tZuiR4yAqf9mwkQl7ZbxINu7MLVzs
 FZlDvc0HQ7/99ux/HD/BhHeZrAAAA
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
X-Developer-Signature: v=1; a=openpgp-sha256; l=981; i=ricardo@marliere.net;
 h=from:subject:message-id; bh=QU2gBNz9Mdeys4gSZuq3IME+ETa6R0jLPNOeXyWCwFY=;
 b=owEBbQKS/ZANAwAKAckLinxjhlimAcsmYgBl0lm/s+cLIQry/amD2ihWnN0tH3yV8RNQUuU8Z
 96voNJ+m3uJAjMEAAEKAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZdJZvwAKCRDJC4p8Y4ZY
 pl38EACLZDx463D+sZUcxP5JuqLYFjLdzYIhcx96TZLavRQwqUoW4O1AWAGaIW0qiNu71bBkZop
 W/scdQcARV45rFbshG6pVRPlwkmc5nRbIg70eC5pUX48UKGiamHR7Yd4+OnSZ5dwqndkS3TmPRo
 +fPZzzC5NvmI0wpTMruaoAVTW1a7hDKXNSPJQ+CsBRH3qYxtAmMkYoJppL/c5bPcjOOenz4FhWx
 DscVDotxPGuJKu11CqfktR0EaZwJayFpeEQScfUUPsWi9pAjx18WVscBgs7wwjegANgAQhtk1gz
 +22uRcC1d6xU4oZKPxFOYA1TpL0KDC1t/ow6MYxdvg+Bd0i0uTJtoJPKINEEyyFV9s6ekDn1+pF
 SffVYCCEcDcPVUwQE0CKP+rEAIw9VZ6qNDc1CunTAt6MsFWKd8ig8nzDeGIFJf05+DZ4WrgcqAV
 2BEMV4XRRIeN+5Eb1Ju5trkQgWVuEcJN/F0CeJvQvZIIA7OjkDINuQimf7YS8a1ChErzFn9gYQg
 zBSjkBvzI7laF4WaEUL+kFOjSbub0lucx4IroCuJUjLHp8sH28DdBhDzBDW3LqFOafN34gSzmog
 YtIap4NNpULKqR7mpMLrTkL/o79Exoae9Rl6d4jmp+J5ljSzym02vfW2v7Y32fkNXwl+WxyKKYu
 QjsMB3Zp78QAL8Q==
X-Developer-Key: i=ricardo@marliere.net; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6

Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
core can properly handle constant struct device_type. Make sure that new
usages of the struct already enter the tree as const.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
---
 scripts/const_structs.checkpatch | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/const_structs.checkpatch b/scripts/const_structs.checkpatch
index 188412aa2757..5227f34a1b4f 100644
--- a/scripts/const_structs.checkpatch
+++ b/scripts/const_structs.checkpatch
@@ -7,6 +7,7 @@ comedi_lrange
 component_ops
 dentry_operations
 dev_pm_ops
+device_type
 dma_map_ops
 driver_info
 drm_connector_funcs

---
base-commit: 4f5e5092fdbf5cec6bedc19fbe69cce4f5f08372
change-id: 20240218-device_cleanup-checkpatch-0757f924f00e

Best regards,
-- 
Ricardo B. Marliere <ricardo@marliere.net>


