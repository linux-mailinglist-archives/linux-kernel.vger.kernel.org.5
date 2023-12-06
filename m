Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D72080790A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 20:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442825AbjLFT4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 14:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442833AbjLFTz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 14:55:29 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E848D4E;
        Wed,  6 Dec 2023 11:55:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZc0DkjK5nZGxEat0AucSOQcHBcZtE+apsRqrhnaky/NPjWObbng5IhY7BGNH44bXihNmJ+GmM3Ev8yhQQcasvjHhzJYB+v6a1BIINcXPZwYY5cPrYwZCDVehPzoDlUrG2eXak9F/wYTLo4b8Bow/9vYGL7TPj2WNot2pPTu1+mNLQ9gtDiiUa6mI7HWn0BTV2WOVoSzYo84Y/TCTIw0Gd7iGnCl+zJPJURkrJdypGdnvDcC11PZSwcpyFVkp+LCqjSkLXQ3bprrSaJa57KeAKtTDb2IWiDSWaVS+5mHb4lAJS1rL/Rg5HVw6iSxvY4MLpxN38SojjEHBrnsWv+mag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CveNRXCZw4gnaU/VIHMZdAJzxUs7wTfrZyLFV5c7Pwc=;
 b=eEah/ZFA799hNVgku+BzOFXSD61hFA96YgKJs85bMzgcAT8zh+/e3tQLP2fEty6x/R+Y9jGPXgDK5AftvkLf18N5KjTunfs5w6xRG+3oQ0hhbR4wQ7NBcYIcDx8N9JZ+sJzfI4WTUdVx8+xNfL2W5uyDd2mxvBRvTrlV27nbC8LOI6fQQ5ZVEsYHz+baCX1+uCewhQQ8iRgjM++gh/NzhuW+aP1FxSx4wwV3wodiWkWdNzfHTrcO8qzDphyzcL9ard0On5eLGM4qZdg6eN7lyB1lnnvjxJ+q+ZawgIdh02yiCsXHJdUcr488lNT1ZV38D+Q7Qe1JK5r7L1a3DK+tdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CveNRXCZw4gnaU/VIHMZdAJzxUs7wTfrZyLFV5c7Pwc=;
 b=dplESuC5aSHUVKl82WvyBu4pNZAXP6tC0ZTmrCyJUUjBtxkX/nATSQ078rzDNOnZRvLOgNmg+yoZn7pwIWoLilXKAvwEKtiJOPo66r+AfHmpFT2QKVHgzvAh77g5OhGZj0QEQiwsC5VGBuxKocu2eYvBiqtSWVKgTo2K9EetY0dHzQwXrWOdwWaqiYigyq6MomJxKQMP47M8toJRYejRTzkNMeqBE2VnNW4ZQ5dqgu5PhRzCOvU8MIN4d8seCLQTlXrezySxWBbYEhyd3rfn2qRjwYC6eKyTufpo8AeByESFy93RtCJ+wdzXwD40yvqTjWvTj2CManeJnsk7K6tyNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DM4PR12MB5086.namprd12.prod.outlook.com (2603:10b6:5:389::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 19:55:32 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ab86:edf7:348:d117]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ab86:edf7:348:d117%3]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 19:55:32 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: i8042: Quiet down probe failure messages
References: <20231206175818.2568-1-mario.limonciello@amd.com>
        <87zfyngoe4.fsf@nvidia.com> <abc96443-ed27-4021-afa9-280be027e355@amd.com>
