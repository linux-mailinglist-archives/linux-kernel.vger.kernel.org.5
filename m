Return-Path: <linux-kernel+bounces-155096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8936E8AE540
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3FC41F24115
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60C713793B;
	Tue, 23 Apr 2024 11:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="c/6j3K/2"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2045.outbound.protection.outlook.com [40.107.105.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4631137902;
	Tue, 23 Apr 2024 11:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872828; cv=fail; b=uKMqaZU3J88cDZpNK5HA+0l9+2ElWFGuD9oP9LGrPyYUaV9HoVfG8qJ0BUe4BloRXlv8sUQd/SFl14qxS0OriaKd5f7ViMxHMjTyvBpI55g7BUufjv9ayKta1AOPq9J9GQf6r3jwvuF0c3NwNmPH8Q5Gp5jyZ8O3+KULMgobMDI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872828; c=relaxed/simple;
	bh=kUl3xWgKzyk2G/rMKzb9SDds9ZgYIO4rWxvUxEnnT2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OPKZWFF0zxCUt8m4NJ0ItzQ9LTwFfv5GRb7mwMq9Llrw0fvp8EPrxaa0nM6lPjxkmc83OoBp9SschHGd5wZpXGVa4lqnwqEznzQSoH4wyS8zzdHAirvAWzi1K/ekdiRadQotCPg3gUWPLmFM6kobuZMreAE3CQuUSVn8YDZbcsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=c/6j3K/2; arc=fail smtp.client-ip=40.107.105.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhOgAXuAVDJRD2hK+0QqlvP/xuqiJS2jVaAv4Vj1ZUTpYC8D57IIge05xMVa2JxWBDbAwoZLDhVnaQ0D/eDfTS69Ij3gqwHLG9RtyaJQTFApf1wSndIN9EksRGSUeWPeVB7Rh2A2wmJjMnk7akVzLvyl3ToLm1U4H20LOkQvqqr/P7u/fuu/CAYG1Q+iZWVtFTyEyVDoTjqaRjkmFCVMudFUbmDSeJJlO7iVE6B6wJWPxNECgzYNTEaqKA+UZGd+M8nV262JCay8rXES3F41Y9kftRD65gDV1PfB/x4tdibyM8O/x5PUVCWlIfVQ2CUUTw4hbM2x2R3CwHa0tfKULg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMPmayyumsqbf7fj5mxltE7GXQnXZ31BevObXbHc+vI=;
 b=JPb3khNkpoP34kWDpa+VfUewdxgQKGWR31g3TwQRU98o0g0fJBpmdQd0ApDG8x34MZmYcEFGHw4hKrLnuYAIWDJC+O83kWoaNP06ZNYyTlVbuJDlJa5E/NRqpQsfNXfZFfEZPl9z4i1W3HToGHcX1mXaWlxwMi+f4sS8eyWCmyPPAyOqr/pLMQtUW7h/c2MLJqDP+9WgWkNA74vilo3yYoKxD36FEVeWWzwger0wxogpFS6CjUepbx9vSZt1QGKnyytun+/CrDvCRQFY/Gd2Pv1uhArtJXWIFgAO6ZHFxi2xBuFbrioXmpRM+ArXIidIm3l5nc7SgYn902/Cknj7mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMPmayyumsqbf7fj5mxltE7GXQnXZ31BevObXbHc+vI=;
 b=c/6j3K/2nRA3ZTGY1fDgLB+6iJBCclP0426rGuSIlZUnv5BuU26T/r+zLOgcWU5iXwWaaLqmxscTBjBJdRNfgqAGd2dl1n9Ura85W9UrAzEU5AIKKXj5qwewJdA2rBL9e8LwEv8pyivCKagzCoiLhBdC60aziwU1zjh0VnsUKeM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by GV1PR04MB9120.eurprd04.prod.outlook.com (2603:10a6:150:27::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 11:47:03 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f%6]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 11:47:03 +0000
Date: Tue, 23 Apr 2024 19:45:39 +0800
From: Xu Yang <xu.yang_2@nxp.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Will Deacon <will@kernel.org>, mark.rutland@arm.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
	festevam@gmail.com, john.g.garry@oracle.com, jolsa@kernel.org,
	namhyung@kernel.org, irogers@google.com, mike.leach@linaro.org,
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
	alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH v10 3/8] perf: imx_perf: let the driver manage the
 counter usage rather the user
