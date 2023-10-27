Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD117D94D8
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 12:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345726AbjJ0KLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 06:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbjJ0KLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 06:11:01 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2081.outbound.protection.outlook.com [40.107.117.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFB9111;
        Fri, 27 Oct 2023 03:10:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Et4raVlufvcwDmRXwR4dnimXTeWhXtFeFz76bYNBSbObC9SD8zezlBaiLF8eQulVS4XWfwmm8+fAgqg1UFtzJn8L68iFvuo/bQxykUy+WNfUH6SEyZl8Otc6sK0cgKIRNhke9/hTJVuc5Do0fTr47AxDqGusJAOSfFRU8g93WMQ7Ravgk/4rOU9PKCsZKKOGe9aRT9URbsipXjk32iHttprByx9U6IRn4qQ9r7r0jyeZJ7+eEZR14YTLgPIklNXO+jXwIE9KHY5dEaY38W+ZlL0GMlhEFt2wDpdZOSnAAFSwBxoexEo09wWljv7dPxFSz9dV7IGC58gTwMY0mVI8qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIEJIiF6hCeA9xNL0Iou6uk8wcRlr62afnY4Pw6XfNY=;
 b=aNjbF3FcpCkeL0qvV0IYA3B1Sr/NLrnTdRzCzD9VHuCo+03LV9w5F4FYsGMbyPJqsiai5KAft2MSkxvnSkyULA9B11ZIUWBQWBGivMOklV4/050qsHxGgQuiiIDJQ0+icic9Rgcc23TsLk0AqBER656ja3mrATRNbwCEoistr+agKCKckc3+Y4TUFC9YM7x59v0RvHAFe8PDuz9dNHTJfArBkY4meE4vA2qJeWHHe0b5yss1JeDcO+I+0hrJGwnCbUHkySQcA58DM/rqONGX7RaykLSVV1hmRqNW5ykBQs/+cWyy4mXmEpiAb/VJPTYq2EjQaY8O2HGz3EDTU8J43A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZIEJIiF6hCeA9xNL0Iou6uk8wcRlr62afnY4Pw6XfNY=;
 b=XMTEmD+w/Nf2bMUdYPYzG/2r4E4xasPFBW6WQE/0zuz3yjUewXMRy6qnBw2Tu3RUn5FblMg0ytttDd+iZoEzD6uIXjSEvpiErlQj2pY6LkHJWfCeS27WwNR7yHzMjdCIc1t1pJsk9g8lzw8mnSK5GGg7Xl2VWITK7FTP/jX2xqM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by SEZPR01MB4599.apcprd01.prod.exchangelabs.com
 (2603:1096:101:92::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Fri, 27 Oct
 2023 10:10:50 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::7723:9ad4:633e:fe0d]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::7723:9ad4:633e:fe0d%5]) with mapi id 15.20.6907.032; Fri, 27 Oct 2023
 10:10:50 +0000
Date:   Fri, 27 Oct 2023 18:10:47 +0800
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH 2/2] tty: serial: 8250: Add support for MOXA PCIe boards
 to switch interface
Message-ID: <ZTuMp/S0uQ9I6lGp@moxa-ThinkCentre-M90t>
References: <20231027062440.7749-1-crescentcy.hsieh@moxa.com>
 <20231027062440.7749-3-crescentcy.hsieh@moxa.com>
 <37a5e055-93b5-4f05-bcca-4caa5ed6f97f@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37a5e055-93b5-4f05-bcca-4caa5ed6f97f@kernel.org>
X-ClientProxiedBy: TYXPR01CA0060.jpnprd01.prod.outlook.com
 (2603:1096:403:a::30) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|SEZPR01MB4599:EE_
