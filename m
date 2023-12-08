Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0196280ABA4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574569AbjLHSI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235911AbjLHSIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:08:55 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFCA90;
        Fri,  8 Dec 2023 10:09:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AudvC7U38VlEmW1quZRQmSGrgy09TP8zkb0Q37Z4uUNVLr0SCOt0QXMD4P/ahkiyRKXtMepiIficIRQteN0+FOqQMgqYmlMfPpKnPct3DKrrcs93RQ69/fzJCGtK2V2JdGIWbOG75Q9K/oYyT6AsLQHhb4yUtz7XuASNtEFSoz8d5O6CUXoqcJEYmRUk3Nl6kTxjE7o+HSKykstZ1p2TlBLq4j/RU9FxTJC65x23JdX+wwK3PRxebAdDqveObvwhGedhXwLFtQ3SEBywes/VYHIw9bPF/hKM0VcewxuHfTIdJN1+fnsfoNzXAN/8pIshSvY34sCGP5afsMBPqWB22Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qTydOyMDKh6krfNiRl2GTILpW5+d2hqi9wVdx3iVLw0=;
 b=e99FM0ZcbbiqD7lSCU91X+87JOry8PJK063p773G2uV1tmv4rYEtDgEoxePIaxVHrpIurJMu1bOqJ3GhUimtE22DCNksi8bm8tu1hC7jzpE1zILqL46PoKbtYbgojioBDZX4LwOZITZDlWsPq3KWWgymdw7M9s6Vs7t6La+nN6MFUXd5HaHTLTqIPXlALGY+W2PNdUmdWvOHVb005PmLbdgfRqM/ttiDnZF6ZcYAe9+a0vTk1B1ymaK5cf4ZZBQS1oaj/umkfe++rpoXAI/JD7FMayBPh8Ey1J33xKVVeMH69TiUc33eHq7pVzjUH1pnSMRcCXHr9jG3M/5YcSGrFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qTydOyMDKh6krfNiRl2GTILpW5+d2hqi9wVdx3iVLw0=;
 b=QCllIfsNCpz3raShMe1Um9Vr6uB0sENm8VIjoGbgqVUq+GCsMcJKP9GM0xAe+rUFa/ki+BkL1ImizGvYTR3nuk5GwM4LqXBxolQXVdV2ABcymmxQRsZMSQ1Jrp0+2RwMVt//WOV1eJ2eSuLjydICVfUYmHGsJpCzDxmjRCnQrTpgF6orDUBB2TAd8BS7Jm2Ohz5CzZ+t+behgDHmhgzZ3ye9Ts37ol+SIhGGJEaLnlIQh9zQ+SAjq2nFUkAopuRyjbmjM5Kn3otRKEKty4d066laMe+Redlhro12qLQ1xB61VgkYERkyunxT8pm52OvsrtH6zTYoOQffnBi0G72Zzw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by CH0PR12MB5043.namprd12.prod.outlook.com (2603:10b6:610:e2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 18:08:56 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ab86:edf7:348:d117]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::ab86:edf7:348:d117%3]) with mapi id 15.20.7068.027; Fri, 8 Dec 2023
 18:08:56 +0000
From:   Rahul Rameshbabu <rrameshbabu@nvidia.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Input: i8042: Add a quirk for Framework 16" laptop
References: <20231206212140.7458-1-mario.limonciello@amd.com>
        <20231206212140.7458-2-mario.limonciello@amd.com>
        <ZXNY8a_Zja9rSupQ@google.com>
