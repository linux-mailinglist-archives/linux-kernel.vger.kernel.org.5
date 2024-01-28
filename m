Return-Path: <linux-kernel+bounces-41672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1946A83F632
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4375C1C21B66
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 15:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112641D690;
	Sun, 28 Jan 2024 15:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.guzenko@web.de header.b="oGFND3vc"
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9601F28DD2
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 15:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706457447; cv=none; b=TnB3VAguAee3LuYhsje13DBfrquyEe2jrBwOqLsQ6fK/AW9KjyPKLydH5hHmQLAppv+4N342z+kylPwvwWRXE343bHRw9AaItw8JUBfkFGlcZW1ITnXVbbBM1aTVp9Q2NN1iZWJ//K9qpI6k2vMZUlKkVSpxiBm1u1ju+czjWqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706457447; c=relaxed/simple;
	bh=GFS4F0OefxoOXjJnNopMDwR/bp9rgwp1BO9HRQFGLes=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MY5nqE2yLHlJ6P1DncI7ASH8gqiy1ZrgPRdSSoTKioj5PZQ/O3h4Hc+cMaj1X278ZVUS3bHofjJdFHYETgmOWeUD40bVzd8ENuLLPaGCiz55gZNdvRTl/GeU+u63p9ah9NysKNXlmI7CAnk29W2ITWjRWSIeT4+Wht+8uSqOEVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.guzenko@web.de header.b=oGFND3vc; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1706457436; x=1707062236; i=l.guzenko@web.de;
	bh=GFS4F0OefxoOXjJnNopMDwR/bp9rgwp1BO9HRQFGLes=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=oGFND3vc5jt5BFEIX0PsPmoVix1E06UYyOfec8U87k+8eq1djVxi2EoNryq3tBhr
	 1AYRLV4lk4wksHZ/4tgnm9OdhKmzUvDiw8n+3likow42+/8yzqVcRlMZM/eXxXFAr
	 QYvULxIQC0sjhGyJMUdGvkMNgzBSCSCpCWToyBL+wSx8lnnk3Z5ETZvBhPzeeWjWW
	 AqPKk/+zLnOzxO1Fo97hDr4k/yENcE+JzuUCNh301hnsavAOrhp6eykEzX2P4sS8r
	 zhUopN7OmPxoSFY/3huG3qzbVg/PqeDOib/QJNFin7NcpLdHcMEmFAjhyy8mnwJQN
	 mQA0Lvo7McyaCKhFuQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from luka-spectre.fritz.box ([78.51.251.250]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MRk4e-1reSaU0aaY-00TNem; Sun, 28 Jan 2024 16:57:16 +0100
From: Luka Guzenko <l.guzenko@web.de>
To: tiwai@suse.com
Cc: alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Luka Guzenko <l.guzenko@web.de>
Subject: [PATCH] ALSA: hda/realtek: Enable Mute LED on HP Laptop 14-fq0xxx
Date: Sun, 28 Jan 2024 16:57:04 +0100
Message-ID: <20240128155704.2333812-1-l.guzenko@web.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:I8Fom4DyIjORlkYYIjOgd3x3ac0zGP5cFmWQ1/kwnbPjVWpPew5
 hg+Gy7hpKpHkjoFw8zCAbvXVQjy9+RZIhZWqIxWdmu/LxBdTWrOGPtckt7mEwVoubaOR3oW
 4usUuEgZGPYu+7zPwFCb4udKsmHQHPf0UcLvNiFOkho6DkmzT820blsrNXjuGomYBdoXIme
 T6vqazPYITvaI2byUjwKQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HTLPyXCyhFs=;cPQ3PlqVxSG6pIMGL/NTeirKysV
 EWvM4gq+Ac5F6a5AAas5JG4jMbZZMkpcg9yvL+oKnBaNM9huN8cdSsChr/jYK7rkyVYpOQkfH
 QFXaHKjVgR2I+K30UP3XJFLPuo55OFVhOiNkd0mJ/Q3FuVz7Ol6y6Ec7vnD6YbQVvf3jsxqP3
 m+TVrPpWBMCAoC19oLBaLeu/yoen1vrcLphEmRuCJ378nRgsi2yP+HncAn4OHP+1xI0VCylQp
 pXBMvyn/BsnaAid1g5eApBw9T5g/Ol1TwpsndnzZ5t0U/UJIQohiffwDoJVy1qcq/Cu7xFnJn
 0rWD+KfyTyln+82rjbOAnhxB/mvEEL/wB/Dk6EyJjfpJE37yQksbFDzg4rBImL7TUX33SIa8G
 MMZGh73HrJ+UDo3Oggeb53bgaL78+fuQEjY/Z3UTX0gcjlrsVOnTGXIOGUYvyGIoQOgAT5mD/
 gKCfi9Bou2QjU70YlBMU3HMv2ih515BldnkQEXmZwxtWx8xJ6EqU2x6uG1e0XZxX+ZRkMop02
 s/zW7TcOFmAVgZqDqidE2w6XZ9mkuntMn13CYHS/Ml4ECo19AARSOLIJLph0WVXFAbdfUsmRK
 4S11B5ROS4EeUzSD14nULp+TToafR5NymijBF+0Vxcf+LCKgCvqdGNNx2NYZbhZLoAWGHu8/G
 g1SdLmhp2Ni73KI+KlBbizQkicso+5BtEyU6ktHt4p5i/D5v93Dc860z3rjaOpXQJlzobx5bc
 5Ea14zGbMPtXNkCtSBhCPfzb3ZrDeLFZ/FOTsmbLgwdNLwclYuSNp4ZxDWzN6BJgRBEuZYequ
 oSTd4x8BKfsVx9xa9A/sjr+JS8MOoqXRn+T5+8Gb+Bs2Z+X8lZoD9y/sLGFgesld5hk4vJilq
 +S+i3CsD3SNIg76C26VqHDc4fd7MLDyuaj01q7l1wjfABQNMNh1bZEt3atqQaS5+5gRMQEL9A
 TCSnLXHmktQlzfO1/akmBcg6VTw=

This HP Laptop uses ALC236 codec with COEF 0x07 controlling the
mute LED. Enable existing quirk for this device.

Signed-off-by: Luka Guzenko <l.guzenko@web.de>
=2D--
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index f6f16622f9cc..0d2fbb8b24b3 100644
=2D-- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9852,6 +9852,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[]=
 =3D {
 	SND_PCI_QUIRK(0x103c, 0x8786, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8787, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8788, "HP OMEN 15", ALC285_FIXUP_HP_MUTE_LED),
+	SND_PCI_QUIRK(0x103c, 0x87b7, "HP Laptop 14-fq0xxx", ALC236_FIXUP_HP_MUT=
E_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x87c8, "HP", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87e5, "HP ProBook 440 G8 Notebook PC", ALC236_FI=
XUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x87e7, "HP ProBook 450 G8 Notebook PC", ALC236_FI=
XUP_HP_GPIO_LED),
=2D-
2.43.0


