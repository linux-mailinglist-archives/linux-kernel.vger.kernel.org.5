Return-Path: <linux-kernel+bounces-58890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3930984EE2E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 01:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92D9BB23660
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:03:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DC90139B;
	Fri,  9 Feb 2024 00:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NWk4RY3g"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2088.outbound.protection.outlook.com [40.107.104.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786D2653;
	Fri,  9 Feb 2024 00:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707437026; cv=fail; b=dqH17g8Gmq9KVsfqP3xyYx9iwffwGEgKMGBMko3lHnm4JU/OIPiFcQzTNI6i0WXmdCqkiTzPxKBlyU5MTSf0r7g3cnj/R2vRkoSFngPQiOr0xRylSLdJmB3gImDxkzIaHleCov3Y7O2v5bFxrCz/KFSh8twlFOxnLZaurLZahLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707437026; c=relaxed/simple;
	bh=WR9CddOrgJa4vvvzEnJbC1lxgNHLP2funB+2s3L0gv0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Yn3ZWsherMsr48IaiGXtIZjSzj/zPw31OSNtVOjvIExap2N4Om+W8TggDrd6s/W/K3SkrB51Ci9Rwv2ms4RPr3SsyR2xsoW6ZtLrtDdGiedax+qAwKsKUYNdXpebgKzE48Y7ngPolJF/lNxcdc/TQ+vsn8NDKL06Jz5QIhPbYGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NWk4RY3g; arc=fail smtp.client-ip=40.107.104.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BWd4tPSl3op68+foZIs0VXc5KicelEXWjHEojQgkRtAdnJ/kvWzRoDtIROzwCfw2cMRijsGHZyTCU9purglqNLCtu5dtMe+q3hKh5jfqPUHJ/jZRSr7awuuvi5jJ/0v0eVz7vuz1akPW4t1FzERi3djQrR2ENTVFL+q4/E7ti1Nq03eO2N8ArYTlTh3qgHPRqjP0iKbBwRhkQ7BTMA1ymfsGVnbsXHrI89ti6ZXNIT00u6smzoB3g146eMJIcGnqjf7xpBbtQefRJsqBDQm7pBWDtgcsxBg7kvcTHN9+/NAMcNY8zsuTjh6N8qdYeySl/WV00uoexxeyKB2Kf0Jr7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKNpJ3wpaM7/caz4Azs/TcRirq8aoNfQAuVDKb8w3dM=;
 b=QOmSm0ORDjWOlOtNFsM+ZZ0wqdop7D8WFvNO/wcKe/krVX846an2WRBM7CehwsBPDplYIHK943iS6QCgb/9MKI4B944J16lJiRUOC3CVRg0w/PwwZJ34fTa3/viGoniFGxt7dIotrQsDFd7oev1uJCQhtuH5otI2Ftkl8v1mpGqiujkYhfTMvXm10tD608lfa+QdCFBzKChs9rWgjfXxOk8cfA8Eel9OfCx3Dnrt+UR5qWh+49WWyKOE2e+LX2fJs+YcImb2NpqNieBmGJXZdNTCQTk70h8qdJaHy/AFq00/qwTESdWvoXryAR7qC9HJ6jjeuuonoWkPPFvGCGocSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKNpJ3wpaM7/caz4Azs/TcRirq8aoNfQAuVDKb8w3dM=;
 b=NWk4RY3goMhJu3MlaC0R9ZrgDc1NQc4W6QAzGSbrMJ4rpQtU2jdogTonPczhTA6x7fn4XnklLd+mmWHXf3TK7471CiZqWBqxsmui14+cptFkRHoeSAL5cj0ptohnegeZESyb12erASinbTceGwAZHjD/Fypsvi3yUKe02hHqtCE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PAXPR04MB8958.eurprd04.prod.outlook.com (2603:10a6:102:20d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Fri, 9 Feb
 2024 00:03:41 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::9b0f:a9d8:1523:5759]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::9b0f:a9d8:1523:5759%4]) with mapi id 15.20.7249.039; Fri, 9 Feb 2024
 00:03:41 +0000
Date: Thu, 8 Feb 2024 19:03:31 -0500
From: Frank Li <Frank.li@nxp.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: Conor Dooley <conor@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH 0/2] usb: dwc3: drop 'quirk' suffix at
 snps,host-vbus-glitches-quirk
Message-ID: <ZcVr05vAYsObrrRR@lizhi-Precision-Tower-5810>
References: <20240207-vbus-glitch-v1-0-7be87099461d@nxp.com>
 <20240207-settling-drone-90e6f10a3476@spud>
 <ZcQAqVViPHcbgn52@lizhi-Precision-Tower-5810>
 <20240208-unquote-palace-83edc6220acd@spud>
 <20240208222748.cc2eodhtqpt2jmpf@synopsys.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208222748.cc2eodhtqpt2jmpf@synopsys.com>
