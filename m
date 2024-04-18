Return-Path: <linux-kernel+bounces-150017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7C88A9922
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59ECE284F99
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3642A15F30D;
	Thu, 18 Apr 2024 11:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b/YYnIaB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 299BC15B578
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 11:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713441395; cv=none; b=GRiE2fw6AOgry3PoreOohHAyHvPfCTl57ASzUyRd3zgMFO9JP1lQ/P5y2Qp0JIVSWFfm09TlXObDmUZd/sFcaLPOEzIBKh9eFKY7je7+r9+khIAPVLbziJkobrn5MEEt23/XVKFJFjkAAXmkZg/bW/NrF0dsdSSL9gCImgunJyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713441395; c=relaxed/simple;
	bh=3yHTimohmBYHD9xPmoEFceULvLGWUXVYoRvacg8EH5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KeWMvkuHtgNEvTcLmiCkNwipur49WZHZkNA7O/r+y8SqoMOdofzYHF5iblYTv2J4UbbsLp/Az1ZVLbg309VVa4xdQF0cu7+DKcbJHYDF/I2K4a/ThIJjUTSQXa1CwT4FiRqg/Gwz/BweP0rnLUO8gEzJEUCTDZEU0GLsXUpaOkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b/YYnIaB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713441392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zpn/+s8/qKx2VMhweSXvGNcJ/PhsEX+1bPMtRIf6i6c=;
	b=b/YYnIaB3F43dB/a7wrlbGhmDudYd/nkniBs2+bUXwYfbUZTor1Xt3A6XwVvyoOHhag7C0
	Bf5luo+cVS8FcyQD8OvHIWE/b/CmdxO+dAbNC3R4Pleew9m9q+9B2u1UUDNszb8mKrk9Qk
	U12XOIaOqL54HZyGULDkGJhfLQqgmHM=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-K61DwG2iOyWSdS11GE3qRw-1; Thu, 18 Apr 2024 07:56:31 -0400
X-MC-Unique: K61DwG2iOyWSdS11GE3qRw-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1e4d22f83a7so7990425ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 04:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713441390; x=1714046190;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zpn/+s8/qKx2VMhweSXvGNcJ/PhsEX+1bPMtRIf6i6c=;
        b=wXyTpDqbrVtzSknus6BIeENVyJCBV16jn+UOVXBfqOJLhGfKcjnURfaay6vLGv8GMy
         EtkjPIoU17EJ+gd9SjztyFmDkiruQ4DbrtUXD02ig0LcM87znZhQsxDCyzVe250BHwx4
         XzIJRg0hQFfNB83bS83EvQjEuvy68FsMpJwb8XwdQ1EmYRYxryClN5cP+lQ+u7XB6aM4
         h5d0KvaKchb5EKz+i0cr1IciTIii8wnFf9+UfpDhkTTYvBuz2ieF75quiJmUvECCBLZ3
         LfE2isrVBoWyYe+8XeONFRslleVJZI1rJXzC26su+UB+ZswVNF67c0HDIsdocvZq2SF0
         F9tg==
X-Forwarded-Encrypted: i=1; AJvYcCWLW88gdvDjmtYt2IBK6vzR4HvGy8AoKzfhaOZMaO7Z2ypTgWS+5aISmHI+/4AYfG4KE1W2yCbrkS0bf/8JoKRSzg57mJCLZrVz/8xd
X-Gm-Message-State: AOJu0Ywpm3k0rvwTEO/thKNp4rQErb9/+7HI8hcDPE31qrKIEEh8drid
	FwOb9ph8LgYpye6nx9HviB56GGa5bI3sUF441OQBcHu9NOzG4V2BaLxqwdI93iL1jzfXmu97KT7
	7HIgiSpmQhuY7LcRzY4l9GUJFbfO3ffxVWeQDpq4kJCdJNIjWhSk6Im3Eu1Eaaw==
X-Received: by 2002:a17:902:d48d:b0:1e3:e246:2cd1 with SMTP id c13-20020a170902d48d00b001e3e2462cd1mr2911930plg.62.1713441390361;
        Thu, 18 Apr 2024 04:56:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/yLCW+FuBgIVPDlCIsrQILrWY/8CCRWVBXPYZrovMCGdlh/2eHFOnHA3UVI6oJznOCZVKdw==
X-Received: by 2002:a17:902:d48d:b0:1e3:e246:2cd1 with SMTP id c13-20020a170902d48d00b001e3e2462cd1mr2911911plg.62.1713441390043;
        Thu, 18 Apr 2024 04:56:30 -0700 (PDT)
Received: from localhost.localdomain ([116.73.134.11])
        by smtp.googlemail.com with ESMTPSA id o8-20020a170902d4c800b001e4458831afsm1342875plg.227.2024.04.18.04.56.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 04:56:29 -0700 (PDT)
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
Subject: [PATCH] Add a header in ifcfg and nm keyfiles describing the owner of the files
Date: Thu, 18 Apr 2024 17:26:15 +0530
Message-ID: <20240418115616.58682-1-anisinha@redhat.com>
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

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index ae57bf69ad4a..63e2080298d7 100644
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
+		fclose(ifcfg_file);
+		return HV_E_FAIL;
+	}
+	error = fprintf(nmfile, CFG_HEADER);
+	if (error < 0) {
+		fclose(nmfile);
+		return HV_E_FAIL;
+	}
+
 	/*
 	 * First write out the MAC address.
 	 */
-- 
2.42.0


