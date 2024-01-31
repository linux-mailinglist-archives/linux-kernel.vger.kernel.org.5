Return-Path: <linux-kernel+bounces-46227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 689A7843C7E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D85C28CDD2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240A269D02;
	Wed, 31 Jan 2024 10:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CYf20RDC"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2050.outbound.protection.outlook.com [40.107.7.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A62969D0A;
	Wed, 31 Jan 2024 10:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706696724; cv=fail; b=h3b5sVqjrpkDSsZfSVOHN/G9AKL4tdiFNo6g6kdcbeglEbM+2fwwt0vb9mlhkKJx6N66IMBo4lj+C+YhWHZmjRq9hh5FYSJ+Jd/rhV+77hjFkquMAqkO0CAEDpBJtu+JYUvfULZ8xCAK3eHnJP4KmY1ULtdL8reqbpajas2eLIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706696724; c=relaxed/simple;
	bh=jsN1reSX+vofWCG02FQw99rh3oTIgbgRqj/C5c+ZQyY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=XM8q1q10kqNS8cQkd4iOkMqlcUM5FA2aoJKKHozMjQgD9y5+Voc32jwYmdoteUeGRpHRNahUs99M4o/wI/pbtzdh0eVs3HbnjH6BXF2NGPgMpXgXj543zuicL28DT5tgGaDZd51nAPeqcbbhx58ZiDE3o/maDlMUdBYe01IBjlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=CYf20RDC; arc=fail smtp.client-ip=40.107.7.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vgr8m4FbS38HErHjZ+vOYMDdkkUFENmgP7nGCHFMxsTVXLV2FbyKvaZTXZPKREdQoBbZMgc/qmI7PSAHKOaUcBoZho37+HNJI8SSxKHx8cTm/UOgBAwWDZJEThnmNVC8Wz5+bZ3XvLgNdGUUR2SDvKwmndfpQ3H2p8+Gaf8I3lnJp19Ep97K7/NURwLQOpsogwEFKNpkMpJFJGj2mEAMksWKXSPZ/YGrgg1KtsWN1BaJJ37eishFZvn3dDmljJE2Y3vXrzOAAznPX+2AnP+Ie2e4ADgAtQKxw6tcevfGBEHdJvjlU2c4g8phd6CytmoswiYu2JKMqO3lMFSZo9PtIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/yCEP2efY3BDLsHt2sHwe1I3OZZrrBn/cRgVy0WhdI=;
 b=RyIvyTWyz99NTxml5y6xhp+gh9n52ZWuitTNMLpD4dLiZYzosEk3oDS/med7glhkUUwEeysKOBKUdgTC+ewJlpL7pLXuGlzihd6kDOH2Plpw0TheFEpvFuJaomz6oyZ3YDHORMk7RFGCBuAqvrgTgKxm61jqEkuEssjltWp8l+4Jx5578Qqnykdl/lmC2xINSBSzZ2yN+xZHyloVjXPJddrSZuDTuA6WNkzKA4t6o+AQ9EDZE7cl6/ZdkJl7zpo2c/418gqEoDKTAWWiFV17M9/xuVOztSwkeGzeexrq8KEfuHuu002tnmBlzlTpSkPbI/oectmg5UGmHmouG+GsOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v/yCEP2efY3BDLsHt2sHwe1I3OZZrrBn/cRgVy0WhdI=;
 b=CYf20RDCBEdIQ8ij99TzJHkl8yXs2N6eriOTnDHNvIil8NfIczUrY4o/2+mjlugVXgcONZNIJv67N7PUeNjTXVJCdoJWKNoRYzI3izfU08TpBC6inetdz6JTcFnya4fG1y4S9Pv6p3LU4HaWLPTuIP+etnAL4DgfLGp+nrT2Ass=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com (2603:10a6:10:360::21)
 by DBAPR04MB7448.eurprd04.prod.outlook.com (2603:10a6:10:1a6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Wed, 31 Jan
 2024 10:25:18 +0000
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::2a3c:9a90:b09f:293c]) by DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::2a3c:9a90:b09f:293c%3]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 10:25:18 +0000
From: Chancel Liu <chancel.liu@nxp.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	kuninori.morimoto.gx@renesas.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Chancel Liu <chancel.liu@nxp.com>
Subject: [PATCH v2] ASoC: soc-core.c: Prefer to return dai->driver->name in snd_soc_dai_name_get()
Date: Wed, 31 Jan 2024 19:23:51 +0900
Message-ID: <20240131102351.469214-1-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0015.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::21) To DB9PR04MB9498.eurprd04.prod.outlook.com
 (2603:10a6:10:360::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9498:EE_|DBAPR04MB7448:EE_
X-MS-Office365-Filtering-Correlation-Id: 88b3c61a-8f33-4ceb-04cc-08dc2246ec46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3cRcVr5Iz+UTCmcIAapKeg2tFE8IQpod09ytOoDxvPaGla3x8spFsa/n6vEX87faxytmOnXIveBPFwNq1oNVsnR2UwAF5Sv/b4LZNj5Z6EqiF74gWl2muLGOvLMafwfLJblD/9sH/wJecdP5RFKvXIZ6d03WlWmt37ksGQUVw3o8ru1Uii1YAHs4jPVUplxo7XgUqiGMZjYrsB6eG64ryIL69K0Of5vedmypxzi6catOac1/gAs1BV7Y3Ck2VQx7sCt5Oik5QBLGRHX/TOU/3s7NEncqxJqj28RDcYLcZXRdqh5w70gzx6xq15SUxGYkt8nIoiDDdAj+dRtVv6zviVPka/5/5pQqfwCSuXNhnk3cmndhUC20bkodrf/2GzMLsBw8Bo9g3HJEAJjUPiisb2nZ3enc+cD6qby/GEgwIeYWQGJtl5G81Oyi2A8He8n6qmrRLceTmgQn/ZBpzfpHvLVwX83f32+WQVr1mWtQdWG9csDXUHgRFXeuVuvSd+vbk1qt4Rx3kKXdDF454OGBc6bXpoCo9HWNM0AXUHRc4c9+0zkkfQlM/GucXGB5hWK6hThmPTCFN+jt1FA1oIBi29FRZXgFzS+hC6UvdwEsgTwqnLnwYj8g3H5WUh33IZIg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9498.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(136003)(376002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(41300700001)(26005)(1076003)(2616005)(6486002)(38350700005)(36756003)(478600001)(6506007)(52116002)(6512007)(6666004)(83380400001)(38100700002)(316002)(86362001)(2906002)(5660300002)(66476007)(66556008)(66946007)(8936002)(8676002)(4326008)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s5kjyfj87mzRwBTM16bKRdJasTXST5U/Ov+7aD9+jEcgz5/S30j/dCer14Iz?=
 =?us-ascii?Q?B6vqT1IrsaeOGDFBt87Kr3jeo22Wh5GVtQfxT67dcGiWr77usQBd21lRwvl7?=
 =?us-ascii?Q?YFCzvo9u+S8wmDy0Jdm7Nvw+zosJLOnEnSRBxPlMbxg/drMMTVHyOS/xN7CE?=
 =?us-ascii?Q?tWZpe9WfOZmsJV1mo7QrsYrSYIWzeA2vLPZTV0rP++Pf7XO2L+AubwEM5wWf?=
 =?us-ascii?Q?IJBweMxCDPKOsuWiOxSc1cnAywjqTPXpnNQn5pm4tlO6xzx4B9c2AHfzgRP3?=
 =?us-ascii?Q?W7NpzgnwVcK33OI3J9E3/1g/A/xPavGgp8jpXy+fqhCcHFOltVrsWH+Yk6QD?=
 =?us-ascii?Q?4SAScW4XH/ETlhVCISs3yQnX3MNWQSibg1lPhSzxSvB8cmQKau31fpzb7rt4?=
 =?us-ascii?Q?HuqZcGNaCu2FnbayM7emlUxx+G96KnkDKPTtasCNDwix/Wr5PYEY8Q53ANQd?=
 =?us-ascii?Q?tBRWRVYPaWhJJ/nXUbsJzpby9G71+TqxaCTvZtJ2cnMmQybDOc8Ozkb/YFNT?=
 =?us-ascii?Q?qteoCTHgj3UMieLIvv7sLHy0j114Omz0L4C8kAdkaDM+DMUtqnzJXpyXVSL5?=
 =?us-ascii?Q?ohxTWSu34uzYdYN62xHk5N2fXWj/N9KYtHtMWOF0hMO61qdttt/AxWsNH/KI?=
 =?us-ascii?Q?NG620vNrKUT8zNE5umk0faVs50PU5u08rfwalTW1Mu8ODPIKvFbcZWHUw9dh?=
 =?us-ascii?Q?Cz57M9ddA8qHVzkM9F83jumFo9n4JN3dda9PCRyUUkT2XewjwL1//n59JHDH?=
 =?us-ascii?Q?Egel9zbxMIw15U3JjpqS63vWztBkpWjgyDStmx7YBZU5UN0VJXljcNJZ+F3n?=
 =?us-ascii?Q?EuCLfKn6o6UdiZPxNoY8smEl66fFfiRb7h6tLO61iot4igF4SLEonMtWNSPg?=
 =?us-ascii?Q?NhFiuhLamz2UBz5NQtydLhb/cI5cwvrzFbYK0Bd+cka+JSlIV/6RVwpmmk0y?=
 =?us-ascii?Q?5shLyVQ1GtqiO3C1rGXJ5TSUSbEjELzM/mOGJA0+goypcExlDls1pdD969Uf?=
 =?us-ascii?Q?FtxqE1uIrTiKd+RoWm39DYW6wpPmHvtjvgAdeHIr/J/RpOszYVFBksauuHTP?=
 =?us-ascii?Q?lyUqt9mi9A4vRXG0+pV7smO5zRxdPTk35J6XPK/BZQD3ItmledKplRgEBjEJ?=
 =?us-ascii?Q?HL0mVE0q+ZAWcVrKN30BFm34p5oc0XH8DiXR8Vg5fwvH3ZSYz9bKho1wv4En?=
 =?us-ascii?Q?lpav2MXreU+YDbI3+NtSLj2/Wrfj04E29fmoOmW2qDABZANk9/ZiyjiI4lKt?=
 =?us-ascii?Q?Uwh7QB1P+kUA6lLceSf/RNeRGSb0KtkwUycGbbDP+Pw2u9VziURm8a3kJuCU?=
 =?us-ascii?Q?KJ46FD8n19KP1cKHCf5fiS22s6TrjqRafquOap8ekgwjTwUkxNy9wSfW1DNF?=
 =?us-ascii?Q?tJa2lpgm58X4SRSjmvprXix/0yNJThpElAaUePaH1EtC8Bw5J6fB6uDBWyAN?=
 =?us-ascii?Q?1k54kkCIVHktdeUwFS48IyHhsoftQ+NMQsWFL5W91gwHA3WNXfcthyz8Ihm4?=
 =?us-ascii?Q?U/DKpf/SKLs8WpYkS04zIfOt5u+LB7ZsS7mwKgokcBq1CXP57eq0Bm7lgfUt?=
 =?us-ascii?Q?6jBs3w8kNWqQno+Q5OmUqEnKi5Eb+UCFjFbrL+/n?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b3c61a-8f33-4ceb-04cc-08dc2246ec46
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9498.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 10:25:18.8635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oquSCJSxaWyZTAFaG24QeGtaQf/75vbDsqW2MHLWZe5Vb8bD/Y7p6bohN7VkF+Ei6wkBCIEUka5QZ5zR4l4Wtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7448

ASoC machine driver can use snd_soc_{of_}get_dlc() (A) to get DAI name
for dlc (snd_soc_dai_link_component). In this function call
dlc->dai_name is parsed via snd_soc_dai_name_get() (B).

(A)	int snd_soc_get_dlc(...)
	{
		...
(B)		dlc->dai_name = snd_soc_dai_name_get(dai);
		...
	}

(B) has a priority to return dai->name as dlc->dai_name. In most cases
card can probe successfully. However it has an issue that ASoC tries to
rebind card. Here is a simplified flow for example:

 |	a) Card probes successfully at first
 |	b) One of the component bound to this card is removed for some
 |	   reason the component->dev is released
 |	c) That component is re-registered
 v	d) ASoC calls snd_soc_try_rebind_card()

