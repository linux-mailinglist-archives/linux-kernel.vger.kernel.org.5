Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54B267D11CA
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 16:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377590AbjJTOsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 10:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377527AbjJTOsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 10:48:06 -0400
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2080.outbound.protection.outlook.com [40.107.247.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C149D46
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 07:48:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDYXOOEqQsx7YsUB+SVirEJbrFt6S5qPv7Bq37R3HwjbMKB6G5/A3K9JF6KXHowec2ztT22f284w2TTUlJbERELO6818rGlb/khVO4tEDk1k0KsbaM3PAtjsgq6dYZa+UVRjBfIwhW74joqTvwgZv3SqbbgP4dV16JFhwpQeHn9ccGZVyBNsQw1hH7raHOIDNXxsBWvY6TivVlcZI0seITOaPJg32GY+mFqfa10x6dHUPmzHUBde9TcQR+uI23vxWmKTeIk3XuqTulJzRWMFlGfGqrCxnPbAGt3EZUyD7tJ/2Y2IRqniRPAHXpenG8Wc8yjw9ThD7HTzmjDKUIPCJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lt5BRVnYwIiYD+Z0rMuOPkDqMV5UrlZeXS8HstkPe2s=;
 b=L4hUh3zWLxE+xsBvVNYqkJHePxt+a/mleNBX1q4CQnlh2EaAJL1dgBumaBoXEtTYfyQueHxR2j70sZ72HXyrUciOt/gtus5B6cqH/5u32BN90kVCRUqt2309M8TC0U6WXl3yroy8yn+a/rScYFl+l+KAFBwUlGUrC3t9x5CcXe/74RLZulfy2onJ5toJmFT9YPp98QQssSBc5U6gu2lfgrGDPVLGwKVLjMWpur2uJU/iszGRUvs+i/j7pjKo1hTYWsSSZ41Lk1/1gDv9RfIZB68gr365XhEodhdb7sCr5SpbV/Ghw0skxcKrGQ4lJlyl0RxodQOucCF8USbxFhsClw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lt5BRVnYwIiYD+Z0rMuOPkDqMV5UrlZeXS8HstkPe2s=;
 b=VhN9AWdyyZ7oxXpizakAEiu6d6A7XbHWKZB8tLYNOL7fFvVmNUWHxrf/L/fnit52F9mzizjT38YEHj/MHZjXIhzyhNHVibpY5tVZM76Bes/fuy/yFTVbsuWErhfq5kKvt61O5vmhivmznghdDayHPmoIimlsXpmiovebFfp210U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS4PR04MB9484.eurprd04.prod.outlook.com (2603:10a6:20b:4ed::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.8; Fri, 20 Oct
 2023 14:47:59 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Fri, 20 Oct 2023
 14:47:59 +0000
Date:   Fri, 20 Oct 2023 10:47:52 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 Resent 6/6] i3c: master: svc: fix random hot join
 failure since timeout error
Message-ID: <ZTKTGG7J55Sj19Nd@lizhi-Precision-Tower-5810>
References: <20231018155926.3305476-1-Frank.Li@nxp.com>
 <20231018155926.3305476-7-Frank.Li@nxp.com>
 <20231019084452.11fd0645@xps-13>
 <ZTFNvrsSoHOS3P2g@lizhi-Precision-Tower-5810>
 <20231020160645.67e678ee@xps-13>
 <ZTKMTwU6cVAfGCKG@lizhi-Precision-Tower-5810>
 <20231020163525.66485920@xps-13>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231020163525.66485920@xps-13>
X-ClientProxiedBy: BY3PR10CA0011.namprd10.prod.outlook.com
 (2603:10b6:a03:255::16) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS4PR04MB9484:EE_
X-MS-Office365-Filtering-Correlation-Id: 358b4589-72de-4dde-8933-08dbd17b8de4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s3lCm7RW4q2QOymZwGuKNgqtepScMKySJ/FKrNnCJ6b417W9ujWhM+SuqTs6trPAKUCj3eP49AHBXbUm+FIUKJDTHC3tbVkMceLKlyiK/ilYVzBKCror+9QktkxOib3DFkuwocaRJEZvWzTU9KZehJF0X0+WRxgDRO6V4+TT5XvQp1nBZUYAKj1Kujsyn0CAyZagM+y/s4dpeRGOaive/8hopd6OYpBO/Qnge8M0NmMa063GyDfgGbeCWKH8eA6IOe67R3v54vfijR0avwStxtpMDmf2Ogax6geYEFSu5hGrD+v/ncgFzC/2OoSWZeYKiYZynvBZuaEppvGa/i6PqPjot9ETS73zZd3D3wfVwVA7DmiPdZXRVgGerOZbDF7OQZ744LZFJkMzWLpQ2w1ILtCj14VMIBAfxXgbcImUAuEwqNdHC3nqlsg7GIWkCN7fWpymHteTMqYbRvgrafumdl3esj45DL65pMQrP/p4HADg3t/W2nHEfRsdgg1CeLTU5rSU+do0Tn7aGS5UDGo3fhmGR2FeAaK3/cA6DmXJ0E8gR/XE9BuFfGCW/w2cYQzLyTAkOKWTsXPdtI3+Kqr8xG/gUprr/dHZF9WpqAQg20gwkUy+Hmt1LdFceqYGDK8C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(396003)(366004)(376002)(346002)(136003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(38350700005)(66574015)(26005)(2906002)(83380400001)(6506007)(52116002)(9686003)(6666004)(8676002)(8936002)(4326008)(316002)(5660300002)(41300700001)(478600001)(66476007)(6916009)(6486002)(66556008)(66946007)(86362001)(6512007)(33716001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?GzHT9x0EBKC0aahtE8TcWsi+3CYZgid39TM5rzziO5JxoXjFi/ZR+7JlOV?=
 =?iso-8859-1?Q?MiXR1woxL5luKVsJgpymIWFGVomtcwZyumbxFibIZc+MtyPvzqHvtBnMm9?=
 =?iso-8859-1?Q?RYuldKDidDXCMadMiXKb5JWcwYnKpL7U9lATNYMLUPPnUb0dhahtUWOYpV?=
 =?iso-8859-1?Q?iMKFfbw/HAykmyulN1O++I4dFAbae77gbgT3LCVx1YPFpKSHlZjcAqEv8J?=
 =?iso-8859-1?Q?WSM11CM8Dp0BwhsxzSQ9IgcmvyS4LexCzEFWb/LK23jP5t7i7nLMj1CSfo?=
 =?iso-8859-1?Q?zQGs4IEQDwiOR1+OLKhRoUNUPA+av3rqw/V92ucq0AeuAzazRDTt4LQJmH?=
 =?iso-8859-1?Q?AfeeP/ERzrghROIY/DnMpOBrhnJe8NoshZlfcmz7A578audCV0FL8wrzQm?=
 =?iso-8859-1?Q?145hE2XohIZ0yjq3fQufFG2cI4uvSfLX6NpswjEDwG3e6S1HjDFzrAHlnr?=
 =?iso-8859-1?Q?NwV9yyn+RDOLe0L9d/JHmfL3Rpa2zOblUmi6BpWabtgJl+jkiO2hnIfCtf?=
 =?iso-8859-1?Q?FcR0merzxSay02PwEd5bsUiVl67FvcYK/XomyK2M9vpeU5eDLQ0WBf+Ehh?=
 =?iso-8859-1?Q?ra72EXmu2tkh748H55Owi4Y2x0iEZyhIZhBTD0j0wtOH6uYWCKveAoyrYH?=
 =?iso-8859-1?Q?PdxEJ0EHMW5IReScNl5ouOM0OzG41vu+y9DMCmV5lT3SrwNnNQR30ZQWYk?=
 =?iso-8859-1?Q?h7ZUDexdSLabO3X9kmMZ1Xb0TLQIgES8yl8MXAOCCcHZDuC+hSsbZTowjS?=
 =?iso-8859-1?Q?D9dOW/sF0J+AFazhmlHYDmvCIaS2yB3sTi10Qk2W5iy6i9qY7A+du4AJnI?=
 =?iso-8859-1?Q?vId1fQblhPOeL+y4TECJxXzRKyNC8xCxHFKm/6NZICfK8TccMajusZWtG3?=
 =?iso-8859-1?Q?1u3TxfHM2zAsPL/ZZ0UAcdiP1xyNOZxC5eEYofqgDk+v9t71HEiweI4t5Y?=
 =?iso-8859-1?Q?Y0P14vYA9IDsC/H9p9oKChttge3yXbgF64Z/t5hClzYPSS/WBm063y6U9S?=
 =?iso-8859-1?Q?e3yYKZYMAEnwDP6PeswPm8adxUlanI+gLDIsloGFpX4lP+YmONJJvcQq9b?=
 =?iso-8859-1?Q?63Sb7HhmSkjsONNstg47nm6kku+AzGIzEigQLD7GiFnAdG6p9LVwWZy/J7?=
 =?iso-8859-1?Q?COHZgE9PknXNhQvxh7XWGSST54EG9D8rm7LqwJ+ZUrJQtV22r666cpyqsZ?=
 =?iso-8859-1?Q?ffhwRfZhrQgFP0xuSmZrBd6VQjE9v54Lx+grB80eVcO/gmcGPmkP+wVR5r?=
 =?iso-8859-1?Q?eBQ6gq1D3/OfRmdEAVwNu4aygPtKy6LCsMkSE2QovYi+yiaCFE2CkIsN9X?=
 =?iso-8859-1?Q?S31taeDPqgfXWZRey9cBeNjzTa05okfX5MvaXQafZgBvX+uHVLhlozkH+C?=
 =?iso-8859-1?Q?r43q7sXs94A5M+tsbYUDEG10tccPsrPxIGVjByYldiPQX7l/hpBEGDEX27?=
 =?iso-8859-1?Q?h1kDhJFveOGIb/oTae8v9KCbQTsifONLv27AQWD1tGDovfqVVNe+8hu6Eh?=
 =?iso-8859-1?Q?EjAGo8eevichCTn/tmthdp3pktvD1J+DoSesPOn80gT77kEm6HJHC35jlc?=
 =?iso-8859-1?Q?5PU5doEBm88lqZW2u++TSyiuLaIfyiNLyFBjBnlXlfoCE6yImVXGOUwhq3?=
 =?iso-8859-1?Q?ALchhHHHUwAjnSCYvNBINlBLgel97G6cpk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 358b4589-72de-4dde-8933-08dbd17b8de4
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 14:47:59.6016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nTDFMlOE9UWaJDpbVQTFYkKVaSfojqcLWZpTHRM5NX0T7JzWHch2JdFzyiV5bRWQTi5aoAx6zmMN6EukAQYAhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9484
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 04:35:25PM +0200, Miquel Raynal wrote:
> Hi Frank,
> 
> Frank.li@nxp.com wrote on Fri, 20 Oct 2023 10:18:55 -0400:
> 
> > On Fri, Oct 20, 2023 at 04:06:45PM +0200, Miquel Raynal wrote:
> > > Hi Frank,
> > > 
> > > Frank.li@nxp.com wrote on Thu, 19 Oct 2023 11:39:42 -0400:
> > >   
> > > > On Thu, Oct 19, 2023 at 08:44:52AM +0200, Miquel Raynal wrote:  
> > > > > Hi Frank,
> > > > > 
> > > > > Frank.Li@nxp.com wrote on Wed, 18 Oct 2023 11:59:26 -0400:
> > > > >     
> > > > > > master side report:
> > > > > >   silvaco-i3c-master 44330000.i3c-master: Error condition: MSTATUS 0x020090c7, MERRWARN 0x00100000
> > > > > > 
> > > > > > BIT 20: TIMEOUT error
> > > > > >   The module has stalled too long in a frame. This happens when:
> > > > > >   - The TX FIFO or RX FIFO is not handled and the bus is stuck in the
> > > > > > middle of a message,
> > > > > >   - No STOP was issued and between messages,
> > > > > >   - IBI manual is used and no decision was made.    
> > > > > 
> > > > > I am still not convinced this should be ignored in all cases.
> > > > > 
> > > > > Case 1 is a problem because the hardware failed somehow.    
> > > > 
> > > > But so far, no action to handle this case in current code.  
> > > 
> > > Yes, but if you detect an issue and ignore it, it's not better than
> > > reporting it without handling it. Instead of totally ignoring this I
> > > would at least write a debug message (identical to what's below) before
> > > returning false, even though I am not convinced unconditionally
> > > returning false here is wise. If you fail a hardware sequence because
> > > you added a printk, it's a problem. Maybe you consider this line as
> > > noise, but I believe it's still an error condition. Maybe, however,
> > > this bit gets set after the whole sequence, and this is just a "bus
> > > is idle" condition. If that's the case, then you need some
> > > additional heuristics to properly ignore the bit?
> > >   
> > 
> >                 dev_err(master->dev,                                       
> >                         "Error condition: MSTATUS 0x%08x, MERRWARN 0x%08x\n",
> >                         mstatus, merrwarn);
> > +
> > +		/* ignore timeout error */
> > +		if (merrwarn & SVC_I3C_MERRWARN_TIMEOUT)
> > +			return false;
> > +
> > 
> > Is it okay move SVC_I3C_MERRWARN_TIMEOUT after dev_err?
> 
> I think you mentioned earlier that the problem was not the printk but
> the return value. So perhaps there is a way to know if the timeout
> happened after a transaction and was legitimate or not?

Error message just annoise user, don't impact function. But return false
let IBI thread running to avoid dead lock. 

> 
> In any case we should probably lower the log level for this error.

Only SVC_I3C_MERRWARN_TIMEOUT is warning

Maybe below logic is better

	if (merrwarn & SVC_I3C_MERRWARN_TIMEOUT) {
		dev_dbg(master->dev, 
                        "Error condition: MSTATUS 0x%08x, MERRWARN 0x%08x\n",
			mstatus, merrwarn);
		return false;
	} 
	
	dev_err(master->dev,                                     
                "Error condition: MSTATUS 0x%08x, MERRWARN 0x%08x\n",
                 mstatus, merrwarn); 
	....

Frank

> 
> Thanks,
> Miquèl
