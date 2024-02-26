Return-Path: <linux-kernel+bounces-80491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DAE8668E9
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:58:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D6F8B21AF5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1701CABB;
	Mon, 26 Feb 2024 03:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="R8GrpEZE"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B99F1C6A8
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708919798; cv=none; b=pzXiBtG1vrInl5g/dJ7hA4bi3wSzfk6XBhbF463bbrWvZsSYo4ihubAdYPIG1b1cmqYX2AXlawWqTB8f/GjMDK2Lghw1RceesHG85Be33gjxxPzUDa52kOGcKMQ311rLdUkvtqbBPkumAoSrVcvuKiVrBiLMrwDzybzneX2LVuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708919798; c=relaxed/simple;
	bh=1u7hURa5SotBF7E39nq1ZuwEEo5Vll5q+P/Z5QRIR6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SZSK7Jyv/2rTyUmzvfXb9fWV7TewZ8d5BZyUwPPy17lC4aPFQtR78iqqY3NN/7537/KGqN3JnFNioZlGn8zeerCvpOJib7NBDRA5EF5WP8iRUZ1b7RJp4P3n4hPtHur3IKP/i93BIX1OPvorRJeNhtF582vPbGRQ98SkTQxk7lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=R8GrpEZE; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-299ea1f1989so1105098a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 19:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1708919796; x=1709524596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6tGxskfEu9aXnzE+dB8cAliyoIBj16sQvq/Y/hZR3k=;
        b=R8GrpEZE3NYBS8jzHXSwwBOGj1p7wbUA2caNAL0PbLnvIgRjuVx9H3R0qwt/BXI5WD
         fXL9YTEZ6x7HDYbb/5YBHBqh7Fotd9+yYW3sda/IQjyMus+FWb40zP4pjdD7vZBJcxfj
         00Yx2svM6m7D+rF6pzHDG2BPvwMKEh89H7Tgo+z+T+rg1uqUfj0SCdHH3IKimLdaAkJP
         MBR1DfShcQxb7DEOBf3Y1jmLhM8Z9neYGTbL//303OEZlu5A3uoXpYaK5mGLEhxSIOxd
         6FB6ytryb4BRMWOXSgz+HYEPAk1khHABW/Ku8lW6fZJU5Op+XYOWJDuM3DevEkAlKCtS
         R9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708919796; x=1709524596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L6tGxskfEu9aXnzE+dB8cAliyoIBj16sQvq/Y/hZR3k=;
        b=kSSNbE7wjzvKkOFlbaJBlHqOPJp9IH7Bq3lrvr7EqE5uGHg5qWtQPwPK/aV3FHggGW
         V7G36UNqStPlodt3zvk7J93t5MNXLD4+Hd5HfNuhhnsG4NzcvHIAnhsWQexcZ4rEk/c9
         7IDlUsKgthM0Mb5YcXwIlljBhUVcQ3LcnFp/GiO08Y27HiPcoKRpYYR2IgTR1+qs1gJL
         JYYSfezoR81uomlsZ6sAaPYRCBvqMLpKaPHLTrXfPeM+KZKqt4Lu0wH5Ej5dD693jNcK
         fQzf2SxbYrTbV4Ck+tTD1c8ueZ7XuxJfoQLC5hjiMtmUl1fqIughn37CocgLQkWqdwPo
         rS1g==
X-Forwarded-Encrypted: i=1; AJvYcCWLVxdrw9Jx51gCsUCikyO1Hb61IP1WsJK2Ft3VwMXmqFYg4hKsraTwZ+m+cBsJbrzQ9e83bLqxdtcXigq4SlVXmjzydOaz7pFoBhYG
X-Gm-Message-State: AOJu0YwXFzIR4btLVC1jjNgf82W8oOQNuNyzOsw00DuoftMNSRofpYtv
	/UXgRX7sXcCXJplo7bjcim+FWMwk281gJKYMXlaNJ3vufM7b/QfpfiXtf8dwQ9Q=
X-Google-Smtp-Source: AGHT+IEygXvZXsKKX+RteNlkEeMde3p8Sfrujz1Yi7Hukkoi2Ml7eVb7F0Lm5SkgsCA/cP2uI+YWgg==
X-Received: by 2002:a17:902:e5cf:b0:1dc:fb5:6f36 with SMTP id u15-20020a170902e5cf00b001dc0fb56f36mr7120020plf.32.1708919795919;
        Sun, 25 Feb 2024 19:56:35 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id kh5-20020a170903064500b001d8a93fa5b1sm2897615plb.131.2024.02.25.19.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:56:35 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 09/20] Staging: rtl8192e: Rename variable CcxRmCapBuf
Date: Sun, 25 Feb 2024 19:56:13 -0800
Message-Id: <20240226035624.370443-10-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240226035624.370443-1-tdavies@darkphysics.net>
References: <20240226035624.370443-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable CcxRmCapBuf to ccx_rm_cap_buf to fix checkpatch
warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index db1a47ce3528..71583bcd8334 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -838,12 +838,12 @@ rtllib_association_req(struct rtllib_network *beacon,
 	}
 
 	if (beacon->ccx_rm_enable) {
-		static const u8 CcxRmCapBuf[] = {0x00, 0x40, 0x96, 0x01, 0x01,
+		static const u8 ccx_rm_cap_buf[] = {0x00, 0x40, 0x96, 0x01, 0x01,
 			0x00};
 		struct octet_string os_ccx_rm_cap;
 
-		os_ccx_rm_cap.octet = (u8 *)CcxRmCapBuf;
-		os_ccx_rm_cap.Length = sizeof(CcxRmCapBuf);
+		os_ccx_rm_cap.octet = (u8 *)ccx_rm_cap_buf;
+		os_ccx_rm_cap.Length = sizeof(ccx_rm_cap_buf);
 		tag = skb_put(skb, ccxrm_ie_len);
 		*tag++ = MFIE_TYPE_GENERIC;
 		*tag++ = os_ccx_rm_cap.Length;
-- 
2.39.2


