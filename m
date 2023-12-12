Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BF580F9D6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377607AbjLLV4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:56:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbjLLV4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:56:51 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC431AF;
        Tue, 12 Dec 2023 13:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702418217; x=1733954217;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=Gh93sViFHVdzjllxczkXV8jMpE91NJ3hBl3NA1Ci+MM=;
  b=mXIJEULdjHYXtxEUzLqsHXkiNas5jJZkWos3McHcYpvXqtYsY0slESK0
   2hru4REOinjPQweO2JAOYF0v2sN5qfEM8G6nvhpwXSbaU3ZMuze4EyZSS
   aa2hyMm6bIHU5kTvnrL4jicrQY8Tc5hap9r9c14tYZyhKWRv/GE+7lQ8f
   oSWDwFj7lG14JfGXgBZHEMKUDhfpsvGHbrdmlHNt/YIfxTgOz9nEIrijH
   WCuTkOIY/jScEahRF0PTVw1s1074GD02RI2YRfDWpQqAvf1MzavtFjiYE
   UaVjAnBmDG+BzBOH0sFIq5ve53clqT4VIJVVl4M3MGI45F+pWkk/DLyf+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="397661337"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="397661337"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 13:56:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10922"; a="897068385"
X-IronPort-AV: E=Sophos;i="6.04,271,1695711600"; 
   d="scan'208";a="897068385"
Received: from rfield-mobl1.amr.corp.intel.com (HELO [10.209.75.26]) ([10.209.75.26])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2023 13:56:57 -0800
Message-ID: <118d0b232f7daffc56db814f90dba7bad266c5ab.camel@linux.intel.com>
Subject: Re: [PATCH] crypto: tcrypt - add script tcrypt_speed_compare.py
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     WangJinchao <wangjinchao@xfusion.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     stone.xulei@xfusion.com
Date:   Tue, 12 Dec 2023 13:56:56 -0800
In-Reply-To: <202312101758+0800-wangjinchao@xfusion.com>
References: <202312101758+0800-wangjinchao@xfusion.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-12-10 at 18:19 +0800, WangJinchao wrote:
> Create a script for comparing tcrypt speed test logs.
> The script will systematically analyze differences item
> by item and provide a summary (average).
> This tool is useful for evaluating the stability of
> cryptographic module algorithms and assisting with
> performance optimization.

I have found that for such comparison, the stability is
dependent on whether we allow the frequency to
float or we pin the frequency.  So in the past when
I use tcrypt, sometimes I have
to pin the frequency of CPU for stable results.

One suggestion I have is for for you to also dump the
frequency governor and P-state info so we know
for the runs being compared, whether they are running
with the same CPU frequency.

Tim=20

