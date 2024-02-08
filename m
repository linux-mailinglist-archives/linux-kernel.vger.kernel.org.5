Return-Path: <linux-kernel+bounces-57754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EA084DD07
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 844EAB22CD4
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C9A6BFB2;
	Thu,  8 Feb 2024 09:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQ8tcAwC"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7BF6BB3D;
	Thu,  8 Feb 2024 09:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707384814; cv=none; b=lRYhWDv1u0NYZniUGGnuWqZcmKHtxVYS345FrJTQ19CwTCfo+gVCEIK2jJUy85/Ront3x0jr63+r7Wug3+fLCIOvh1kPYenr1UFtqaf8vaVCvb/W8a6KnSPy1SRf0kS9K2hLMPoIQ2/Z1LcRdh6S0Q+C8YETmYy1Z93h7PQckuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707384814; c=relaxed/simple;
	bh=lhwPUoYyro9oaMp2bVStAN7YAQl8rqdb9WH7FoKshb8=;
	h=From:To:Cc:Subject:Date:Message-Id; b=WCTwrIR4e/J1OpI8+PboEb6VLDy/GpxYj2La5EAmxhUT83+TiM/yBpYDdkNpWssDm+Htwz4uNgaVfvf8ixTPLIxj8KZBj4N/raQxcxCLWMn8+9lpQYAv0iDJH0UJ5xjIxl3TxT5V8J3Gx6QnyTb5ish85EmKSagtSaGp3iiUlUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YQ8tcAwC; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5600d950442so1836317a12.1;
        Thu, 08 Feb 2024 01:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707384811; x=1707989611; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClZxZfA/V4+BWFkj7VuhiD7elrfOXLoTCprCHq1vgfU=;
        b=YQ8tcAwClVvjy+k2Q+WJX85DK4XdAaZtvkGLnC+BiphLi8q9RW73aLrIfno6MombQ/
         tEpwQ5RZrbLjaa6wy/SzpsfZwdVmCPIssGuWC7Bwmw8Bh6iUSbJ/D0sa/CHEFM+92/jI
         9qgnQST6J4UB63qmdf+hv75ZrtP85Pj5EhjQlaTU2ieGHcYaoyLEKrBTwXu0tJoQ36Yj
         pIFCqOXmvJZKbcJvUQH1rqtlPEPv+LWyc10TFfdM7pqJ6qHXn9LS6l/RNf8ZJLUfdI8q
         w0vpuhICBMvIaNnDQlFITEDxUYIbeJ3B69iKdS0NZzCsVHN2YxExEbZAc47j1Umf/9dB
         4IAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707384811; x=1707989611;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ClZxZfA/V4+BWFkj7VuhiD7elrfOXLoTCprCHq1vgfU=;
        b=P+kGpQi2cctzGuTBHJRtBHwgti/3kxp7qybeLs09QRIzR9GWPS6SIVv/VLK4dyNYW7
         43xcjfhlsYO0LV97AbzGrb1TqJbUsoY1xbif5knE5isb1Ct5eYhfsBMCs9+DdLPjwrlt
         CabJt86y/2puXau9rgvp5Wh8ag8g1IbzfWnhuS6aIlja9RP/UBrtd8v0onwJV92pyAMH
         9LdABit6aUfXgA8mpyMKFqMMnoOwXWXaPKA5yfjKkoLiTrXiN6q10Fu7JlFbZmsuERQV
         C8jCHMceZrb/+qcLNUzVeAnOyyKS5YrYLGXborMBXoA/7ri5+UR7QDOD5nyoAR0cRp3L
         DH5g==
X-Gm-Message-State: AOJu0YwdyaPfqxH+FeHcrxa1dub54Qk6xJwf2/hvQmSFIMQISfsJAmT7
	hXAN6nc4gQRXADKxF1lSnFgbFpWttlKv20d3rmiF1yKECPWFJ9eQ
