Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183517C5AE7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbjJKSGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbjJKSGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:06:08 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457F2C0;
        Wed, 11 Oct 2023 11:06:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpkKbg8q/Z4WDnUhlnk4Q8V4aiohZg3oBBCjPMTCR6xKiJnym8eZDVm8UI4kk8RvYn98xd74zR67u3eLWNaug66lP1atoCkNpTsG2AY0TOQBRU2DD9QZbWODd5GLqAUCHAopLAWZZqdnYFUH8oSLr9oqwtVRGFmrDm0GQdbuQK9aqck69P7W1jZQK78ve9K9SP34SO1pvFCWHO7xCXdZIVBosz05hFvTtE1vruMLKdKUEnDdqC2+D0eWtOGhD++lfX7fxs58a5UCLL2x2REcGfzNgIpmRxnPCe8fS+jBOX3k1ykXmrmPJiwh8nE7uD4Lv9r8So3D8w99znT4HItDug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gGHUg/gYbTgClatE3hjQkepclIwaPjS6JHR09GSUPvY=;
 b=ZB6viyElzFhSa2D/dLSLWpbjPuHe6nEuNEyRG2GPKE5SvG6mUCAQpF0PUC1bJxoHLCJqFMe8aWsiE8wAfNlqZhzGHyLYSYJseyCPxj/1pDS5wsPbjqMa7rS6EHyhS7keuQtqUIZgX1zfrYIj4Qfwy+2ehQpowe5oaMz6N1J4n4iGveSNe3qE9vzaslHd2P7V3isbUWSxcYzsxRlYYcNKmOWVVGOw5xlPKwiujjNNp6s5gdVroH8u9GY3WBJuHTGWUEJ/2UP9N5Nvmkgazd7658GVCt7qmU4MeiFuRePUEfnBg/tg8GgslrUzEOBu/qoGvWpycUg7hQOOh+69GBLhmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gGHUg/gYbTgClatE3hjQkepclIwaPjS6JHR09GSUPvY=;
 b=CusIbQQVMtDFR5PPFuR8Y6tyo+Fe4gbhCw9EMyfQd8Sg2HuJfM/ytOdFRiP3mNq8DavReRjBxSL50TGc+Qrsus4xAH+jdJc5X/FEi6o0S2xwFQwmr9uR/CX9VsZiep2wpATDHAWvMQR1wsj1nO5MqwY5+Yqr3HplfUWWqUy0fPE6dVqZhrID6S8e96l5NXg6fkW9VMLpVNt1zQeL8GZotkqm3Ln8ezbguYqftXGZEVdNCBdbLW3V+xJs50ns8veIBJGWJRyyiSi8scq3T6gcRBP2mrww/6LsQjD8Rti1GE68Nt+u8PK8vluhJQt+5BKE/ZqsCZkCELqSUi2HBu6a+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 by SN7PR12MB8147.namprd12.prod.outlook.com (2603:10b6:806:32e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37; Wed, 11 Oct
 2023 18:06:04 +0000
Received: from IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea]) by IA1PR12MB6604.namprd12.prod.outlook.com
 ([fe80::8814:146:e28e:6eea%4]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 18:06:04 +0000
Message-ID: <4103e4b1-ad3a-b64f-e877-6c48d03deec4@nvidia.com>
Date:   Wed, 11 Oct 2023 11:06:00 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v1 4/4] hte: tegra194: Switch to LATE_SIMPLE_DEV_PM_OPS()
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        timestamp@lists.linux.dev, linux-tegra@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
References: <20231010151709.4104747-1-andriy.shevchenko@linux.intel.com>
 <20231010151709.4104747-5-andriy.shevchenko@linux.intel.com>
 <0db37cd0-9cb9-41bc-c2aa-0a01c0295ed0@nvidia.com>
 <CAHp75VcRKnWRNxTafsG2f+tWrF-6yQjECLpyn_S-VK78SfL8VQ@mail.gmail.com>
