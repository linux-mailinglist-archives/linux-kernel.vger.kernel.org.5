Return-Path: <linux-kernel+bounces-41531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6232B83F3EE
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 05:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 456A51C21462
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 04:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62FF6FB8;
	Sun, 28 Jan 2024 04:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1gFmqsBx"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646E46116;
	Sun, 28 Jan 2024 04:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706417633; cv=none; b=eM0zjTPv7YxiKEUc8S2wuoiSmWBtscH0OuELLLNHpWBjgxHXiG5a+9sUOFJ/zeFQNWX9xiBRTTjos/hng3kvwtMVSiVoW5YLYjaXlSBp4ZpyxCwY0mdQr60zQBcwH9+5RwMi9AWePZ4EAvpBl0zeebql1HtO25yelkpUJXoEWaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706417633; c=relaxed/simple;
	bh=N8OAfAAMd64feZpXPmfhCadvsAZERJxQmTW0JK/hyXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y9oVjaIHvC/gzL7zi4kjuw9kMBo23vhya5vkoSghNEGL/6A2DY2c2OJuRXM2JqmKqNuN0TGrOyCQ2gEUgMyXoNIS+NOyPqSa+2o3u5kcRiD8iGvu4EnVXrVxyf8sfwBTysa6qS2or5ljWvkwRfkVO2e7vbJA5f67la0+AlLRLE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1gFmqsBx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Jhwv+0/QNmEjIq4GNRuX+cmD/88pv8YEVncUT+Cq1So=; b=1gFmqsBx4D2AYNJpbqL8sLgZO9
	n9iKt2Z100zcdDyEYD6MGmW8i+7ftVcnbCfKWoF7Iguf8rSlPz8ULyz4UTR2kK5cq0QVdC3dpiewj
	7qm2abZZ9bWjXEbnKknRlJb+/9XT5aLIZZS2GwpIUr5CncMhCHjNsJs+C0oLGRyeBFMUiGWM0RzEC
	MdwpmJf5NaZKgIjyDFHwnroASFlDaEHagWkimlz1BJYGOwviOf32P5E1uxOkAqjrcLLwszu4RBip6
	hFhgAw0qSJDIBEVHnkzBWCc4+g29cBPknnaK/bb/+ZYyeswb2E9sq3uABeyy3PvMwP6rcS56Y0V+m
	OaKUWEpw==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTxAz-00000008jQB-29YC;
	Sun, 28 Jan 2024 04:53:49 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Krishna Kurapati <quic_kriskura@quicinc.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Sergei Shtylyov <sergei.shtylyov@gmail.com>
Subject: [PATCH v2] usb: gadget: fix max_segment_size malformed table
Date: Sat, 27 Jan 2024 20:53:47 -0800
Message-ID: <20240128045347.25909-1-rdunlap@infradead.org>
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
extend them by one more '=' character to prevent the error.

Documentation/usb/gadget-testing.rst:459: ERROR: Malformed table.
Text in column margin in table line 9.

Fixes: 1900daeefd3e ("usb: gadget: ncm: Add support to update wMaxSegmentSize via configfs")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Krishna Kurapati <quic_kriskura@quicinc.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Sergei Shtylyov <sergei.shtylyov@gmail.com>
---
v2: s /to error/the error/ in the patch description.

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

