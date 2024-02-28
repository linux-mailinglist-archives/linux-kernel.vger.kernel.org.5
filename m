Return-Path: <linux-kernel+bounces-85663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07D5D86B8DD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 732DBB2788F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA7871EB1;
	Wed, 28 Feb 2024 20:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QYd4rGVN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798EA5E07B
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 20:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709151148; cv=none; b=P0VblcsC0ImeqaQI7n51UkdUX87N/JFsWiCeX9gS/cYqbYZ4pc0Egl5kfW8e9FwHZz1bWTXNkHQWOxCHcOp5QPdzNRZkU1eOWd1E4CZn8GIKpKZp3hEC+YkpOytW8JlDkJta6DyVQUMZBiJ3EG4qqbo4kgSWk5TPS+CHvUjpA6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709151148; c=relaxed/simple;
	bh=vSCY86DjYJ6LoNtj3P/+29GiTUr7GSnsdZ1KbZ/S9k4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=MHtCiFAd3egjI7+NzKC5AsRkroWTAog3k3ObNh3Q0KyN1h9j7pGwIlLtOKk2KOWmyCuhr8pj5WZvcEmKMkiUx1mlkbtFLF+dtFR/9j68BeLtu29rup5Qyqvn/no5nmbVyBxSNKFdb7DjNnOyQswipMwM2zLgQPcgQ88Gi3+k6wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QYd4rGVN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709151145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lt7Z2bfGFfZb7GW+qc4A0EHIW+vtSShzIyaaG+Gg6bc=;
	b=QYd4rGVNz42HwTXwVh/CnrUqL9scxOT4b187fxp8/zizkNIH9VE7viRSSNt6rlqsGG8rTV
	NZrrkm9QTToFbh09zN/O7VDdVDD4gs9armgdoJNi+/gGFE+/v2rtLQOjtWK+QEFJ5g2ZBG
	7ZS6FBysQzKoi/dbxeDoibgQHFMR8DQ=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-lFeeXlUaP52Od5Om9zpcVQ-1; Wed, 28 Feb 2024 15:12:23 -0500
X-MC-Unique: lFeeXlUaP52Od5Om9zpcVQ-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-787b27005b7so14667685a.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 12:12:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709151143; x=1709755943;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lt7Z2bfGFfZb7GW+qc4A0EHIW+vtSShzIyaaG+Gg6bc=;
        b=aBdhR6baeZgMnVLH2NoUWqSQtkg3hrnS12jg8RoDfMinibxrqVlaFxpcqKT0zzVUTJ
         uqRJopZjJZUvaVU5jDxcX/0YDw4bVsIlNE3dmih6lfYxqazsGx+N4mP3+/sPNntL1JT1
         bEKwN6HKjESORBSloXXx6meupzeOmuJ0PMzYczgZuM6C9YFRbChMJKmSMWVVUEK0QYTh
         cjin5Jz9NB4ykMbSncKpDastrIapNs8QnJZkQmWULBF1TVZayNPa1wM7RdMnt7Pw2fyQ
         z9dFBgHZKtGMnofTV3YJdsiJ4UElRdtHBbBXjw6DlNAqoBQCc8d6mxHUgQDADbGQwsAb
         DGSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVu49AqaiGfPl0mU0oZTYd0yMZQhRTMZ7XA4tTOpxyX5grqq/eIEAyhw2HzvpP8UD9cPvIG+eRxwOfbV9gyXgFU7OpSdarDAl2vDH3X
X-Gm-Message-State: AOJu0YwVNFO1kmApdGvVwdLFLwcLA9wRj0YtzOtSdKeolzNmj6oL8FPy
	14Zor/bQ8qyUKxhmM2f35XQkev4lFPXdaDPIQ5BLaP6zHK7eF8dyzwWPCs58woMRKh1AYn9ElTx
	bI/PRfVkAQdtS1Ktv8rkIym8mlI92r7G5BPHihNjSTPlxCDYYDhT5WrcYSf4Vsw==
X-Received: by 2002:a05:620a:1108:b0:787:f452:df60 with SMTP id o8-20020a05620a110800b00787f452df60mr97193qkk.47.1709151143417;
        Wed, 28 Feb 2024 12:12:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzEM8vE6Yv8kYQAtA9/PNJt641WNB+vw1kTd4a6fUV85b8yyNH9nKk+KexNqOg1WQLFei8Cw==
X-Received: by 2002:a05:620a:1108:b0:787:f452:df60 with SMTP id o8-20020a05620a110800b00787f452df60mr97173qkk.47.1709151143120;
        Wed, 28 Feb 2024 12:12:23 -0800 (PST)
Received: from [192.168.1.163] ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id z1-20020ae9e601000000b007873213b29csm122762qkf.49.2024.02.28.12.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 12:12:22 -0800 (PST)
From: Andrew Halaney <ahalaney@redhat.com>
Date: Wed, 28 Feb 2024 14:12:06 -0600
Subject: [PATCH] drm/tidss: Use dev_err_probe() over dev_dbg() when failing
 to probe the port
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240228-tidss-dev-err-probe-v1-1-5482252326d3@redhat.com>
X-B4-Tracking: v=1; b=H4sIAJWT32UC/x3MPQqAMAxA4atIZgM1+H8VcVCbahaVRIog3t3i+
 A3vPWCswgZ99oByFJNjTyjyDJZt2ldG8clAjkpH1OIl3gw9R2RVPPWYGcNUF2F2VeOog1SeykH
 u/zqM7/sBYg+Xc2UAAAA=
To: Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
 Enric Balletbo <eballetb@redhat.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Andrew Halaney <ahalaney@redhat.com>
X-Mailer: b4 0.12.3

This gets logged out to /sys/kernel/debug/devices_deferred in the
-EPROBE_DEFER case and as an error otherwise. The message here provides
useful information to the user when troubleshooting why their display is
not working in either case, so let's make it output appropriately.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
There's definitely more spots in this driver that could be upgraded from
dev_dbg() to something more appropriate, but this one burned me today so
I thought I'd send a patch for it specifically before I forget.
---
 drivers/gpu/drm/tidss/tidss_kms.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_kms.c b/drivers/gpu/drm/tidss/tidss_kms.c
index a0e494c806a96..f371518f86971 100644
--- a/drivers/gpu/drm/tidss/tidss_kms.c
+++ b/drivers/gpu/drm/tidss/tidss_kms.c
@@ -135,8 +135,7 @@ static int tidss_dispc_modeset_init(struct tidss_device *tidss)
 			dev_dbg(dev, "no panel/bridge for port %d\n", i);
 			continue;
 		} else if (ret) {
-			dev_dbg(dev, "port %d probe returned %d\n", i, ret);
-			return ret;
+			return dev_err_probe(dev, ret, "port %d probe failed\n", i);
 		}
 
 		if (panel) {

---
base-commit: 22ba90670a51a18c6b36d285fddf92b9887c0bc3
change-id: 20240228-tidss-dev-err-probe-fa61fb057029

Best regards,
-- 
Andrew Halaney <ahalaney@redhat.com>


