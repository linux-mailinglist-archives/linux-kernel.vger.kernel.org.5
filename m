Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBAF763F2E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 21:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbjGZTEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 15:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjGZTEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 15:04:08 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2092.outbound.protection.outlook.com [40.107.244.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4064E62;
        Wed, 26 Jul 2023 12:04:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kH7yLnf90jK4t8XnADA4J0Tp1rPxRrS3pQdGdtrZcuJPazS3QSYjLecTbSyIwQhoDzJcsnoV8JuFt++ZIn8TDmay8ZJ1kGa1LR+giHn+Orx2owWwQgE8rz5wgzh7fzcG0ewmYA2TMlOOH4O+oF+Del22V/2jKsFcztUGz9Xwe30lHB4L5ejSAQF080qvCArHM6UkSFMoswhNU6LumF4eeYZk5GiAP3zaq5Y+nn9tYBhsrOM4/a65S2iHBttwAaUG3t5PLRuKb67Vnekz1pkA37Z8kAXt2uCI7Fl4xYo3VkbjvZ/vZbNuZZ9eUJ4708l/DvRV6eSoHcCTIj3fMnSp7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jm98b6JqJ/Hiq3pgP+pnjU25S0+HIDVw4SmgFL3EY2s=;
 b=HUgZb6F2nLux28qumThB+J0rMMvDVYaI2eeLj//yQR0kPG4TObZb4D5lIEKO5jEYv/G741InS1CTbqf1FT8DFK5TJPUuG9XE5taHJ3jIDgTf+m3puWfs47GnO5jCIMBlQ9/N8QuBkFzS1F/hofRWcdO95CQAN6rGEsXzqtzR649BreBLKQ349CcYuTBo5mxYkWl7jg8W9YvokjGMkZyA1HKU5FPoL8srYQvgGLPuXich1Dx+YVZ5PJvClc7WPfuTSXgklSpzeT69zhVvjoJ282PwlnYRvsyPgzgaAkkPgEWGWwZ+FZFCRZewRHEXJ+Y0vIlUlsfhVZXV88bUZUn6Ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jm98b6JqJ/Hiq3pgP+pnjU25S0+HIDVw4SmgFL3EY2s=;
 b=f2M+/O38r4GN6tiqECFxsj+7XfrDeoBk1+sfPBZtmDsgNf+BEMLqfQiZb2fuMNr7uBZvUDyxKz5aIBAwP6c6iCLqF3oR/ohW3/QOJh6bGMLbdmSAE0ZevFqywOdvfErTZms+FWgdxFM7LosFzbjpkpoAnSA0IhyXV3o7rzm8zXE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ni.com;
Received: from SN6PR04MB4496.namprd04.prod.outlook.com (2603:10b6:805:a3::23)
 by CO6PR04MB7762.namprd04.prod.outlook.com (2603:10b6:5:355::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 19:04:03 +0000
Received: from SN6PR04MB4496.namprd04.prod.outlook.com
 ([fe80::fba6:1478:6dd7:9115]) by SN6PR04MB4496.namprd04.prod.outlook.com
 ([fe80::fba6:1478:6dd7:9115%3]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 19:04:03 +0000
References: <20230717170552.466914-1-gratian.crisan@ni.com>
 <5fdc06b2-22bc-1470-e60c-1e388774ee4b@redhat.com>
User-agent: mu4e 1.8.14; emacs 28.2
From:   Gratian Crisan <gratian.crisan@ni.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
        felipe.balbi@linux.intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, gratian@gmail.com
Subject: Re: [PATCH] usb: dwc3: pci: skip BYT GPIO lookup table for
 hardwired phy
Date:   Wed, 26 Jul 2023 14:00:21 -0500
In-reply-to: <5fdc06b2-22bc-1470-e60c-1e388774ee4b@redhat.com>
Message-ID: <875y66h4v2.fsf@ni.com>
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0170.namprd04.prod.outlook.com
 (2603:10b6:806:125::25) To SN6PR04MB4496.namprd04.prod.outlook.com
 (2603:10b6:805:a3::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB4496:EE_|CO6PR04MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: 10c9d9b5-4b8f-48a3-f7ca-08db8e0b13ed
x-ni-monitor: EOP Exclude NI Domains ETR True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hmADC05q0nf/k1ZCmaCrVccGz7soAk0mveEzGL4vBljlZDAe+XIQvCa8fJqcvy+uZBbmkuoBBov5nPXvuR1pGJfmB+kJDoBUX5v/2bqEYo7KXuVeh9pTn51sEaPXhhwcx9foRbUBu79Dsd+At8ZzR/d4bPVgV0eO+0HoPQRUZZfG768gA0TYZFxPSX3JYBldd1syAjf6wF89Qvq6qZobrJeU4Nv0RYznjsI0l6nsqUR5TS9VVGA9C0lGsWISavWSnHvEZ2ihfpMF4JA9ky2eqUTxFJEo8m1RXgI4yzqpd9+RQPPQVBP6RRjWlL6Aq6wvQstGWXBI/XJd0Ynf4a1NnxZDSoVdgR0DYhP/8itRoTsljle+ZpLCpriBwL/3fgTkbUbXZYowttDKzAwSALtzG0+9cq9SnN7dW+HybZ1e3FHDty0e5QRKZLjsBHcjnNUtBSG599o0JUkhNn1tLwTUxbXpgi7FTebPR0MYt1ANxtguJk7tk8hLGIUO5Dv9OovXdngatn9w9+45RL3vejWwugUKccE49p9HPRB923hV1m8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB4496.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(376002)(366004)(346002)(451199021)(966005)(478600001)(6486002)(6666004)(6512007)(86362001)(2616005)(8676002)(44832011)(6506007)(8936002)(5660300002)(26005)(2906002)(4744005)(186003)(41300700001)(36756003)(38100700002)(4326008)(6916009)(316002)(66946007)(66476007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9XAvoHzjJlQ14T7KrJ+zj+T0M/Mo5pJTSqaZmJ6sNBf5XTYEFFWJNyqpbPnl?=
 =?us-ascii?Q?7TERtDmZ29z5mt6YBL3VTj5qHXdy5HcRTFYOxhIgifhAVOx9Xjwci38R4f/2?=
 =?us-ascii?Q?E171VbcN0GXQhWpr7i4vh2bHzBbKOPGDvmgqOKgt0ZTwkaznVzNaIehlEzFd?=
 =?us-ascii?Q?Xj5ZOhQi0D6HPljyk2J9/3vR990jrUyHLgAWUNqtBnaBjNSr56PgN1LuAXc6?=
 =?us-ascii?Q?DJwbx6xBx7Pu5QUmPzfhBO/mGSiuOh/iDOjplqwuFScWI+wDilrOukz+MLeU?=
 =?us-ascii?Q?D3IEPtSgcdW3NTtZfLLwC9v8a5wk/uKhP6NuaCAxVZxg5SZL8mZ6ZIgCKf/4?=
 =?us-ascii?Q?cJbpXhZ2RDbsMs5KW48RnuTUyl6ig8/7WGQeCSDUX1eDAthaBzTnbTe1YQZQ?=
 =?us-ascii?Q?1KL1IoTFEAupgnCL3W7ze8fFuFzpIJ/u97p/wYP6PdDljFb0a9Ph2OkBnJfl?=
 =?us-ascii?Q?KJ/EIAZNw8Tbrvu2Bo9CGNbO+0JR80UufvREmd/3NwdVXRPVw26dgPOHW9sQ?=
 =?us-ascii?Q?QdCGFz3kwMFnkyuExIMX+g6Gyd8kHvckqWom5bMyAiTa2ZsqceoLG10DFKHL?=
 =?us-ascii?Q?5pEZuXCUTjg033e1FLMnHHgS9O1nec5oHOuQ4aiZwGl+dWbxYdmalb18Abpf?=
 =?us-ascii?Q?yqorE+kGWAWQMD2kp/kd+fmMfhBgqUaMPaHRNPHy4oHsTmDoNX0WnQ7Et9uR?=
 =?us-ascii?Q?eztmqDpMMXU7xbqczE+YMjImaQhGVVdLgY7Io+A5imS11OtozbWPYHdPZPqc?=
 =?us-ascii?Q?Q5ZjYcoqhjsZfuPhn6RfBLGbAz0YwJmn02IWQDxVQuekVHUo3hJiBkjf1TBq?=
 =?us-ascii?Q?lwhUubXK1JXMRE3fZ7XiCgD6hTDc/LCH/E1p4CphePh1wPYZZwi/mSuBjiL5?=
 =?us-ascii?Q?hJQeLpnZnVqJm4LemXtECJWr/rcakT1NGTo5DRcRpVAMbvzbhbNzI0ksG0yL?=
 =?us-ascii?Q?9B6zvS9yGBDxF2uEhzZu39zIgEJZ5/db5W36WyezScJBcmLUwJcaZs3HjG0o?=
 =?us-ascii?Q?tme4b57tMA6/wbIEjaFVdJ/6vkco7zrht+tSxcGA8EqAvDWzcw6xaUmb/j4j?=
 =?us-ascii?Q?adqOUDigXGZ8l9wEu+uwgxYwPDW1r3eUZFKb5oIiiGVMSTtgyeMLURSMJDSg?=
 =?us-ascii?Q?pLobmfjmoXDd2Z8Imte8lLg4n5e4fJKXRZn1+VT0TxmkvooNWBNwLYkm9YZ0?=
 =?us-ascii?Q?CuAKWnVrlqC9woRP8s068OCT+U6MuLwYpzLRCFKYyriqQYVYyFJiXhdcJjra?=
 =?us-ascii?Q?ap1KkT0MeEB4nHY14A36RmOjWi2EYH+WSvCZ/jBBOrah0empE5kGeX1WB0MH?=
 =?us-ascii?Q?fOgKhcg2z8RwwC4PNO8j7MliFfTwAV4mzGvFxw71pukObUWo4fcTMj2UNFaV?=
 =?us-ascii?Q?s1Igl9n2R5eZ+vFoJjkcKgE2jxniWAcfTVuylXcgceAHMnLLF4CkRT6vqIbp?=
 =?us-ascii?Q?6WYytbu2gQibR2ckSyAMZ0nLYWbBnWJxRzu0XzKRbiEjfCC+Oedv5v3DhRed?=
 =?us-ascii?Q?IGjizh6lAmMTTfl3nwy4jCvmhTf9xKLt7jfMsFDUf846cYb1qpLBMQBbs/ez?=
 =?us-ascii?Q?CSaVX6mS9fHlkEAO8xhlfc4/rjVr2vGTjliojx3E?=
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c9d9b5-4b8f-48a3-f7ca-08db8e0b13ed
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4496.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 19:04:03.5065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n5mZqsaUsI34UvuAWELAYs5waF2kk2PSNi3olo+JJRyE94RX7L3h56A/RHRSgQvRNBjPkXMeDI0IjfZsmwqHaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7762
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hans de Goede <hdegoede@redhat.com> writes:

> Thanks this change looks good to me.
>
>> @@ -247,8 +249,10 @@ static int dwc3_pci_quirks(struct dwc3_pci *dwc,
>>  			if (IS_ERR(gpio))
>>  				return PTR_ERR(gpio);
>>  
>> -			gpiod_set_value_cansleep(gpio, 1);
>> -			gpiod_put(gpio);
>> +			if (gpio) {
>> +				gpiod_set_value_cansleep(gpio, 1);
>> +				gpiod_put(gpio);
>> +			}
>>  
>>  			gpio = gpiod_get_optional(&pdev->dev, "reset", GPIOD_OUT_LOW);
>>  			if (IS_ERR(gpio))
>
> But this is not necessary both gpiod_set_value_cansleep() and gpiod_put() handle being called with NULL gracefully (so they handle NULL returned by gpiod_get_optional() without issues) .
>
> Can you please post a version 2 of this patch dropping this unnecessary change?

V2 posted: https://lore.kernel.org/linux-usb/20230726184555.218091-2-gratian.crisan@ni.com/

Thanks,
    Gratian

