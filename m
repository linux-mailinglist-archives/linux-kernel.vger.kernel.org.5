Return-Path: <linux-kernel+bounces-126439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF27893811
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 07:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 496B81F21476
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 05:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A14D8F61;
	Mon,  1 Apr 2024 05:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eo93+2kQ"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C4E8BF7
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 05:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711948657; cv=none; b=ntdOsizJ14s1XtvoBthiH7v5HWkuREdEZV5osxzowvkBWiuhzYnkLfYrRRR75LD15+GJ7xLhilLn4BoXJQLImaLCqWm5EzgsFoEBry5Z/d4m8EYvwDNVV+X5O2NsLz3PRCVMRDIuix9SKH8eMsaxjvj2+lZV9iszrtN16WHCZO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711948657; c=relaxed/simple;
	bh=tBglxvlDUeCZXU4OkTWfXJTuUNjdjT468JtqkKvyze8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pjyy0q+q6fbscXwmLWN8uuxCk2LJAWkC9drLz4FaVaN31FwgXIjhV2nPqzrClWivY0/Lf9IghercTtYibmkxQV4wzhf3XbKMbbPUj4FlBDbewlPMXE0ft8BRENMihivKX6qTWF194uJMQvpwwZYbX3NOSCk9+SpvGZvmXmR9gJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eo93+2kQ; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-515a97846b5so3880053e87.2
        for <linux-kernel@vger.kernel.org>; Sun, 31 Mar 2024 22:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711948652; x=1712553452; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cOj27ZZTllvPcuA8dCQrQVFTBK3f2AC/nEUUJ3KrkZY=;
        b=eo93+2kQtOjwj4VoyAZppsLLX11hY+nTWnj4nc5z45OXZGdRs45L4fDq6qoCHExTk9
         OhqEelZDErc0Z1ky61klV9H2OunI8/VPZtyo4A3C/3moik9WiKhhxtJrZOftYGfIaZix
         nnDUQ9gMjNDWzXSXLAFfSRogBARjncAwTZggoy5mhYVn4AaepzVOLiFnvE6QI9ZsTBd6
         ZKeq9N3GHgZkoVRy+E3KA1aZ3VbJC+qGZKO20JHLamF7kjC8FBpoMLB8mzNpsT9yA7xe
         ArsEN6jxFSSqudOsmQJb5/qvAcogtwptdEl/HZsCNye4k9aoxKfya1OGqA+7ZNjb4lE8
         uvgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711948652; x=1712553452;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cOj27ZZTllvPcuA8dCQrQVFTBK3f2AC/nEUUJ3KrkZY=;
        b=gGuAsPG8QOCE8uqTQAEBLKh395YNn/1z/f6o5KZxEeFV+xGCnkYorRq41JsW5aN7Ba
         hOZ7xA3lKigMLliLrof3hANyqbrWfrwdw/APF+VPpSONRVRnehOpzUOkAgYA8b9l90oy
         a+o2OhLX29ss+bSL/OzTC74cDIoIY571RGqM3WGMCLPoaOkL8vTEnOxT0qjORes8WyEg
         PHW3jtnzbo+zt9Vvgn8zXQ8W4iZjVglAGUSCV/frBJmC+JddXnW0PCgtmoGO6oV0cxVr
         l4n69pD0Qfwj/aN7KFr3ixMPd+oy87uC37sfBpuH13R75aMm1sNWv/1nNHvSmP2JCOx5
         kf7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVIEh2EGdEhPqhHFnEmCOU+leJVkMKZRA2JEUKG7Q/fG/qo06FqG6O6/uavgi++TQ4cy8evo9li3dzdth30IZVgVWSDqdl1Z6MET3K+
X-Gm-Message-State: AOJu0Yw4zSw7Us5qnHkVWihqG9F0sk47RsaVXjt1v54v2INQ8jlvY//5
	nYLbs6U4V/MdKrwXB15vipw7ptwq6002iatCvI9PPu5oUlM19N0XSYJgoq1Uwfc=
