Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83507D05CB
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 02:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346758AbjJTA2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 20:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjJTA2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 20:28:39 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2042.outbound.protection.outlook.com [40.107.6.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A77FA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 17:28:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTILc/BtZsQ5MDhGnvuMC36oAB6xbntA10MWxtiKfTkRwEDOtiI4H5UgmcHi73dU5vAHSytpwlbEnrnppLJ0nRTtxMEsR/qstfkJ05Rtk3mU+0npQLViC8/msozFIcsB83+NTetERiedJ3hV0tSWJ5v/pEMPw4X6/ACqqaNq08Wdix2hvPy1gJvnrfBtkNAvhP/lWIp4S6oieN54UQpKnEm5ndG0DVCJ51lk6RAmst/YC5XLUBFXMkC+jJB9AiT7SYFWUunzONjQZxu6G9oWyx9EsqONdSlrBBStjxniTlYFLq8r1gMXWLksD0YIrOrZRW8/Nvj0hnRpUxkwaBjJyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D6R4JAiDZYS7/Pom32y1V3IWQrjJn0fswcBulp/uyy4=;
 b=cPS2mIv3i/hLfSl1g86FjAGaXAxN9rz8lMLI6P8rcioxgDo5/LG7cQvjKSRdPMZOlAikunYTQEICzmqnBvQuwkB8zRLsk/435d7ot2zycb2RH8kTHFPgRTfARzZMrN1VDzApDHKk2vSCAPe6qeabHSyTtswBnJ3Ot39IyFLrTpr3TLjS8CVZN4oQqvgMb4ojA3juvp33jagNVuSF+K50sb2mxkgh10MlPe7u7ViLQ+ljVllo9ayvBXtF4pZGXi/pLmGZH0CcGfFeKdSPx6XOHvjLZu4ZOUqZsyNbY682gMr8Dn5Iem9PiIj15QDuRt6DSrZzn1KQIE8z9aeaFTcewA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D6R4JAiDZYS7/Pom32y1V3IWQrjJn0fswcBulp/uyy4=;
 b=lQlvzuP+ueOAfIw7EakxWKo5Q9GL/D+EwR7HMSFUVrUcVyM36aw0yrZ2xFt5ptR4cgy0Xv3fAJDK/U+A0bYlpAf7OZl37zFotaSQTr/9ptgLV/94RcmksrmfO2ljIVAhhE4nupO45qlTKjGelmmIV+ztRdjYtuJyliqc3Ah3++U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AS8PR04MB7528.eurprd04.prod.outlook.com (2603:10a6:20b:297::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.8; Fri, 20 Oct
 2023 00:28:34 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Fri, 20 Oct 2023
 00:28:34 +0000
Date:   Thu, 19 Oct 2023 20:28:27 -0400
From:   Frank Li <Frank.li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     alexandre.belloni@bootlin.com, conor.culhane@silvaco.com,
        imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] i3c: master: svc: fix SDA keep low when polling
 IBIWON timeout happen
Message-ID: <ZTHJq+9OKHVRaXGW@lizhi-Precision-Tower-5810>
References: <20231019222725.3598022-1-Frank.Li@nxp.com>
 <20231019222725.3598022-6-Frank.Li@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019222725.3598022-6-Frank.Li@nxp.com>
X-ClientProxiedBy: SJ0PR03CA0129.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::14) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AS8PR04MB7528:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d7563ee-e665-454e-fe96-08dbd1037e75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h+p7Xx/MJR7XVc9CdbTdgz5OpXDsYtYRA+BOpoJZsoGuWpuj17y1hH0aK1kTWU3pPtX8nc68oq1zwDDW+oXhhFElhOw41Q3IorIVEmxFXR332HKg9e8+npZtAy72zF4wje8uIT0dP2GNGydkv3hd49Em1EOhnpuU3wGLMJZtzQ/SkrCS6VcAvpMIQe240Ukor15FQ5L3DZnJWUARj3n8CnY2PgN0P0VNFl6hp13jLu4W8klHvapdgCkWeG18jan9z5CjEz2G4c7+HvUItuI8iZp/dRfXeDSeaaPMDyWToBkmbzNIjeSzHJyReJPOBEWJZfV6eMY5nyQdf9JgWR/pWOVSolKmzHlt7IlGwzf/kGdSTqYYr9l92XKVK7YXzCEw2M3GZZM4+nebyRVxi/DtahSWyb1dq7dH9Fzxns8bYdFdRgroW98coFbG5mu9PlsRXatTbRS+t6VG97KpgIDX90AJ5OI6ZjdfN0u69WGctL0J/7sTiaMAJ8+wz8Wldejam6MnQApy24elGolAMwvXD8ugvy5UqMlyfm2bDesN92SPVPkkrey2mSWnMcJsbLNTTCII/jfjH4LmwOBpmFI0AvS+ulHzonP9nXRIJn3mrqUYyHrluisnBnYLBUjHMZBj6qzX6VhjeARX6CLRn4Hu6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(39860400002)(136003)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(86362001)(9686003)(6512007)(26005)(41300700001)(478600001)(6486002)(5660300002)(8936002)(2906002)(4326008)(66946007)(6916009)(316002)(33716001)(66556008)(66476007)(8676002)(52116002)(6666004)(6506007)(38350700005)(38100700002)(83380400001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TzazHxC5b4RNrSF8xVcMDXngaJ2ANuh8rTWGzW9izZh54PI/bMO5dUuSt6W0?=
 =?us-ascii?Q?KjTm0ZENNPDcEEx1IThIjm66W4S0wdz9dQ0B3c2RMZC4CK1M8fiwvRoWqplm?=
 =?us-ascii?Q?vWzui3MN/dWsq8O0F91/z1hHgD6ylyfYY6r8rgtrIOWH9EMKbYp3PhEIr5Y5?=
 =?us-ascii?Q?hY1IuViJorPAKnk/ZUxj82dr9YaAFbpZALsd2VTvRqPLg3LLuBooUpy0wr8C?=
 =?us-ascii?Q?n+w6GLfiw+uNq6js0XAIuuOQddc5DXdD44QFsojZYEDW+aH2EUKfT0t3fMZI?=
 =?us-ascii?Q?+mL4kQoEyNi4w5p572RbnYu/DRDGeotHNndscUriLZP/uSk02eaAsldLcOks?=
 =?us-ascii?Q?bP3VO2Ih8KJEX8c9J7R8uPX1mvWB5PoBfG9CdWuidWNt57bkOwJ3cMVRZ2d5?=
 =?us-ascii?Q?bc27nurFUP0G5rh9enCL18It+vKd2MFkMCU/BRqLPaL8je9upfv/osPUCLnm?=
 =?us-ascii?Q?tP3ozs3neSvtj0Bu42SCRIKfMFGq4S4mxisxWapKRg+zC1ipAf057iDKu9sa?=
 =?us-ascii?Q?J1m+NRXFuuvzcGohgc0X1+9vBR0+8mlgHInUqEjYUFIqPIefdJnKCztEoKEq?=
 =?us-ascii?Q?dVMnBJfry+VZ3UkKGY6gCD6LBDL3dp2LSuBiM7tEioGF+Gykg1Rlm+bark02?=
 =?us-ascii?Q?ljS5UYm3v5Ss6YrdMegv82SlUv4oWDlLKkItfoOWJfeCBjqefdi0j5C+GT3H?=
 =?us-ascii?Q?ZTxwJrAnvv1lvb8ApvIdEY8ZOPsvqTE5/LeuY2AzRwpK+e4aLDTJ8rhThsr3?=
 =?us-ascii?Q?gkucZcysGpgQgp/hKrlcH+i+Vbs2sZhFa7y21fCuHwgYaHMygtlU6cKAz0Gb?=
 =?us-ascii?Q?/nEMQ9VfIgJNBrEG1TCzub25XNJtFyv3J9r0x0xHnaocUE3PagXLQ08e2rMR?=
 =?us-ascii?Q?9qxlg7hQtcCi3EAAP0JMnP8x8BU9FOI0KmhqtE0Fa59rYNucc/OjTV/J+CpV?=
 =?us-ascii?Q?0C20Q9+0fmAiwHrDthFThdEUOJcS5pAOqssGfz2sNusl/jr8UNCxLc6yKjcH?=
 =?us-ascii?Q?lMeAxe0SkWLYqSj5mYj+I2kYx9SsrZ0AGEioyVxs2n15fgPQu2Wqjm5A/cC2?=
 =?us-ascii?Q?wCk/4kRKAZ6zDX4nPOcTCJ6AByz//eMxjhlvEmFg5Ttnl3MDvn/o1OvjvT2I?=
 =?us-ascii?Q?ziwQB5EJFcYeTn2Bek/qfC0VKSjzHAInPeJ2T+D6p3hXAB7B0FJxr5j8/1dj?=
 =?us-ascii?Q?rxB31tmQUVt9S8DO957FgMMZNUk1qIty9TwRybFDLcSSnmlfP44eLrgOfDcb?=
 =?us-ascii?Q?0507STfa8mTli0JfrzbPn17X9V63kJtp7cMWirbgLlMsr5axxlcXUW9UnCX+?=
 =?us-ascii?Q?Xz3ZmVnn6wDVgtEdd/MjhIH8v815ryr2Ma2pKXOSlVO6rfaBsewi/ay62Xs6?=
 =?us-ascii?Q?s2qcZJD2ym1uFP457KvYaB1LvlQDAE14/KeNrGBeJs9zzfr4QPbc+z74uFDC?=
 =?us-ascii?Q?vOLu0c6tfO/TZiF5p/aK05bNhv89vr84i2Btv2s/n0V/AgoUw1tb1KggvnI5?=
 =?us-ascii?Q?O+8AoBLYwoT+8WP4dsBUWXk8/icg6IT0LCKWUxHF7KsFTkt+MBU+RBbbXXcm?=
 =?us-ascii?Q?j8g45Ud0k1JU6A9n7PB7H9+6JGVvBdq03DhNZlev?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7563ee-e665-454e-fe96-08dbd1037e75
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 00:28:34.1301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WqpGvkBJfk96WEq4ORCoMWtN6rUV+be1Es+M1tNKFCyDh8cvfIG4bJOsRr84xwZGta4CxaOUKr6HRQHFz4uDkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7528
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 06:27:24PM -0400, Frank Li wrote:
> Upon IBIWON timeout, the SDA line will always be kept low if we don't emit
> a stop. Calling svc_i3c_master_emit_stop() there will let the bus return to
> idle state.
> 
> Call svc_i3c_master_emit_stop() to let i3c bus come back to idle statue
> when IBIWON timeout happen.

I forget delete this line. will remove it at next version.

Frank.

> 
> Fixes: dd3c52846d59 ("i3c: master: svc: Add Silvaco I3C master driver")
> Cc: stable@vger.kernel.org
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> 
> Notes:
>     Change from v2 to v3
>     - Update commit message and add review tag
>     
>     Change from v1 to v2
>     - Update commite message
>     
>     Change from v1 to v2
>     - Update commite message
> 
>  drivers/i3c/master/svc-i3c-master.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index b113460f059c3..1a57fdebaa26d 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -404,6 +404,7 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
>  					 SVC_I3C_MSTATUS_IBIWON(val), 0, 1000);
>  	if (ret) {
>  		dev_err(master->dev, "Timeout when polling for IBIWON\n");
> +		svc_i3c_master_emit_stop(master);
>  		goto reenable_ibis;
>  	}
>  
> -- 
> 2.34.1
> 
