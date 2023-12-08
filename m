Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E3880A787
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574352AbjLHPey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574342AbjLHPeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:34:50 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC25BFB;
        Fri,  8 Dec 2023 07:34:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iduiq2y2jEaWqmnp8hDLc+GXInlCv5qHF9OqAFJgXGjRAMhZVU67aUnJN558L8ybW8mcw7Z/8gWZdA8wXyYAq+GC/WI3UPxIHxHMRaAi5kgDsm3f+YL6WUeiGwVGrUPj0cfZV+671EjSVvJnSmdiKGtH4P/HvNcR6rjwOl6rV3Ou81TkEtXfoLu2ZyL/iZuA3n4ftYSDVvyGIqUfedrKVOy3Iy/c6a7Sq6cd2XE9iK4gtBjAhu79qKQoBYUQLHair3PVstxMwXfLVEB9MNM5RPQWbhZ+WJ69/Z/F6stCQUm9NN6XN/q+355Pmq4ynYRETiiZNr0iv5SdPh/QWCV49Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eWavWN28GH2sKmampkNxgp4RWhu9GuiIwTZkighzq8=;
 b=Kq1cXzjVs/04GknL1CbqiQVrqg3ql+jP5WrzyDheqzGlQW40/x9GCMamj8mlVLxZdDJOrbRq62IampzygZGw5XtaOg09qf9uyb3vA/+DC64C4jylp0w3uxQgu9g6yVYl4uVvBepjSl2cTysbSTrX6zcxibOMxcWox6UQddK/TybYvhnV0/w7fslT5wyEmT/FFKlsEiPxfulpQtA18JuNDSGdHc0D10x2rmEPkeVHkRAaY/l2Z1uIiTa1Y/w8/PFQe82hoHHCtSWakJVuJhZxH77pOM1YY4Je1SR0Tx1KgBsrzzxW5G0Ybr6JqSmSLsUSGIuiNQTTlSXNS3hJyWNpzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=talpey.com; dmarc=pass action=none header.from=talpey.com;
 dkim=pass header.d=talpey.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=talpey.com;
Received: from SN6PR01MB4445.prod.exchangelabs.com (2603:10b6:805:e2::33) by
 DS7PR01MB7805.prod.exchangelabs.com (2603:10b6:8:7c::15) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.28; Fri, 8 Dec 2023 15:34:48 +0000
Received: from SN6PR01MB4445.prod.exchangelabs.com ([fe80::e38:e84:76d4:5061])
 by SN6PR01MB4445.prod.exchangelabs.com ([fe80::e38:e84:76d4:5061%2]) with
 mapi id 15.20.7068.028; Fri, 8 Dec 2023 15:34:48 +0000
Message-ID: <28ae8ff9-2437-4185-bdd7-40fb4c2faf46@talpey.com>
Date:   Fri, 8 Dec 2023 10:34:46 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ksmbd: validate the zero field of packet header
Content-Language: en-US
To:     Namjae Jeon <linkinjeon@kernel.org>, linan666@huaweicloud.com
Cc:     sfrench@samba.org, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linan122@huawei.com,
        yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
References: <20231208065647.745640-1-linan666@huaweicloud.com>
 <CAKYAXd9t-J+BV72u_JdYD=MrOyat1Nx1=Jo8rBa59qtsrNviDg@mail.gmail.com>
