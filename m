Return-Path: <linux-kernel+bounces-13376-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FB982042D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 10:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0984282130
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 09:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CD723C4;
	Sat, 30 Dec 2023 09:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="BJJLiWk/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E64522D;
	Sat, 30 Dec 2023 09:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1703929627; x=1704534427; i=markus.elfring@web.de;
	bh=GMs2AVW2tBxrY1cqGnNO0p1p+ejcs3wt5swaa17M8Ms=;
	h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
	b=BJJLiWk/mbLZLmwSf9sX03bZ17ZDQbChKauFsiexn9TjJaIw7DdZcq4w7lQnCqOn
	 cFTS59htgk7ykh95PX+TzecV+aPD84vURal9xt3bW6In6wLu4PJ36sUCvg7WosuiC
	 xBPEEKN2fjlHexdSo9ojfIlsWWXdMPyQgQ880WsXQhkOcOJslSJ0LoPlEc947NIRO
	 Fu4FAN6SaTdrvWDAlfeX5wsw78MVkBj7482Q95NfeOLwFKNHTyhEIYNvV6y4xzYol
	 wPFrtjFLfPinKjg0CJScOJ8kXRAfAGdJyfA+3gb5erNGD+kX0zYIOwwqIsRI6Mwg/
	 LL7bxLDL8beqP11ZVA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiuOW-1qnUZ51ov6-00f17H; Sat, 30
 Dec 2023 10:47:07 +0100
Message-ID: <9e415e37-a5bf-459f-8b9c-a02431e8fcfd@web.de>
Date: Sat, 30 Dec 2023 10:47:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 kernel-janitors@vger.kernel.org, Paulo Alcantara <pc@manguebit.com>,
 Ronnie Sahlberg <lsahlber@redhat.com>, Shyam Prasad N
 <sprasad@microsoft.com>, Steve French <sfrench@samba.org>,
 Tom Talpey <tom@talpey.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Subject: [PATCH] smb3: Improve exception handling in allocate_mr_list()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lDb7IcjYgBLfG8EuKhdeSTkwDqhLg/3gRRrk4elDkaVQbGNzQ5r
 ixGGqPvxmdc8s3Q2GidDRQQcb8IPSx2RcQTKl0ijg0X1l/hLMFoCn3GqWOVRi+na5HjqRJt
 aQFnrJtkLoOPZWr921rHmohcvOWlLeSiS9iQN2AS/waQt85x481kiQPpzZC4MmaMZTCArPT
 0e94FZLBooZv5v4HkXMVw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EsAHDhYQdgc=;Eqlz2JfG0la3g86X0JV40k/BH8q
 ynQGpcjQ/yiQ6SDKyEz4LFpqfkD4joGcozanBVZ2VFiQKzXQRlbYrler90PI6tKZuBwSt/R2u
 LY2Qd3zGmtPdgfdPKg8YuMVuAAbpxvp0BPvMRzmkyvgpmNQI6l5/GrmzEgO5847NlzHOv+hPY
 prpGW5gpf5Zch2uart2QVtv7yo3oO6gUqiBxH9Bpl1HB2tXMF7D2OYFM/P5rzfaXjMvzRN865
 HxSmMWp73h5wq0m7xcY+Tr+O/gIr+3l1ZejZupcqxsOipsiVAV6QdJkHcdBzf+GK5gcetLDkY
 Vo1ObWYn3CQJJ4rbVgiLAus7D08YgxXt5KlQJjyvPKOI5aCloMfwEUlK6afXOus/HirO1wlYW
 8xUgPrrTkjhyuGCi7Md75a754YtGQH2f4Xd7ZbFh70hujt1A0JQVN+WpX6zjA0W6MYGjjSFHw
 SBTV3wSt5hNnKp+raoBOr6YeveSuwl8jEKJA9/Clr7i3M9wzRWvNhJRuoQc0P04n42FAE6g1r
 nIqRqjEFaKzJBn1Xf3HjJgZRyGBhjOZKcMGLFaBLFD3ZHuNAIs25aanQNqPt4uSojHzspP4V2
 fnWALsR7Sd1m40OVm9IGIiNU/CaIarHY8uuTBhTsUb4+lxuBAvjxYxaCWQk2b1u+DCtYRupAy
 h2p2F9ovhH5GT0oyQ2wzWV2cryKHhtoFH2vr0DSVO+nbeem1QxN/ZqDCPem8XZ0XVVhlfjsBz
 f9Cl48HOZeGj4gvYn5GFvzdM7/YQB8+UpFrcj5OH7JUSRtgdXoiLbmfiop4wUb8gSkEs595va
 QZlAJbM1qPJJfqcTezUT1O2an8c7cYYihEMxtHh3WezNmNI17FW8dKFTkV4hLwhfGh92ftwL+
 VuyS6Pl5yFaRWmWLo59UdrVDBfy6Y/GkZbWTL2cClLxh+XXKF41+qtUvxLRO3ko87mBcIhq48
 NPDaAQ==

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 29 Dec 2023 20:43:12 +0100

The kfree() function was called in one case by
the allocate_mr_list() function during error handling
even if the passed variable contained a null pointer.
This issue was detected by using the Coccinelle software.

Thus use another label.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 fs/smb/client/smbdirect.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index 94df9eec3d8d..d74e829de51c 100644
=2D-- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -2136,7 +2136,7 @@ static int allocate_mr_list(struct smbd_connection *=
info)
 	for (i =3D 0; i < info->responder_resources * 2; i++) {
 		smbdirect_mr =3D kzalloc(sizeof(*smbdirect_mr), GFP_KERNEL);
 		if (!smbdirect_mr)
-			goto out;
+			goto cleanup_entries;
 		smbdirect_mr->mr =3D ib_alloc_mr(info->pd, info->mr_type,
 					info->max_frmr_depth);
 		if (IS_ERR(smbdirect_mr->mr)) {
@@ -2162,7 +2162,7 @@ static int allocate_mr_list(struct smbd_connection *=
info)

 out:
 	kfree(smbdirect_mr);
-
+cleanup_entries:
 	list_for_each_entry_safe(smbdirect_mr, tmp, &info->mr_list, list) {
 		list_del(&smbdirect_mr->list);
 		ib_dereg_mr(smbdirect_mr->mr);
=2D-
2.43.0


