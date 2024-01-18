Return-Path: <linux-kernel+bounces-29674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D22C5831194
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 03:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFFB61C210F8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED60C129;
	Thu, 18 Jan 2024 02:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="GCy8msPQ"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C386C9474
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 02:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705546312; cv=none; b=m/i5nXtlty9XWV/nkQQGWamTzwIygGfsuW+19J2rOvqPGq7ddM/tajaIsXSL/Rol/pcPgqRpKQLkxOrCuSrbLEZGKj8Cgile17lvyQdobKs2qSO98mjhgUCoc634XU/LB6TneuVkpzu6KwLhsnK+04pklhrcgoo7zUhN84OBNus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705546312; c=relaxed/simple;
	bh=qeZ3tY/o44baRhR6QAmQ3u7Ui4fQMK8qYGmLuQSHVR4=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding; b=j+bLEHpK3FiVWinWRUPxb1kn5ZkDcsiuHQ1zYCtv9Y5zLS5FI2KS1UFJF0nsA3ZbkIC5rqfVe5wBwfcBTmtJBM+2wEfnnY11UAOIl7oq1gvza32IQsH+s0RPv3ux8SbyhVnny+cQPM53/nxR0d4XPT6MtlEjPPrEILxNpfF+2vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=GCy8msPQ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-40e90163be1so1611155e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 18:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1705546309; x=1706151109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3o3JIW0lMFFX9linU1Dr7QEV8ZT+tiEVZq+1/7eCMH8=;
        b=GCy8msPQX4RwUoFlDWaO2h4HYSplkrqpQIvPaS5AgnuN38X+8ggV3Fl9JapMsW0ALt
         4iNNlnkLpubt9kwLMmMM9Qwpx8NDO0cgNYhO44zv5ovoyxpK2OarrJbej3cPfSZA6kUd
         1T/4/zexLh8ySXUtCSHxUK4M6hhj2AY5FbFJ6+Efn4mOi1Izg7veck6QecMLTBnDFPx6
         8/mKFiHwXE+sG6jPEEWV5ziQkzmDMUtGIUEdQqVYSAJeP444PkhYWpe1E4Z/pxkt8/GN
         vQbs/bEb6kcWXylE/QYeaoGhKX9S3xuFloH8hWpFS0l8E+183q7FW40eAq73PGLjr2ZW
         CKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705546309; x=1706151109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3o3JIW0lMFFX9linU1Dr7QEV8ZT+tiEVZq+1/7eCMH8=;
        b=mnjlo8JPzBAThW9w8wkGitCP51eDoLAdI4ExbCh7na7eJA/LRsqxKYS6YBRkq2YCUQ
         tEIeTxzudci7U9xf78K2YVA3qC0u4O+uq/uidE1Q03/KAWnmxQfNHpAtisJHFiXW30Lz
         +H04ZAzMyBc1cFldlaj+NwgHyxm7hwa8zxi0cFIp13XXpk2IT0VlToOOUTBQ0zfid7w0
         j1zNg8ANKBz6A2mA/Gkpc9alBaLStCdVLPL6nT8J2bZbr0OJcqLCTmis6tLToAuz4f6O
         OGhnmsa2pE1noswm4KGTPD3w33UTgpndMlEdwKWO2sFr40/UFSNqAajNaZxp3zQ86v9F
         0F4g==
X-Gm-Message-State: AOJu0YygqtBA2TlhHq++oL1Om+zIJvfavfQHYAj0zSiGE3CP5D3L++vE
	EM7ejgGcTMnGa7rX9EdjRsJ2njozZej7mCTLMDqAgpompfTuwCVLhezXiOY2PA==
X-Google-Smtp-Source: AGHT+IGTP8bDonVO2FTMnOfmYmhTkXA7oZIjIWi56IdHYCM3+hcb2Gwh7mTQIsxRTHcK1mpkziqCEQ==
X-Received: by 2002:a1c:4b14:0:b0:40e:47bf:f332 with SMTP id y20-20020a1c4b14000000b0040e47bff332mr41977wma.97.1705546309242;
        Wed, 17 Jan 2024 18:51:49 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id z15-20020a5d440f000000b0033664ffaf5dsm2868219wrq.37.2024.01.17.18.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 18:51:48 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Dmitry Safonov <dima@arista.com>,
	Mohammad Nassiri <mnassiri@ciena.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] selftests/net: Clean-up double assignment
Date: Thu, 18 Jan 2024 02:51:36 +0000
Message-ID: <20240118-tcp-ao-test-key-mgmt-v1-3-3583ca147113@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118-tcp-ao-test-key-mgmt-v1-0-3583ca147113@arista.com>
References: <20240118-tcp-ao-test-key-mgmt-v1-0-3583ca147113@arista.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-b6b4b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705546294; l=958; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=qeZ3tY/o44baRhR6QAmQ3u7Ui4fQMK8qYGmLuQSHVR4=; b=nB5WMfppjsBWtpYlDmqyc73zjVS9nEfgidteoRQ0/Rfb/dLrknlixH1oNA964bflYfHGG2n2a /PKkERTk0U/BI8T0dEMYZie22fblu4GxYKvI1gJlXBlW4Qmnysso9RP
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

Yeah, copy'n'paste typo.

Fixes: 3c3ead555648 ("selftests/net: Add TCP-AO key-management test")
Reported-by: Nassiri, Mohammad <mnassiri@ciena.com>
Closes: https://lore.kernel.org/all/DM6PR04MB4202BC58A9FD5BDD24A16E8EC56F2@DM6PR04MB4202.namprd04.prod.outlook.com/
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/net/tcp_ao/lib/sock.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/testing/selftests/net/tcp_ao/lib/sock.c b/tools/testing/selftests/net/tcp_ao/lib/sock.c
index c75d82885a2e..923a9bb4f1ca 100644
--- a/tools/testing/selftests/net/tcp_ao/lib/sock.c
+++ b/tools/testing/selftests/net/tcp_ao/lib/sock.c
@@ -377,7 +377,6 @@ int test_get_tcp_ao_counters(int sk, struct tcp_ao_counters *out)
 
 	key_dump[0].nkeys = nr_keys;
 	key_dump[0].get_all = 1;
-	key_dump[0].get_all = 1;
 	err = getsockopt(sk, IPPROTO_TCP, TCP_AO_GET_KEYS,
 			 key_dump, &key_dump_sz);
 	if (err) {

-- 
2.43.0


