Return-Path: <linux-kernel+bounces-135241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C9589BD9F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:56:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81DAD1C21C05
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005FC604D3;
	Mon,  8 Apr 2024 10:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="NRks62Cy"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928655EE8D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712573762; cv=none; b=SJ+WNftZ5SJ6DCGh2AKrkQpSoF3WCt8OpiYKTaHEB3JkBRxEjJYe7VKNEi8+nQw2dCROqSDYOg7WJBntzHHKFBKBbSXBvYqy/sHPDbdbGIPPpadWJ7ktrGEL27P1lV4iAeIO6lBPZ90RXlhzD/9cj7ypnqNoUTeoZtHraTVlW58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712573762; c=relaxed/simple;
	bh=kEgF9I/ipHqHK/VgVuJ8B/ldXF4n52hinx8TTVFqrbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uIdGxVe+ewnAAI0ZdYLYGTtFjnX/BC1E4Znl7bww0eBfElk+f50qcn47NDoQUx/IR/YAK7D/acPyiAF8vyg8p69jPQg65GnTwsf36UKtHetGUiqJyiTPwk92tDa+Ac+ijxmMVWzM9XFOROqm6NKCFkTYrxpMIlOsxR56QfrZnqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=NRks62Cy; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56e67286bf5so689188a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 03:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1712573759; x=1713178559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mqQDXPfK9efO5t44B+8ce16kPk2snvMFmnndCGXCakU=;
        b=NRks62CyFjyz5+5YWPmKk2fIYwrWL1k6CmwblsjoG753AflHpDyJub2cQ4CoSCJSjI
         p8McSBpthGrgghmrORwnTB6Wdzuiko6OzmiAdeCSOLEA7Ebc/9NQhso1DE5Rk4QqShj0
         89rn3PR+A+ktzlWBmnFLTBmPnfPHDbImn6uRjVO/vkdou07UbsuCy50CwlFU5NXpQDtF
         NBx17W/uEmNm9Is/Fhw2dUfb2F8rQLideTxoSQWcpdL+l9tFS8pC1YUMvRBYomaTJKTx
         0jxbXZJOdRWRxloDjWbjuPc9gitvsKNW6u1chaxxgpQyUBdedaUOStOClzC0I8GnYidM
         Kktg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712573759; x=1713178559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mqQDXPfK9efO5t44B+8ce16kPk2snvMFmnndCGXCakU=;
        b=g97Q8r78I6W9FZ9lrSez1MV9cofERstX7SHtR/DH/9XIaoZlakyeCKJUCRGAbAEogZ
         av+7UeoeuXXzzy418iYPq/kJsjSYsGVk4ENfHqSSiY23NVNb2sNC0DpxCe6GZMtqt86b
         VU1fWtoIzzkBPouS/GP1i8Q4SThraBOqwa7ik9Ij1E683CRndTa02ci+z6o/Jt5QdVu2
         uS3nX59od+oiFiirk7lNCh1WpTWEOlIT8i4HMzT3hqDQ/SvrNZWENhk0MGf/oXvzVmJn
         npHDZfY0A47CMeF1nw6xrQ3XyY4v49ALKy6pAlHTA/8DFwgw01U7dndsQupxyrHD/N4k
         HSxw==
X-Forwarded-Encrypted: i=1; AJvYcCXgx98sN9KTZALxs9fu5xEyfzBlcpNoJ9hhe5QAFdW8Ged1TfC7b64Oev1TsF4sv8yYhsu4zzFd+OU1QGAf6+S7NIQsl1hfMqCG55K3
X-Gm-Message-State: AOJu0YxSS/xxg9ma0dJ4FSY5+14f5Z8et45Fd/89lZ07aVKY7yE47VUn
	tR0eswJG4jd74XY3qCIK+A2An99ivsc7a+41LSq9/zwlri6j5Lt9mRtJKBzQ8gQ=
X-Google-Smtp-Source: AGHT+IGVaPWTXesL6CrfDHvqS/I8wRxWNWsnEaZhlmzN2xzxmYEK/dbsAWen74B807WwEhMUvEGwuw==
X-Received: by 2002:a17:907:7e85:b0:a51:ab81:6062 with SMTP id qb5-20020a1709077e8500b00a51ab816062mr9443862ejc.30.1712573758841;
        Mon, 08 Apr 2024 03:55:58 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id se1-20020a170906ce4100b00a51a9d87570sm4008517ejb.17.2024.04.08.03.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 03:55:58 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] s390/tools: Use ARRAY_SIZE() to fix Coccinelle warnings
Date: Mon,  8 Apr 2024 12:55:17 +0200
Message-ID: <20240408105515.2328-3-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes the following two Coccinelle/coccicheck warnings reported by
array_size.cocci:

	WARNING: Use ARRAY_SIZE
	WARNING: Use ARRAY_SIZE

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 arch/s390/tools/gen_facilities.c   | 2 +-
 arch/s390/tools/gen_opcode_table.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
index 68580cbea4e6..ebd8a947e97c 100644
--- a/arch/s390/tools/gen_facilities.c
+++ b/arch/s390/tools/gen_facilities.c
@@ -149,7 +149,7 @@ static void print_facility_lists(void)
 {
 	unsigned int i;
 
-	for (i = 0; i < sizeof(facility_defs) / sizeof(facility_defs[0]); i++)
+	for (i = 0; i < ARRAY_SIZE(facility_defs); i++)
 		print_facility_list(&facility_defs[i]);
 }
 
diff --git a/arch/s390/tools/gen_opcode_table.c b/arch/s390/tools/gen_opcode_table.c
index a1bc02b29c81..468b70c85f62 100644
--- a/arch/s390/tools/gen_opcode_table.c
+++ b/arch/s390/tools/gen_opcode_table.c
@@ -138,7 +138,7 @@ static struct insn_type *insn_format_to_type(char *format)
 	strcpy(tmp, format);
 	base_format = tmp;
 	base_format = strsep(&base_format, "_");
-	for (i = 0; i < sizeof(insn_type_table) / sizeof(insn_type_table[0]); i++) {
+	for (i = 0; i < ARRAY_SIZE(insn_type_table); i++) {
 		ptr = insn_type_table[i].format;
 		while (*ptr) {
 			if (!strcmp(base_format, *ptr))
-- 
2.44.0


