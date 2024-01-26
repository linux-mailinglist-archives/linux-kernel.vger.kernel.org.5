Return-Path: <linux-kernel+bounces-40772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D556C83E580
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62FB11F24ED1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0905B202;
	Fri, 26 Jan 2024 22:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="bsWUoA5c"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7990E58134
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 22:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706308310; cv=none; b=lOysKfIrWGA+Stx6jcQ1wjmfe10xha4QAA+aAlmuOmBYEldqMgDtmXbWOcT/XojUmjXSNrYxuLHUldhiT9QGyF3Pt5t63stdbVxQbqDkK95IzD9f5Sp6jEY09D79vy2SwFAbRajolwmCRZ+MgS0sS8OUA6+mtYW5aTDtIi5Ri74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706308310; c=relaxed/simple;
	bh=bXgbQVHALOit0JpLxby/llTa8pMZ7z5TUOxAybcey2A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cfubATMd1iPGeVEgnSwUo2NQ8FAHMnCrp/8CLhpA8GATcu4tCrjRobXvzBDhdvWWDS5QPi+ONxfI7gOxcZqroCw/jIn3yajedl7NwcDpcQLXABDx8Kg6YjAabr7UkPqQ8jUggB4vEkq/1zHtT9/dKQ0e/GfdSIzdEzHlNbJEbGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=bsWUoA5c; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d76943baafso8265315ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:31:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1706308308; x=1706913108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vuMPJtFia+dzORGwT4oKwk5DTmcy4HXJHzRu2k9t7Wo=;
        b=bsWUoA5cyzASneLbGVgl6ocwiVufZUo9fL4qMuDLlAYsxOFxfa1xjBmiYVS94Dk7MH
         TzLUfazIO0JpgB/WTxmFUbL7tltr0IJZaAx62QXojmNGwfZpvRrq5V6KJGJMrA2dQq3J
         h3THOdqm/JZoHbXsVbj57tQpYzIS62jceZPUqqN8VycVRmDfLnYoFxo9lrUwFAO4R8N3
         PPUn/JnE44CI1a3xrU6Heeevd3PO7wSZnt8sdc7DdjIkYuq4CuIeAD1k60u2QXladHYe
         NFUry2BEas5oRQEZzVkhxdZOlJLfaEINhC2jWFAg11FOXFzl+lBnsZSpEgEBzUpMsYB4
         L2UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706308308; x=1706913108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vuMPJtFia+dzORGwT4oKwk5DTmcy4HXJHzRu2k9t7Wo=;
        b=MwfE90OXWvEnlBayr0SVELWyFY1qT70Nq4nJ6KUppd4FPZdfkWgj9CDue7afIm5gLn
         4Q9egf4PYscfZJ1dTbAM/RCWtMbjFYK/vfm/0DmdbfIPArc5xtIqhOKfPe56jsp9MIMy
         sRHMi035gElZwWaVFHf+jcfJ/4E/pAexYKiwD6rogeqQ7wddzwDIzR1412XtWVCkXfih
         FoH4lHHJLCxBZ9kq80WBHv1NEVpYrJvYvjLIcY17ygI+29AsGvy9aLU1n0/fMNqEx95d
         brDXBQh/4fR2TfNfwQxjr1U0z3NRW/cqXdJsjipVeFpzhtvHVuyGYl3kBQKUkeyq6whx
         5NDw==
X-Gm-Message-State: AOJu0YxiqLLbxPWjFbqZjmrR5e+jMEhFdGjD8OZpYrTazfuIRsn3C/aj
	GOZ2D75km1c2KncAefQ4NdWqG0PC5S2N2Q30hHJZfk0+p7x7MxKdfhQtiRvUzzM=
X-Google-Smtp-Source: AGHT+IGvwa3/HWJlOE3OkF7bG44KeH09Vpze5wvlGoHXrqTsYcXvAEgyeCN+4Wm7wWx5vxR7GWT6kQ==
X-Received: by 2002:a17:903:230d:b0:1d7:8b8e:52e7 with SMTP id d13-20020a170903230d00b001d78b8e52e7mr606102plh.17.1706308307850;
        Fri, 26 Jan 2024 14:31:47 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id n1-20020a170902d0c100b001d8a8f431b7sm737909pln.300.2024.01.26.14.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 14:31:47 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH v2 13/18] Staging: rtl8192e: Remove unnecessary blank line
Date: Fri, 26 Jan 2024 14:31:01 -0800
Message-Id: <20240126223106.986093-14-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240126223106.986093-1-tdavies@darkphysics.net>
References: <20240126223106.986093-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove blank line to fix checkpatch warning:
Blank lines aren't necessary before a close brace '}'

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
v2: Correct spelling mistake in Subject line
 drivers/staging/rtl8192e/rtllib_softmac.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index ab41632def7a..dc91e59f1bc2 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1081,7 +1081,6 @@ static void rtllib_associate_complete_wq(void *data)
 	}
 	psc->LpsIdleCount = 0;
 	ieee->link_change(ieee->dev);
-
 }
 
 static void rtllib_sta_send_associnfo(struct rtllib_device *ieee)
-- 
2.39.2


