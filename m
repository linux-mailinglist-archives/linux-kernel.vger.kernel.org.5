Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F32778C16
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 12:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbjHKKaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 06:30:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjHKKaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 06:30:04 -0400
Received: from HK2P15301CU002.outbound.protection.outlook.com (mail-eastasiaazon11020025.outbound.protection.outlook.com [52.101.128.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 190EDF5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 03:30:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NiIIAuzQPBKBcDBzWkDppGRxcvRcKDAIn6IncnbD7oyZUKWJRwZBCF8kw9sklK59t3YZKZe5hOwrBtshPDJmreZk9WzoqEXrBR1RQXmHqq6oFbT5Di9ebVwsF7T2LxmVqG2pQLmBKLyxLv7PWHRFJf3TZL/WDAsXCLurOZ5mM/9aT5GcUKLcbCmIMIFwAQ0DJNVAGl7Yn/Y3MFda/CxWK3sdYdwXR+qXBYpmGQWn4JC28s5C8uEBnse9kLXftqyA3Q4mfmejFDOKWuAKC8ilWyUAQGsL0oNBQLQEOc/iTKaMsET0RJ/OfhpxB9zBC74sCQbjipH/YMpqOVfhRjTBxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rckSP+wlK8XEVORdmpmuoG8D87CpHhXVoct5il9sNTs=;
 b=CKcR0d1zqcQXcr3pd18bFasijBkYvefJc+RVsiGNn2Wq/OUfuOiABQ3UxQ5SsrTN2tOC77jFTJGtF6qqOmvJvjWGBly5vm7VjzWD3Qm/gLFptVBPfOeritz6h7HYmihxF8GUYLIBqJ0/cv0NqUJN8M0l9ty1Uq46W2Hy9fm+eD9DpumeeMaUTX27AoEkZ3lOUC+hcS83QdlJat2V4s2qteXu0vflmodMnh5/nlS82xwd08OxxZFPW7owNWk7Cl7K1gDIgfYHpIC+MxTIpa18qBGkaFbuRmQfBphmboRXbCQ4Kjp+a8R2NfdTIjU1XmmiGqwy2dEpWwlX1vBOIkmsow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rckSP+wlK8XEVORdmpmuoG8D87CpHhXVoct5il9sNTs=;
 b=jPAS7bYSMbhIEzGinikQ9RxelXfbeZ9B1dlzu/VJZwcSMFd1Xer4WCfbxmzlk1hMrP+Gfj2vlQykd3hpIJ+KkLKSyw5DXaMtV0YJVU+FxA95u83f+9CyKckbdewsytGVqM8mS7V+SN6WNIfkTx+nfe+KpYs1329dHIgC+kMs2Nc=
Received: from PUZP153MB0635.APCP153.PROD.OUTLOOK.COM (2603:1096:301:e2::8) by
 SI2P153MB0444.APCP153.PROD.OUTLOOK.COM (2603:1096:4:e9::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.8; Fri, 11 Aug 2023 10:29:58 +0000
Received: from PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
 ([fe80::97bf:be96:1ebd:5190]) by PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
 ([fe80::97bf:be96:1ebd:5190%4]) with mapi id 15.20.6699.009; Fri, 11 Aug 2023
 10:29:58 +0000
From:   Saurabh Singh Sengar <ssengar@microsoft.com>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        Saurabh Sengar <ssengar@linux.microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/numa: Add Devicetree support
Thread-Topic: [PATCH] x86/numa: Add Devicetree support
Thread-Index: AQHZqMj18wvdpynsiE6phwVwKFX+GK/XknGAgA2Y1EA=
Date:   Fri, 11 Aug 2023 10:29:57 +0000
Message-ID: <PUZP153MB0635C754D81715D1B60A6D6FBE10A@PUZP153MB0635.APCP153.PROD.OUTLOOK.COM>
References: <1687850882-22554-1-git-send-email-ssengar@linux.microsoft.com>
 <BYAPR21MB16885DEA2F3248B137EACC22D70BA@BYAPR21MB1688.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB16885DEA2F3248B137EACC22D70BA@BYAPR21MB1688.namprd21.prod.outlook.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b8d0c2b5-0d82-4e7b-b138-87e0bfca477d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-02T18:34:25Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZP153MB0635:EE_|SI2P153MB0444:EE_
x-ms-office365-filtering-correlation-id: 7af4e8db-bdd9-417f-a652-08db9a55e94e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LEC0fIGEb/Q1FL7ThwfcMFFI+IRfFJ5/hYzBYzgeg/jKMcjSDNXYuOe04yHwlFKibschVChviVOVTdEXCSklc8Bkf7WxUbZjQPVmyY4ULpvNPd6PSuYc8kEZZWMv0qqFKLl8deSIwZs9WeZ778f6ZnjUt2hAdowZLm50AFtceYkc70bVU+4uwILksoGFOeI4Uha3hTPWrGEt/jGG0mBNNqAYpr7D0WsAGP/9U6Hh8VWLPURd+HHMj4CVJgEvydhvWvH2FGRmnOamrau7CkcPa17yOu2vIVt3dSvpt9z8iTlJ7b0Wfx/7qggk/K4DkDDR8uoXmKv0KubcJV5Tm+GhAGR5tmjEQjt+vd+2oxIOG54Hzz8aqMOmQFNQKK6DEAcuaw/BcYY491HKlacgj+pRvvI7OYqbqLPGPKKf1Pp6oguLIpN/CUirDUJoXz5CWkuxcNY6MRHd7TlHeQwSA+eJl/HMVHtXbAsK+/OkpUFJxTJQBnNHNa5ISw6/8hgh9toc1gAECoGVcIqc/YGQ9QVurnHupJcZbI8zKM/lsQBRwnvsVk7PJGGSv1/TCnTaphPm31lV6Th2jYrxqQAWW5leyWr2F6IrWUBKo3pqpWEL18RRLzMokdbsloLJ/z9Sp0kVmZAKNGcyI5cwbiCDwsnhjBPyN702suhilaKdX+uH1jraey9R5fmfBL8aA0SzciL8z529Kcy2hM4dnyZM987l+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZP153MB0635.APCP153.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(366004)(396003)(376002)(39860400002)(451199021)(186006)(1800799006)(38100700002)(86362001)(2906002)(8676002)(8936002)(52536014)(12101799016)(38070700005)(82960400001)(82950400001)(83380400001)(122000001)(33656002)(921005)(316002)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(9686003)(7696005)(55016003)(478600001)(10290500003)(110136005)(5660300002)(41300700001)(8990500004)(6506007)(53546011)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uCugIZEsOjhji9SFRlahV4zKEaMaTFKgRja9YWFZmBE9Uwj/Ifn9PZxTX1pJ?=
 =?us-ascii?Q?jbx+7Ep6hKD2jriIm3xmDflA01B6VwQx1MYjT5O3e1T1on9NikxPp43P9Qvi?=
 =?us-ascii?Q?CNn2ArFVGV8q0UQ3+LnvGEjv92dAyq7VJjHLwySE+nuoOzJ4S6eTI3/PD75l?=
 =?us-ascii?Q?uNyLw3ixnrSvegiaH50KjjwCtPQIMsBrGLYvme9r4Tlm5uh1H2ieeBDd6a3S?=
 =?us-ascii?Q?VLwuvXqkgirg5rm5ZjUp5kltKvQHYYuu2bwRGYrNw4Mno38ox333imzPP3w/?=
 =?us-ascii?Q?1Z5rkcKvOnngNnwLMFQq8SpLfg2CJTamay5vQ+2YSqxqGByW3HhlisK4jB8b?=
 =?us-ascii?Q?n4jaF4EGsjxFxucQavp9ZSGEKT8KR510MemmwBfKStDmnL/s3WEca7K2jb7L?=
 =?us-ascii?Q?n9AYrPn50WR52dAI/38gBZVew9Bf3vTsgS/Onj1pWLYLHSo9nNkkVMt5djVe?=
 =?us-ascii?Q?TdZ9+2UpaX9XX5y3BM0Q8GRCD/Y8PWCov7UiLVoSVwr7hJu22MKHqte8294k?=
 =?us-ascii?Q?E130pdQ3g5reHKwSj7llrzXwRd2HmW7Gfs7jRL/OlRUnWMT/gx39E4LoiSqp?=
 =?us-ascii?Q?IFgnZ+DqrdXXld9Tv1dr7Rm4XZ+WdaA1zZu5rd73CdKBN+pnjNlI4Me7xCI+?=
 =?us-ascii?Q?vB0Rra/YJQ3Z9ygAUfSTueyeKlmLjs5/Upxtv6sEeY21edVIz8Ew3/NsAnYt?=
 =?us-ascii?Q?G5NWaazelBr0arbcvXCWB0nJ/uZRn7jAq4usHgsjUS7NsXD174bquwqCY6pr?=
 =?us-ascii?Q?CbKEj1SRJ2B05G+FRvJ1U3MQ7FmT9QeAVVBgEN6beOPnipGNfhvq0+pjGvaZ?=
 =?us-ascii?Q?f9s9frlK6N8C6QeO4BWIHAQMlvhk+6Oc5fe6+I4/VFU48AMlsFb/UGM9tgoA?=
 =?us-ascii?Q?iZc/gfYeV3arnY2I1i9AlCd8X/2cz5apzsY0cv9A/eSatPeBzqiwhAtnBkBh?=
 =?us-ascii?Q?5qhDrInBhf21Fayi2duV/lFqCzMqbow0xrthAncn4eJ+6RPMfC8nzieNebss?=
 =?us-ascii?Q?/jJcgMXfPHG2zVHRwp5/wmYWKO5R1LQ/DEsd+3mkCmnNN9wHoaqPyyIdXBGv?=
 =?us-ascii?Q?hpdzIwYMQkanrnMAynKfkkMSpFq7I17ufuR8+ekN/sO8Hedw/idswAZiB3a2?=
 =?us-ascii?Q?J1236m4AhNgayNxIVwPCUXz/ZjOYJtxN1TY6xDFMoLdgAk943UbBZr+mVaZv?=
 =?us-ascii?Q?PUyzF/EVLY9piGfmYevE9DKl9yF0gluYpHeCcsZXvOxLIWpwGdDrexasbsan?=
 =?us-ascii?Q?Do2F9WP9Y/JhZOEgYiHxU5GUdLdOulsLVIG8APCzdTLLG94C3JWN/FiMFyln?=
 =?us-ascii?Q?rCPzocg6pZVWG+oYjzIdNpwRHTZTQ0IF912bmHlidfMRzlt5CGI7rIeFyvDK?=
 =?us-ascii?Q?62iK5ZmLHiIEPd4GBRb8R0jf9Q0S/p4mMaFxPH8r+cAwhgwRC7y9C0mDJEAu?=
 =?us-ascii?Q?Vxt6kGH7oM4KdXCgv/mS4XypU9i/vckv506SIBqd354gsC4WHjm4Wd7eUXll?=
 =?us-ascii?Q?I/rM7G66W1mUe7WEn8MPbVbSfvMOtBlzcE/Mz+wp5k9HXCr0YmLhjKjXcA6m?=
 =?us-ascii?Q?/ENOFRnzO4MXBZNzjY3HoYEZ8oySx7YBGC5tO03+?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZP153MB0635.APCP153.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7af4e8db-bdd9-417f-a652-08db9a55e94e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 10:29:57.9842
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VOKw9NKFG1OCSpT8DlDiGL+K/GfxVx6XvE7mrUq0dFPRTXxOx1i048k9yQZZthKEHe9SuZygCHooOAnnn9riog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2P153MB0444
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Sent: Thursday, August 3, 2023 12:19 AM
> To: Saurabh Sengar <ssengar@linux.microsoft.com>; tglx@linutronix.de;
> mingo@redhat.com; bp@alien8.de; dave.hansen@linux.intel.com;
> x86@kernel.org; hpa@zytor.com; luto@kernel.org; peterz@infradead.org;
> linux-kernel@vger.kernel.org
> Subject: [EXTERNAL] RE: [PATCH] x86/numa: Add Devicetree support
>=20
> From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Tuesday, June
> 27, 2023 12:28 AM
> >
> > Hyper-V has usecases where it need to fetch NUMA information from
> > Devicetree. Currently, it is not possible to extract the NUMA
> > information from Devicetree for x86 arch.
> >
> > Add support for Devicetree in the x86_numa_init function, allowing the
> > retrieval of NUMA node information from the Devicetree.
> >
> > Additionally, relocate the x86_dtb_init function before initmem_init
> > to ensure the Devicetree initialization prior to its utilization in
> > x86_numa_init.
> >
> > Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> > ---
> >  arch/x86/Kconfig        | 1 +
> >  arch/x86/kernel/setup.c | 2 +-
> >  arch/x86/mm/numa.c      | 3 +++
> >  3 files changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig index
> > c531b16ee0bf..a2ada193b2d8 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -1567,6 +1567,7 @@ config NUMA
> >  	depends on X86_64 || (X86_32 && HIGHMEM64G && X86_BIGSMP)
> >  	default y if X86_BIGSMP
> >  	select USE_PERCPU_NUMA_NODE_ID
> > +	select OF_NUMA if OF
> >  	help
> >  	  Enable NUMA (Non-Uniform Memory Access) support.
> >
> > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c index
> > fd975a4a5200..940c92a6a5e9 100644
> > --- a/arch/x86/kernel/setup.c
> > +++ b/arch/x86/kernel/setup.c
> > @@ -1220,6 +1220,7 @@ void __init setup_arch(char **cmdline_p)
> >
> >  	early_acpi_boot_init();
> >
> > +	x86_dtb_init();
> >  	initmem_init();
> >  	dma_contiguous_reserve(max_pfn_mapped << PAGE_SHIFT);
> >
> > @@ -1261,7 +1262,6 @@ void __init setup_arch(char **cmdline_p)
> >  	 * Read APIC and some other early information from ACPI tables.
> >  	 */
> >  	acpi_boot_init();
> > -	x86_dtb_init();
> >
> >  	/*
> >  	 * get boot-time SMP configuration:
> > diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c index
> > 2aadb2019b4f..a6d3d331fda2 100644
> > --- a/arch/x86/mm/numa.c
> > +++ b/arch/x86/mm/numa.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/nodemask.h>
> >  #include <linux/sched.h>
> >  #include <linux/topology.h>
> > +#include <linux/of.h>
> >
> >  #include <asm/e820/api.h>
> >  #include <asm/proto.h>
> > @@ -733,6 +734,8 @@ void __init x86_numa_init(void)
> >  		if (!numa_init(amd_numa_init))
> >  			return;
> >  #endif
> > +		if (acpi_disabled && !numa_init(of_numa_init))
> > +			return;
> >  	}
> >
> >  	numa_init(dummy_numa_init);
> > --
> > 2.34.1
>=20
> This looks good to me.  I've looked and don't see any obvious issues in
> moving x86_dtb_init() earlier in setup_arch().  But I also know the setup
> ordering can be very tricky to get working correctly with a wide range of
> platforms, and I don't have that expertise.
> But with those caveats,
>=20
> Reviewed-by: Michael Kelley <mikelley@microsoft.com>

Hi X86 Maintainers,

Is this good to be accepted ?

- Saurabh
