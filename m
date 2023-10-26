Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9014E7D8771
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 19:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345028AbjJZRTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 13:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjJZRTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 13:19:22 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0096610A;
        Thu, 26 Oct 2023 10:19:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDgpVE19BA7/JdP04MWIirKq5KIcuTu1V4T7SgQHtqzPxkXk4H5PKCTqIdPz+RKCa2NyJNlL0ySEVY/dhmlwrRNf7gMtrR+dLuJdeYDt3V7/QZ/Ls+ytUQKbAgz+BsH3Y1RhEadBnapsN296lFGTDF8vb5Vt5DBlvi3MCWKo3pMkAwL3fPQ8mXiFCOiawYTfClqpFr/B7QKv2tuxN6m1KjWBVLRayKb3TGms8xpF/5b3T5qf5v/5KyUEUwyryoxHo7puJbuXnkkMExl4/Vr+eybJZiRokQUBOAHpo7yGK+aLBZ/eABJwoGKDXRNPTchb7rO+VyjslL6NBvI6gnZ/AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzs5H7KtadBy/TugZiSXtTlAOxpXcMJB9/2ekyyW/WE=;
 b=A0D1aq4AES7l8VF75FZIK+yXyrSjrW+iquxpZWUauVVKzTldKWfoEhN3a/Zevt9EJ+xTGDlkhaDh2gfximwJNgpTx68StV5H7qSRfMuUCbWUr/94ZCiUqsc5TFWBUSIjIyy+iRMwCpZX1Yy9NMWUYja/2qonFUCyM31HtR40cMlkc+HlvmvPzJ/BIWtDGREpRbnr5uR86jDK9cf5KcBKBklGpEgH4sBtw0eTISAdGFVxttuCVKHVKxVsynH5QK9HXKhjYDkxb6i9V3Eok0CO+PDiCFC/GqKspjOAX5cxQmUZauAJpfIGK6wLDytJi8dEM1asWNyFTLjTr9dNkVffJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzs5H7KtadBy/TugZiSXtTlAOxpXcMJB9/2ekyyW/WE=;
 b=eUsfhYI+nYLu+N4dOmp3MxhVWDB21tjjhouyA5ie4HCAPZyLNNT2CYs7h5OYhfs5bLoJxwfSsIEZh601umy5bqYucdTuVcOga2JU8+N2o/4TgLaT4W84yRUzkjzP8+V33B0IftSj2rc3nLY47AgXJ+HIW7CiBRBQb/jKsq4bU4I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DS0PR12MB8454.namprd12.prod.outlook.com (2603:10b6:8:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 17:19:17 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1e4c:5da0:33ed:ff3a]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1e4c:5da0:33ed:ff3a%7]) with mapi id 15.20.6933.019; Thu, 26 Oct 2023
 17:19:17 +0000
Message-ID: <a55c7d7e-019f-4eb1-9ae7-ec5e0f810bd3@amd.com>
Date:   Thu, 26 Oct 2023 12:19:14 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH] x86/resctrl: mba_MBps: Fall back to total b/w if local
 b/w unavailable
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>,
        Peter Newman <peternewman@google.com>
