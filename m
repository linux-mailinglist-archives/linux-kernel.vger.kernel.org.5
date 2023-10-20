Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F87B7D131D
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 17:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377756AbjJTPsE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 11:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377663AbjJTPsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 11:48:03 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2077.outbound.protection.outlook.com [40.107.8.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B17EB3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 08:48:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e+dGpOEZzmxWpbu0rNCgA+wL1tUvT9tPAqMVLE7cIWQnl1CBFyoNakzydYzCfspEpWvPl82Prc0wwHqb2UEhNKNu+EeElyZ8g/mKlPCtQw0nsFS6ehP1VBBVZOZD+GEImnffnpMRq5tQtEM1RxP7ab9GiXSFRrtBbB9Jj2cFcnvSCUwJEGzwZ0TiQdkXCCo5vHAlWoceKw1uGYGqRWIAgHMWGbyEtf5pizaxq9R2hAxHK7/Q35UNqPWpWQAi+WvSPkYxS+71dJ7rqn370l+Wajzc9TU0MOq2rnVu+qLWmSt+N0dG++yJXlcQCKare8a06nT8TiyfFFPWpQ3iPQf7+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x7I+19D7rxssELWClhxoqA7xeBsnBflsh8KlFJkTuHs=;
 b=SuROpIgN9MeBjECmpq1EJNOcV4bRErqolQV9Fnl8QHIRrwpKN2OyiriMvHSQxO/33q9oLxIbs/tgjPfMk00Q3VJI/O6tmfLgiZn8802WTyaskfhaaHPOLPmdi9gr/LAvgz7nOlQtb/uwsFk8ZORNFj+0RFcp4eY2lFOq43Xyn77LWvCCJPV/RfXQnIJkE+F5BCBiu/OwQVmG8Yx6Wx9bLDPWDZCiCA3p68/jF85ZClyR8n+RY4EMM7kJNKpELuQmex715ue0WLqZ6ZofJic8YKCwOkADv75dsUgvmxH+M+XloI2Y8rnsRPW5rCt8QdXShpZxnn+7wxzyYIHXNEvdoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x7I+19D7rxssELWClhxoqA7xeBsnBflsh8KlFJkTuHs=;
 b=iSEu5Fdh6wEOzpQfe+hWvIDvf35jpfV1/AWY3rz7ZfPWrq48XDVwyzYu8B8PhTFjsH4t3Tc2mZgilxqdJ0eRqysvq1CA528/+LG3t0kHDbSxzDcLw/azsofQoZSIuqU/daBl7nbPCEMRC8AWLudWjfN5KD/Xu3O23kw9BXKXmIE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DBAPR04MB7415.eurprd04.prod.outlook.com (2603:10a6:10:1aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Fri, 20 Oct
 2023 15:47:57 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Fri, 20 Oct 2023
 15:47:56 +0000
Date:   Fri, 20 Oct 2023 11:47:48 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 Resent 6/6] i3c: master: svc: fix random hot join
 failure since timeout errory
Message-ID: <ZTKhJOAAz4CaupEf@lizhi-Precision-Tower-5810>
References: <20231018155926.3305476-1-Frank.Li@nxp.com>
 <20231018155926.3305476-7-Frank.Li@nxp.com>
 <20231019084452.11fd0645@xps-13>
 <ZTFNvrsSoHOS3P2g@lizhi-Precision-Tower-5810>
 <20231020160645.67e678ee@xps-13>
 <ZTKMTwU6cVAfGCKG@lizhi-Precision-Tower-5810>
 <20231020163525.66485920@xps-13>
 <ZTKTGG7J55Sj19Nd@lizhi-Precision-Tower-5810>
 <20231020172006.5de0998b@xps-13>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231020172006.5de0998b@xps-13>
X-ClientProxiedBy: SJ0PR03CA0133.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::18) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DBAPR04MB7415:EE_
X-MS-Office365-Filtering-Correlation-Id: 10ac0634-d4cc-42c6-0acd-08dbd183edb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lZPVzVTpNYb3qKbv3/8CMkPfV1HkQzMgisoAM18BXni5Kym9zhRKLgp4cnDdhsNXPWq4834yDgr3vm2oL+Wi3A6u3PRpnFRJ0M+3FEGdRUzn7Xml3GVMHxJm4YZ7eDcP+x39EVFs5Zs+iKcRS5IM/SsAIwCtcPuVouaACn2oc2Z+bVWhNYsSSeQSHMi4xjyuGR6dgUAXWBJ5PR591S1HTAuzf+261ivpnCbcN5o1CkLKmQciMDP+wqE/v5cU0PM5GhZKFICazjJKelLILvog1eCHUYnhz4Tzb37PFqhWnhPIbtwpohTlkox632u9kr59UaFAehAGZfwYG0Eg7429Gz1Clqcq0+ubOwhzAcVPQfUSUAUl0ntr45wO9C4avJjubzr/EArcFbLV2AqWDz7m1Wr50KVbzgBCG7gNZa2Pi58tVB0bc7ZPzgZTiXeuarlESdiKDAftSm2aaPZfaASn6E/0NQYwoWBhVwsZIqnBb5pLvIcVX7o1ZPNdzoydjYVDMywfYPElkdCjCw4pp3gOGZNekAdgiegreMQBeuE9Yw8WLwaEHyizX5NoXKm7gU3FHQEIbAqdhhhvu7C3eaUwfomHQ1DsnC7fLIx98ZURSpZ1VdpZZjz2Rbc7Xh/ynb7s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(366004)(396003)(346002)(39860400002)(136003)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(26005)(5660300002)(2906002)(66574015)(6486002)(66476007)(8936002)(66556008)(8676002)(4326008)(66946007)(6916009)(33716001)(478600001)(6506007)(316002)(6512007)(9686003)(52116002)(41300700001)(6666004)(86362001)(38100700002)(83380400001)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?BlsFedWVjSJIKPWYVFYZ4oHgSBWMxL1V9MLzzsGOsTAg1txl9mhzHYg1FP?=
 =?iso-8859-1?Q?5CefGwFzzhmz9lnKGdg8kl6Kn8v5ML1V1IulV96RtM/qoPMuHidRA9KrQX?=
 =?iso-8859-1?Q?vhDz5nm9AgIpH/llN+sLCC0HghJuiFFh7xR3FFXLaCuP7bdJwP8pmK8hfu?=
 =?iso-8859-1?Q?S2w0O3qN0UVTGtoObC9fVIzQBJgY14AxmEjQtKL2ht4O3FdEV55O1biGKJ?=
 =?iso-8859-1?Q?NfK8jcXRTfLZza3qM1mLzOyu4lzoiK4MWgDXZRDBCvDgH7wkUx17ECipHp?=
 =?iso-8859-1?Q?f462R/Nu0nwkKzYtLyPZHZgoSBVbjHXTxlwwjbc6vIF2VNZHTgBN2ECoGa?=
 =?iso-8859-1?Q?2ytnl77tZptdmdQUsbbeOjrfGmHpF7uw9LDLq1ohsIk6JyJ4j0kIoHk/gc?=
 =?iso-8859-1?Q?c0tX6pUmbJIWRwdXZ4hTf7yELQgrVoznFzKYM8rmnI1m3i28/lc9cqz4rO?=
 =?iso-8859-1?Q?f2Ny55Q+q/9Ej7Rfzhrrcrap1pVQNGVjz+zqucxEjXHy/en4rYA83QgQyt?=
 =?iso-8859-1?Q?iV5V6L7agkjOGDQYGGrE4O9+FtGBdUY/puXZ1P00i1R9G7myLA5IkHX6iM?=
 =?iso-8859-1?Q?A+u22lZQlw5yJSJSeV5Vq8wRqFgRx4iEE9eP1jm0lkqvuBtU1ZIbf7N1/v?=
 =?iso-8859-1?Q?THHuiao3i1hTEQib5LOnIcP2AT/okDpQX4IN+6sCGu7aAZ0kyG5Mx3YbYZ?=
 =?iso-8859-1?Q?0RsQj5fZ9NAQRbI4WFWUqL9UKJxFc37Gqh4Pyr+tHI0KPOAVf+2/RmKaz8?=
 =?iso-8859-1?Q?uonHg7aOBvV0SWI8OjxrbRMwq0NWWYbDAvw75kaenIc6EyPLdU+fyZ5RqS?=
 =?iso-8859-1?Q?nWaeQkS71uykaCHV/Tks0LaTa/1roduYc7MN1+4RlKmmJELily63gzECQn?=
 =?iso-8859-1?Q?KAADBz0laO+2xjTuQvCqlK2AAZ8+g0lFs1cm+tfvcW+4APXBgi9E9VTe8S?=
 =?iso-8859-1?Q?Q/IUin+YBKjw5Oe0LwggmSPalCRTx88oH/cUulgeroS2Gjk7h7PZELMdPE?=
 =?iso-8859-1?Q?Q5DssESrkUzc3ksV1aXVsX2dMmmyYiqq+1+zAy65nswy3UWG8rhsfic455?=
 =?iso-8859-1?Q?thmPTNO3FiQIKVNANw7TdVhwZyHQ2bAC3qzAO9Th0xy1sESLqQv7yL5fTe?=
 =?iso-8859-1?Q?hScwTGIiLLYTIfbqN8Y0GoCPiSg1jLKkKvZDz4o1YKIXEhXi1gsJ21+pN6?=
 =?iso-8859-1?Q?x7rbz6aunTZeGw7wzYF1Ql9J3Cxy69XMWT/gwV3RRjOfIgaQ8Nd+hLdVcT?=
 =?iso-8859-1?Q?FPQyYt6N3NjyDWvbQPMHOdnrrQOnQFvbhqkOXxH39DVokJ0S1RWxziZ+8l?=
 =?iso-8859-1?Q?HeKp3EZxy+Cb7wUIM0+WB+ecx6pAK4hO0gVd+rPQ4O1NXKP0uba3+btP0r?=
 =?iso-8859-1?Q?LUn0XVLNkniVFDUyEp3xuMX3JVIXPwXoHwNI76K//tdMsvkYWfCi/I4lPT?=
 =?iso-8859-1?Q?Fb5xP1Pm8PNCWZ+Yijb7AOw8pfjdmiBNwN7r3dvsispN8fc/IQdRalnMY1?=
 =?iso-8859-1?Q?VlJgQbepbAdSurJwPhOhW0o8TfdDUPIqcNs1j+RFbEwpfKfXY5pLTia/eB?=
 =?iso-8859-1?Q?JQ3KYtArLAtzRyLB/MQejK3B1oHuk0L5bBzeffFba2/DTlB9Qe2xDRHKLV?=
 =?iso-8859-1?Q?CaLAKtbcXSiIAhwBILlAM5kRZ63iWDxpE2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ac0634-d4cc-42c6-0acd-08dbd183edb2
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 15:47:56.3627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UcnXEq/aX/MIkxjZ3uupHkHU49Q5iWUIJj8z/Cm1fdMsYBp6VvxYAtnnIG6AWRImcSUenj0BFCOdCWfZkjhpGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7415
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 05:20:06PM +0200, Miquel Raynal wrote:
> Hi Frank,
> 
> Frank.li@nxp.com wrote on Fri, 20 Oct 2023 10:47:52 -0400:
> 
> > On Fri, Oct 20, 2023 at 04:35:25PM +0200, Miquel Raynal wrote:
> > > Hi Frank,
> > > 
> > > Frank.li@nxp.com wrote on Fri, 20 Oct 2023 10:18:55 -0400:
> > >   
> > > > On Fri, Oct 20, 2023 at 04:06:45PM +0200, Miquel Raynal wrote:  
> > > > > Hi Frank,
> > > > > 
> > > > > Frank.li@nxp.com wrote on Thu, 19 Oct 2023 11:39:42 -0400:
> > > > >     
> > > > > > On Thu, Oct 19, 2023 at 08:44:52AM +0200, Miquel Raynal wrote:    
> > > > > > > Hi Frank,
> > > > > > > 
> > > > > > > Frank.Li@nxp.com wrote on Wed, 18 Oct 2023 11:59:26 -0400:
> > > > > > >       
> > > > > > > > master side report:
> > > > > > > >   silvaco-i3c-master 44330000.i3c-master: Error condition: MSTATUS 0x020090c7, MERRWARN 0x00100000
> > > > > > > > 
> > > > > > > > BIT 20: TIMEOUT error
> > > > > > > >   The module has stalled too long in a frame. This happens when:
> > > > > > > >   - The TX FIFO or RX FIFO is not handled and the bus is stuck in the
> > > > > > > > middle of a message,
> > > > > > > >   - No STOP was issued and between messages,
> > > > > > > >   - IBI manual is used and no decision was made.      
> > > > > > > 
> > > > > > > I am still not convinced this should be ignored in all cases.
> > > > > > > 
> > > > > > > Case 1 is a problem because the hardware failed somehow.      
> > > > > > 
> > > > > > But so far, no action to handle this case in current code.    
> > > > > 
> > > > > Yes, but if you detect an issue and ignore it, it's not better than
> > > > > reporting it without handling it. Instead of totally ignoring this I
> > > > > would at least write a debug message (identical to what's below) before
> > > > > returning false, even though I am not convinced unconditionally
> > > > > returning false here is wise. If you fail a hardware sequence because
> > > > > you added a printk, it's a problem. Maybe you consider this line as
> > > > > noise, but I believe it's still an error condition. Maybe, however,
> > > > > this bit gets set after the whole sequence, and this is just a "bus
> > > > > is idle" condition. If that's the case, then you need some
> > > > > additional heuristics to properly ignore the bit?
> > > > >     
> > > > 
> > > >                 dev_err(master->dev,                                       
> > > >                         "Error condition: MSTATUS 0x%08x, MERRWARN 0x%08x\n",
> > > >                         mstatus, merrwarn);
> > > > +
> > > > +		/* ignore timeout error */
> > > > +		if (merrwarn & SVC_I3C_MERRWARN_TIMEOUT)
> > > > +			return false;
> > > > +
> > > > 
> > > > Is it okay move SVC_I3C_MERRWARN_TIMEOUT after dev_err?  
> > > 
> > > I think you mentioned earlier that the problem was not the printk but
> > > the return value. So perhaps there is a way to know if the timeout
> > > happened after a transaction and was legitimate or not?  
> > 
> > Error message just annoise user, don't impact function. But return false
> > let IBI thread running to avoid dead lock. 
> > 
> > > 
> > > In any case we should probably lower the log level for this error.  
> > 
> > Only SVC_I3C_MERRWARN_TIMEOUT is warning
> > 
> > Maybe below logic is better
> > 
> > 	if (merrwarn & SVC_I3C_MERRWARN_TIMEOUT) {
> > 		dev_dbg(master->dev, 
> >                         "Error condition: MSTATUS 0x%08x, MERRWARN 0x%08x\n",
> > 			mstatus, merrwarn);
> > 		return false;
> > 	} 
> > 	
> > 	dev_err(master->dev,                                     
> >                 "Error condition: MSTATUS 0x%08x, MERRWARN 0x%08x\n",
> >                  mstatus, merrwarn); 
> > 	....
> > 
> 
> Yes, this looks better but I wonder if we should add an additional
> condition to just return false in this case; 

What's additional condition we can check? 

> something saying "this
> timeout is legitimate and has no impact".

Add comments "this timeout is legitimate and has no impact" or dev_dbg
print that?

> 
> Thanks,
> Miquèl
