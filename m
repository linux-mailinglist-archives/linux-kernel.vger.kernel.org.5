Return-Path: <linux-kernel+bounces-25444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F9882D058
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 11:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 529DA282652
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 10:54:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68EB1FDB;
	Sun, 14 Jan 2024 10:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=erick.archer@gmx.com header.b="oYL6mnaZ"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52797E;
	Sun, 14 Jan 2024 10:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1705229640; x=1705834440; i=erick.archer@gmx.com;
	bh=NvqscB2Ajcq34snKdM9C0SC/kgMq8em8xsX/ESZhuI0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=oYL6mnaZcUBPgRW4lhwHrVSSF1ZVz8dicxM7Jb1QQD/sHCZ7Zp/nW+v/dbZS9PbP
	 mUd4VgOfSk3RTi5NR2QoS7bI8Y81xVmxrgzSgrhj3BwswSvOFH6NhgMAthSmXOPkW
	 PKMAgDB/qPB6uDXnOxXdaD6Ho2Sx1ptbb6wyiiVi93+oZ60pslrlxtle8I3Ule1jp
	 55klY41Cu25YwtI1kQNahHYjUuIzrQQN10NTMOpPjG8ZlrJ2eijNmlTmvpWvIciMw
	 5m7BiKnaWsQYMgFNJOMcGSAVi2jV44pIcwMYd2Ywg2fFtH+pL1YdCoTPnFb5I7uDt
	 Pe2wxdoQ9UvCi1IQMg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([79.157.194.183]) by mail.gmx.net
 (mrgmx005 [212.227.17.184]) with ESMTPSA (Nemesis) id
 1MK3W0-1rjNKD3Cwg-00LXzZ; Sun, 14 Jan 2024 11:53:59 +0100
From: Erick Archer <erick.archer@gmx.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Erick Archer <erick.archer@gmx.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] eventfs: Use kcalloc() instead of kzalloc()
Date: Sun, 14 Jan 2024 11:53:40 +0100
Message-Id: <20240114105340.5746-1-erick.archer@gmx.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZD/CHY3f8YxUcmuXSP/UsOL9TwcrS0cxnqxldgYRKuRielakJvN
 UZUaPvJdD1nEmFf9pmULtagMqRl2eWPOAAgRvDpEDRTCzxDsdrxG8EHZNghUHfqa+E3qCHF
 52EMawhwIahKcCLaeD12tn8fUSrQX9xUNT19uvdVeGmmbqXlxbHd1vfVPkMrrUPzGdHOIhW
 9PoG4N83FtExvS/oUNk+A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:R+04s8OMMks=;5eFZI2q0bx8yuRXSfu6hd4yHemc
 GxFb8R62x6GrSQeZxHJYqcn83Cxa/jRVRlbZqqd1wy92IE6t0RFMLjhYnmVxb86glqNVsGj9G
 iugCzdFaC+9mPxhAm3mgwn7Q9pxx1qq/b234PW8oFnPenPbjWBBsmuLHzpUPwY+O+/IgghwH3
 NamJnA/yvvdykEDifQkEj0GR5RrMS5Nk4LJdPymP9CufLora8F0ohVOSxGVRSGTNMOu8Gp0WZ
 MPGpnO6Ynhw3a04aEdiQO9n7JwRd6mhD1KtkOAZQ5iW7b5ofcC0m9o6hlGSkpFoqrQ38VJzRn
 D+vrzO1j9ZEKG4NfndHaVHSdZ2b4lIKadKRfywj0PhvwmGYIH4gK8BK81WQTJ4fN/pNpbQm1v
 qykeLsjpkWQjHu8NUoFCtqIa4C0wxGYJORz61K40vzMYqBCcMykO/TAbBuYWppnEVTQcjfL8X
 R7qSRuLAupO+UvREWTr1Ipl5baG4VHHGVbMSWoP8iJ6rDtkiT2QQc3Jy6nP50tCmwTMa8xyYy
 vai/NDTt9GL7cS6qf3LgZN5urI6EkwkNv6/8lYmPiROGRqcFt3cmR7NCbRs3NZT50wvzP6VL/
 Cp3OAcjhnQk3OOneMgFoa/5Ehg1gJxQVcxTSlINYVJ/Qq4R47CClh3Y4L/lx27VFENL3Dw1By
 YM4YysGxa8mF1avzPWpjYmcqHxk2+UxxUZsDbrvuR3lja2Ofz/jDT9Z59YIt5Jh/aZeiixajt
 w6zV3dnZLWpGQtjsaHrdLXmFYuV8a2yQzz7kDcbyhZaxkh5ehXX6nH/K+wLRxzZlFPl0479p7
 w36/cEF6G0GaIOeBkU1+mbxyyUy528nB3q3HfV0AsVEx3X3YLhRgcMVEHKtB5xsr8IcRaBIoz
 WgvcF8+A8WNDCYtPbBbo+0E0F4l93SSOWiW6tR55dBVdZCsU/gBP3/HXPirRkCKSnTPmzzBlg
 UoPR1OkehClNwjbCoG/lWEXh46s=

Use 2-factor multiplication argument form kcalloc() instead
of kzalloc().

Link: https://github.com/KSPP/linux/issues/162
Signed-off-by: Erick Archer <erick.archer@gmx.com>
=2D--
 fs/tracefs/event_inode.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index fdff53d5a1f8..f8196289692c 100644
=2D-- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -93,7 +93,7 @@ static int eventfs_set_attr(struct mnt_idmap *idmap, str=
uct dentry *dentry,
 	/* Preallocate the children mode array if necessary */
 	if (!(dentry->d_inode->i_mode & S_IFDIR)) {
 		if (!ei->entry_attrs) {
-			ei->entry_attrs =3D kzalloc(sizeof(*ei->entry_attrs) * ei->nr_entries,
+			ei->entry_attrs =3D kcalloc(ei->nr_entries, sizeof(*ei->entry_attrs),
 						  GFP_NOFS);
 			if (!ei->entry_attrs) {
 				ret =3D -ENOMEM;
@@ -874,7 +874,7 @@ struct eventfs_inode *eventfs_create_dir(const char *n=
ame, struct eventfs_inode
 	}

 	if (size) {
-		ei->d_children =3D kzalloc(sizeof(*ei->d_children) * size, GFP_KERNEL);
+		ei->d_children =3D kcalloc(size, sizeof(*ei->d_children), GFP_KERNEL);
 		if (!ei->d_children) {
 			kfree_const(ei->name);
 			kfree(ei);
@@ -941,7 +941,7 @@ struct eventfs_inode *eventfs_create_events_dir(const =
char *name, struct dentry
 		goto fail;

 	if (size) {
-		ei->d_children =3D kzalloc(sizeof(*ei->d_children) * size, GFP_KERNEL);
+		ei->d_children =3D kcalloc(size, sizeof(*ei->d_children), GFP_KERNEL);
 		if (!ei->d_children)
 			goto fail;
 	}
=2D-
2.25.1


