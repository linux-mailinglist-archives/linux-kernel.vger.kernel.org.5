Return-Path: <linux-kernel+bounces-100372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EB187966A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00A7428477F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1B437B3E8;
	Tue, 12 Mar 2024 14:33:09 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1228416439
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 14:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710253989; cv=none; b=X3T9LZYXjLJhlmYsY8QuMlzVdpcISLQ43G+KNw+UGw3bzbp0WeSfhHPpQV0iZMX0V/ISBv+ip6+GfuhrK5fvl3cj1llR5t1JjGKyRT3sP2a0oOL8Fpbyr4uPGc6XfhACD0H3Z+zIyEFfG+d3d0ZHRkPlQfNBgPxT+wlhwZcXXbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710253989; c=relaxed/simple;
	bh=xibwLgdugElJ6qgRit1db6TNWxjYG1ahf7c6qBY+KNw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=h48HlmAtif3kzlbclSgoTTZA2V2a+CjRtc3jS+nPNVE15x7vpO0QzU2Taw0NR8y9MWfMQt2YkBVdQBcLw4WCb5dqTkA+6AWEy1+9dcFP6MRYQX0Pt3g/i6YN7unzIgXNDSOCGVcqYgs6jwtvAvDXPMeI0JKI+XiRFMISP5908a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c8a960bd9eso260686739f.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 07:33:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710253987; x=1710858787;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jcchRI6klPvetLBhvBb86zluU2kYnKjxKm1+oLxHEBs=;
        b=aRx1h5pX5Xy7JsQvlRhDrU0oX6R+p1iNJbrO9Dymut+Ta5HVq1S0C82OUkD8u4NeNn
         X1ti9Rb/yODlBMRLSW29E5V0Wv96klW5SothrJBa47WrNrZJaQf1462QqFcil8Wl0W8y
         CZbqv6T5mnazM2nYEdRg0ySjYNULoSd5wvg3F0KvmokW9jFlqicQFNGY1nPKbJm72UF5
         LUBWCuCjPJPNjucDrpC0LzddvfyxV5BgYmzYgSwTHmzgn3pnlESPO7S4jKvsGopri1vb
         oEL640YKtsfBH1Oo3+E8uyCHGIkEIEA4zvUHtoh0JsduiE8svEtR2A6xEPt8KSRcetQA
         fUWA==
X-Gm-Message-State: AOJu0YxPfri8akDypH//7o5kfiv01CxAqjtfLl3DHq9tEj89QTQ4bOtj
	FtgKyrp+Aga3GzEdmL9lhryqGfFw1BNNlX7xmr6LTNN34H0i023Nv/KOXLCze2TVOfbH2JNKgJZ
	NpjVuT3L2sIizyJ4gSraOriMLUNy1wGA01eX4Y0v0xkyoqoxiGlDDmGOQZw==
X-Google-Smtp-Source: AGHT+IGrmDBXSengP5xvtuCRKmhYSdS26h6jls71GcexbjIFLjkjCAM6hDA9YLXi837QFAHUki7QAsOH6lYx6VS9rn1KlUHaxBjY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3425:b0:7c8:4807:7a0 with SMTP id
 n37-20020a056602342500b007c8480707a0mr3354ioz.2.1710253987211; Tue, 12 Mar
 2024 07:33:07 -0700 (PDT)
Date: Tue, 12 Mar 2024 07:33:07 -0700
In-Reply-To: <0000000000001663ea060ee476ea@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006249bd0613778910@google.com>
Subject: Re: [syzbot] Test for 2ef3a8ce8e91b5a50098
From: syzbot <syzbot+2ef3a8ce8e91b5a50098@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Test for 2ef3a8ce8e91b5a50098
Author: syoshida@redhat.com

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 9f8413c4a66f2fb776d3dc3c9ed20bf435eb305e

diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index 6d14d935ee82..b983232e25cb 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -228,6 +228,9 @@ struct hsr_node *hsr_get_node(struct hsr_port *port, struct list_head *node_db,
 	 */
 	if (ethhdr->h_proto == htons(ETH_P_PRP) ||
 	    ethhdr->h_proto == htons(ETH_P_HSR)) {
+		if (skb->mac_len < sizeof(struct hsr_ethhdr))
+			return NULL;
+
 		/* Use the existing sequence_nr from the tag as starting point
 		 * for filtering duplicate frames.
 		 */


