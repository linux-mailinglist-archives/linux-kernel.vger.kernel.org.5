Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAEB1785E0A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 19:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236953AbjHWREw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 13:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235478AbjHWREv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 13:04:51 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F26E6D;
        Wed, 23 Aug 2023 10:04:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMFO5QYgd/oFMHXZzhTqnbYOKSPioTr2ZJIRi7tGItLPuewS6g4PFEWLCPt24X2ijQ15Rt79Mz9MLXHhwHvAcokeEYQCjTDkn0GtBlXBmy93s3n8yXtDu+CtB50V8T10YkRdfFnk2bCvULk6DHFSrhYXbHpaNtIayu/sW3wDpPS+frq2uynkCmr7xWgqY5dMiDiuZjw1mbBiMHlBuyUjuzIdMPwgj/UEpSs9UJWrn5visBDSIlHDim07LO/nt0jr9CxKqynKD405ewi8phxhdjbftyA2zflmreuc1Wce2BI448NLLTjdqMJndz/jGwOGKk36FYipV4cNQu7NMvhcRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KhA/fBqdVjj6VLIugrViieaPSosnegOYC0uM2hs5r0o=;
 b=YnTjvm6BbOO9FVhgiHoEC1IwpM9jjtZRkBEoXG7dNkyc91CGS8f+XTlHO8kMiMT1WDfvlVHNBYH5s9wm7CNz5MnPZ6oLEQoON8wIGss5l8KVGGJA4+jU+MyV3m35meLV0AOk5qPhJ0aiffzr8L1z2ktVRp5ZDoFVwJFocMzdLuF5J3tOL92BouCqA6hBdaOBbe/HezavY863/r3VbBjRn0Ebe6kf+7LEa0Bja8lalvKEeSk/lOPcbHK9WfV+STbceTopDX5n26s0ncEshVEgPW16Or+JNFsxotm9hipaYZBvu6GShFAXHUAslotJMIIlQM1ce/MiUgEpB4ZQSdm40g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KhA/fBqdVjj6VLIugrViieaPSosnegOYC0uM2hs5r0o=;
 b=GRDWSMkNTAbuLKaIZJEJJz0kmZUz9jBgzodpHQGWMzHvRUmi3XSSYXC6RVU31MvMPnHe2MKjGX9FTQnirT5kaKuTF4xFIho8EMG6ImaTQ44SC0o9uSrJEj8ICcDfqC5MumB6Ajp3KgL4GHLpcCAJautgeWIO+JFflnY38+oBEsh49v2CEfUVMtf77gjOgL9fe59qwRrIXc/qx74muPwTVZfyCWUtprpT5G6Vh46cjyCQNnebztGgXBPikahIqyhsIVnIIrmxxZP9jsaixbc5SCitxmg43cHaYO4/qhZutyFvJgL5/i2Jgz0AhDoE+BLvKqNhIg6U5qtw73O8sdvPrA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by IA0PR12MB7699.namprd12.prod.outlook.com (2603:10b6:208:431::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 17:04:46 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::900c:af3b:6dbd:505f]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::900c:af3b:6dbd:505f%5]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 17:04:45 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        syzbot <syzbot+3a0ebe8a52b89c63739d@syzkaller.appspotmail.com>,
        davidgow@google.com, gregkh@linuxfoundation.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        rydberg@bitmath.org, syzkaller-bugs@googlegroups.com,
        benjamin.tissoires@redhat.com
Subject: Re: [syzbot] [input?] KASAN: slab-use-after-free Read in
 input_dev_uevent
References: <00000000000035beba060371a468@google.com>
        <ijh2qmdtj452nq3idu2tohkrmfwr2qhbhrnyqzxjkkw2lrby53@v2dffcqdohsx>
        <878ra3m5my.fsf@nvidia.com>
        <nqrdxdcvuhvcs2syjfhcp5fbk4ckgzibc3izxknvsrka3kres6@ae65hqx67c4u>
        <ZOYAtI5KttKQnLWs@google.com>
        <y3hfjc227wouzraa4hyltyfd4athig5rmna2uwjqy6v23yzkad@wdmzmochmsve>
        <ZOYd1R3Bx2IToWfb@google.com>