>=20
> The script produces comparisons in two scenes:
>=20
> 1. For operations in seconds
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> rfc4106(gcm(aes)) (pcrypt(rfc4106(gcm_base(ctr(aes-generic),ghash-generic=
))
>                          encryption
> -------------------------------------------------------------------------=
--
> bit key | byte blocks | base ops    | new ops     | differ(%)
> 160     | 16          | 60276       | 47081       | -21.89
> 160     | 64          | 55307       | 45430       | -17.86
> 160     | 256         | 53196       | 41391       | -22.19
> 160     | 512         | 45629       | 38511       | -15.6
> 160     | 1024        | 37489       | 44333       | 18.26
> 160     | 1420        | 32963       | 32815       | -0.45
> 160     | 4096        | 18416       | 18356       | -0.33
> 160     | 8192        | 11878       | 10701       | -9.91
> 224     | 16          | 55332       | 56620       | 2.33
> 224     | 64          | 59551       | 55006       | -7.63
> 224     | 256         | 53144       | 49892       | -6.12
> 224     | 512         | 46655       | 44010       | -5.67
> 224     | 1024        | 38379       | 35988       | -6.23
> 224     | 1420        | 33125       | 31529       | -4.82
> 224     | 4096        | 17750       | 17351       | -2.25
> 224     | 8192        | 10213       | 10046       | -1.64
> 288     | 16          | 64662       | 56571       | -12.51
> 288     | 64          | 57780       | 54815       | -5.13
> 288     | 256         | 54679       | 50110       | -8.36
> 288     | 512         | 46895       | 43201       | -7.88
> 288     | 1024        | 36286       | 35860       | -1.17
> 288     | 1420        | 31175       | 32327       | 3.7
> 288     | 4096        | 16686       | 16699       | 0.08
> 288     | 8192        | 9662        | 9548        | -1.18
> -------------------------------------------------------------------------=
--
> average differ(%s)    | total_differ(%)
> -------------------------------------------------------------------------=
--
> -5.60                 | 7.28
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>=20
> 2. For avg cycles of operation
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> rfc4309(ccm(aes)) (rfc4309(ccm_base(ctr(aes-generic),cbcmac(aes-generic))=
))
>                          encryption
> -------------------------------------------------------------------------=
--
> bit key | byte blocks | base ops    | new ops     | differ(%)
> 152     | 16          | 792483      | 801555      | 1.14
> 152     | 64          | 552470      | 557953      | 0.99
> 152     | 256         | 254997      | 260518      | 2.17
> 152     | 512         | 148486      | 153241      | 3.2
> 152     | 1024        | 80925       | 83446       | 3.12
> 152     | 1420        | 59601       | 60999       | 2.35
> 152     | 4096        | 21714       | 22064       | 1.61
> 152     | 8192        | 10984       | 11301       | 2.89
> -------------------------------------------------------------------------=
--
> average differ(%s)    | total_differ(%)
> -------------------------------------------------------------------------=
--
> 2.18                  | -1.53
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>=20
> Signed-off-by: WangJinchao <wangjinchao@xfusion.com>
> ---
>  MAINTAINERS                                 |   5 +
>  tools/crypto/tcrypt/tcrypt_speed_compare.py | 179 ++++++++++++++++++++
>  2 files changed, 184 insertions(+)
>  create mode 100755 tools/crypto/tcrypt/tcrypt_speed_compare.py
>=20
> To: Daniel Jordan <daniel.m.jordan@oracle.com>
> After spending a considerable amount of time analyzing and=20
> benchmarking, I've found that although my approach could simplify
> the code logic, it leads to a performance decrease. Therefore,
> I have decided to abandon the code optimization effort.
> During the performance comparison, I utilized the Python script
> from this commit and found it to be valuable.
> Despite not optimizing padata, I would like to share this tool,
> which is helpful for analyzing cryptographic performance,=20
> for the benefit of others.
>=20
> Additionally, thank you for your assistance throughout this process.
>=20
> To: Steffen Klassert <steffen.klassert@secunet.com>
> Thank you for providing the testing method. Based on the approach
> you suggested, I conducted performance comparisons for padata.
> You were correct; the scheduling overhead is significant compared
> to 'parallel()' calls. During profiling, approximately 80% of the
> time was spent on operations related to 'queue_work_on' and locks.
>=20
> Furthermore, I observed a substantial number of 'pcrypt(pcrypt(...'
> structures during multiple 'modprobe' runs for pcrypt.
> To address this, I adjusted the testing procedure by removing the
> pcrypt module before each test, as indicated in the comments of this comm=
it.
>=20
> In summary, I appreciate your guidance. This serves as a conclusion
> to my attempt at modifying padata, which I have decided to abandon.
>=20
> Thank you
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a0fb0df07b43..5690ab99f107 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5535,6 +5535,11 @@ F:	include/crypto/
>  F:	include/linux/crypto*
>  F:	lib/crypto/
> =20
> +CRYPTO SPEED TEST COMPARE
> +M:	WangJinchao <wangjinchao@xfusion.com>
> +L:	linux-crypto@vger.kernel.org
> +F:	tools/crypto/tcrypt/tcrypt_speed_compare.py
> +
>  CRYPTOGRAPHIC RANDOM NUMBER GENERATOR
>  M:	Neil Horman <nhorman@tuxdriver.com>
>  L:	linux-crypto@vger.kernel.org
> diff --git a/tools/crypto/tcrypt/tcrypt_speed_compare.py b/tools/crypto/t=
crypt/tcrypt_speed_compare.py
> new file mode 100755
> index 000000000000..789d24013d8e
> --- /dev/null
> +++ b/tools/crypto/tcrypt/tcrypt_speed_compare.py
> @@ -0,0 +1,179 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) xFusion Digital Technologies Co., Ltd., 2023
> +#
> +# Author: WangJinchao <wangjinchao@xfusion.com>
> +#
> +"""
> +A tool for comparing tcrypt speed test logs.
> +
> +Both support test for operations in one second and cycles of operation
> +for example, use it in bellow bash script
> +
> +```bash
> +#!/bin/bash
> +
> +seq_num=3D1
> +sec=3D1
> +num_mb=3D8
> +mode=3D211
> +
> +# base speed test
> +lsmod | grep pcrypt && modprobe -r pcrypt
> +dmesg -C
> +modprobe tcrypt alg=3D"pcrypt(rfc4106(gcm(aes)))" type=3D3
> +modprobe tcrypt mode=3D${mode} sec=3D${sec} num_mb=3D${num_mb}
> +dmesg > ${seq_num}_base_dmesg.log
> +
> +# new speed test
> +lsmod | grep pcrypt && modprobe -r pcrypt
> +dmesg -C
> +modprobe tcrypt alg=3D"pcrypt(rfc4106(gcm(aes)))" type=3D3
> +modprobe tcrypt mode=3D${mode} sec=3D${sec} num_mb=3D${num_mb}
> +dmesg > ${seq_num}_new_dmesg.log
> +lsmod | grep pcrypt && modprobe -r pcrypt
> +
> +./tcrypt_speed_compare.py ${seq_num}_base_dmesg.log ${seq_num}_new_dmesg=
.log  >${seq_num}_compare.log
> +grep 'average' -A2 -B0 --group-separator=3D"" ${seq_num}_compare.log
> +```
> +"""
> +
> +import sys
> +import re
> +
> +
> +def parse_title(line):
> +    pattern =3D r'tcrypt: testing speed of (.*?) (encryption|decryption)=
'
> +    match =3D re.search(pattern, line)
> +    if match:
> +        alg =3D match.group(1)
> +        op =3D match.group(2)
> +        return alg, op
> +    else:
> +        return "", ""
> +
> +
> +def parse_item(line):
> +    pattern_operations =3D r'\((\d+) bit key, (\d+) byte blocks\): (\d+)=
 operations'
> +    pattern_cycles =3D r'\((\d+) bit key, (\d+) byte blocks\): 1 operati=
on in (\d+) cycles'
> +    match =3D re.search(pattern_operations, line)
> +    if match:
> +        res =3D {
> +            "bit_key": int(match.group(1)),
> +            "byte_blocks": int(match.group(2)),
> +            "operations": int(match.group(3)),
> +        }
> +        return res
> +
> +    match =3D re.search(pattern_cycles, line)
> +    if match:
> +        res =3D {
> +            "bit_key": int(match.group(1)),
> +            "byte_blocks": int(match.group(2)),
> +            "cycles": int(match.group(3)),
> +        }
> +        return res
> +
> +    return None
> +
> +
> +def parse(filepath):
> +    result =3D {}
> +    alg, op =3D "", ""
> +    with open(filepath, 'r') as file:
> +        for line in file:
> +            if not line:
> +                continue
> +            _alg, _op =3D parse_title(line)
> +            if _alg:
> +                alg, op =3D _alg, _op
> +                if alg not in result:
> +                    result[alg] =3D {}
> +                if op not in result[alg]:
> +                    result[alg][op] =3D []
> +                continue
> +            parsed_result =3D parse_item(line)
> +            if parsed_result:
> +                result[alg][op].append(parsed_result)
> +    return result
> +
> +
> +def merge(base, new):
> +    merged =3D {}
> +    for alg in base.keys():
> +        merged[alg] =3D {}
> +        for op in base[alg].keys():
> +            if op not in merged[alg]:
> +                merged[alg][op] =3D []
> +            for index in range(len(base[alg][op])):
> +                merged_item =3D {
> +                    "bit_key": base[alg][op][index]["bit_key"],
> +                    "byte_blocks": base[alg][op][index]["byte_blocks"],
> +                }
> +                if "operations" in base[alg][op][index].keys():
> +                    merged_item["base_ops"] =3D base[alg][op][index]["op=
erations"]
> +                    merged_item["new_ops"] =3D new[alg][op][index]["oper=
ations"]
> +                else:
> +                    merged_item["base_cycles"] =3D base[alg][op][index][=
"cycles"]
> +                    merged_item["new_cycles"] =3D new[alg][op][index]["c=
ycles"]
> +
> +                merged[alg][op].append(merged_item)
> +    return merged
> +
> +
> +def format(merged):
> +    for alg in merged.keys():
> +        for op in merged[alg].keys():
> +            base_sum =3D 0
> +            new_sum =3D 0
> +            differ_sum =3D 0
> +            differ_cnt =3D 0
> +            print()
> +            hlen =3D 80
> +            print("=3D"*hlen)
> +            print(f"{alg}")
> +            print(f"{' '*(len(alg)//3) + op}")
> +            print("-"*hlen)
> +            key =3D ""
> +            if "base_ops" in merged[alg][op][0]:
> +                key =3D "ops"
> +                print(f"bit key | byte blocks | base ops    | new ops   =
  | differ(%)")
> +            else:
> +                key =3D "cycles"
> +                print(f"bit key | byte blocks | base cycles | new cycles=
  | differ(%)")
> +            for index in range(len(merged[alg][op])):
> +                item =3D merged[alg][op][index]
> +                base_cnt =3D item[f"base_{key}"]
> +                new_cnt =3D item[f"new_{key}"]
> +                base_sum +=3D base_cnt
> +                new_sum +=3D new_cnt
> +                differ =3D round((new_cnt - base_cnt)*100/base_cnt, 2)
> +                differ_sum +=3D differ
> +                differ_cnt +=3D 1
> +                bit_key =3D item["bit_key"]
> +                byte_blocks =3D item["byte_blocks"]
> +                print(
> +                    f"{bit_key:<7} | {byte_blocks:<11} | {base_cnt:<11} =
| {new_cnt:<11} | {differ:<8}")
> +            average_speed_up =3D "{:.2f}".format(differ_sum/differ_cnt)
> +            ops_total_speed_up =3D "{:.2f}".format(
> +                (base_sum - new_sum) * 100 / base_sum)
> +            print('-'*hlen)
> +            print(f"average differ(%s)    | total_differ(%)")
> +            print('-'*hlen)
> +            print(f"{average_speed_up:<21} | {ops_total_speed_up:<10}")
> +            print('=3D'*hlen)
> +
> +
> +def main(base_log, new_log):
> +    base =3D parse(base_log)
> +    new =3D parse(new_log)
> +    merged =3D merge(base, new)
> +    format(merged)
> +
> +
> +if __name__ =3D=3D "__main__":
> +    if len(sys.argv) !=3D 3:
> +        print(f"usage: {sys.argv[0]} base_log new_log")
> +        exit(-1)
> +    main(sys.argv[1], sys.argv[2])

