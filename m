Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710FB7F1DCE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 21:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjKTUJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 15:09:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjKTUJD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 15:09:03 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2047.outbound.protection.outlook.com [40.107.6.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FEBFCD;
        Mon, 20 Nov 2023 12:08:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZP5S7yXjuxGw7mBh8Fs2TLn8bZ5meqYdrfVhJDrbuV1g8gWKazeS80c3HmfyOC1GJ5ZwFsOwYHTuuL/pjtHP1qxslwIvnOcjrZX5AHFMPeSyTbetUX65pj3SzRlfsxu1eB9Lf7+Dn+5fCyHpA8tPT9AC1WxVvwBO4S+B4NBWzw8aaygl4C/0IvVtFFI4xChAvR8ZTo6AWLVQJrkEI+JmuF93OlcOptmUC93WuFQ4txra+N/kKE8dXAJHxxhd+sonSoeXR53ER3X6UKwU6SWLq5kvxCZKy9K+KwC2HxUfc6L7Ak8Wsu+1pWV60RSgrp8wyX/FAXCBftXBhen9HkVFOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bX1eTwLYPWmqG1pR94SMWFl0lwvntsTCEeMdIykJwBY=;
 b=DIREj406KTXMEkOLZtg5g+RXMdOl5ZCsLXN79bDctNmznTh6aurm4HcwMVKDtTx3w75mqZ75EZFmrsuHwaBuycNYuJid3pBhsTMAH2M6+sJC/G4s+/LU6YDG8ZyJ6yTOhdIPFQXwsH96i1AA597QeNYHgfv4QKxRb+12C1Cfwbfi3ctkcSVqc2bJxZ7+mPtSszkbLwW61m3lJVXV7a+z2sUMWQ6BY5O37yA8qC+XI8ofoi9T1Zw3VDP11bdp+jAvdsAcFDScJRO7/ChA0403G790XizUC1+Zu3Ph3gHJoWQI9hXoAED9EJHSRJU2k+avJ/q80D5DOSlmnKhkufJ+pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bX1eTwLYPWmqG1pR94SMWFl0lwvntsTCEeMdIykJwBY=;
 b=EP5frw6Rh8oKj+EcIYwcYD2CijWa9F2CCyZx6rm2EeSaRIjq+0xDt22xsplkVILNJfSy9je03+JYFyP6l3GeR0RQeDz4WvZ0+uXZ64f+s42mzR1CwWqk6/oUS7sR6I1BK6w9SX9bVjDfehGSPYRmJK5kCGprST2cU9/bRhrg6PI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AS8P193MB1288.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:335::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 20:08:55 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06%5]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 20:08:54 +0000
Message-ID: <8712ccc3-8619-41b8-97d0-d0187c0b59c6@kunbus.com>
Date:   Mon, 20 Nov 2023 21:08:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: tpm_tis_spi_remove() triggers WARN_ON() in __flushwork (RPi3B+
 and SLB9670)