a) points dlc->dai_name to dai->name. b) releases all resource of the
old DAI. c) creates new DAI structure. In result d) can not use
dlc->dai_name to add new created DAI.

So it's reasonable that prefer to return dai->driver->name in
snd_soc_dai_name_get() because dai->driver is a pre-defined global
variable. Also update snd_soc_is_matching_dai() for alignment.

Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
 sound/soc/soc-core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 516350533e73..847f92721fdb 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -283,13 +283,13 @@ static int snd_soc_is_matching_dai(const struct snd_soc_dai_link_component *dlc,
 
 	/* see snd_soc_dai_name_get() */
 
-	if (strcmp(dlc->dai_name, dai->name) == 0)
-		return 1;
-
 	if (dai->driver->name &&
 	    strcmp(dai->driver->name, dlc->dai_name) == 0)
 		return 1;
 
+	if (strcmp(dlc->dai_name, dai->name) == 0)
+		return 1;
+
 	if (dai->component->name &&
 	    strcmp(dlc->dai_name, dai->component->name) == 0)
 		return 1;
@@ -300,12 +300,12 @@ static int snd_soc_is_matching_dai(const struct snd_soc_dai_link_component *dlc,
 const char *snd_soc_dai_name_get(struct snd_soc_dai *dai)
 {
 	/* see snd_soc_is_matching_dai() */
-	if (dai->name)
-		return dai->name;
-
 	if (dai->driver->name)
 		return dai->driver->name;
 
+	if (dai->name)
+		return dai->name;
+
 	if (dai->component->name)
 		return dai->component->name;
 
-- 
2.43.0