Cc:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
References: <20231024181600.8270-1-tony.luck@intel.com>
 <CALPaoChftF-H6GauKq4-c_qBJP1GJbR3-ByE5krsaQF4y4y9oQ@mail.gmail.com>
 <ZTluypa9bCWv4k2n@agluck-desk3>
 <CALPaoCj72V=o60tqsFMRzaeUw-1+rN7pyhsdCyVEV=0tN_CZ7A@mail.gmail.com>
 <95fc35a2-2f19-4ba5-ad3a-7d7ae578289c@amd.com>
 <SJ1PR11MB60837D379853EFB14A6A20BBFCDDA@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <SJ1PR11MB60837D379853EFB14A6A20BBFCDDA@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR12CA0001.namprd12.prod.outlook.com
 (2603:10b6:806:6f::6) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DS0PR12MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fdf4489-a243-473a-3cce-08dbd647af2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C7nDc/trUtJWI7PdI4N3x33rB43iiQVwTZEJ8tVaP9z5lbS8Z7LU2gV0ihq+wtex4b0ysKo6BVdK8f4cMNDMOIHGldztBRAFZxvf9JdjikgX2dnWdoLhOWQc7aNtXV2cXl667OiPVlZI+funPQ7yjtnJmkr9XkwfELHnuzNj2F/3M+A8vqQsU2W8svxlQG6wWa+V0YCr56forgrxz+0rRrw/qLZlJOLSNaZc7tQpHrCN0GEipX714pbqvzvFVR38uIEQ7v7F51InU8R+MBg0yMlEFc3GKP09nrcMUeUngF8LBhi6qkklD0cG22FK/wvUO5bU47y5+ICtza4gSAMXLJemey35t7BDh00YQtUAmbjt8JTwokWts5uImROfNQnxGepocc3z8V4r4L3vdNn/zjY8Dypc6jp3MyS5G6fyolSYRs+5T42foAe/JYoLlOPX8Fiit2hxbfBa1sSq2weRG7/CypmeMBG6QfUPKedztn7oenEmlsARzWM0qKwSwOwk/Q9veQUW0QcXmtYejPbkb6itu9SQ4zWGOdCpGmxgll9+wWsy6hFPiFhgsVUQ/uTTM1u7ksVcZkRRb7zKBS0ME6KO0xeU/EBMN1cWhW8fcfx6b2jS4hmcy0owMmcp9/IlAzd5ZrU78FPQzOWE0F3XQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(39860400002)(376002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(6506007)(53546011)(6512007)(6666004)(66946007)(54906003)(478600001)(66476007)(316002)(66556008)(5660300002)(4326008)(8936002)(8676002)(31686004)(110136005)(6486002)(3450700001)(2906002)(7416002)(41300700001)(38100700002)(86362001)(83380400001)(2616005)(26005)(31696002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0hQK3JEZjB2eEtuTGRscjExblZlOUxyY2RScTZUK2J1c3VudGJYS3dtYW1s?=
 =?utf-8?B?SFYwRmxVcFU1QVRPbUVXYU5xb2lFL3lSUjlEcVFWZDllWG9YM0FwekcyVC9P?=
 =?utf-8?B?aTNTZDBzckFlb0RxcGFpOXhaY2hNU0JpM0hzTHF2ZWk4dXdZWkZZd05wYitT?=
 =?utf-8?B?WUZIbm1mNnVPNkpHdTBRRER6WFVsK05ydG1PNVNoWEFCdTJWeEUzS2Vzb2Q2?=
 =?utf-8?B?SFdtcDBlWWYzZ3lwKzNzSE1HSitJc1g5aEVsdlZYd3ZpTjA0KzZyMXh1Wnhs?=
 =?utf-8?B?eHR3dmcxcUV0cVhtU2c1cGJhaXRFb3dnbUl5TkNXV0JCWFlwUnd1TnA3bk05?=
 =?utf-8?B?aFlJb2syRlF3cUxKWDZqM0tZbzJlbEZJWkpXNjEyWDY4WitFbFlWZ2pCNGtV?=
 =?utf-8?B?YWV6bWMwQnBLRkk2UTFsSThTRUU3UE9tVDRhRndtbjZrb3doWmY2clA1bG9J?=
 =?utf-8?B?Ry9mZ1hmY3N3TUYyYllnVktGQnc0ZTB2NEpqa1Z4SUFDelZvMk9VQ3gxZ1Vt?=
 =?utf-8?B?RldoWTRUdHd5WHRDR21PRnBobkdGTmFvNXVWdFM2Vlk1eGc3ZGNVVUVDdXZN?=
 =?utf-8?B?WDJJcURIWkVsbSsxLy84RkhqYWpQRjRxUTdPekE0bGxibEhNcXJycjRnZjJO?=
 =?utf-8?B?cHNNUVZSTXhkYmVRb2dsQmord3FUZncwQmltTTRzV2s2ejdDeXkxbDlob2tu?=
 =?utf-8?B?MTcvV3Q0b0VTV0dTSlBZNXBDRDRsN3RiUXhONWpGaFBMVHhxTzNheVZITEVo?=
 =?utf-8?B?clhRamk4SEd0YU5ZV2U5Ukd2Y2JzU0RMSFJiKy9Vdjh6REN4T0hGSWg5MUhz?=
 =?utf-8?B?dGhSN2N6Y2VRcktZN0FWSDU3VXFXcDFNWk41L3JtY2hPd0s1c3BFRTFnTURK?=
 =?utf-8?B?R1FEZ2FmUyt2SE9VQ1JIZ21FcjIrVktOdzNvMFQzSzRlSW11eUxtQWNIRVZX?=
 =?utf-8?B?bVkrRFdFTWQycjVYWWZVSGtBM0laVTJ3R0NBK2szVjhCdmVkZkd3dnIvaFoz?=
 =?utf-8?B?MzJHbDdVTlowNjF4Uzg2Y3BmMW9DclJsK3A2cWJTVjZXTS9LdVUyZFJsWGJS?=
 =?utf-8?B?eTc5eVltcEQwb29QM1BhbmhUZXljMm1BNVVEeWJWUTBvWnllQmwxemU3SVdn?=
 =?utf-8?B?U1I5NTRGdjV5VFNlMjJwTytSd2RmT0VCelpiT3VLN1ZGOFlvM3Z6cUNFS080?=
 =?utf-8?B?Q0tveU1ObFBDUnJMM3cxMGFVRnpUK2R5dkptMWM5UWJVSk5vYXR6ZmhCNjhv?=
 =?utf-8?B?NVpacW1VOU03cTllR1lNdjZjRlY0UDlTd3RrdmJXZlZxWm1INDJVaXVneFJF?=
 =?utf-8?B?dXpJc25BbXVqZ0Z0MUdlOWdkMU9tRFpUVzU2NHpBODNKOWordXoxeTUyS241?=
 =?utf-8?B?d1hCdEJNNTFxKzZYMlByUEhCaVlKYVVrTUx3aE1QWnV6SGhXM01KeDdnbHJi?=
 =?utf-8?B?Z0J3enNVbEN3bk9lWDdrUDlWT2V4bG0zc1ZYWFNEb29kanNYMFJqZVZUem5W?=
 =?utf-8?B?SlRnN2k5UEpRdkdnaFVGbXhWMXhZVGR5MmV0S2NjcWUyUnEyVUIwWDBvd3pR?=
 =?utf-8?B?VjlxUWh5bk0zNzZHRzZ4SEozKzBKb1gweVFtS1RXbDVCd2FvUDFieWdiNzJ3?=
 =?utf-8?B?SmZYWVVEZXpyNVRwczFFUG11RjExc2k5NTJmZFBWOHNxT2RpVjM1U2pSNjlG?=
 =?utf-8?B?REM4WEJZeEtSYk5Kd2hQY0JicGY4WitrR0xEQkNIaVF3TGFXZ1l1U2NWMjYx?=
 =?utf-8?B?THEvaWp6R1lTMXVyZTFqdXdaekIzZFBFYmUyaGcrTFMrQ2ljeXV6Skt4RUZU?=
 =?utf-8?B?Q1ZwMFJpcGZkSFpnUVpRNTR5dHptYk9jSGxoRkZTWWg5TnRXaVV0MW9JbEFR?=
 =?utf-8?B?NjhjNXp4RlBDblZyajZQaUh6S1NzYnc2cWRpU25sOWpZMzAya010eDlSZjEv?=
 =?utf-8?B?QTg5UkZDYm1hTTNSYWFGTWQ4aVZwZTZ1d0NBRk8rNzJDWnBHMG1qK1UyQnlP?=
 =?utf-8?B?eHdRckRwT0ZWU0piNHdldTVyQzA1M3R1QjlUdTFVc3FzWXpmcVpDQ2Jxa1JT?=
 =?utf-8?B?RGkyVnNuN3FLYTZQTVhEVEE1Q2JaV0FPK1VqekFCK05ZOHZINjF1UGVoNVho?=
 =?utf-8?Q?v+3s=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fdf4489-a243-473a-3cce-08dbd647af2d
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 17:19:17.4410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PS3Eu/+dIBJ3TED6VMslOWr8mF7gO4i31NQA2iC2LO1j11BOT6q89KzVW7zfOB+w
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8454
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 10/26/23 11:09, Luck, Tony wrote:
>>> What I meant was I think it would be enough to just give the function
>>> you added a name that's more specific to the Mbps controller use case.
>>> For example, get_mba_sc_mbm_state().
>>
>> I actually liked this idea. Add a new function get_mba_sc_mbm_state. That
>> way we exactly know why this function is used. I see you already sent a v2
>> making the event global. Making it global may not be good idea. Can you
>> please update the patch and resend. Also please add the comment about why
>> you are adding that function.
> 
> Can you explain why you don't like the global? If there is a better name for it,
> or a better comment for what it does, or you think the code that sets the value
> could be clearer, then I'm happy to make changes there.

My theory is always try to localize the changes and avoid global variables
when there are other ways to do the same thing. It may not be strong argument.
> 
> Which events are supported by a system is a static property. Figuring out once
> at "init" time which event to use for mba_MBps seems a better choice than
> re-checking for each of possibly hundreds of RMIDs every second. Even though
> the check is cheap, it is utterly pointless.

mbm_update happens here only to the active group (not on all the available
rmids).
Also, I am not clear about weather this is going fix your problem.
You are setting the MSR limit based on total bandwidth. The MSR you are
writing may only have the local socket effect. In cases where all the
memory is allocated from remote socket then writing the MSR may not have
any effect.
Also you said you don't have the hardware to verify. Its always good to
verify if is really fixing the problem. my 02 cents.
Thanks
Babu Moger