Date:   Wed, 06 Dec 2023 11:55:21 -0800
In-Reply-To: <abc96443-ed27-4021-afa9-280be027e355@amd.com> (Mario
        Limonciello's message of "Wed, 6 Dec 2023 13:22:25 -0600")
Message-ID: <87v89bgl7a.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:a03:331::14) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DM4PR12MB5086:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bd2076f-0203-456f-77ef-08dbf6954dbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hG1voYfVeqH5rBijCs7rEC5vB/r7Ps5FujKNS1PyOp+c25tewlBQTaU0BCEszkzewSQ06wLeGoqlh9EHoqkOk+m2xAfp6AOwSo4vkS7AvW8xbVl7hKvLgBG9Q/ZI2XFsg9lwBHVN8oKfdAcGs/5MImA8Z5EUMvz5TlsJ0kFkGKDmJxrr4hbqMR4cfzIu2UISScwvjCUkzkNLUq90kPfBjF+EItsVqy6cV6aDQrB6cAZ1OMvF9l3ny5q/qQxPcfJR+N3pib6NBNzCmK/7w1A5F7byp2GhDnEzzy4LjsPWvQMhy86E5f8jZiwt6JVWXVLJl2MQED2CzB/z+lAJ7mz6bXMOznvNOBDLHbYBLB5tFOATg1HwimikNvV+/2WOxhOaGndUsAyPtrc1KrPJTc3V/v8FpcKoTVrLiBcYw/p/nFBkQwPuEHerU7/PRuTNYQh+ESzhlQPhDwhZ3Y/nTmrVxn/eYwrqhVAQKXQ0zTnIy08AKGPwM63Nujf/mYL0nLbCrw8vCKIDblAFfWIb/5z9t2/TcgG1KJ+Uhej0wS5nLxL+Dk+g2wqjVRs5jb9KNu5OdGu74vUh5ImKe2hyQD8nJSZH/Rud1rzvc+B9KDACMLSc0GSfe3jGCH0Wl8dGsv9pzjvCEK0dmBhuWS/hRcBhd2LiNWtmgZ3D7tps8i0ptRU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(396003)(366004)(230173577357003)(230922051799003)(230273577357003)(1800799012)(64100799003)(186009)(451199024)(478600001)(6512007)(6666004)(2616005)(4326008)(8676002)(8936002)(66556008)(66946007)(66476007)(38100700002)(6916009)(316002)(966005)(26005)(83380400001)(6506007)(53546011)(6486002)(5660300002)(2906002)(15650500001)(86362001)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9wrxw3czAJtpJrzU8WmyDKifSGbmMdTU2K1bwmLdcxXunljklRatOlNg23jQ?=
 =?us-ascii?Q?oZZT5PaGJejJeOHmk5+sc9BXvcKiqw8e6uQTeaJs9MQg3n3IC9O4SGRReIvj?=
 =?us-ascii?Q?qxPobYJJkqOeERFzY2BjtcEuPWvtIm1e8wkPfxOHD2AR89+ecfyUrgDJS5h9?=
 =?us-ascii?Q?g+ckqp3tmzU6L4hsmE3hdg/SN0mMOgHgLGXjnYhlhJ6Tgfyb/yqOXZOszctk?=
 =?us-ascii?Q?MbS0INRBJCsWzoqb+Nv1kc4Ts3RFt2ShVnRPIqDf1EYye/DCH2RX+IXKaxmP?=
 =?us-ascii?Q?OwPteSRxW9kBQ35ntJg+m7nlzz8MFIAyyhlTplEDr5cTBoPvdjdSzL8H+7y4?=
 =?us-ascii?Q?+NFQ6rsunWiNpYH8Nvd3NHpnyPqTqX3JLmy1/fYSRemiI5bZGEQUT0H9xEje?=
 =?us-ascii?Q?p1yoEYu2fLoPw0KIk2+nBrg6GUH87rHotn5/bMRz4u3LuyUBckmVF5agl2/9?=
 =?us-ascii?Q?0UzIDnKQgM6G9IVq9MMxw3tyIZhwM7nf8MTxHGeVElrKyQRHB42pYE5SfS//?=
 =?us-ascii?Q?RrVT43KYirTzBbXDCpwJIKhuvCKLmFTOBqgdOWxKpGqSGxbfNVKbtV0HcDPW?=
 =?us-ascii?Q?ucmSmXQenMWfHwDatYTjVbxYxeOPoa2X4LaJNJB6b2K95LTqXloaTkp5+Yba?=
 =?us-ascii?Q?LCliEtWncwDfcYXQ7MtrCsvrCIUJFKEx8IJYtR6+6WvgMlCZKrW0L46f2RH0?=
 =?us-ascii?Q?hfZixrIdE5yJZZ8jfEdPoKFiNlBcoLas5IknOwyqMq0jjgD/b5bPCDUfvOaO?=
 =?us-ascii?Q?RxlBE4lpc53nLhuWMX8W3buRpmKBa5hbofzMxkHkWA5CX20oQPgoq7dto/Yq?=
 =?us-ascii?Q?RBRpHaD1SoQZsZ8E9hZnXoje1bkPTjqzyLjVpqgFRrjFDhlQeL92zx0FCETJ?=
 =?us-ascii?Q?9as0+9iv8vRVCNmC/7un5UbBu4x6gaAllhgGmMYrWzA+pc2ETsg0vnPnubrv?=
 =?us-ascii?Q?5Ws6Gz/HQaJSuoSABMfrYMRnwO7zvILpOieHbINRLUkLnV6U7kNLxgh1Qafj?=
 =?us-ascii?Q?Q00v9F4zI2erCyVQQXHLOMUr+SY7cgvw9+zwemt5GNFy7HgOfPf3WBIyI7Au?=
 =?us-ascii?Q?xZhtVPHnv27CK0MQuA+5wvjSq0AXzDNilQxP5ZxE5gsS5qdlmKYpdoyClELc?=
 =?us-ascii?Q?uYKej/8TdkDEghrnDVqoD42Cj2pal00iT2dueVPN8qCU/bCA8nsxzQanc7Wz?=
 =?us-ascii?Q?GCigtMfxBh+L+pX2BmeJTodEymrYVcPPSkjpqngDKX8NgnhiWLQ/vM0nGzZL?=
 =?us-ascii?Q?LlHp8k2VdUk7yMkUHCQnq1SvcE1g0CS1CQLqxw0nWtXSCrZKOsVifZkIeNXA?=
 =?us-ascii?Q?8hQQ7UKJENVFGSUnXH+XvJ++j4wCTD5czL8u30cFafHADB2O8BnIILw6FIEy?=
 =?us-ascii?Q?/kqQt3mnS3zpzAO0Yx7T7AtcczYUCv1nxYXJ9kx0fKOBU7gDg0wky6dVRUDW?=
 =?us-ascii?Q?EeMcf1KT27xMg7c32KPZnHVjl9hbP3S9JEetwN1oOzdsdKJdiDTt0VMDc1cl?=
 =?us-ascii?Q?R1Y2mUqL+S5F6vBamvdJxqI3T4lUDRgQ9cbhBZC3GZ/H4YJGpWPSilh/lk4O?=
 =?us-ascii?Q?JR7sgPqIbTrO6wd9OZOxqvhhTYFAn+pwZTsUP0NP?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd2076f-0203-456f-77ef-08dbf6954dbf
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 19:55:32.0053
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +/1DAT+VOgXbcPVj+BDTa/Uq6BN5Hquss5y0WQfg4cgDlokVjUa9IHhWOOqgBbs9sW3CrCnLEHXARY5//jx1rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5086
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Dec, 2023 13:22:25 -0600 Mario Limonciello <mario.limonciello@amd.com> wrote:
> On 12/6/2023 12:46, Rahul Rameshbabu wrote:
>> On Wed, 06 Dec, 2023 11:58:18 -0600 Mario Limonciello <mario.limonciello@amd.com> wrote:
>>> The Framework 16" laptop doesn't have a PS/2 keyboard. At bootup the
>>> following messages are emitted:
>>>
>>> i8042: PNP: No PS/2 controller found.
>>> i8042: PNP: Probing ports directly.
>>> i8042: Can't read CTR while initializing i8042
>>> i8042: probe of i8042 failed with error -5
>>>
>>> The last two messages are ERR and WARN respectively.  These messages
>>> might be useful for one boot while diagnosing a problem for someone
>>> but as there is no PS/2 controller in PNP or on the machine they're
>>> needlessly noisy to emit every boot.
>>>
>>> Downgrade the CTR message to debug and change the error code for the
>>> failure so that the base device code doesn't emit a warning.
>>>
>>> If someone has problems with i8042 and they need this information,
>>> they can turn on dynamic debugging to get these messages.
>>>
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>> For the Framework 16, I think the following should be done.
>> Use SERIO_QUIRK_NOPNP for the device to avoid the PS/2 controller
>> probing. You can find examples in drivers/input/serio/i8042-acpipnpio.h
>> under the i8042_dmi_quirk_table. This will prevent emitting the first
>> two messages in the shared snippet.
>
> I had tried this initially, and yes those first two messages are removed.  But
> TBH I'm not too worried about those as they're INFO. Adding a quirk just
> switches them over to a new INFO message.
>

