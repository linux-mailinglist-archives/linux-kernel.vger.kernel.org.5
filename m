Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857827CE8B9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 22:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjJRU0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 16:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjJRU0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 16:26:18 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2076.outbound.protection.outlook.com [40.107.22.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1A0A4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 13:26:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDtLtuggljtYbuTHxZJ7ELEU7E02s8W2LKZgzs63bUPhTF0hBs/8wtEqUisT1yd0ub1eAbbRjILdkPpHPwfFxUVxYaLEJ7Ft7KVzP3xnSBqtphMYq8lY6ZDV8U776dSCN6KVo/fO4feC9dpR/bIhSxpiT+1KEfKoBQ9qN/D7bUMrIyxBBuMSASlzN4viZfrxRjejUDWr2RM+a86IkvwPIo0mUgJBUSpkWT1cSfIIeWAW+izhibbPZwmceWCUliWZ7huOu1vw4IisrnL00CSFDE8SJrRiX7zzt/iul81lyxkRkFOWvNiclV7oZMKwMclG2BdJDL05gEq34KQ8LVDGIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8R8QGutBQBbPOEgDJuZhR2Q2xgAwuyyjCCxrmT8O8mM=;
 b=PO47qFkRA78Ae4xH3iZgl4F/WaZiDzgF0VHsv1czMufvjTcIrtk8kaow5zXOjZAnwrUFeWLDI7vLGYqaRbtVFtbCEssNmd/3/5zjDL9ahrKXf4ATtvMz+mAhXkkzzLOO7DNYMiqExJCAbDhgIwPCOkCKeOtYbg+Xx98XZ0ZzZleCL7L7eG3/JFzUSAZngb5oFBRn6EOZGGPLCNpOeRdZ3kZxsZByK0UtLmy6HGUxyClUvNKfJQbPY2VLQvr9KHD2EyZFhidy0Hmh+/CGe0MsWM+K6PM7HgyB8cD8vxHcybIhRN4lJ7843Gr/fNIhdLU1Wl8cJjfM73hz7kx8xqa0nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8R8QGutBQBbPOEgDJuZhR2Q2xgAwuyyjCCxrmT8O8mM=;
 b=mp0+YIDuAfusFPdZo0kypN+nsMqAbago5MzWo0wxf4tO/cDhN56OPkhDkc+u472rULyV0B2PRni13AcV2W9SdQ57EYV1xoWqHLvUJDrsgOPxik1gYx51QkTvsfuhe02VvOvDz5AovsZLMuyPYPi/r7blGiFDYAa8bu/Xt32gA/o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB8401.eurprd04.prod.outlook.com (2603:10a6:20b:3f3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 18 Oct
 2023 20:26:13 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Wed, 18 Oct 2023
 20:26:13 +0000
Date:   Wed, 18 Oct 2023 16:26:07 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        joe@perches.com, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH 4/5] i3c: master: svc return actual transfer data len
Message-ID: <ZTA/X333KBXDN49p@lizhi-Precision-Tower-5810>
References: <20231016154632.2851957-1-Frank.Li@nxp.com>
 <20231016154632.2851957-5-Frank.Li@nxp.com>
 <20231017161007.146a5199@xps-13>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231017161007.146a5199@xps-13>
X-ClientProxiedBy: SJ0PR13CA0062.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::7) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB8401:EE_
X-MS-Office365-Filtering-Correlation-Id: b6940017-9d14-4f2f-cfbf-08dbd0187912
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +9bMSWmz/qbUhs8OoQ9SMGrnNj4u9E+r5ePqLHYVxYccLJuaV9WS4Gd2rlTGHnBMVo51cLGGVyyWV5nmAjRFVKKjERwSZ17tPR046vGX6zgRILgI8q7xn0ZxlzypKKR5nmNt0FP3sInmZVtdEggBAK3gfoyi8UPRTZ61oOE1OL0G5utupDuNwvMKEiC352HVDUJ+9nqDY3xOFj4lY5ey37Z7C8dF9iYRMcRAk01SoS90V0jNRdT4FAXlmk3WR7moPbsM1nPy38xMsKxg1BuHIDm8waSO26+PKQr8BLiXJ6U3y8ghFel4jHnXP5R8PzMhpuFvdbBoEvMofx5mTQYj4JjST3UIKCwV5/TyTPmgH/Laf218WgkAmtBOaXKSsIDfMRDynyEWX5a8C/pLIb4aIetX75T7+vBq3qzXr2TARiETJZNAPRo96f4O0gTZbz7ufrYequCECmaDF1LbJ/ePbBay/glZerFh+jJ3WLinnNlfOuYFVhf7nDi1Pc6gqiliuvUZ28HKiJf4wDT4I37DzMdX+U2GR9jSf9RtK6BEhjxiX4a1UabGx6Wzdu5PrZ2FPOOjYFIINCIZBJDEvXcQyoSfZIeVt702ko+UigKuTug3g9z9Jod1GqkeAunVW4Xi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(39860400002)(396003)(136003)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(83380400001)(38100700002)(4326008)(9686003)(6512007)(33716001)(86362001)(2906002)(66476007)(316002)(66556008)(66946007)(5660300002)(8936002)(8676002)(6666004)(6506007)(52116002)(41300700001)(6486002)(478600001)(6916009)(66574015)(26005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?nN2nxMxFiLL8+x16i8MhLfTaV4Ufum6T8fg5Cta2Wb9G2I9jd4e8tLaret?=
 =?iso-8859-1?Q?EzTxqF4qyFO066jzv/RzxOKI2M3ULPPbj07/6KJr0LLqEK+NI3uJmdfba9?=
 =?iso-8859-1?Q?0QbYJTXCDzBUNOanFf/4rjEbInhtr+uPmr6t5la/7ijgm+e49HFMFirFdv?=
 =?iso-8859-1?Q?7g5tHNs6kAyEkGdTk3VIJ96kc0kLb2dvjS1wQRTPSBnuaDQySGcSCy/MXR?=
 =?iso-8859-1?Q?rE45d5lDDopAE+TWeEk3SBeJNZGt3sKwbybTlZo+NtfEbhJvScdJifvI4K?=
 =?iso-8859-1?Q?bJBBnOcMW5ganB0QDejLpl1iElohD4m9MgUCbTMI50gz+wXb/QlzlEK4v5?=
 =?iso-8859-1?Q?SNIrawPW1rjLWaJE983Ml7TmiW2AE/EYZgKhMW9bNvlpUBJy9cyNJE0j4M?=
 =?iso-8859-1?Q?/THIQ9i+eIYUFDkpgZR4MYuGHrxthLg3ALYRjkkV82ErJ/UWqHZUCLwA1C?=
 =?iso-8859-1?Q?Jve84W8Mxc849UoB1mds4JNEUbqtPw3zgj8y8l0IyCkdpARYbY08B28OUT?=
 =?iso-8859-1?Q?j0pJwXYVO+17VjE8ts/ag4RrrZYYqRQ+Tf4DA7diZOmsqB0cJG4bUo4edJ?=
 =?iso-8859-1?Q?/t49mp5xJNYxMMAvxjnofY5lX9WDXdgV/VhWfjCWJsZtoNd0gUCT35CwJb?=
 =?iso-8859-1?Q?VjBExrwrbi4wQgomFsFg4aGivJglssz52u5TqjENXDS2jt+7XO75vwnNum?=
 =?iso-8859-1?Q?BpLyo/gffoAnJ1enfXrJJZr7MCv4uX2PYp20hUuOtdww4RId5a6nCm+bot?=
 =?iso-8859-1?Q?ajSOirxZc4c9gJjFJhHFnpyZsXN4fwmtCXbFPr17Urs878IV77L+B//EAL?=
 =?iso-8859-1?Q?QdlnSXnFql2JYAURE2QJP0WdzQUgrPo2W/YEFjRVVRhElNTNM1ZRQIclzw?=
 =?iso-8859-1?Q?uZE89O2Qjdv9fMyDqew6W1lY6q+pIirunsnK7yUH0hmllo0G6GhwZ1bp80?=
 =?iso-8859-1?Q?rT5HbruFni7lC888KDpxnt2q9R8J9/a9OZedQ2e+yW4scLftWI3XPO7+ug?=
 =?iso-8859-1?Q?lI70zfDz4m+rIUIFLzv4DezhYy3h9mGGwvrQYLblNdmNS7fCCQ8BsGzv4g?=
 =?iso-8859-1?Q?SOPFaTy9pn99p0zZgAlsdY5pqjmPFA4tJ3kCRPQGVB16y9h6F2HqLuFr05?=
 =?iso-8859-1?Q?0Hb02b6VKKmCezuSz1pHKkxJrbD2Lmp9ZwFu2vSOTsveN9+RLvbSf66NWp?=
 =?iso-8859-1?Q?Xwh2cy91VDYBuRcEiBme9MhrglU9Fu9ACYHprViSo8uQmMEqlMMVWJmeJT?=
 =?iso-8859-1?Q?nGZlv5r4BlZtuRhfkfbnJWx2YdJWpAOeHtMsOMREr4qrUt1abybPzpNGwk?=
 =?iso-8859-1?Q?SsUlVHOk7dldYN03qYKlujY59UtCNOpb1K2bA1B2ZNHqF44OCKw5R0kqwB?=
 =?iso-8859-1?Q?nM6Wf9kJZbbjdfuzJDzKPv+VKjhlGpOWUncuuA7XPfXqqCavgasBafeKXz?=
 =?iso-8859-1?Q?avpUKQbZzfbfshCSHukKPSjvMGw2l2gFaDanfXu1xjPnYj4YI+jwD1WhQP?=
 =?iso-8859-1?Q?k/ToCMbwmxRnpS35t9Wk+1ajH4Ei1OlGqYtnRawqBBHJxoQLqbOtzA6XE+?=
 =?iso-8859-1?Q?vrxNR+FMAvXGY2cyYmy6maL+ByAPzSUV72RMJLoihK96+f5a1/ARYEct0o?=
 =?iso-8859-1?Q?YpJgI4/2VONZxVJzgXoksw3MDSsqBzg3Cm?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6940017-9d14-4f2f-cfbf-08dbd0187912
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 20:26:13.4653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: inrwIGaTDtzfr20OPzwJ4mk7XAgEwxr+SDyVv1+mT6pxC3mVVAFIQGo58kW/ldqQQQ2OOpecqipaJKUNOO4hdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8401
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 04:10:07PM +0200, Miquel Raynal wrote:
> Hi Frank,
> 
> Frank.Li@nxp.com wrote on Mon, 16 Oct 2023 11:46:31 -0400:
> 
> > I3C allow devices early terminate data transfer. So set "actual" to
> > indicate how much data get by i3c_priv_xfer.
> > 
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/i3c/master/svc-i3c-master.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> > 
> > diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> > index 3570b709cf60..444825aafa6f 100644
> > --- a/drivers/i3c/master/svc-i3c-master.c
> > +++ b/drivers/i3c/master/svc-i3c-master.c
> > @@ -138,6 +138,7 @@ struct svc_i3c_cmd {
> >  	const void *out;
> >  	unsigned int len;
> >  	unsigned int actual_len;
> > +	struct i3c_priv_xfer *xfer;
> >  	bool continued;
> >  };
> >  
> > @@ -1045,6 +1046,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
> >  
> >  	if (readl(master->regs + SVC_I3C_MERRWARN) & SVC_I3C_MERRWARN_NACK) {
> >  		ret = -ENXIO;
> > +		*actual_len = 0;
> >  		goto emit_stop;
> >  	}
> >  
> > @@ -1062,6 +1064,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
> >  	 */
> >  	if (SVC_I3C_MSTATUS_IBIWON(reg)) {
> >  		ret = -ENXIO;
> > +		*actual_len = 0;
> >  		goto emit_stop;
> >  	}
> >  
> > @@ -1157,6 +1160,9 @@ static void svc_i3c_master_start_xfer_locked(struct svc_i3c_master *master)
> >  					  cmd->addr, cmd->in, cmd->out,
> >  					  cmd->len, &cmd->actual_len,
> >  					  cmd->continued);
> > +		if (cmd->xfer)
> > +			cmd->xfer->actual = cmd->actual_len;
> 
> Just to be sure, wouldn't it be more natural to always fill cmd->xfer
> rather than checking it here?

cmd->xfer is NULL for i2c and ccc transfer. So need check it. 
I will add comments here

Frank
> 
> > +
> >  		if (ret)
> >  			break;
> >  	}
> > @@ -1344,6 +1350,7 @@ static int svc_i3c_master_priv_xfers(struct i3c_dev_desc *dev,
> >  	for (i = 0; i < nxfers; i++) {
> >  		struct svc_i3c_cmd *cmd = &xfer->cmds[i];
> >  
> > +		cmd->xfer = xfers + i;
> 
> Please follow the same pattern as below: = &xfers[i]
> 
> >  		cmd->addr = master->addrs[data->index];
> >  		cmd->rnw = xfers[i].rnw;
> >  		cmd->in = xfers[i].rnw ? xfers[i].data.in : NULL;
> 
> 
> Thanks,
> Miquèl