X-ClientProxiedBy: BY3PR10CA0028.namprd10.prod.outlook.com
 (2603:10b6:a03:255::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PAXPR04MB8958:EE_
X-MS-Office365-Filtering-Correlation-Id: 74ba9c47-e3d6-4d6b-9585-08dc290292e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2e1OtIRF8ezxbwltN15tweKBA2HQAUn8hX8lxggt95+9fBeaICuKBYM5Ij4XL7NyPez/HCN+g30RHGEq73g8sNmjWFHxeCgjcoyIkOT0LaI2LmijB4J1ziIK2NoBxhIheP8LNR7/q48rOAcKadNplcNND+IR7mrBLQhVHl4JCDOa/ndW7zI8R6hLYL0G+EZHwebiqLcUQs4YSmh+w8J5YnL+zlNaS4CM0zmIFggX50brEemWbtbyL1gAceovAGgRi6uyj5oQJ+tNdKDF7Z+/boCkcZWRTNJWkHr2eUauj57KMFkVcLQqIcQeoOAOLiOp3LjjEwvAkD5l7ZmBM3JpF7uZefOfOsBhRfIT/OlA36vhh08pplQYs5ql9pdmubwvbh5NeF0av3cEBD65QwXEkv4dOEFlPFuWhv4OVEPKmaVshc4nFtzz+vONOM1u48OX/5z76wLlncbL3JfaC1gt35ful7aOcpmrrceJAF6VIxD0uR4IeuQMRUvlB0wa+GJDVkwsFV6gahsLEDhk85UIBrCX5zl3ZLEVRo09GP6RLNDVeHYMkuWvsuxfBo4/zF/OoJKw9w0b0spqyIU0cj9hCm4fqpkTMtWKvQGx5TcR5uE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(366004)(376002)(346002)(39860400002)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(6506007)(966005)(38350700005)(6486002)(52116002)(478600001)(6512007)(26005)(9686003)(2906002)(66946007)(6916009)(5660300002)(7416002)(66556008)(54906003)(316002)(66476007)(4326008)(83380400001)(8936002)(86362001)(38100700002)(8676002)(6666004)(41300700001)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?soztKeNg2paMTIOw+NQvoxVeRids1ubFR1M7ctQvj4BlE1Io2mVnIfiPTvol?=
 =?us-ascii?Q?iLNcMSbP0eR7rnxw1DteJYHYpfl80lSoAd5eCozO2G+wfaZDEMn+b2aRngi8?=
 =?us-ascii?Q?r4OOEKeDrrL422wcJnzyF4CPcYAVQLKx5SW/Ky/0X/j/tl5xgvuZeizZt6Rf?=
 =?us-ascii?Q?o+/XIYa5Uruh/Yoi/f028YkqqxxwtvkWB0aD97haghcUG10Q4fPLZ2i1MPIu?=
 =?us-ascii?Q?ysXbB2VwrQM1WlM6jX8s3KHb5LQx2k/0vaWlpq1hcNP67pUA/KYLfCyUcS+M?=
 =?us-ascii?Q?fp3bxavza42bDJcBwPSfRJ2ooaQtZHKZH0HseHdP1u0dIZ9jFX1ZbixBYm/3?=
 =?us-ascii?Q?sre6Uors64rtYoADnh6JZW5apO53P547EV96snmT+5YsB+c6oRnXTqi7/ptB?=
 =?us-ascii?Q?NeP/I+AoY1EklHOrnNgdeiU108Teb03MGdgOcOFGw6cyGrcC4x/2lV9SlZpL?=
 =?us-ascii?Q?FaC5acIkGpKZVsFJ0g07d4ROeRH+IKJP//apEPdkoD2gIvu0TobY9hAd4+LB?=
 =?us-ascii?Q?Si1tvZV3SkQRRCb6/CY3qqbe1zyBesd2w/BwGXbJhYVi3aqEVneQoMHGpA8Q?=
 =?us-ascii?Q?l/LUVhTu1zISk73T9mvxAXZe4Xnmva9EnJiiHVReGLVmZ6aZ5R+mDMxt6KBT?=
 =?us-ascii?Q?GQF2v7XBrAnhz+KWzPREya3R2yp3Ux3OtstnqFAcBz1GIyjCWSzExuj6EkEn?=
 =?us-ascii?Q?iXKyRvsxWR/3rRmG4sMdFW5d2LegHLUZeMGD2pUsjZ+3u3ZEaOMlJKd/oVIg?=
 =?us-ascii?Q?rgpLPaPZH3O3qm1FLEzPZWp+TUfRmoRVXYFDeKpRn2JoVCTRxlhTkZfSbvYi?=
 =?us-ascii?Q?pMzzlaSi2453F4gXnXjHnMph6ogn1CGCj1ViLKVoM2CSFPozTh3yEgq8ervT?=
 =?us-ascii?Q?mobHwqFRH/k8vDZGQj6MLKAa9ZLYnh9khCD6fvT1m5WK/UyhMTXkwmRYjgBx?=
 =?us-ascii?Q?RBnHciF/H8IDZ9E74DkeZNPrNhjHoqyOis0t99ZHil0qMapsRp7J3L92HSKP?=
 =?us-ascii?Q?LE6IsQfZbBS8BXpHCG7uPelJwmWRQWCf5GQlFU8MG9EVrXljtfH6gdabPYmg?=
 =?us-ascii?Q?sPUPIvNAywrCZoO35fnyrGipS3rNSu67wkHiZIyHNVZ0uRQEjI68rss3k+cU?=
 =?us-ascii?Q?L9c97TwxeZnt0VYDcjWIFijP6lNtHtBNCT8yHYGkYQXdLB0VwyzUwO1Pz8Qw?=
 =?us-ascii?Q?A779PfBj7lcGa/xds3YUi/y+froK4OJCGYEFrxG1Z313u+tdnXOSx7ENHG5b?=
 =?us-ascii?Q?4Joqbb06XUmfwc5OnREfV0YHPUUYCLmAtFkBP6LXmmvpGx/IcSsFNbH/tt8W?=
 =?us-ascii?Q?MkT7bJFD6gRZgHF1vyZ/4HGb9AtciHxylzwEECC0ne+HgYgz8noztu8hpeXq?=
 =?us-ascii?Q?Y3OLTNHXA8Dlmtt++hFS5wwf66l8gjVlB+e8C4X3VTdeRSHi8Xtr0/7OVsOJ?=
 =?us-ascii?Q?YMZrvRBAu4Shlw6gK6q/CP0hsVJenNUpoY5WR773plxYG4VknXjSc5QnWBdD?=
 =?us-ascii?Q?9GjcKa2xoX9dOoQ5VpEY0xUFLaMLC17gU8qS3ynMO/pj3qR5cQZBI8rKLsJV?=
 =?us-ascii?Q?djqEyuwd6OPB8nfORxE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ba9c47-e3d6-4d6b-9585-08dc290292e6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 00:03:41.7433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0ECWfnHRXsPrEH2jWQqW/lmyN9rUEic5na6HCMZzL82SpZAGP9ompOL2kPYxys3hoDvMsRQUmJK5Mk40s3W2XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8958

On Thu, Feb 08, 2024 at 10:28:22PM +0000, Thinh Nguyen wrote:
> On Thu, Feb 08, 2024, Conor Dooley wrote:
> > On Wed, Feb 07, 2024 at 05:14:01PM -0500, Frank Li wrote:
> > > On Wed, Feb 07, 2024 at 10:05:23PM +0000, Conor Dooley wrote:
> > > > On Wed, Feb 07, 2024 at 05:00:17PM -0500, Frank Li wrote:
> > > > > Since dt maintainer give comments at old thread
> > > > > https://lore.kernel.org/linux-usb/20240119213130.3147517-1-Frank.Li@nxp.com/
> > > > > 
> > > > > The patch v4 already merged.
> > > > > https://lore.kernel.org/linux-usb/20240124152525.3910311-1-Frank.Li@nxp.com/
> > > > > 
> > > > > So submit new patch to rename snps,host-vbus-glitches-quirk to
> > > > > snps,host-vbus-glitches to align dt maintainer's comments.
> > > > 
> > > > I thought the last comment left on the v1 was Thinh agreeing that a
> > > > DT property was not needed here and we should be able to apply this
> > > > conditionally?
> > > 
> > > I don't think so. This is workaround. We can use this track which chip
> > > actually need this. If some year later, such chips already end of life.
> > > We have chance to clear up these code. Otherwise, it will keep there for
> > > ever.
> > 
> > > And I am not sure that the side effect for other chips. Workaround should
> > > be applied as less as possible.
> > 
> > I'd rather do it unconditionally if we can, but if you and Thinh think
> > that we cannot do it unconditionally then sure, keep the property.
> > 
> 
> Perhaps I wasn't clear. I meant I agree that we don't need a new quirk
> property. If anything, it should be safer to keep vbus disabled before
> handing over to xhci driver. We should be able to do this
> unconditionally.

Okay, if everyone think unconditional is good. I can submit new patch to
remove these.

Frank

> 
> BR,
> Thinh

