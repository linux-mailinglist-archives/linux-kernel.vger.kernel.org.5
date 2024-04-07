Return-Path: <linux-kernel+bounces-134243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5997089AF6A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A8681C2140F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 08:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38476134AB;
	Sun,  7 Apr 2024 08:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JqbpjPLv"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C708311720
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 08:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712477126; cv=none; b=cwqVcuvrlegMqiLqcCR3zzoGWxmarwyvodQHrGwJXbd/GSnupQ7Jxj4YRENvU/mix30DZOOSwBi/oACUDa/I6lemHykPCnw9VHWO/wRFqDYg+iypB4oYjvw+82+Z6HOWUA3betCyhXO7DD0HrnWLiraDRoPlyrq/386ag35g09s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712477126; c=relaxed/simple;
	bh=sipUYppo/fuNUneIxzUGvGCxT1E3jMZtBO3piEFY9Bo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dy2nL9FvQoiafBn6CD1xBGBF1a0cxk+tU+e56KhaGzm1t1eAqmsp6V/9PLvRr9amTUDBg5vFTrp62+a1/F2ShDKz13ckrdJrOak46bP4hWfsZsRPVcXPCIBWQz4aidT9ViGgmn96f1buBaBn4A1wfGb0MSaQUbMJfIPAU7Si3E0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JqbpjPLv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712477123;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=fZMY4FIR5bqHlVqLpHDKFnD9HwhABXpqUz5I1Slfl5Q=;
	b=JqbpjPLvsgF94WhbSgJ/kUxp846SAWVyqQo2wieC7exSfAzJl4IMMzf7A43Z2klf1JLLfW
	2oyI+a8F4PQgNjiK8KmyG4+IfmWIVhdEnanaq2IFQ0sZ/KioVR3GgStqCdmSnRSlEi9K5u
	bFQT/fR3gDJxNpDzOsdzKViF4LbUkmU=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-wDpMQvvBPgyWTWfHon2Mxw-1; Sun, 07 Apr 2024 04:05:21 -0400
X-MC-Unique: wDpMQvvBPgyWTWfHon2Mxw-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1e278ebfea1so32536095ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 01:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712477120; x=1713081920;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fZMY4FIR5bqHlVqLpHDKFnD9HwhABXpqUz5I1Slfl5Q=;
        b=dO/RQm34ljNe2260O+RnFxgfPC29Rn4ufUgSDJvVnYkwxw+yLuJdVJqEkeRKePyRk9
         xadsf68Zhi/g8PmLCADTxDondkaEZCMbwTqddZTY05F87V1nlHeDwshsplVVpK3ls8qQ
         pE94H9VIXp2Vc0HhXNR/LpO1Zf7QkGYDrIiJi6uMx2EwqOUhzf4qVLja10D2M8YmRcn8
         a80UV8OhAbn9qVKqqaoI0k0I2zynJItO8tDfqffjV+ASRUj9D5I2WUgo4rRs5jl6NFNz
         y0A0+F4KhLZnNbYAqfPtmvD1I0EzYvgPvjgM7gUHZFdot6vURLEbPFWTzwmHI7wC1AgV
         HUwg==
X-Forwarded-Encrypted: i=1; AJvYcCWdwZf1v4sFbJW9GzSVnj8kYxuJsFGoS/a/j0SWzn3HSIVPb3ei8k7DySXuRQen3IV/GcbzIQ/ZLUb3RR90E5ImUdb3WAAd/VYoaSnf
X-Gm-Message-State: AOJu0YxUYfl0khXoSE0aA5f97RTwlrIfMjABd1spMuEN7J/ILE0w+vd2
	05v8sDCS2tAf39pCN3iuMITTbNZ1v5D8xucrqx93eneYOFiXneLMjIv8TZk8RGAOdf7cGKV+KJ1
	q2SMjk3JfnSfPDq+M7gvMavAOSadgVV+/Gp+Fcv8AxDQtPaUOceINFDhSSqLApw==
X-Received: by 2002:a17:902:6806:b0:1e3:dad5:331a with SMTP id h6-20020a170902680600b001e3dad5331amr3187002plk.59.1712477120365;
        Sun, 07 Apr 2024 01:05:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdLw+ctudtG5r+xOHndXsrdEa+rCjmOgdC2XpVPQttOj9CueVJYiAKFgBsFYW1hcW2+KHY2A==
X-Received: by 2002:a17:902:6806:b0:1e3:dad5:331a with SMTP id h6-20020a170902680600b001e3dad5331amr3186986plk.59.1712477120035;
        Sun, 07 Apr 2024 01:05:20 -0700 (PDT)
Received: from zeus ([240b:10:83a2:bd00:6e35:f2f5:2e21:ae3a])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902780c00b001e3c9a98429sm3735115pll.119.2024.04.07.01.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 01:05:19 -0700 (PDT)
Date: Sun, 7 Apr 2024 17:05:15 +0900
From: Ryosuke Yasuoka <ryasuoka@redhat.com>
To: krzysztof.kozlowski@linaro.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	syoshida@redhat.com
Subject: [PATCH net] nfc: nci: Fix uninit-value in nci_rx_work
Message-ID: <ZhJTu7qmOtTs9u2c@zeus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

syzbot reported the following uninit-value access issue [1]

nci_rx_work() parses received packet from ndev->rx_q. It should be
checked skb->len is non-zero to verify if it is valid before processing
the packet. If skb->len is zero but skb->data is not, such packet is
invalid and should be silently discarded.

Fixes: d24b03535e5e ("nfc: nci: Fix uninit-value in nci_dev_up and nci_ntf_packet")
Reported-and-tested-by: syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d7b4dc6cd50410152534 [1]
Signed-off-by: Ryosuke Yasuoka <ryasuoka@redhat.com>
---
 net/nfc/nci/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index 0d26c8ec9993..b7a020484131 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -1516,7 +1516,7 @@ static void nci_rx_work(struct work_struct *work)
 		nfc_send_to_raw_sock(ndev->nfc_dev, skb,
 				     RAW_PAYLOAD_NCI, NFC_DIRECTION_RX);
 
-		if (!nci_plen(skb->data)) {
+		if (!skb->len || !nci_plen(skb->data)) {
 			kfree_skb(skb);
 			break;
 		}
-- 
2.44.0


