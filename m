Return-Path: <linux-kernel+bounces-133200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D9A89A04C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2054C1C2320E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBB216F82D;
	Fri,  5 Apr 2024 14:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="W5ybl//v"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2106.outbound.protection.outlook.com [40.107.6.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0185016DEAB;
	Fri,  5 Apr 2024 14:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712329003; cv=fail; b=P3ROlR+wLpVVyp/xdcinyAkcCTpZCAAT648uQgDV8m1IThfdxQY9WPJgp7LvSgNljsiWT96x+5VXuMwbmBgOkji5SPrxEkM5VuQb5E0nDbaj8nkKqz/jyMNKR+sX5Eh7Vi4dwZqZxNYx3nPdm26BysLQtQSDy5rtY7i0V5nZiwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712329003; c=relaxed/simple;
	bh=epw2LxZpFzc9yQ9shyNLLX9rbxbNSLPXLbzCuqIMFDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C5tHrTm0GdAitjdZrQyN1TN0Ka6odK22Yz3RBZ8Zcbc9+JwqAx5m+YImHkkVk//KjplJwA4hzAIfXbK+k/nZTz4bdym46qkH0LN9puENKEZ34jxJFvv7Bwew5imMFkhxZKQg+HjiTakyUd9oVsV9bH1d4TPZ3hhRodcppoDcFOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=W5ybl//v; arc=fail smtp.client-ip=40.107.6.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaZykAPi091rwj2jtBq7lhshqzxqMmBRtDRmu0vw0LiVmC6BzP7LN1WC46p5VLtRnXzIz2R1lideyT3+Z+vQVQiis5q+GJ87iVuVNTryS3kCE9FNPKp8+G4uPukmES/4Qp8ncrRkThWyPyH3yslT9wzW0+NxNQhAlH29VOOu9al7nH/FuJWHAaZT2ZlvHXsn5busZKEgwYDlI0YKhA5XgGhXYKSJIhDKHDuquDqmycHwAF15q3BHVmV13XchyiKOoy9UM+Tuy9P/hWqTQ+4lO0SEduOAKtLUJ8YNuG5RfRW0BdZc1m4KKl3K+BCvHPwCyCSuPvECoAKNKFyZWx/IbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lKB1I9rieadX3n8EfWXFokd7S0ShQBko+iJ2euZo0lE=;
 b=F58B0UroHH7KYp0j7gt5+oGPzrmYUNrMh69+0xW/aAm1Je8/Yu+P0OKEr5hxj9TILF3YAeriKF6O5Gva1lXekft9ogZ91UjxB5Ou0BUHbxbwDyNXvrRFlsFRVgsgjR+BKgIDr7aYaiBLomJkIxIqW67muN9cxzwJbrdhfpxGYDOI6EjXqyq+75OpGNYnAXt7TZa6vbl6KfkmAcrEt9VYEbEU7QRArEbNVycld5UhzynHmrd7DOCBfWnf/ZucwegjuMmt0/mCQLoaJ2RiUs/h8DVu1h3/FzQF+oUAhqLDOUXm8vDRA6WLG4WwdDUN8bm9QZvDxnTEAJ8qxeVf512HNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lKB1I9rieadX3n8EfWXFokd7S0ShQBko+iJ2euZo0lE=;
 b=W5ybl//vHiKWLIalqYuyH9xl8RDJD7BQ6Kgm8RJfnILBJiILkhoBjhn4FzJqE3WuhGr3mZk5cpNNE6NoaDzGAiJI1nD9zd8KS9FG5FjveDS7HC0mPNB14VcMUNJ2H0qFfpdwDDqB+TSe5Kk70Iqamvym1/Nxxv3jamw0x/Xio4I=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 14:56:38 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 14:56:38 +0000
Date: Fri, 5 Apr 2024 10:56:30 -0400
From: Frank Li <Frank.li@nxp.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	"open list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <imx@lists.linux.dev>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] arm64: dts: imx8qxp-mek: add cm40_i2c, wm8960/wm8962
 and sai[0,1,4,5]
Message-ID: <ZhARHhzZ0mUmMyVw@lizhi-Precision-Tower-5810>
References: <20240404161914.1655305-1-Frank.Li@nxp.com>
 <20240405063648.GA4562@francesco-nb>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405063648.GA4562@francesco-nb>
X-ClientProxiedBy: BYAPR03CA0011.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::24) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB6802:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oMo+2rCDKa9hTCEZO4bpExyaFcuhYuRKtBNdm0tOucPDSyqj0fmZgY50Zw0h1WU0ImFasBjNhr3FvnLMeCVk13T65j0p8R/CE7zgpnANbkypSbmx+e7dKTsUAUkb163+t+2TsFmcN7MT0YZwrfJ3fCJ5cLRgHGI3O0WOYnfNiE1q/pMjEzLLGjVbU7UCD9j8ax6b5TDAWRWydF/AvH2vqzmoRZN+cRUCmoxM31gxoxBE/JqrxjUhvr032V936y+zM5sKUlVd3Wo2fCNe9dRwNXhqqm0EUhVs6G36791bgp0yZs7XSG2ybx9f1tyR+esaUgjblKsAYVJgOxIl51NpFs4AQ4atr32/yM7m8iG9dgN79KH7B0jwRbNvLUgAyv4Jox8tYsE1iaizj6ynKIaQGDsqfekUyROVxbU9Qpj31XPtW+m9TTIwO3LlM/4Ha+56BSTeZk5JfzvG17PT9nAb1Z/m37DT+wywptdhFT0s9ahnuHQP6K0FjOZJPT7DqdbwSDEwCWJbv6xQIUxohMLgkOMMfy4pQBTnLBGf6mBUvDNv8tMhbtHiI/6tcT0KznGDqwrBcCaA0KYowwohV5B+ciVDoDQQSFrjru2FZtNcGrQ0xGygVF0UpWMx0e03E5iiw1Dr/kgLN6SXqp23lcD55ejcDGIF/GdZcCmQ+/qPi/I5cMfFaoZG0xvtmvQqKHu0ieR0pOy9kaCk91kB5jGA9g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(52116005)(7416005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+qJMScozOQF2IzoGNmvDlB5qsAhqjTx7p5QeNspgoPspK8nA9LNHxR3Nk8ns?=
 =?us-ascii?Q?jHqsFNNCVNOCCpm5rfiRVT0g9FVvtdPCWc/ZQXJ3gwMsKffhNGEqNtZk4BIR?=
 =?us-ascii?Q?ORKB2EwC0lTMq86yefL8AjvEHjE2lTFrm7XH35XE+VpuvnG0lwBlRoJ2PuYo?=
 =?us-ascii?Q?1P3bQRygwNOqQuFUgbWhesSSHu5a3fRMXtRhGoJ7XeI4w1PxmiXMZf1T+Le8?=
 =?us-ascii?Q?5TIyDLmnwhSGJDbS3KMUaWSgpEsAeWPAksv/5TEU78kEyHYozR8JckAvc/5A?=
 =?us-ascii?Q?aYtgWeqrZAOGPvvcNIpj3o47/EjBveSra0xsgG0ngKij/ivj5HlgwVRBvNoo?=
 =?us-ascii?Q?qxNjlBZX2ydMfCTfoT+VFK2voK3v4+PmMK2fXzxNx/YGUsDAxIm5WF7TWtyD?=
 =?us-ascii?Q?BJ9r0SyjE/ikcSUmJpBcZ8BmwTH/Ftiu+5LeNRwkJsPfurfGgvbLfaY21Kmz?=
 =?us-ascii?Q?z3DhIsHH15XF+7hXw610aDaJqw1nVGoLsJeM51yeRH3qK4XsXkgoZPcGgmEb?=
 =?us-ascii?Q?zpaC2dfoFtGhl1E6HxGJl54h+USS4DDlUwYU8Qvj1OGda/QgqLbB8xfMrJNL?=
 =?us-ascii?Q?CasYv1C6fNLpPE6zD2FK2QKIb5hTk3zaKvi/QHbtwmr2oz4ankjoPCyDfYix?=
 =?us-ascii?Q?2jQAWR/9RHeoMV52xrp9BxQ0uLdC8HeGfMpqCD1kkVEOnhws0af2/NweF3Vc?=
 =?us-ascii?Q?BwtmJMt15Iho3+j9SkdLXsVRsaCictN66wt6OuMx4HFbs23rnhIBNvdNHdBD?=
 =?us-ascii?Q?XiEqDpGgFxh7HPHbwdC4Trm6JoqpxGOmdRl5hK+xtXmixK3puPF8F8fsByje?=
 =?us-ascii?Q?rZQUY9sNa5YNqtNXUG2MGZbf94oTA4LhpeLN2ofUcluLriACNAShVonciXAG?=
 =?us-ascii?Q?B1wo7E9vl793Z41fjcB76Ij4jlZcBZK4p0+KYsZvXvQy3iLrYUiS5tO4KFti?=
 =?us-ascii?Q?ctRtYRiGLmi0AC4sRh2GKrvMbt6HceSPgjwEEZUy4SBgkWJR259xjYffe1C7?=
 =?us-ascii?Q?qwcC1b7twSf6TnnbWrdZ24+8LVO0Vqf9BGskmZIlUYNTi/aCWx6dpQcNI7Q9?=
 =?us-ascii?Q?1VgOW/nBitVHC7Xe6HfRx5i/mXjIEOSqRZL11VxjREptiquRiaOxjDcRzZA5?=
 =?us-ascii?Q?xhIqVNw7qythcQC/RQh85DAngoYalpKilJFIUlcd/6+++vuxPRA/NXWM/5PP?=
 =?us-ascii?Q?m9Olhv0YDl06piuUpa6twIY4K+Ee5ySzwJpPvL//WEYFLS0D618L3w+DwS0+?=
 =?us-ascii?Q?jwS5SxOcSYDq36yoYhClUjAkp41m7b06KVEXsjMJrQjgMKmZAexDfVSwEHTA?=
 =?us-ascii?Q?6R+iuwuYlVNpmDf5MbmMSLL1meiQ+eGIrxlSTeWutIpQBqwzHTDZORaGd1XW?=
 =?us-ascii?Q?goRxul3FHFU2MdrnqIdchM/xB4nZgtVDjopLA/TcqvdjLHyCFSLfg9kNCfxL?=
 =?us-ascii?Q?/WkLpc20cv6fVOios78ifTosZyaQEpDU8etn1P+SW1BdnWNZx5C9Z6jTPke0?=
 =?us-ascii?Q?v8jjWSjTUvYJ0y8uR3Q9tY0pgVRaLvA4D+fbzJRGD7uyvVXDguq0WWb9weZ9?=
 =?us-ascii?Q?qCCRfoas9iX6//vd+5yQK2a/W5nh5AeUA8ycd+y0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d8fbde-bbaa-4b32-2d74-08dc55809846
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 14:56:38.0027
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pbxlnnoDFewhuBe/AjP6thnosqIRG8Nal+hUL32iwJEx5uYo1JI7j+Lbal40IILD5nxb8NtDvQGK8ePxAmOpdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6802

On Fri, Apr 05, 2024 at 08:36:48AM +0200, Francesco Dolcini wrote:
> Hello Frank,
> 
> On Thu, Apr 04, 2024 at 12:19:13PM -0400, Frank Li wrote:
> > imx8qxp-mek use two kind audio codec, wm8960 and wm8962. Using dummy gpio
> > i2c bus mux to connect both i2c devices. One will probe failure and other
> > will probe success when devices driver check whoami. So one dtb can cover
> > both board configuration.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/imx8qxp-mek.dts | 210 ++++++++++++++++++
> >  1 file changed, 210 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> > index 8360bb851ac03..adff87c7cf305 100644
> > --- a/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> > +++ b/arch/arm64/boot/dts/freescale/imx8qxp-mek.dts
> > @@ -44,6 +51,105 @@ usb3_data_ss: endpoint {
> 
> [...]
> 
> > +	/*
> > +	 * This dummy i2c mux. GPIO actually will not impact selection. At actual boards, only 1
> > +	 * device connectted. I2C client driver will check ID when probe. Only matched ID's driver
> > +	 * probe successfully.
> > +	 */
> > +	i2cvmux: i2cmux {
> > +		compatible = "i2c-mux-gpio";
> > +		#address-cells = <1>;
> > +		#size-cells = <0>;
> > +		mux-gpios = <&lsio_gpio5 0 GPIO_ACTIVE_HIGH>; /* use an unused gpio */
> 
> There is for sure people that have more experience and competency that
> me and it would be interesting to hear their feedback, but this
> looks like a bad hack, and you are just playing with the driver
> behavior to ensure that you get what you need.

We want to use one dtb to handle differecne bench boards because some chips
are out of life-cycle. I don't think it is 'hack' although not
straightforward.

check woiam is quite common at i2c drivers. All used method is quite
common, I just change it from difference point.

> 
> Francesco
> 
> 

