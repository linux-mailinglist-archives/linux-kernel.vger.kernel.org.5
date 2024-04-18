Return-Path: <linux-kernel+bounces-150039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A06D8A9977
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 14:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C9111C216A4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DFF15F412;
	Thu, 18 Apr 2024 12:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XeF6YWLo"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8803A15E80B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 12:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713441965; cv=none; b=GTUEPnEhh8oKcLQFINJsXZ/NZRcA92PGe5+On99YMtU1lnVplJ7AbsaAJOK8Bm8cn15dob40UphnIHyKK3z5SVEA3Nr5XuSJhicIlH6hG8Q02Wsy9g4pGEu8Y48FpFVmgkMbkkjggy3VoEkq0EsyDCj5KjNGpZBSIMJk337RyDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713441965; c=relaxed/simple;
	bh=wV1q09azHgzZ3Yre/HZZew17vHq85B77RfcsujVrHlI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HOdxKNdUBoNLD6bHFdymqgNrsczhzyKNuxDcCBKMUWyLtTCKrgCe8TsjRtCLhjJaU6XG7WflgKwRsQQjAX6RQE10pL91vcgSlOrW5HMYhMkRtDaHZadQ2wEHjSmOBNIiPZeNMWgtbn0GgOGvTEdOw4PHR7LxEhbFWpOWrV7h3FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XeF6YWLo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713441962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oxCCv+GY90eEUwoIFbKmjfk3gXJKwVh094KBVsL50+w=;
	b=XeF6YWLohMLqAkoidQEQ6C2mSMzrSWfNrWfbq4WeEgKGPIO6BHJ63WkuIvJ5csL2w+Exi4
	HzlRnJwXcHg+fkeJObdBbPOSOOvuZFsj1bksbRe7IiecExPCupZjXU5J2M7fanR9AdiHp1
	a/SLi1cnnGQknH7mDcmcPkkUbTk9w4k=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-169-Vyvi8pv0NnCOC9eAhEZ5pQ-1; Thu, 18 Apr 2024 08:06:00 -0400
X-MC-Unique: Vyvi8pv0NnCOC9eAhEZ5pQ-1
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2a53909676fso943542a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 05:06:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713441959; x=1714046759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oxCCv+GY90eEUwoIFbKmjfk3gXJKwVh094KBVsL50+w=;
        b=aK0fKMFZt6KoBIbUlkCMr9hlyzy5ipn5u04EcPQMYZHM4np634x3FNEVm3Jwcv2vaQ
         oGK+XOBv1z1bN9eNRHTDmIGPKHm5FIXhy7TEiNBtweIne8oLvZIPkTCuIhxFCAlfHkyQ
         nlJ3cdIx/nvRZOsv/CQrjiSVrLFMFma/1YWZtaoxyF9tHm7X6/n3R26srMRa6dUnw1HH
         yTC1FpJ1f6+ZYl+6U59c5R86mGWgReEwspFacXBpOVKBRT13TuuqNUjiuZQx8R3pZkH9
         Aavqlohw3KcPIxwC4GpvZIIsNT4Xad/cwVarwWSbxN6PDwg09cSmW+xNJxMmU88zbVf+
         gRTA==
X-Forwarded-Encrypted: i=1; AJvYcCWii0n307OSJ3zhZXtQM0yKk8Uy7Nq8AO6fk+ztWxeVI6/xRpIANl7kwncNRvZd39Hcj4B6QsYW7BpaOe531HxWLOBVInn5P5FFNDLy
X-Gm-Message-State: AOJu0Yyip0pJwecVBkwIcFl2YyEBPgFpFIe2P98qrCUV7BL95P2bLuM6
	gvz4MG9u740d13PGV0nUNJ18pJysF5QAtRmbmjtPxHXvYdf8OfwFMGfQEgn0hwtE8vlziLxYHXn
	rb0P5qMvRGEUGIzDeH2k8+6S3JxD8YyLfy7iCTYKwVmXrUFwucygmCLAzcwD5WHVE03ARCw==
X-Received: by 2002:a17:90a:ea8c:b0:2a6:e5d0:d42b with SMTP id h12-20020a17090aea8c00b002a6e5d0d42bmr2356068pjz.2.1713441958966;
        Thu, 18 Apr 2024 05:05:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFabCbK8j7WqSqyOEIhDwAd5yXN/ORmENxfb2k0++RkIZ1ey0r4T8exz9+3edB3aS8OXfSnqQ==
X-Received: by 2002:a17:90a:ea8c:b0:2a6:e5d0:d42b with SMTP id h12-20020a17090aea8c00b002a6e5d0d42bmr2356036pjz.2.1713441958430;
        Thu, 18 Apr 2024 05:05:58 -0700 (PDT)
Received: from localhost.localdomain ([116.73.134.11])
        by smtp.googlemail.com with ESMTPSA id s4-20020a17090aa10400b002a54632931bsm3006491pjp.23.2024.04.18.05.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 05:05:58 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Cc: Ani Sinha <anisinha@redhat.com>,
	shradhagupta@linux.microsoft.com,
	eahariha@linux.microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] Add a header in ifcfg and nm keyfiles describing the owner of the files
Date: Thu, 18 Apr 2024 17:35:49 +0530
Message-ID: <20240418120549.59018-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A comment describing the source of writing the contents of the ifcfg and
network manager keyfiles (hyperv kvp daemon) is useful. It is valuable both
for debugging as well as for preventing users from modifying them.

CC: shradhagupta@linux.microsoft.com
CC: eahariha@linux.microsoft.com
CC: wei.liu@kernel.org
Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 tools/hv/hv_kvp_daemon.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

changelog:
v2: simplify and fix issues with error handling.

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index ae57bf69ad4a..014e45be6981 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -94,6 +94,8 @@ static char *lic_version = "Unknown version";
 static char full_domain_name[HV_KVP_EXCHANGE_MAX_VALUE_SIZE];
 static struct utsname uts_buf;
 
+#define CFG_HEADER "# Generated by hyperv key-value pair daemon. Please do not modify.\n"
+
 /*
  * The location of the interface configuration file.
  */
@@ -1435,6 +1437,18 @@ static int kvp_set_ip_info(char *if_name, struct hv_kvp_ipaddr_value *new_val)
 		return HV_E_FAIL;
 	}
 
+	/* Write the config file headers */
+	error = fprintf(ifcfg_file, CFG_HEADER);
+	if (error < 0) {
+		error = HV_E_FAIL;
+		goto setval_error;
+	}
+	error = fprintf(nmfile, CFG_HEADER);
+	if (error < 0) {
+		error = HV_E_FAIL;
+		goto setval_error;
+	}
+
 	/*
 	 * First write out the MAC address.
 	 */
-- 
2.42.0