Date:   Fri, 08 Dec 2023 10:08:49 -0800
In-Reply-To: <ZXNY8a_Zja9rSupQ@google.com> (Dmitry Torokhov's message of "Fri,
        8 Dec 2023 17:57:05 +0000")
Message-ID: <87y1e4o9ce.fsf@nvidia.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::39) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|CH0PR12MB5043:EE_
X-MS-Office365-Filtering-Correlation-Id: 038d5449-162d-49ce-83b2-08dbf818bea5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GV2XDs5ZQEBcVgbfLdzCHDc6wNC13IxJ3bZIc/RRisfsEtHqfWewpGv0V1YAqqkITaBkBPVpZX1Gzz86mpOGOeSaVtvNZQ/WD6CpsLGNF2Rcyt1deEYjpMeG3VO+dbQ33BsiwYYuZpwBszQn4+q199BiYMh5KZ2CpbCsEtefDroA/+1iqmPI1GJyOtBbDsjWkNz63prd2kPrW3lYuPIQF6ubyt14tW30K86cL6p5yUKJ9K2o3+PsrVRVyv2UdVl/BWF9NAzpY3T5WoE2GiQH3rbSeNr7K2AG7Wx7YuyC49IXYZe8hFafmjZki15iFNRBfvZUwK2mtVpmltOtzPCt7OJjsrSVpQw42oGSKnGMU/WAfDFwLjdjCQagI3WENVNr7jOfuU+bVUuOjKR017E0hRNfuGkb8K1Gbq6hgUfzYnXVd2mmaNliKoEIZVqsE5RaYObg3W5ScIz9Sf1sV4FyuxfDa9VuX6MIdLfunGkfUaxpRMiD6Q9R7BfxmVLvVUteseb0Kzap3dyTuNFZK9caiM3Bg4SE55n8RtwoHhyhhW4hIL+bi4HpOOOHvdsEift27zeD1rUrcjiQKzrQcXO0VhoOk9BJX7i7yQrqpsjPWHQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(396003)(39860400002)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(36756003)(6666004)(478600001)(6512007)(26005)(2616005)(316002)(66946007)(83380400001)(66556008)(66476007)(6506007)(6916009)(8676002)(8936002)(4326008)(5660300002)(2906002)(41300700001)(38100700002)(966005)(6486002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LPkszPTW6AZrl812jxunjvl0h/dka+FldCwkeNiVpnxgrqIRdsKp2xDKGXEp?=
 =?us-ascii?Q?iOQgRj+fyOAoGKZME58pGoym2F2QC8f6A5iUc2zAblmtqJTaoPGw8NX0pYiT?=
 =?us-ascii?Q?nYxkiqDfFCPe0tjTfW+ibW45oyyk3G+UaYwNQvnnrdec1ylxYgsj+uiE9b35?=
 =?us-ascii?Q?iJSV0HFAqZbSnvydRTA+U9IpG0BlvdlO2dTfO/ApgKovbQVpobZLpryevw9V?=
 =?us-ascii?Q?K82vYFLMQ2nm8rOs0nYXKaMfkJbyJ882Y4+LKD3Z3uJZGB3pfOT4IdRfNeT3?=
 =?us-ascii?Q?ihS45Z6CaHM8GjaNIJ/rScMt7z6wmaJMSIg05N3s5wXdpGZcddR4TWTUdidV?=
 =?us-ascii?Q?IesUwmYYKESDyTenCbv6aVOnvL7B26H/trC4JUvjzd9epBGxpYzndF5Borr/?=
 =?us-ascii?Q?XqxOZLpZlU21Ee2dkLrWSwIMAFiuQ7LvgQ06j3Z7I55HOoHct0O1IEKuVO7f?=
 =?us-ascii?Q?g8/lpzNw2XH1kBiw4g61IEbfc3hBkt4NPtQ42TesA2Rr/UFM/tOUwy6OtdlT?=
 =?us-ascii?Q?6UGC35tDoxsctug/4T402O6Yf2xllnkMRKpPqBy81jN0ADUKkY6FDIVUoRXu?=
 =?us-ascii?Q?pWWafUf6djRQmRp/Ruk6sPNgaWTl78bGLtrfr9B6KpBmkqSvofOJICYppoXl?=
 =?us-ascii?Q?2mvuH9c2J9rSxwC2B/2WIuZC0dKnK/46f1Nq4FUVKt9wnM0Lb3uWTTZSEdl8?=
 =?us-ascii?Q?Iu5JxEgKiviHXawtLwB9evzW2IuBDo5W3ZPF2CcDm2xZt/Aqk+NjnJkWpXbH?=
 =?us-ascii?Q?pLfhLsafenLeOt7HGyMTgAVLA8ltfZGf9pY/gMuv3NQA+Z7pYyg3hrvLZQey?=
 =?us-ascii?Q?HU69tO3mGNTX2CNR3Ih19xTKhwI0lecczOANwfE2xq/ugL+uI/nbPk9Tzi/V?=
 =?us-ascii?Q?axIKJRp+OsAr9BwQrXcUI2CpsBXCZr4/6wfc5Sz2wQ1W+Vg595LfGxlHbneP?=
 =?us-ascii?Q?c6lzPbYqffamGU7RlcSccVwQulKPW0hx89vCSuB2DTOeAfBFSZcazCDCg6M8?=
 =?us-ascii?Q?c+mnUu1cVYGM7LBYz757SlMGQEf546dhn6GZZElew9JdEDoOGvvaQNJ+OCjt?=
 =?us-ascii?Q?qasuPFH14hIIoulCZ7qkeCiGdvCxs9rL38DOmca5Qgmtyk3+3iDHSees2gg8?=
 =?us-ascii?Q?v0VbNJ44BAonTyjBy1FpZ2m2UHuqv6SmRb0BNNrki571CUPNX/yitcyyk882?=
 =?us-ascii?Q?munP9gFaDeYK0wlgLo2ThqFstIOoJYYu3uEAM9AmLo0VjFKOPTyz6MiAzuEu?=
 =?us-ascii?Q?Gh5YIhuwXOw+L8cO/Ct9UtpgxmALF8V1ryFMYushRmwFk+EJdqeldwBLwmFT?=
 =?us-ascii?Q?lP8iZk2IYLU8WPkRx+4ixO31lSKGx/aNXp1BYCKLhUaq1TYC46/mzj/B6kds?=
 =?us-ascii?Q?VfJ5kn4HkeRzGYei1MEJkeTlkdBlPJ13X8GOrtYO4jLLlaGg8KHhpatvOi1s?=
 =?us-ascii?Q?xmS/Y0POBoqc9EuC6gut9zitwKK5HWxAz/Be8HuP0q6SnAl6iURRGR85Gy53?=
 =?us-ascii?Q?5hyR9orZXtwRP5Gh/s/gDnYFi/x8D/mm6AQxxuy3/0BDdFlo8TCgf9JA6KjN?=
 =?us-ascii?Q?KFGJbcKCx5F3pPGthABFYgM/g2VdoucQZurGeA2B?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 038d5449-162d-49ce-83b2-08dbf818bea5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 18:08:56.6788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3RAX3aHTT28vb8bU3crHFuT8s1RvuF0BOr9aPW7bhp+5IyAEa2SVL1mEAeECnnfIUyhGqqaQRTowJeWFYNw47w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5043
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Dec, 2023 17:57:05 +0000 Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On Wed, Dec 06, 2023 at 03:21:40PM -0600, Mario Limonciello wrote:
>> The Framework 16" laptop doesn't have a PS/2 keyboard. At bootup the
>> following messages are emitted:
>> 
>> i8042: PNP: No PS/2 controller found.
>> i8042: PNP: Probing ports directly.
>> i8042: Can't read CTR while initializing i8042
>> i8042: probe of i8042 failed with error -5
>> 
>> There are no PNP devices as those listed in `pnp_kbd_devids` but
>> i8042_pnp_init() ignores this and still runs and will continue to
>> try to probe.
>> 
>> As there is no PS/2 keyboard or mouse in this laptop, set a quirk
>> to avoid this behavior.
>
> I believe the proper fix for this is for the firmware not report i8042
> as present by properly setting up FADT. Please take a look at
> arch/x86/kernel/acpi/boot.c::acpi_parse_fadt() and how it sets flag
> X86_LEGACY_I8042_FIRMWARE_ABSENT.

This is along the lines of a point I brought up in the v1 of this patch.

  https://lore.kernel.org/linux-input/87v89bgl7a.fsf@nvidia.com/

This means that Framework as a manufacturer will need to provide the
appropriate fix for what's advertised over ACPI by the device. I think
that makes sense instead of creating quirk combinations to avoid
resolving the issue at the ACPI level. I guess the only de-merit is that
means folks need to depend on vendors with no way to suppress this if a
vendor does not correct set up FADT.

>
> It will still say "PNP: No PS/2 controller found" which is an
> "informational" message, but should not try to probe ports directly and
> report errors.

--
Thanks,

Rahul Rameshbabu
