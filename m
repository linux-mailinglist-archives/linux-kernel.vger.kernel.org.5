Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7C075FFD4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 21:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjGXTbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 15:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjGXTbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 15:31:16 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2119.outbound.protection.outlook.com [40.107.223.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B9110E4;
        Mon, 24 Jul 2023 12:31:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFqgSRx/vOHbfjVggggtbUpg6OtnHVPbAd3XInm0JYwyH+mEqi3HKRyWhlNW1KDkEMUuYSY348wku7VGrIbS+/P5ZsquEOADtl78aH4f7K6qmIR066dk1i7ytv8fBSXVnupm+SwRZZcUG3qyKpG2Q7Qu/LHN4jkRHGMLBcxBFE7+66c3l5FtU46NwwiBftkA+km4y4Sc3B7qJCoYnjxAfBPlUtpEiGi3mQ0PT9xqkP71G5jbVAEtFWP9zkCTpvbkhMt2ycj/S8biCSrs+67tVVf5/9CsYoisvmdtLJKprym2nMbMpRaeI+dZR6JvIPZHnBdKAYvd2vJLFNB9O+oeqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGt8udlgSPHiRgdqQlUSu8k7GB4bnen8tc8u7Sz5rhQ=;
 b=jY9YlRi7eoBdLS5FDLeVSU+5KI2k8aCaE9RWB9XwvaijTUZ7zicHv4pXqkFLIlEVTPHCtPXPtrEOylor1460kNeKXVk9UE3U+0WNVp6WC2l2tSfr2dgzq2tm8lL64O4996+es75uUbbWvWFSk5d4OR7AnztZSMzLqY5gUFDjtpgnBTY9WQtsSkckCjrs/ajn87ws4ioalSuKhnyM6p+Q968pgrt/7sQhwxMaWu2JEHoti+UrHPyOB0j40koUfz/FiBx+OFKkp3niDuXGibTkzi4G+BBKMuH6oq8cHTeUR042BYYtk3NwCCw5CMCW7QVu6EuWnV6nG14UpYEq1El95g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGt8udlgSPHiRgdqQlUSu8k7GB4bnen8tc8u7Sz5rhQ=;
 b=tlVGim/lr4QAKF+rwOXqWT5B0sgo90Nvl3EwNzZGinkpe91WXNypUlioa8PffKy68OYEoxVwKIrMDN+035bWvZGzg51CrsKxEb42ZUmGP6AKLzp5jBsC/nAPb3d2706mlo/3rE3rklZDCvOgvVl6eKjDoS1GfSrZsn6nLWVILfg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by PH7PR13MB6266.namprd13.prod.outlook.com (2603:10b6:510:24d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.29; Mon, 24 Jul
 2023 19:31:10 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 19:31:09 +0000
Date:   Mon, 24 Jul 2023 21:31:00 +0200
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
Subject: Re: [PATCH v8.1 net-next 03/23] net/tcp: Introduce TCP_AO
 setsockopt()s
Message-ID: <ZL7RdEEz2nH/QFqZ@corigine.com>
References: <20230721161916.542667-1-dima@arista.com>
 <20230721161916.542667-4-dima@arista.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230721161916.542667-4-dima@arista.com>
X-ClientProxiedBy: AS4P251CA0021.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::11) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|PH7PR13MB6266:EE_
X-MS-Office365-Filtering-Correlation-Id: 38674c58-894c-440e-bc57-08db8c7c87fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ECV19Q9c4TiGVi0oMTx5B5oiyV/vkEThP5ekToOA3GxxILSGE5l8BN0WTUQmQ7nZluPyvdPWlb/IrEiW2zj0mnV0y3fP1X5MtthNNi4XTH+UDpXbVbMo6Onzeh3Dd+juuefYyrfjx+TTxsoL/AzOtdVWvR0hkU+tWsmm9pEDhpohQQDQgUB/lu9SL+POaQ0EvISDd+Ij0QYZLIDWXUUJNn+IgnXOIdi4p4Duj6vsrd1WJt/vJtJ/trOKBcMsM/ypSMZzUNRq9oosQWpUY8/KCYgQgb2rpzLSHc+l/ufMzTVLcM5/CP6Z0yfjDtkr7szTQq0NYqiIVrZZce77MAanP1DPlMUtU3RHzhYPsY5FaVmv9Xxg2yN+yXLZCIPsqro1lbn72amgby6ZSO3oFXMYjBCldCDaVRrowHiPVuinataQ3jtELHDKOtIZv3vnAvO6o0eqJHM2g19lm3xONAEBgdw1fTrbiKK8fMbFSTcOwO7vhPP6aWJxg0NoL1kt+bnfDeeoCi+H29dj3wZGpNpTFhdROPqYYUm1N10mi6E/9xxSbB9OvA2ClAF/DYOzsGOxqsZlGCa/OSi+LEEGmONRbsUT1SowTGiX3uwJBODLNVY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(346002)(396003)(39840400004)(451199021)(6512007)(6486002)(6666004)(478600001)(54906003)(186003)(2616005)(6506007)(2906002)(44832011)(41300700001)(8676002)(8936002)(66476007)(4326008)(6916009)(66946007)(5660300002)(7416002)(316002)(66556008)(36756003)(38100700002)(86362001)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVFERVhkaDBJQTgxd0lFOVFSQ3R5VGpQTmhIM1N6by9nd0RlQlIxaXAxRG9W?=
 =?utf-8?B?Vy84WlRPc2hlaFczaHh0aEU4TElrdzdua1orYXB3SXFFTURTSEtmMmplZDNt?=
 =?utf-8?B?OEZGVkRvSW9VQ3hIV3g4anA3SVZKb2VEVHVvY3VzcStqT1YxQS9ObGg1MmxD?=
 =?utf-8?B?ZkFWR3p1bVlkWlRMZWpkbnpwdW5SYWE5ckJyZ1Y4YnJ0V1RPVHBvbmxnWUhM?=
 =?utf-8?B?eHg3b1NpVHlVM3JyeG9NVElJeUZXaHovY0cyR3gwYnhkeGhaZC9vakhqZlpo?=
 =?utf-8?B?WUkvc3NocjNzOVhqOUQxU0VEbmJWVGtHMUVPanFRdUx1VU5ld0dMSTNaamhs?=
 =?utf-8?B?TnNnS2hYUGZ0N2VPOEJGM0crY3lBYlpDbmF2R0NuVDFjSGYrUkpmMENRRm5S?=
 =?utf-8?B?VUd0WGlHUGd4VTRtNkVxTEphTHNGMHdEREVDUU1DbzF5TTNSTWIyVTlnZ0NJ?=
 =?utf-8?B?dnNERXdaZmFVWXRxWEtKTExqMlZtWGczaERMMWgwc09JOXdZQ3JLNndiNzgy?=
 =?utf-8?B?cEtxU2xONm9obzhtVER6cGc0eXl4WHcyRmUvbVpkRXZZTkxrbFB2RGdwbUJl?=
 =?utf-8?B?UVlyMW5pc0FFQVV5dmd1MzFqbTU1VE16NGJVaTRTQjAwNmRwcitnd0hXdWl5?=
 =?utf-8?B?SGMrOG1zU25FUlpGb0FnUVZ1TkJ1OTNxem9KaGgrWVk3dDhEd3BOMzF6b3RM?=
 =?utf-8?B?bGRhYmI4bVRwR012M1VXRVRBSGNJb0FUWXI4Wnc2dTZoVXU1ZlZpWGw0VWdx?=
 =?utf-8?B?S0VCNGM2WEE0bTMra3FQZS9USXNZZjFvbnl2TG9OR2NBVmV4NVd3ZTdlU0x5?=
 =?utf-8?B?MUgzL1FrS1RMTFQxY1V3ZFN3YjhUMEJXT3kyUWpGaU9DTUFhTXVKSGRXYmVv?=
 =?utf-8?B?d1hrU2RVUjM2MFJwRHlhcUNGOEhFOHRIMGZkWDlIajlQdUpUdms0UDBrK2k1?=
 =?utf-8?B?NzdGNk5NZmNJYk84bWNteitIVExYcGlZdDQwOVB6TG9nNlZzVlJyN3U3Nmty?=
 =?utf-8?B?Q3dnTnFyY1lMUE16d1hLbWJrL1g2aE1MTWZhblk1dnIxeUpHRU5xQUdFTXQw?=
 =?utf-8?B?VjFja2QyK21oMXU3TU1adVpJU1gvUnNPaTlpYWE0bWs4bUVJMFBQbTNZdUZE?=
 =?utf-8?B?cGZhSjBod0YwL1RCYWU4TE13MDRzRmhGNmJZVURMVllIZnRkUmw0MUpHVlFG?=
 =?utf-8?B?UksvK25Jc3FDN2tQVTUraXkrbDZaMndUVmw5MU5udktMSXdrSFJndGxtcHdm?=
 =?utf-8?B?Q1cyejVPa2w3R2tqaGlYSjZzd1lHWVlSN05jL2dLQjBvK3RHQ29yK2ZiZU9x?=
 =?utf-8?B?M1AvTzRQRm9UdFFSMXE0SVVTNEtGRFNnWEd4NUo4UmxjU2Zwem9rbEFNbnVo?=
 =?utf-8?B?TE5GRTdCbDY3M0ViN1F2WU1tSlFGOGVhRFVUOWV2Y3BqZnhwcVB0SFgwOVJQ?=
 =?utf-8?B?eUkyOEpYT01FYWwwdVVpQm0zUm16cjFTUE5NR2JaS2tmcDc3bEprejM3UU1C?=
 =?utf-8?B?eitrWEFac2h5WUxmcmQzOEJIa0IxZUlYZzBUYk5WTGRtYitsbmxLc3BrQm5x?=
 =?utf-8?B?Q0V0dHJzOFBXaXBNNW14QjROaGpnOGNQdDV5KzAxVVdSVWlnd0JNc1JabnNv?=
 =?utf-8?B?Ui9TL3pIdWk0anhJZDRDUlQrNnc3ckwwK0VsR29nOVFkQjRMaHZsK3dIS0tJ?=
 =?utf-8?B?NHhMMXV4VVRkTEtkR282NGZsSlZJcEJiUWhBWWVuekVsMXdzSU1YcXFHa2tT?=
 =?utf-8?B?d2wyMm50clQzYld5ODRrS2ZaKzRPSjFyVlhsMWsxcXFaaUNtdEIraEVCZG1k?=
 =?utf-8?B?NDZZQ2lRZTFKU09mbXFIcHhTcllWRm1VejUxUUJWeDR0dStIaWRWOVNlMkc4?=
 =?utf-8?B?VWZpVW8rZCtNNWFXeXJRNlo5K1F0dTZRWG94ME9ZbDZxTDhUSjYwOXdpQ0JK?=
 =?utf-8?B?MFNtc3VRaldpcEY3UmlmT2xZc0h5OFM2cEU5NkxKQ1NIc0FXL1owbC9NMXFU?=
 =?utf-8?B?amRDWWZEMDBTNW5mMjYrNmdNZHJiY1ZvUnNyR1RhcFpsdlUrVTRBcnZ6d0t4?=
 =?utf-8?B?WnNBS0hBc3g3b3VneXdMUlljQlRrTnRkVFVCbFlJTU8zNy9lQ25DUW0yRkM0?=
 =?utf-8?B?NVRGcGpKZ1JiZW8vSHVMNi9nSGMzNS9HZ25KQVpXOXgxR3JLZ05ibm9sMUtX?=
 =?utf-8?B?OVhOUFQra2V4SkxuWCt3R0V4dllWaDJwNDFubHhVeWwzNGJoRHVYTVhxdjBU?=
 =?utf-8?B?alRnNE5RcnN5YmVWWTV6K0tsV2t3PT0=?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38674c58-894c-440e-bc57-08db8c7c87fb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 19:31:09.6490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jeuz2FVt6UKcTHDyqpMsnEFHDN+VeDlWiwkSYqwJfIgeGg73c50OCDyqB35MIDTWb3+O4l1VDziNn7JX9IzQVW9fFlgI81Sa+ZNVD6C69b4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR13MB6266
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 05:18:54PM +0100, Dmitry Safonov wrote:

...

Hi Dimitry,

> diff --git a/include/linux/sockptr.h b/include/linux/sockptr.h
> index bae5e2369b4f..307961b41541 100644
> --- a/include/linux/sockptr.h
> +++ b/include/linux/sockptr.h
> @@ -55,6 +55,29 @@ static inline int copy_from_sockptr(void *dst, sockptr_t src, size_t size)
>  	return copy_from_sockptr_offset(dst, src, 0, size);
>  }
>  
> +static inline int copy_struct_from_sockptr(void *dst, size_t ksize,
> +		sockptr_t src, size_t usize)

