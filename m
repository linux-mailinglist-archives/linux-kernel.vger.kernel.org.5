Return-Path: <linux-kernel+bounces-144040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9478A4125
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 10:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 759C61C212AD
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 08:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC3A225DD;
	Sun, 14 Apr 2024 08:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="wN8NwpPp"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDD8208AD
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 08:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713082705; cv=none; b=mHqrNGTHuhN2mLCr5Fm/1njKB/6627uysppfgpikFbRQL6Rr1kzJBaNvMUwOOpa94Iv8dtYOGooBBFIUrSHSMS9FG30ld3Cx8+mBtUyHRxN0JvANWO+pd2sAwZNokQ1tkuITj82rXhGPzUaNmolHkZY1JZRFzpyFvVAGWHKEQfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713082705; c=relaxed/simple;
	bh=9gbB2V+XRKA4BUsb4k+PNhZDgg72q7XI2/1GSg9K8Qc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DmhJh7wKf7TufruTlK+FJSOzvelR6RzkkkfLRdfLKeQWFgF852wfKn7FSqJMYuzrv/EpzEJxx69Lr1XYZpm0b5qFreS/+GQuPOBbBONAdEjsUryQwWvAXAmIdQbEchJEMDwR0tr4LBi/MeEi1hhTc4so8N/Ky6ItJx6dY3NZREg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=wN8NwpPp; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2a2d0ca3c92so1395818a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 01:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1713082702; x=1713687502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NqdYOjaGRi8Ao/HBdeRS83wqPYe36FAKk8geF0dSUP0=;
        b=wN8NwpPpOf/kdfJg6+64aoLwvuCUxWS9TeoI/07bpxi8O0dIpTBh3a64Rs6qmM13+q
         hjOXWXAZUMyzQgLWWIVghIR6gqEMX4V2z6nZUhhOKJ48rKopE7Z8yJGr5IfL+V6B5hET
         8HAkRWBKVrR2NVJ+WukEoJGWej4Z9cmhD0CxYiLzWTVo7JskyXrp90/6mloVVYTt57e8
         2sxp8nApAX3OkKZzEnHr29JWDK3VC4CuIdDvBrqBuncE0SWPSGH54nVJIcpeIA0SbWV1
         rKlGgWW6kKd/Pta0IPrweXNVBBM/u36R2HWH05422SpZiqgHp/ifWknNA0oGbUYQKUF/
         I5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713082702; x=1713687502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NqdYOjaGRi8Ao/HBdeRS83wqPYe36FAKk8geF0dSUP0=;
        b=CMq+qJ1MnSmzlHSRhSODkJQB4PIThwiIL9NQzHuJ5SbrC082uUncPCl/TYuawZ83M7
         xK6Tga3ce2/MQ8vPU2bxId7nr+XmI19ddrUApXhTTmHGKIsNRDYHPMJCYNT5Wp+h8EI5
         0UINwDmRiCBYrWdZt3ot7D3M6Fl+6tPZ0S0qmFTVAwLG4TL6wwVcDIDV+ArOHz7zvQlH
         6K29WoDpwf8d0oMtj0kQqqp+v9gVzgwSRVPBXZFqu3cVHLpHf9y3W0YfHD/l99Q890W4
         e6JNzYF1u7MaV2PbTkv/yvvbaJakYEDDotBLB/OVtptvvASoMsXHdLg9RRikADxSmhf/
         5IBA==
X-Forwarded-Encrypted: i=1; AJvYcCWIbb/hXBtVC6md92gJAPw5tYVpBx0u3dslq21fis1Mc53MflQHwG3ahsH6MAG5ZNLIJ1fhfRYOvE+pOJHWlWI0Vd9GrZ6N7LcCKJnR
X-Gm-Message-State: AOJu0YwjVM+or5hRdsLbFHhOwbwBwIzl4vU6mmRZzgpvUk88yENKVKZc
	KXjauKtsJ8afy8eLVPMGd2sJNFd4gseIa8vIOh+eEy6NFSC3IQlXhfNPJ4nBXNE=
X-Google-Smtp-Source: AGHT+IEQ7LOjl1eC1hy0XG7j2jZZeucoi3B0IntyqmOMGYmfCkf/CDiZjWHDIgUg2CF23GpuQ4SHZw==
X-Received: by 2002:a17:90b:1244:b0:2a1:64a:bb63 with SMTP id gx4-20020a17090b124400b002a1064abb63mr9435927pjb.2.1713082701943;
        Sun, 14 Apr 2024 01:18:21 -0700 (PDT)
Received: from localhost.localdomain ([8.210.91.195])
        by smtp.googlemail.com with ESMTPSA id bx33-20020a056a02052100b005f0bc6d04adsm4440543pgb.46.2024.04.14.01.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 01:18:21 -0700 (PDT)
From: Lei Chen <lei.chen@smartx.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"Michael S. Tsirkin" <mst@redhat.com>
Cc: Lei Chen <lei.chen@smartx.com>,
	Willem de Bruijn <willemb@google.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4] tun: limit printing rate when illegal packet received by tun dev
