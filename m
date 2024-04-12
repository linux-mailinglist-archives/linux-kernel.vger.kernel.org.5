Return-Path: <linux-kernel+bounces-142101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 317B18A2789
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53CC21C21487
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DE24D58A;
	Fri, 12 Apr 2024 07:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b="jUZwrqq+"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32AB46558
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712905223; cv=none; b=fZAmSxkrNKaOx/VY+5Hck51ovJgNvT+2i3P7sQCrkwghj5YPUEHx/ojtJq5KyU3sDgSpr/diln9ispxyclMeLzusul0eJFwM5+rct1IOY2briuVQLq/7FgqrbG8mWByhg+rpr+WxuARJdMx+PWl3q07oByZoNbry4k5oFchSF/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712905223; c=relaxed/simple;
	bh=W6lIJ87blDFQy40/MQCUjdNhysk/lUYI3a/UQNiuRTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u3Rje2vYXALGTumYPIWhzfWtpthFKuBXpGjIUyHuToUulZ0GgZfEIerw86Yl8SkX3ZtYnMz6ExtNnaHBiEWuTwxHZte4sd8Z3wmyXZALzT+y86ud7k92L6LfTpU3eedMU7Y7ws0NIaZNR1mLC/LnPQCsC5XgF4u3QwzN0WC/K10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com; spf=none smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20230601.gappssmtp.com header.i=@smartx-com.20230601.gappssmtp.com header.b=jUZwrqq+; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2a3095907ffso364204a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 00:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1712905210; x=1713510010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7q5h9HaG/VUM+RDE7dhrzmPiovNSzJaDim+39mVuIWQ=;
        b=jUZwrqq+7mkwImCjEQ6XBE9Xm4QzuoVaBzE558ccPUSdGiBeeKEzQJ7Yn3qJfoghxc
         B8Pm8NMlIv1Nh/OgNkgwJtSVFRft8U2nDrRs+9jDgjO/IIqMuQmK6CXgz4g1oknfL194
         TkvA4pCImcQ/e8YnLUHbvKOW7InCpVuCLiXhqfY1BteZ34QjjWEnk0j+UnEeuYirWX7X
         znB8zucWocBA+0G00eDiYwFeRJ3NfSuxulIV1hEhIkAYI/LJ7Bne00kafETqwBvrVl9m
         Ce3S4H9+kmUrA6euD/y2P0VeJxYkFArRUb3TqAU6py43y7STjHnpHa9KnA2p+aMx3lf4
         tSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712905210; x=1713510010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7q5h9HaG/VUM+RDE7dhrzmPiovNSzJaDim+39mVuIWQ=;
        b=eQokfmp/ZSHtc2SBLmqJ/R0rJZQltkFiCWaO6vYYJ3UDLbJ2I+K+T+Lef49eihnzEC
         kISoxrt2FwF0BLUB0nYX2C+bESHccdZTVBPucHJR96RJq+D6Nh9dtRhqdiCMjtxJvk6Z
         +2jj7B8tq73clXGNNBTLQGDSVx+jGcOmNFnDz6KhKcZ+A71bDxqBJ3dxn6JLmwAnusuS
         H5dLwS4TddpGGh/ppanTa0FDSDVBxyXyUqwj/v+xsYuQSZcSMzxs1oLA7uIZToQaci41
         f7f40SGF1FGciXV/Ksd9BnDqTQ9irmWo1AEIOrMA9fh/w/qdgxwQ2kkw/j7YpLLFdJlX
         8Ymw==
X-Forwarded-Encrypted: i=1; AJvYcCU1SYiPMJnuJ2Upv8KKI6bKPbcbfZ4gm8JsLA3EF0pF2m40W5pbx2jpZIRQqx7CvY2U5ZhObnAFUINzUV5mWsi3bLxqtBYMlzHw+2qb
X-Gm-Message-State: AOJu0YxU88NYmbiGo4QAt0zf16PQUTd/exvvbpzxVd12DBRdab4xaxRm
	zJuik25IC3iCrDhtZIXFAo7/GnL7iEG9wmW7zIApk84BLlXYPXVJkDHgCNI/GB4=
X-Google-Smtp-Source: AGHT+IFfdDdH61r019wJzHLaeIy7ZbF0voE9uBIuHh1wTgvCSppeDlW3ZpGOwHe3V43VZiGNPVDoWQ==
X-Received: by 2002:a17:90a:ac10:b0:2a4:92a3:d9dc with SMTP id o16-20020a17090aac1000b002a492a3d9dcmr1589097pjq.22.1712905208687;
        Fri, 12 Apr 2024 00:00:08 -0700 (PDT)
Received: from localhost.localdomain ([8.210.91.195])
        by smtp.googlemail.com with ESMTPSA id y1-20020a17090a1f4100b002a5e73ba87dsm2371147pjy.6.2024.04.12.00.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 00:00:08 -0700 (PDT)
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
Subject: [PATCH net-next v3] net:tun: limit printing rate when illegal packet received by tun dev
Date: Fri, 12 Apr 2024 02:58:39 -0400
Message-ID: <20240412065841.2148691-1-lei.chen@smartx.com>
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

Fixes: ef3db4a59542 (\"tun: avoid BUG, dump packet on GSO errors\")
Signed-off-by: Lei Chen <lei.chen@smartx.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>

Changes from v2:
https://lore.kernel.org/netdev/20240410042245.2044516-1-lei.chen@smartx.com/
 1. Add net-dev to patch subject-prefix.
 2. Add fix tag.

Changes from v1:
https://lore.kernel.org/all/20240409062407.1952728-1-lei.chen@smartx.com/
 1. Use net_ratelimit instead of raw __ratelimit.
 2. Use netdev_err instead of pr_err to print more info abort net dev.
 3. Adjust git commit message to make git am happy.
---
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


