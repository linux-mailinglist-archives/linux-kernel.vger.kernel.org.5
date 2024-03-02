Return-Path: <linux-kernel+bounces-89320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D9C86EE52
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 04:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CC7C287206
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 03:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B858BFD;
	Sat,  2 Mar 2024 03:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="d7Lreiuv"
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A333D64
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 03:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709350982; cv=none; b=u8F0gBf9JgkpCbGGaskinN0nEKHaFX0KYU6pWw+tJzBYuJwvnEEDevCMvLJARc0GDaGva4PJNhyRXvTvMNcxMpWUizjcsuKCMoTVp6BEjcYQ1h2uZSe+u9mmdf9yqrT++qWR4IiX964HZUxSVAQWF0PA2v+GnR+TKXqKhwVmYSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709350982; c=relaxed/simple;
	bh=742bPY11Sk8b8lbeGaM31HWRtQcw0j4v2EVxT+M1R64=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=q/1zVSc3JyIssdrD94KRHdhpBqRQ5nd8hfF8OiVGuLa5OtDsCTAWdRILa0ThV8i+Bv2pj/fcUhoc3OIH8Ir5TSF2uOZVaQ91k0ORyPVTrr11YcFZBfm5J0gIBWKbx5mUSPFPk3gbmYNvADzwvh3VGJ+30oz31GLjhNQCzi3Aa68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=d7Lreiuv; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1709350969; bh=0KroCWAIlUxLdfBmFYmW3fcQxmNCt0DmBCFbL9RjJnk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=d7LreiuvhfjD/V/v8HfCQqlCjIiS25xMQbvAtVownRdYLNXI/pWyy2gUoiWWb/s8g
	 P0jAU7STYomTFRccQf35Yf/AG4FanHP0K6q35nELb5m2kJ1XkyPqpZY04wh1tfbvBU
	 3C73lnSkRXbV9g7ZlkUMv0OwiVeIK2KQwVGIS+cY=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 92A26EDA; Sat, 02 Mar 2024 11:36:42 +0800
X-QQ-mid: xmsmtpt1709350602tnhlhp424
Message-ID: <tencent_DAEC42CF7878366DC42DD16D289568E95E0A@qq.com>
X-QQ-XMAILINFO: NX3xVHLFGis3Q/IfXLkYFL4geKBlCZjFBGxb+XM/icAjBNX04x7J2hrhsplPgq
	 fwp6/H8HnTiax/HHqibBDWyUCCyTpmbKHzBPoe05ODJexzjbNwajYB7pPpLkGYu6d+wLvP6AvC1F
	 SeRZVhEHDato6km1CeITDYrS6QE31SQ7MKsQjg5U6mU08/S3m/rS/2bL5xEY0cKPjciDQo7RAY6S
	 vEyXs38i9f/nTiE+7HRVBTceyfHoIS9YF/+garooxBkLmtgzHibAD9vZissUu3+nDMG/EV7VuhKt
	 VVk/FRFtgdFMCC3Bn5gSIBt4BZjqGqHpEHUIxgxUrYc56N8OCHTdtMu931nJL7EMphVq5FYdt5XE
	 Z2A+HpC6estvwUBZ7qJ1PxoKoaUGBDnpIS2zIazHiZm9MkihpKPu8uMAVSvDJFV/PP2rEhaNoMNa
	 Jnnq/9Xovd5AhV5ze22VY0Ey69KYYH2zid9K7zCnyiZaqANSaBo1mbsKE6ANbi5DVhnqJMM78Njd
	 lFw2k51oHouaVPIDqxV7OPiFBVVrpMz3gMgw3sAXZtnkhGJk2Duk0+Zjj6gzMNHBu5wFDv3c+mrH
	 PcC7/n1klvNmak4W2PLRdDPzd9blX6XYDvZdOVw3W95ygKoiEMkxpCGzfqssg/BNIHh77U0O6H9X
	 Pz8qNMdLbimiZ6lKawNoY++peMQcwpgXx+2T3ZX1iZS6rImvxZCSGqa8dVsOQjYibKXRcmTJWgS7
	 y7UX2f8oNrqjfDvbvDWxH+VeHt5DTMZ8IC1CLfcOC47nE7cUnAej28HjeaQz/tNWS7kULiaOrIfP
	 oGMuNIThMzj5NsXloaeh0ieJ4+CIyLlTmztXw9Oe6QPTXN4pr0GLKfzUlvOvQHgWBQVhWH8XMbzJ
	 cIs86P5KrcQzDQp65Wej0Ax7yjslETQYtGcwr9GzirCTeWY2ViypX5jyIk7ZyhqM3yPysRw56U
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+d4faee732755bba9838e@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [rds?] WARNING in rds_conn_connect_if_down
Date: Sat,  2 Mar 2024 11:36:43 +0800
X-OQ-MSGID: <20240302033642.2933199-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000c0550506125e4118@google.com>
References: <000000000000c0550506125e4118@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test mp capable for rds

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

diff --git a/net/rds/recv.c b/net/rds/recv.c
index 5627f80013f8..142c289bcf6b 100644
--- a/net/rds/recv.c
+++ b/net/rds/recv.c
@@ -228,6 +228,7 @@ static void rds_recv_hs_exthdrs(struct rds_header *hdr,
 	}
 	/* if RDS_EXTHDR_NPATHS was not found, default to a single-path */
 	conn->c_npaths = max_t(int, conn->c_npaths, 1);
+	conn->c_trans->t_mp_capable = conn->c_npaths > 1 ? 1 : 0;
 	conn->c_ping_triggered = 0;
 	rds_conn_peer_gen_update(conn, new_peer_gen_num);
 }


