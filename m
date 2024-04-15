Return-Path: <linux-kernel+bounces-144887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9BD8A4C2E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:07:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 282DA2862DC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAE24E1C6;
	Mon, 15 Apr 2024 10:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ILcGSLnm"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6FE4D5A3;
	Mon, 15 Apr 2024 10:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713175638; cv=none; b=QyJUaysY38I5UsqoRAlqv4a8p75fo1hpemmhdKnNGSyGHM8xuGD11jmimPixMgAgqiKmzMolQJ4SDBn2ige3YTmfKhONP18fDMTp/+H2H35ko+PPW+q01S7KqprV0e3QW2rX9o0getUVKDtspnG1VCXjLqw+NdDWtckoEky7pHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713175638; c=relaxed/simple;
	bh=//V+V2R40r5SUvLYR5q4Klg9/1q6WEihOSkTw8xBNnY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=kFA9xLtB5NSnxKNtXDsliGqS1QDx47iIz8lXkXsgAKDoK6hbpdzvoSvKGCS7wRb/Zf7NOLtL8p9pNutwOusHT2dithm1hRRAwC1PPjKSDbb3oxAs/3Z60KeoWoTzbV6p6O18TWGw8q6kMrW6BqUX8pGZOMHwSZwZSvZ3l5rtZKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ILcGSLnm; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-516d0c004b1so3849440e87.2;
        Mon, 15 Apr 2024 03:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713175635; x=1713780435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BhlEjmtmUCpQ7ergSdGRir16O+zkW0stCcQ9+0jWIYY=;
        b=ILcGSLnms0elxkO1JzZp/TSa8xh6xawrnV9DEi2FTYmiSWvI6WoZ813148S0zli9Hu
         TVK7pKBVhzhPv5KV8HAylF0xo3LniI4LGZ/x8O8OsUX0T6hSg27nWEsB3ihoTqf4KynJ
         FbHDQvRcg3P0anQnTTUsqPnqFO2Byy3jAi5grtTfXNfdANPjJeDerRiKWKOzCpfgn8NJ
         hoUTNL0uynaCHnJehq5ss3eYS4w27rPJI/5D1bbHmEY9Txyrfdg/4UzoqmPPlDYId4Q+
         c1jo9ElV6sBaXKWBAjpvai+JRXCkpy9c15711z2EUU0MPKMpYVf5czlU+Sy+zYZNFYxH
         QnWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713175635; x=1713780435;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BhlEjmtmUCpQ7ergSdGRir16O+zkW0stCcQ9+0jWIYY=;
        b=emCejDTMw1lP1FH6rKMDbMUJT/cPslvDiseawHFmqpRSgTI9anMygpcgY6Ug2WJwbi
         XSBk0DzbhbbMM9ZN2Z60iKqzkK59j4HsxQU03XWIc970juBWcPx0y/nt7n5lxtwM+SZ5
         o5vV3LppW5uuOMeAvKMNun8iK4yf/uPd4HFQpIc08fY7n7dhMAoaKK6DDrH9jGIRVbuT
         4tEeL0XE0AB8mbHw2vnPGyisPnz2L47ZUL5cYKoUcx39v8uVOkdJfSLC4wO4nWUyO1QA
         pJlM85Ie+NjqBPbYWAv9yslVQXPqVSjGpfQMXGAwhMxlsEBl4WwMJpTlY60jKbOv/gd4
         iKFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUukPF9UVfGvrLC2eA1OTeYTetZMkNHU2BJpbtKxDyYrB/X61F7On3Ojwdb/UVVHShPwpVB1K+N5flzi93vdgH3NflIEh5dE/kNButRtM6XeRwgROny36eNg3VeWDkaPwSoddgD
X-Gm-Message-State: AOJu0Ywz6COsB1WLyo/MWRig6nrDrTRzecc6qWTUPXt6/FjbbzMeakVD
	XSuoN5PS8h4+37+QLJMExIjQY/0JqWdcraoki1B5e2O9aT9d97SONSGQieKg
X-Google-Smtp-Source: AGHT+IHdiou1eDSu75+fUv+u+sAkaqCtkm05euiSudyzbg/LpaOWWWlCBAgNmxSLvF4sVwV8UDA6FA==
X-Received: by 2002:a05:6512:68a:b0:516:d43f:898 with SMTP id t10-20020a056512068a00b00516d43f0898mr8871756lfe.21.1713175634718;
        Mon, 15 Apr 2024 03:07:14 -0700 (PDT)
Received: from localhost (craw-09-b2-v4wan-169726-cust2117.vm24.cable.virginm.net. [92.238.24.70])
        by smtp.gmail.com with ESMTPSA id j19-20020a05600c191300b0041663c75ef1sm15748031wmq.32.2024.04.15.03.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 03:07:14 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-tls-handshake@lists.linux.dev,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] net/handshake: remove redundant assignment to variable ret
Date: Mon, 15 Apr 2024 11:07:13 +0100
Message-Id: <20240415100713.483399-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable is being assigned an value and then is being re-assigned
a new value in the next statement. The assignment is redundant and can
be removed.

Cleans up clang scan build warning:
net/handshake/tlshd.c:216:2: warning: Value stored to 'ret' is never
read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 net/handshake/tlshd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/handshake/tlshd.c b/net/handshake/tlshd.c
index d697f68c598c..d6f52839827e 100644
--- a/net/handshake/tlshd.c
+++ b/net/handshake/tlshd.c
@@ -213,7 +213,6 @@ static int tls_handshake_accept(struct handshake_req *req,
 	if (!hdr)
 		goto out_cancel;
 
-	ret = -EMSGSIZE;
 	ret = nla_put_s32(msg, HANDSHAKE_A_ACCEPT_SOCKFD, fd);
 	if (ret < 0)
 		goto out_cancel;
-- 
2.39.2