The indentation of the two lines above is not correct,
they should be aligned to the inside of the opening '('
on the preceding line.

In order to stop things being too far to the left,
which is perhaps the intent of the current indention scheme,
the return type of the function can be moved to it's own line.

static inline int
copy_struct_from_sockptr(void *dst, size_t ksize, sockptr_t src, size_t usize)

...

> diff --git a/include/net/tcp.h b/include/net/tcp.h

...

> +static inline int ipv4_prefix_cmp(const struct in_addr *addr1,
> +				  const struct in_addr *addr2,
> +				  unsigned int prefixlen)
> +{
> +	__be32 mask = inet_make_mask(prefixlen);
> +
> +	if ((addr1->s_addr & mask) == (addr2->s_addr & mask))
> +		return 0;
> +	return ((addr1->s_addr & mask) > (addr2->s_addr & mask)) ? 1 : -1;
> +}

Above, '>' is operating on two big endian values.
But typically such maths operates on host byte order values.

Flagged by Sparse.

...

> +static struct tcp_ao_key *__tcp_ao_do_lookup(const struct sock *sk,
> +		const union tcp_ao_addr *addr, int family, u8 prefix,
> +		int sndid, int rcvid, u16 port)

Same comment about indentation as above.

static struct tcp_ao_key *
__tcp_ao_do_lookup(const struct sock *sk, const union tcp_ao_addr *addr,
		   int family, u8 prefix, int sndid, int rcvid, u16 port)

