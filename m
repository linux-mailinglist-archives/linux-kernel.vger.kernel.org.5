Return-Path: <linux-kernel+bounces-13333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E9B8203A3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 05:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE2551F221C4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 04:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577B68C18;
	Sat, 30 Dec 2023 04:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="SBjnCyE9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F3B187E
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 04:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1703911925; x=1704171125;
	bh=mpfS2FF753ZSOUmOzhDiJSInHt5JGm319qqgU/Wo+a4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=SBjnCyE94BXerPC1PUjPsFByxySTEa5qI51gVNbc9JHxX6ZCqpN3B0AaJWl4I3O7z
	 MtmOrOlga0M7rzSpR0Y04YAxCn2TfxGim7xrzU7qGRdkgxZyFTFpD2qqTIoDhP61l2
	 3jfL7oIQZBfbi5vF6lnmyVx64Bq333HGGfV5htqFulmf5QeJOBotW1P8ReTCkNZy0k
	 M9DcZnEv7kIYcQ2xqiXw6dvVTVP9Z/ktLDG12+wZMRJMPZzUphcc9AEET99Rz8sGCJ
	 IGy+4CKqOC+ReLeDj92E4XPYPSKcQFt508g5N+qaY5BvVlBJzeBN06FDH8l1PFjM18
	 Kt4u8oLfT2pXg==
Date: Sat, 30 Dec 2023 04:51:51 +0000
To: Kalle Valo <kvalo@kernel.org>
From: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org, linux-kernel@vger.kernel.org, Rahul Rameshbabu <sergeantsagara@protonmail.com>
Subject: [PATCH wireless 5/5] wifi: b43: Support advertising lack of QoS capability
Message-ID: <20231230045105.91351-6-sergeantsagara@protonmail.com>
In-Reply-To: <20231230045105.91351-1-sergeantsagara@protonmail.com>
References: <20231230045105.91351-1-sergeantsagara@protonmail.com>
Feedback-ID: 26003777:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add b43_qos_not_supported functionality for disabling QoS. Currently, the
function checks an array to see if the chip id matches a value in the
array. If so, disable QoS.

bcm4331 appears to lack QoS support. When queues that are not of the
default "best effort" priority are selected, traffic appears to not
transmit out of the hardware while no errors are returned. This behavior is
present among all the other priority queues: video, voice, and background.
While this can be worked around by setting a kernel parameter, the default
behavior is problematic for most users and may be difficult to debug. This
patch offers a working out-of-box experience for bcm4331 users.

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
 drivers/net/wireless/broadcom/b43/main.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/broadcom/b43/main.c b/drivers/net/wireles=
s/broadcom/b43/main.c
index b6ac1526c0e8..39906bebef7b 100644
--- a/drivers/net/wireless/broadcom/b43/main.c
+++ b/drivers/net/wireless/broadcom/b43/main.c
@@ -359,6 +359,22 @@ static struct ieee80211_supported_band b43_band_2ghz_l=
imited =3D {
 =09.n_bitrates=09=3D b43_g_ratetable_size,
 };
=20
+static const u16 b43_no_qos_chip_ids[] =3D {
+=09BCMA_CHIP_ID_BCM4331,
+=090,
+};
+
+static bool b43_qos_not_supported(struct b43_wldev *dev)
+{
+=09int idx;
+
+=09for (idx =3D 0; b43_no_qos_chip_ids[idx]; idx++)
+=09=09if (dev->dev->chip_id =3D=3D b43_no_qos_chip_ids[idx])
+=09=09=09return true;
+
+=09return false;
+}
+
 static void b43_wireless_core_exit(struct b43_wldev *dev);
 static int b43_wireless_core_init(struct b43_wldev *dev);
 static struct b43_wldev * b43_wireless_core_stop(struct b43_wldev *dev);
@@ -2587,7 +2603,7 @@ static void b43_request_firmware(struct work_struct *=
work)
=20
 start_ieee80211:
 =09wl->hw->queues =3D B43_QOS_QUEUE_NUM;
-=09if (!modparam_qos || dev->fw.opensource)
+=09if (!modparam_qos || dev->fw.opensource || b43_qos_not_supported(wl->cu=
rrent_dev))
 =09=09wl->hw->queues =3D 1;
=20
 =09err =3D ieee80211_register_hw(wl->hw);
--=20
2.42.0