Content-Language: en-US
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        linux-integrity@vger.kernel.org
Cc:     Lukas Wunner <lukas@wunner.de>, linux-kernel@vger.kernel.org
References: <CX32RFOMJUQ0.3R4YCL9MDCB96@kernel.org>
 <CX342W32D30U.330BVFC336MA8@kernel.org>
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
In-Reply-To: <CX342W32D30U.330BVFC336MA8@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::20) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|AS8P193MB1288:EE_
X-MS-Office365-Filtering-Correlation-Id: 416f332a-2906-4bb5-0460-08dbea048599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O377JDwYRdslGg//YO2+MhzMXmm3jRJcKMCo8/H9mdrhfvzb62n+XjMuwjAvlAShA2hGZMcNQeGUNmTJrX9jfBwW7kUR9WUDQR2Qj9AQaCkA2xwdQjC8TscK8El8bAx2LkXipSniB/KFe4c+UOfcImz1dewQ9LYn/1RY3vT9OgUUOcw8F7z0I0hOFynkIi/k53EkXDxC2vb5LNk+TVj9vQo5/Jb4D7GRNXEoUocXQl99MMlTpu62jvUCufSS9j2C7rvNGoG8HLbqRwdflLHiG8vS4sQ1Wy6NtXTPjqkglV+2Zzs0JxyOjAsl/1Uy5ACntLJJuLGJWxiAstisLwTEAIyqu/2w5DFWaO4eU8oJYZOfMOUQdNO6a5zsgs4BX8n19LmvCSU4AJfLUy9scmtgLbp59mTuZr7FV2A0DBLvndrJKDyqWtDcoEC7k2qD3x7sGcG/47PV2Qijcnou1/hOcBXUCEBD2t+0cPvXzL/xIbo2zHpj3HSBHb1OQ0U/hM1vfXBpnaPoXydFOy3Uaqq/uacD2e8u57rQVct1nzR6qIqs41DSOtCFTdCwHBKzkwBB2UKnzQneFqcldLV1x2TgyfBWJ4m2tKm5tNgmf4r29sVLfCLHF0zZSJx/lcHIjsz//VuQP9Uqsxh/i4UQt5G4kRKeJ+JJOQAP37yZuWSN9CW4Iwwc9vSewNV9zWmS98+S
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(39840400004)(136003)(396003)(346002)(366004)(230922051799003)(230173577357003)(230273577357003)(64100799003)(451199024)(186009)(1800799012)(2906002)(5660300002)(4326008)(8936002)(8676002)(31696002)(86362001)(36756003)(38100700002)(41300700001)(478600001)(66946007)(66556008)(316002)(2616005)(66476007)(966005)(6486002)(83380400001)(52116002)(53546011)(31686004)(6512007)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WW43R0ZTZC9oaHNFUlIrci95aTlNaDByVlVVQ0R4SWhma0dkenkxdVpza0pl?=
 =?utf-8?B?bkFCZ2p4SExPdVhuY0dYbUtKQjh0R3B1SEMvbms4RFB1cVBoUHdWcURiSHhi?=
 =?utf-8?B?eSt4NExxdCtvQm5CalhZcVVEcU1sU0ZQdGxBcEMzRnVyUysvd1lMYWlxYWRk?=
 =?utf-8?B?aitlRURsNlVrL0tqQlhDUmRteFFENW5RVVdqY21TMW1yTnFDclZOejlRejYw?=
 =?utf-8?B?RDdPU0llNDU5cUdTRmtwOVNOUzd5TmViOVcwSFZteDdQeUZoNHl1aHA3WUtY?=
 =?utf-8?B?cnh5SmV1QW02TnJ5OVRLbXBHSlpwOXVpOEoxQlNBN2FMeHVXS1NndGNNWWpZ?=
 =?utf-8?B?c2VpWDFaTVZhUjBtc2RjQ1JrWW1NbmgwdERkUXRhNzQ1NTBLOUIweUdwSHZv?=
 =?utf-8?B?bE1CZ2ljT1lweHFWU2sxNEhOM2t0cTN6UzRxM24vN1RhMTJSb2Ztd0JoYVhy?=
 =?utf-8?B?WHZ1UnRZVjMyM0RVUG9ZUkJYREJXWExmSzBBWHd0bUI4Y0pwS1l4YlY4aWhj?=
 =?utf-8?B?ZmthaiswNlp3Vy9BclV4QTl3cGduY0xqbTd0UERla2JucXliMjR1c1dpc2Z0?=
 =?utf-8?B?SGZUOEl2Sk9oU1V4WG1jbzU1OXRIa1pQZUxoTkhneUoxRS9naSt2c0tMa1g0?=
 =?utf-8?B?ZjJkS0dsZC85TkVwYjh3djJ2Y01vMU13MGZjMW5RTzV5NG8vMG5Rc1hKRkJ3?=
 =?utf-8?B?T2dxY3R0VnNrL3VjZzdqdTZpYnF6YWx1aFNpcEZOSkN0Q0R6ZDA4Z0Z1RmdF?=
 =?utf-8?B?UmFiNkY3SXNXY0t3V2VnQU54RzF3MVpZUXVCRFNjNlZ6MFBNME4rd2M3V2J5?=
 =?utf-8?B?amRMK2pKbnMzUnBvY05QU2tBcnVXaHF2cE8zQ3R1Q05yNmVpZzczK1Z6Skgv?=
 =?utf-8?B?cHJnTTVSMGtuZ1hpMW5PSUtzSWVxb2c4MFpNcm45KzlKeWhhVjJFK0l1dVNI?=
 =?utf-8?B?Q1lIS0NoMkZvV0VXc0FYRTR2YytsRC9XWDR6UmJjTTFkUXIvOE9JQk5TV3Z3?=
 =?utf-8?B?ZmFkMTdOQmNoSW1PNmhXVXZpYmV2WlhaSityUTd1dzFkVS9ITVZpSDZ5cy9t?=
 =?utf-8?B?bDRBNzdrMi9OVzhCSS9taGxhOWVJcDE4cGtYVksxYzVNblMxMUtuTnlsYWxY?=
 =?utf-8?B?MVREUzJyb0NWNlhTblRUOFpPU0JxcTd0dmkxeC9SNm9KOFN6c3hKaHd3c0JL?=
 =?utf-8?B?NXNBUDdGclhwbTVJUCtJajU0ZmlDSnVubmsvSlJQbGFnK284MVFMb2ptWVAv?=
 =?utf-8?B?dGl3eUg5ODY2Tms1MnN1VHhoaVc1bkNXMDBZTGVSNFFlbU1HWTExK3NTUzBh?=
 =?utf-8?B?Zjk0eElTUHBaVFNmbU5iSEFTNXp2Mk1qNTV5SGpDU1h5TDByNUxVQkVwOTZI?=
 =?utf-8?B?cVdWdDFLbHY2Q0xIaEE0blNPS0VHRm1reDNjdFVoemNoVm5SV3U1WGtmcEZL?=
 =?utf-8?B?MGJkUWdvSXhIMVliY2x6V3lkN2MxWGVXWHVLMC9naFVZZUNYTHE3T1FoOUJY?=
 =?utf-8?B?UHVyOUlFczZrQVVBZGRwZjJmZVdRVnFZU0hFZTFXcDkzVHBqVytQYk81aFZK?=
 =?utf-8?B?OXNPejFHdGpVYWlJWGVWc2E3QjFaSURBKzZPaVdOaWViSHZlZzFsL0NEb0Mw?=
 =?utf-8?B?WU04Q1JsZFFGQU1lZ01vQktyQlhjV2NRT3FtUkIrTEdPMFZ2Q2IyV3p0Um04?=
 =?utf-8?B?N2pWWmZJSmpnMU95NGNib0hMSm9CUzRhOWdpemw1KzRYSjRCek9qbHBqNnN6?=
 =?utf-8?B?bHJObmN5b0pCenZPMUV0cG96Z2lRTHJHNm1FR1ZxdW83YUxtTm5xZE1OLzFP?=
 =?utf-8?B?WjlLWlVNTTFOVWl0VWpQTVdXVWdhc3dnY3ZyZWtwazV1blF2YkdwRmVjN2s2?=
 =?utf-8?B?aGk3Y3IvQ2l5dFV4cGVkcmxMbEdWM05TdkhTa1dYck83OWw0MFp1ODB0Q3dr?=
 =?utf-8?B?am8vQlFmSzlaUTk5ZVVyNzJEMmtBMHJNRW05bXJwZVV6a0cvWTZSaTlBTFhF?=
 =?utf-8?B?MHZaRE14b3VSdmd0dmtQdms1bXdMMjkzTVpFanRFMTJkYXZ0cWVNa2VuZTVl?=
 =?utf-8?B?ei93R3Zla0Rab1FQQ3B6c1E3R3ZwUnFEd0ZwbVVpeXEzdzdoVGpYVkRaS0x5?=
 =?utf-8?B?eGFnZURHZ1d2RTFuYUpYSWUrU01sSXZZVUNId0N1OERXcHFFd29IdGdIejQ0?=
 =?utf-8?Q?ljI8qbz19tVYI1jvxeRWM5qtpFG3CKj7TSW1R/RPkfev?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 416f332a-2906-4bb5-0460-08dbea048599
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 20:08:54.7499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tOaggqfcTkzpCDU31Z+F9pBgQ9zuDFkpW4anTijlccLEXnxNOb5JcZlZkq1y1ZLr1eT5tj6z7SMeIumMNz6/Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB1288
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 19.11.23 22:37, Jarkko Sakkinen wrote:

