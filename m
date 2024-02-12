Return-Path: <linux-kernel+bounces-61875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DCF8517A8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 809C5B24029
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF1E3C088;
	Mon, 12 Feb 2024 15:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IuE7mIgK"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EBA3BB50
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707750595; cv=none; b=kIG94UnvJc1UHcJWlQVETTdMJyio0dlMzYNh/B7dD+odt48cLEvIDTVmSS4NwTZAHnzvBDZZV4+kN47sw1Mj1tOXAg4o+ubqpN+Hmwp7AUuMHvqM7+6RSP6tfG/C8QwdKDzHGYau5Wl4pJ/kJD6l01+3hvlUycYDJaUo/CY0VAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707750595; c=relaxed/simple;
	bh=3CtlPnrAIc9kCdFZyaIZYzpbe4Ll+a/xbmqDNliycXI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iCIgibGIa2HFMfxba42OlY/JU11wAJtNSu17cD26wwKB0y6z/sE5xUHSZaE3nw3fEG9xvACOOsFxYFQl1BgfmGdBdSIaAM12vGOHMTum8YNJM49L0RLiBhD+lhhA2KDxdLrtrKsXo+7FnfbEeaKdLX24VdIBCw7LuRS2IQIWoSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IuE7mIgK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707750592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+ItIfDGsC0enS4BsvR9I/hhCmejBlGx8oVDqvTbRAes=;
	b=IuE7mIgKtt3nAd16HQDwkPHhaoVQFGowoqtaUnwaKTMmBdwN565k7kLD2/YJp8aFgALo9i
	PHQ2GnS6PfE7gIOE12rVg1Vllp8Fxxo7uto4rU7K9U5o0pStJv1qnm0kETawcB/QM0iD4G
	y05Kev/Sc2la+T2+8TMyUqp7BRzPfaE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-h-JPHpR9PqyFzO9A_liJqA-1; Mon, 12 Feb 2024 10:09:51 -0500
X-MC-Unique: h-JPHpR9PqyFzO9A_liJqA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-42c6f7d83abso1422571cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 07:09:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707750590; x=1708355390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ItIfDGsC0enS4BsvR9I/hhCmejBlGx8oVDqvTbRAes=;
        b=iz6dpPPrXlyMMJJXQHQPJRu80mUQqrL3sumuNAoY9iSSs0HnC8hoS1Cpnf7S14kvzb
         4V6mq464F+iAx1fLcAcGVBToXWTZCFnAnFZwoWiCVGNsnJ1Na/ox7cZKe52APzfD7Pp7
         gQdIXrU5O/Hm9ausU04CsA7PaUTl3TsRz7QAkf+iFk/Af0Mo5LQnrLXbK62f5+g9ipNf
         K4vAH/M6eJcR5Rv7Lc2rgUsmf2vnvD1oifdfFo+URv4MPsUQfS+Ze2Qpkqop6KpsvBHR
         YY7VJEcmVislZMHXRmB+iVn8deSviW7OjEZBUW0nWrcBMmk+AoYhQV2OpJzqSwZdaRJK
         QBsQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5ruXEAv3pJ+YbQBNGHlyTvg5UWgFQcYlQNhfTkh3ODC057AmZZAkL6R2i2UOgxCi49nUm8FLvIX/wy/fALVcn/xEe4SP6l+o3IaRk
X-Gm-Message-State: AOJu0YzqqRFoRzZvKCVIhqiK8OhiBjSgogRhbAnykqfEaeZgdBc2/pnr
	cOra+EOze1o8JRkRyLflzUhHVKyPexUR977uc8IF2TDh5lHTtDbjD5SIHCrQO0xBxwSm8HBmz+R
	rK7FnFdzp6uk5XwwzTFE+pskmrbXGLGqi8LccJgyVumCajHtxGAgV2F9i1NjX4w==
X-Received: by 2002:a05:622a:14:b0:42c:63fc:71df with SMTP id x20-20020a05622a001400b0042c63fc71dfmr8987677qtw.5.1707750590546;
        Mon, 12 Feb 2024 07:09:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHPknBjAVJNsaadO9yq2Eb2MRewXppMl85PQadkewZwkHwihhWG4rtXP8ycJskvQs6n+nNfXg==
X-Received: by 2002:a05:622a:14:b0:42c:63fc:71df with SMTP id x20-20020a05622a001400b0042c63fc71dfmr8987647qtw.5.1707750590230;
        Mon, 12 Feb 2024 07:09:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX5fCpx3BSGnayIIm+tvauvJ6kQuHOzJBxveyv9t2/FNcd5Ma2SwCiMHWI224C/xym8kyzWJN59dpa91PUVJNnOD5DHJxAcSTovV7ynV455KCyGxnPPkMideWar4HPSoN+mBf7RnrdrsGubvSQ/r1Kcc2EMh0B5t9zNfvO8DmxhpojDXYa9zr4ibJEaDIsbBN9YZ2to3FpiTFE0DmE3lz/Sd0sRQXlRm/s1gUJ5EgVRcUa3sA8mmIq8r+YAPLqfsjq/SrmNo+x2SyrytVkyJaZvcDmUm1AJGBXh2WASCrKRLCpTV49F5fKuSHWaBI4TvJP0eaOqTiU+TXx5hcdtOXSiaX7+RD4/
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32db:5d00:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id x8-20020a05622a000800b0042c6c103f7bsm213874qtw.37.2024.02.12.07.09.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 07:09:50 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Arnd Bergmann <arnd@arndb.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Helge Deller <deller@gmx.de>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Baoquan He <bhe@redhat.com>,
	Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] Docu: fix build warnings for PCI
Date: Mon, 12 Feb 2024 16:09:34 +0100
Message-ID: <20240212150934.24559-1-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

drivers/pci/iomap.c was accidentally added to the Documentation
generation at two places.

Remove it from Documentation/driver-api/device-io.rst to resolve the
collision.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/all/20240205160908.6df5e790@canb.auug.org.au/
Fixes: 025bbeb5c880 ("lib: move pci_iomap.c to drivers/pci/")
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
As discussed with Bjorn; this will be squashed into the series that
caused the problem, in PCI.
---
 Documentation/driver-api/device-io.rst | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/driver-api/device-io.rst b/Documentation/driver-api/device-io.rst
index d9ba2dfd1239..5c7e8194bef9 100644
--- a/Documentation/driver-api/device-io.rst
+++ b/Documentation/driver-api/device-io.rst
@@ -517,6 +517,3 @@ Public Functions Provided
 
 .. kernel-doc:: arch/x86/include/asm/io.h
    :internal:
-
-.. kernel-doc:: drivers/pci/iomap.c
-   :export:
-- 
2.43.0


