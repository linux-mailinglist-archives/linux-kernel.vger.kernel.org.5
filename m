Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2D37A8884
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:36:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235405AbjITPgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbjITPgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:36:50 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2070.outbound.protection.outlook.com [40.107.104.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FF8B9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 08:36:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYoRJ0BfeMy28zK770K1fy6O3Xre4xKYVEK5S/rZxbb/d8ohK08lHxvwkzVkxtuih14huB4DTNJXxm8W7Z/L74ZiZelZs8ou68bg+wZf+1i8yjBkE0evhhkm40stFCtfyAlrzmR6dJ/FtfItDjI51esRyN2Cf0qUzy1+hH2h1mLlZz2crqYaPq744eHW8xqWVZ7LtAGAa4jQeCgF1yAHggmzvrft1Lez+njwZ4pdTdnd8tLLjd79zdE+kkoFYCN27dnpRPlDgSPDIc3RBNQ132QZyPsbXa/lnB9YIBOETXYgw+VeqeB3tlFIP/FlPpOb8JdQfD4tIihQ9IiBwOYyGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pUPoKTtJAGz2bWN3S7LB+iQwI/DdO5FNtE1ERK6mLwg=;
 b=ivEtjpBnIo8rXYvYxwuEanTZQqORjMb72NzBo6cBv+0M3zMwa3Zvbn6C2SCMkBf/yedaveDkALnVp4uBl0cpPBtVHrG+aaEn1jebW+c9NKLdE8tMQeHgnXuRWmtkFxd9Gk4PGpMvrOrXajNmMvOjD70TiG1axVCaee1S1JUq2jyU7wGuhAt0Xv3RVoOyZUKzgPL9Ke49NOcVE8ipfjA99ukdLwACtL61QY8RBnrUkN0moMq2GnnymOipi6jVLD30WnTxENVAgTIH03yoovSD2sI61ct7xWLDo4640302scGK5hA9OPIywRaxuao9iHVcUmFn+1GEf98MZdoh0UZ68w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pUPoKTtJAGz2bWN3S7LB+iQwI/DdO5FNtE1ERK6mLwg=;
 b=qTCXZko4RQyy+myTEfjdSYZNH6zuV4JcVgre0lnrwps+CtLfbL87qG7kbJOd9X+u/jKYj+wq4w2iZuGF3DxnJWUVD4KgRNy+g8uztPxHmzGWJi0XtnHpnxa45Mv4rMhifoBi8vY666ryzVW1rzkxvwsIrb50DQ6Azk2gj/NciTo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com (2603:10a6:10:360::21)
 by DUZPR04MB9748.eurprd04.prod.outlook.com (2603:10a6:10:4e0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Wed, 20 Sep
 2023 15:36:39 +0000
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::51f9:b8d2:7ddd:c74f]) by DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::51f9:b8d2:7ddd:c74f%6]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 15:36:39 +0000
From:   Chancel Liu <chancel.liu@nxp.com>
To:     lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Chancel Liu <chancel.liu@nxp.com>
Subject: [PATCH v2 0/1] ASoC: soc-pcm.c: Make sure DAI parameters cleared if the DAI becomes inactive
Date:   Wed, 20 Sep 2023 23:36:20 +0800
Message-Id: <20230920153621.711373-1-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::13) To DB9PR04MB9498.eurprd04.prod.outlook.com
 (2603:10a6:10:360::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9498:EE_|DUZPR04MB9748:EE_
X-MS-Office365-Filtering-Correlation-Id: ca98d04c-5b2a-4952-0030-08dbb9ef6204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V2RnLZisZ6/StIBSTRKQp/SMLfqaXYLiAW3C2/9lLlzJZjPXS3naxgvkQ13cc6BcRztNgLX8dO1/9HeSR3ShSgL1gxV3ELl6mRCkNzfGKfis6BGomuQbOmh7NDxyaaZgs/AycH7tZirVfZbawc9nHaP7mS/xwlll0SiDhyNF/tPqgN05pLp5XsHnPd9q6cB7x4dP5eCM1luB26+nyDOHQG4M6z0jXCCfLFcG56//EJZsWTgAAzSOL9WsGe/8a0VLKdMhjKtsRx8ZO1mPbUpR6KL8nkDeHmCbXlaKegXRbsubDspdHPP7TzPnlcEFMS7aKH964/zkBPDuqMFBmJOAEN/OZHw36yRS4xWZ09k8kb0h0DnjF/NKvKYp+OCdWqdjSrhM4i+3hMSWKUO6oP7q6uWTAJLnEfLmmkRpZEv4q+Pnjrrw6JXJMyj5BfYy4pDTf+lp8bQ9EUop8p88NydqGJNtplT7NmikSUhkZ389eZnu0Y3Kb0U9tZvQyrgK6tluJmgvC/eF8EV8x1qZ34kMq+ULYc6cNIEq/yAHXpgA4oqGXBc+RFz3ZJO8MvmDdx8KUcInANar7fIXIaUtPuueUQT7CSyOFCl/dB6Fyq1G05w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9498.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(39860400002)(376002)(186009)(451199024)(1800799009)(966005)(6666004)(6512007)(52116002)(6506007)(6486002)(36756003)(86362001)(66476007)(66556008)(41300700001)(38100700002)(66946007)(316002)(478600001)(38350700002)(1076003)(8936002)(4326008)(8676002)(26005)(44832011)(5660300002)(83380400001)(2616005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?10kqLl+vnwnZPC/NVGUeJzAnBbZR2jokMNFm9U8BcvsmvUXe5vC+uRp+w5pk?=
 =?us-ascii?Q?N05BRmpJJ9VyxOF+Zr0OLGjPgBAhgnEEZdcHombMiLRs2u0CODG0mQ1Ryda2?=
 =?us-ascii?Q?mKwC1qW6EWHdTGNIx+nVBiOKpJUNCBoz2JCFtDoeaWDz15o1cAm4EL+KyiiI?=
 =?us-ascii?Q?X9B0cjZrfTTfLmVqNgLr8m6uY3Mvk/kONknRfCtm705PoQCw3fIuvIhik0lU?=
 =?us-ascii?Q?93efHcBdbcTUFnAV5/rZKHCTcAG85+ShnCavSWgt0vEHy2XZC9UxYhg981YW?=
 =?us-ascii?Q?4k7aXWukvE59AVG4VtszjXZnbMgHZ3Av8tWCQHnvFaWnUo+kKwbfNF5oIGVH?=
 =?us-ascii?Q?iVN07Fqpl/kuHEQwmYCO42upXiRHAll1atwoEqDLy8SL2axPkBYPzHVQx1mv?=
 =?us-ascii?Q?80bEoIbkfFWPIQL25xNcZJJ009qZ3dOsVgq9ntqmsZF015lJhX4D8B3HQF0G?=
 =?us-ascii?Q?zjHlZgHUntkLxXeUFFLFqH/bpIh0IpamN4nL0lQYJkZQqFw2WvzysMmj6sMD?=
 =?us-ascii?Q?APZ84MsGa/Dzm3GqB8bmNJyZKgR4jJeT0zkBqY9A/OOHL/SvhYTZBIgoUdIW?=
 =?us-ascii?Q?ovTMRorhMbiAxiviVWbp1XIk5/aTXd3OlXyDs9h4rhQuDoSemOnhuMK0hipN?=
 =?us-ascii?Q?lg04U4Mv6hERL0tX+n4dyj8O/h3CZa7iJGv3tTL30nrJIeffloUqj5YP1ojx?=
 =?us-ascii?Q?+ThNyc7JaoE2dfdWMUxv2V7SwA7oy+52dxClXHx8SQJK5cDQx1JdXF1CYO34?=
 =?us-ascii?Q?VgpSJT4+94mKmWTHe8vT2GOJtigkSu/6S1LdpDhRrjTUKbiHztw42H0j1K/I?=
 =?us-ascii?Q?sWk66xqjRvG9L9U7o/BId+LTb4ZCL6+M3lEnZRFkYxG8V9Na1OqpOg1Fn5fI?=
 =?us-ascii?Q?rk2JQprtxMo2lDJ73SazMz6y4HSyJuZjWTj2CzXgksk7jMnXpeiTYTJU/l+g?=
 =?us-ascii?Q?Lm2RvQ6utrvwQC/oCB0f6o5uof3sVFc9/t3FCosxj6JaGpmnt9MNBvsfJdcl?=
 =?us-ascii?Q?dPGwvhMndt3NzkN1ctcuzsFm6QYnTPJN/n4SQLujXmEl/FsYsqbW/gI5VUOH?=
 =?us-ascii?Q?4a44jafsHhXUN3wlZaHkBnOgQjT2BiaCdTzlw7fsU9dz90vu0ItgM54u7c/m?=
 =?us-ascii?Q?gm1D0Algh/Y5di9zYIT+JV3sAkeByojyaQYQG6apLcA/AmeiXLXXafVcZwM2?=
 =?us-ascii?Q?NLsls/dIi3YXbGGIh00HnLiLnz9uK0FXhyn4CtNvXTIEum+bUZ2o1wKr2ipV?=
 =?us-ascii?Q?P7ID3DUCqTIoCm1IsqDsylHlP+pOirYXnWUGAvjzMpoT7KqJZz643/b56bAf?=
 =?us-ascii?Q?vGid6RiRbh+4gkrxh1/N0HSHjdwAIWDNkVftyk4A1HWFGrTmOq0erOHJBZd7?=
 =?us-ascii?Q?8oU23s20QUX2DhHm2PAdIPyGbUujUoy3q6xfzSKEnI7NNYLeGDqz2hKA3Kwy?=
 =?us-ascii?Q?Nlh2OrzN8mV3p8YLfD5uVKKSOF1qBiDoAhNuPnK3IOhBYL0uLAOjReG4WG9X?=
 =?us-ascii?Q?QuHSW5lBDqgwDDyl3P9mEe5Mpt8wdlFsDn4AaZ2JMYfPlDkQNKvQ4p5wmUSW?=
 =?us-ascii?Q?oJFu6qXJ/4XdFlNxuOeioElLrYjiiBKWqYBHUZrO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca98d04c-5b2a-4952-0030-08dbb9ef6204
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9498.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 15:36:39.8248
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ahxiEhQAoVwPNCsLw9bjbz1V2ePvVVDnKs0MKPTzehIn1f5yAHEJjRbvnpW63apPw9nBYCpajcWt+LBXF9clNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9748
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's reasonable that DAI parameters should be cleared if current DAI becomes
inactive.

Only check DAI active status in soc_pcm_hw_free() is not enough since there's
the risk that DAI parameters never be cleared if there're more than one stream
[see A]. Only check DAI active status in soc_pcm_close() is also not enough
since it will cause the cleanup just happening in soc_pcm_close() [see B].

[A] For example, we have stream1 and stream2 for DAI about to stop. stream2
executes soc_pcm_hw_free() before stream1 executes soc_pcm_close(). At the
moment, stream2 should clear current DAI parameters because stream1 passed the
cleanup stage in soc_pcm_hw_free() and stream2 in fact is the only active
stream which has a chance to do clean up. Since DAI active status is not yet
updated by stream1 in soc_pcm_close(), stream2 doesn't know itself should clear
DAI parameters. In result both stream1 and stream2 don't clear the parameters.

[B] Suppose a case: aplay -Dhw:0 44100.wav 48000.wav
In this case, we call soc_pcm_open()->soc_pcm_hw_params()->soc_pcm_hw_free()
->soc_pcm_hw_params()->soc_pcm_hw_free()->soc_pcm_close() in order. The DAI
parameters would be remained in the system even if the playback of 44100.wav is
finished.

In conclusion, it's better to check DAI active status in both soc_pcm_hw_free()
and soc_pcm_close() which makes sure DAI parameters cleared if the DAI becomes
inactive.

changes in v2:
- Patch v1 link: https://lore.kernel.org/all/20230112065834.580192-1-chancel.liu@nxp.com/
  Patch v1 tries to introduce a usage count called hw_params_count to fix issue
  on DAI parameters cleanup. However it's not a good fix because not
  considering hw_params() and hw_free() are not symmetrical and hw_params()
  might be called multilpe times by user.
- Both check DAI active status in soc_pcm_hw_free() and soc_pcm_close() which
  makes sure DAI parameters cleared if the DAI becomes inactive.

Chancel Liu (1):
  ASoC: soc-pcm.c: Make sure DAI parameters cleared if the DAI becomes
    inactive

 sound/soc/soc-pcm.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

--
2.25.1