X-MS-Office365-Filtering-Correlation-Id: 2229a05c-2fa7-455f-96bd-08dbd6d4fee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZH2wEfZgLvq6vMmtjRpCaT9tx+aj0bUNLzjbR0JlK4B9bKwftYUGdUcajttr7v/wkXPlKJAr5y02LuIJsHReRbyZDnDfiAwpxYZ2jJZfUFWmih0QH7en/adgdoBElNAhOTVUtFHMrILkbFLzvZj0EL980z81Xya16UrPdkapXlmsG6wsQN0QCpD81gshGL9yiaqR+RV7qMM34m34AS4vWWHvPaUDyjVuon3903cbP5eC5lsXk7NC01RPeZkS39xqAw4Z9KBX6H4w686crrGqJdN7jhNZhfK4MNoSFcldKg8VlQLTZEp/FfWvZlAhxU2dI88k7JJjq23vhKzB3PWSgtdM51KyKquH6G8iOSai5Drwc7Cl5/1rjFEPnRJQbLX6JU+00oQhNirVPtLyN5TllJo986YYG+W1lTJj7dBNgtrFQe56jPYTu1engto8n757oWD+Dqb8CrYjptWg1KcplvQGajNcFx3tTbTo/52BQvxASIz8C0rcXFXGELHGaf5O8J+jNtPR+sJxtIVNL7QVvubD1DmMB06m+3iz0j98++wJoW6CvmHuibewEREC7lq2B0b6j1hwFemPJY8aRn3SKm9OVe1t+q5Wz97aBY9P7LU5o5GZCkzTDbb637f6GObN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(366004)(396003)(39860400002)(346002)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(38100700002)(6506007)(52116002)(9686003)(6512007)(38350700005)(26005)(83380400001)(2906002)(41300700001)(66556008)(5660300002)(66476007)(6916009)(316002)(86362001)(66946007)(6666004)(4326008)(478600001)(33716001)(6486002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d+FRd9yHKvgNJgXb5VQD+Z79e/NEfev7B/2S4DKYBBEhuuWdXxgQ2d7g0+qm?=
 =?us-ascii?Q?ZDZCVU+C6KIG2WDuMSPZvrsmcluD100gUsQnJvUC7rY2n+p2nQFX22Ad7E6g?=
 =?us-ascii?Q?SebphxKIrJ/STEgceVB6IvlKgCJqoZJVUYwanfSAtA6fF1mC135CJ0Hu/YT2?=
 =?us-ascii?Q?2z1AO7orqmYrpJNSBKO+3gHuaq8TbaGD8TatHA9STvXDbtGvY0O82HzJ/o+N?=
 =?us-ascii?Q?Jhfw9488gXnP+UxOfobYGI19cMEsgrolEfIRXE8yWw/nyFIVPlwYwpoGiUeX?=
 =?us-ascii?Q?L0HI/EIPUSkZS8dMmfx/1P8RJKQB7ZhsxgI3xkVCGoalVn8ovDzmSUhLhktH?=
 =?us-ascii?Q?hnNy4ABxollXivnfCJcIywtG3qcdPqnsVNH7EiMqBOrsphwHKGB17k56/Nzh?=
 =?us-ascii?Q?BDj8v7Tfuaqg+ZjJc3UOgI2CHbL6bLpgiZsvn6tA5sDotqcN6hUW9G6cJVnp?=
 =?us-ascii?Q?3wwrcEy4mM8ZMIhahwWrIiDZxImPrce9Bx9bk9FOkvDAHT7tpvV83MGGDER1?=
 =?us-ascii?Q?ys2fetIa6AxjOy/sEsoeKqt+9TYzCMtp6dt3IHnq8UtqkYR9ba6eWYSFgHFK?=
 =?us-ascii?Q?I/cMoEuEXH0RK+B5YmKdnCidIu30B+meGb1ouwXD7IP5tY44079TS6C0AGYX?=
 =?us-ascii?Q?FjgwFvp9XvgiDBOpYN3CHJVNsmKr3ARlkBpNdrwBl4KHjLmHh4ta9goKD6Lm?=
 =?us-ascii?Q?6sV8ZG2YQbVvoZ0DbAzn3+hG5tBWJYobfTgs8E25qCURFWp5HuKg6oozHFfA?=
 =?us-ascii?Q?S5fhZ68Raiz2QKKqzfmDrA358KmtDqlXMpP2/Lx1KPqNqSA7VdWNUlfvNR2n?=
 =?us-ascii?Q?80GpjHJ7q8oheUptb7kkzbqbd4DvpcZg7XLW/4cW+Mob6f+lAn1I4Y19MUcN?=
 =?us-ascii?Q?rzVH1NhqqM8PybfXxeTgd1nZieEGdmTZotLMJCHPuWoDWNzlYvkpIxYD3jfH?=
 =?us-ascii?Q?oG1IhRqAXMULSK5E7+nJWIcKdmTOibNerSHYr8kRJ8vBKm8OI+KXrGxRVfn2?=
 =?us-ascii?Q?yoGztMm+/hkCRcNCsVR7ekVk9O7W6amiATrvZuZWx6zKp/5bKUQBNqIbNEr6?=
 =?us-ascii?Q?bkMwb1DiLzyOGy4uN8XBcC0cwIj79TZzCRGom9ZduPFRzUy0y/MCT5mPK+LG?=
 =?us-ascii?Q?4BshIBmSA7M4gTOcm7Vi4b4y2neAe1iCs68fYIJCv7RS0Mhi7sQoYKAtD6do?=
 =?us-ascii?Q?Vf3MWt+N/PINcRY+wxjDq69QXlkdKfh9pjgBcYMjYsjOBAHkvcej+VexO9OT?=
 =?us-ascii?Q?Sm58ghY8ikVfbWKLwQeCt2ZMjpivtVlZRAcN1YOFKTxTZY6OTskbtOVpn5H2?=
 =?us-ascii?Q?FEUyB9NgQk9HBkzEcmNQheO5366AmGaoQWP/s915yoapJMnqEv+gEIJaUEC5?=
 =?us-ascii?Q?SSaautedToHeJs+0rHdoyWAaJlDsWoBmu9DtsspnJdjX7Em3+rrzLWZb1lcq?=
 =?us-ascii?Q?/2KgOy8hiHlIhdzUyELrlvTt1vOkmzPXvrng1Q05XAOtupoP6leQgucObeQh?=
 =?us-ascii?Q?UBWYhCGhazQhBoh0ofYk6WyvJmX4xIwveCrjjXX6EQdc63yhJJgjCiIhL6aN?=
 =?us-ascii?Q?+GL+Txdn+aWIQVDuHY7lqMgxJxzKLmXYKpWD+PH2yLam2cGhVvmfEDSnItL1?=
 =?us-ascii?Q?yg=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2229a05c-2fa7-455f-96bd-08dbd6d4fee9
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 10:10:50.3432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qNai+Or7/LqW1qldeGn0YCjdnVELUgLfDgB6nHm/nr19N0goeax/Z6459UnOawKKvwSEsFAS3LbdQwZugApjmDFg27MackIyQLJxfbdTm2M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR01MB4599
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 10:29:38AM +0200, Jiri Slaby wrote:
> On 27. 10. 23, 8:24, Crescent CY Hsieh wrote:
> > MOXA PCIe boards have 4 serial interfaces and don't require additional
> > stuff to switch between interfaces:
> > 
> > - RS232
> > - RS422
> > - RS485_2W (half-duplex)
> > - RS485_4W (full-duplex)
> > 
> > By using ioctl command "TIOCRS485", it can switch between default
> > interface and RS485 if supported.
> > 
> > That means, for RS422/RS485 board, it can switch between RS422 and
> > RS485 by setting the flags within struct serial_rs485.
> > 
> > However, for the RS232/RS422/RS485 board, it can only switch between
> > RS232 and RS485, there's no flag for switching interface into RS422.
> > 
> > This patch adds a flag call "SER_RS422_ENALBED" in serial.h and modifies
> 
> It's not "ENALBED".
> 
> Anyway, I am afraid you have to split the patch into two:
> 1) add the flag and core support (but wait a bit for others if they agree
> with this approach)
> 2) add the support for moxa.

Agree, I will split this patch into two separate patches and only send
the patch for adding the flag and core support first.

---
Sincerely,
Crescent CY Hsieh