Message-ID: <20240423114539.4jseauipidvwo7bh@hippo>
References: <20240415061320.3948707-1-xu.yang_2@nxp.com>
 <20240415061320.3948707-3-xu.yang_2@nxp.com>
 <20240419154913.GA3983@willie-the-truck>
 <ZiK6G3aM+K92lq0w@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiK6G3aM+K92lq0w@lizhi-Precision-Tower-5810>
X-ClientProxiedBy: SG2PR01CA0162.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::18) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|GV1PR04MB9120:EE_
X-MS-Office365-Filtering-Correlation-Id: f17926db-abc3-4118-2837-08dc638b17e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kXsupYx9YEWIwVDVZ1IIhAMmy5ddPmu4iLDpE0DyBVMbU9l2kvT2HzSRO6PI?=
 =?us-ascii?Q?+BlFIc9B1VH9gHddtGTkZMxLzhASO4p2QUacndfNzDG6CrMkVdsQszM2L5kS?=
 =?us-ascii?Q?zV7YalBrfGYCkro4TvXmyto3lA404zjM4JhZfx1ccdRuqOV+3oTsnDgfywMm?=
 =?us-ascii?Q?+AFIUz/CFMjn1LcGpipoX10Knlj7D1IxQuJguHGrdGBB+NuXlSsGam6rA8xh?=
 =?us-ascii?Q?Wnj9wRG4hsVspitOS+WkI4DlwrXmvcwoWGKGHme42e2qJXroqUDHC26cc8MK?=
 =?us-ascii?Q?E2nqG32UF50p4NY5MoTuOuu8HWGd+rxVKlHaZLC+5o84zg+cmUaz5pbVrJuw?=
 =?us-ascii?Q?I3GXHbHh0GtG/M1lRVdzRZbpmDA78qWs2HoKj3qCBA0KbRsZNpYEAyAvAziR?=
 =?us-ascii?Q?bChYerlWsmvZ+5b1LQu/rV17WpZLHCeGlTCnjsU5ZPICsYAa4WoVkrTOSNcp?=
 =?us-ascii?Q?uxGT5ohzlGHlrzsIeGu3mwpFmlv5LX47imHCj1cEsiSPE2pMfFVf2EHC0ul4?=
 =?us-ascii?Q?Y3JjlgEGg6OpKijbGkfJ1xVqJ3vIerD00sl4ZbJyfyDGhjcpfLdU1bj1Tpbj?=
 =?us-ascii?Q?YY19eEK49beFv4GL/oU2I6YqcipkdZfQLPBGHlHCzFcwiquo02aggzs2OUIX?=
 =?us-ascii?Q?9eHuiBToOkALhhQ1hHzzqNNxTAmshnkHPh4Z3LPUW48iTHfvDWFGwmbjj3PK?=
 =?us-ascii?Q?J1CL++IO9QhXBtTo62XaPo6AC4xEkDoSgTRdkBefoKDlFDjsgiUEW1ggVVqL?=
 =?us-ascii?Q?F4TKMFV4HoLZkLvz8JgNSjg4hia8sanXeiX8V720gR9RSSnO5pVkezdJ/KRn?=
 =?us-ascii?Q?AmQhU9GURv/AlXkzV8bzgcg0D01jVa9RIwNsj+29ABKYZCpbRkuNnOD7vj2u?=
 =?us-ascii?Q?dJAR7szJeOncU+GypdMFisL5FUdj7QPragg+rkBS2qaM2NoUAbXQyPtj/a9L?=
 =?us-ascii?Q?DipIPu46677apiAbj8TIEuEWXxRUCSHZGepBr+7l26u5FnHZjgrjsLmVMtgm?=
 =?us-ascii?Q?lLJRvZdfZpGE6n1DZtZkKrTOMkFzJex5SSq5zkFNQ8WCrFbITIX7mW+GALkg?=
 =?us-ascii?Q?F9ewnnpIgLkSXDgpQMSICF8b8hTEDfsPpazdbulJhZ0UevvLymTbqeFyIm1T?=
 =?us-ascii?Q?Ef82EMeBU3eZiZHmAJCdQqtZ3+Ti+UxB4oge/4Wixb8PqE4vOBMExUmryYWJ?=
 =?us-ascii?Q?c5MQfisBXrcrYkEJDGZAKrcO1ZeSybU2nTupdV1orMKO2ujisHyFfjWN1Y7k?=
 =?us-ascii?Q?XIb6TpSJ0Gttl9HO6xt1EiGnqnTtCYhurLsm9+Xm1SFAur3sKWHTiARfK5hP?=
 =?us-ascii?Q?sza8mvhD01rBdaVosmOdeVQ3gSDbK7ofkCq3yL16fG8sTA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9aVnH9ioKLDBdmGUVxmDSXFuQtrev1uUgsja7L3I+13VhdkNn8WwZFBC7pqZ?=
 =?us-ascii?Q?dRGBIdB0fq3Izhk691VaLtLOoPHR2I6vF3RtWD9PHfzUZsuBaX3rtlSCO7lX?=
 =?us-ascii?Q?3fKXbtpswjAZ9+kmURj6AKEBnkvIh0XrS5p+beF9RA3Nd/5ttdzn7ejzm/ZB?=
 =?us-ascii?Q?6w2g/tcxirnnFGnY2DGJvfGn7pQOtOc2dCaWA9f5wuML8fBGYJ1KNEFf0obf?=
 =?us-ascii?Q?Y/8UxijE3AGKRGIDUy8SXzTCfr1sg3JCwfjA1HEuO3sCfHv91+cIV6eOe3Bd?=
 =?us-ascii?Q?MAT8ZGpc10t1q925rWwUWRIuH1qCFA0uKA1QoI8dhd4STuEFalrr3xra0Jgp?=
 =?us-ascii?Q?N6F71CycZebeAt6/Wk0Hb7lNV9OwCRQl3Yhkaj9zCsw2qUpv/u/8jODj57VI?=
 =?us-ascii?Q?jQH3p6d+jEy7BvdpMK9buFncAek8WnlD2a0Z4CCaIiqPAFgWZ78FnVd/vOsf?=
 =?us-ascii?Q?lfuLsieSov/ZZxYyGPjplSkUgy9tMARKqPFRqs67JaRH+9AAMhy2sGFINJqc?=
 =?us-ascii?Q?SF6179vmhqzQxAV9WVLMIZwUGnmoLfTpoGAr/vP8XSe2Q6SjmuPlMbMqAIwz?=
 =?us-ascii?Q?e+K5lFIqBwU8NdixtKuLBp66LXkVh8LDWWu188L70G5SJ7q4axPEuQ15XBey?=
 =?us-ascii?Q?147ahF1RyaoNSbOSFVAS0Tn5p2ItQKYLAuFoLJ2am2jgosPlcUAn9Rjjpbcr?=
 =?us-ascii?Q?PkxshFqtaC4C8xz0re21Fvr2JUbtX/+Gih4x34Q0ZG+P4XDftdKjLtdv6vmo?=
 =?us-ascii?Q?PHffhh3wQjfTCPghftsOeot9/vMW3NJ8k94Oocm9UNE+z4Z8TeMF5fChsu6V?=
 =?us-ascii?Q?9RQ5AfrhhzhiasLF6CtAEYx0qETPY3cqJAKf5/CbRNdFJpzOOA/l0uKOOETX?=
 =?us-ascii?Q?QbKCZR955bYpncNyt5moqqAlQMwzNpffoyH+HGXF03IQaWrjQVNafLcw9sf+?=
 =?us-ascii?Q?Tw+1vuhswGsvgB+/fb7GZt8yhXgDreRB0G5pp7UCsRZv25fBeO0/lN/utxNJ?=
 =?us-ascii?Q?FJuazYzv3balzUAPPLAi8ap/dGPPk0oGunGyLvlImPY6OocPIedQQ2Ub2Lek?=
 =?us-ascii?Q?2cCU1pcCYcmUOvPeu1IyA1o9eSluxZn/JPUYkCtFexxefEboIn1BIOnFjW5D?=
 =?us-ascii?Q?8wKOAWIre7Yy3ceHbgGYoytfANNAh0JxIYwAwz6KlUYuWCqrjWTTZSICh82y?=
 =?us-ascii?Q?zOSX93jlM+IAYxa0B7ehY3bZxw9avLrW9hIqcHljBW7Nh8mSDWfwFjqAGBA+?=
 =?us-ascii?Q?U9CypwrNqnNYtr2NZ4AdiO9pZMWJlrNAS/mG5FjCJtJ3JuDp5FaUpU66fEKC?=
 =?us-ascii?Q?0f/CuogvkFrBpHbK0U5L5jQntRrcodW7TailvQOMV2JnuxwvjeHTagh0ntHP?=
 =?us-ascii?Q?EGxIvRJEg0/yF7jUB6dFDvtowb0ne3rhYXn2DAcUSQ8mWOfcmARUdw/b2P7O?=
 =?us-ascii?Q?LOcIy3UZ4tm/J9wMoIephh9qzuWKz1Phe7d/urnojNf7sNoM0PeBikRJZJSs?=
 =?us-ascii?Q?rX3WjEh0lyt9N8IGPrICzQYg1Hk6lCKlwXiyri9EfHhmcqCZ2EwTNtDuMzzg?=
 =?us-ascii?Q?w5ByDLmJ8Oij/Yryt2JLNUitQY7CksCLeTZt8dAA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f17926db-abc3-4118-2837-08dc638b17e2
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 11:47:03.2794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tlm2lg5t7dv0IObkUcyQZivyoONMyFxbu/RWfQeQvgR4WuvMaKOPNKhgUX+H1M6b5mHteVxDzzPF8DtO9euokw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9120

