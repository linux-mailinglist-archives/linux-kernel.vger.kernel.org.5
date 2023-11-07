Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489767E49DC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbjKGUdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbjKGUdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:33:20 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA0DA2;
        Tue,  7 Nov 2023 12:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699389198; x=1730925198;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=x72g59TJ1u0yNz1XjOUCQ8oQotUzOBCpvTrIUY1EHkM=;
  b=D8DZElT5ZY0jlBSTs1dN1jiyd2um5sJsw1LaTTJ40WMnH+b/yXH6OVHY
   dxt79KzzZFRIIMU76ppKz2wZrUwQnJXkk5507QJ6Cl4y6pYvIDD9t4yf7
   1q//74DrQvG/8ASlkEuwDzCjkxQrlrEyoadTDkNIpbWeYn6EHaLeOl4c0
   Qa74GYx4t1j/zGQ9NxZZ1EhOImsOeuz7C353Vy9N5YJwGHeP+C+gCECh8
   pf5P06FUVZ9QhsjnzAKyNJnBu637UBdPlhYUEzvCCI9EwTLR30fByPfj0
   tJTwaN/oULFZ/BL0Sayr2gUFw3kFdOPa/fI7Sq8BEje+iGpax78SNjoaM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="374661488"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="374661488"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 12:28:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="1010027328"
X-IronPort-AV: E=Sophos;i="6.03,284,1694761200"; 
   d="scan'208";a="1010027328"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Nov 2023 12:14:10 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 12:14:09 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 12:14:09 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 7 Nov 2023 12:14:09 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 7 Nov 2023 12:13:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RRzeLXF2iy+FnzMwhs4O9Rfgku4EIaJtL8LohhipVmxTTKGRmUqBwkZ1Hluor2lzTNb7VHIBfikcCBQvEZ+tLvKlaRHMOFDTdHlhrQPsb1mKvtsgujtBQOCbuKHwMioWKcj6qf0sQ85CSI4+NV3MByMGyFcTNr0b0frtJux6tLBJCdKTt7+JPEgZPQehB0cY/FzKEydiHNmbe7DyKlgdbF/C+bHS94jdBUYVwJ2ZtQwv9HFQYTGE8b/2m835SWq9IXv8aC1KJrOfbIEzg9tjVCgaWY8BfW+eLZBzTUYc4UuaRyQXU8CVMfrgG9cCm9lUD+OWd2eIbH09Svmlpxm7Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x72g59TJ1u0yNz1XjOUCQ8oQotUzOBCpvTrIUY1EHkM=;
 b=de3tRwas04y9yCGHRerdA3Clu6+nrIomTgJba2OC0xfQtGo0FgPs+ABzA6JyublQYk0Nyz/duTyIBzJ5G78GUfHvaTNqXMxaP5KyCnZ2WjY39/s4HvqBAT8gul7layN/VFKMLkBMrHQvOmQs9om7imbJdq+zZ+ZFMSGRiTFRVAyIWcI6782veeHWP2V4yo8V1oDn0ekie/CL+QVo1kF+j5hklnAm+MSCn/zi+4IFdJ/euWM79qn3YyX/487wNFnDfMGZaEsTeGxtnOCyLmTXtSj8ERxQSwXcVQCK0+1+gsRShazEvRGWdSgymF/bVzJW0GHV8uvFqZwVJ0DF+nyTTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by IA1PR11MB8150.namprd11.prod.outlook.com (2603:10b6:208:44c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 20:13:19 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::fab8:8ece:c8fe:fc7c]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::fab8:8ece:c8fe:fc7c%4]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 20:13:19 +0000