X-Google-Smtp-Source: AGHT+IEZDOgle6xEeOkEl/5TlUMHh/sDQAV3pdX3MQSmWUeItHW9uH8U0Gszb+dGZ3njJ8RK0BuGYQ==
X-Received: by 2002:aa7:d95a:0:b0:561:1484:8cc5 with SMTP id l26-20020aa7d95a000000b0056114848cc5mr534673eds.39.1707384811049;
        Thu, 08 Feb 2024 01:33:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWdxX+Z5XfKi+0hB9EUdd/yz/n0ff5bWnTmPCM6KditwXe7kyb9xF7fGlJmcG7Qutlb6Zwco9744h+P0R8Mh3V5IizY3BIrOoHEtGdMCAxw3iNiFEJ6ZE0Ircd68BY0c0RPoaEQ5u0hDZPGt8BBJrNNcxPmMYtPEnvrJgXSBTCJbaLJ9NC74eviKltzeqexGBn/S36ZNGaeOxF8FUNB9tCQQx9o8Lhh/k7AB+Q1wXbeFm5VCM/Ac5Ii8CyDqo+b3A==
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:f81c:5b24:d269:24d])
        by smtp.gmail.com with ESMTPSA id dk5-20020a0564021d8500b0055c97f940fcsm628306edb.81.2024.02.08.01.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 01:33:30 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Danny Tsen <dtsen@linux.ibm.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-crypto@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2] MAINTAINERS: adjust file entries after crypto vmx file movement
Date: Thu,  8 Feb 2024 10:33:27 +0100
Message-Id: <20240208093327.23926-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Commit 109303336a0c ("crypto: vmx - Move to arch/powerpc/crypto") moves the
crypto vmx files to arch/powerpc, but misses to adjust the file entries for
IBM Power VMX Cryptographic instructions and LINUX FOR POWERPC.

Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about
broken references.

Adjust these file entries accordingly. To keep the matched files exact
after the movement, spell out each file name in the new directory.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
v1: https://lore.kernel.org/lkml/20240129131729.4311-1-lukas.bulwahn@gmail.com/

v1 -> v2:
  - address Herbert Xu's feedback:
  keep the matched files exactly those which were in the vmx directory

Danny, please ack.
Herbert, please pick this minor clean-up patch on your -next tree.

 MAINTAINERS | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 58845a852ab1..1820f661bfe1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10329,12 +10329,17 @@ M:	Nayna Jain <nayna@linux.ibm.com>
 M:	Paulo Flabiano Smorigo <pfsmorigo@gmail.com>
 L:	linux-crypto@vger.kernel.org
 S:	Supported
-F:	drivers/crypto/vmx/Kconfig
-F:	drivers/crypto/vmx/Makefile
-F:	drivers/crypto/vmx/aes*
-F:	drivers/crypto/vmx/ghash*
-F:	drivers/crypto/vmx/ppc-xlate.pl
-F:	drivers/crypto/vmx/vmx.c
+F:	arch/powerpc/crypto/Kconfig
+F:	arch/powerpc/crypto/Makefile
+F:	arch/powerpc/crypto/aes.c
+F:	arch/powerpc/crypto/aes_cbc.c
+F:	arch/powerpc/crypto/aes_ctr.c
+F:	arch/powerpc/crypto/aes_xts.c
+F:	arch/powerpc/crypto/aesp8-ppc.*
+F:	arch/powerpc/crypto/ghash.c
+F:	arch/powerpc/crypto/ghashp8-ppc.pl
+F:	arch/powerpc/crypto/ppc-xlate.pl
+F:	arch/powerpc/crypto/vmx.c
 
 IBM ServeRAID RAID DRIVER
 S:	Orphan
@@ -12428,7 +12433,6 @@ F:	drivers/*/*/*pasemi*
 F:	drivers/*/*pasemi*
 F:	drivers/char/tpm/tpm_ibmvtpm*
 F:	drivers/crypto/nx/
-F:	drivers/crypto/vmx/
 F:	drivers/i2c/busses/i2c-opal.c
 F:	drivers/net/ethernet/ibm/ibmveth.*
 F:	drivers/net/ethernet/ibm/ibmvnic.*
-- 
2.17.1


