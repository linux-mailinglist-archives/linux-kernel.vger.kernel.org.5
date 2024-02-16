Return-Path: <linux-kernel+bounces-69238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC57785861C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8A37B2162E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29599137C24;
	Fri, 16 Feb 2024 19:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m2KEpSpj"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2060.outbound.protection.outlook.com [40.107.6.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27880433B0;
	Fri, 16 Feb 2024 19:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708111393; cv=fail; b=fLMYyS2L4do8ANs60cAwDAx7hDACzMhZbfJATIKOwfe+jotWq5f2i59XiZnwoBqH/YooKdAUF+WwJg+hzU939IcKaRAhqSly9VlPoZ12NQPNt5DuURiWP4ErRH9EAsZhlFvdl+/+qINq/s3Skf7Nc8CzH894oXtzATpyITdULMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708111393; c=relaxed/simple;
	bh=RHjSYgtT/I+tBrxr+nvqrnxPuaS5QEs2+6+xMudjDe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k7edCsRxnUCf0kx6wnXJplPxGQE8ZbMNccy85B05c0nqQYTMGivGqU6tDhZI1ttrP1UXkuwHUO25DgWNsoFyPKVunpzfEPfH4Pod0SpYYfu3WysJb9sCkEwOi0gEnUF8drRCWTs2QW9bGR2NjgLxLGZjRIq3slZqU5DDlRvXFYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=m2KEpSpj; arc=fail smtp.client-ip=40.107.6.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=numWKQ/l8hy6zQiqABUIz2INHcN1fZgakmdljjyacFvlo4/lk+iQXrLEMfKFqZMBCuo0FnvawjXA75KQDwVsNV1EnCaiRVoFO6KY82RQ2Z8Oa/oHRaQKoAqsag9Mw6aznHNEyw42GOL01aH7+CrIat1rr+iSPKMmHV0e6BF+1iXew0Wf+5d5qG8CTrmfdb/8RNtxC4z+0IWFJYS91wMLrW0yUBTEpbUxbShSczUYf7JmdZipjGLXqnuSuTjRB+GRtL8aJDtE/2eN7iY+No8rz8BHt/vHXrXuBSnOUDU7GhVcMXCVtuuUidysNptsxtYYv51AUEHElwoBaLXVCkdCiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bnTRukWwdZeUYclXYG8jSp9XnLtQ0UTCgu0tPDILNwI=;
 b=g0vBjm7gUUgMh0b+h0WLmWIL/8QLO4nlKUR3tafYtrnlJtfbsBzTKJQFQAm5mTC9sDBv+8Fs0Qm2g7/VfwLneZAJg3NJRxTRzGAWVynn4ELyjuhDU5T1JPOXdVDcCEpXBuPPSM1yXNak+d7aD2j/7a1EpxctQ3xZOcdmYnssBp4SD842SYozlvSGXJZbPmryDPNnywLMPH6H8gvjvyFRMtvk4p7hmKA23+8K9BvPMrxtVZEJBzl0yKZTID8QU1GyITXmpOYs7cDn7R/iR2k+edFiMiKWGb7AFz1Av6j8vmUNDNqRPe2mSwje6EsjOuIYdVPybUzIqzKZZtQqynYRtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bnTRukWwdZeUYclXYG8jSp9XnLtQ0UTCgu0tPDILNwI=;
 b=m2KEpSpjpbVjOMr/diigYXeGn3hBtuy1BywjRRGFfAGRXj0YFZZrfmxLb3jcyvEsHiRfL0fVmQWYQ7de80Fl2kiIM76XeCYH/dlnvbax9IzVVPdKDGBUEF+jhT+KZ4cQGLkUOlgDcSKLZOOV4yo46Fkvq6J+TZG0JoYxTkCgfg0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9802.eurprd04.prod.outlook.com (2603:10a6:150:110::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.29; Fri, 16 Feb
 2024 19:23:08 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7292.027; Fri, 16 Feb 2024
 19:23:07 +0000
Date: Fri, 16 Feb 2024 14:22:58 -0500
From: Frank Li <Frank.li@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>, Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v2 2/4] dt-bindings: net: fec: add iommus property
Message-ID: <Zc+2EitZrVzLsA03@lizhi-Precision-Tower-5810>
References: <20240201-8qm_smmu-v2-0-3d12a80201a3@nxp.com>
 <20240201-8qm_smmu-v2-2-3d12a80201a3@nxp.com>
 <49dbd0a2-a4b9-4c05-bb10-44f267672374@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49dbd0a2-a4b9-4c05-bb10-44f267672374@linaro.org>
