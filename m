Return-Path: <linux-kernel+bounces-155548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 858428AF3CF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 401F2286C7D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0570113CA99;
	Tue, 23 Apr 2024 16:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GhuZ3qEm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB29313CF9F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 16:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713889369; cv=none; b=KRMksd6apoBSysJf2F3Q/RTeGBDSFuO+9bFe1vZRurzHuOpbeRmAzRGzCuc9jGct9lpnLu4E4SgYsRphHUOCs4+yK+corNHPf76HCkPKawwJuQIwoUKV/xFlX2VCSP4/Ioit1azLE3i02/a4tnbQbg1yhb9hb3ZVqjYDBCLwHLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713889369; c=relaxed/simple;
	bh=RZ9HqBGp7TiesVGMtiKF6isf7pQuV7LId4hRp1mxlRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oTY5itXAKv7/Xrib8onuSL8Yj4APs93JVCtF9zOkBLXsu8PPE8JSjFQwA+QT4/VM6yiE2nirEKAQtCljWee61luOoi81zPlD0W5Ek+9/WaDWyqEm+dTT6sbHfT0DSBKJ4rgWtNaRPu7Druh3Bp086sOjAI8J//ZOcIVMUBJFvIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GhuZ3qEm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713889366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=H3SCZLnRvL1eBDiJGajTRcdGyi465jDJW6Y0DciZF9U=;
	b=GhuZ3qEmJUNXsKpMfAbAYgLAsG3T3bpJ3U6Cxn/cZ2xhOmBDLVOWyACP2kMRKXVSq5sljt
	RhMQ0BBufg84ljmgeB7IjUqv81fGrHjC4crIyuvg/PdyjhRcAbHGxx0TI8U0yUbnrYyrkH
	XP9pIiWyPZXwLwQd9EX9JEq6OnA7v/g=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-284-ymqMAgOGNMGyMYsnK7uF4w-1; Tue, 23 Apr 2024 12:22:45 -0400
X-MC-Unique: ymqMAgOGNMGyMYsnK7uF4w-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-79071211fbbso396984085a.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 09:22:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713889365; x=1714494165;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H3SCZLnRvL1eBDiJGajTRcdGyi465jDJW6Y0DciZF9U=;
        b=XOr9JEyXpUUPlqIQp3rUYn4llqk2QQmwbo7FBShBlRuraAocvJG9w+QNwWY14RwVJJ
         ATogiy98nabZpJOpijtyk1Rcd3iK7Gj24+mfTK+vXZX7OdzfZgcjVTylqRzLr8dc25+f
         qQ2Od0hqPFeYEIDDk/XiifuH1TV+sLAdPq3Q2jTSEX0oY8RQZ31F00DSHqBD+xBnDwpV
         BiMMtucXhS0ReigEUcHFSYedGfxNVhUuiPFnefWfdemhlkDWeC6GtukfB+KIQLdFPKNh
         nsOC20+iCzlihrcE6NkbiHZxHCqXYzcl7+0we2X0JG2lhZ8fAGDwKtD36ZhF62WK+Xme
         QlzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmI+5nSNg46c4DYNJE2ZOqx/g38y/Rf4bnPO0R2PrroYotpBjRfml0eOPZiuWzeCTWppPfB0QHsjclgKlipIIQX/+4nHLZsEspR57x
X-Gm-Message-State: AOJu0Yw9120kc3sKXTZdGXbBx+3myw7vKEKO9E135NSf2AzSafkFFdMn
	xn68leNBQ1+0kn18LAdGqGkyckywzWb7A6ykLF5NYKrpFcCa36oY3/x0s0fyJVWsadHqI8V/qug
	j5k/Y73HkkkU63itArqxvNgKmX1DHj+wNFzyJX+93Ost4R3PZnfcryZmO90RZ
X-Received: by 2002:a05:620a:4c5:b0:790:652b:6ed6 with SMTP id 5-20020a05620a04c500b00790652b6ed6mr11916150qks.35.1713889365077;
        Tue, 23 Apr 2024 09:22:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6LfYBiqs0o5HuFdrqThiCJq0HcpbT83enbtYOCy34DyyB4s1voP9KXTHqq36y4sCHWLaHbg==
X-Received: by 2002:a05:620a:4c5:b0:790:652b:6ed6 with SMTP id 5-20020a05620a04c500b00790652b6ed6mr11916132qks.35.1713889364776;
        Tue, 23 Apr 2024 09:22:44 -0700 (PDT)
Received: from klayman.redhat.com (net-2-34-26-208.cust.vodafonedsl.it. [2.34.26.208])
        by smtp.gmail.com with ESMTPSA id a4-20020a05620a066400b0078d73685803sm5412757qkh.99.2024.04.23.09.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 09:22:44 -0700 (PDT)
From: Marco Pagani <marpagan@redhat.com>
To: Moritz Fischer <mdf@kernel.org>,
	Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>
Cc: Marco Pagani <marpagan@redhat.com>,
	linux-fpga@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fpga: re-enable KUnit test suites for the subsystem
Date: Tue, 23 Apr 2024 18:22:29 +0200
Message-ID: <20240423162229.52023-1-marpagan@redhat.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The core components no longer assume that low-level modules register a
driver for the parent device and use its owner pointer to take the module's
refcount. KUnit test suites can now be safely re-enabled even with loadable
module support.

This reverts commit a3fad2e92c76 ("fpga: disable KUnit test suites when
module support is enabled")

Signed-off-by: Marco Pagani <marpagan@redhat.com>
---
 drivers/fpga/tests/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/fpga/tests/Kconfig b/drivers/fpga/tests/Kconfig
index d4e55204c092..e4a64815f16d 100644
--- a/drivers/fpga/tests/Kconfig
+++ b/drivers/fpga/tests/Kconfig
@@ -1,6 +1,6 @@
 config FPGA_KUNIT_TESTS
-	bool "KUnit test for the FPGA subsystem" if !KUNIT_ALL_TESTS
-	depends on FPGA=y && FPGA_REGION=y && FPGA_BRIDGE=y && KUNIT=y && MODULES=n
+	tristate "KUnit test for the FPGA subsystem" if !KUNIT_ALL_TESTS
+	depends on FPGA && FPGA_REGION && FPGA_BRIDGE && KUNIT=y
 	default KUNIT_ALL_TESTS
         help
           This builds unit tests for the FPGA subsystem

base-commit: b7c0e1ecee403a43abc89eb3e75672b01ff2ece9
-- 
2.44.0


