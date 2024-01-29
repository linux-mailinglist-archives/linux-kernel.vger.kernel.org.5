Return-Path: <linux-kernel+bounces-43641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 554B384171C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:46:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB73A1F239DF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C69852F9E;
	Mon, 29 Jan 2024 23:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="VMN5QA87"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2119.outbound.protection.outlook.com [40.107.114.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A47524AC;
	Mon, 29 Jan 2024 23:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706571986; cv=fail; b=u6cYk+rH9v4bsKupNGYpLJa6ALqM/g7eaHBIRmTt6qRErl6W3RZMOlugcSZqvjL5xeAWah2/EbRxSyWuohts/wD+/6l1hV8yDjfYB1TRhsKSbRMBSqzWxHd5imsD9JzLJBjGRFeNc1xgxgLLAlhqPcjJoq0FwOW3ml9mZ1Ned0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706571986; c=relaxed/simple;
	bh=98m1Ra/LddPKbDHop7ydoVQtczIg9Je0jpXodzdS8G8=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=HyJYsS1MWFoUF129WKInIs2flWGWgLcN3aVcS4O1BWbWN9LrnfElYUVXZC7nvKxwaUvy1TPSZw6gxEk+/nIQ1hbgfpetIpcjoLaSIcujI64eS6SrSfP+XDjyF3wAMzxkfMz9kfQJVC0XkNe36UYv205AWd5PYifP/wh6E0SHJZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=VMN5QA87; arc=fail smtp.client-ip=40.107.114.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WHop65qwUIrWgizcJsqqLe2+M3pbY4rLe8+gqXdInAwWSrRUCKstAjdCExTf/JLbJvsVRxcHPFgOlmECRXmQv/OPg5fo2y27E/1BT9BFVmUz3ZpAOvTm3aORG0Z31maYJhZ0i3qLnugVRBU9RGUn1kh2QZuRJF3QNxzOD/yh7Y5YCuWMC4otkAmpDwmcpGejhBkZMt8hSlxAAMWo3jPyVlhN6VrAQLxrFQhK/awT52FagFShYintgZigfrpJtFl6aBC53UlhhhhUXXE/eu89j7QRe/zwlpKun7Tj02YlGONpHp6xwtDp4KiaKJL6+cu5ehhcx1rnB8uorOdQR7IGPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SThkbvHldaC9G2Pm+Pmwuj0+q8A4elmEbPQ+rFZgCtM=;
 b=Hh8KSo1v+LEpuVUnq+6sHQbrX3TEE0wwf2zr73XCAKVr+8j350UyGCLYk6G/6i+gMvcXMCvZy/4/xJl7w6daKXr2zAO5rJR6sGGOF+An3d8fkH3gs1QudGtYlKqbniSmHq2yjSkUKiIqkRZFS0BkgyWkTxnMMCtoeyvq8DU4+A65gDHAsE47UYNgndH6bsOtHtg7RozCmRv+PNITBXsrvglRnc+hlnsoGGjoO3rEcz++J9NzCeziB0myjS24tFR0CZumkrAD/rO6qsncKee+PIWyZIpA90GpDRZuvUkdCFthHTF/AjFLkq3Tt2uLTs/C302KOYRCrKe70nLpQBBR3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SThkbvHldaC9G2Pm+Pmwuj0+q8A4elmEbPQ+rFZgCtM=;
 b=VMN5QA87V+GrCXI+iJ0JMHub4QKXfzAxG2TdceQqZJm3UAcl7b+7WmcPMYrg9sixp9Q2LdGyfXGGhs04+mmwAx9wsCiN/Gr6HBO6/953cT/jQQc7yvL1LeBumyfRb652oGPWehxRGS4HSLqYHQrfINGIypRYHunT3aBsZk9o3kc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by TY3PR01MB11472.jpnprd01.prod.outlook.com
 (2603:1096:400:40a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Mon, 29 Jan
 2024 23:46:20 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::ce8:8f5e:99a0:aba4]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::ce8:8f5e:99a0:aba4%2]) with mapi id 15.20.7249.017; Mon, 29 Jan 2024
 23:46:20 +0000
