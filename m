Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFD176D729
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 20:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbjHBSt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 14:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbjHBStM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 14:49:12 -0400
Received: from BN6PR00CU002.outbound.protection.outlook.com (mail-eastus2azon11021020.outbound.protection.outlook.com [52.101.57.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D62126AF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 11:49:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0iSchevJPPYeJl5XUymwtRvEH36D/Ts/OgHk/rPKNP6A/P1W3Yat3ZgwmaAkLSes5NQC31pjVspCEMV1Skd06gRt7jZ5pOVnUGsq6g+rh54JBhB+nQFSx+gj40a6Gt5ld1Oo5O2niDFtLyxFIjmXqUrDt2V+vSjkPaJ912T+3XtJDY/73m7CjO89PAsumuI/1ngnt6pCbIQgA0TVteR/dI0zsNvU4d29llory+I/huGNTQiWE5dv9qkGOp2gJgIrS7NNc/Li6kDpcYua3JSR334dfCMQKvHNrzbKH7inYPQISgQm3GeBr6Pb0qXvMGI4ZuRUNmXMOkk6JhOu7Tp+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B+WakoAtu6/mNByC1itf+2Li0cd2l6vyiWA8ZOuJuV8=;
 b=Mifeyo6fFNujGoZxHlkL2p2d9ZQOTPqwF2YvG1gM3ig9V0e/fYpeXa9G0YshqORWA9UN/0PioZduB4oi1ZQbrjrHX8v8jphObC74TgWvNeOCGKUJu8xN741pqi7Ut/5e25GuLCPs/L6vouHZPdJk0ZA3i6ZYSllWy5NzBy+ivFdeRhN+n7XfGGWdIB1BNTCN4DkhY5/JBb9brYKM1OLzTM1FxxnIQoEEk18X5NoDE2fh52HNWBXdaMIIyczLJWy3EJ+kkQ4T+XaZqL9tLMGVgSM8swpf/1irF/bDr9/6Fjo7GtQ3VJLgtnMmDHNUZU+v5kHhypKH6otg5u0NF9zweA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B+WakoAtu6/mNByC1itf+2Li0cd2l6vyiWA8ZOuJuV8=;
 b=EyPJdrlZKITX31sCu9tHPhmgAhH6wJrFzl5Px4+stRwX55r8V4ALn44yHzHu7aVcfHb0xHVMsqvlnIk3f7bu6dmfxJvGoevQLM13q9S3HiLx9u/6zQS6S800I8qdbIADwulq8GFY9CwPdNSjlbUzZfQ6z+kv2LjDCN/YtkvkqpU=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SA0PR21MB1993.namprd21.prod.outlook.com (2603:10b6:806:da::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.6; Wed, 2 Aug
 2023 18:49:03 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::b588:458f:b0dd:8b9f%3]) with mapi id 15.20.6652.004; Wed, 2 Aug 2023
 18:49:03 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>,
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
Thread-Index: AQHZqMj0cBz1DuUt00C3TxZ+fqysYa/Xjltw
Date:   Wed, 2 Aug 2023 18:49:03 +0000
Message-ID: <BYAPR21MB16885DEA2F3248B137EACC22D70BA@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <1687850882-22554-1-git-send-email-ssengar@linux.microsoft.com>
In-Reply-To: <1687850882-22554-1-git-send-email-ssengar@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=b8d0c2b5-0d82-4e7b-b138-87e0bfca477d;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-08-02T18:34:25Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SA0PR21MB1993:EE_
x-ms-office365-filtering-correlation-id: 6214ea2b-5c20-4a55-f677-08db9389243c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DStAmbu22OTMSjW7EHeLhUz4CK4bfkwBhpRMdRB2tSCU2LkTOqjBYkWiXPX85i9bCtsIAsnrQHnoGWUOqdppevTc1c8kCnEuEZvPh8B6M3qJFGqJE6nG4E6OurQwFuLqFSlfBAkU3+D59BEsgjg9S7Dv9WfEXUGq7dXv+J9o/64nuXmx4+WezbZSQAvVXC4XskRgGqM5MPin9jf48ky5tqdFcYyspDGJlue2YwVPIMW9gDi2BsxW35W8+rVj3NEbf7hxslEfmmXpMkNjEkwRdRqGdci0r4bdLFRQqcXWTiBn8tkJAu98VQi0Rsbk9NCqiPDQONPr9+nNuRNei+7m/IH5cwl4rFV6asWvVBlM7V7u37vNM10qVbG6uL3kN9Imu2dYYNqteDZYmgH8JzLzlK746/2R9ySV6xrJ5Zl0Sj8YpwnH610qllCb48tKwPMmP3LX0ceNiUrFN6YeNABWoUlOpFHXuBEd8ph7MILvjbwwgJI4Ep3qK6FSfw7WVEjt/tahnywb81xscBO3JN0YbN32ugmNpfOUxHZwin1zrhfYwr+uaDskOMHR7ZV/HO1tlcKctXuwVjYQ9ky9UxcDPqk2WlJB42EoZ2YdFV1ahUcTirf8KvcqLdSZjEUeJnB37b0cjqbLN4aWPYBVoBzN++59HOb3P7VrMo6gNXDVZPmHbm7DCwqRV3rXhrmVWcLJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(346002)(39860400002)(366004)(376002)(451199021)(82960400001)(55016003)(82950400001)(8676002)(921005)(8936002)(5660300002)(52536014)(2906002)(83380400001)(186003)(26005)(38100700002)(8990500004)(86362001)(6506007)(71200400001)(76116006)(38070700005)(66946007)(66476007)(66446008)(66556008)(64756008)(316002)(786003)(10290500003)(33656002)(110136005)(478600001)(9686003)(7696005)(41300700001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0QZlHjpyzkg9J6I8qUWsAPEPn3gxoE+7Lk1n3XXPObYSv/keZ62Y5sFL9hv8?=
 =?us-ascii?Q?ah/paE01L0q0F3FqNt2qEM+kZg9JsksyOYvyseqYLMkHEH/rsWsW04ZkOpoB?=
 =?us-ascii?Q?N1iPrSibLweI16my8tC6xLeS8rxuQjjLQiSwUDpbyR6HL6WVYI0ObQ4DDs/o?=
 =?us-ascii?Q?leiz4aQ/yaPF2kgPG/SRvfv4Pie4WOBAQhkTfOVBFiLrEaZojzS/uOU/dGq3?=
 =?us-ascii?Q?vZRmtqp5MUxj+Z5d7331sNNppmhArRJz8BsGjOx7LXx8tFCPDe8eLrNe0wf/?=
 =?us-ascii?Q?PNugGqpLknaYNIQNwNNvnX4cHD58l+sB0pUFBPGIFzAzFlQA6DD2szOLTE4l?=
 =?us-ascii?Q?mPnXcYF9ZGCS8JZc1fN/C3tlX0ZmDQmThbWRPF/+ws7/TGFw6hwZ/bRpCCWB?=
 =?us-ascii?Q?1X3OWVa4GfoHUXqp5TxARqwpI3zo75Nd9qZOzh4KWpawsoH/fBFt2B/1AZNE?=
 =?us-ascii?Q?CQGF/bScX5PGSGXZkfAiq8CAXK3VdL72WUVFAUnSFR7kz3OxmefDVyLjeBda?=
 =?us-ascii?Q?RR1WaYlqxY4wh2pjL7xAQiAk73MWixMsECx80BCUnDcsbUNeBUuqMstakIGs?=
 =?us-ascii?Q?zj6V674Hf/0CAbWfshCWs+zHnVL5/ehzsBHPpXntg2iAQ/V7T20YMTmneoWa?=
 =?us-ascii?Q?opzJUhZnijRWkZFUSvPttcsRPz8M9rPsiYen/yOlUcDxfr9eiMi4iKrUyXXP?=
 =?us-ascii?Q?d55uv/7Dnr7nw5/Cf0GSFrWla9k6X2yhg9LLX2Ie2BXms1IbRliQxmzmEDjC?=
 =?us-ascii?Q?N8txfo7KlmBaDmoJ+A2AOBoOdPsX5+D8KO/yZhuoKrRK/trjbQStL1TbdfwJ?=
 =?us-ascii?Q?COVvaOLwpGTglrqqvaVgq3O7Udy9lYPQl5c1FsAI/D5vJqzfIfTK+um3nh2D?=
 =?us-ascii?Q?0siAaKHiIkww2b5TInMv3jovLQgzohmwNBwdXHmxySCmZqaJfd2Zr5M/dya+?=
 =?us-ascii?Q?G1k9eEuJOG6xtvenhJ044j1L3xOC7C+616WjK7U0vMfUYNaW1WqIHsM37Cih?=
 =?us-ascii?Q?ZBNUYLxXk4gIO52Yp6rYa9iAnCNWKwGcXFsOkZPAgTgvxU7u8lGuurWbFm3/?=
 =?us-ascii?Q?4dqEO/hMWEcyQGqXO287m1vyR40eW5G+f7SObw8htGG42lARLWfg1OnSqlcX?=
 =?us-ascii?Q?L+TiEVbugpDP2ldnEHMsRFFtV3IdKiXK5tZt1cjVxzQiDiuh4mwxXIGwKSso?=
 =?us-ascii?Q?kaJzAkiAjC3ZKkge4CVAun++hC592BzRKgSHA0d/LlWMgGSHK55OtekYVHk2?=
 =?us-ascii?Q?Y2eSnUldXA56NKaWtH8yCM8NCkX/f5jdwQuc5nDEb4LpkxwpXY3QknkOTnw0?=
 =?us-ascii?Q?pqTdY/q2dSy7kf+T1U0VIQ6K1GoNizgsHHlSu2rJt1aOuVwE522Jf7786kXA?=
 =?us-ascii?Q?ecKAavhNizX6I1kLGeyyBnBoNLFMV+lCsnCMNOdd6CIQHlYIlxcwlJSRjZq9?=
 =?us-ascii?Q?trDcN65WHSjABCdFSEhNurk2SBpzXti3CSCSg9+1DteEmnW/Xd/wRjV/2GOX?=
 =?us-ascii?Q?L4g5SELtIWLeHfyPp8ejN92Y8HxJzZFMpmA5+vq6x9kSax7NN6hHZ2rQC+gB?=
 =?us-ascii?Q?L7T0RTCZQXZIUk60YdwX1sfx9e20CRTecxEmGe5xKSYL3CdjrYvNHZrhCbSY?=
 =?us-ascii?Q?BA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6214ea2b-5c20-4a55-f677-08db9389243c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 18:49:03.0748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DGcMimNwBJIFE4tyTbTeZaY0S0TktoS02LMylPM+jfCoQWUo4weCS3b5r7/nqWNc+uapIekGthY3UHxONWcIxnVDoxHFvs+3V+j9di+V9JU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR21MB1993
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saurabh Sengar <ssengar@linux.microsoft.com> Sent: Tuesday, June 27, =
2023 12:28 AM
>=20
> Hyper-V has usecases where it need to fetch NUMA information from
> Devicetree. Currently, it is not possible to extract the NUMA
> information from Devicetree for x86 arch.
>=20
> Add support for Devicetree in the x86_numa_init function, allowing
> the retrieval of NUMA node information from the Devicetree.
>=20
> Additionally, relocate the x86_dtb_init function before initmem_init
> to ensure the Devicetree initialization prior to its utilization in
> x86_numa_init.
>=20
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
>  arch/x86/Kconfig        | 1 +
>  arch/x86/kernel/setup.c | 2 +-
>  arch/x86/mm/numa.c      | 3 +++
>  3 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index c531b16ee0bf..a2ada193b2d8 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1567,6 +1567,7 @@ config NUMA
>  	depends on X86_64 || (X86_32 && HIGHMEM64G && X86_BIGSMP)
>  	default y if X86_BIGSMP
>  	select USE_PERCPU_NUMA_NODE_ID
> +	select OF_NUMA if OF
>  	help
>  	  Enable NUMA (Non-Uniform Memory Access) support.
>=20
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index fd975a4a5200..940c92a6a5e9 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -1220,6 +1220,7 @@ void __init setup_arch(char **cmdline_p)
>=20
>  	early_acpi_boot_init();
>=20
> +	x86_dtb_init();
>  	initmem_init();
>  	dma_contiguous_reserve(max_pfn_mapped << PAGE_SHIFT);
>=20
> @@ -1261,7 +1262,6 @@ void __init setup_arch(char **cmdline_p)
>  	 * Read APIC and some other early information from ACPI tables.
>  	 */
>  	acpi_boot_init();
> -	x86_dtb_init();
>=20
>  	/*
>  	 * get boot-time SMP configuration:
> diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
> index 2aadb2019b4f..a6d3d331fda2 100644
> --- a/arch/x86/mm/numa.c
> +++ b/arch/x86/mm/numa.c
> @@ -11,6 +11,7 @@
>  #include <linux/nodemask.h>
>  #include <linux/sched.h>
>  #include <linux/topology.h>
> +#include <linux/of.h>
>=20
>  #include <asm/e820/api.h>
>  #include <asm/proto.h>
> @@ -733,6 +734,8 @@ void __init x86_numa_init(void)
>  		if (!numa_init(amd_numa_init))
>  			return;
>  #endif
> +		if (acpi_disabled && !numa_init(of_numa_init))
> +			return;
>  	}
>=20
>  	numa_init(dummy_numa_init);
> --
> 2.34.1

This looks good to me.  I've looked and don't see any
obvious issues in moving x86_dtb_init() earlier in
setup_arch().  But I also know the setup ordering can
be very tricky to get working correctly with a wide
range of platforms, and I don't have that expertise.
But with those caveats,

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