Date:   Wed, 23 Aug 2023 10:04:34 -0700
In-Reply-To: <ZOYd1R3Bx2IToWfb@google.com> (Dmitry Torokhov's message of "Wed,
        23 Aug 2023 07:55:17 -0700")
Message-ID: <87zg2h3d25.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0062.namprd11.prod.outlook.com
 (2603:10b6:a03:80::39) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|IA0PR12MB7699:EE_
X-MS-Office365-Filtering-Correlation-Id: 36fe51da-2790-405b-bf70-08dba3fb0cd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LJSUe87P+p5a2AowpKfpcGbTw0+IhySSopmpBVKYpgdB096u3STNL0NmCM6vJa/kARc1PkNOzmmQVIfuQ6CaftUsj8tz9KnmbemBguQ9aOOFpxQ84SH8O0/ekikOBYSuyllj/bsRQ2lVygVJN7meAPvLrkVVH3rQRDYAeSVlPnjmzXLKHQAPgLGJPbzqsb0hNUMkYYwCHGSLyrKK47VC6cwOpTDTsiOP1nyLfzltInk4XJey9VK8tQkqizNKv0QYWQTT+mpaqux4vsKUphSrFGDGkm9vyMwpWQIwzS7Q2eQotwd4Ps3NNnz4uUMKvAUnuziNXE+aQxWuUSD92pElZx0byOo76Jp0ToijBlxIKRocOQJ1l3ce4TTFq43C2FTvLFPwpZeh5g6vn9oMzthQEQr9Ks6SgDMrwxWhdOdd9G4jTbBLMZdLTmHaveSvOcuWSh+cjI7kkqm0+XMyeuwtiaRucMbwV4o7rMx4SZ6trTb9PMe8nicFJ/RpSAFs7/4uqmFbOsv82AJaFBNiQm4D98hmocPWrbJSV6JJcYrrBU9bjWKt+H4a/tckFLHPeIk4vbdJGJqdt8ilq4+nP+Oe0VAbpEoOSUDaVih3+z0J71I=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199024)(1800799009)(186009)(83380400001)(7416002)(2906002)(6916009)(316002)(6506007)(6486002)(54906003)(66556008)(66476007)(6666004)(66946007)(478600001)(966005)(86362001)(36756003)(5660300002)(26005)(2616005)(38100700002)(41300700001)(6512007)(8676002)(8936002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0HZqgdL0HTSxMVTTTjLdfBbeDKfAGhvbCgcqEBzGGtztRw7uXAa56e1+3EU6?=
 =?us-ascii?Q?6/aXnPsMM11Ddi2PPd5hpKmOncX/oUKrXovqULJOFqbCB2Efnkedj23UxWZR?=
 =?us-ascii?Q?2+9knh/qiTm3fdm/NWCF1wUTrqzNnQwxnMiUFrnHGX7EHt6xLyha0vzIfn46?=
 =?us-ascii?Q?JbuAYFHMy/Opfq8DC+7IF8WrPSIzmCmbO0WL4GPLI7pDziDOOPO9+wklRh4B?=
 =?us-ascii?Q?hf6oPbsV7W+rTsigr8X5L3EN8vIXOYB+RdwIvU8SDDIPy/pldKHV+tsUsLc4?=
 =?us-ascii?Q?y7zV6mthqbl3I+WoxCrFkHMMPvGIorIe/XrRFunGzu548P0e1z47ETcwaG8N?=
 =?us-ascii?Q?rb6U8vLKhdgPNb7uGGgrMKd+RRbCauQ/QrdzS4LeHK5FRWptWFPGzbdJ8hIw?=
 =?us-ascii?Q?NjPY7d+fr/g7dyaSwGJ9zHvVd1RxTvURSS1HUXUofbCsinz6OG+dmCbsyZrZ?=
 =?us-ascii?Q?BgOuj/1NIVStyUDKM4O7x175IMFGOtiFVd0kwS69BbJeHOtnNcc9TsYsd/ri?=
 =?us-ascii?Q?R1a+/LaDd5f1/HqPMyIriQ4D7hsAsdBO3s7XuLmjDRSkUGHIj8y7pWeT1GEj?=
 =?us-ascii?Q?Y4Cm7FU8NMM2yX3XjyXDonM6HqqurnjKF3PcsHJDC+/Q+AtNdJ2gRQlGrxpL?=
 =?us-ascii?Q?heQl6mk9ByD5UnFcGP41Qxyehd1dVjf8H2/RTnqTaqn350orGAN4r3I88fv1?=
 =?us-ascii?Q?OCODuWFNhbW8nJXT8gict5HObkX5EW5p7iJWZOTYsP56U6zVaZHRSwEnLw/k?=
 =?us-ascii?Q?vUkPWc4A7VNShhZmZYwBDs8ve6qecxOJmgDBlr0eexhqw2U/zbW0OQ3in8+c?=
 =?us-ascii?Q?YUW649Kd1Ls4BkcpKftltjvWeSAPD/sd058zNJlPk5UFqI+WufsR4+ZslwpV?=
 =?us-ascii?Q?K8Yu0L0v1hV+AiyeCVQEyhfJuuu+Aoeuwv/UJ/nreKsSRDrJUrEBlBD/3ixX?=
 =?us-ascii?Q?GD2c2PVbV8v3iTXAjeIhdwnP8Uj6VuG6LL2vm2goZTTLjy1CXDDjXFzrnEYT?=
 =?us-ascii?Q?wn+aMmTswRyq9xs5EctSJB1uH0dnZtX7+KGqHP7H9ttUvtRPA71Ou/bfsyXD?=
 =?us-ascii?Q?Si/aMEXavBOjqjuVQc0Fy8Lnoywn4SxMzCLjLtXRjLTNzsnJONvJOMEBgyLa?=
 =?us-ascii?Q?tUTmnf/74N4yvBsSmiSFz5xKn4190mNZovL8X6wfvxX+P7GOhpE5ejI4Khax?=
 =?us-ascii?Q?OwzeiZmXWPkHWQACYKY6MafAHsVKVteLKddZmWPsFyO2/F/jajDLupQWXD4d?=
 =?us-ascii?Q?Lwhwphfo68p+9xWFP1yiN30AJH78N+YUh7HMuPWgSMLZ13gXP5t7wErWdI9W?=
 =?us-ascii?Q?E91bXBZjFpCgwn+BfmB/3NwLKyYgdPt8cbUg8PXKnh4gmtWBJkAunnCoPugk?=
 =?us-ascii?Q?FlXJC6RKH4LY3wD6XZtlNON6h2qOoO5pQ2YFzfJmZz5uCEB0Jm+4f2OUjsX5?=
 =?us-ascii?Q?kQTPsQjr45B7043I/MW4gZM0hnZ0f0E5YsRGsFIbYEQ99wD3/mRh8fcAYsnO?=
 =?us-ascii?Q?cYCU9ldBS5W2Ns32VrNZVE4dTK26xqaeocLPd4cFts0sxL4QDVTbp6meQgfp?=
 =?us-ascii?Q?gKzBGokl7xoI4K4WtiCyrREZgu55g0hsy5t49XINYfvWjDBoSjDiFtD9Hia3?=
 =?us-ascii?Q?Eg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fe51da-2790-405b-bf70-08dba3fb0cd5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 17:04:45.1652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5oBmNMP1SWTYJLgea0OjKwWyu/2JDQvq/A16Bf8s673uxOixB/2fC5e9KSpz/FQSNw2nTYVlsOhBQ6tPQ7vcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7699
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Aug, 2023 07:55:17 -0700 Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> Hi Maxime,
>
> On Wed, Aug 23, 2023 at 03:16:02PM +0200, Maxime Ripard wrote:
>> Hi Dmitry,
>> 
>> On Wed, Aug 23, 2023 at 05:51:00AM -0700, Dmitry Torokhov wrote:
>> > On Wed, Aug 23, 2023 at 09:44:22AM +0200, Maxime Ripard wrote:
>> > > On Tue, Aug 22, 2023 at 08:57:41AM -0700, Rahul Rameshbabu wrote:
>> > > > On Tue, 22 Aug, 2023 11:12:28 +0200 Maxime Ripard <mripard@kernel.org> wrote:
>> > > > > Hi,
>> > > > >
>> > > > > So, we discussed it this morning with Benjamin, and I think the culprit
>> > > > > is that the uclogic driver will allocate a char array with devm_kzalloc
>> > > > > in uclogic_input_configured()
>> > > > > (https://elixir.bootlin.com/linux/latest/source/drivers/hid/hid-uclogic-core.c#L149),
>> > > > > and will assign input_dev->name to that pointer.
>> > > > >
>> > > > > When the device is removed, the devm-allocated array is freed, and the
>> > > > > input framework will send a uevent in input_dev_uevent() using the
>> > > > > input_dev->name field:
>> > > > >
>> > > > > https://elixir.bootlin.com/linux/latest/source/drivers/input/input.c#L1688
>> > > > >
>> > > > > So it's a classic dangling pointer situation.
>> > > > >
>> > > > > And even though it was revealed by that patch, I think the issue is
>> > > > > unrelated. The fundamental issue seems to be that the usage of devm in
>> > > > > that situation is wrong.
>> > > > >
>> > > > > input_dev->name is accessed by input_dev_uevent, which for KOBJ_UNBIND
>> > > > > and KOBJ_REMOVE will be called after remove.
>> > > > >
>> > > > > For example, in __device_release_driver() (with the driver remove hook
>> > > > > being called in device_remove() and devres_release_all() being called in
>> > > > > device_unbind_cleanup()):
>> > > > > https://elixir.bootlin.com/linux/latest/source/drivers/base/dd.c#L1278
>> > > > >
>> > > > > So, it looks to me that, with or without the patch we merged recently,
>> > > > > the core has always sent uevent after device-managed resources were
>> > > > > freed. Thus, the uclogic (and any other input driver) was wrong in
>> > > > > allocating its input_dev name with devm_kzalloc (or the phys and uniq
>> > > > > fields in that struct).
>> > > > >
>> > > > > Note that freeing input_dev->name in remove would have been just as bad.
>> > > > >
>> > > > > Looking at the code quickly, at least hid-playstation,
>> > > > > hid-nvidia-shield, hid-logitech-hidpp, mms114 and tsc200x seem to be
>> > > > > affected by the same issue.
>> > > > 
>> > > > I agree with this analysis overall. At least in hid-nvidia-shield, I can
>> > > > not use devm for allocating the input name string and explicitly free it
>> > > > after calling input_unregister_device. In this scenario, the name string
>> > > > would have been freed explicitly after input_put_device was called
>> > > > (since the input device is not devres managed). input_put_device would
>> > > > drop the reference count to zero and the device would be cleaned up at
>> > > > that point triggering KOBJ_REMOVE and firing off that final
>> > > > input_dev_uevent.
>> > > > 
>> > > > I think this can be done for a number of the drivers as a workaround
>> > > > till this issue is properly resolved. If this seems appropriate, I can
>> > > > send out a series later in the day. This is just a workaround till the
>> > > > discussion below converges (which I am interested in).
>> > > 
>> > > I'm sorry, I don't know the input framework well enough to understand
>> > > what you had in mind exactly. Could you send a patch with your
>> > > suggestion for the hid-nvidia-shield so we can discuss this further?
>> > > 
>> > > That being said, I think that the current design around name, phys and
>> > > uniq is fairly treacherous to drivers and we should aim for a solution
>> > > that prevents that issue from being possible at all.
>> > > 
>> > > I was inclined to go for a char array for each to get rid of the pointer
>> > > entirely, but Benjamin raised some concerns over the structure size so
>> > > it's probably not a great solution.
>> > 
>> > I think everything is much simpler, with uclogic driver being in the
>> > wrong here: devm resource needs to be attached to the right device
>> > (instance of HID) rather than to the input device itself (which should
>> > never have any driver resources attached since it never has a driver).
>> > Something like this:
>> > 
>> > diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
>> > index f67835f9ed4c..f234a7c97360 100644
>> > --- a/drivers/hid/hid-uclogic-core.c
>> > +++ b/drivers/hid/hid-uclogic-core.c
>> > @@ -148,7 +148,7 @@ static int uclogic_input_configured(struct hid_device *hdev,
>> >  
>> >  	if (suffix) {
>> >  		len = strlen(hdev->name) + 2 + strlen(suffix);
>> > -		name = devm_kzalloc(&hi->input->dev, len, GFP_KERNEL);
>> > +		name = devm_kzalloc(&hdev->dev, len, GFP_KERNEL);
>> >  		if (name) {
>> >  			snprintf(name, len, "%s %s", hdev->name, suffix);
>> >  			hi->input->name = name;
>> > 
>> > In general, drivers should attach devm resources they allocate to the
>> > instance of device they are binding to, and nothing else.
>> 
>> I'm not sure that's enough unfortunately. The fundamental issue here
>> seems to be that input_dev_uevent follows a pointer that can be
>> allocated by the driver, and will be free'd before the last call to
>> input_dev_uevent.
>
> Yes, this is a fundamental property of C pointers - you should not free
> them before exiting last code section that may reference them. For input
> devices it means that pointers should not be freed until after
> input_unregister_device() is called.
>
> I.e. you have sequence like this:
>
> 	driver_data = kzalloc(...);
> 	driver_data->input_name = kstrdup(...);
> 	driver_data->input_phys = kstrdup(...);
> 	input = input_allocate_device();
> 	input->name = driver_data->input_name;
> 	input->phys = driver_data->input_phys;
> 	input_register_device(input);
> 	...
>
> 	input_unregister_device(input);
> 	kfree(driver_data->input_name);
> 	kfree(driver_data->input_phys);
> 	kfree(driver_data);
>
>
> devm typically helps with resources being freed at the right time, but
> for that the managed resources should be attached to the *correct
> device*, with correct device being one the driver is binding to, not any
> random device structure.
>
>> 
>> And I think that's true for both devices here
>
> Yes, it looks like the shield is also using wrong device.

This is a problem in shield too. I'll submit a patch. I'll take a look
at other drivers as well to see if any of them run into this issue.

	idev->name = devm_kasprintf(&idev->dev, GFP_KERNEL, "%s %s", hdev->name,
				    name_suffix);

--
Thanks,

Rahul Rameshbabu
