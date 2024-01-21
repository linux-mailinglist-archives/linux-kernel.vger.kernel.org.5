Return-Path: <linux-kernel+bounces-32171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB948357A6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 21:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB1611F2194E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 20:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D8E383A4;
	Sun, 21 Jan 2024 20:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLv+9/5t"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A8B12E7C
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 20:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705867368; cv=none; b=nyUsoKN3HfJSAhePmflIRMOx+51H3kxfGY2U2L9EKbQi1p/uvkaDY07Lt+IQLWes8A27i/gMQubzVGTPrFqlwRiOgWogj/atT7CDkWg/r7unSy6oIQLjAu1JVGSRF0Ojk5KZnZF1wJ9cbcnGIJ0+aWFd5IFoKQitgz4zcK0YUt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705867368; c=relaxed/simple;
	bh=CFba6yBxMqahDhxXXbyJrpczbPpZcSOe7fz27cRHjRs=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=gzkgKlayuqwt6o06LlkKp4c6eym0cHk/JDCwBQKQcSZg75j5Sr+oBMLJA40mVWhiHtFnf58oIVGM7/oY8vgZ0Yv9/SZefKIV3YlhKzVNsUd28dHlWrPNoKaYArCsk1eS8RQvkmN9vf7B4jRrECeAkrSV+f0wwVlGLKvgY3nI4J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLv+9/5t; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6da9c834646so2506539b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 12:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705867366; x=1706472166; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y3EbBfiXII+xqP/XocniUaecVX4i3H4jifFCHOQtVck=;
        b=jLv+9/5tjTLZKmi9toAhi95RI1Oex8aFMI58gqo0d4sU/jdzHilGE3VGwmUyT1m7tD
         WkSj3ptt5sK3fx0UWZawkWcf64FULcTarHnzE9hnX7ddopV52YmXvm06YOHswQtYKfc6
         h0pLLHDgavCn6406rWyYhyfUZyTS3yeyzNXhuNCUAUQOIteE9QEqgDTBJARTyLQn3vFu
         XRcSmt8pPyAGHtVwQ+LtcdPIuKpI7qe0co9n2+Qu6G9xkuHIBzAAb6UD2TwtcgLPcVQf
         9hN3/3ENXaunG2zoVRxrHgfCPgRbmFRaIZYdarjfXITvNtbqmt3KJn2NjX/XBWznIY5n
         Yicg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705867366; x=1706472166;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y3EbBfiXII+xqP/XocniUaecVX4i3H4jifFCHOQtVck=;
        b=YcVzqTKJMJ23ul1ddgSf6U7bg/F/MhdFL76n+dmxuhlSMB+5NFvGZxsHkmrjF7pCBw
         WU+wzhJtah2pNoVwIrld9y3etZW7+vep83pSiW5fQ5XBIcDxKfWJRC2AiXUBpxn30DGa
         cmAtYmBIamS6luDVCq2lCCt2vuNYlVctbjxxtH8Niy1e+dZs2jUMd/HtYRb43w0OGbrQ
         lEHbMXb3mmDzmo2J6DdyJMMT4aQqmUJpC81pTBzSyQPqeWbuliRH5HMDmkbqqcbsrzjc
         SrGqRC4GETLpi/tFPgq3zXV9zyxLL7jvZPh5I0a9eFDeiS3ZnZzSoqrLUEDdBepQ9wFn
         lqDw==
X-Gm-Message-State: AOJu0YyfAWvliXk1Wh1R7E6ABxwdUi800CO+kv/FVz8eV77QyHFX36Lb
	+0zTuHn8CaNFPKyOFEIb2ppdoLoH+Y7BkmpDz0DX0WpPf7XG+FoYMcGxUuIZKYoy7l49
X-Google-Smtp-Source: AGHT+IFdtrMbzWPbQnjpvHP4970k0kKC5wNaRS4euLbx5//Aa0H7bgVlbkeHLrklgXgomXKKmm1jzg==
X-Received: by 2002:aa7:99ca:0:b0:6d9:44fc:f7c1 with SMTP id v10-20020aa799ca000000b006d944fcf7c1mr5079945pfi.28.1705867366474;
        Sun, 21 Jan 2024 12:02:46 -0800 (PST)
Received: from LAPTOP-7VGLEE77 (19.216.252.27.dyn.cust.vf.net.nz. [27.252.216.19])
        by smtp.gmail.com with ESMTPSA id c20-20020aa781d4000000b006d9a6a9992dsm8377265pfn.123.2024.01.21.12.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jan 2024 12:02:46 -0800 (PST)
Date: Mon, 22 Jan 2024 09:01:27 +1300
From: Hoorad Farrokh <hourrad.f@gmail.com>
To: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: remove unnecessary braces in while loop
Message-ID: <4ii7ptqhz7ion46dczabnevuj7tjfv4iofvzedms6tvfgsfu2e@6rvcsdyodny2>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Fixed a linux coding style.

Reported by checkpath:

WARNING: braces {} are not necessary for single statement blocks

Signed-off-by: Hoorad Farrokh <hourrad.f@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
index 1593980d2c6a..0145c4da5ac0 100644
--- a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
@@ -127,9 +127,8 @@ void kfree_all_stainfo(struct sta_priv *pstapriv)
 	phead = get_list_head(&pstapriv->free_sta_queue);
 	plist = get_next(phead);
 
-	while (phead != plist) {
+	while (phead != plist)
 		plist = get_next(plist);
-	}
 
 	spin_unlock_bh(&pstapriv->sta_hash_lock);
 }
-- 
2.42.0


