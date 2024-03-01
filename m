Return-Path: <linux-kernel+bounces-88557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E204F86E366
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 15:37:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62152B211BA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 14:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F75720E4;
	Fri,  1 Mar 2024 14:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TV4qXrW6"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE081FA0
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 14:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709303864; cv=none; b=PT3lOxe3JeLUXbnNwog8L1BF6OjzmJua+MecYIF7FWikUd9VBPlLx5YY9dz8KlhvlQs0ayhUoAVC07GJUcTZ9pCpfsX5NCCVv9iIvn3f4GCFulQX7uQr4Xu9zpp3uUrJlziMihfPbBDRZ15WY572g4V/PXArLRzbXwpe6y41YzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709303864; c=relaxed/simple;
	bh=Tu1IhSm5ytRoCYM2NUIGoUQfc9tPBjeGnKpUrWBIzS4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eeBm8RKZKPtI4mU/6WHrjpmyBzTwWJ10utvu8nnr2tFSuGoc38GH3sXvbKoZcBD0/CdTmRkubYma98qYmBC9/apDH5RTbgqQfAKX01QSZQ1beX2x5+GvI2LspD1kVzP2FYDHsyG4vcM4TsNk7bsSkrorauw6qeG1g7u4aZHVjFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TV4qXrW6; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dbae7b8ff2so6097815ad.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 06:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709303862; x=1709908662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oVtdCDkncAEjYp5VDfB0TkA+iNPQzbJhtZQ9XlyWAes=;
        b=TV4qXrW63j5bHEgVYRDL5i5MnfUy4QudFtwBnXK5JBFifgyAyzNscdLpFUhh40SdYO
         QsEqUAU9WT4kPyHqgZMsSrkAIBj/7EUdVcujrgssNMabe9khIAb5TleYStqMC6mMFXY2
         +ovfR4q1D5pWeZGSTz+e+tExb6CzLLrS+4C0MO6pMMoVDz08WrtMVSYtRLhQ4TI7kQb9
         EiZk9vv+mss9H61A0HrOp2jf5pg7edESrxqqcPc+48+jq8Gx88Z4kZwJ4AT3n+Y+w23y
         tts8axSVuIH9A648mO3cZzEZFLRYCG8jqyE2CAiGjIGAerPwkFXCdPdvkcsCRnJP71Gp
         lBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709303862; x=1709908662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oVtdCDkncAEjYp5VDfB0TkA+iNPQzbJhtZQ9XlyWAes=;
        b=e0O9czIPHQ3Dwhq1AhNdzZoFJARSbMzTWV7gQ3QnezBCfA5GPTflGhXHuoygUxnmza
         uUWPrXogGmeTcnt1yrkui/6OmPx6PrZJ/z38HB2DW/cvilI7gQHx1cgCkEznnN/Fzv9L
         q7yV6HdZ6Qo1Xmdxe9cN2jXltOongABXSkLZorc62cSXKqq4fEckc1bQuu2ycty6nEpC
         IBVbERmimbt0dl77uksTZ4g0w5Z7UEyCTvDa5c2XyWg4vF9kiHfWgi91rdZ2/wMlOoth
         NKncrrar3+rJ021TdXFXbI7Eb1gcjNIBCbq0xYsPMGmDkFDDgIjYaKS62XAdWaMPr0Oa
         144Q==
X-Forwarded-Encrypted: i=1; AJvYcCXYQjn+3pYZxi2I87t38LZ29vVCuzitXp3yz2Uvi0OqCmnZem1WNxnR6HTUpAMlgS+EZ8JPQo2kio+AhZl8HVhssK4kFHSMMrK2FNAu
X-Gm-Message-State: AOJu0YzMb4LlaCtjYJ4UrURi9B48/OijQgHnvgWvsZWpMgpkzcl74Frx
	hQgxN1cFYwbdpilKdfRig00MtVShGqxj2GWjnCrFXp/7ZONDoVZoSCDN/QcLHbQ=
X-Google-Smtp-Source: AGHT+IEc0VYmCsFGtKuNFZxqUlC22U6RVuMYWS58KkWVcBcHQtJsz9h797yn3Q9ko08aW7bsTmOwSQ==
X-Received: by 2002:a17:902:d3c4:b0:1dc:5d9d:6eb3 with SMTP id w4-20020a170902d3c400b001dc5d9d6eb3mr1641483plb.21.1709303862445;
        Fri, 01 Mar 2024 06:37:42 -0800 (PST)
Received: from sumit-X1.. ([223.178.213.98])
        by smtp.gmail.com with ESMTPSA id c3-20020a170902d90300b001db94bead0asm3497899plz.193.2024.03.01.06.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 06:37:42 -0800 (PST)
From: Sumit Garg <sumit.garg@linaro.org>
To: op-tee@lists.trustedfirmware.org
Cc: jens.wiklander@linaro.org,
	ilias.apalodimas@linaro.org,
	jerome.forissier@linaro.org,
	linux-kernel@vger.kernel.org,
	mikko.rapeli@linaro.org,
	Sumit Garg <sumit.garg@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH] tee: optee: Fix kernel panic caused by incorrect error handling
Date: Fri,  1 Mar 2024 20:07:31 +0530
Message-Id: <20240301143731.3494455-1-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The error path while failing to register devices on the TEE bus has a
bug leading to kernel panic as follows:

[   15.398930] Unable to handle kernel paging request at virtual address ffff07ed00626d7c
[   15.406913] Mem abort info:
[   15.409722]   ESR = 0x0000000096000005
[   15.413490]   EC = 0x25: DABT (current EL), IL = 32 bits
[   15.418814]   SET = 0, FnV = 0
[   15.421878]   EA = 0, S1PTW = 0
[   15.425031]   FSC = 0x05: level 1 translation fault
[   15.429922] Data abort info:
[   15.432813]   ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
[   15.438310]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[   15.443372]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[   15.448697] swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000000d9e3e000
[   15.455413] [ffff07ed00626d7c] pgd=1800000bffdf9003, p4d=1800000bffdf9003, pud=0000000000000000
[   15.464146] Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP

Commit 7269cba53d90 ("tee: optee: Fix supplicant based device enumeration")
lead to the introduction of this bug. So fix it appropriately.

Reported-by: Mikko Rapeli <mikko.rapeli@linaro.org>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218542
Fixes: 7269cba53d90 ("tee: optee: Fix supplicant based device enumeration")
Cc: stable@vger.kernel.org
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 drivers/tee/optee/device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
index 9d2afac96acc..d296c70ddfdc 100644
--- a/drivers/tee/optee/device.c
+++ b/drivers/tee/optee/device.c
@@ -90,13 +90,14 @@ static int optee_register_device(const uuid_t *device_uuid, u32 func)
 	if (rc) {
 		pr_err("device registration failed, err: %d\n", rc);
 		put_device(&optee_device->dev);
+		return rc;
 	}
 
 	if (func == PTA_CMD_GET_DEVICES_SUPP)
 		device_create_file(&optee_device->dev,
 				   &dev_attr_need_supplicant);
 
-	return rc;
+	return 0;
 }
 
 static int __optee_enumerate_devices(u32 func)
-- 
2.34.1