Date: Sun, 14 Apr 2024 04:18:05 -0400
Message-ID: <20240414081806.2173098-1-lei.chen@smartx.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost_worker will call tun call backs to receive packets. If too many
illegal packets arrives, tun_do_read will keep dumping packet contents.
When console is enabled, it will costs much more cpu time to dump
packet and soft lockup will be detected.

net_ratelimit mechanism can be used to limit the dumping rate.

PID: 33036    TASK: ffff949da6f20000  CPU: 23   COMMAND: "vhost-32980"
 #0 [fffffe00003fce50] crash_nmi_callback at ffffffff89249253
 #1 [fffffe00003fce58] nmi_handle at ffffffff89225fa3
 #2 [fffffe00003fceb0] default_do_nmi at ffffffff8922642e
 #3 [fffffe00003fced0] do_nmi at ffffffff8922660d
 #4 [fffffe00003fcef0] end_repeat_nmi at ffffffff89c01663
    [exception RIP: io_serial_in+20]
    RIP: ffffffff89792594  RSP: ffffa655314979e8  RFLAGS: 00000002
    RAX: ffffffff89792500  RBX: ffffffff8af428a0  RCX: 0000000000000000
    RDX: 00000000000003fd  RSI: 0000000000000005  RDI: ffffffff8af428a0
    RBP: 0000000000002710   R8: 0000000000000004   R9: 000000000000000f
    R10: 0000000000000000  R11: ffffffff8acbf64f  R12: 0000000000000020
    R13: ffffffff8acbf698  R14: 0000000000000058  R15: 0000000000000000
    ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
 #5 [ffffa655314979e8] io_serial_in at ffffffff89792594
 #6 [ffffa655314979e8] wait_for_xmitr at ffffffff89793470
 #7 [ffffa65531497a08] serial8250_console_putchar at ffffffff897934f6
 #8 [ffffa65531497a20] uart_console_write at ffffffff8978b605
 #9 [ffffa65531497a48] serial8250_console_write at ffffffff89796558
 #10 [ffffa65531497ac8] console_unlock at ffffffff89316124
 #11 [ffffa65531497b10] vprintk_emit at ffffffff89317c07
 #12 [ffffa65531497b68] printk at ffffffff89318306
 #13 [ffffa65531497bc8] print_hex_dump at ffffffff89650765
 #14 [ffffa65531497ca8] tun_do_read at ffffffffc0b06c27 [tun]
 #15 [ffffa65531497d38] tun_recvmsg at ffffffffc0b06e34 [tun]
 #16 [ffffa65531497d68] handle_rx at ffffffffc0c5d682 [vhost_net]
 #17 [ffffa65531497ed0] vhost_worker at ffffffffc0c644dc [vhost]
 #18 [ffffa65531497f10] kthread at ffffffff892d2e72
 #19 [ffffa65531497f50] ret_from_fork at ffffffff89c0022f

Fixes: ef3db4a59542 ("tun: avoid BUG, dump packet on GSO errors")
Signed-off-by: Lei Chen <lei.chen@smartx.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
Changes from v3:
https://lore.kernel.org/all/20240412065841.2148691-1-lei.chen@smartx.com/
 1. Change patch target from net tun to tun.
 2. Move change log below the seperator "---".
 3. Remove escaped parentheses in the Fixes string.

Changes from v2:
https://lore.kernel.org/netdev/20240410042245.2044516-1-lei.chen@smartx.com/
 1. Add net-dev to patch subject-prefix.
 2. Add fix tag.

Changes from v1:
https://lore.kernel.org/all/20240409062407.1952728-1-lei.chen@smartx.com/
 1. Use net_ratelimit instead of raw __ratelimit.
 2. Use netdev_err instead of pr_err to print more info abort net dev.
 3. Adjust git commit message to make git am happy.
 drivers/net/tun.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 0b3f21cba552..ca9b4bc89de7 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2125,14 +2125,16 @@ static ssize_t tun_put_user(struct tun_struct *tun,
 					    tun_is_little_endian(tun), true,
 					    vlan_hlen)) {
 			struct skb_shared_info *sinfo = skb_shinfo(skb);
-			pr_err("unexpected GSO type: "
-			       "0x%x, gso_size %d, hdr_len %d\n",
-			       sinfo->gso_type, tun16_to_cpu(tun, gso.gso_size),
-			       tun16_to_cpu(tun, gso.hdr_len));
-			print_hex_dump(KERN_ERR, "tun: ",
-				       DUMP_PREFIX_NONE,
-				       16, 1, skb->head,
-				       min((int)tun16_to_cpu(tun, gso.hdr_len), 64), true);
+
+			if (net_ratelimit()) {
+				netdev_err(tun->dev, "unexpected GSO type: 0x%x, gso_size %d, hdr_len %d\n",
+				       sinfo->gso_type, tun16_to_cpu(tun, gso.gso_size),
+				       tun16_to_cpu(tun, gso.hdr_len));
+				print_hex_dump(KERN_ERR, "tun: ",
+					       DUMP_PREFIX_NONE,
+					       16, 1, skb->head,
+					       min((int)tun16_to_cpu(tun, gso.hdr_len), 64), true);
+			}
 			WARN_ON_ONCE(1);
 			return -EINVAL;
 		}
-- 
2.44.0


