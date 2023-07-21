Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773BC75CFDE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 18:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjGUQnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 12:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjGUQm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 12:42:58 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE9130CD
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 09:42:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSrsjtQYtHwyCQuxV9Qey8C4G3FiKhvk7n/i8IbM2BcCrGTMly6B2gETGSUioM5h0CLMXBS1JF9cvx+roadQetuRVEpmyc8kwA21nCv/7vqkx0Hk4R3nzQ0PxEUOIEgshK38lPVRtoMxwxqNEijJQeFx9cCJw0oKx3xEmYEO8WJ9j/jHL2jpeGZ7bMcE1RPfSNHALqiR2c3piSFyGurtXyoO/hdc/0hhLt8Qqmj0xLpEDaQes3ZrT+QGmork0PoMZ9cDnSvwFbN4c4vgs2KfFshkfGRIqo6U0+3ZbKlOetFcpBOw4gdGx8P/f6/HdhtoRIT+05egizPt7n5cWAhQEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZNNkKKzcINfCkkcxmHjiWC5SKIHQDO7t/8iPyAWCg8=;
 b=Hq3UUYMchclkvHgVAjSckpk4XMUkeRs1+n5dLE+C+mad6hFWvtFvi35lPk4LkWME/RdK5Yp6ASI+mlpP2O5uV4Hp/gllGrxXcG0Um/9e3VOWpaFggXDCkJ6Rio75Pm2b4RBXtXU02IXgqS+6t4GHtn4RyJOt8rXz+ZA5I0gidtsiTHFsQokkkD83XpfUHaTpWFNTfqmF/XE6vdH/HGF+9rEJucI926eqNBMhwj6ye8ivQMUmaKaZ4IcwLNBRL4OaYR2WWwOegaW5q/nmheEBzukirHWIfl/oMWIT4z2q2TxXuaKD3r8BFxrhv9hVJLvLPm9c+iIJNiMC6shm/ivDng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZNNkKKzcINfCkkcxmHjiWC5SKIHQDO7t/8iPyAWCg8=;
 b=I1mP+fSXyU9jr39qZsbnQcm6eRtSklAtmNl+2NkIo4G5A+qCakz040UmANmOJSezUIJBgeW16UEqvVf6JGgH1KneJA2Maex3EsTtkquZfbaApVi3EXASSuD5uHBNsZTIxg0uDH2GLAFOY3z93M+e5Ix1B+ZhFG/D/aOXUDoaXF8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5995.namprd12.prod.outlook.com (2603:10b6:208:39b::20)
 by CH3PR12MB9122.namprd12.prod.outlook.com (2603:10b6:610:196::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 16:42:08 +0000
Received: from BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::d271:9942:132c:5adc]) by BL1PR12MB5995.namprd12.prod.outlook.com
 ([fe80::d271:9942:132c:5adc%7]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 16:42:08 +0000
Date:   Fri, 21 Jul 2023 11:42:03 -0500
From:   John Allen <john.allen@amd.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org
Subject: Re: [PATCH] x86/microcode/AMD: Increase microcode PATCH_MAX_SIZE
Message-ID: <ZLq1W9en/2jroDGB@johallen-workstation>
References: <20230720202813.3269888-1-john.allen@amd.com>
 <20230721154942.GBZLqpFkZoWn1Um+bq@fat_crate.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721154942.GBZLqpFkZoWn1Um+bq@fat_crate.local>
X-ClientProxiedBy: YT3PR01CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::27) To BL1PR12MB5995.namprd12.prod.outlook.com
 (2603:10b6:208:39b::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5995:EE_|CH3PR12MB9122:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a529928-50b9-4395-53f0-08db8a096c31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pXXi3ytuSoz6oLVBEmJmInf5v7YNZy5Fj5BMkypYQb7dmRyCjvDO255zvv381mQQ4xr+SfG4BmwLuUUR3MLCTO1Y7YX7qG7nJ986S/YRHydqWFTaMJVgx0CfRc2PX2ak2xa1vM2Kbiek5s0ei0HbhmhLXC9b1MQfWVf1viaFesBGL2vMskLAgPlYasqeQwwmzbX/mpV+Xh1uzpbFdJMspZfA5gRNu4Qb7JtajxwEhmCFtr2pxvWV1DxWj7oksThpnWxqr9dMk/Z6vzXOP3EFhTOQjP4NolgO1+olrq4IDUFyN7Z31IcdHTbmDS0t0PvgIjaM0dt9iDKqzGW8HCPLkC0J/cSQnG4FzWHWZOecai/2tT3m8u4VTJR2iT5oqptneirLsa0QkGjkzwR8gWllZjun8u3M/PY7whC6Gi+zFaiKcAJka3K8oP+talGgQl9/Z5OK01viS35INd6RbXib/m+qgFFyjUMAyDlyxjpgn/JOtRWAtfrbFLmInwNzsvO4FM/ZS9fsukc3yDShsO5SPhTdQMSnJbYCFMtjHsLXuhByyiQFe5mkAoeHsuxZMqSW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5995.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(451199021)(83380400001)(6506007)(6666004)(478600001)(186003)(6486002)(66476007)(66556008)(66946007)(6916009)(316002)(4326008)(86362001)(38100700002)(6512007)(9686003)(26005)(44832011)(5660300002)(8676002)(41300700001)(8936002)(2906002)(558084003)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0xFMIpypY7PxNJ5ifb3uxtchYxS91aML3SW/00pPd2QEraVrfi4ccU9UAY9S?=
 =?us-ascii?Q?UqdDefKftjMFbWNF2RIOQcgcRtH1HLHL/jPpbokHigDRNdJZYGORwGtcDojf?=
 =?us-ascii?Q?vO9FtQjoMPMW6sOQKueC1Ip4aql23bgnLix39a7pDf2Yy6aO+s56ooxQzWFH?=
 =?us-ascii?Q?x07hb07OMclubTe5iP8pb0LaiZa2toBsUChg737WVnF5Y2jHp1ZEhpY1u5dx?=
 =?us-ascii?Q?w6XMaIpqcqBmTgF6sx4SZOhv7bwDr39RyryPRJhdN0cHRh6ErbnT09KdCWpd?=
 =?us-ascii?Q?7ly4MUrIHomK75tcSuw5LHt5+55AHI1lRoTE9N1Q2gyX8tS8jquQriNCc1mO?=
 =?us-ascii?Q?ZvvOXhdckz8goG66e5K/l73gXVYPueUUZSmZGqTIA3/QjiUeupQrcdhThkXD?=
 =?us-ascii?Q?kar4MVFdbAks4jE0W0IGh8u3npyW8KZV+ooQLiQAu9PPU784DtRB/Beik/2p?=
 =?us-ascii?Q?uMxoaLWEq8nAuaB+UU9zgg/u/ls7aAd50wb5rkpA1swmk8hFG4yf6z+Dpmub?=
 =?us-ascii?Q?W6pxEJ6eSbUOCNUn3rUkiiY1UuGeXYnvrKK0Icv1HEq6fKjcRZd5AP8Me6kB?=
 =?us-ascii?Q?KMG7dWnRIzbzvXnIB5EZA6PuXCPhG0gmVGTHPlpSgabGI1/ui96PsU3xCiuO?=
 =?us-ascii?Q?v8ZWVyg48POr8u4+y/NfkZA+Q/eQI5qhiquWJTNZPCL1FtBMPWsPTQ+p+ReM?=
 =?us-ascii?Q?nBNPuFW8xXzJnE0aJtVZtrDOOuYBme4VzfrmLl9j6NPsTe17DcFz00yYGBIh?=
 =?us-ascii?Q?qLKQMQnGldYyBlzoC6UohugxhLMnICdJM1xK3wVTQ+eX8Prvn3IV8rwPLM/0?=
 =?us-ascii?Q?ogH3lLbhdVFYKaT0YBYc7YVVjtnhAZ4HcGzy2Nz4kFW1JQKORIUQmmIP4F1v?=
 =?us-ascii?Q?2qd1S7IDn+90LFsskeDoVwLItH6PU5YlIy9KSz9hoY648Wbuz0dlZWqEv0kc?=
 =?us-ascii?Q?quC34vK6nA6uSGs1nv62F98ylhZmf0Gl0yPcloL3RpkWuBX2wspKatDd98ya?=
 =?us-ascii?Q?7VNcgoNYJfVE5JFfoYOYjFfYLYtzCif4CD7PGmCfnjZgnwH+wvKURfe0db3H?=
 =?us-ascii?Q?O1Ju2ANWH+CWgUwHV6RtutEXPN8c8NZllkVU9abww1VQ7G2sCNcgkONm5qPI?=
 =?us-ascii?Q?MttExlbEhuwL1LpDAC6nF9WSXqqGq3O2MCthARaN5iF/fpWRH8ZV7VUqM397?=
 =?us-ascii?Q?N7PYp3WW2F+YAKu8b94YE+H09+yfwvwBhiYQFbBHSp45BrMTIFBI2cF+QtiX?=
 =?us-ascii?Q?68esOx+XtEKu91eVRkF9UR51FgKkGiFgEgBpNkBQT4Ou8WcFPupCw9sVjpeR?=
 =?us-ascii?Q?KMFA2Fuo4dSEu/JsGD6OHeh1rDfr3gZB5U4/CIe+7hTS+qj2Vjl33gxlhX3I?=
 =?us-ascii?Q?IQJUI5x+dqzhWWlvaPVgp6OsZzSsPWGqqAej9NIosT1rQTQSZmtBDBw3hOFx?=
 =?us-ascii?Q?xoC+pBitrfIiDOtGrA9cXRrlhzNBQuirK739c22eQzApyHNS8KYzN2/WJpOX?=
 =?us-ascii?Q?wG9qt7v6zZ/8xD+JRVohy2ZMsn0CdgaI9aof9jJ1KuLridHuEbcHqRjOKPHp?=
 =?us-ascii?Q?yF6fLigyg3Iy4brpPU04Ek6jN8lDFi7zv17nA05g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a529928-50b9-4395-53f0-08db8a096c31
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5995.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 16:42:07.9349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vMTc+AWc09Lpu/NeLgCzN7/bfWq2dUPmj05rA7m57ldcHgEF5yvimUQqyo9Cgme1KB0ffedkpui4susMJjK5Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9122
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 05:49:42PM +0200, Borislav Petkov wrote:
> Remove stable@.
> 
> This below seems to work here on a couple of machines.
> 
> Can you run it too pls to confirm?
> 
> Thx.

Yes, this appears to be working on my machine as well.

Tested-by: John Allen <john.allen@amd.com>
