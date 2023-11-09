Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B7A7E7090
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344779AbjKIRnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbjKIRne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:43:34 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED08E1BFD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 09:43:31 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2c5039d4e88so14952571fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 09:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699551810; x=1700156610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=x0mnIDGPT+WHoDMoZBIVwEOLAGpA8cSWlbxyWL1Mt0I=;
        b=AY3PkLIqH5ggRSi07/7qtRQ+qbHxaENvvwaxR50Si3EfCOyEN2+09rfqtCQK9zVqJ9
         +OF5kALKFSvSdr6cGj9yAcjknDT9p4DxXIYjjT3n079SYKd+s4FmV/GQ05pWDwQUt28B
         7u4K0ijn78GDT2s2Lg0GmOeUy95L3Okf4F+zn8E9NYMZZUr3GFsH25bHpoO4pULZ6Ej8
         grgp4Jw+MH/i40MEAkXcIEJsIzXwBYYJuWfPy09tMrLXezR6e/8XQ8MO00svheSXk4Il
         +I/f7NtoowYXdcgx6PcuVBYpHVUP1CKuqeMerKkJ/HEbtixD5csYJMln+zP1WF8ZVjK4
         ev5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699551810; x=1700156610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x0mnIDGPT+WHoDMoZBIVwEOLAGpA8cSWlbxyWL1Mt0I=;
        b=wGDeaAASuC75gJU1E/RiAoy2AH7rSuNkdtaY5DcRArJEgEH5tItgnC61pyHxfQO9V+
         fzHFsgfPY00u+jBfCwm4mmgNa6/J5wY6CNYZSdlxLSa5LawcKKSXxaHlx+MrEja4ZHXw
         mpT+G/xWwaY7UUtf+vRFCL+Uco/wKWrXhYYp1yibert5DLBh7KLcgAy4hi8v0ipa+v87
         NQSPp0UEwOmqMMTjqCeGWQupg3zHb5VYeeeyeLLB0SzOVhIUURVwjWyYa79WvlN7txAP
         sWRn1o+CpGPw0323jkkl0/U7imobWRgMjWycq15mUH1cdgLegxvai4bEPdQZHzSxrODS
         Ge1Q==
X-Gm-Message-State: AOJu0Yy/2eRscDyGr4OQFde6h6jItobC5hbFnz+qCvByy/6C+PKWEqMo
        CcSPw9ho+JL/nwWAz68pIKWh7Q==
X-Google-Smtp-Source: AGHT+IEpgoCC2LpiraNsrgyi17PVhBMrCLpZhyddjrBAoUhcLO7slV/3Y6xUPQp6fXsOziAxOdLiDw==
X-Received: by 2002:a05:651c:542:b0:2c5:21e3:f21a with SMTP id q2-20020a05651c054200b002c521e3f21amr5378558ljp.53.1699551810211;
        Thu, 09 Nov 2023 09:43:30 -0800 (PST)
Received: from localhost (c-9b0ee555.07-21-73746f28.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with ESMTPSA id a22-20020a05651c011600b002b9e0aeff68sm16392ljb.95.2023.11.09.09.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 09:43:29 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     bjorn@kernel.org, magnus.karlsson@intel.com,
        maciej.fijalkowski@intel.com, andrii.nakryiko@gmail.com
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCHv3] selftests: bpf: xskxceiver: ksft_print_msg: fix format type error
Date:   Thu,  9 Nov 2023 18:43:28 +0100
Message-ID: <20231109174328.1774571-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Crossbuilding selftests/bpf for architecture arm64, format specifies
type error show up like.

xskxceiver.c:912:34: error: format specifies type 'int' but the argument
has type '__u64' (aka 'unsigned long long') [-Werror,-Wformat]
 ksft_print_msg("[%s] expected meta_count [%d], got meta_count [%d]\n",
                                                                ~~
                                                                %llu
                __func__, pkt->pkt_nb, meta->count);
                                       ^~~~~~~~~~~
xskxceiver.c:929:55: error: format specifies type 'unsigned long long' but
 the argument has type 'u64' (aka 'unsigned long') [-Werror,-Wformat]
 ksft_print_msg("Frag invalid addr: %llx len: %u\n", addr, len);
                                    ~~~~             ^~~~

Fixing the issues by casting to (unsigned long long) and changing the
specifiers to be %llu from %d and %u, since with u64s it might be %llx
or %lx, depending on architecture.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/bpf/xskxceiver.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 591ca9637b23..b604c570309a 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -908,8 +908,9 @@ static bool is_metadata_correct(struct pkt *pkt, void *buffer, u64 addr)
 	struct xdp_info *meta = data - sizeof(struct xdp_info);
 
 	if (meta->count != pkt->pkt_nb) {
-		ksft_print_msg("[%s] expected meta_count [%d], got meta_count [%d]\n",
-			       __func__, pkt->pkt_nb, meta->count);
+		ksft_print_msg("[%s] expected meta_count [%d], got meta_count [%llu]\n",
+			       __func__, pkt->pkt_nb,
+			       (unsigned long long)meta->count);
 		return false;
 	}
 
@@ -926,11 +927,13 @@ static bool is_frag_valid(struct xsk_umem_info *umem, u64 addr, u32 len, u32 exp
 
 	if (addr >= umem->num_frames * umem->frame_size ||
 	    addr + len > umem->num_frames * umem->frame_size) {
-		ksft_print_msg("Frag invalid addr: %llx len: %u\n", addr, len);
+		ksft_print_msg("Frag invalid addr: %llx len: %u\n",
+			       (unsigned long long)addr, len);
 		return false;
 	}
 	if (!umem->unaligned_mode && addr % umem->frame_size + len > umem->frame_size) {
-		ksft_print_msg("Frag crosses frame boundary addr: %llx len: %u\n", addr, len);
+		ksft_print_msg("Frag crosses frame boundary addr: %llx len: %u\n",
+			       (unsigned long long)addr, len);
 		return false;
 	}
 
@@ -1029,7 +1032,8 @@ static int complete_pkts(struct xsk_socket_info *xsk, int batch_size)
 			u64 addr = *xsk_ring_cons__comp_addr(&xsk->umem->cq, idx + rcvd - 1);
 
 			ksft_print_msg("[%s] Too many packets completed\n", __func__);
-			ksft_print_msg("Last completion address: %llx\n", addr);
+			ksft_print_msg("Last completion address: %llx\n",
+				       (unsigned long long)addr);
 			return TEST_FAILURE;
 		}
 
@@ -1513,8 +1517,9 @@ static int validate_tx_invalid_descs(struct ifobject *ifobject)
 	}
 
 	if (stats.tx_invalid_descs != ifobject->xsk->pkt_stream->nb_pkts / 2) {
-		ksft_print_msg("[%s] tx_invalid_descs incorrect. Got [%u] expected [%u]\n",
-			       __func__, stats.tx_invalid_descs,
+		ksft_print_msg("[%s] tx_invalid_descs incorrect. Got [%llu] expected [%u]\n",
+			       __func__,
+			       (unsigned long long)stats.tx_invalid_descs,
 			       ifobject->xsk->pkt_stream->nb_pkts);
 		return TEST_FAILURE;
 	}
-- 
2.42.0

