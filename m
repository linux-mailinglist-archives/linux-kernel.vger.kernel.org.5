Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011F17929E7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354491AbjIEQ3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354285AbjIEKcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 06:32:33 -0400
Received: from DM4PR02CU002.outbound.protection.outlook.com (mail-centralusazon11013010.outbound.protection.outlook.com [52.101.64.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC68E8;
        Tue,  5 Sep 2023 03:32:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ACCHRYc+iDsJYCNdGwy3/KVB37Ye748f7pcDVX3XJma4Q3Ybi+geGVQ8lojWKmqZ9xpx1L+pVM1UQNstoETykDUYjXtJ4i1/Pi57VxFXTH0MaXTymlKs4F8Nl1uM1a6iL2+bUGn6h7d5cXIP545sVEJJ8UpMGXB8g0+v6BsuWvwntNz2ig9nnbfsAoTRgYEC5R66jwTOmcGQI777M7iDfCj54YTJM3LBQ+3JVXQN1l/tQuMxmoN/4pyYeb1lrbbrWmJKm7Yp16EmG1hvbm5DCaUofBnNxtvH6RCU3vOwp4NgFws2CAdD/gwtisR8oFHLIrCPuzpT7UsEuPGcAdLPjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJtsLzFUri30flZgdZ+GkOTnOGdk6nheJOH4X+T7L1I=;
 b=V7Yf6ad//Yyj30T0RmqL3sZefCaWmSWNEBjHHBnS7v40TZiwudvEzvYk+c38BCnQursaD8wPIiGkpJ7QJS2E+YIafgtjzXMbC7jc0YU3yjkR9VA0gTuxEvo87rkebbxX1ITMtTzB0nDVQKwud8ZSH3rYbJ1ZPHmmF8Z2GA+4eYq9gm5dgxWGsYVDqn9EHOfTvKnWWb22IqHBjabnGO0zhbpNqLKWLcK17MrNI/ah8h5Qib9oMrgvX14QFAqvzCzamd4M5qlBP8FtkkNPGKC76jeQ7YTwZ0f97VCb2LbTuQW8KEA3I85tbAh/HuZ5qujY6KkCgj+AnQWIm++Y2QP4PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJtsLzFUri30flZgdZ+GkOTnOGdk6nheJOH4X+T7L1I=;
 b=In1ne7YiRBDf7T36W2C4i05D7I/0ZLz8uqM2DUjxrwUSTxBnmtYOBZ9yXr72K87To9Nzs1NBrSllkvDhtzQf9Lf1nefT4/nDYAzDAzhuOgIgywOPp0rjpLGH5pOwj38O+DPSdbjv75ftFDvk1mFYZP436Qh7SQPGQK73VFmA1nU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from BYAPR05MB4982.namprd05.prod.outlook.com (2603:10b6:a03:a3::31)
 by CH3PR05MB10314.namprd05.prod.outlook.com (2603:10b6:610:196::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Tue, 5 Sep
 2023 10:32:26 +0000
Received: from BYAPR05MB4982.namprd05.prod.outlook.com
 ([fe80::c1f7:4ed:2680:f088]) by BYAPR05MB4982.namprd05.prod.outlook.com
 ([fe80::c1f7:4ed:2680:f088%4]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 10:32:26 +0000
Date:   Tue, 5 Sep 2023 10:32:17 +0000
From:   Quan Tian <qtian@vmware.com>
To:     Eric Dumazet <edumazet@google.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lars Ekman <uablrek@gmail.com>, Quan Tian <qtian@vmware.com>
Subject: Re: [PATCH net] net/ipv6: SKB symmetric hash should incorporate
 transport ports
Message-ID: <20230905103217.GA3087913@bm02>
References: <20230904154042.3081190-1-qtian@vmware.com>
 <CANn89iKpj81ZJSn3ksS_P7EBwRjbbk=TnvOW8YF=ogHo5TXcwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKpj81ZJSn3ksS_P7EBwRjbbk=TnvOW8YF=ogHo5TXcwQ@mail.gmail.com>
X-ClientProxiedBy: SJ0PR03CA0105.namprd03.prod.outlook.com
 (2603:10b6:a03:333::20) To BYAPR05MB4982.namprd05.prod.outlook.com
 (2603:10b6:a03:a3::31)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR05MB4982:EE_|CH3PR05MB10314:EE_
X-MS-Office365-Filtering-Correlation-Id: 04e32721-675f-4c84-63b4-08dbadfb65db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bbF0BmttW9Vlx7vkgQ9UrH6rGGfCcfETnSAi7VUUKp8tnxhiIzW92UtZxpNxFTnZNYutZPRtIKxx31Yf+0yYwTHsrxxt9+zZBpfB8tuNTmItVHrG5JMSnGuGz15eCJz8URHvuKH0pfDMD1FJhHtYdnTm2Q+yIrRrnQ//MUWKmAa8Dh68OPeAXS7iOdmQcbvPP0NYRSQAPLH0lSAktd4798TZ2VVRxlt3UtFZFABN11YP/G/FBzw/hLf8rNGIqwAO5bETsyCQVc2Eq9kEmI9F3E4+ptQ7zPcqcheh1Y8G1IE7J2zUSkRHV9DHq+cEZB7U2r0f9twVK/yKRFY93ikejdO7A9QFgfDio3cPyL4hD4LUyHV1KqGUvgCrVn9gh6GfWC9f6rnRa+Dr1V44jS/sqDBn3Sg4QrmeOO0u0P/chVSYzAG8HEJpJSBBE+RmdPxufHdXB+b6HdnJ2tcdXxX2TZIQJvvkOLvI6MZCeGrfeIObENFZgEUVt53zeEtkT3jSzVYssCbfQjWb6LD0eSxqnIHw4qoqQYa1PDpodawvjfsjJ8D9Og14gLAUhmnKOq8QTrVNB77fKxAxBWPJSCUt/zpxhoZEM3EbY1avJs0UP7E+BmPIurxYEyNNQ094/euH7aySXIFtqyo/gHj+Zmm4PwsFqUfXMWL8YKF2oT6g9MDAzIbDaO01JwCCfRC/jHC30lIMY3R6ZAwRs72VAEAFiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR05MB4982.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(346002)(136003)(396003)(366004)(376002)(451199024)(186009)(1800799009)(966005)(8936002)(41300700001)(83380400001)(478600001)(6666004)(2906002)(66946007)(5660300002)(8676002)(6916009)(66476007)(4326008)(66556008)(54906003)(316002)(9686003)(6512007)(52116002)(107886003)(1076003)(26005)(6506007)(6486002)(53546011)(33716001)(66899024)(38350700002)(33656002)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1gwaFhMVGNoK3p0Zml2NGZyZ0hNZEVwS3BDVk5hY1FJYTRLVGgzekNNV3M5?=
 =?utf-8?B?c3UxMVhrRWRmbEl3WityMmpBRnNXcEp1dk9wbTJPeEk1VGVoZU5Qb2FHZGRa?=
 =?utf-8?B?SVllVzdJaVZaenEzVWhzMTRDNW9qMlJBTEFEUlFMQitjTUE4RitnMmtiNGds?=
 =?utf-8?B?VDRQczVpVE9OYXg4WW5NemNFVUVXeDFJUmFOWUZjZVBYQUhqaVBTeG9iSVRX?=
 =?utf-8?B?ckhxM0JnekFWUDZuZ3JDOUpRTEZib1dNUkR5a0k4bWpwUnRoMUdlZlRPdWVj?=
 =?utf-8?B?N0V1NnA1QUk2SHRibUZ5OC9RMGZ1MTcvbjAyb2NZTWhrSGZaQ2xWdG80SjIx?=
 =?utf-8?B?dzRwaUtSYzR1N1gyUUtVSmY3d0tTcHNtZE5RYTZzNmtDNWdYUjVvdGI2bHZX?=
 =?utf-8?B?d3NJWDVYLzhpR2pWUHl0dkZXL3MrVnhQVkhLaGdlMHZjRnFNcWJpK3p5cHgw?=
 =?utf-8?B?aFNITVVjNUY5bEtxdHRqTHdqVmZUMVZqN0JsUlN5TEtZT3ZiYjJJL2swSVRJ?=
 =?utf-8?B?RlNWMWNyQkhCYTVzc25HeU5mN3oycnlqYmJITmk0TTVCRnQ0OXR1Smkvcmpw?=
 =?utf-8?B?ZlhYMjNnV1UvelhTZ2hMaEZBRWE3TVE0VXdPVDFXdjEwMGc2YzFLK0cyREls?=
 =?utf-8?B?MXN3MllxQWU4NVNxRUdPYzhDZitBMDYrUzRVSGZMOUJmZFZ3UG9JamU0blly?=
 =?utf-8?B?dWpvc0JMM2xwQjNEdTZvTFA1OVE3SU9FTlZaRHhaQzZWZlpIQ3ArdGVRYm9H?=
 =?utf-8?B?YTVGbXVmRnFkMS9lN3FJeFBDdzk3bEFOY016WmNUbDVaMStvODFKWCtGKzV3?=
 =?utf-8?B?bVR5aTd5SEt5U2d6K1h1UlRlcDBLNFJua29xMEhRazI5c2ZTdGd3RHI1bmtz?=
 =?utf-8?B?U3puc3FQUWxTTUVlaUdjamY2Zk9HZllpcy9idVpUUHhHZkh6TEhWSzdBYmtR?=
 =?utf-8?B?ZTE1b2s2c24yVFNtK25XbmN0VFIwd1piNEZhZmtwQVErUm1oVjliUFhSN2Ft?=
 =?utf-8?B?bE8zNytITkJ1c0I3OEkya0pyYXg0N1ZsajBWVkF3Tit4TjNIV1VHWWtqZFdC?=
 =?utf-8?B?ZDNuek1pcU5ITlk3bno5NDZnejI0TENXc21LWEV3aUJSd1NmWXRZVkdQVXM4?=
 =?utf-8?B?TUJ1ejd6TldtbEZ6RnhtNTJEdkdpZlZNYUZncnhzZXpWQzhUdnNYVnpLcHZB?=
 =?utf-8?B?U3lVMzQzQXVvTkYvV0JtUzRwRWxsOHZQKzVKcnJMZlVYYmd5WStReXJLaDVG?=
 =?utf-8?B?QzNTUjg5MEMyeW5GZUErSU53eXpYL2Nyd2dERXF0NmFqdHpuamxLRklUQXNI?=
 =?utf-8?B?UUlPbXJtWlhrYk5Vbk9ndlZKZkpadlZYSlB2YjljUVA3eS92VktKdWJVZkZh?=
 =?utf-8?B?VU1zMklXYjAya2dEUmM1VzNBWG5ScGJzZDhsUmZxNlV6ZHVuNjBKbHlxQzk4?=
 =?utf-8?B?anp1b2xLODM0Nm42NnJ6UkI4dnZmMUpha0FSNGhkYjBjRHJPU201VTJrNU03?=
 =?utf-8?B?c0pvdXowZ2Q0TU5PRUM1dUpnZEs0Q1BLVjhsSHRpenNlNS96MXR3VjlNOFM0?=
 =?utf-8?B?V25XZzZtMlJzcmxmeDlPNndvV3BMdHR3MER0Z1B6OUUwNi9pMFFyOTdKOWRB?=
 =?utf-8?B?cWxzT3djekJmNm1RcW56YWJweTkyRUFFVGZnbmYrS2JzL29xMDZScTg0T3Iw?=
 =?utf-8?B?cy9EOVQvWWM2RGZNWDc2OVczek1LbnUrdjVPRzg3UGs1eW81V1M1N1ltTy9U?=
 =?utf-8?B?RTFZdlhiZEo0UVFaZEh5TUVpelp5RWF4aDg1L2VPQ2NSdXYweFJIczFqYzJJ?=
 =?utf-8?B?SnRLSm8rTVQrbXZyZkxwRlAyb1hnU1JmOHNqRFk1R1RYN0xVT3FxMXJWTU1T?=
 =?utf-8?B?U25HMXl3ell5TWFkUlFid3VlbXNjVnJFSjdRdWU1UWJtOXZLWU9lZFlUbHJh?=
 =?utf-8?B?WlFlZ0kxR2MwbWRhY05OdTZFUHdSeWRSaUVVL3RLaHE1VWJpbEN6TXRkTkMz?=
 =?utf-8?B?dWhIaVI4L1ZkbkxycVk4eGFqTDhUbDhJdk9NM2hsZSt2ODBHRkNRdmgvOGU2?=
 =?utf-8?B?cXRTS3hFdW81c0czenM5NzV6RUdPVFdGc3FCWkdXaXc5YXRDRXVMeFZ1WXZk?=
 =?utf-8?Q?eR/qwkjxp/euX4zQgd2s71AdF?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e32721-675f-4c84-63b4-08dbadfb65db
X-MS-Exchange-CrossTenant-AuthSource: BYAPR05MB4982.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 10:32:26.1706
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F4WCQrxm3TKibT2BEKZw+8yRS06EGZK0Camz8ocYLqtJRgguKYEEcDYxk/OE8v8EzvLxc2VlTgSSwggrwiRu6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR05MB10314
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 06:28:24AM +0200, Eric Dumazet wrote:
> On Mon, Sep 4, 2023 at 5:45 PM Quan Tian <qtian@vmware.com> wrote:
> >
> > __skb_get_hash_symmetric() was added to compute a symmetric hash over
> > the protocol, addresses and transport ports, by commit eb70db875671
> > ("packet: Use symmetric hash for PACKET_FANOUT_HASH."). It uses
> > flow_keys_dissector_symmetric_keys as the flow_dissector to incorporate
> > IPv4 addresses, IPv6 addresses and ports. However, it should not specify
> > the flag as FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL, which stops further
> > dissection when an IPv6 flow label is encountered, making transport
> > ports not being incorporated in such case.
> >
> > As a consequence, the symmetric hash is based on 5-tuple for IPv4 but
> > 3-tuple for IPv6 when flow label is present. It caused a few problems,
> > e.g. when nft symhash and openvswitch l4_sym rely on the symmetric hash
> > to perform load balancing as different L4 flows between two given IPv6
> > addresses would always get the same symmetric hash, leading to uneven
> > traffic distribution.
> >
> > Removing the use of FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL makes sure the
> > symmetric hash is based on 5-tuple for both IPv4 and IPv6 consistently.
> >
> > Reported-by: Lars Ekman <uablrek@gmail.com>
> > Closes: https://github.com/antrea-io/antrea/issues/5457
> > Signed-off-by: Quan Tian <qtian@vmware.com>
> > ---
> >  net/core/flow_dissector.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
> > index 89d15ceaf9af..b3b3af0e7844 100644
> > --- a/net/core/flow_dissector.c
> > +++ b/net/core/flow_dissector.c
> > @@ -1831,8 +1831,7 @@ u32 __skb_get_hash_symmetric(const struct sk_buff *skb)
> >
> >         memset(&keys, 0, sizeof(keys));
> >         __skb_flow_dissect(NULL, skb, &flow_keys_dissector_symmetric,
> > -                          &keys, NULL, 0, 0, 0,
> > -                          FLOW_DISSECTOR_F_STOP_AT_FLOW_LABEL);
> > +                          &keys, NULL, 0, 0, 0, 0);
> >
> >         return __flow_hash_from_keys(&keys, &hashrnd);
> >  }
> > --
> > 2.42.0
> >
> 
> Networking patches for net branches must include a Fixes: tag, to help
> automation.
> (providing the sha1 in the changelog is requesting human investigation
> for stable teams,
> because a sha1 could be mentioned even if it is not the bug origin)

Thank you! Will add the tag in the next version.

> 
> Fixes: eb70db875671 ("packet: Use symmetric hash for PACKET_FANOUT_HASH.")
> 
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> 
> Thanks.

Thanks,
Quan
