Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E5E7E16B2
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 21:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjKEU5p convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 5 Nov 2023 15:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjKEU5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 15:57:37 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04olkn2069.outbound.protection.outlook.com [40.92.47.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31B7EB;
        Sun,  5 Nov 2023 12:57:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dy2kbY5HqkDcDHdR9aKAgnKXOp+ZBozbXrALq730dqSEbPZck+Bo2+/iomxGdeJrOzzMN+VJ2rbB1ajTzECu8K5NHjJh0OGIkHImbFxyGCyua31ldL4snlfmzcrWaS+rDM1oJbMtagKMfqTLzujyzuyiij9tHqQK0RACV37Z7JFV0RzqQ8CSS65ENmxhudnmov9Ls1XuK/c2GUDvRDLoV2H6ZajQrtRF9rA5Ylqd/LDn32JqoOBPLSiY5LlJd/VNKnn+Vjcxwuw3iu5UWSAeANBTCVEYxK6wCRA5dLJlC3GWHXJ/8RBmAFAk60BA/Qlb0h3AksyWNGVfGnqwm3m1XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KYVQB2VfyPF40H62lUjWWyS3mvhU50Fftcie/KgfEQ=;
 b=dxLoUFTRlQVQMINcvgJUmburq2OvzB8tf4ZuiO/FtSuIfwKdy0p/QEK11Wp/6slEMJOJqUXMtnUc1+qoQaeMJdnGXktXX+HNcDCZ4Rn7gUiOE0QeIpb/W2jEmUMYYMSnBrOEa/wi09Cq3ggy3XAXpXQSchoUrcmRR7G6DtxnyPys4wwmDuVA9W+bJtW8O6Zj/UK7fp+eaE+K+cPD8IETcVSBkaOt2wuezEvz5MBqOdxo2+AGGlevo4SROaT9/szfE/CpgR8XvcpaYVozR5E+e9brrHyFu6odPioAgJfRT9wNrhMvGnQrMW3ZTgCLNQCMNtuNJui5EqSJj4NVgaWrkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DS7PR12MB5765.namprd12.prod.outlook.com (2603:10b6:8:74::19) by
 DS0PR12MB8573.namprd12.prod.outlook.com (2603:10b6:8:162::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.27; Sun, 5 Nov 2023 20:57:32 +0000
Received: from DS7PR12MB5765.namprd12.prod.outlook.com
 ([fe80::2493:49ba:b06b:fa80]) by DS7PR12MB5765.namprd12.prod.outlook.com
 ([fe80::2493:49ba:b06b:fa80%6]) with mapi id 15.20.6954.021; Sun, 5 Nov 2023
 20:57:32 +0000
X-Gm-Message-State: AOJu0Yzm/H6bJtddbf5+Xt6EpUtgN59OjnvG1C42hN7wv2zSucxqsg23
        AoXskonysNPqD108lCZCbkP5MlkyO6m2qZ9D7M4=
X-Google-Smtp-Source: AGHT+IEzuxrMuN8YgXkTOVWv8T59R4NMUqD/WDSbk9yk+8F1zvYAsdxF10Q0NBk24bXWK+X8NxyQDvPs3MM6AJVAJ4k=
X-Received: by 2002:a1f:da81:0:b0:4ac:2561:db3a with SMTP id
 r123-20020a1fda81000000b004ac2561db3amr2472746vkg.3.1699217427243; Sun, 05
 Nov 2023 12:50:27 -0800 (PST)
References: <cover.1699025537.git.tanyuan@tinylab.org> <7807078d4612beaa3f450df9f3f3cf70b2bccb4a.1699025537.git.tanyuan@tinylab.org>
In-Reply-To: <7807078d4612beaa3f450df9f3f3cf70b2bccb4a.1699025537.git.tanyuan@tinylab.org>
From:   Fangrui Song <i@maskray.me>
Date:   Sun, 5 Nov 2023 12:50:16 -0800
X-Gmail-Original-Message-ID: <CAN30aBF8NjwcMqPxWtzk9oJufY4SiqKFqAJNpNifJxGywTeD5g@mail.gmail.com>
Message-ID: <DS7PR12MB576503711253C682DCE40524CBABA@DS7PR12MB5765.namprd12.prod.outlook.com>
Subject: Re: [PATCH v1 09/14] DCE/DSE: inhibit .size directive for SHF_GROUP
To:     Yuan Tan <tanyuan@tinylab.org>
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        luc.vanoostenryck@gmail.com, linux-sparse@vger.kernel.org,
        linux@weissschuh.net, palmer@rivosinc.com,
        paul.walmsley@sifive.com, paulburton@kernel.org,
        paulmck@kernel.org, tim.bird@sony.com, tsbogend@alpha.franken.de,
        w@1wt.eu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-TMN:  [pgQn8P8IlgTwmo/qoctZW1vKn6Wg9brJ]
X-ClientProxiedBy: MN2PR02CA0011.namprd02.prod.outlook.com
 (2603:10b6:208:fc::24) To DS7PR12MB5765.namprd12.prod.outlook.com
 (2603:10b6:8:74::19)
X-Microsoft-Original-Message-ID: <CAN30aBF8NjwcMqPxWtzk9oJufY4SiqKFqAJNpNifJxGywTeD5g@mail.gmail.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5765:EE_|DS0PR12MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: 194da695-a6ad-42ca-6a05-08dbde41d44f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: adRBZE4wG3cNAsVsSsYdB4v1kwjmL2ZL8/Xj8etPFG/0QrZJSnS/U4jIUk3G1Jcfn9cuvTgQ62cg0m03lzbv0YfI3UnSz1AsOXFkrb3waYQjbQ69LU1LC4fK+PftbbJpIpqeNbGD4wRU+5PiglFQ1oesbjCs+xGnsFXbOhxOAcCVEGAx3pXWJPuxbjhax/YazVqNIdlbxpaHEnIL7HDSpkVlsC/imB8TUXxIlgbAd19Xte2baoDFgNZyPdp+hzVgy8Vt5msDtq/snW4JqFwyqYsGq43C8aEl5DifbfP2KiYT9K/ruB0G2ZMp1ryqllSDLpQ9VfYZkdIwCuYKTABxzXxrTCzf62zUqwetGM/6eeEsTYN+g0CqRSDZQLc4kvi5zq0g+wjaSWxdcA8ztFK4/wxJ3kq8WbYjHrQYMcXomeOAQAbnumBiPm33u8hBy8T5d/3n3AYEhY5hhnKGAxQyH9ntmk4++ok2A/S7EeL2fQArBPZ11UiaxBoGVm+Cly9aPw6KO7iO04IUF+nvUfDlTav+sX3jQg+8ID9Qxl22OywfNn2JBVXfHjnqUwl43YMagFWMBIU812AfFDb5QUswoLhlURDgcDr/PCDoix/mbYY=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmNINDVSZlY1MUZranZyTUJyTkp2U0crVlZvMmFFUGxIME03ZEhWcFFTczdt?=
 =?utf-8?B?NW0yN0swejlkT0N2UlFTYk5pUHVuUUsvV0I1MmtNRm5VN1ZKcjc3QTlzMExD?=
 =?utf-8?B?OFNFMnp5S1JKblJRVCs3blN1TVNvOGlCYjFpN3M3ZXk2WjByM1BjcGZSNkx2?=
 =?utf-8?B?QWtkL1ZHaFVqNkVPMnJQbUxZNC9ORFNxbTFOSDQ5eUVtTjZjK09QYU5lYWh2?=
 =?utf-8?B?alhUaHRETmxSbnFjS3dwc25PZm82ZURCdzZhSU9xYUZTMTBTbDlVZE1GWVVU?=
 =?utf-8?B?OEFTbDFLUlpPeVVmaXJoYTlmY29Ib09TdzRrVnd1SzJWUXI0ZlVweEFMVE8z?=
 =?utf-8?B?cmJlS2tkdU85TE5QTkZrK2VvWkp4b0l6WHg1TDZSVUpnNkRuOXV0Nk9WYTJp?=
 =?utf-8?B?SVlBZFBRYStiTjNsUldMazkzRlA3ZWZIeGVqWHQvWGVtUXUyWmRMOE10WlhK?=
 =?utf-8?B?WUNGbUpKeFpMN2syWVNxSC8vY29jeUtCdFlRZ2ZNS2dOZEszWnQ3cFdLZTNJ?=
 =?utf-8?B?aEFPSm9SZUFNN1AzWUhUOG91WVp3aGlTa1hBRDhGMldSNkordktMditLR3Yr?=
 =?utf-8?B?am9wY1JHcUdjbllWSndOcnk2RTNJWVNsRkJhTjJZeFEvK2gvQUFGRlF1Mnkz?=
 =?utf-8?B?MkZuQ053UW5rMVRiRjI3U2N6cEZ1b3JaVjkzZEVCbXZxU21KNURRdFhJZ2pl?=
 =?utf-8?B?OVQxaDBmbzZ4eWFmLzY3TFhsTHAzM2JISWk3VnVXbGg2V2c1U2w1dlhQL0VW?=
 =?utf-8?B?NWNWRmgwaXVvNytSNEp5Tno4dExSeFErQy9ERDFTbDBROTRVMW5BQlFEOEVY?=
 =?utf-8?B?VjVFakM5Y2lxbTk1cVRGdE15YU9UTXJsTzJOMHFqWlE1dUZNV3I0bGVMUitj?=
 =?utf-8?B?QjdZOGJvNzlyU2VvU1pHeTROeXFVY1lqZ2oxUjNPSTluZ1NZQ0MwcU5uUzF1?=
 =?utf-8?B?Skp4UzdEUGtKZTJDSm5RU2htelhFYzdEWlloYUsyRFNtWDd6UkdxdHJTaGcz?=
 =?utf-8?B?eDRsZUxJL1JzVGNGNWl3aE5KT1pYQktocGVqYkhVYS9GcysxaHhHbWlVNEhs?=
 =?utf-8?B?b0ptaWJNM3ZQdWJNY3M0bTJpY0hQQUNXbllJNmdlc3B2eng2dHNVNElwOC9j?=
 =?utf-8?B?ektENVpkcFU3UzNjZ2RKNTI3SEw2VmtEcW9ZOUVnZXIzQUk4MGRaWkJGRjJt?=
 =?utf-8?B?dlhEVS90cG4xeUFodCtyTi9CTWloTGpadVdCQ0RLZXR3SWNQWi9uTzFjcmlD?=
 =?utf-8?B?bDYrY28wRitTTHREc0RYTkx4Zlpya0ZWbzQ3S1BPVzN5Uks1WWZ5eHNXdXgv?=
 =?utf-8?B?ckhhR1VQaFJQekw3NnRYckwxVXI1NUdBbUZ6K2hiNWJpSlFYcVJocUhxQURQ?=
 =?utf-8?B?TFp3Zk5rZ3BpeFNIWmlVKzd3RTJDL1VIenJMSFlrT1psdUdvdGFYWFlsOG9F?=
 =?utf-8?B?eFE4K1F6OFhZZ3Q1aXFQM3ljd2RJREQ0V0FzWUVVMUx2akZka1FId2VxeGhM?=
 =?utf-8?B?ZEdYZExNL3UvWnRBNXFBYXJ2TWRSQ2VadWVnVG5mcThGN3VrbmpqZlZvRVFp?=
 =?utf-8?Q?aA9HsUREy77K12zcsVozACRIVf/4C08Hav3wFj5MDbykej?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-5183d.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 194da695-a6ad-42ca-6a05-08dbde41d44f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5765.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2023 20:57:32.1833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8573
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 3, 2023 at 9:01 AM Yuan Tan <tanyuan@tinylab.org> wrote:
>
> .size directive fails in some functions with SHF_GROUP, this is not
> really required for normal building, inhibit it to silence the compiling
> failures with SHF_GROUP.
>
> Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
> Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
> ---
>  Makefile | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index a4e522b747cb..f67b6e8d2c45 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -936,6 +936,9 @@ endif
>  # `rustc`'s `-Zfunction-sections` applies to data too (as of 1.59.0).
>  ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION
>  KBUILD_CFLAGS_KERNEL += -ffunction-sections -fdata-sections
> +ifdef CONFIG_SECTION_SHF_GROUP_SUPPORT
> +KBUILD_CFLAGS_KERNEL += -finhibit-size-directive
> +endif
>  KBUILD_RUSTFLAGS_KERNEL += -Zfunction-sections=y
>  LDFLAGS_vmlinux += --gc-sections
>  ifdef CONFIG_LD_DEAD_CODE_DATA_ELIMINATION_DEBUG
> --
> 2.34.1
>

Clang doesn't support -finhibit-size-directive, so this would break
Clang builds.

GCC has had this option since 1992, but it is not used in the wild.
https://gcc.gnu.org/onlinedocs/gcc/Code-Gen-Options.html#index-finhibit-size-directive
says

> ... This option is used when compiling crtstuff.c; you should not need to use it for anything else.

What problem have you seen with .size directives (st_size field in
symbol table entries)?

% cat a.c
int v;
void f() {}
% diff -u0 <(gcc -S a.c -o -) <(gcc -S -finhibit-size-directive a.c -o -)
--- /proc/self/fd/11    2023-11-05 12:42:51.298618475 -0800
+++ /proc/self/fd/15    2023-11-05 12:42:51.298618475 -0800
@@ -7 +6,0 @@
-       .size   v, 4
@@ -27 +25,0 @@
-       .size   f, .-f
