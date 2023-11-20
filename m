Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA717F0C6F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 08:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjKTHFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 02:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjKTHFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 02:05:03 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2137.outbound.protection.outlook.com [40.107.243.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98844A4;
        Sun, 19 Nov 2023 23:04:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHPI69kB9E8kd6Of/9QXSnZSnos40QyzJCn5Nmg2zIw79hHPRe9AIcAeDoCFTFJbd21QCo+6SeEznD7wS1AuC4jsQhtryULlVzqMaUnk5xh+Zs29wXdTj03Ztd80PE1FLD9QPBVvdOEhY23X66XXMBPZyUtxYdI0yvTly8ilsBM3cf3BAl/NPhRlseWkwqbXaYJeTwaGIayCJeMDW2ozkabaYMcuNoUhLEoKHbqnP7thRelFoYyjP+Wf50Oo3+ZAjSLgs9RgBcL921boXgI8SKukm4zIv2WZzeEZNevphDBqwvIFkAeY+1L5SZyHjBii994s5BXMppHQtAcjYqAsHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GD5UCnHVDsFTrbnfiX5+WQOppB7RqAbvlnetxzwP8ec=;
 b=dzZW34kT5r7w3HutCipg7PHiX0sbnQwS7CTP+Q4lbMzaNrgQPcVyF9b2SvUKWrDx1n8mPA3IOaqJ8suc4JgtJhMsbOqdC2KwhFNpaTLPn4MMbQ1KnvPN6c83XXBUhpitoFAXinEPGOFOt5UX4QNkNg3s+5zq6LrOOHQZaI8/pGo6Q21+8MwvOkFMMmadYPR2haUfhvVrdqCRJxg8h1j9TrbzNCyq8ROwOk1/xCNFWjtB3WG/PrCvsUxnbhKT4vRFcfT8nug60rCG5NBVSYL8beB75t7RX2X/cYCoHOVViHxotGXZcMiTJrHg8PUn/5mJBusOhJY8/XjAMhEdZ0vMYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GD5UCnHVDsFTrbnfiX5+WQOppB7RqAbvlnetxzwP8ec=;
 b=AakcezaMly4jVl6QwgEY4X+n6dCEmU2xuDr8KjPWCux/Ng08YPy30yjyNxTRvvNdRyAkhcO+jC3TrnEdKecPMOw2D3CPFtXDda4C8gwr6XnhLlCdtPa2wBLXLya1aAOOt4tnVtLFpcok52PxhplB/bptOMlGFlq5GYHvQXbfIbo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from CH2PR13MB4411.namprd13.prod.outlook.com (2603:10b6:610:6e::12)
 by PH7PR13MB5915.namprd13.prod.outlook.com (2603:10b6:510:15a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 07:04:55 +0000
Received: from CH2PR13MB4411.namprd13.prod.outlook.com
 ([fe80::e79d:4237:713a:67a1]) by CH2PR13MB4411.namprd13.prod.outlook.com
 ([fe80::e79d:4237:713a:67a1%7]) with mapi id 15.20.7002.026; Mon, 20 Nov 2023
 07:04:54 +0000
Date:   Mon, 20 Nov 2023 09:04:36 +0200
From:   Louis Peens <louis.peens@corigine.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Denis Arefev <arefev@swemel.ru>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, oss-drivers@corigine.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] nfp: flower: Added pointer check and continue.
Message-ID: <ZVsFBACC05VrrCfw@LouisNoVo>
References: <20231117125701.58927-1-arefev@swemel.ru>
 <ZVd4RYURdHLL+F2h@LouisNoVo>
 <20231118202207.16a60834@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231118202207.16a60834@kernel.org>
X-ClientProxiedBy: JNAP275CA0040.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::17)
 To CH2PR13MB4411.namprd13.prod.outlook.com (2603:10b6:610:6e::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR13MB4411:EE_|PH7PR13MB5915:EE_
X-MS-Office365-Filtering-Correlation-Id: 64bf7e51-73c7-4269-bcbd-08dbe996ff40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o7vc0JeKh+OusO0I0I75sEHric3qqwShjVXgHKTQZRHsO8Eh1imbx3fhvDfv7s6PkiOamnhTtcODxAykBMlgNpJBlM6E8jZw1zLXxKIdVIS6Y+gGGiCM7if6khy6d3gz2uWE/eJaNFL6irXUxXyTITf9rsRU0aA/SO3cLdbUhCIawRBByWOZSjh62tzyu7SAfJRbm/qvHaxZnesefsNg4XyB+AQSkmB5Is0KQiSEjQCXDlV0O35JNnI9j5/y6m7m80tX69Vb1a/9Wqd63qQUA0k9hDD3LepHPCxjuz6Irsu0V8XEkH9bNlga4N4zp4Ui1nrQW2RXnSESsKuwRc45t9LWL9NGIY066Kxf6mMR1Igepm0RgR1RloWKTLz3/JF3qAayXujYikKNnmzPAXFBcL6s7Qz5N8wVgsYQ7i8W8n4UMhI66xeQNob1tQ76DulKRIgByvsNL/+qtykw3dHLcVzchanxJ7GqPSXinoNkxPdcdLwelM9zGTWU2v62ga2705ev9vkn7tai55B7nzsRLgh5bmnjtWuiUPjYARg0Zox6NEX9DQSzHxBisVcWDGxlPdO6+Sq/W4edhPshd1WztKti2hETpZO/u0+txNeqnYqO2Nr4iyU2lkOEz6c4b3KhT01cpANnsdrb+9T3WgfLbIxOXiTk+R/QF9fXL0OMob+OCOxyEtByxE+FXMwszr2h
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR13MB4411.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(39830400003)(346002)(136003)(376002)(366004)(230173577357003)(230922051799003)(230273577357003)(64100799003)(1800799012)(451199024)(186009)(478600001)(6486002)(6506007)(38100700002)(83380400001)(26005)(55236004)(6512007)(9686003)(6666004)(66556008)(316002)(66946007)(66476007)(54906003)(6916009)(44832011)(86362001)(5660300002)(2906002)(33716001)(41300700001)(8936002)(8676002)(4326008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ecQplg93IAUxxFi5uMOZ16gQ4sCzFd/ATtZOdGDGKZD1ErgjYMqw/PHYqw9I?=
 =?us-ascii?Q?Kmisd9XHUwMDtYl9VKjYQHE8u0UGd+oObFy9ctfF511yIsjiIqBEZgvauEFS?=
 =?us-ascii?Q?s3SA66BeQl49GDoNoP2BT4+cZLn6sgJ+4eKadJhu37v7coRmVtLxtVAlL6cZ?=
 =?us-ascii?Q?mzkE5nsbifDR3bWko0zNGjJ3FqIVUyj1YAvkIQqrEE50DzFHFxDiV/2P8UTK?=
 =?us-ascii?Q?eYlyIkcKRurBWdDe3AxH7vhckSgEWZkLeJqyGELbBnWPBFUgL+V0Xeire2wz?=
 =?us-ascii?Q?zi7gWDakm+xreXIQYzZtnoACQr3HOchZ3u2wJJcL5lQjlteQR7dVFJvpPWKj?=
 =?us-ascii?Q?N9nCO6rE9BPPLLNm0OHEMWXFmJybUEbnz3o3Vc2gJFn+JA1kR9MwMB3I0BcQ?=
 =?us-ascii?Q?s81HXA6zkY/iwlRXB9fzrN7Mb9skUGP1QjWELTI8Fo9hLob9k5m1ifAyqGsz?=
 =?us-ascii?Q?x5Mnjsto3YFbE4gwz4whT6IKbRhGByCvoZESDs/4vFMxU3N8aT1qmBD22NN5?=
 =?us-ascii?Q?Np3dVi9rBphUDqmkPZw9qru59YUD/ww//IWrYvflpjmPyjTGn1jAIT3tRDXf?=
 =?us-ascii?Q?Wleif2UMQ4Yjqtk1T9qrFkWVp468pO7XhjodI41/gfULke95tjR82pEG+1Sf?=
 =?us-ascii?Q?t96SUDKS4mrB7+fpzKTcqwU9/gkkbzfwoiKEZppn1P/czmvcODooAtX8dIer?=
 =?us-ascii?Q?P7dkEuuU/VdsR7NrPSru2nn4MAgn4hCXhqowNPhqL766k87WJbK0uFjQEDvU?=
 =?us-ascii?Q?GgxNwGE4oJznKYWZa33RD8jBAy+NM+wDE2WoUc+xQUoS0khcXr/Sd6XlyEQf?=
 =?us-ascii?Q?enoUwsKKOYnHTqIBKn65S0p5dYkKRISaGPISx8QSC//YAZ0z3DklccQ4+zg1?=
 =?us-ascii?Q?vZUz+Y+b30/Hf7AwzYtpzYQk+7cs3WrByujC9q7razWLW/PAZQ8Kbrx/eGpY?=
 =?us-ascii?Q?M4VUYUgcLjJOz9uf6fkJ7mQVl9TCFBQZ9emc7MRffD/7eOmqfVG2Kd6pgKLI?=
 =?us-ascii?Q?4v57aMXX8HIT5MejcCzeGb5B1ml0fuPBSnQrDZl6kx/ZE3xOd8t9xkT77z7q?=
 =?us-ascii?Q?KladzOxT2nkzte8N+paiMe/Qz1pMZT8cdMsaeAA94eEzpO+uMaLGqHSL5ThY?=
 =?us-ascii?Q?yF3rYjgFmKc5gZWDB1TN2qQhMWNJmNuOJ3/LmwJ8ufJ3hUHQp2K7vz4whby8?=
 =?us-ascii?Q?F7g6MDpqKwV/OCyA/6iFUlfXwBajKYCCxUAc/lBIR1e9QjDMnama6ZoA6Ro+?=
 =?us-ascii?Q?cyYMJKww51ooY44P89Ut0iXiU5kjS5ZIx02ZKgA0pzmljhlercy4BuhgKAA0?=
 =?us-ascii?Q?KFmKotbBZntkFCnVJHmJY/2VihLsRLWxHal7ZKSXfWO6aqJO4khSk1p/6YVB?=
 =?us-ascii?Q?YtwREQ9aLBE6VTe/KwWyTL+BrTuXHNm9WK8cB4UBTigJGHS3vbX9xEOacy4a?=
 =?us-ascii?Q?6/iO7s0vB/gp3mH/FijZxWU/h4cPFEMjAxxa00VXivXUDY/i4aRegTqBV8w5?=
 =?us-ascii?Q?y+8FKKS0m1w7RrJ7iFdX1rpXfdxGFYi7X9RbvGLKiHtUyt8np28wRyITPPv0?=
 =?us-ascii?Q?CbWLB5qPp3nZzA/vn7fnLmgrusQ7JBm/F1CuqMY/5bd3VA5d7WAT2AjeceFI?=
 =?us-ascii?Q?Xg=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64bf7e51-73c7-4269-bcbd-08dbe996ff40
X-MS-Exchange-CrossTenant-AuthSource: CH2PR13MB4411.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 07:04:54.1127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FjTDNa+FMjYZHNE07hBM/ZTw8ZM9v2MIGECbP+cCKqRyHmYsA2j28ZzOZU0oYXyBtNNMcoaoD6IbMb83O45ft3SFNCHaFwondhN7RCg2t/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB5915
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 18, 2023 at 08:22:07PM -0800, Jakub Kicinski wrote:
> On Fri, 17 Nov 2023 16:27:17 +0200 Louis Peens wrote:
> > >                 acti_netdevs = kmalloc_array(entry->slave_cnt,
> > >                                              sizeof(*acti_netdevs), GFP_KERNEL);
> > > 
> 
> Unnecessary new line, please remove it.
> There should be no empty lines between call and error check.
> 
> > > +               if (!acti_netdevs) {
> > > +                       schedule_delayed_work(&lag->work, NFP_FL_LAG_DELAY);
> > > +                       continue;
> > > +               }
> > > +  
> > Thanks for reporting this Denis, it definitely seems to be an oversight.
> > Would you mind adding a 'nfp_flower_cmsg_warn' here as well, so that
> > this case does not go undetected? Maybe something like "cannot
> > allocate memory for group processing" can work.
> 
> There's a checkpatch check against printing warnings on allocation
> failures. Kernel will complain loudly on OOM, anyway, there's no need
> for a local print.
Ah, thanks Jakub, I did not know that this is frowned upon. But I have
not thought about OOM - it would indeed not be a silent failure.

In that case I would be quite happy to add my Ack to v2 with the newline
comment addressed.
> -- 
> pw-bot: cr