Message-ID: <874jevk8j8.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Chancel Liu <chancel.liu@nxp.com>
Cc: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: soc-core.c: Prefer to return dai->driver->name in snd_soc_dai_name_get()
In-Reply-To: <20240129071839.2393483-1-chancel.liu@nxp.com>
References: <20240129071839.2393483-1-chancel.liu@nxp.com>
User-Agent: Wanderlust/2.15.9 Emacs/27.1 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Mon, 29 Jan 2024 23:46:20 +0000
X-ClientProxiedBy: TYCP286CA0201.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::15) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|TY3PR01MB11472:EE_
X-MS-Office365-Filtering-Correlation-Id: ad9498de-b0ca-4009-454e-08dc21247e5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bo9h11+rV+BVHFV+5LjM5z25DddEyoNT8e70Tt2j+YRsYVex6CqaLuRHEe/roABY19m/F7HGqP5jin5kVa2RY4HXLPyTGtg0LR7k0udImtP834EOCg6106zHOzA6nUY2+s4pOg5J4H/EcW7Z65QRDpi+IDcXcVHnBbzU9++U/94u3T1kuWz3qcVeiaIei+aw4V5fo6TUig1EZedARx1Cm2B8ebthcgvapqf2BQyBBMm5FV695tNy9yDUzVh/l52QgVhl3s4QnKONjOyLsdcg3wsZ30M+4SxYOkTPKyRLuNDJ1efOgAvhHwluCATfIv+P0dZE+/1CEZx0MX0kIFd4YPXsvhp9HrXhzIgqJ0aMSMDrt+AZvT0B24H+AhrkU0pd+rxwU9J07zEFb09+/IqW7J6NQbfh+4bDSLuQXKMzXRHA5Ratym3D4KQvfC2R4dcSveSPro1kjZ879PHH3xSathWfqdlxlElvadK3qTjdWFCKyTK2P1pPxLYrcLLRc3Kfe1Gx6GeHp7GjOpKriC+p2k2x1XaTLtji8j2cCDVfTvfL/bC9I7pCfRldLx3asQe8Zct0VWLwMNtgqfKoC6EThMmxlAQACazL32jb+K9dtLDm95hOrYavM0FnE6sMKlST
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(39860400002)(346002)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(52116002)(6506007)(6512007)(478600001)(8936002)(8676002)(4326008)(316002)(6916009)(5660300002)(66476007)(66946007)(66556008)(6486002)(2906002)(4744005)(26005)(2616005)(83380400001)(38350700005)(36756003)(38100700002)(41300700001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Dy5UtKweR6oWv8u9iU388VXe5BZJcUlWKjAqp99u+okgqsEkbi2dGfnI2hY2?=
 =?us-ascii?Q?azZzBlVc5mglWMBi2AHk5x0YTAaojVfbJPH1JZjIjePUjJGjQ9usFZV9XbKN?=
 =?us-ascii?Q?OccOsbo8k25S5zOU8g+1CikhwTv03uh9HATeYEAWfTQPjayK46TZJeB/Pkr1?=
 =?us-ascii?Q?r6S58MQd+Fg3MTT8nXGQR7bTSVaD2Gqwc5rZCv044zwYuUlPe6nD6zSYYwiZ?=
 =?us-ascii?Q?xunx0QUUc/7BnbqoH2hknyCBJ4HpOkgrNYZxq/0PZDlnt9/WACth+Ja9qinW?=
 =?us-ascii?Q?hHMlQErhwsvuq/+DrzKgx6xg+g5Yv05NODw39E1cKuFELaPaa3goiGgaJvx9?=
 =?us-ascii?Q?4jADlfDWOaXl+rRjmxv9gAzGveCPS8SVCsb2jRBRNheX9HeFS7yB9geYu96h?=
 =?us-ascii?Q?f+3HB9LXgyFga+wgllsH2T8cQY38quxbj72zIlP6RJoMrPZgwVqNVCEMpc3H?=
 =?us-ascii?Q?0rfMfhB3mMnb+jTXri/4AngtzJmW7Blb55gmaviU4WGeZcZuosqI/8PezjCH?=
 =?us-ascii?Q?Q9Qlife7orN1r4xJT3oJdz+SHlpZdQr6mmL4r1bIRQQkldODQe4Cb694DA6b?=
 =?us-ascii?Q?qeQeHSMkPITnO2tGQLFJTXbQqPHzj7zem5KuR2IepJvj5TJ3Dv2X9htFGrz9?=
 =?us-ascii?Q?7d1+p9ySCk0nYq/pOESvBL7BTYVJxVCDC8nNjAF8yqgqa5yE6E9hXTG3vxXx?=
 =?us-ascii?Q?L2BpXzW+rYRo49JecgxdoYewRd5C1FrVeIBoIGwstcQstvBHoojhzPPgSRVD?=
 =?us-ascii?Q?2JJrN7RuVK0kx5ehyW00xSi8Gb/+B8eC2H1Zg+5rk4wh2dsvlx5zyLg6D0la?=
 =?us-ascii?Q?akgmN1w8qr90OpJ2a4dxHw7J2nAz+j0frCOVsLJQKdFkKCUS04q1xo10vKKI?=
 =?us-ascii?Q?fVsStPveBGolLw/HHgJePwww94l/MZ4L0feVOPFCdKIibm+ogay4WJZhTEX3?=
 =?us-ascii?Q?C9vk4Gm6uxoFd4ChQEzEZH50maV4AD5WAyNB8XcurL4OtbWxMK4sg6Q5GNvZ?=
 =?us-ascii?Q?r1l5geYFK0Z+g0gTY0gfDpn5v8+RJ/TgaxoHoUGs/mdOBKoF3qm3h/8XIOzF?=
 =?us-ascii?Q?m54dIaoDqfJ8ssVrdmJF8Ko4vvE7Et+JmKvetH5jJbZZD/68D2bOf7P2awMf?=
 =?us-ascii?Q?BVeFNuDBxAlVMCgHGGffJPUqtSavaNkkYXFRnr01dDdnalwhbbwSadW/6V/h?=
 =?us-ascii?Q?aONmCkwIPKWc8pfL5dy/CO6GknNvxfuiGx8tUSYM82lEoq5r7g76T7eqW3bJ?=
 =?us-ascii?Q?zaAaGbPNbJWrYNxAjamWu3/ex39I6t1XlSOhoBiRThv9RusLqcqCw56RQSfP?=
 =?us-ascii?Q?6gRAtw35d2xqi9aeJd40neICGcnkX9VbeF5UfX7fVRw+YdxLHDuW+dO4+/WI?=
 =?us-ascii?Q?DF+RnDJq4NdU9XyKWP8YTmtqHmZoKIhWtfbLr+Ir6uQRoQ5lWZyEgGYMiaBy?=
 =?us-ascii?Q?usS5OKj98EzhYYQaQToePmmC0tXIWjhM97ioVUXSCixirYEVyIWtMWCC4ecV?=
 =?us-ascii?Q?sQyT3wKhwSk1x6BeqrqcvXQpaoTH6DBAobCB8Pq5H0IBmt3gYpxfxLntMI66?=
 =?us-ascii?Q?DgBk4qsvumkuR3Afkne+ffIT/bNhmjILv5uSnvDhRZYCUGQ1nRIe7dRQNcof?=
 =?us-ascii?Q?6e2fnL9xQCCmHFIhzGTFLik=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad9498de-b0ca-4009-454e-08dc21247e5a
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 23:46:20.3067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pTuYitezPUk+9cnLJ5l0SJFp39j95wXu1fXMz2SwSrO3mCBVisX3CdggvjxKZ+yNKQpYVJBfW1lDixEn53Iyp4iXAl7KMMumyx4F6Fr8mYTzJAEEGQb/YXH7TKxLtXpD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY3PR01MB11472


Hi Chancel

Thank you for the patch

> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index 516350533e73..09467c693627 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -300,12 +300,12 @@ static int snd_soc_is_matching_dai(const struct snd_soc_dai_link_component *dlc,
>  const char *snd_soc_dai_name_get(struct snd_soc_dai *dai)
>  {
>  	/* see snd_soc_is_matching_dai() */
> -	if (dai->name)
> -		return dai->name;
> -
>  	if (dai->driver->name)
>  		return dai->driver->name;
>  
> +	if (dai->name)
> +		return dai->name;
> +
>  	if (dai->component->name)
>  		return dai->component->name;
>  
> -- 

As above comment indicated, snd_soc_dai_name_get() and
snd_soc_is_matching_dai() are paired.
If you want to update snd_soc_dai_name_get(), updating
snd_soc_is_matching_dai() also is good idea.


Thank you for your help !!

Best regards
---
Renesas Electronics
Ph.D. Kuninori Morimoto

