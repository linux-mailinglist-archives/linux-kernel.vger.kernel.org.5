Return-Path: <linux-kernel+bounces-134013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 810C889AC1C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 18:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35258282268
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 16:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005883FBA5;
	Sat,  6 Apr 2024 16:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gizgIDXY"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03olkn2086.outbound.protection.outlook.com [40.92.59.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781D23A26E;
	Sat,  6 Apr 2024 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.59.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712421990; cv=fail; b=bdF0UJ0q0i+GKbTISI7ozXuQEbsnlyCTUV1RjXrevvqZtIAgzj4lOVFnsuIzrNS7qiSe4hjpn04i8IOOVGi6qeUVAIFYUfSmwl1/cIuprKIzRL7jbHxa4rQ/Yo5q8+r38UiHcIJ5jExkBJLGBlevBTomJhJCqnV91VENEc4mQ+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712421990; c=relaxed/simple;
	bh=+o8xF+c3J0kte/V4G/UjqyN0qZUVccEGPELPS6+xSHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OtOUgUuqYUlQKLw/CumO0+PozrZA8I5YVFQv86+NZIHRnThzXf5Ei1Er0B8ZGUrjqinNDpp8d7ZLARCh/lvPYgs79Z9dKQjJi1Y5nLg778aY8q+j4mYf9JaZZNFaFV0WnH0SNcYzx2zWGbJeXra/RlsAlIe6JG+xaw0fQ3F8+ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gizgIDXY; arc=fail smtp.client-ip=40.92.59.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VeF766Ckn84p3HE0IKvtwOALsdN+f0za6CDhPFbruUQe0AM6SJcT2yvrbte4o2CjocjIY+ca4XdnlppiyX87/htQ8ua3NK41kMOK5eyhvpaiA86Mv26s54vxhxfqT1Gj2zxBesWi645sqdrs5uaw4GJ+vhgwQ7mxEvV4L0oZjSCrRyWWsONpRoBcwgMbiz7hPRfwqeaoSMskZfyRlqhiO1EaH4UQSkBfmGPaSg8rbcFgggp71LJvUhLSk/bWkcZYO7Te45BzIEL1+Td5qRNDjUKzchIRauMjx05YIvGaG/EQ9wDCKw3v3G/mDMNe2mrKRv90Z8Lsh5PhbkKPXWWCQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UF2zGeEp20pZ+g+ruR/Y/fUPN2XB39IWhALwuoEmqXc=;
 b=MCP38VGA7Ftk5fOF2Tkt0/GMxJdVqXwCuSHx5hTcF1yoLNn3td1OZ8cgEyGEOQ48F9uXvdEvYHKAqLu/+pW26mogGjhO962Wv4XnC6jp+J1eej/FOV4JxgtpgBBDt1KItWqFGVWn2KIW0pOtzwWnGqerrWh7XfQ91y/UCf2gU9+rMNngRUJbfOBDyMdMAqZx4JnlAbsD+0NbPBjTK2y8FN9P8CaXCUisldz/a2o0/GTZaZnP6ggO613QMhAd23drY/nx1BodBrOL39D4fTGhaMIcEEy5xX/OW5utma+GnwhTSOJf7IEWZG2pWQLZbkfmBLMCRisD8R1bj6Speoi1TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UF2zGeEp20pZ+g+ruR/Y/fUPN2XB39IWhALwuoEmqXc=;
 b=gizgIDXYuFzWm85H/poPtD9rY0lfwRwH9YC968EwYDNw3qeDluwaD/KUjl9a64iOOXXOedJMn9JQzDRh1CqBHfWo6vu4gnf6PJA24neoOaxBflkTxDyzwVwB9rNc7wcXVqdFb/h3IPX2U/R9em9WcvtLGb27zX5CV693OC6Nvk3HYT9eqWQulQpmW9DcMv21VGId0qhT73XtWXip9esmac4UJKhP52469WNLeLjpSatiyQlF80dg2B451FbtI4pKgilRfGvyKBYh7+5I759aZhBVutF0AtndV3VMqArW6lo1ZYcTyqe0EDAY86wTN8K5BQeNjTGcd+jsLzldPNrkgA==
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com (2603:10a6:20b:3f1::10)
 by DB8PR02MB5771.eurprd02.prod.outlook.com (2603:10a6:10:f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.54; Sat, 6 Apr
 2024 16:46:23 +0000
Received: from AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::9817:eaf5:e2a7:e486]) by AS8PR02MB7237.eurprd02.prod.outlook.com
 ([fe80::9817:eaf5:e2a7:e486%4]) with mapi id 15.20.7409.049; Sat, 6 Apr 2024
 16:46:23 +0000