...

> +struct tcp_ao_key *tcp_ao_do_lookup(const struct sock *sk,
> +				    const union tcp_ao_addr *addr,
> +				    int family, int sndid, int rcvid, u16 port)

Should tcp_ao_do_lookup be static?
It seems to only be used in this file.

...

> +static int tcp_ao_verify_port(struct sock *sk, u16 port)
> +{
> +	struct inet_sock *inet = inet_sk(sk);
> +
> +	if (port != 0) /* FIXME */

I guess this should be fixed :)

> +		return -EINVAL;
> +
> +	/* Check that MKT port is consistent with socket */
> +	if (port != 0 && inet->inet_dport != 0 && port != inet->inet_dport)

port is host byte order, but inet->inet_dport is big endian.
This does not seem correct.

> +		return -EINVAL;
> +
> +	return 0;
> +}

...

> +static int tcp_ao_parse_crypto(struct tcp_ao_add *cmd, struct tcp_ao_key *key)
> +{
> +	unsigned int syn_tcp_option_space;
> +	bool is_kdf_aes_128_cmac = false;
> +	struct crypto_ahash *tfm;
> +	struct tcp_sigpool hp;
> +	void *tmp_key = NULL;
> +	int err;
> +
> +	/* RFC5926, 3.1.1.2. KDF_AES_128_CMAC */
> +	if (!strcmp("cmac(aes128)", cmd->alg_name)) {
> +		strscpy(cmd->alg_name, "cmac(aes)", sizeof(cmd->alg_name));
> +		is_kdf_aes_128_cmac = (cmd->keylen != 16);
> +		tmp_key = kmalloc(cmd->keylen, GFP_KERNEL);
> +		if (!tmp_key)
> +			return -ENOMEM;
> +	}
> +
> +	key->maclen = cmd->maclen ?: 12; /* 12 is the default in RFC5925 */
> +
> +	/* Check: maclen + tcp-ao header <= (MAX_TCP_OPTION_SPACE - mss
> +	 *					- tstamp - wscale - sackperm),
> +	 * see tcp_syn_options(), tcp_synack_options(), commit 33ad798c924b.
> +	 *
> +	 * In order to allow D-SACK with TCP-AO, the header size should be:
> +	 * (MAX_TCP_OPTION_SPACE - TCPOLEN_TSTAMP_ALIGNED
> +	 *			- TCPOLEN_SACK_BASE_ALIGNED
> +	 *			- 2 * TCPOLEN_SACK_PERBLOCK) = 8 (maclen = 4),
> +	 * see tcp_established_options().
> +	 *
> +	 * RFC5925, 2.2:
> +	 * Typical MACs are 96-128 bits (12-16 bytes), but any length
> +	 * that fits in the header of the segment being authenticated
> +	 * is allowed.
> +	 *
> +	 * RFC5925, 7.6:
> +	 * TCP-AO continues to consume 16 bytes in non-SYN segments,
> +	 * leaving a total of 24 bytes for other options, of which
> +	 * the timestamp consumes 10.  This leaves 14 bytes, of which 10
> +	 * are used for a single SACK block. When two SACK blocks are used,
> +	 * such as to handle D-SACK, a smaller TCP-AO MAC would be required
> +	 * to make room for the additional SACK block (i.e., to leave 18
> +	 * bytes for the D-SACK variant of the SACK option) [RFC2883].
> +	 * Note that D-SACK is not supportable in TCP MD5 in the presence
> +	 * of timestamps, because TCP MD5’s MAC length is fixed and too
> +	 * large to leave sufficient option space.
> +	 */
> +	syn_tcp_option_space = MAX_TCP_OPTION_SPACE;
> +	syn_tcp_option_space -= TCPOLEN_TSTAMP_ALIGNED;
> +	syn_tcp_option_space -= TCPOLEN_WSCALE_ALIGNED;
> +	syn_tcp_option_space -= TCPOLEN_SACKPERM_ALIGNED;
> +	if (tcp_ao_len(key) > syn_tcp_option_space) {
> +		err = -EMSGSIZE;
> +		goto err_kfree;
> +	}
> +
> +	key->keylen = cmd->keylen;
> +	memcpy(key->key, cmd->key, cmd->keylen);
> +
> +	err = tcp_sigpool_start(key->tcp_sigpool_id, &hp);
> +	if (err)
> +		goto err_kfree;
> +
> +	tfm = crypto_ahash_reqtfm(hp.req);
> +	if (is_kdf_aes_128_cmac) {
> +		void *scratch = hp.scratch;
> +		struct scatterlist sg;
> +
> +		memcpy(tmp_key, cmd->key, cmd->keylen);
> +		sg_init_one(&sg, tmp_key, cmd->keylen);
> +
> +		/* Using zero-key of 16 bytes as described in RFC5926 */
> +		memset(scratch, 0, 16);
> +		err = crypto_ahash_setkey(tfm, scratch, 16);
> +		if (err)
> +			goto err_pool_end;
> +
> +		err = crypto_ahash_init(hp.req);
> +		if (err)
> +			goto err_pool_end;
> +
> +		ahash_request_set_crypt(hp.req, &sg, key->key, cmd->keylen);
> +		err = crypto_ahash_update(hp.req);
> +		if (err)
> +			goto err_pool_end;
> +
> +		err |= crypto_ahash_final(hp.req);
> +		if (err)
> +			goto err_pool_end;
> +		key->keylen = 16;
> +	}
> +
> +	err = crypto_ahash_setkey(tfm, key->key, key->keylen);
> +	if (err)
> +		goto err_pool_end;
> +
> +	tcp_sigpool_end(&hp);
> +
> +	if (tcp_ao_maclen(key) > key->digest_size)
> +		return -EINVAL;

		tmp_key appears to be leaked here.

> +
> +	return 0;

And here.

This is flagged by Smatch.

> +
> +err_pool_end:
> +	tcp_sigpool_end(&hp);
> +err_kfree:
> +	kfree(tmp_key);
> +	return err;
> +}

