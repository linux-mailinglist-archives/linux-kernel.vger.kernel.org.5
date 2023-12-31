Return-Path: <linux-kernel+bounces-13635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8226E8209C3
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 06:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 230771F22031
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 05:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD9DB65D;
	Sun, 31 Dec 2023 05:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="KYp4vBy8"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDD0A95C
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 05:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1703999051; x=1704258251;
	bh=lFqzWO9IoWJvWf0zvyPqX/iTXV5Tg5hARwJdoUqbE50=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=KYp4vBy8y1jA1fcOQ60rmUC+TkiGIDOXUGAA6ry296whZr8UaibPGJ7vtGg69MNLv
	 ZtkXKuYbqZ8srsu5C5AAMs6oTyOwuMqV1lJbAQl8kIL3BSt7cHF9KwSYjB6tyY2V0Z
	 OSxkOLQCqzIisMeYGnFEYdFCriE6uZzMPWkcfkZrW9QP07RaisEGybyWbFflqySkX4
	 gx1mdBnQwf3X6vkGCjPajDuERTpYxkfbHLQUuUcJQ95PtZtiMB2KdlXtgxtMoK08pp
	 BrRBStg5hVluzJTPSzWiNTxvENQhPKBIXQGEPPnmNuD55JE6FPUFyjCcCMpdheMkuU
	 Njb39fRsZynwA==
Date: Sun, 31 Dec 2023 05:03:58 +0000
To: Kalle Valo <kvalo@kernel.org>, Larry Finger <Larry.Finger@lwfinger.net>, =?utf-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>, Julian Calaby <julian.calaby@gmail.com>
From: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org, linux-kernel@vger.kernel.org, Rahul Rameshbabu <sergeantsagara@protonmail.com>
Subject: [PATCH wireless v2 4/4] wifi: b43: Disable QoS for bcm4331
Message-ID: <20231231050300.122806-5-sergeantsagara@protonmail.com>
In-Reply-To: <20231231050300.122806-1-sergeantsagara@protonmail.com>
References: <20231231050300.122806-1-sergeantsagara@protonmail.com>
Feedback-ID: 26003777:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

bcm4331 seems to not function correctly with QoS support. This may be due
to issues with currently available firmware or potentially a device
specific issue.

When queues that are not of the default "best effort" priority are
selected, traffic appears to not transmit out of the hardware while no
errors are returned. This behavior is present among all the other priority
queues: video, voice, and background. While this can be worked around by
setting a kernel parameter, the default behavior is problematic for most
users and may be difficult to debug. This patch offers a working out-of-box
experience for bcm4331 users.

Log of the issue (using ssh low-priority traffic as an example):
    ssh -T -vvvv git@github.com
    OpenSSH_9.6p1, OpenSSL 3.0.12 24 Oct 2023
    debug1: Reading configuration data /etc/ssh/ssh_config
    debug2: checking match for 'host * exec "/nix/store/q1c2flcykgr4wwg5a6h=
450hxbk4ch589-bash-5.2-p15/bin/bash -c '/nix/store/c015armnkhr6v18za0rypm7s=
h1i8js8w-gnupg-2.4.1/bin/gpg-connect-agent --quiet updatestartuptty /bye >/=
dev/null 2>&1'"' host github.com originally github.com
    debug3: /etc/ssh/ssh_config line 5: matched 'host "github.com"'
    debug1: Executing command: '/nix/store/q1c2flcykgr4wwg5a6h450hxbk4ch589=
-bash-5.2-p15/bin/bash -c '/nix/store/c015armnkhr6v18za0rypm7sh1i8js8w-gnup=
g-2.4.1/bin/gpg-connect-agent --quiet updatestartuptty /bye >/dev/null 2>&1=
''
    debug3: command returned status 0
    debug3: /etc/ssh/ssh_config line 5: matched 'exec "/nix/store/q1c2flcyk=
gr4wwg5a6h450hxbk4ch589-bash-5.2-p15/bin/bash -c '/nix/store/c015armnkhr6v1=
8za0r"'
    debug2: match found
    debug1: /etc/ssh/ssh_config line 9: Applying options for *
    debug3: expanded UserKnownHostsFile '~/.ssh/known_hosts' -> '/home/bina=
ry-eater/.ssh/known_hosts'
    debug3: expanded UserKnownHostsFile '~/.ssh/known_hosts2' -> '/home/bin=
ary-eater/.ssh/known_hosts2'
    debug2: resolving "github.com" port 22
    debug3: resolve_host: lookup github.com:22
    debug3: channel_clear_timeouts: clearing
    debug3: ssh_connect_direct: entering
    debug1: Connecting to github.com [192.30.255.113] port 22.
    debug3: set_sock_tos: set socket 3 IP_TOS 0x48

Fixes: e6f5b934fba8 ("b43: Add QOS support")
Signed-off-by: Rahul Rameshbabu <sergeantsagara@protonmail.com>
---

Notes:
    Changes:
   =20
        v1->v2:
            - Simplified logic to solely just disable QoS for
              bcm4331 (suggested by Michael B=C3=BCsch <m@bues.ch>)

 drivers/net/wireless/broadcom/b43/main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/b43/main.c b/drivers/net/wireles=
s/broadcom/b43/main.c
index 97d8bdeaa06c..effb6c23f825 100644
--- a/drivers/net/wireless/broadcom/b43/main.c
+++ b/drivers/net/wireless/broadcom/b43/main.c
@@ -2587,7 +2587,8 @@ static void b43_request_firmware(struct work_struct *=
work)
=20
 start_ieee80211:
 =09wl->hw->queues =3D B43_QOS_QUEUE_NUM;
-=09if (!modparam_qos || dev->fw.opensource)
+=09if (!modparam_qos || dev->fw.opensource ||
+=09    dev->dev->chip_id =3D=3D BCMA_CHIP_ID_BCM4331)
 =09=09wl->hw->queues =3D 1;
=20
 =09err =3D ieee80211_register_hw(wl->hw);
--=20
2.42.0