Date:   Tue, 7 Nov 2023 14:13:17 -0600
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>
CC:     <linux-modules@vger.kernel.org>, <lucas.de.marchi@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH kmod] libkmod: remove pkcs7 obj_to_hash_algo()
Message-ID: <xxg4dizkj63kwddmjq2ti5kszwu25yoa3mhotz6expvey53o34@nfmy2xmsexoo>
References: <20231029010319.157390-1-dimitri.ledkov@canonical.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20231029010319.157390-1-dimitri.ledkov@canonical.com>
X-ClientProxiedBy: SJ0PR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:a03:331::14) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|IA1PR11MB8150:EE_
X-MS-Office365-Filtering-Correlation-Id: a90c05ab-158d-4b61-2eda-08dbdfcdfc27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dd73lMQAdym8xbeiZyXzS1Y5gNbIUX5oHw/kiGpL4hmJ2R2Y/Pm0NkOvpBpxyU6ZCqNquKxVz0EMxSg0QYBtV//LLmgny41Mobi5C+nji7YsopFnfKXpcHD5in6cHiIovr2p7pxfQl5MGhImC4VVRLcOzZU4uel1JSNUkZbJZP7ntKLGI45+FGEvaAHfsPvpZ8GRHdHUAzbCJrRCRiwHt04SR1tU4O5tYkx5S0s79setiUhr9jy4dvdYfDIKiZTuSw2BndPtrTMQi4PfwhGCZ/tHWLOufkN8uW0uc27Ri6ASpprAhkD6LdzKA9ZrNZvXHan1XLDmXqmUZU+8Xoz9H90mCtUnap+gwTB7N7g+56Ge3sqAA65VE6vjoyk1Lvaa2EXlfeeFzx/fryNXdJduQsmufXS33SiWNAtE2Gvg9rPhqGsCytlIFBdxxNo0fiPlppN/yupx/IEMHCnC/2v4PO+V/uVgN4TWB2ydGSl8NLS4XGY2ybSrj9iNSXBPgGkYC1wAgeWBzV8xAOpdksbVRCX0c7WbvW7yN4HWZnaeekZ41RMp9B+0j4S933otQ20/
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(366004)(376002)(136003)(396003)(346002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(478600001)(6486002)(66946007)(66476007)(9686003)(316002)(6512007)(41300700001)(66556008)(4326008)(2906002)(26005)(8936002)(33716001)(6506007)(6916009)(8676002)(4744005)(5660300002)(82960400001)(86362001)(83380400001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eocY6A/pr3DL7aTvBWbqSXaigXTddsGHPPEoOarQdbjiGyfKn5uPNJYaKPJK?=
 =?us-ascii?Q?i5zo/isBPShHsU5quezpcvyIUOr1jDvJQCbON4NOoqfajk/gj6Jocf8m5v3d?=
 =?us-ascii?Q?/TGq8TP8keVNngXXjkyJ1dqQGppPO5CwWiXZm5ZkafgBS5/jLv1woRLI+myZ?=
 =?us-ascii?Q?jcRoYRICoO4L0B++CViA/SEkz+A2wDKlccUVVY/F9n6MIwyJp762HEYVQBvR?=
 =?us-ascii?Q?v0CRZTYr+o8JQhDb2cNSgZE9XxSerAHfgH6SMAKa9H0Axjh+MfykxBz2MvG0?=
 =?us-ascii?Q?Jutik18Z6jmzK8hDW06MiAPB3eFEmkCqmiSZU5lkjxZ48Zt7vtcD9oZLvTs3?=
 =?us-ascii?Q?JEMQmlmrxTFu6QmJaYtnsMkWgZpRrWl1smtlp3qTevJUGk/Qp2Gu4hug+jX8?=
 =?us-ascii?Q?nZsnqMaLYBnSN4xxIYuSJE7iTbWjnXrFfrvHLhbIpHozsKLxYXJxwdFXBoEk?=
 =?us-ascii?Q?rmAa5MEJBGAAGoI0IGKnLuRfSd5p5uTw50rHiPeXfpyv8xMw70A1WQZC0RQS?=
 =?us-ascii?Q?68UyU1jAjAtmBe6qq1jFh4O9/Mc/ejmgtvNylGqVmPVQoSl6QLJ2LbTDeGuC?=
 =?us-ascii?Q?+YiaUHlgFFP0vFlpPaqrONIGD/xL+5VMvbDLnCpI8r6m1VtlJx60DyQt6r8u?=
 =?us-ascii?Q?+9CLPlmxVCQdQqDw5L/GTq0hTwQhiHgBwvhm5PXgxewqbE/PFa2CA12iErkO?=
 =?us-ascii?Q?uGlRX3ElMqToB47B9ZiR31OgaRUSeC2eKsK+2ujWiRaTg5/IIaFA6hb/iYOv?=
 =?us-ascii?Q?EnW4A43/yHcrur59lKBb9xolfNR3X25RwINir+sZ60b4VAFuaj5umZrHAP7j?=
 =?us-ascii?Q?OuzYVrtnNXrYmyAZR86xVqB7pbLLekQmtv7AR9gZAfCU2Tlit3fE1kg748kJ?=
 =?us-ascii?Q?JqbSyCWYdSOAN0NDtGNQWXJTAqf2tpIC2Th6x4qza3krxG5spVhx/KgBQVBb?=
 =?us-ascii?Q?WmksJPNGoxbkVA/+m6YaDahqgZLuIZymzjonkRnC2vP2u6cK7XxyoLBZL0R0?=
 =?us-ascii?Q?OxaJxEPzhne73id3h4//87hW3bhB5JbQkf80UUNSGiOIUfjd3InfSdwJAdv/?=
 =?us-ascii?Q?giPVtGhihEI0kkW5in6hyZFQheqVXFmeQpqqbQHI1kWX62Sc7mnVF8Q8ygsY?=
 =?us-ascii?Q?b+K3pSBvjGbV5kptPTIoNS0zK8aGOwcje0AZnmH3qHKixRA0t2JVhj1sPUSx?=
 =?us-ascii?Q?AoIJGklNhPa63Hse4YGgxpdSnQN+Rhx4Q4WkRqz3u03t47N+qtoaaLI3tOG+?=
 =?us-ascii?Q?3gSAF0Z+KRfsckz3xyedrzteXBJNEojDk571DEf3DBE9nAR1nvt7Rl03MJ4F?=
 =?us-ascii?Q?nObpwUXESFbF4MsEIzEC67BOCdMy4CtWy1zbz+s5HsSEPrIbfm/K1UAev2/m?=
 =?us-ascii?Q?1fUN+GBV2ymcZWxha6afLLnHi380nvh7Bg/cfUfC+gH9oq+FtaN8UkHedpnh?=
 =?us-ascii?Q?ln0erHZKQ7Er7ogJqyzZwe4ZkH4wGh6s49FML59/95ubwQ5ZgF6fh1/LjPoW?=
 =?us-ascii?Q?cf5MKAWUvFtI9/YXXJKnhefHTZ1Yu0LcdOHvvqlxkvPpkqSGEeUs4X4up5Pp?=
 =?us-ascii?Q?V2RmPzIF+c64p3SPPRpRzJEisLa/eMw81NuBLICeRXHDTzeIvA8TLB1cmn4D?=
 =?us-ascii?Q?8w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a90c05ab-158d-4b61-2eda-08dbdfcdfc27
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2023 20:13:19.8206
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GttIBPGbScIbknEoWelBM1MEv/P61IpXrLpKqIkBLI/OQMcdcces4tO6b1lWXCG5uyEjjN91Ijgc8qsnBYFL7x+ec2jdYk6DZkEdbUVxo90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB8150
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2023 at 03:03:19AM +0200, Dimitri John Ledkov wrote:
>Switch to using OBJ_obj2txt() to calculate and print the pkcs7
>signature hash name. This eliminates the need to duplicate libcrypto
>NID to name mapping, detect SM3 openssl compile-time support, and
>enables using any hashes that openssl and kernel know about. For
>example SHA3 are being added for v6.7 and with this patch are
>automatically supported.
>
>Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>

Applied, thanks

Lucas De Marchi
