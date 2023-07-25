Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55010762336
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbjGYUX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjGYUX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:23:26 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2103.outbound.protection.outlook.com [40.107.95.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C6110F7;
        Tue, 25 Jul 2023 13:23:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTZYcswIRPxGU7SMNYqX8poC+lpFVOIxEqwZnfrYmbC49fRAEf5a+fqkM8uaU89u/ukV6LQuDOXTLRZQCVfM0qWlbSELfOgq8EBaLY1Kc2IY57GI28Ne4iAMKvdI/WmTBibqQALMnrQU3go/LgQpBq3PgfYm1eKjd3QspkAPHkgJwHnSGDv5d0LlC6HlhxkXMpoRs2LG4dlt7jpBwNWddlmPP/X+ZtA3cttQhDBIbgeNSejjUOV0FdQmo4xaRx9ogeSa2gt9rNZjl2ANHVm0BlEB92mBGZWS65uRUm/m2y5T4o5sizFJLkGVOOEVMCT9EHai/e9foJ23E5B+gXWuLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLvJ/N5y9ZdO9bX9ogAHOyz9iCkrsuKTKIqDil3FdZY=;
 b=WqaExHg0THYVeaeTX3nlZgC/Lgup+v5oBZyg579m9/94XV0sJAZtHFYGyapTZJm+IL4rwPSk5/v0cf2UXQj9n0YpBvzuuUiEZorCLg3dZySn8oOyWJKuYtCerx716QbSZIQvWYombD0i1Nv7kxYt5rP/0uzOUtHzZQQsg57QAlX5SvLbcRGbNacTWgVb7hLqVuZm/O+AvQHDJSFkU37MqswSoG9zLG3yjOt/VRajpuhZ44Jg8KgFS5ybwXkyNbxvhHZYHFSlwXig7+jfebeRF0aleloRDqLttS2C+rEAYL4NreGBPlh+UgkZZW7VIQyITR9RAxCxo+uSz7q/M7aiTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLvJ/N5y9ZdO9bX9ogAHOyz9iCkrsuKTKIqDil3FdZY=;
 b=s6ZstnW9V9tcdAnBj7/BFF1w5U50v11eGWUIRhEYItcsOMlS2JwHtITj3mQsogvje59jsfpoWCygLVz3IZZ3Xxed6PLcEyYf6AgsC+O+5n5TzU6oHdDckTNFTl0rdXsbhcNPguHkykgfoZ60PnbF5kPPgnItxDKhyn58+g4cpzg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by BY3PR13MB4996.namprd13.prod.outlook.com (2603:10b6:a03:356::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Tue, 25 Jul
 2023 20:23:20 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 20:23:20 +0000
Date:   Tue, 25 Jul 2023 22:23:11 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Dmitry Safonov <dima@arista.com>
Cc:     David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Bob Gilligan <gilligan@arista.com>,
        Dan Carpenter <error27@gmail.com>,
        David Laight <David.Laight@aculab.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Donald Cassidy <dcassidy@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Francesco Ruggeri <fruggeri05@gmail.com>,
        "Gaillardetz, Dominik" <dgaillar@ciena.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Ivan Delalande <colona@arista.com>,
        Leonard Crestez <cdleonard@gmail.com>,
        Salam Noureddine <noureddine@arista.com>,
        "Tetreault, Francois" <ftetreau@ciena.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v8.1 net-next 06/23] net/tcp: Add TCP-AO sign to outgoing
 packets
Message-ID: <ZMAvL+9gMIozLbpB@corigine.com>
References: <20230721161916.542667-1-dima@arista.com>
 <20230721161916.542667-7-dima@arista.com>
 <ZMAAPBKnnrdk/c9K@corigine.com>
 <b01a63a7-eaaa-85db-b04d-8270e82e1080@arista.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b01a63a7-eaaa-85db-b04d-8270e82e1080@arista.com>
X-ClientProxiedBy: AM4PR0302CA0028.eurprd03.prod.outlook.com
 (2603:10a6:205:2::41) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|BY3PR13MB4996:EE_
X-MS-Office365-Filtering-Correlation-Id: d8a0879c-50d0-4858-5a4f-08db8d4cfce5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qz734RLN9RYOzICcHKqmFwH2DSWLVcngQN8vuq90XXUk/c6UE5TUnVHsG+Nkbl/rdJGZaZIq6AtAe3iQFe4g609hCLEOCDX6Xzvl3cRFABUxkEGpDsO4tngfcMytsNrNp+C+YX853tOqtdNgGw5dlYxAi4ieRdOYOGJQz2kBgtdoApSVzji6hCxxW3CheEv6nwmo3GbHxG9fPpkHCOAJc6zbHoEnudOhN5FWdUSqZ1ZUgM6Q3Xxv/FBQO+BatlRDvw2BktxiT6ZiSny0k6S1uwYn2DmftY+8WDeUkmLJrji+RNYJSmJaJtdbsl2ejm6sY4yI88jhuc63Mth3Sz6aduDEtHSl9u0lMP2CReyXUVK8etF2USDGtIYw5K806CWoMw1sjPtmXpNSpv7SQom6vnF1yhv+TICqiPHgJPc7dz9iI2XhcAFD3z35JSF5dXiibcb7tPkvTmMROVCfsYJ5So6ZzgNI6XJ8NiXi01aSv1C4UKv9tE69igTRYrHo5/AG5knNXekaPP50Bsv7yy2FMzgAcFUeCA42fEMr/k6u2ckp76VQjqvJansPybc34q7KTGYT6dCkQoIObjzuEcDSjPw1dtsOF4ZjpVn504U/w/CAWMt4YzxsVe8Bcphmkx07wzENEVzgyxIKb9XKY5Wlj6lxZ8uNKkv3SxX5ZMQWPck=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(396003)(39840400004)(346002)(451199021)(6512007)(6486002)(478600001)(6666004)(54906003)(83380400001)(86362001)(4326008)(186003)(2616005)(6506007)(7416002)(2906002)(4744005)(36756003)(38100700002)(66946007)(44832011)(66556008)(5660300002)(41300700001)(8936002)(66476007)(6916009)(316002)(8676002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qjyZibuBCb2KiTHUJJNpU2hTum6PAe+0o5/wtyTZGMxXdmXQU1Ytqb8DnaKv?=
 =?us-ascii?Q?DOsfEzxiXSRot/fOWmCeDUI7L+GJDMD+fRYWaDp3kROUnyioza52S21ygzF7?=
 =?us-ascii?Q?1hiNCjvRli3Ox8h+FqMePQcZ4M6xB8tiVdUhGPrjcoYT1BsLWYop/o4TVCBK?=
 =?us-ascii?Q?g8Bl23qdin3tGHbGPqaT/4arDW2bgQW6Kq33NeqCKUpsEYbMzmvJQ9KcnokJ?=
 =?us-ascii?Q?amAEPj4ACEiCH3sl2ABPTt0Qy5JiMzRryg9Q+LIm5R2ZtZSL//nogAP3GPrx?=
 =?us-ascii?Q?+R1fTt9ntAg5YeKo5kw3dttoLzaVFScuDUlFdS5noksDpOPdNi00xqptd+JU?=
 =?us-ascii?Q?iQBcb9WHqotXhfAkIwpaDgZ65oIwzEhhKYLzU74KAfEcTn3PSgxi//l70W03?=
 =?us-ascii?Q?KphPgEQUvUiZMUSpNaycEnAGTl7h0vmU+6kPwpkdLzhqfM9ENoZY4UnWl6z0?=
 =?us-ascii?Q?wI85IvYzBw42g1eD9rYnMUwGxke/PULyt+nUV8YByeCMao0s4wEONEmwVnWt?=
 =?us-ascii?Q?1OMJ68KtkoEtvGTiOgRNON0iGlBuiy+3LVdzy8k/vg0BycpWa4+qRMUMjg3j?=
 =?us-ascii?Q?cyrlyC9OZe/BDguPMA8irUhO94VckeEVuhM9UYBsf1rWPSojKyyHc2Vzb5lS?=
 =?us-ascii?Q?zvHxOuSY9wR2V+7pcDYuDslxguLKLs+Yx2+G28mr1588Ci1jyKjO1pi5E4iI?=
 =?us-ascii?Q?LvrUxVnX/rg9ksB8JYy1GecvjCq+qduRU5uUL7gb0mMvuoiiIVWKUB2KCnO3?=
 =?us-ascii?Q?RvekM3fr8GkqzQLvL9K+M1awMjg7fSFrK4a3fqwJc21i6TlDbSaAizH+Y805?=
 =?us-ascii?Q?aNB/d6ZUp3oEDp74kCSC1lHlrq3fVBToHz89izrDnHw8epEuZgfv5ekNd/fk?=
 =?us-ascii?Q?MgDAM2oWSf8EcyP5eqedmoSDKB9ZtPeIuuXt4tI4lPhmRWhnOcm0cbvYw8hV?=
 =?us-ascii?Q?/ltQ7pZbxmWIZsiy/8CuH63w9ATXe/oywa3yAPBnkN2uy5YMjOEBoq6XOvWk?=
 =?us-ascii?Q?SvuQLJ3pGrNgkFjpIfOPqVKmi3mRnXke2xGuz6dIIou3WwuXdNhpUHI4Pt9o?=
 =?us-ascii?Q?cPQ/DXw+ORUsUdtNKLn0zx3zT8TiVJFHnmK97zF2dieJH86DoM28hXhu9ZCo?=
 =?us-ascii?Q?AO5H/wvmPqDKdoMwrq7WfbJpqSKxK8KaE/D5eEABdaQa/Vv2WkRCaEmteSco?=
 =?us-ascii?Q?uDgM/uE1sMfaQevILCO0IzcXnOObUN171W8GacTSsUQ50P7x5XiEtzmJ5Jej?=
 =?us-ascii?Q?mSKRS5iB5Ww4nPGhnKApX3bGpUXmPXnuVgMM+0tnR8ocmroq7vFoWLQBL9wK?=
 =?us-ascii?Q?unVA87btk7QJuroizqEXlUd/+lEPMg9HOgKEldj2kRW/rPOTK9TRLeS0hL/G?=
 =?us-ascii?Q?OZ0wxK62AC3kuXWh9j4LN0fpS4THBd3J7aNzsG5KKU+pGtrDCF6hLMSb14n9?=
 =?us-ascii?Q?9CpyWc+e8RJteOj9N9psgl4WD8JsMBtTDSbbiHyhBL8zHbqikzqH5HfPuk/u?=
 =?us-ascii?Q?iTN2Eh0w/CA0GyTViyHnFe9uxMYIMYADK3C6D70dbOTY6hhg9Lgfm6Y3vQH0?=
 =?us-ascii?Q?dxkKbckTwDUJu6jWUeAFbPLIs7BUSMVmn10g/92jxDNSe2O1Vo0sU5std18o?=
 =?us-ascii?Q?gkw/qC0grHv7Ky+zxCNSN07z7fF7Y0MkSZdssitCt1xosJC8JoDlVahi3RIK?=
 =?us-ascii?Q?VGGSPA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8a0879c-50d0-4858-5a4f-08db8d4cfce5
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 20:23:20.4683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RevKSZqchaRlGKBWK/UGaZA/DA+9ZgD1SZ9P+WO6g59LeYTz4OSPy8iDkIq1Le4zcZUpNDxAzp6XL/jqKQ13xy54Tu8lpMfYPkVMcVcUwg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR13MB4996
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 08:10:21PM +0100, Dmitry Safonov wrote:

...

> > 
> >> +		struct tcp_ao_key *rnext_key;
> >> +		struct tcp_ao_info *ao_info;
> >> +		u8 maclen;
> >>  
> >> +		if (WARN_ON_ONCE(!ao_key))
> >> +			goto out_ao;
> >> +		ao_info = rcu_dereference_check(tp->ao_info,
> >> +				lockdep_sock_is_held(&tp->inet_conn.icsk_inet.sk));
> > 
> > Checkpatch complains about indentation here.
> > 
> > Rather than point out each case in the series,
> > could I ask you to run ./scripts/checkpatch.pl --strict over the patchset?
> 
> Yeah, but then it won't fit 80 columns here. As both aren't hard
> requirements I tend to comply with 80 columns more than to indentation.
> In this particular case I'll check if it could be a helper function.
> If it won't make sense to separate it as a helper, I'll just move it to
> the same line than, breaking 80 columns limit.

Thanks, I missed the 80 column thing here.
I'd actually think that what you have is better than an extra long line.
But it's your call.

...
