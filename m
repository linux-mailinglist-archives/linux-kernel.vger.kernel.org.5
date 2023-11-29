Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFFC7FD4A6
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 11:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjK2KrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 05:47:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjK2KrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 05:47:18 -0500
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11012005.outbound.protection.outlook.com [40.93.200.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67B2DC
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 02:47:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QH4L9ZdZxOmNEQPY41B0jYfpdMTShfEbm3hcJvmrVfDcO692gAR2lBIB/+fSAGTMdTL8TEz/VGg+wPFXOOAqyEhBrXHEfQYbjmG3vry+BRnc9XI214lfMUgroSAkgA3mWaQtdW7PvMSmALp1d/AMGiUIuITSW8YgoEIARsVwF00ypdWC7G2qz/gfFfmqZQLkYtPpkJmW6BHE7+sZcRWaCy3YLGq4mdjzYYwkY22bZTuYLZdCdGFwmPv5e2zLDFr4WX9Nj2ADm/pP5a3yUajmkXC/yah4tf+E8BJphhKlH7U9+FPfiH+v3Tl9Fd2fpq6HsuXw6twO6aOiiFcdw1a1kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJpAFdhGJL/PE8TQSOFtElkqRCi/ULkEYIGH5zA+KAM=;
 b=iVx/tqE0YzhfBH2z6WrQBh+1cjRt4lk7ce6MsNqX0PzK8q06DlhapM2DOoO8/7ZpwEfcAePGrGejqbQugK0/1P4C+DNs31j2c5Ww8LRKtcBHzD7VVIWjV2wbHrqy5AcC2B2cuAN4eglFtTbL+AiKgZMeeMpJGs+XtLd9yibSfhUvhO1OURxB6Bo5sF0Q37udE+jlW3s+51gK87+CvafFDudCdRzWGLcRzzbrYaWMrw27DrI+KiPCMZbZckTYAf0EQ76PZi/84Bd2AG9Y0VWPZVMBdA6kVLS2D/+tvgPrCl55dz1j4o20zx7J3L76bBYLRIcmqd1Wlh9pywNHsTxZrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJpAFdhGJL/PE8TQSOFtElkqRCi/ULkEYIGH5zA+KAM=;
 b=BQZcdllbGWGVkAQxxHfbxn2r7cyHvTIETt+OP3DLhFmdVsNVid94VWaSWwoCYRzHsj5qpWr3+k7YieYFiLoqREDK/3RGB/un19c0HAiMsecNZpHfElc7FxY6E1kTa1R53i4IyJb/NBuRYz0eyC+jXNPFOMCzOhS5KzM+FURqT8c=
Received: from BL0PR05MB5409.namprd05.prod.outlook.com (2603:10b6:208:6e::17)
 by PH0PR05MB10063.namprd05.prod.outlook.com (2603:10b6:510:29a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Wed, 29 Nov
 2023 10:47:17 +0000
Received: from BL0PR05MB5409.namprd05.prod.outlook.com
 ([fe80::a6f3:b0ad:90f:e26a]) by BL0PR05MB5409.namprd05.prod.outlook.com
 ([fe80::a6f3:b0ad:90f:e26a%3]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 10:47:17 +0000
From:   Ashwin Kamat <kashwindayan@vmware.com>
To:     Tom Lendacky <thomas.lendacky@amd.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "jroedel@suse.de" <jroedel@suse.de>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        Bo Gan <ganb@vmware.com>, Tapas Kundu <tkundu@vmware.com>,
        Vasavi Sirnapalli <vsirnapalli@vmware.com>,
        Ajay Kaher <akaher@vmware.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Ashwin Kamat <kashwindayan@vmware.com>
Subject: Re: [PATCH] x86/sev: Update ghcb_version only once
Thread-Topic: [PATCH] x86/sev: Update ghcb_version only once
Thread-Index: AQHaEHsQHcuOCrEzhUGRricPD8ACVbCO3B8AgAJltAA=
Date:   Wed, 29 Nov 2023 10:47:17 +0000
Message-ID: <AD64E227-94C9-4B1C-A88D-D8EB768CF96A@vmware.com>
References: <1699252361-1286-1-git-send-email-kashwindayan@vmware.com>
 <4219d88f-5c09-408f-b72d-1685367072f0@amd.com>
In-Reply-To: <4219d88f-5c09-408f-b72d-1685367072f0@amd.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR05MB5409:EE_|PH0PR05MB10063:EE_
x-ms-office365-filtering-correlation-id: 7e167a37-59f9-4dab-817d-08dbf0c88e35
x-ld-processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtFwd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 33VnUm9dbwJbeI6KjnQTJQEJOX0G5BWT9CDzq6KDeIhalzDlUomeCx+4W5pj7Ln7H+9Rv43AJEvfgUQlRpHJ8JyN1M9IbS9xLO1Gf9u3HG4y00Vt2IJ375rgzCGZmNK4N33FIm7nQ0saetZ0OtJvMDcWtd6DATG8sL7WvsNhOEXNnqFI7Y1kFKB1XOlwAxQfb2hdNYeb29CVyDeLhbGoaHUaQgQVDuoIa6mUuXljciFeRzrZ8R2MfY4r/zip6yH8k+hol/YvP7xuNlLa4XKiOKpfScyFkYWLPX9z2AFLX1eJW9KDuoUJMMcyjkM4ob4cbOLRqdH4SJy7BGNUE9kpwgUXcKjiHLb2tY/x+Ek6nyl4HCGF+9xq4RtxllN9VxztkXNz6D3B74SGbongajge26sOeAG1OM3kHWHzbbv9UEwpnvmcJSD/Tkf30OBl8oUQImaSWYyUgaeUnSFqGiwH6hLc9mTZphie/MvnXXatUFtra9pe1YY+psNWGJnXufr/MXpDYsvQWe+/+C6NxnsoGgq/gF5yeWHS8z38VdkcWQIPmBdxJ5Un2Rz2cYsYIHynOW9hOb7pm/Ko/ow+lFxf7w70Rwc5zGkDmFNhiXN4Q6UD5szCEcpfTvJeBrpX0OycFJLeL4Td2RmbG9AJKLtMc2GV7vcpFlTJW+RgQc+aAiJpVIPtDxDM7Oix8DC8/HPpvdjfH8BNhu9ZDz3ujw4aR+LkTW0tIeh3lC33or0cTkQQSxnOPE1dhDAGJSoE9g3Z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR05MB5409.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(39860400002)(376002)(346002)(230173577357003)(230273577357003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(2906002)(8936002)(4326008)(8676002)(6512007)(55236004)(71200400001)(6506007)(53546011)(66899024)(66556008)(91956017)(64756008)(66446008)(66476007)(76116006)(6916009)(54906003)(316002)(6486002)(478600001)(66946007)(122000001)(15650500001)(38100700002)(41300700001)(36756003)(33656002)(38070700009)(86362001)(107886003)(26005)(2616005)(83380400001)(7416002)(5660300002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1Urz0G1Paqw4OpyUL2xclwmvKa6yQXcneQFjjSFU9uWD7z5UkctMa93l0nxC?=
 =?us-ascii?Q?OA5FZpUfSKVH7voIpk4LFSRCHkulTf6bTWHyvf0rMykWbY6lpTH+OX+rUybV?=
 =?us-ascii?Q?VdNZMgjxSqo4gfqa/GnApZn47Xl3G3YSsG7JVNldntj3EhyZ1HhlNqDajdp4?=
 =?us-ascii?Q?JE4UoHcR34wdf5xIyzLDEEmJuE4GyPJRDTq3D6wS4QTpOLoUtEOFs4EmuBa6?=
 =?us-ascii?Q?TlHqjFdbDEncLhmGlvVAS5C6OaImSnqNgONst11BaXdg6eNpuGlLakqmjKAb?=
 =?us-ascii?Q?JxJj9FIAij77xdWiJkYqqDTr+Ma80roXw22WdEq1WI304s7vIIZEyRdm6moZ?=
 =?us-ascii?Q?XNOkb5k24w+O3NYBkLTXTasjZjtZ705IWf13dx/alN8wt3EnecOjeEKPTLmZ?=
 =?us-ascii?Q?+U8+Xvxy2Frlo6t4PbHXoZhAFxP45ij/sFD57sQ3Zv74Y8X1UxCDxXmSH4eW?=
 =?us-ascii?Q?nscjWXm2DbsoAxWaBONdGHNS49mckh+T15vevSbpRCCnDXQVnchdkW7qpAEY?=
 =?us-ascii?Q?m/HRMLoX8bEgKAwCT1m0Q7rUtMhwOJcDiwOQIO7qBJV36b4nRZ+lprmjjpE2?=
 =?us-ascii?Q?izG0Xh/An8rfdaBvuj/HHKYTZ3pGNvkeCFRmua0I7W6705JKiNHAJ9hH9ZsX?=
 =?us-ascii?Q?5wihCU4qkgGjPwFwK5tMHDQqVzsGJax52powHL64cnm93ZZrxdJhymGigM9+?=
 =?us-ascii?Q?viyWHWiwXJOFsbHDsjtR8vKZZPmV9/9fsct4eMG0Oxk4wrnyCF1+RHlyTqr7?=
 =?us-ascii?Q?QEqPyaSIscPnb6wEUpbzfI4Oj/RgmJI0KH/9SL6boifCpHMFjeV98dD57Grl?=
 =?us-ascii?Q?6kRB+mjiG1tut9o++i9OjkvxLxPBBV+Pt9DQa/GiYONtVJfWEhOH8B/jPONK?=
 =?us-ascii?Q?yeqXWr/cgNDCvI4i2WuJUmbGyR43o+SpUbESF2PjWqhZjNy4zgq13BAVEJ3g?=
 =?us-ascii?Q?rHD6wWSjzJKcEemE3nM39roBJ8UANEsIqgQooIzzF3Dqd9pgLCjxknyH802t?=
 =?us-ascii?Q?m3UAFKEaekynQIZGhHqeTcbW0BmhKtTbAHTPB71htnZl1yI4xKvEuO6ilz1A?=
 =?us-ascii?Q?1aGn3VZB2VHgYUD/OeB43xl42/UO1FFRm6i+o1Nq3ytLupCO9tua+p2nW5Bg?=
 =?us-ascii?Q?etA3Diu3AqzrPSzSViii4nE8pRSZpD1biofRY3EuwSIwqk2XEZQ05RpRKAz/?=
 =?us-ascii?Q?ETBGVTD+Bm4Ks4PjvWC7E87NFnMD9DwUE3A4FCQFmJtXgi2edPu1l00PoSQZ?=
 =?us-ascii?Q?649UltiNzxFN+MwDocz+u5zwIKlseIvv/4V4LqVlNP/gDOb9msFb8ynH6sB7?=
 =?us-ascii?Q?5uE/TBEKr9J4tuBtUoRhk7IPywTUqqpNllzMl8gPwf9jc5eMYMTGVBDo5e/E?=
 =?us-ascii?Q?nKmMHqRJy35XyGzFcMH/RvorwFSbfEwoDaTu7Gs176Jg/fW4TMMY33/pQ1Ug?=
 =?us-ascii?Q?KcgHDb8yU/2ayAcpEwgmYoRKt+LkTRcbdPECc3jRIwqioRBdfuTKxE/SrtjF?=
 =?us-ascii?Q?mmY608TrhIWKTNKePlvBz5+rqQXM0EE3dxzjmkkSuYaUm5u6SAXzEnvuT6Mj?=
 =?us-ascii?Q?4NFPnoMXylF9PkPrSZpXQZwqD/1QRJQ92jrN5WUjcYY6bVKl0bDqR8O76w2m?=
 =?us-ascii?Q?qg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <41EE618D7583374694DABB700A612D41@namprd05.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR05MB5409.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e167a37-59f9-4dab-817d-08dbf0c88e35
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2023 10:47:17.2695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mulxy+PN0ElDH12sdyUjQa4kwS5320HoPfuNyUixK2RlGJVhYZAlaZl6PFDsgzuZkmXhGj+RtOSI+Az2X0DJNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR05MB10063
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 28-Nov-2023, at 3:40 AM, Tom Lendacky <thomas.lendacky@amd.com> wrote:
>=20
> !! External Email
>=20
> On 11/6/23 00:32, Ashwin Dayanand Kamat wrote:
>> kernel crash was observed because of page fault, while running
>> cpuhotplug ltp testcases on SEV-ES enabled systems. The crash was
>> observed during hotplug after the CPU was offlined and the process
>> was migrated to different cpu. setup_ghcb() is called again which
>> tries to update ghcb_version in sev_es_negotiate_protocol(). Ideally thi=
s
>> is a read_only variable which is initialised during booting.
>> This results in pagefault.
>>=20
>> From logs,
>> [  256.447466] BUG: unable to handle page fault for address: ffffffffba5=
56e70
>> [  256.447476] #PF: supervisor write access in kernel mode
>> [  256.447478] #PF: error_code(0x0003) - permissions violation
>> [  256.447479] PGD 8000667c0f067 P4D 8000667c0f067 PUD 8000667c10063 PMD=
 80080006674001e1
>> [  256.447483] Oops: 0003 [#1] PREEMPT SMP NOPTI
>> [  256.447487] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 6.1.45-8.ph5 #1=
-photon
>> .
>> .
>> .
>> .
>> .
>> [  256.447511] CR2: ffffffffba556e70 CR3: 0008000667c0a004 CR4: 00000000=
00770ee0
>> [  256.447514] PKRU: 55555554
>> [  256.447515] Call Trace:
>> [  256.447516]  <TASK>
>> [  256.447519]  ? __die_body.cold+0x1a/0x1f
>> [  256.447526]  ? __die+0x2a/0x35
>> [  256.447528]  ? page_fault_oops+0x10c/0x270
>> [  256.447531]  ? setup_ghcb+0x71/0x100
>> [  256.447533]  ? __x86_return_thunk+0x5/0x6
>> [  256.447537]  ? search_exception_tables+0x60/0x70
>> [  256.447541]  ? __x86_return_thunk+0x5/0x6
>> [  256.447543]  ? fixup_exception+0x27/0x320
>> [  256.447546]  ? kernelmode_fixup_or_oops+0xa2/0x120
>> [  256.447549]  ? __bad_area_nosemaphore+0x16a/0x1b0
>> [  256.447551]  ? kernel_exc_vmm_communication+0x60/0xb0
>> [  256.447556]  ? bad_area_nosemaphore+0x16/0x20
>> [  256.447558]  ? do_kern_addr_fault+0x7a/0x90
>> [  256.447560]  ? exc_page_fault+0xbd/0x160
>> [  256.447563]  ? asm_exc_page_fault+0x27/0x30
>> [  256.447570]  ? setup_ghcb+0x71/0x100
>> [  256.447572]  ? setup_ghcb+0xe/0x100
>> [  256.447574]  cpu_init_exception_handling+0x1b9/0x1f0
>>=20
>> Fix is to avoid updating the variable after it has been initialised duri=
ng booting.
>=20
> The call to sev_es_negotiate_protocol() could be moved down to after the
> initial_vc_handler if-check in setup_ghcb(). That would then put the call
> to sev_es_negotiate_protocol() only in the BSP boot phase (and it only
> needs be done once). Does doing that prevent the #PF for you?
>=20
Verified the change and it works fine. Updated the same in v2.

>>=20
>> Fixes: 95d33bfaa3e1 ("x86/sev: Register GHCB memory when SEV-SNP is acti=
ve")
>> Signed-off-by: Ashwin Dayanand Kamat <kashwindayan@vmware.com>
>> Co-developed-by: Bo Gan <ganb@vmware.com>
>=20
> This tag needs to be moved above your Signed-off-by: and it needs a
> Signed-off-by: for the co-developer.
>=20
Fixed in v2.

> Thanks,
> Tom
>=20
>> ---
>>  arch/x86/kernel/sev-shared.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>=20
>> diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
>> index ccb0915e84e1..a447908f2b4d 100644
>> --- a/arch/x86/kernel/sev-shared.c
>> +++ b/arch/x86/kernel/sev-shared.c
>> @@ -144,6 +144,9 @@ static bool sev_es_negotiate_protocol(void)
>>  {
>>      u64 val;
>>=20
>> +     if (ghcb_version)
>> +             return true;
>> +
>>      /* Do the GHCB protocol version negotiation */
>>      sev_es_wr_ghcb_msr(GHCB_MSR_SEV_INFO_REQ);
>>      VMGEXIT();
>=20
> !! External Email: This email originated from outside of the organization=
. Do not click links or open attachments unless you recognize the sender.


