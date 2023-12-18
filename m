Return-Path: <linux-kernel+bounces-3773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 997888170CC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 14:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE4981C23721
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 13:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0384314F63;
	Mon, 18 Dec 2023 13:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="J0EQW107"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDC3129EF3
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 13:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1702907342; x=1734443342;
  h=message-id:subject:from:to:cc:date:
   content-transfer-encoding:mime-version;
  bh=gEzdns6AbQ4AUMf6BKuUSf4VBq0UBBe+qVH4Rxy4SWw=;
  b=J0EQW107Hqgdh1gr3Bww/LYqvH152KYlXd8ze8gtKtzi2imGXoZnjkmh
   QRKvKp0asVJTvpotwwiqIS+diwxdTj7IWhwCwtm/+f9I5rBsdfP78umCY
   Jr5AZg4sdy6m/wM9fOeeK42mzDtO+4uYNfUl2B/76jxz5VpAFiKKEryMh
   vTr7C+wC0o+JM8f9+3TklXzffQyRaLHquLGG9qjPioi0sjGrG0f/zY7HU
   tinmvk3LR3dX7qce0GMXEEI9irs1h0cDDnDkrNO8mIsCqP0foY2z49/zP
   xp1GF+Dd1TBXRJiSOkjrC/FYGwqux19v11WwNLSrcpbs4wiCCLmRf4f1d
   g==;
X-IronPort-AV: E=Sophos;i="6.04,285,1695679200"; 
   d="scan'208";a="34564229"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 18 Dec 2023 14:49:00 +0100
Received: from [192.168.2.128] (SCHIFFERM-M2.tq-net.de [10.121.53.15])
	by vtuxmail01.tq-net.de (Postfix) with ESMTPA id EE8A1280075;
	Mon, 18 Dec 2023 14:48:59 +0100 (CET)
Message-ID: <46a002f7fe894c7c7ed8324e48e9cd226e428894.camel@ew.tq-group.com>
Subject: powerpc: several early boot regressions on MPC52xx
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>,  Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, "Naveen N. Rao"
 <naveen.n.rao@linux.ibm.com>, Anatolij Gustschin <agust@denx.de>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux@ew.tq-group.com
Date: Mon, 18 Dec 2023 14:48:59 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi all,

I'm currently in the process of porting our ancient TQM5200 SoM to a modern=
 kernel, and I've
identified a number of regressions that cause early boot failures (before t=
he UART console has been
initialized) with arch/powerpc/configs/52xx/tqm5200_defconfig.

Issue 1) Boot fails with CONFIG_PPC_KUAP enabled (enabled by default since =
9f5bd8f1471d7
"powerpc/32s: Activate KUAP and KUEP by default"). The reason is a number o=
f of_iomap() calls in
arch/powerpc/platforms/52xx that should be early_ioremap().

I can fix this up easy enough for mpc5200_simple by changing mpc5200_setup_=
xlb_arbiter() to use
early_ioremap() and moving mpc52xx_map_common_devices() from the setup_arch=
 to the init hook (one
side effect is that mpc52xx_restart() only works a bit later, as it require=
s the mpc52xx_wdt mapping
from mpc52xx_map_common_devices(); I'm not sure if there is a better soluti=
on).

For the other 52xx platforms (efika, lite5200, media5200) things are a bit =
more chaotic, and they
create several more temporary mappings from setup_arch. Either they should =
all be moved to the init
hook as well, or be converted to early_ioremap(), but I can't tell which is=
 more appropriate. As a
first step, I would propose a patch that fixes this for the simple platform=
s and leaves the other
ones unchanged.

(Side note: I also found that before 16132529cee58 ("powerpc/32s: Rework Ke=
rnel Userspace Access
Protection"), boot would succeed even with KUAP enabled without changing th=
e incorrect of_iomap(); I
guess the old implementation was more lenient about the incorrect calls tha=
t the kernel warns
about?)

Issue 2) Boot fails with CONFIG_STRICT_KERNEL_RWX enabled, which is also th=
e default nowadays.

I have not found the cause of this boot failure yet; is there any way to de=
bug this if the failure
happens before the UART is available and I currently don't have JTAG for th=
is hardware?

Best regards,
Matthias



--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

