Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A577FC125
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345747AbjK1O2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 09:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345705AbjK1O2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 09:28:00 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BA618D;
        Tue, 28 Nov 2023 06:28:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBjPog1WxXvVIdMbw3xLeZqpK73PyMx0TVIzZOqd0FZU0U/Et7eigyGkDRt8pbNvjK3cIMlCrwairyALzY1cYaVCGkX5g4UxHQwrhyt18HjgrLuzkklkr6uTPv2HqOUkf/Qnklrv+SL517yFhASXr2H66xRfSvsgTtq8kdvwxlho44//ZX+Ak7OtlUqJC5PikAm1OMUmn+yzsFj/eLlEoySB/cGVBjk6LPLyLr/HZJxRI/gQHVIWBtmkxJjnIefv468XeJuuvuGcfiw3l4SE9JUjqLKEewBxkcZcHjUX3vns9sXpTOYL7iWM3kAwpyiEJdH+USXpD6g4ZIlk5vvJmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vh8eYWIPIq8wum4v2Zab94ICXCD4mytu1VMi1hAb884=;
 b=Mets4YQeBnwgumvntSR4cLHDaOEDJjfLrJejcgMFt6grrWK3fosArmBhGfr4ina6Ho8sT8E8u3WeLsqsA3ZNbhvT3dDuad3uzSfQGQzhuxFZvLH4Y393h+6irI5vJam8j9tYap3CTArjXvmjTHhfVzuoWXRjv+bayGE9NaogdSadGoDXawp2XEQA58v2OGz4YFKyAdYyNMGRUN9Fl3SRlpqRTc5RdrCWP86iyiKHJszox1i+wLwmfZ1s14OFYQ1wDro6ARfgKyZbzno/QF4WknF+BJ97ZLn5JC75FRNEfMWjf/GfXIAJ1A5mUc1rTqLtXR5+oyfzy7uGaJA9MMvJUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vh8eYWIPIq8wum4v2Zab94ICXCD4mytu1VMi1hAb884=;
 b=rNNcICn9J53hgRjUBtQ2mw06oXKAh1N86hTMulAVcpVbakghrGJq4RrmrLGWXurlX5Epy5AMNJi3tZ7Jhwu319F/4lD7pUv/3KH0VOinM9xxni9ubl4VW9ziH/8MYaG2spwXju7GU3IR6MgjzXhL4aOrb+Xg9Z6eNLc4dLapwCs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by PH0PR12MB8173.namprd12.prod.outlook.com (2603:10b6:510:296::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 14:28:00 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::83d7:9c4f:4d9b:1f2a%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 14:28:00 +0000
Message-ID: <d574a393-1512-41ec-9fb0-ca747d6bd7c8@amd.com>
Date:   Tue, 28 Nov 2023 08:27:57 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT][PATCH v1] ACPI: OSL: Use a threaded interrupt handler for
 SCI
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Michal Wilczynski <michal.wilczynski@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
References: <5745568.DvuYhMxLoT@kreacher>
From:   Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <5745568.DvuYhMxLoT@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7P222CA0017.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:124::15) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|PH0PR12MB8173:EE_
X-MS-Office365-Filtering-Correlation-Id: 501ea755-0a24-4fb1-4f78-08dbf01e3965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VfoxdMHjNFzKOkHs8JErO0PDPBklzeSorVriz6b4oOpIMC5nS8QyW11D3EyaLnl7ZBZMiqMKyjmY+Ku/LQEVl/HlsT5NrjmR00mITK3NRnaHhFVgwMCUS1Etd9ukNcvHcYVpZ6qWk//c6MemDanwRQRo+G021JXJz+EgmJSummCYudEaIg9z39qQuI8ZGOxZsoYA4ZJ17zOHZdCOW5GLP4lvGBtIR3GCW+dQagzhfHcyJM8zbtR0QmEL4ag59hdHvKo6R4hmWxiJVRhqHj47avRD9QZIbOxioKR+fM94Kx1T0CM58WHeuL6rLkKorzHRmTljEh+czfoaRaIaKXVtlai5o7EkfHDZguwybz0BZU8nvlW1JNu+Mq/9QbPWWC42ID4PpeEFyicT74siEq5+SlwIDCRPXMntoy40QEQta5ed4Rd2KmsoYM3FqYA7V8zcux7MluP814tgqoT2VRkie/jD+SolLnJvl0/YvW2ThLsZkufTofTUmpxGIxxMUIvvz+SjBD5C7aHdZdE/PXFJC19fp2EqJG8n7HoXsTv+Iu9djo7tedWh18PJKRT0pKlcoQTNd4j38j5lrXkym2e5dbR/QdK0TvuyfZFCyME4jHNw/M3AHyF2cR6aDN1AN7/p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(39860400002)(136003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(2906002)(31686004)(44832011)(4326008)(7416002)(110136005)(53546011)(41300700001)(66556008)(66476007)(8936002)(54906003)(66946007)(316002)(6506007)(478600001)(6666004)(5660300002)(8676002)(6512007)(6486002)(2616005)(84970400001)(26005)(83380400001)(38100700002)(31696002)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXZKZ3JCRUpVblRtZHVqWUt3dWhBaUtiOFliYXEzVVhhQWdEOEMxb05RQzNJ?=
 =?utf-8?B?MVVJUzlGV3Q0S2VWUERjUEE5SzkwRDZUZzhMVWF1Mm80azE0Sk1WNGgvZEQ3?=
 =?utf-8?B?WlBOUjBRTkNnakJmNmpIVTFkWHRTRnlmUGpWRmJHV3NOeCt5ME9VTGVwUTRm?=
 =?utf-8?B?aTZkajhiR2JSTHdZcGJoWWxJUGhqN2JSdzN6cWdMVTdsRVVXbjF4ZEw0N2pk?=
 =?utf-8?B?aVAvT2YvcGFlMHVoZGMzZU5XTkxVTE9jR0RmUHZJRVhqTzlYMmd3cmM2Zkxv?=
 =?utf-8?B?Z2JLTUZvcUZSb21kSjR0dHNoVm1QaThRSE1oUTE5NURaZEJuVDRYcmoxMWJQ?=
 =?utf-8?B?a0hWREpPeEh5WXNpcjl5YXZqcnZZQkErYktQRXRPVzlreUs1RUxnWGo1Y3Vx?=
 =?utf-8?B?M214SkNwdHhLais3WlhhZXJnSkdyZmROZDdZbk5RaExlRlEvNTFGSEFYWjJ3?=
 =?utf-8?B?a0hJWDZta2F4VnNNeTdZaEpibkRUMnlKSXliY3FjNGV5c0F6SDJMN3FwVHE0?=
 =?utf-8?B?eG9UUmFpd1BvQXArUFc2RW91WGJWbFlvTldVUjF3U2VPRERndS9scWZpdGdE?=
 =?utf-8?B?MWRQbW00VFc4OER2TzR4WUd0R2FLeCtMNUVCa1NtMHA2RS9UNUN0V1dMYmZy?=
 =?utf-8?B?NWFUV2JDSWU5MHgveFg1Ym1mZDFneG5QUm9zOW9ycUhjRTNsYmpFTGVDNTFE?=
 =?utf-8?B?RERuaEpwUklKaENjZms0STBIRTRrbjVLMUtnOXdBaWtxY3ZXWU9oTGVWTTAx?=
 =?utf-8?B?Zkt6SENTNUxSNHNOalRqUDAxWlFSY2FxZkNLTnVCUG94Y0pBV2pBWWprVlVp?=
 =?utf-8?B?OTF3djUwcEdFYW5YckhxcTExOUVZTGtUdGRDTjVaTk5IbS9IWGpsYXhOb21h?=
 =?utf-8?B?cDBSTUdaTFNEZE9ZRjNLcURsVXVyelFiTHdYWWJnQ3R5WEZ4em9idTlqZENz?=
 =?utf-8?B?SUZHc3pFMEdhdUU4c1BkSHRyZSttWGxqNGxrTmw0cURDV3daamNmbSsrRENN?=
 =?utf-8?B?R3F0TjV6SGhiUkxIT1ZkQjlmZzJkeXQ5bUU4SFVFTHNnTkxWcEl3dXdxT3J6?=
 =?utf-8?B?aE96L0Z6ekhreTRVcGFxRzg3U0diQUZGWDRYVGxWS1ZZc1dIVTFzU2pmdlJn?=
 =?utf-8?B?eVNhR28yd2RONUxETEhDYUd6Zm9XMGpuT0VvMHYvL2xYN1BObVdOMzhqSEJP?=
 =?utf-8?B?cUJVSTdLQlJON2JXaWhkNy9GL3VyNnAybUIxUDF0eEdvSlU0R3MrRHk3SFdH?=
 =?utf-8?B?Vk9WY0dUTFBSUDFHREJBZFNKbnF6RGx3UjJRZVlZdG4zenBkZ0llMFI2YUdQ?=
 =?utf-8?B?eVZCVDNyd1BEWi9LbnlHNmFWclBPVFIwcWNSTWtLbVFwTU0xdFJsK3FmL05h?=
 =?utf-8?B?NDQ1cGpHNnVPZVI4N2R3djRUQmQxMVcxNEk4eUQvWStlWVBBRStZeFkvS1Uv?=
 =?utf-8?B?OEEybzVxR01IQmU0MXlVdzZMQ0xUOUFvMUxWS1RNUFdUWUlzZXFJVFFOcElx?=
 =?utf-8?B?bk9vVFkvR0haOFlBa2V4RW9lTzdybkovc1RlNTZ3OGpVMDBpYU9yd0xSeGlT?=
 =?utf-8?B?cFlxNUdDbWdqaTJlUU5mM3dUaEI4VHdaYUJFS3Y0WmZPL213ZnN5SncwTTBK?=
 =?utf-8?B?enM2UVh6cXBqVmVnUWJ2RDB3RDlpQ0YzV3J3dDdVMWN1WjMzUmJwdWF3UkFW?=
 =?utf-8?B?Yk1TTS9CTmdVckhOV3RaenZsL1JyRDFualp0WGUrT3V1NHJzcDNDOW8wRzh1?=
 =?utf-8?B?dy9WMGlYbG9hSTRxQXhRa2pRUFh2Z3NtQnpmY0MxK0FsNUN5SnNlcnJsaW9s?=
 =?utf-8?B?c3IzZVVON0dUUThhZS9WdHg3bkJTT0N0WUhjMUpBSzhBQm0vQUUyTm0rbnYy?=
 =?utf-8?B?Z0FQZStmV3U3TkhWVU5pMXdxankwdlVETENSclVDTlFhUG5iVWlVTzdPK1lJ?=
 =?utf-8?B?K2NxNVBGb2J1d2tZVFpaYmJHU3ZSWmY2QnNMOXE1bmZvSUZuclUwL3FMZWFL?=
 =?utf-8?B?Q0NIVkp5TGM5R3RjaTQ4WGcxdGJ2bHc4eFhrWHlFN1dNd29pMGJOdEJYa3dZ?=
 =?utf-8?B?Qlc4TDd1UzcwMzJUVklPcUV4ZndHc2RLMWNwRDcwd0NKQWhuTEdvSksyblRr?=
 =?utf-8?Q?rJcBYLAmC34ZYaHEkyrQwsP3C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 501ea755-0a24-4fb1-4f78-08dbf01e3965
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:28:00.7191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f0zFzsumLvDMGJOdoNaostOUb85tk8857dw9saHGtfZGX2fT5EzZagOSgMHtvrqpLjn/PRDG9O0Sq/jkqh8KGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8173
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/27/2023 13:57, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> In the current arrangement, all of the acpi_ev_sci_xrupt_handler() code
> is run as an interrupt handler for the SCI, in interrupt context.  Among
> other things, this causes it to run with local interrupts off which
> can be problematic if many GPEs are enabled and they are located in the
> I/O address space, for example (because in that case local interrupts
> will be off for the duration of all of the GPE hardware accesses carried
> out while handling an SCI combined and that may be quite a bit of time
> in extreme scenarios).
> 
> However, there is no particular reason why the code in question really
> needs to run in interrupt context and in particular, it has no specific
> reason to run with local interrupts off.  The only real requirement is
> to prevent multiple instences of it from running in parallel with each
> other, but that can be achieved regardless.
> 
> For this reason, use request_threaded_irq() instead of request_irq() for
> the ACPI SCI and pass IRQF_ONESHOT to it in flags to indicate that the
> interrupt needs to be masked while its handling thread is running so as
> to prevent it from re-triggering while it is being handled (and in
> particular until the final handled/not handled outcome is determined).
> 
> While at it, drop a redundant local variable from acpi_irq().
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> The code inspection and (necessarily limited) testing carried out by me
> are good indications that this should just always work, but there may
> be still some really odd platform configurations I'm overlooking, so if
> you have a way to give it a go, please do so.

