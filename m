Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6BA87C9910
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 15:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjJONDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 09:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjJOND3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 09:03:29 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2083.outbound.protection.outlook.com [40.107.7.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9914AD;
        Sun, 15 Oct 2023 06:03:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OPLYd0SrtBj6SMjM7NDFEZjses4XG+wG5esz2laL20vx8qqyDeVc8ykd0ootR3o3y31VdfatZkBwSKIix9It8eP6szCEFOpqvXNTAh7Dxr44P7QibmDGnclyj1JcFWGd5gbvRaNWiFyD8mclVMlKd8W+QgXBgmNyylLsNAZuAToWI/YbAV38guw4fVpaB85sT6SWBdn065dhhSLfHmzURyeiiYAFvQFhMVrbWd20+iNYXJ0gTla0OG9rwTcJ3AAuXnw4NJBWuGRwsiBXQ3cohuM2rR8Su5HpOAb4U8XYAe97E/dNPn3krWQ3eyR1VqKZftHz/hPq13ep3rGO9mqdFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WZEdw5yBq6bVsizgAYQQd+w/awdGEoftjGFqBmkQKO8=;
 b=NH4egsltLDBL/KqnUtvX78TnP2ZlUnUSalwANo78RW+p0j8KLn4tl+w69YeuYreHzuPI6cCEdrH5uzNtUBDmu/CAqAq3vaS3lxTjdU9XdQXdhb+Li09f/86S9ashxh7uOvT4+qG1YQiLwKz5sd4DyS4SDFvc8h7apFjey/rdn7I9YrxJn6b3UXSi/qGbDgesWLyikSezM9YXZ4+iyMCziPtTENTI4XrH46B+waJvMh9FIreYT63xjnEGx5uVHKw3NDd/GoEzbWWhBi9b8/WCR/6z1hdiYoLFdKHznu1ILGBl2OOuWx1eiJduJ4iSOMV9KS0SzyfTYsWvurBAGc41TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WZEdw5yBq6bVsizgAYQQd+w/awdGEoftjGFqBmkQKO8=;
 b=xFdjoCLO+Z3eOX24P3jnlWN7M2g1R5Y8km8L08czFWWJS2/azBskstBevn/sq+V/k1mvL3ZS0MlYsij+1smLbwsO2iBDg6jIfFcqJoerjolqVVC14O/eKLKUXkskTbqfh8qu9+mbHgV3vvU2qRf+3D5qv68BDsQ99gLa/KIXYAE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AM9P193MB1346.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:2fe::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Sun, 15 Oct
 2023 13:03:24 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::550d:2425:c0ed:3e59]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::550d:2425:c0ed:3e59%3]) with mapi id 15.20.6863.046; Sun, 15 Oct 2023
 13:03:23 +0000
Message-ID: <0ca84efc-c999-4077-85aa-e13fd0984182@kunbus.com>
Date:   Sun, 15 Oct 2023 15:03:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] Fixes and improvements for RS485
Content-Language: en-US
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, u.kleine-koenig@pengutronix.de
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        cniedermaier@dh-electronics.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, LinoSanfilippo@gmx.de,
        lukas@wunner.de, p.rosenberger@kunbus.com