Hi Frank,

On Fri, Apr 19, 2024 at 02:38:19PM -0400, Frank Li wrote:
> On Fri, Apr 19, 2024 at 04:49:13PM +0100, Will Deacon wrote:
> > On Mon, Apr 15, 2024 at 02:13:15PM +0800, Xu Yang wrote:
> > > In current design, the user of perf app needs to input counter ID to count
> > > events. However, this is not user-friendly since the user needs to lookup
> > > the map table to find the counter. Instead of letting the user to input
> > > the counter, let this driver to manage the counters in this patch.
> > > 
> > > This will be implemented by:
> > >  1. allocate counter 0 for cycle event.
> > >  2. find unused counter from 1-10 for reference events.
> > >  3. allocate specific counter for counter-specific events.
> > > 
> > > In this patch, counter attr will be kept for back-compatible but all the
> > > value passed down by counter=<n> will be ignored. To mark counter-specific
> > > events, counter ID will be encoded into perf_pmu_events_attr.id.
> > > 
> > > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > > Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
> > > 
> > > ---
> > > Changes in v6:
> > >  - new patch
> > > Changes in v7:
> > >  - no changes
> > > Changes in v8:
> > >  - add Rb tag
> > > Changes in v9:
> > >  - keep 'counter' attr for back-compatible
> > > Changes in v10:
> > >  - add some explanation about 'counter' attr in commit message
> > > ---
> > >  drivers/perf/fsl_imx9_ddr_perf.c | 168 ++++++++++++++++++-------------
> > >  1 file changed, 100 insertions(+), 68 deletions(-)
> > 
> > [...]
> > 
> > > @@ -245,8 +249,8 @@ static const struct attribute_group ddr_perf_events_attr_group = {
> > >  	.attrs = ddr_perf_events_attrs,
> > >  };
> > >  
> > > -PMU_FORMAT_ATTR(event, "config:0-7");
> > > -PMU_FORMAT_ATTR(counter, "config:8-15");
> > > +PMU_FORMAT_ATTR(event, "config:0-15");
> > > +PMU_FORMAT_ATTR(counter, "config:16-23");
> > 
> > Although these mappings are advertised in sysfs, I don't think we can
> > change them because userspace could be relying on them. I also can't
> > find any examples of other PMU drivers in the kernel changing these
> > mappings after being merged, so please keep tthem the same.
> > 
> > If you need to expand the properties to be 16-bit, then you'll need to
> > split them into 2x8-bit fields.
> 
> I just see tools/perf/tests/pmu.c: { "krava01", "config:0-1,62-63\n", }
> So I supposed "config:" supported below format
> 
> PMU_FORMAT_ATTR(event, "config:0-7,16-19");

It works.

Thanks,
Xu Yang

> 
> I just want to confim with you because I have not found other perf driver
> using such format yet.
> 
> Frank
> 
> > 
> > Will