Date: Sat, 6 Apr 2024 18:46:11 +0200
From: Erick Archer <erick.archer@outlook.com>
To: Sven Eckelmann <sven@narfation.org>
Cc: Marek Lindner <mareklindner@neomailbox.ch>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <a@unstable.cc>,
	"David S.  Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Erick Archer <erick.archer@outlook.com>,
	b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] batman-adv: Add flex array to struct batadv_tvlv_tt_data
Message-ID:
 <AS8PR02MB7237161B8D17F83F0A31467F8B022@AS8PR02MB7237.eurprd02.prod.outlook.com>
References: <AS8PR02MB7237987BF9DFCA030B330F658B3E2@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <5466543.Sb9uPGUboI@sven-l14>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5466543.Sb9uPGUboI@sven-l14>
X-TMN: [B/2mQTnMSx/9dfbusV7bQx2ESxCQQOMB]
X-ClientProxiedBy: MA4P292CA0014.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2d::7) To AS8PR02MB7237.eurprd02.prod.outlook.com
 (2603:10a6:20b:3f1::10)
X-Microsoft-Original-Message-ID: <20240406164611.GA21322@titan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR02MB7237:EE_|DB8PR02MB5771:EE_
X-MS-Office365-Filtering-Correlation-Id: db0b8e0a-a757-4698-89bf-08dc565917bb
X-MS-Exchange-SLBlob-MailProps:
	vuaKsetfIZkROEo2gJaqbzokFpX8aXM6DNmNUR/0rxwggsJctEeOogq2OeF011FdJL+4eq562zTEHD78Hq1QKoXS46511zfbZfpB0GD/c2AivYT/fY54oa4JzWdSyq83cLKFgcKXjDGMYuYRe1cY3fuRbDIE1gZWJ3xDuyVbe53UwlLU5I33DCnPi+sqQomMLswhaqSa1Cwac39DcZbxmVzQAILkVmmRwasbZff45vGzxOKIgfB1ryyVRxIV6PBySe7TYckH1IZ7MpqSX2wIqJg/wKINUm6m/Wi48++imS0rKds/s9BuHID1V332u6nTR1V8q9fdGfS3RTH9b7xMUuv1M3+9ladkz2L+TOXPzpaZv8Cgomq7ND0gMISGyEYOuH8DKJCXupo7rPLUn1VveRlf16rKNpNLOe5/qaxbzgVIWn0Ywmq68axwj8MFnUcLrAOnwM2Qa4b9VDWHXV0zYtey5uLK4eZdVuIdxGp2/ahqVrzDlDyKiSyNqE6qCegYGHStLejVdPqaj61AkoglP7kaXCGrPzV+Jx1Bw0LMq1U329/TBeC7IOSH9mJQWINlcXyT7MEA8yqZMQf/2PJzH0MdJkAGg0W2gQ2zVqOOxF2rIIOAmzzt2rKpytxwy9PJw1ex5vcFMj6VCmVSJpqqXrM32Qjqa79QhhMUtjbnNULs+sCY5JG2VTVYvEQa2RYODBlM1qp3aZS1rUpBWuEqFuq2yANMMojWd9QRKss0JY8Cn7NjssA7txb48kuPKK2/AeVv2Cs4O0pL3/gPl/kS2OxBXY0dqg5OJJNj/oRH2ALfZcYzbg0c5uNcwYwvJIj0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VebbSgdsyIe4DVKeU8GpE6fShD4MGDioLQxg8TdFO3astpbzQfPfFtc4wdVh2C2wOjwx9VsQlyvj+NQ2VqO2pge81CdsqoziDVTIpiKtgfHgfGHXN92meA6sNK3+AlXFEMH/v1f6aQtmSB4xEzDsXJVwbAuZZEN3o7WFFXuVuEcTA8Fq40YfXJmIaY14jD89/U/JgKEIjv7fXCIXF01EbDQUgFFUKmsMxAgdd0sCDpFWuQ3C7tkIORLitPiM9SCbkhEyf+sGJrBAYJDCzzy/mHgDos15grU4Jq2Ucr6vp4weJU9aOo6A2hf4qWYdrh7aUk4PQBnch2o9jJEqzndsD+p+bprGlfwPfEqphTh3NVw8nQpWvkEQKZfxpkER8bLnw/2gjfay/XO3pjFPcQN3lKY3VDsLL6QwO0njy9+cEjLe0SgURbl+7sH2GWJyw+I//PtGl8dGWM9Ea4pQudcJM3bZlXdP9qy9EHPfNvl1HjTaEkWGaOtqdLxlVF4IUZk1i7V/IoTxYU7N1DtkqhbN5jqIWJLBgWznHFyDYAMTaBtJ+Zif3t8Ne3N87yInhA4YDzxzuk1Eq1lE4b28S6dcSGXaYSEbFCed5QlQA1Dqns1jSQX7V4EtgbwwLEI9EcX/pnJPsAdGI9AwCvV02XLHlgC6VInxII4lUdoSIqRe486OksDfCXY3inpwifyS1UkgTKOdt4KZwkamA4y4Z9qWag==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LUFvAlSbFT+eyc7bEa60mJIC0bu8ikvBIUkw0dfp42t9YQufdBHJWGYEsE76?=
 =?us-ascii?Q?+01BPdzhpyLIzn4bQFi6w5WcwauIs35/B3+Kef3JJsbyIkBqfVGpSLwiQR4r?=
 =?us-ascii?Q?VcqiYz61frg2DH2H7lxbOolIoYWqzV+Kl3VVh1oK2zNFUbNp4UeuAcfI8+HV?=
 =?us-ascii?Q?VRNl99I0NThICtz+ptu+HYgGEQYDhLBGYmhbsugmvYhYyc4vykmMoM2fwd04?=
 =?us-ascii?Q?iZfm1TViVHpMejOEMijw3BdqU59rasrrVDEC67XQjYiAHzLsExxCp2QsetB0?=
 =?us-ascii?Q?qGvyd+nlMUQ44bATNEiiEZHBmzrGgxdQNrwrnjH50OxOt+iQK/mbjNjDJliZ?=
 =?us-ascii?Q?SGFf5E5OZuKvhnFDzql0Onv/mYi1fjzvfQ3YDZgvirvdTQpluJZRcy+IHxtJ?=
 =?us-ascii?Q?Uof7Dtyghjr3i+BIO21Kx1qiWKmdk0AVp9AOV46qnTgixp+BXO0RM6h3rsaV?=
 =?us-ascii?Q?6rESR8W8tz8J+lIWCHqESc6/K5xfYMOuvqFT/mAY5QdgJBGbDq+O1vz39KwN?=
 =?us-ascii?Q?DtRE9gKIhdAmxEQiuWYIeqaj+hcccYadAqJHSWvYIABUXszogSou3bokJ+H2?=
 =?us-ascii?Q?zo5Tw779r/PkbuIYoocgkiX/0dHlgFIGc7V8ICyU/8VvBI9efPXdkia4rrvY?=
 =?us-ascii?Q?cfigUwposXW2ZPKtTwr7P9FWh4SK2iqx4UN1Nf7YBaqNa53nbtaWrdFJVXRC?=
 =?us-ascii?Q?uw3PeXJZtavq0D+0INYqFrqF2bs4kh+zwKWrOa+xL1ZqBWVmIFgfvhabj/tE?=
 =?us-ascii?Q?Y9rsQYEaR/wW31oeQ1yaF8w6NvpOqfmyM3rJt743J1C5iUaEuwZB8WtbK7wj?=
 =?us-ascii?Q?WEnVWiWa23NhFVbYt/qlURHkMoghvoqsXGJEH4rZBMheuVMwce2UszvFuFKn?=
 =?us-ascii?Q?gA+YAmsvKkHmuTVpkzuI5ojNF4J5PqEFs7rWp3lx0+kE66yUFqazcRDWmFAC?=
 =?us-ascii?Q?QlC+NZjbLWexLUd9hxXG+cwqMTFjBdL2a1zWUaCbVl85PDRqd52QnFcp1Ful?=
 =?us-ascii?Q?kwiT2dDyRd0HlBYomCy+UwscC2Zm1b15u3Lu72J0q0lt85MLdvo6y/wL+OSN?=
 =?us-ascii?Q?JK6muFnewpXeXkcAboVizLIFZ5feYWATHsJnrYhIxJBzOXb4V3ksjWjdlUlw?=
 =?us-ascii?Q?xPCKxhCXG9VShldPnJAwBMATlvy8nWz3pFxud31BBCKLZPXkKhj3h98P8zgw?=
 =?us-ascii?Q?svwY9rYJ1CjQdBV9H+2ASuLGR9Haidg0kWEjrENnwUFBK0QVX2Lb5ShrGQ3f?=
 =?us-ascii?Q?LSYIumHio8BhUWpGzcF3?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db0b8e0a-a757-4698-89bf-08dc565917bb
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB7237.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2024 16:46:23.2362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5771

