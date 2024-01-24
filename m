Return-Path: <linux-kernel+bounces-37395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CF383AF38
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC86A28B848
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959FD823A2;
	Wed, 24 Jan 2024 17:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eckTCup/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9047E58B;
	Wed, 24 Jan 2024 17:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115982; cv=none; b=a0yXHEKMHNOOb1Y4vayspR4mtoF6ZPfGXppMSCT5Z8bYSXGqwEltHc5VqkGt33kFtVa8h8r7M/wy9P9qrdlhompHJEx2N7j424U/JojVzvOczwdDsbejqFJfdVo9hu4RAQcrDjNJGIdRSOJ+UdTId/UzisfuSx16EK+rQph5yvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115982; c=relaxed/simple;
	bh=U7lCqVMGrtZDU6zhviF7Qx9nA+uvNFyijhmN2Y2H6Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YH8XUpbSuPU7QttBH6d9vwFEzXe3nMNCqbgoUXZkVoIOKBfFnhWVd/UTUEX/Ds+JLK33/3JR5oJARszSHtqP9B5VOpVJGCehqs1U6bH36e4+zJfj7colmpNgG4f7oWSjkHedklL3LCvWtuoNKFOT8rVvDJ1hMvDbvqIfjlgpuvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eckTCup/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76181C43390;
	Wed, 24 Jan 2024 17:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706115982;
	bh=U7lCqVMGrtZDU6zhviF7Qx9nA+uvNFyijhmN2Y2H6Ho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eckTCup/fuIPxn2crgJaj4gUoyjChf1g4b1ZkHRaYiimKr+gruOeLtJnF6g/QzcTc
	 zJ8avrQcv/vifQym+rneVJMZgtSBzjW+0D3D0z1ilUJaC83oie/hHE4A464o3vCZty
	 ev/Ka3iwZRO9st3SibCZBdUMvCUrZJTIn6OKD+N9RGMNVC9ypAGiLOVWQWrJY58fTD
	 zwbzkT3pjaCCFxAyI4/+xFNPGJE4Q2UXVd6z5RW979ITYpaly9awX4MkoUGtOarCWU
	 DOxJi0JJoZvK7HVhXLQMlCc0Vju5WRRY89P1xh0VGLFk5PpqPZgFvZsEQUz/5745Ne
	 b9ADjyqHLnv0w==
Date: Wed, 24 Jan 2024 09:06:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Danielle Ratson <danieller@nvidia.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
 <davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>,
 "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "sdf@google.com"
 <sdf@google.com>, "kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
 "maxime.chevallier@bootlin.com" <maxime.chevallier@bootlin.com>,
 "vladimir.oltean@nxp.com" <vladimir.oltean@nxp.com>,
 "przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
 "ahmed.zaki@intel.com" <ahmed.zaki@intel.com>, "richardcochran@gmail.com"
 <richardcochran@gmail.com>, "shayagr@amazon.com" <shayagr@amazon.com>,
 "paul.greenwalt@intel.com" <paul.greenwalt@intel.com>, "jiri@resnulli.us"
 <jiri@resnulli.us>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, mlxsw <mlxsw@nvidia.com>, Petr Machata
 <petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>
Subject: Re: [RFC PATCH net-next 9/9] ethtool: Add ability to flash
 transceiver modules' firmware
Message-ID: <20240124090620.69af41a6@kernel.org>
In-Reply-To: <DM6PR12MB45169D23F12F3680FF8E07F8D87B2@DM6PR12MB4516.namprd12.prod.outlook.com>
References: <20240122084530.32451-1-danieller@nvidia.com>
	<20240122084530.32451-10-danieller@nvidia.com>
	<20240122210534.5054b202@kernel.org>
	<DM6PR12MB45168E425B2C1832F6D26453D8742@DM6PR12MB4516.namprd12.prod.outlook.com>
	<20240123074955.72c27eb0@kernel.org>
	<DM6PR12MB45169D23F12F3680FF8E07F8D87B2@DM6PR12MB4516.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 24 Jan 2024 15:46:55 +0000 Danielle Ratson wrote:
