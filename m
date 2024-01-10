Return-Path: <linux-kernel+bounces-22739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F8982A25C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9B6BB261B8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438B24F1E2;
	Wed, 10 Jan 2024 20:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KkKoyZuV"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED15E4F1E0;
	Wed, 10 Jan 2024 20:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=hm+GOWLWZMlQYiUykVPkXxcZsaeHx3xTaM9h8zPhfMw=; b=KkKoyZuVd8JKHa4QJxJwkcS1Cd
	D91R5tFWaNIAGiKYHzg+9pVyjQVzgJCabMfF8DCgfXbKu+/N8XHWp/4NW4jZVObdlqF4i2c3ql/ux
	p47R6bEUjYDJRDmCThWASEIJki0SDf1h2jswBDHHBqwli352TajDPYHZESc8Avymv0lR915IehkMB
	b5HYXqmFgn8MIizRPfuMpfz4y7q87nSGTxThWYLQUXGSuW3O381uGBIDAEApeBAKu9B1kGvQtGdM3
	t3aDcmfpEuQdVNiGTLlKEB6y5FXn/WYELDOOSYA4M0m6OtaE43WAC5ZeqU2IvaVHyK86iiYBioPJq
	na9jppQg==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rNfIt-00E13W-1W;
	Wed, 10 Jan 2024 20:35:59 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Krishna Kurapati <quic_kriskura@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org
Subject: [PATCH] usb: gadget: fix max_segment_size malformed table
Date: Wed, 10 Jan 2024 12:35:58 -0800
Message-ID: <20240110203558.2638-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sphinx reports a malformed table due to the table begin/end line
segments being too short for the word "max_segment_size", so
extend them by one more '=' character to prevent to error.

Documentation/usb/gadget-testing.rst:459: ERROR: Malformed table.
Text in column margin in table line 9.

Fixes: 1900daeefd3e ("usb: gadget: ncm: Add support to update wMaxSegmentSize via configfs")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/usb/gadget-testing.rst |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -- a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gadget-testing.rst
--- a/Documentation/usb/gadget-testing.rst
+++ b/Documentation/usb/gadget-testing.rst
@@ -448,7 +448,7 @@ Function-specific configfs interface
 The function name to use when creating the function directory is "ncm".
 The NCM function provides these attributes in its function directory:
 
-	===============   ==================================================
+	================  ==================================================
 	ifname		  network device interface name associated with this
 			  function instance
 	qmult		  queue length multiplier for high and super speed
@@ -458,7 +458,7 @@ The NCM function provides these attribut
 			  Ethernet over USB link
 	max_segment_size  Segment size required for P2P connections. This
 			  will set MTU to (max_segment_size - 14 bytes)
-	===============   ==================================================
+	================  ==================================================
 
 and after creating the functions/ncm.<instance name> they contain default
 values: qmult is 5, dev_addr and host_addr are randomly selected.