X-Nvconfidentiality: public
From:   Dipen Patel <dipenp@nvidia.com>
In-Reply-To: <CAHp75VcRKnWRNxTafsG2f+tWrF-6yQjECLpyn_S-VK78SfL8VQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0236.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::31) To IA1PR12MB6604.namprd12.prod.outlook.com
 (2603:10b6:208:3a0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6604:EE_|SN7PR12MB8147:EE_
X-MS-Office365-Filtering-Correlation-Id: 690a8645-ce24-41ed-aaf4-08dbca84bbd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mvbv+j3DpXwfXBpjKT5gZZlcGYuHKR1cbnsSdDliCCe0e8eS/zNOBKT6n3flK0ELJCbD0wPCBWphjCgms64ZVwE2lkKR85m06YSDNQrHp7hV1lDXzT5R6bGTwE8ZXzxnJO1tLTJg96eJto1Vbuq0iSLjxk3pgZhFCMW00l+cK/DzaxQgTPc+P0v5vr5H0pNiO/D11sSEuFnWcrUyLTk6ba7kXpfZqEA8Ma7C/uhhT1cPFmUjvAfABGyMbVRrjrBsWvj3RhuTVRzzkUten85sOdsTiH6hFHXM2RpdJWY+GO07Hr+xhnUL2lltW0EzXN8Wmf/6sfWczjGdfq3fHboVZZucauGlPbnOu1gySgcIHeItBknPurks8Izajy9RHPLFwcXRxJ2CUirAdVcg5PQxPbQFt55Jl5WN/CuWLItuqs7u7e4KbqVFER+x9gFy/c+g/1Lrc71qTniGEjT7M7h5WcaUvysWozBH7YxDtgMz6eCaQhC33Wj8ARxyhNFJz2ZBYzvgvf3ME3M9BjcQXEL/jV70kId+d7aaTQG7cecSaZK2DUEM/2SveQ4/IRCb2D+hVp5wCxjWVSr3bZMx/R6nT+noWJZwoCJp3YdoEvmFtJ36lX9O9lU48ylkn4WD55OCcclUkcBPEIOmggJ9SKfBOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB6604.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(396003)(366004)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(2906002)(54906003)(107886003)(2616005)(26005)(66556008)(7416002)(66476007)(316002)(6916009)(66946007)(4326008)(41300700001)(5660300002)(6666004)(4744005)(478600001)(6512007)(8936002)(8676002)(6486002)(6506007)(38100700002)(36756003)(86362001)(31696002)(53546011)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3ZQeXROeEFZd0c0U3RCNUpvREZMQUZtVkFtR0dPS0tnZ0w0U3BoY2Z1RHFT?=
 =?utf-8?B?NWhuWWk0SlZJMnBwcWFQZGxnZWpQeDZSdGpHenozZ2x0dm01K0JyWjQyOW9V?=
 =?utf-8?B?WEQwa3lMaHl0QlJTRzQwV2h0RE03TGNCN1dpbDQ1RFc3bDFPZ2didU0yNHIx?=
 =?utf-8?B?Z0twdDdBV1RyQlJDdmp1QkZHNHdZbGRINkMvM0t1czVmYzlWdGs3c3VUR2ND?=
 =?utf-8?B?Ymlka3JjRVpNdGxBVWxJaDgzSVBuVWNpc3RsTndYYjZHVS9ZUk1GbjJ1NTNC?=
 =?utf-8?B?TnZaREpuaEVBeTZ1OWpsQzdaa1FkMzlaaERGcVEyWTFMM05INnBhZnllam96?=
 =?utf-8?B?WVBFNGRVUjVaNkNoZHRBL2VsSlB2OUxpZ0JldFNoTDJxWk4velRsU2tzenVQ?=
 =?utf-8?B?UmgzT3BQR3VzNm16N1dBemwxVHk2cTRmbldoTERJaitkeDZnVHAvMWVHL0M1?=
 =?utf-8?B?cHBNYkkza1JXN1RxQmRxWjZOWWdkNTFkZ3YxRmdVUkNtSGZaVk9RSlpkeTg2?=
 =?utf-8?B?b2F3d0F0eTRTVjQ5U3dlWGFMNFhUc1Bsd1luSWNFREJPVWFTRGppQWVCOXQ4?=
 =?utf-8?B?TUZZb3liZjR5TnFWdER1aWhiaUxTa082dks5MVRpckk4ZXNncDREdGNTSGJF?=
 =?utf-8?B?VXJsTUZtWWszYm1oL3B6NVZ1MUszMzMxY3U2VVg5ZXhtbEQxUjRFZ0sxZUlM?=
 =?utf-8?B?VlV4VHNMbisraFkwS1JadzhMUDNLajBHNFRqTVlNWWREcXRIejZsOTdDV1dL?=
 =?utf-8?B?bXE2V2lHUXlKdnBVZDRBTit1dE1ySWtXWGc5MkY5eG9MYkdveG1KcGx6elNF?=
 =?utf-8?B?YnE1YW13aFd2eW5pTWh5Q25qT3ZTS2tjUGRsaUZDdENCTTJ2Ri9sc3MzUUs2?=
 =?utf-8?B?ZllYWGFZWmJhakRJYTg3bm1VZHRpampqRzVORXdab0NXTnQrcG9pZHZJczlE?=
 =?utf-8?B?V1RtblpDT09kbkdNV09ETzI4enhTQWh6QTFaY0ZjQTNmaTVqeEZmanQxb2pj?=
 =?utf-8?B?QnZrLzA0VGZwNG1FTEZWVUg2cnpVSmRJVEJiTU8wS3hwYnVyaTd5TWM0NjFz?=
 =?utf-8?B?ajk4R3hyWjBEUElYS2d1YTdrN1Bub1V0eVlNL0wwTGpFa25NVUpQMmNXc2hj?=
 =?utf-8?B?dVk4cU1UTWwzMWhxT0l3Z1ZhYUoyekxvNW1mb1NNdzI3TFpPTXpuTUJ4b1Jv?=
 =?utf-8?B?TjY2VGlvZDJWYThSajBqbEQxNmplazUwOWM0cGtPU2ZOdEFVNDUxTjN6djhI?=
 =?utf-8?B?bkwyTGxyUEkzWHhHL0VaWSt2VFZ2SDhTWUNSYW96dkQ4cE9XL1psY0tFczFz?=
 =?utf-8?B?RXV0RHlnM0ZUR2FGclZnd2RYeTMrM1BkdXp2WnVpck5LeC8yWmx6VkVtRDZl?=
 =?utf-8?B?dU14Mm5EK1BOdHlMSXlCbU92eXBIK3R4NzcydndHMzBMeFFHVzU4ZUpFTWNr?=
 =?utf-8?B?T3krTnhIaTZrb2c2VndzRFNkVWk0c3RGZVFaQ3JFMGZPZTFBR2RmbG9ZS1FS?=
 =?utf-8?B?MWNsVDNFUkZtSVRNejc0SmtzbjBxNUN5cjNybEdXbWF4clAramJZMkJieUl4?=
 =?utf-8?B?N2t5U2hXM01HK3NmazhQM2syQkVKQ1F0c0E1OHo3SnByUTRRN2REVkljVko1?=
 =?utf-8?B?V1ZtNlN5WVJzd2VoUUFmOFZnVk5KUUllUEFNSDQ5cjZYRVJsd3FnNXNkd0dI?=
 =?utf-8?B?NzhzajRQd2J2L081QWprUEZERW4yS0NkZUdDYWFqVENLenZGNVpvcHVEQTc4?=
 =?utf-8?B?eXltcTExTlpPaUcyTHhhWS8vSitrM0pLQ2JSdlpOZHZLLzlwbU15cXNGUjZY?=
 =?utf-8?B?WXAwM1VNelZuQkRZV0JRM2ZOeldMbFV0V2NQWWJ1UjltUTRsYUtzMklTVS84?=
 =?utf-8?B?QXNjdHZwaVZFZGJPTGJVWFVwUzZlaEFxMElHU3ZqQ3JvNG14bWRDMGh1V0p1?=
 =?utf-8?B?bUZjWVlJWHFGQkdQdjdTZTVGczB6OWxuV0kzdmFFRVorKzNPOGtEQ3RLWXVW?=
 =?utf-8?B?TCtOeFFLdUljbExETUFVM0tpYnp6eG10TlZ4WjV4VnJrMWNqcm1tU1VVdEdP?=
 =?utf-8?B?enBUVCsrNnhGdERPdUh6ZTJvSERLYVJIN2ZhMVBEQjFlUkNsUVh1dXdyZVJ1?=
 =?utf-8?Q?QF59YZqzgiOVWz68lkkNy7v3l?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 690a8645-ce24-41ed-aaf4-08dbca84bbd4
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6604.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 18:06:04.0462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1GqnByuygoeVEl/OzJcOXd74SnUz5Ptagm7UKWkgtg/82UcNu+wNXd6/kQ4ms1bNa056ypWCTgAeo/ulVe9+9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8147
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/23 10:55 PM, Andy Shevchenko wrote:
> On Tue, Oct 10, 2023 at 10:36 PM Dipen Patel <dipenp@nvidia.com> wrote:
>> On 10/10/23 8:17 AM, Andy Shevchenko wrote:
> 
>>> +             .pm = pm_slee_ptr(&tegra_hte_pm),
>>
>> typo, pm_sleep_ptr instead?
> 
> Indeed. On my x86_64 this code slipped from compilation. I will try
> harder to compile-test it next time.
> 
After manually correcting the error,

Tested-by: Dipen Patel <dipenp@nvidia.com>

