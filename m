Return-Path: <linux-kernel+bounces-80511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A300E86690F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40C40B239D3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570451CD3E;
	Mon, 26 Feb 2024 03:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="M7D6Rs9l"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B8C1CD2F
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 03:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708919961; cv=none; b=iPt6FaOWwRJn6UlTen7+tb09d8oxmPiI2FXukJ5yOcQ1J2epWVmKF15VUwVS9ocoCWE7vE1NcL2qfPGppVQDFZZgQUkNSRW/Oqhn4APKGawGn2GZbDFe7QxjsFH5EufrRJnpyw11wgX9RNtq4+JUj6pkblMt0eUWXvJ6QBxZv/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708919961; c=relaxed/simple;
	bh=618httmeWCIIGJJeFM0I/PfO2VgZGTGYJmRi/GlI1l0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I3LN1408VpZAJ8UlLueONPUf886Z0tT6UNCKAfWpzKsGa3kPM0G5kMki1F++MPY5NTi9Aq3pm4tbVeyZ7dYQzfDKQwzbYLPPCRFkZEEgoL2MBwZbCWYEDwuYmPgBPM/BdDqnsgvUT9zHt9W72VBvEAOm6oHucSIFT+NHrpqjEj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=M7D6Rs9l; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dc418fa351so12379835ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 19:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1708919959; x=1709524759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xOsrd801zJsct3pzB+qM0qFvoaKTOFPWMLrZ/GwwX1Y=;
        b=M7D6Rs9lsSDPcan3c1iN7OOGmc5yD7d9TR+0HsT3g4V5jfrPyUCdMNdOylOJGhj8TG
         JehJkzoLI7JSr5dES5PLbLa3T68p3elxXO96KIZ8VO2+FA98QtvjCNMtTQ9X1MJ6Mfdw
         rQFte8BQbBuTHY3lXQK4MwpV7zPn/vjCXHkejbjJes90PUVjba6ZFhyucMEBZ2SxQVKy
         SddqP8sst0Pi8xp+9sulCq3bR9GDgefXO4lDUUGufbf6vTSXVBNKEB2e6jMEig/qE/Io
         egA52IIfuAABF1sjSoRXMw+n9XM0W+V+qF98Gzn8RKe2Fh0l8k+kmme/rKZHx9gvt1Om
         ne8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708919959; x=1709524759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xOsrd801zJsct3pzB+qM0qFvoaKTOFPWMLrZ/GwwX1Y=;
        b=gOGm88ATjtvHsMNYGS1SiGelGdPd1rUm4Vn8styxfldb1BTq27DGZiu78V18yzHUZA
         X67i33ql6HmptJO0cG3LEUaIIAnHQuZzHwwD4Tii5UWSGRJgGdK1IuxzdQiWcl3L/fn0
         zvCFYwbscicEkWImkJVVhKVzksB8cFeGjA2u/SeQ4UA0mauNPlqcsdIlVTC+FtKQ3uDe
         zqMsfKd4ZnGZlAww5fl/rdy+6QFrs5/mlVcudV7hwRYlTmgpcps4O0AQwapVj6v2YJAt
         9Uw+u+fJrvFvVbg3OVInDNKPSUxq5rKqNcJkvtAYqrxTbVbitaw13dGfK8knXdEeA/8s
         Mtiw==
X-Forwarded-Encrypted: i=1; AJvYcCX6l4hRUll1nmIhW2UTzlPaKfjYDhxjN9zXzXU9MkHH7Q82QFyXjQi1eJyA//jAgXAGQ4HkQ1F8U68zA/qx752K1PtnM5mkjvvMSbex
X-Gm-Message-State: AOJu0YxT0FmOywfgRpefP7bXrDQVccZIdrUJlGm4ErlIIB2prm9361l6
	jMNpd10G1jeDS3jyLVZyVgo+DfVZnBTwXGStEfBSVAAPZ5yyeqbw7Cj9CikCyPSZv4eCf3dcnfL
	D
X-Google-Smtp-Source: AGHT+IHnQD5q9kiyidY9XUm4GTNj/1IOQwkucBz96milIytJRdhSpAhuFAR4zIocKpdP2sWYK36cqw==
X-Received: by 2002:a17:903:182:b0:1dc:88bd:64db with SMTP id z2-20020a170903018200b001dc88bd64dbmr6045943plg.21.1708919959609;
        Sun, 25 Feb 2024 19:59:19 -0800 (PST)
Received: from oatmeal.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id iy13-20020a170903130d00b001da105d6a83sm2893426plb.224.2024.02.25.19.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 19:59:19 -0800 (PST)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 0/8] Staging: rtl8192e: Fix Checkpatch warnings in rtl819x_BAProc.c
Date: Sun, 25 Feb 2024 19:59:07 -0800
Message-Id: <20240226035915.370478-1-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes the remaining checkpatch issues in rtl819x_BAProc.c
These patches are to be applied after patch-series:
'[PATCH 00/20] Staging: rtl8192e: Fix checkpatch warning for rtllib_softmac.c ''
Thank you to all reviewers                                                      
~ Tree Davies  

Tree Davies (8):
  Staging: rtl8192e: Fix 5 chckpatch alignment warnings in
    rtl819x_BAProc.c
  Staging: rtl8192e: Rename variable TxRxSelect
  Staging: rtl8192e: Rename function rtllib_send_ADDBAReq()
  Staging: rtl8192e: Rename function rtllib_send_ADDBARsp()
  Staging: rtl8192e: Rename goto OnADDBAReq_Fail
  Staging: rtl8192e: Rename goto OnADDBARsp_Reject
  Staging: rtl8192e: Rename function rtllib_FlushRxTsPendingPkts()
  Staging: rtl8192e: Rename function GetHalfNmodeSupportByAPsHandler()

 drivers/staging/rtl8192e/rtl8192e/rtl_core.c |  2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_dm.c   |  2 +-
 drivers/staging/rtl8192e/rtl819x_BAProc.c    | 66 ++++++++++----------
 drivers/staging/rtl8192e/rtl819x_HTProc.c    |  8 +--
 drivers/staging/rtl8192e/rtl819x_TSProc.c    | 24 +++----
 drivers/staging/rtl8192e/rtllib.h            |  8 +--
 drivers/staging/rtl8192e/rtllib_rx.c         |  2 +-
 7 files changed, 56 insertions(+), 56 deletions(-)

-- 
2.39.2