Right, I can imagine someone owning this device panic-ing about the logs
in red/yellow in journalctl or dmesg output. That said, since we know
that the device should not bother with PNP, I think we should add the
quirk, none the less.

> But the ERR and WARN messages still come up.  The 3 messages that show up are:
>
> i8042: PNP detection disabled
> i8042: Can't read CTR while initializing i8042
> i8042: probe of i8042 failed with error -5
>
> I'm more concerned that ERR and WARN messages show up making you think there is
> a problem to look into.
>
>> 
>>>   drivers/input/serio/i8042.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/input/serio/i8042.c b/drivers/input/serio/i8042.c
>>> index 9fbb8d31575a..95dd585fdc1a 100644
>>> --- a/drivers/input/serio/i8042.c
>>> +++ b/drivers/input/serio/i8042.c
>>> @@ -1008,8 +1008,8 @@ static int i8042_controller_init(void)
>>>   			udelay(50);
>>>     		if (i8042_command(&ctr[n++ % 2], I8042_CMD_CTL_RCTR)) {
>>> -			pr_err("Can't read CTR while initializing i8042\n");
>>> -			return i8042_probe_defer ? -EPROBE_DEFER : -EIO;
>>> +			pr_debug("Can't read CTR while initializing\n");
>> I also think this error message should be pr_err in the situation that
>> the SERIO_QUIRK_PROBE_DEFER quirk is not used. I think what you are
>> likely looking for is avoiding emitting this message when the
>> SERIO_QUIRK_PROBE_DEFER quirk is used for noise reduction purposes.
>
> SERIO_QUIRK_PROBE_DEFER isn't set on this machine.
>

Yeah, I would like to add this quirk as well for the device potentially
along with SERIO_QUIRK_NOPNP. I'll get into why I think this might be a
good idea later in this email.

>> 
>>> +			return i8042_probe_defer ? -EPROBE_DEFER : -ENXIO;
>> I do not think this change makes sense to me personally. It is indeed an
>> I/O issue with the i8042 controller on the Framework motherboard, so the
>> error should be -EIO when i8042_probe_defer is not set.
>
> With i8042.debug enabled I can see that the error is a wait read timeout.  So I
> had thought -ENXIO ("No such device or address") made sense here.

Right, I think that wait read timeout you are seeing is likely a symptom
of something very similar to the experience on laptops like the ASUS
ZenBook UX425UA, which inspired the introduction of the probe deferring
in the i8042 driver.

  https://lore.kernel.org/lkml/20211112180022.10850-1-tiwai@suse.de/T/

In this case though, the ASUS ZenBook device did have a PS/2 device
attached, while in the Framework device this shouldn't be the case. Will
delve more into this nuance in my next section.

>
> If you feel strongly that the errors and warnings should stay as is I I wonder
> if this should be looked at from i8042_pnp_init().
>
> In the no PNP device declared case it still probes, why isn't PNP trusted?
>

My understanding is this is due to some PS/2 devices not supporting PNP
so this manual probe path must still be taken even when we add the
SERIO_QUIRK_NOPNP quirk. I think if we add the quirk for deferred
probing for the device, we can then also have a patch that does not omit
the error to the logs when this quirk is enabled.

My question now becomes the following. If the Framework device does not
want to expose its Intel 8042 controller to the host since its some
unused hardware on the mainboard, why does it bother to advertise the
8042 over the ACPI table? Wouldn't it be better to have some UEFI update
that fixes the ACPI table listing to avoid advertising the 8042?

  https://wiki.osdev.org/%228042%22_PS/2_Controller

>> 
>>>   		}
>>>     	} while (n < 2 || ctr[0] != ctr[1]);

--
Thanks,

Rahul Rameshbabu