X-Google-Smtp-Source: AGHT+IG3yOIWJMlaa6+5jb3PNL7kJftD0rwMRnODCA6mYOj73UqdrbvoQaH734IsVUARtuD+e2Vc6A==
X-Received: by 2002:ac2:5f86:0:b0:513:cb7a:7cf7 with SMTP id r6-20020ac25f86000000b00513cb7a7cf7mr5147397lfe.63.1711948652453;
        Sun, 31 Mar 2024 22:17:32 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id x12-20020a056512078c00b00513e4086815sm1324342lfr.162.2024.03.31.22.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 22:17:32 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 01 Apr 2024 08:17:03 +0300
Subject: [PATCH] docs: submitting-patches: describe additional tags
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240401-additional-trailers-v1-1-f472bf158d2f@linaro.org>
X-B4-Tracking: v=1; b=H4sIAE5DCmYC/x2M0QpAQBQFf0X32dZaG+VX5OGyZ7kldFdS8u82j
 1Mz81CCChJ1xUOKS5LsW4aqLGhaeJthJGQmZ5233laGQ5AzS7yaU1lWaDJubBsfa3gGKJeHIsr
 9X/vhfT8zfY/GZQAAAA==
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2220;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=tBglxvlDUeCZXU4OkTWfXJTuUNjdjT468JtqkKvyze8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmCkNrIW2CbJPlEIiAtlkvjFoDoy+gKdyBxndam
 HItDuxWtu2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZgpDawAKCRCLPIo+Aiko
 1cHiCACqii0cJWQpxMm9UTq68xxNtctI48gh9Ma5qGRTEvzCaub8Jg/6AwxCbwDtbmBiwpkMZcT
 ASQ58aPDcqe7ctxXTxSYljbaUh3cy+FCcG+86/dc2FR0HCpTyMOZQFrIVA0M0b0zgW7uF7c914G
 tEfWr1/yPCrhb+JWD5ux9xB+rVYFAsLyt2a0UIL2lrJjHVKW20G6TGYMzyEVX+U4atm1ZoELVUX
 hxYXFrfoeZN9c8MBtGm1m71q017FYwV3JDEO77BVoDy79vzZiH1eGAFXJPgG3ebnCUau2KJbfan
 waSyQntx3ReP50HhuOh0sLRhVsQyWt9kFsUs1NyvKYLS1pBZ
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Described tags do not fully cover development needs. For example the LKP
robot insists on using Reported-by: tag, but that's not fully correct.
The robot reports an issue with the patch, not the issue that is being
fixed by the patch. Describe additional tags to be used while submitting
patches.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 Documentation/process/submitting-patches.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 66029999b587..3a24d90fa385 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -544,6 +544,25 @@ future patches, and ensures credit for the testers.
 Reviewed-by:, instead, indicates that the patch has been reviewed and found
 acceptable according to the Reviewer's Statement:
 
+Additional tags to be used while submitting patches
+---------------------------------------------------
+
+The tags described previously do not always cover the needs of the development
+process.
+
+For example, if the kernel test robot reports an issue in the patch, the robot
+insists that the next version of the patch gets the Reported-by: and Closes:
+tags.  While the Closes: tag can be considered correct in such a case, the
+Reported-by: tag is definitely not correct. The LKP robot hasn't reported the
+issue that is being fixed by the patch, but instead it has reported an issue
+with the patch. To be more precise you may use the Improved-thanks-to: tag for
+the next version of the patch.
+
+Another frequent case is when you want to express gratitude to the colleagues,
+who helped to improve the patch, but neither the Co-developed-by: nor
+Suggested-by: tags are appropriate. In such case you might prefer to use
+Discussed-with:, Listened-by:, or Discussed-over-a-beer-with: tags.
+
 Reviewer's statement of oversight
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 

---
base-commit: 13ee4a7161b6fd938aef6688ff43b163f6d83e37
change-id: 20240401-additional-trailers-2b764f3e4aee

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