Hi Sven,

On Tue, Apr 02, 2024 at 09:06:35PM +0200, Sven Eckelmann wrote:
> On Tuesday, 2 April 2024 19:23:01 CEST Erick Archer wrote:
> > The "struct batadv_tvlv_tt_data" uses a dynamically sized set of
> > trailing elements. Specifically, it uses an array of structures of type
> > "batadv_tvlv_tt_vlan_data". So, use the preferred way in the kernel
> > declaring a flexible array [1].
> > 
> > The order in which the structure batadv_tvlv_tt_data and the structure
> > batadv_tvlv_tt_vlan_data are defined must be swap to avoid an incomplete
> > type error.
> > 
> > Also, avoid the open-coded arithmetic in memory allocator functions [2]
> > using the "struct_size" macro and use the "flex_array_size" helper to
> > clarify some calculations, when possible.
> > 
> > Moreover, the new structure member also allow us to avoid the open-coded
> > arithmetic on pointers in some situations. Take advantage of this.
> > 
> > This code was detected with the help of Coccinelle, and audited and
> > modified manually.
> > 
> > Link: https://www.kernel.org/doc/html/next/process/deprecated.html#zero-length-and-one-element-arrays [1]
> > Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]
> > Signed-off-by: Erick Archer <erick.archer@outlook.com>
> 
> > ---
> > Hi,
> > 
> > I would like to add the "__counted_by(num_vlan)" tag to the new flex member
> > but I don't know if this line can affect it.
> > 
> > ntohs(tt_data->num_vlan)
> 
> 
> Yes, num_vlan is a __be16. I could only identify the kernel-doc related 
> scripts as consumer. But maybe they are more - so I would defer this question 
> to kernel-hardening.