...

> +static int tcp_ao_add_cmd(struct sock *sk, unsigned short int family,
> +			  sockptr_t optval, int optlen)
> +{
> +	struct tcp_ao_info *ao_info;
> +	union tcp_ao_addr *addr;
> +	struct tcp_ao_key *key;
> +	struct tcp_ao_add cmd;
> +	int ret;
> +	bool first = false;
> +	u16 port;

Please use reverse xmas tree - longest line to shortest - for
local variable declarations in new Networking code.

...

> +static int tcp_ao_del_cmd(struct sock *sk, unsigned short int family,
> +			  sockptr_t optval, int optlen)
> +{
> +	struct tcp_ao_key *key, *new_current = NULL, *new_rnext = NULL;
> +	struct tcp_ao_info *ao_info;
> +	union tcp_ao_addr *addr;
> +	struct tcp_ao_del cmd;
> +	int err;
> +	__u8 prefix;
> +	__be16 port;
> +	int addr_len;
> +
> +	if (optlen < sizeof(cmd))
> +		return -EINVAL;
> +
> +	err = copy_struct_from_sockptr(&cmd, sizeof(cmd), optval, optlen);
> +	if (err)
> +		return err;
> +
> +	if (cmd.reserved != 0 || cmd.reserved2 != 0)
> +		return -EINVAL;
> +
> +	if (cmd.set_current || cmd.set_rnext) {
> +		if (!tcp_ao_can_set_current_rnext(sk))
> +			return -EINVAL;
> +	}
> +
> +	ao_info = setsockopt_ao_info(sk);
> +	if (IS_ERR(ao_info))
> +		return PTR_ERR(ao_info);
> +	if (!ao_info)
> +		return -ENOENT;
> +
> +	/* For sockets in TCP_CLOSED it's possible set keys that aren't
> +	 * matching the future peer (address/port/VRF/etc),
> +	 * tcp_ao_connect_init() will choose a correct matching MKT
> +	 * if there's any.
> +	 */
> +	if (cmd.set_current) {
> +		new_current = tcp_ao_established_key(ao_info, cmd.current_key, -1);
> +		if (!new_current)
> +			return -ENOENT;
> +	}
> +	if (cmd.set_rnext) {
> +		new_rnext = tcp_ao_established_key(ao_info, -1, cmd.rnext);
> +		if (!new_rnext)
> +			return -ENOENT;
> +	}
> +
> +	if (family == AF_INET) {
> +		struct sockaddr_in *sin = (struct sockaddr_in *)&cmd.addr;
> +
> +		addr = (union tcp_ao_addr *)&sin->sin_addr;
> +		addr_len = sizeof(struct in_addr);
> +		port = ntohs(sin->sin_port);

port is big endian, but here it is assigned a host-byte order value.
It looks like port should be u16 rather than __bbe16.

As flagged by Smatch.

> +	} else {
> +		struct sockaddr_in6 *sin6 = (struct sockaddr_in6 *)&cmd.addr;
> +		struct in6_addr *addr6 = &sin6->sin6_addr;
> +
> +		if (ipv6_addr_v4mapped(addr6)) {
> +			addr = (union tcp_ao_addr *)&addr6->s6_addr32[3];
> +			addr_len = sizeof(struct in_addr);
> +			family = AF_INET;
> +		} else {
> +			addr = (union tcp_ao_addr *)addr6;
> +			addr_len = sizeof(struct in6_addr);
> +		}
> +		port = ntohs(sin6->sin6_port);

Ditto.

> +	}
> +	prefix = cmd.prefix;
> +
> +	/* We could choose random present key here for current/rnext
> +	 * but that's less predictable. Let's be strict and don't
> +	 * allow removing a key that's in use. RFC5925 doesn't
> +	 * specify how-to coordinate key removal, but says:
> +	 * "It is presumed that an MKT affecting a particular
> +	 * connection cannot be destroyed during an active connection"
> +	 */
> +	hlist_for_each_entry_rcu(key, &ao_info->head, node) {
> +		if (cmd.sndid != key->sndid ||
> +		    cmd.rcvid != key->rcvid)
> +			continue;
> +
> +		if (family != key->family ||
> +		    prefix != key->prefixlen ||
o
> +		    port != key->port ||

There is a similar problem here too.
port is host byte order but key->port is big endian.

> +		    memcmp(addr, &key->addr, addr_len))
> +			continue;
> +
> +		if (key == new_current || key == new_rnext)
> +			continue;
> +
> +		return tcp_ao_delete_key(sk, ao_info, key,
> +					  new_current, new_rnext);
> +	}
> +	return -ENOENT;
> +}

...