References: <20231011181544.7893-1-l.sanfilippo@kunbus.com>
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
In-Reply-To: <20231011181544.7893-1-l.sanfilippo@kunbus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0008.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::13) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|AM9P193MB1346:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fd995d6-a9c4-421c-0124-08dbcd7f1cbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D/zoYB8EVLOnhqNN+AvpnsrPh0wNr7DwZGpX7+32dl3upTKppEN5L0f/Jd9482iwRGozIL9fsuHvDhZ1g4N+AvYz7o6N2NBrGoeCvGn2+/DYFNkAo9VCvMtTKsU1A9PV0upxFxb89ZIOryk/ulQZu4Mh95gT60mvg0s8bcT8tnCVgg4aqt2/Np2MIKX2hBSPSv4KV2w0//Q4TfvRCydQaHbvhNhDlF28s/UA6kNrjlQlQm7OicWrj2K/FtZEGMJaAM2+zaTxCDZ3D4bWgx5PBXv37TMDpBcJzpTft4o4F8ATgDBmmx1HLqKbogOlzJA2DRMZNjXfSfE1NjEzgonObgPe6RxustAGeZzly/YHyB9qCefurB9SC8U+Vu1rXp15W7BL3Fen2TNYr1Blf4ynDkZnJMf6ohigLGBVEodrHFmnRrVnKy7TP05nN/Vp7TEKkZbYAxyVVoaIh8rkugl2u9mzD5h+Ppi4F3UuzDHcy+MjhxC49qFVJ6u9hy94ARIaaELsrF+I0qnLciR5W91XUVhN6q+6PRbMUqZ+/yxVjlaiSmlu+RCOYrl1F6VmZQeIj15UXxAeLGm1pFrHnWOzhCzuaf0AZodUWeCB73UdHeHXu8jspLe0lWCOu9ps+wrDvViDP6Qmb4ymIg6XY1ru1g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39830400003)(346002)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(31686004)(478600001)(6486002)(66946007)(66476007)(66556008)(83380400001)(31696002)(86362001)(38100700002)(316002)(6512007)(107886003)(53546011)(2616005)(52116002)(6506007)(41300700001)(5660300002)(36756003)(8676002)(4326008)(7416002)(2906002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0NpcjhpOEoySXZFVDU3RXl4OTNYelpnUkRXdk02dHpScGRsWWlwc3BTOXVk?=
 =?utf-8?B?aFdpbUt6WFBzK28zdXJ0L1J6RmVYMkw1Z2pVRG4vVk02L3pRUzFoZnJFcHEz?=
 =?utf-8?B?MXhYVWxOVnprMDZ3Z1VOQk9yMzZUWndCckRvNlJabG9Kd3dlTm1sVSsxbzFP?=
 =?utf-8?B?ZFZOaXhSZHRFYWxWaG1KTlJvMUdyMm9XakpwSGhFVHU5OFlORzNIYVEvK0M5?=
 =?utf-8?B?bXRtQkRrV2NJRTl6YnRNODRSSGIyZzlnakZJOTdPeUpFYk1rQmV6R09UWEto?=
 =?utf-8?B?ZFRFMDd2bFpILzNjd1dPd0Z0TnFoSmV3RW5PeVBBamQvdlNhdWhKRjFVOGhF?=
 =?utf-8?B?MWRqUDMxZXRja3VWQTdTem85N1lpNkN6QmtJaUFPd3VXOUpSMURqdXFvdTJO?=
 =?utf-8?B?WWsvSmJldVllODF1Uk9KY1B5R2lBL0o2dTRzSG1lQk45Mjk2bWlXRmJPS2pE?=
 =?utf-8?B?L0hqdUhmUk5OUjNLMWNvR2JSS0tMY0FmUFhTRTJPUDZGUXlrTDZjNUhLalcv?=
 =?utf-8?B?eks2ZVJFaHpzRENUQ3lGUm1sKzJVYVJCekVDSWhzZzI5MHVha2FJYmI1M01p?=
 =?utf-8?B?NU1LUFVodFZxQlhKVVRmS2FRS1d2bkJibmFxeUNZd280ckFZdUFkbmE0amhF?=
 =?utf-8?B?U1RRamFYaGtlVy8xcjkxdEJjejc4RDhENzZ0UG9lV3NOdkxKZ1dhcFBxd1NY?=
 =?utf-8?B?b2p2bkgySkI2WmlJT2ozUkJMUGY2S0pMV3BPVHVnV1VlQXRzQm1nZzVkU2dN?=
 =?utf-8?B?OFRYbDFTR2IzYmVsTWttZ2x1S0hHZS85WTliTEQ5bHU4dTI3MjVlT3lFWWJP?=
 =?utf-8?B?ZmZhZVdOQkxtTDI1Mk9abkFkU1ZhaDMyWHp1WTM2YWxUMklMbmtXN1RCUE4w?=
 =?utf-8?B?TnF0djdPVkdDbHladG4rUkxMYk5PbHhOZzg0MGwzOGg1NHd1U3NWdFhQSmth?=
 =?utf-8?B?Rkd4akF5dkRSY3FjOHNPdW5IY2JnTGhkWDNOdmk4NEZub0VKMHpqWDdNdDhI?=
 =?utf-8?B?TWFhcmEvS2oxOHM1VXZZVUZHZWdmcnNUSkowcjNGbEl6NGRSMisrZzRsYUYz?=
 =?utf-8?B?dmVMd09CbTdyM0xLdU85bndnRUJUN0U2azZZL0JzbFlrYXJmaWZEM05kbG5i?=
 =?utf-8?B?U28wZ1JMRGJYdFQyaXVUZXBxd2huZDYya0xYUFY5QVBCY1NOL0JKM0x1UkJ5?=
 =?utf-8?B?aEJUWWRwNzNzQTRWNUZZUVR6eGZydW93VDZCMWFMSWZiakRPaERpUy9COFlI?=
 =?utf-8?B?M3VUY29IOTl6UXdpcjU4Uks1Rmo2cmRSd1g3T0l0VWFrUUh6YmFyVTdvZDFE?=
 =?utf-8?B?alQxSWJpMG02bTdBOE1BRHRNd2ZXbGRkd1BhVnA5YzI0d1dkZHVPZWt6YTRI?=
 =?utf-8?B?WEN0K2x6a0hjZlRHbnVlY0hhRnJkc2VoaFhPYlpUVVpITnZyaEFWaGJkZmRv?=
 =?utf-8?B?MHFPMVA3R0dNQnk5OXdaZnUwZVJRVk1EMGcvMmdGSHRJemdpTlB6RzBBV3NS?=
 =?utf-8?B?M1lOM2Z2bW9ud25qUkZJOFdFTmRqNkxqNHdZWEhDWmt6UGxORFRXc3NQUkR3?=
 =?utf-8?B?M2E1MnNLb3RRY0wwQjFEV1hleWdSekRxVVpxMEV6czZlenROTEpTdldyaTR2?=
 =?utf-8?B?SFdCazI0MjJ4YzBGVitDK1FKL0RZV212a3huR1F3WmU0d2JScDBWL29YMlM4?=
 =?utf-8?B?Ym9IWC9mNWZmby9yUmpPQ0gwK3VicjUzbnArWnRxNjQ0WnNBZmlqbXkyWXVk?=
 =?utf-8?B?bWpyWVpmSmx0YnBTNG1uUzZWb3BGWWc5aS9ENlI0Q1JqZ0c1bXFCMkFOSXA3?=
 =?utf-8?B?MFRwSHhLU0cvdHp4UHhHSzEwK0Fhai9scEY5NUt4aDdvN2tJdk82azBpSVdi?=
 =?utf-8?B?TnVjUzJhUkZaWDQyTE1aQXcrbEgxYkRQYXpOSzRCa1RuUG5QUmxLaEdqN3ht?=
 =?utf-8?B?S3UzRndzMlYwRVV5RFlBM3M4S2N6dWw1dHBaaEg5Z0NKWnZyUzQyVjZlZXhH?=
 =?utf-8?B?djF0c3F5TWczMjRlZVVXb2dBcHNWcVM1QzFYMmlIYmV5MzRPNkZQNW40MENG?=
 =?utf-8?B?VjdUc2o1T1NtVlZrM0MvODF0ZktDRDNJSGNBNEZDdEppRzg3VmRhb2xoZFMx?=
 =?utf-8?B?OW9GVzVnNitYS3c3bGlvanhoQzlkWTN1Mm96UDZvUk1hT1FGaG5SSUxXUlpl?=
 =?utf-8?Q?jUuXQ4nuyQ9kB7uc+7YvaHmk7XeJEP+YNBsen+IIRHjW?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd995d6-a9c4-421c-0124-08dbcd7f1cbc
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2023 13:03:23.6844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /vkiqOscqBKgWDgZi4v02pXHb1Fn6ie0elh6ihgKTE4FQjUxWoYT7JJNNBBHkbC0gtmYWGx2mznF7rTSH0TPig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P193MB1346
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Ccing Uwe.

On 11.10.23 20:15, Lino Sanfilippo wrote:
> The following series includes some fixes and improvements around RS485 in
> the serial core and UART drivers:
> 
> Patch 1: Do not hold the port lock when setting rx-during-tx GPIO
> Patch 2: Get rid of useless wrapper pl011_get_rs485_mode()
> Patch 3: set missing supported flag for RX during TX GPIO
> Patch 4: fix sanitizing check for RTS settings
> Patch 5: make sure RS485 is cannot be enabled when it is not supported
> Patch 6: imx: do not set RS485 enabled if it is not supported
> Patch 7: omap: do not override settings for rs485 support
> 
> Changes in v2:
> - add missing 'Fixes' tags as requested by Greg
> - corrected a typo as pointed out by Hugo
> - fix issue in imx driver in the serial core as suggested by Uwe
> - partly rephrase some commit messages
> - add patch 7
> 
> Changes in v3
> - Drop patch "Get rid of useless wrapper pl011_get_rs485_mode()" as
>   requested by Greg
> 


Sorry Uwe, you gave valuable input for the former version of this series and I
just noticed now that I forgot to Cc you for this version. 

BR,
Lino