From:   Tom Talpey <tom@talpey.com>
In-Reply-To: <CAKYAXd9t-J+BV72u_JdYD=MrOyat1Nx1=Jo8rBa59qtsrNviDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0072.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::17) To SN6PR01MB4445.prod.exchangelabs.com
 (2603:10b6:805:e2::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB4445:EE_|DS7PR01MB7805:EE_
X-MS-Office365-Filtering-Correlation-Id: 3aaaee6c-9b06-4754-1584-08dbf8033646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PzBRVEcMB/Yg1ysYLIvMSygWXh8hkRc0/7OBn55q2k4dsaCkEdTAzWRpS1FEdaEKfNfFYt2YB9svivdML+4atWYAmWpUrAkMZhY3gFvlJY4FrlivdSNjUG5LW77eYTG7tZKYv5YOxm4j9B1NbGGYG0O6Q/ZvCET3bIyU8G4eT02HzjHfOpltrKyC9wsr+l1FZes2w9sTpcdDfYjWE/E8kx6wZJsPMW4HwXlpOJEcuP7nJZgY5fNIaqtG/D3x2sEHNnxdqhWWnCd0QFYn9cWaohNOdZt9X0PNXb14qSIVIXT/Bws7MnnTZsz2yxnTlnS6TR3uZcPh/auJoeYKUPIYQtbRh/sEJ9Pqtxpv82jM6HxijtkWWCYCoetQzIs43qv8sVzFEqfTWuepEN8EoID+DVbR0jRMzGZsaX1mgsApLSjiO8g/njmDcSIdpW8ClKt9paaaKZVksw7nN/DjhYI1ImZKjYKSii0A9kfzevzjUTqO0IHCRzDm9EBmnq8Q9EIfS3tWleS9+mNo5/O7YyhfktY/xf9dHc2TU37KJPUMCWbqGs0HYyEPywy6CB989b7wem8cfBdNbL2RH3UeIO2OIP8StilHO2rJfUyrZvmv6rs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB4445.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(376002)(39830400003)(366004)(346002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(36756003)(41300700001)(7416002)(15650500001)(5660300002)(2906002)(83380400001)(66476007)(66556008)(66946007)(6512007)(478600001)(966005)(6486002)(53546011)(6506007)(2616005)(26005)(31696002)(38100700002)(4326008)(8676002)(8936002)(86362001)(31686004)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnlxNXEzenlNUm0xcHNxblBhK04ySUhUZkRPZVQ3dDlwdmMzTkE3cUJsYnhx?=
 =?utf-8?B?Z1NrU2llSTNiY3M3NElKaE9lZlMxMC8ybWl1RVNMR05IR2NMRVlmamNhZzFY?=
 =?utf-8?B?ODkwQ0hjUzdzelg2Z29iTGZ0am54RUNyY2tCdVpiVzE0QmFFUjBCU0o1Rzhi?=
 =?utf-8?B?ZlowelJONWxUNitJNmhYYjFWeEhVWnRDMWRSMld3ZzFDb0l6VS8vTHlQM1Zu?=
 =?utf-8?B?V0o5dkQ0MjIrTUJKMGxYSEg0OWJGTjZIYUp5aUdTbGVjNVluMUJncnNGeEp2?=
 =?utf-8?B?MitDUGtoY01QTGxuVndiK2grN1c1OWJJZ3NKbWJrNy9QbFdPRmxYd0QrRzBZ?=
 =?utf-8?B?WkViQ0cvcGk2TjBKdHN3UWRMRVJqa3Vqb1BtVW95RXZTajhCN2NrM3dON2U3?=
 =?utf-8?B?SjUwaFREQlF0MnZYYXBTN0ZKR1o5M0czREcxdzBQME4rTnJzK2M5am9SVUF6?=
 =?utf-8?B?N3FrUGdRNjNYVjVzNGE1aWNxWkIwdmFzU0gxRXFtM3NmN3dCSUQ5bVdDV2My?=
 =?utf-8?B?UzJyWElSUVRWdVVRRWZDSUg4NG1GeE1PMis3RitITU1teUFVZ01nZ1N4Mld2?=
 =?utf-8?B?Wjh4T1FyR0pqR2ZFVVBLQkFUWW1qZ3AvanhzSVk1L2JPa3NFWm90Lyswc0Yx?=
 =?utf-8?B?Mzh0djhOdERQdGUwUWNqRWVwQWdhamxGRjhZT3pHUWpDb010bmRwR0hXc2J2?=
 =?utf-8?B?VHRUVHdsUGtzOHBTOFdEbWdWUUNsbEc3VzlqZi9qVXM2dmREWVVlM2tLTFRN?=
 =?utf-8?B?NWdUbHRxblA3bG9WdDFUNmxHWG5nYkRpeUY2bkVFaVFhN3JEcEZPdGlzU2Vt?=
 =?utf-8?B?OXJ4ckpJWkdQT1NZdzdnWUtQVndvb1FYRUlWbytUTVUzZDVKVkdhZ2xrUVRM?=
 =?utf-8?B?OWFLUllhQnUvQUtHb0l0d1RONWNNWUU3YXVoeTJVRmJRcUJlVDdWUnY5WmRB?=
 =?utf-8?B?dkh1ZEZNRWFIWDJoaXBvNlBSaVZDZ2oxMmc3QnhnR241dU16ci9VN2FSSmpu?=
 =?utf-8?B?UGZWY3hzNC9BcFdkaXgxck5aV3VJaW5BSXhrTjRTQnVPQWpKWklDTkpsSTV4?=
 =?utf-8?B?NWQwM1pFbHVxYXFwdUlxSElXM3pFYUVtWWh0Vm5rdFBjNnlhOU03WXRMS0Ft?=
 =?utf-8?B?NW9NaUJsWk5hbkMyajVEV2NUZlBNcjE2QTRDNklhNHp6c3gvYUhPc1I4bjIz?=
 =?utf-8?B?Rk9ZZHljU05uVndPcmhjdHZBMzRheHhzVVkvOWo0Mjk3UnRxcG5Na3JCaVlP?=
 =?utf-8?B?NUFzTDFlMWJSR0dzKzN5R2MzRlMrL0FkZnB0UlZEUkN0ZmkwajZ1dVlqMkNu?=
 =?utf-8?B?K041eVBXZTFOSG5zYVg1MWtJREh3QjRoMllEL08vYVVIVWRwVFZVRVByeFVX?=
 =?utf-8?B?aEU4SFFraS9HRXNhL3lTaXRXckc2akJ6dG82Si9BUHpIOFk0M3dCTXJveGpw?=
 =?utf-8?B?S1BBRlBGeThVK2g3cmlTcWh6OHUyNDZ3cTd4VVVVeWplcEU1bktwRm5DMDFC?=
 =?utf-8?B?MjdOekhzc0ZTaE8zSktBSkJRWUJRMFVoaERCVlQ5aVhPUGpkMVdLSm5YdjlR?=
 =?utf-8?B?U0lBQkFEdW5PQnhwck9UVE5RcFNSa2ZuRENreEJTNGdycUROTUV0c0s3L3Zm?=
 =?utf-8?B?OTlsSjJjZ0JWdjc4SFFhTjRCYjJrQjltaVNmZ2lUS01pV1RDVFVaSkZFZU9R?=
 =?utf-8?B?Ri9HSFh0SDBsOGRINUtYcWF3ZWNBeCtCaWlUZmtScTR4MGNoVERrY2RGWldx?=
 =?utf-8?B?UXhqS2oxeFo1VnBpYlpsOFowYS9JMElJSWFPQXVhTzlVVURHZWR4WHJaY096?=
 =?utf-8?B?bjNtem14U3JKNFgvcG5ib052TG5jNWgxMmhRUHpCem1jWk9pSU5WRHNleDVS?=
 =?utf-8?B?ZzVuMkxrWXFlVU84L2w3SUgwSVlveU1IVGFBeG1DS2lmYTlXc1NnUGNWOW5G?=
 =?utf-8?B?VXB5VEN6a1ZiT1lJeUpLb2ZHUmY0YjB3WHBzT211eVdCaGxZUnNyRUxxSC9U?=
 =?utf-8?B?WkIyb1lXeldhanA0c2NkdGFhRWxndThGUVQzOVd6cWszT092Q3J3cXN0dE5r?=
 =?utf-8?B?cmk2Tmp6cEd6RHRYcU9JM1Z1NFpRN0pWTk0xekp3U012eXFBYTRPV2x0TlFl?=
 =?utf-8?Q?uTWgO0s2aaoo8iX4WrsIex9E5?=
X-OriginatorOrg: talpey.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aaaee6c-9b06-4754-1584-08dbf8033646
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB4445.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 15:34:48.5680
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 2b2dcae7-2555-4add-bc80-48756da031d5
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLMPryMGBGPTylEfEz+8IYkyeqHROWPCwKM8FIxWwmtMQnhTamghqQfRDCqsDtfd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR01MB7805
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/8/2023 9:20 AM, Namjae Jeon wrote:
> 2023-12-08 15:56 GMT+09:00, linan666@huaweicloud.com <linan666@huaweicloud.com>:
>> From: Li Nan <linan122@huawei.com>
>>
>> The SMB2 Protocol requires that "The first byte of the Direct TCP
>> transport packet header MUST be zero (0x00)"[1]. Commit 1c1bcf2d3ea0
>> ("ksmbd: validate smb request protocol id") removed the validation of
>> this 1-byte zero. Add the validation back now.
>>
>> [1]: [MS-SMB2] - v20230227, page 30.
>> https://winprotocoldoc.blob.core.windows.net/productionwindowsarchives/MS-SMB2/%5bMS-SMB2%5d-230227.pdf
>>
>> Fixes: 1c1bcf2d3ea0 ("ksmbd: validate smb request protocol id")
>> Signed-off-by: Li Nan <linan122@huawei.com>
> Acked-by: Namjae Jeon <linkinjeon@kernel.org>
> Applied it to #ksmbd-for-next-next.
> Thanks for your patch!
> 
> 

Technically speaking, the first byte of the 4-byte header is a flag
used for multi-segment continuation/reassembly. But since ksmbd does
not have any code to do such processing, it's best to deny the
message. So...

Acked-by: Tom Talpey <tom@talpey.com>