Thanks for the info.
> 
> And with this change, I get a lot of additional warnings (-Wsparse-all)
> 
> 
> cfg: BLA=n DAT=y DEBUG=y TRACING=n NC=y MCAST=n BATMAN_V=n
>     net/batman-adv/translation-table.c:574:21: warning: using sizeof on a flexible structure
>     net/batman-adv/translation-table.c:859:25: warning: using sizeof on a flexible structure
>     net/batman-adv/translation-table.c:859:25: warning: using sizeof on a flexible structure
>     net/batman-adv/translation-table.c:938:25: warning: using sizeof on a flexible structure
>     net/batman-adv/translation-table.c:938:25: warning: using sizeof on a flexible structure
>     net/batman-adv/translation-table.c:2932:16: warning: using sizeof on a flexible structure
>     net/batman-adv/translation-table.c:2932:16: warning: using sizeof on a flexible structure
>     net/batman-adv/translation-table.c:3378:21: warning: using sizeof on a flexible structure
>     net/batman-adv/translation-table.c:3378:21: warning: using sizeof on a flexible structure
>     net/batman-adv/translation-table.c:3982:30: warning: using sizeof on a flexible structure
>     net/batman-adv/translation-table.c:3986:27: warning: using sizeof on a flexible structure
>     net/batman-adv/translation-table.c:4026:30: warning: using sizeof on a flexible structure
>     net/batman-adv/translation-table.c:4030:27: warning: using sizeof on a flexible structure
>     net/batman-adv/translation-table.c:4032:23: warning: cast from restricted __be16
>     net/batman-adv/translation-table.c:4032:23: warning: restricted __be16 degrades to integer
>     net/batman-adv/translation-table.c:4032:23: warning: incorrect type in argument 1 (different base types)
>     net/batman-adv/translation-table.c:4032:23:    expected unsigned long [usertype] factor1
>     net/batman-adv/translation-table.c:4032:23:    got restricted __be16 [usertype] num_vlan
> 
> [...]

I will work on this for the next version. Thanks for share these warnings.

> >  	num_vlan = ntohs(tt_data->num_vlan);
> >  
> > -	if (tvlv_value_len < sizeof(*tt_vlan) * num_vlan)
> > +	flex_size = flex_array_size(tt_data, vlan_data, num_vlan);
> > +	if (tvlv_value_len < flex_size)
> >  		return;
> 
> This helper would need an #include of <linux/overflow.h> in 
> net/batman-adv/translation-table.c

Understood.

> 
> [....]
> >  /**
> > @@ -4039,8 +4029,7 @@ static int batadv_tt_tvlv_unicast_handler_v1(struct batadv_priv *bat_priv,
> >  	tt_data = tvlv_value;
> >  	tvlv_value_len -= sizeof(*tt_data);
> >  
> > -	tt_vlan_len = sizeof(struct batadv_tvlv_tt_vlan_data);
> > -	tt_vlan_len *= ntohs(tt_data->num_vlan);
> > +	tt_vlan_len = flex_array_size(tt_data, vlan_data, tt_data->num_vlan);
> 
> This is definitely wrong on little endian systems. You first need to convert 
> num_vlan from network (big endian) to host order.

I'm sorry. My bad. I forgot to add the "ntohs".
I will fix it for the next version.

> 
> Kind regards,
> 	Sven

Regards,
Erick