> 
> On Sun Nov 19, 2023 at 10:35 PM EET, Jarkko Sakkinen wrote:
>> Captured from serial link with Raspberry Pi 3B+ and Infineon SLB9670 TPM2 chip, i.e.
>> triggers here:
>>
>> static bool __flush_work(struct work_struct *work, bool from_cancel)
>> {
>>       struct wq_barrier barr;
>>
>>       if (WARN_ON(!wq_online))
>>               return false;
>>
>>       if (WARN_ON(!work->func)) /* <-- */
>>               return false;
>>
>>
>> # uname -a
>> Linux buildroot 6.6.1-v8 #1 SMP PREEMPT Sun Nov 19 21:46:00 EET 2023 aarch64 GNU/Linux
>> # poweroff
>> # Stopping dropbear sshd: OK
>> Stopping network: [  246.487818] smsc95xx 3-1.1:1.0 eth0: hardware isn't capable of remote wakeup
>> OK
>> Stopping klogd: OK
>> Stopping syslogd: OK
>> Seeding 256 bits and crediting
>> Saving 256 bits of creditable seed for next boot
>> umount: devtmpfs busy - remounted read-only
>> [  246.623163] EXT4-fs (mmcblk0p2): re-mounted c5bb63df-c03e-4e4a-9846-0cdf5986edc4 ro. Quota mode: none.
>> The system is going down NOW!
>> Sent SIGTERM to all processes
>> Sent SIGKILL to al[  248.680154] ------------[ cut here ]------------
>> [  248.684825] WARNING: CPU: 1 PID: 298 at kernel/workqueue.c:3400 __flush_work.isra.0+0x29c/0x2c4
>> [  248.693582] CPU: 1 PID: 298 Comm: init Tainted: G        W          6.6.1-v8 #1
>> [  248.700926] Hardware name: Raspberry Pi 3 Model B Rev 1.2 (DT)
>> [  248.706780] pstate: 00000005 (nzcv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [  248.713774] pc : __flush_work.isra.0+0x29c/0x2c4
>> [  248.718415] lr : __flush_work.isra.0+0x44/0x2c4
>> [  248.722970] sp : ffffffc0812fb910
>> [  248.726299] x29: ffffffc0812fb910 x28: ffffff8003e30e40 x27: 0000000000000000
>> [  248.733481] x26: fffffff0350c9c10 x25: 0000000000000000 x24: fffffff03500c028
>> [  248.740661] x23: fffffff03500d208 x22: 0000000000000001 x21: fffffff034f37568
>> [  248.747840] x20: ffffff80064d9ac0 x19: ffffff80064d9a80 x18: ffffffffffffffff
>> [  248.755019] x17: 0000000000000000 x16: 0000000000000000 x15: ffffffc0812fb760
>> [  248.762197] x14: 0000000000000004 x13: ffffff8002808410 x12: 0000000000000000
>> [  248.769376] x11: 0000000000000040 x10: fffffff034f35a98 x9 : 0000000000000004
>> [  248.776554] x8 : ffffffc0812fb9a8 x7 : 0000000000000000 x6 : 00000000000003e8
>> [  248.783732] x5 : fffffff034e46000 x4 : 0000000000000000 x3 : 0000000000000000
>> [  248.790909] x2 : 0000000000000008 x1 : 0000000000000000 x0 : 0000000000000000
>> [  248.798087] Call trace:
>> [  248.800546]  __flush_work.isra.0+0x29c/0x2c4
>> [  248.804841]  flush_work+0x10/0x1c
>> [  248.808177]  tpm_tis_remove+0x90/0xc8
>> [  248.811866]  tpm_tis_spi_remove+0x24/0x34
>> [  248.815901]  spi_remove+0x30/0x4c
>> [  248.819238]  device_remove+0x4c/0x80
>> [  248.822836]  device_release_driver_internal+0x1d4/0x228
>> [  248.828088]  device_release_driver+0x18/0x24
>> [  248.832381]  bus_remove_device+0xcc/0x10c
>> [  248.836421]  device_del+0x15c/0x41c
>> [  248.839934]  spi_unregister_device+0x48/0x98
>> [  248.844231]  __unregister+0x10/0x20
>> [  248.847742]  device_for_each_child+0x60/0xb4
>> [  248.852037]  spi_unregister_controller+0x48/0x15c
>> [  248.856768]  bcm2835_spi_remove+0x20/0x60
>> [  248.860804]  platform_shutdown+0x24/0x34
>> [  248.864751]  device_shutdown+0x150/0x258
>> [  248.868701]  kernel_power_off+0x38/0x7c
>> [  248.872563]  __do_sys_reboot+0x200/0x238
>> [  248.876511]  __arm64_sys_reboot+0x24/0x30
>> [  248.880546]  invoke_syscall+0x48/0x114
>> [  248.884324]  el0_svc_common.constprop.0+0x40/0xe0
>> [  248.889057]  do_el0_svc+0x1c/0x28
>> [  248.892397]  el0_svc+0x40/0xe8
>> [  248.895478]  el0t_64_sync_handler+0x100/0x12c
>> [  248.899864]  el0t_64_sync+0x190/0x194
>> [  248.903549] ---[ end trace 0000000000000000 ]---
>> [  248.910555] reboot: Power down
>>
>> Just putting out. I was testing https://github.com/jarkkojs/buildroot-tpmdd/tree/linux-6.6.y
>> and this popped up. To build sdcard.img bootable with Raspberry Pi 3:
>>
>> make raspberrypi3_tpmdd_64_defconfig && make
>>
>> BR, Jarkko
> 
> So I applied [1] and now I get a clean shutdown:
> 

AFAIU the warning is shown in case that interrupts are not enabled and thus INIT_WORK has not
been called for free_irq_work. This should not be too hard to fix, so I think I can provide 
a patch for that, soon.

BR,
Lino

> # poweroff
> # Stopping dropbear sshd: OK
> Stopping network: [   66.189514] smsc95xx 3-1.1:1.0 eth0: hardware isn't capable of remote wakeup
> OK
> Stopping klogd: OK
> Stopping syslogd: OK
> Seeding 256 bits and crediting
> Saving 256 bits of creditable seed for next boot
> umount: devtmpfs busy - remounted read-only
> [   66.353850] EXT4-fs (mmcblk0p2): re-mounted 6accf2b0-3291-4e1e-90e0-1c75802d14cd ro. Quota mode: none.
> The system is going down NOW!
> Sent SIGTERM to all processes
> Sent SIGKILL to a[   68.412015] reboot: Power down




> 
> [1] https://github.com/jarkkojs/buildroot-tpmdd/blob/linux-6.6.y/patches/linux/0001-Revert-tpm-tpm_tis-Disable-interrupts-after-1000-unh.patch
> 
> BR, Jarkko