Thanks for looping me in.

I tested it on a few different laptops I have on hand from different SoC 
generations and manufacturers and ensured that SCI was working correctly 
for usage and wakeup.  My base kernel was 6.7-rc3 plus some unrelated 
RTC timeout handling patches.

Tested-by: Mario Limonciello <mario.limonciello@amd.com>

> 
> ---
>   drivers/acpi/osl.c |    9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> Index: linux-pm/drivers/acpi/osl.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/osl.c
> +++ linux-pm/drivers/acpi/osl.c
> @@ -544,11 +544,7 @@ acpi_os_predefined_override(const struct
>   
>   static irqreturn_t acpi_irq(int irq, void *dev_id)
>   {
> -	u32 handled;
> -
> -	handled = (*acpi_irq_handler) (acpi_irq_context);
> -
> -	if (handled) {
> +	if ((*acpi_irq_handler)(acpi_irq_context)) {
>   		acpi_irq_handled++;
>   		return IRQ_HANDLED;
>   	} else {
> @@ -582,7 +578,8 @@ acpi_os_install_interrupt_handler(u32 gs
>   
>   	acpi_irq_handler = handler;
>   	acpi_irq_context = context;
> -	if (request_irq(irq, acpi_irq, IRQF_SHARED, "acpi", acpi_irq)) {
> +	if (request_threaded_irq(irq, NULL, acpi_irq, IRQF_SHARED | IRQF_ONESHOT,
> +			         "acpi", acpi_irq)) {
>   		pr_err("SCI (IRQ%d) allocation failed\n", irq);
>   		acpi_irq_handler = NULL;
>   		return AE_NOT_ACQUIRED;
> 
> 
> 