> > > The file_name parameter is not really needed inside the work. Once we
> > > called request_firmware_direct(), we have all that we need in
> > > module_fw->fw. Do we still need to avoid that situation? If so, can
> > > you please suggest how? =20
> >=20
> > I'd pass it to module_flash_fw_schedule() as a separate argument, if it=
 doesn't
> > have to be saved. =20
>=20
> It doesn=E2=80=99t make the module_fw->file_name attribute redundant?

This is what I mean:

diff --git a/net/ethtool/module.c b/net/ethtool/module.c
index 69cedb3ede6d..ea048a7089d9 100644
--- a/net/ethtool/module.c
+++ b/net/ethtool/module.c
@@ -229,7 +229,7 @@ static int module_flash_fw_work_init(struct ethtool_mod=
ule_fw_flash *module_fw,
 }
=20
 static int
-module_flash_fw_schedule(struct net_device *dev,
+module_flash_fw_schedule(struct net_device *dev, const char *file_name,
 			 struct ethtool_module_fw_flash_params *params,
 			 struct netlink_ext_ack *extack)
 {
@@ -254,8 +254,7 @@ module_flash_fw_schedule(struct net_device *dev,
 		return -ENOMEM;
=20
 	module_fw->params =3D *params;
-	err =3D request_firmware(&module_fw->fw, module_fw->params.file_name,
-			       &dev->dev);
+	err =3D request_firmware(&module_fw->fw, file_name, &dev->dev);
 	if (err) {
 		NL_SET_ERR_MSG(extack,
 			       "Failed to request module firmware image");
@@ -288,6 +287,7 @@ static int module_flash_fw(struct net_device *dev, stru=
ct nlattr **tb,
 			   struct netlink_ext_ack *extack)
 {
 	struct ethtool_module_fw_flash_params params =3D {};
+	const char *file_name;
 	struct nlattr *attr;
=20
 	if (!tb[ETHTOOL_A_MODULE_FW_FLASH_FILE_NAME]) {
@@ -297,8 +297,7 @@ static int module_flash_fw(struct net_device *dev, stru=
ct nlattr **tb,
 		return -EINVAL;
 	}
=20
-	params.file_name =3D
-		nla_data(tb[ETHTOOL_A_MODULE_FW_FLASH_FILE_NAME]);
+	file_name =3D nla_data(tb[ETHTOOL_A_MODULE_FW_FLASH_FILE_NAME]);
=20
 	attr =3D tb[ETHTOOL_A_MODULE_FW_FLASH_PASSWORD];
 	if (attr) {
@@ -306,7 +305,7 @@ static int module_flash_fw(struct net_device *dev, stru=
ct nlattr **tb,
 		params.password_valid =3D true;
 	}
=20
-	return module_flash_fw_schedule(dev, &params, extack);
+	return module_flash_fw_schedule(dev, file_name, &params, extack);
 }
=20
 int ethnl_act_module_fw_flash(struct sk_buff *skb, struct genl_info *info)
diff --git a/net/ethtool/module_fw.h b/net/ethtool/module_fw.h
index 969de116f995..888f082f8daf 100644
--- a/net/ethtool/module_fw.h
+++ b/net/ethtool/module_fw.h
@@ -13,12 +13,10 @@ void ethtool_cmis_fw_update(struct work_struct *work);
=20
 /**
  * struct ethtool_module_fw_flash_params - module firmware flashing parame=
ters
- * @file_name: Firmware image file name.
  * @password: Module password. Only valid when @pass_valid is set.
  * @password_valid: Whether the module password is valid or not.
  */
 struct ethtool_module_fw_flash_params {
-	const char *file_name;
 	u32 password;
 	u8 password_valid:1;
 };

