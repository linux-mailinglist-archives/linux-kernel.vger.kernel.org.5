Return-Path: <linux-kernel+bounces-56672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2693784CD6B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5557B1C218BF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CA27FBA6;
	Wed,  7 Feb 2024 14:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4Ct78yJ"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34E67F488;
	Wed,  7 Feb 2024 14:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707317769; cv=none; b=KCq3IH+kwfwkD9JAZfJHUTVkea8GWDgSuem65iUGEyFxvjPf0+kIIlyW0UGUyJxJFNQnCPhDNFd6goBUsz1V1vM27q0fPIMmlUB+Y2Jw5KMnYpl+/i0zvqg7+1MzWp14mnnArclzIsXiatvjWpUg7D1NNuaA2JSYXQLHVfiqLSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707317769; c=relaxed/simple;
	bh=PJmG1KKGxok8PWBCFvMcq6dvkE8hOcLNOmvBI4+n6Wc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=ZW1MH1bRV0HxyJczYIIGkABEwTMdQPfiK51aubxmdeSBM4lXleIdvfqi1WBv+CmoDMH52vfDuvJr1s0meLeulNgqlFSs1obujUsmq0BsGF0T6bN59gEolheoPX6clATQWv8EvBg4Qa2JOBw2JrxlYHvkIjGQp1grUDBeuhYFG98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4Ct78yJ; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a28a6cef709so106220366b.1;
        Wed, 07 Feb 2024 06:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707317766; x=1707922566; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVb4olXz0r3VckM4ahy6qW3HKdVoZ71DhkYlv2eDkD8=;
        b=V4Ct78yJAfMybRejJj/nSWp6pdMV6QCHnN3aHI2qlDxhh9CuTVQ9r30e71TxHreGkb
         +NC8UffiwMPJ6/hAWQF8eJ9U+WSXG1xfnwjteOvyPHmI1BTT+X3XEhE9xw4ccOghY322
         7WgHhSfH5ms2tltcUpJztu87M8TzZ9yJxcaMGjSmRRTA9fln4ejX3Ypv3I8tw9wl0DXs
         SBBT2w8sBqIJCQceqEPvTj2IH283t/cXZw/nwv3w2QO79rXzabScxnsQ2oYuUgjOMyJY
         if3khhB7nLAyDf9ptIx/Ez8yEXoBiRmlt8ZsvE/yUHfnFXIaR67vTfhL72rXHOXxppWB
         xTjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707317766; x=1707922566;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nVb4olXz0r3VckM4ahy6qW3HKdVoZ71DhkYlv2eDkD8=;
        b=eveYuxOelvWOnNKw/NXpT3oFk7z1NEBKw3CFt+/qbZilFWqBv23e+51LzNyQ493xyE
         IT9gmg5i/glRMPbpkvWKD2Ivcg79X7kkM0UZ1Otg1zTYXjzrCIM5Xq65AEPRsvM6yq/6
         fDOeCffzl9m5ektQ1mR/0lyhfnaPz1yY/KfO4F/ob0faGF4AaaLabKCIvlkRAIIh2f5y
         I459jctTfdBZ/a9vimvZr6wFdqvEQT0URlmeFYDRYp2UxhkeYp68PdOdcqYbMR9RrPLg
         Um6w9SReVSxFNhVUh5CSCOJp343ehYSTMYUSNCU00xS4zOU+Nos80aE9QBChv5vuep9P
         uYjA==
X-Gm-Message-State: AOJu0YxG44cbyWS6jg9IZB2vQCtOahXM9BKfhIyYZTACegj77RGGpdsh
	tu7awHEhpc1U8mEK19jVcmvveVUhynTcAfbWu2133Fh8P1116E+xkRwKbbbz
X-Google-Smtp-Source: AGHT+IGFLiZIGE658DXcSfTVcb/SKrDUqrQtrGYYb9krfTpRcZ0SiQzTzTHGY9PAjwSLxi9NoPYtAA==
X-Received: by 2002:a17:906:ccd9:b0:a35:3ce3:c490 with SMTP id ot25-20020a170906ccd900b00a353ce3c490mr4396319ejb.6.1707317765977;
        Wed, 07 Feb 2024 06:56:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVRLlSYJ6PJVecOI424/a08oDsIThNyZ44ywSYwhvGiqDtNFJNiRFYbIrLEwtLaER2VccvDmkaIQZqA0ZJj/VNDNhOPiyg/0PpKLzDq3Ky1N+t8XjcG3BjYrHyYxmaeh29S/E03sqVAl+bZ7bPtSvhfa4yTTgHYlFQs6lYiUFUZLp/cntvA36Gnnytu6OAYfNV63dPojQvObDVGgSBkG4sjOybyO/tFswV6OdPydHWlm67XpjANen3mM3Hl6t8=
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:81be:a476:88e2:db23])
        by smtp.gmail.com with ESMTPSA id a8-20020a170906670800b00a377ac3730esm839168ejp.2.2024.02.07.06.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 06:56:05 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Mike Christie <michael.christie@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	"James E . J . Bottomley" <jejb@linux.ibm.com>,
	linux-scsi@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] scsi: core: really include kunit tests with SCSI_LIB_KUNIT_TEST
Date: Wed,  7 Feb 2024 15:56:03 +0100
Message-Id: <20240207145603.15680-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Commit 25a1f7a0a1fe ("scsi: core: Add kunit tests for
scsi_check_passthrough()") adds the config SCSI_LIB_KUNIT_TEST and
corresponding tests. Due to naming confusion, the actual tests would only
be included when the non-existing config SCSI_KUNIT_TEST is enabled (note
this missing 'LIB' in the config name). So, they are basically dead right
now.

Adjust the name to actual existing config.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 drivers/scsi/scsi_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 23719b903259..0315a0dc3406 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -3428,6 +3428,6 @@ void scsi_build_sense(struct scsi_cmnd *scmd, int desc, u8 key, u8 asc, u8 ascq)
 }
 EXPORT_SYMBOL_GPL(scsi_build_sense);
 
-#ifdef CONFIG_SCSI_KUNIT_TEST
+#ifdef CONFIG_SCSI_LIB_KUNIT_TEST
 #include "scsi_lib_test.c"
 #endif
-- 
2.17.1