X-ClientProxiedBy: BYAPR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB9802:EE_
X-MS-Office365-Filtering-Correlation-Id: ce5aebf4-0001-4d91-f762-08dc2f24b4b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Mdaha6cPTWpBxlXn9Z9LGerxAs9G/1RJEunH5B52njVADOGp81wpUkXjzIsryIc/iSM5Gh621bRTb2EMcufHW/UU0LpAP+y9zQA6Hq4hko+8MiybKviTI/kImfFFmTZzam2nNG/NZQFZP4u03qDy95nm7ETUz6T6cABYFwn4q3vPl/Rc3XZ3iLnL1ROej4CW+aGbDn/YtF8UE8YQR62K+kXX54okFl4AIcqNlRTqbD5JJFBnTZVHURWHtvbNxyNVKTEdLytfoqm85pbhYFDnzszE6jWyEcD0nr8jcceNEmZQ02Rm3Z1QbfyrKJEcAuUgiq0J09CFY97MaeiEjwcx67a7po3mMZnojs/5/BFvtTG2lCUB5FUoEC1+GQUZfAtoUQ72DnG54MQ0decGlRX1aP+x5pcPZqX6H1rmz25gOqNjloDE8X7+r+OIWOc04267i9+BVYjLtUCJwkwCAp96JtbXyN1ojQISAI4yGX3KODCMV+qPIDxw9pJ5HbJ9X3xDHXTYKdbrdFBaKNVVTm8OMGFBM23CxQ8Lcoq5d4w+lSA7ZIP5XW/5kzOPU+o4V1XGHJfj06txzh25C1eQVOacWaSS00uNV/wZ1WiVplliUoXGW4w+CcOtYRqXJtXwnBV2
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(86362001)(33716001)(9686003)(6512007)(6506007)(53546011)(6486002)(6666004)(52116002)(2906002)(5660300002)(7416002)(4744005)(38100700002)(41300700001)(54906003)(316002)(6916009)(4326008)(66946007)(66556008)(66476007)(8676002)(8936002)(26005)(478600001)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0I9QTJXjMWZ2WjMRftMgSVUlQv+QftmGejn8KGpYryjwL/URDOh4gBzj1oIy?=
 =?us-ascii?Q?GkOKDtraDzi+nH/RooO5to6L/TUOnnModGLdFnHVZVlXT+ZhHyR1L2an+0ZL?=
 =?us-ascii?Q?/wudFmN/NSV3KpTNWiD/PAaJBqUfNugYB3w0PFa4bQWIaCMYlYvwiLTqTJ+x?=
 =?us-ascii?Q?DVWj1r4QsJ83KZb/Lgwd6id4CeACUyBVJWE9zVsb6xUgnIVW/1+CYuy4JniL?=
 =?us-ascii?Q?vXD/Wia2N4/FhjA5+iDDxaAcCkWV5G8uHfTP7wC2nxz7cowf4W+/R4C2BEgx?=
 =?us-ascii?Q?eyfEPHaSWxc1UFH/0DfxFkh1zfdwfUUsifiSzyqjIbchI18mAgwSu57qApnF?=
 =?us-ascii?Q?gKoLVt2FovHID1rNVP+Ls0QUAXZhkWIVbzQzTMDWKbVEoaYCmFRl7QzP5jEe?=
 =?us-ascii?Q?O9A44ndIq5YaKpz5AvkrrqLVKip6Ews/0Lk+qJYULX5lkXtxiI7BoRV5I/ND?=
 =?us-ascii?Q?tBVmKmPx0o6m/kt/kDFT2pasr+Uoyy8h/qb0woocJbRWiEW0rZOIUEs0WOrH?=
 =?us-ascii?Q?LKWzgwtrMbe1RIQRV6LxKLgDpF/G5Dt1O+W2w0KAlTeJZTsmJQzS9XnV4OeZ?=
 =?us-ascii?Q?Lkr2Db0PZhplIXFvkAUVt1atiSIyhkZHo/SEAHjmmbKaMbbqEDixArJ3b72t?=
 =?us-ascii?Q?vL8td2jpPPpKAvXG+hJq+LBxOkwJPz/SGIZ1YSRTd5S/pgndBtB4i0R/Ttfg?=
 =?us-ascii?Q?eztXxZs0it77aveAOii6/zOXdo+gG0pSgAvECyZWk/otkAXlghMgeJm5gBJT?=
 =?us-ascii?Q?RdU8biUqgORANk7ebRDamsVzkptC0oypww641abJhORW2gX3Vbwu+CHI6p9A?=
 =?us-ascii?Q?ElXG7UA4695+HKSJrqazb4kU7VBJs4268n7iWZ/xxfSyR2iia40E+PR0lnJO?=
 =?us-ascii?Q?i530//QsF0eCKgSOL/8d2Z/IKCfmpZFXAL+9Dd42qOmJoMO0BNROE01twfLE?=
 =?us-ascii?Q?g87D9M6KJUtsSV8H6/ie1Q7a7dwhYuCmylVs9YV6Q4a97OPRmnEqp2wbRWhr?=
 =?us-ascii?Q?u1KnS+v5Dmd2wd/kQPkD/Rsk/QxRlC/axO+SigcCkW5AfojUUjAnNhvyDud8?=
 =?us-ascii?Q?dv/YXZHkm9BZXObmDxgIfDR/AzDRSAYQXP2vajFAZ4rml/3pPBZuLxVuBJnk?=
 =?us-ascii?Q?OVMAFYMbwPQdpHj7+RmKMkW5MirXvwBvBVGVdx3cWi+Sxc+So9L2ccvib5Xl?=
 =?us-ascii?Q?sVyWu6I5rZVaZwoqz1crJxgtf5+gxKiHGOsh5VqBNdnpzoUNSi47GPRbLRqj?=
 =?us-ascii?Q?ngwEGcY0NNdKyQJbtoxbMBkx8k6IdN5zDKOyfc+zpH/2OwAGClOLFk4f8ska?=
 =?us-ascii?Q?DFHhsejseVIsUfsRXY6fRPG3FGXI0JbmCNlvaWHJLwmt3ipcBHye29noYP61?=
 =?us-ascii?Q?slZGma3nMpc+M5gK314d5ZdcRJTcgwwvx06PCwJ6NoOvUkV8oKrpxX6IK4dA?=
 =?us-ascii?Q?6w7c5h591xx/tiln0IPqsQL+M/gJazBaK7m6rpj8K/dOWqQTYsypnhW1vnNi?=
 =?us-ascii?Q?OyPfl4yKAU7QsK7PRjGi8/OcVMhxZW2uWUCRyhLdkP8I6RN7v9vjY3d6JxHQ?=
 =?us-ascii?Q?oETj+pPxo94VRIQzeYAjHYGbixTeYye9TiBXYWmP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce5aebf4-0001-4d91-f762-08dc2f24b4b5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2024 19:23:07.8071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bSM71hqGjBHpp3B4WbaI2iZByV5jdwOzTPiRbCO4Jn8LRT5JCRTfp+uNvIoMnIR+4YFpLa26N6CV4ikOxLEksg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9802

On Fri, Feb 02, 2024 at 09:23:37AM +0100, Krzysztof Kozlowski wrote:
> On 01/02/2024 21:22, Frank Li wrote:
> > iMX8QM have iommu. Add proerty 'iommus'.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Other 3 patches already been linux-next. Who will pick this one?

Frank

> 
> Best regards,
> Krzysztof
> 

