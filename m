Return-Path: <linux-kernel+bounces-37746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC3083B4BC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E468E285E1B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1AE137C4D;
	Wed, 24 Jan 2024 22:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="QocG5xe8"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB9E1E882;
	Wed, 24 Jan 2024 22:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706135599; cv=none; b=MZ9d0N5/LjaUw4GPvt/Y+t0Zag8sb3LYIdBUiwvIaRno84aaWuKCS6lSopRZMBhPTGJtWvKYhVLt+IigKUGsC0e/wTWIus+EWCGRzFUDlHxzqzLFMi93gwcuFX2mIrLohphpZ/HiXkL8fy2/ABx9bgyqBUj+7aZEIrUYAm/20eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706135599; c=relaxed/simple;
	bh=qrDaTsk7HTfc8TrmJHba7pRVGRstI4yMYwXgF2rjUlY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ny3tCSlCJsFenumjcTGT/4uD24y88YSS8NR3/Y7/cCSyffskd6U1eXXW78gy4nmDugQddXUVk9qBR7zm7iX3oU9QeePodvr2bBW/lm6tgTpfKN5i9274Q1FauwRUsZNpHcudw+2Nhod8v+1w5Mehstncm+n+EtmuFris81TULzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=QocG5xe8; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706135558; x=1706740358; i=wahrenst@gmx.net;
	bh=qrDaTsk7HTfc8TrmJHba7pRVGRstI4yMYwXgF2rjUlY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=QocG5xe8JcuBN+Kydmhil3GdAGNCirjPCxAsym2xBAtYF7jzLiDzx3u9znVZ2/sX
	 mMLh43TkkYW7BCPiHfH6e2XpAkyBbO8mSWlahIrAMGDpydBKOxEeeVyin3DmLFNls
	 hPKp47Fuuc7rBVrD7ck0mt7tWN+fTgj1lDMkGkCeN865z6Bk63ZcqO76p5xakwxD+
	 2NtnwhHwGe24hxa8XiJ/3+lieqJ7xImemro9LauvycFTbZskuhHYzEHBFdcKVfXhJ
	 X0Vx+oybsAfDzSklncFKJyz1x+LGwL8tzhOHYeK28szd14Vn1E5IncYq+0eeVGQbF
	 siulkBqY2IAqNwPQwg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.248.43]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5G9t-1r3AVX363h-011BeL; Wed, 24
 Jan 2024 23:32:38 +0100
From: Stefan Wahren <wahrenst@gmx.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	Florian Fainelli <f.fainelli@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH V3 04/14 next] qca_7k_common: Drop unnecessary function description
Date: Wed, 24 Jan 2024 23:32:01 +0100
Message-Id: <20240124223211.4687-5-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124223211.4687-1-wahrenst@gmx.net>
References: <20240124223211.4687-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:haDaJ774AzzypKlRpr+jQwx8oGav0zVwZAc/Q2T11GxpOsacOAO
 a4b8i1YA0My3Ff8GlWQTeQyCxyYN3/e8l6Jukc4mCRzKPT7Jl2VBa8ACqBRnRTy80wsHSAU
 U5zTZxumjiwN9OwYp3ZaSly2CUsT/wnpGMG3NnapHbMlDVCQiUyQpDhIgYK/of0pJR50Fbb
 Hod8ZRaevpb8Sh4JQfKxQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:0GZ4805+wNI=;Zg9tXZn4ciFBgbquN0uYItUapEL
 XlIGVmCCMmJJrRIa/DIJxhP4VwM3K7h5M8N3/GPFlR6TW9qA1tIs/BHk1SQx2LvtFj/T3MKq7
 td0NSpL9sV/8VgKdzYPcCClVcd5owmwi/LETrEn2OwBbWW5Bts6ONrY7wI+IgztKL1+sWQ0YP
 W5Wx7z8fygA7OOGvPdYC4I7A6VjwcKDT2xNbelnwZgNkUazm3y/5fR7FlKASEvlxYVLAF0fQJ
 8FOs3lJPC9367XPHst1BllIM418tfGR679BW7WCc5B443ggIT7UVhRymJGEzqRWx8iIJ6X0fB
 GKlLG0mBy0FIAfTKUhSYlwpypXtIeA9pLFV/hxg3LiG5RRPXyFDnn82SuEo4BIwP4dsL2vZK2
 6984+9TP3UMm3jxbOa+BGDLQBzzWcpIExE/ac81vg4OszMtwZZ+mtdqd1QdaInBW20E0d71Ms
 wNWqj/MySXDel73HXMBsRfhI9fsZW3hIGKgZi4um3kT3/6raWBAxBXf1bMCAa8TD8LPp5qJ2K
 FJV+J/sc6pp7Ig13YHcgRAyYGJZPBulV/oFAQrkfU+ObtLWF1M2b/H7FqdZWzlAjcpThqwYxP
 B4jUBlquellLJCxzomHUIDxTEYhwzdIMhT1eMO4IXnPR+F2U7WZV006bj0UzYqzpPcnOEdQ6Q
 zXo1gP/5UGJub8uqhwxPGjLEcnOuXarS6vQCDMdR8JJJLFv47xll9uNiwamOGxx3wK5oXO8hx
 dTJkuatGUYvmK2s+657ycUcZmkusa7LAtlNxCBPbKkPue3nx2uWFa/zqZvrBQz2Ky/DrhhHUv
 Ap+lgoQCRlDYwMIa50N1/YcmjjW/Mo/nM6OvNWOButXCpsnr5chp3I+H0S1PnylsmdD3izXR8
 EcdNnJ2vCatY2ejiWBO2JR6byBMiz3qcolm/yJMF51schVIs1VbpkVN7ONfj00+z6OTa4V5K8
 Ox0CDDC+ZGQiwUfm4Qj/+P9y+c4=

qcafrm_fsm_decode has the almost the same function description in
qca_7k_common.c. So drop the comment here.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
=2D--
 drivers/net/ethernet/qualcomm/qca_7k_common.h | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/net/ethernet/qualcomm/qca_7k_common.h b/drivers/net/e=
thernet/qualcomm/qca_7k_common.h
index 928554f11e35..71bdf5d9f8d7 100644
=2D-- a/drivers/net/ethernet/qualcomm/qca_7k_common.h
+++ b/drivers/net/ethernet/qualcomm/qca_7k_common.h
@@ -128,17 +128,6 @@ static inline void qcafrm_fsm_init_uart(struct qcafrm=
_handle *handle)
 	handle->state =3D handle->init;
 }

-/*   Gather received bytes and try to extract a full Ethernet frame
- *   by following a simple state machine.
- *
- * Return:   QCAFRM_GATHER       No Ethernet frame fully received yet.
- *           QCAFRM_NOHEAD       Header expected but not found.
- *           QCAFRM_INVLEN       QCA7K frame length is invalid
- *           QCAFRM_NOTAIL       Footer expected but not found.
- *           > 0                 Number of byte in the fully received
- *                               Ethernet frame
- */
-
 s32 qcafrm_fsm_decode(struct qcafrm_handle *handle, u8 *buf, u16 buf_len,=
 u8 recv_byte);

 #endif /* _QCA_FRAMING_H */
=2D-
2.34.1


