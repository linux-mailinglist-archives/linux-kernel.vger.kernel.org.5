Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE42774EB3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 00:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjHHWye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 18:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjHHWyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 18:54:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25A61982;
        Tue,  8 Aug 2023 15:54:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4002C62DEE;
        Tue,  8 Aug 2023 22:54:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC9CC433C8;
        Tue,  8 Aug 2023 22:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691535240;
        bh=S1YyyKsi4PMJ1YeMq4VI9CGk5TcWYpFJDARF/6lAgcE=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=Jztk+FrWloB1ICOuUWZ4Y7ESx72xfy5uLlMPr+puXMbdhni+b8KIQqN5g+ysW6/6X
         ME68n6TIAz/wg9+X8jcmgLhpw/h3LBhGVK6oB8sr+ycCNPcC8NWCb9vlQ0jtD/65LJ
         wC6zjTvNwbuJD3QxjnmSfzsf+qom5hvKeaRSZCSKE9CQq+/7fV3VMC35Wp/FRcKmGj
         8nUPWZ0K6vBv5gsTBzWKhmrrt2XNq5/GkxfOZ1SaUC+oEJtqMZut+hsuVZXEUbTVBr
         3cKkJlyLXdFaxvZoC9bFFqVi1DBfOP98UbOqpSvuAkLcZHtjPxO97TMptuwjKbk65b
         yFRGxwmtDcm5A==
Date:   Tue, 08 Aug 2023 15:53:59 -0700
From:   Kees Cook <kees@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
CC:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Roopa Prabhu <roopa@nvidia.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Kees Cook <keescook@chromium.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, gongruiqi1@huawei.com
Subject: Re: [PATCH v2] netfilter: ebtables: fix fortify warnings
User-Agent: K-9 Mail for Android
In-Reply-To: <ZNJuMoe37L02TP20@work>
References: <20230808133038.771316-1-gongruiqi@huaweicloud.com> <ZNJuMoe37L02TP20@work>
Message-ID: <5E8E0F9C-EE3F-4B0D-B827-DC47397E2A4A@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On August 8, 2023 9:32:50 AM PDT, "Gustavo A=2E R=2E Silva" <gustavoars@ker=
nel=2Eorg> wrote:
>On Tue, Aug 08, 2023 at 09:30:38PM +0800, GONG, Ruiqi wrote:
>> From: "GONG, Ruiqi" <gongruiqi1@huawei=2Ecom>
>>=20
>> When compiling with gcc 13 and CONFIG_FORTIFY_SOURCE=3Dy, the following
>> warning appears:
>>=20
>> In function =E2=80=98fortify_memcpy_chk=E2=80=99,
>>     inlined from =E2=80=98size_entry_mwt=E2=80=99 at net/bridge/netfilt=
er/ebtables=2Ec:2118:2:
>> =2E/include/linux/fortify-string=2Eh:592:25: error: call to =E2=80=98__=
read_overflow2_field=E2=80=99
>> declared with attribute warning: detected read beyond size of field (2n=
d parameter);
>> maybe use struct_group()? [-Werror=3Dattribute-warning]
>>   592 |                         __read_overflow2_field(q_size_field, si=
ze);
>>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~
>>=20
>> The compiler is complaining:
>>=20
>> memcpy(&offsets[1], &entry->watchers_offset,
>>                        sizeof(offsets) - sizeof(offsets[0]));
>>=20
>> where memcpy reads beyong &entry->watchers_offset to copy
>> {watchers,target,next}_offset altogether into offsets[]=2E Silence the
>> warning by wrapping these three up via struct_group()=2E
>>=20
>> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei=2Ecom>
>> ---
>>=20
>> v2: fix HDRTEST error by replacing struct_group() with __struct_group()=
,
>> since it's a uapi header=2E
>>=20
>>  include/uapi/linux/netfilter_bridge/ebtables=2Eh | 14 ++++++++------
>>  net/bridge/netfilter/ebtables=2Ec                |  3 +--
>>  2 files changed, 9 insertions(+), 8 deletions(-)
>>=20
>> diff --git a/include/uapi/linux/netfilter_bridge/ebtables=2Eh b/include=
/uapi/linux/netfilter_bridge/ebtables=2Eh
>> index a494cf43a755=2E=2Eb0caad82b693 100644
>> --- a/include/uapi/linux/netfilter_bridge/ebtables=2Eh
>> +++ b/include/uapi/linux/netfilter_bridge/ebtables=2Eh
>> @@ -182,12 +182,14 @@ struct ebt_entry {
>>  	unsigned char sourcemsk[ETH_ALEN];
>>  	unsigned char destmac[ETH_ALEN];
>>  	unsigned char destmsk[ETH_ALEN];
>> -	/* sizeof ebt_entry + matches */
>> -	unsigned int watchers_offset;
>> -	/* sizeof ebt_entry + matches + watchers */
>> -	unsigned int target_offset;
>> -	/* sizeof ebt_entry + matches + watchers + target */
>> -	unsigned int next_offset;
>> +	__struct_group(/* no tag */, offsets, /* no attrs */,
>> +		/* sizeof ebt_entry + matches */
>> +		unsigned int watchers_offset;
>> +		/* sizeof ebt_entry + matches + watchers */
>> +		unsigned int target_offset;
>> +		/* sizeof ebt_entry + matches + watchers + target */
>> +		unsigned int next_offset;
>> +	);
>>  	unsigned char elems[0] __attribute__ ((aligned (__alignof__(struct eb=
t_replace))));

While we're here, can we drop this [0] in favor of []?

-Kees

>>  };
>> =20
>> diff --git a/net/bridge/netfilter/ebtables=2Ec b/net/bridge/netfilter/e=
btables=2Ec
>> index 757ec46fc45a=2E=2E5ec66b1ebb64 100644
>> --- a/net/bridge/netfilter/ebtables=2Ec
>> +++ b/net/bridge/netfilter/ebtables=2Ec
>> @@ -2115,8 +2115,7 @@ static int size_entry_mwt(const struct ebt_entry =
*entry, const unsigned char *ba
>>  		return ret;
>> =20
>>  	offsets[0] =3D sizeof(struct ebt_entry); /* matches come first */
>> -	memcpy(&offsets[1], &entry->watchers_offset,
>> -			sizeof(offsets) - sizeof(offsets[0]));
>> +	memcpy(&offsets[1], &entry->offsets, sizeof(offsets) - sizeof(offsets=
[0]));
>							^^^^^^^^^^^^
>You now can replace this ____________________________________|
>with just `sizeof(entry->offsets)`
>
>With that change you can add my
>Reviewed-by: Gustavo A=2E R=2E Silva <gustavoars@kernel=2Eorg>
>
>Thank you
>--
>Gustavo
>
>> =20
>>  	if (state->buf_kern_start) {
>>  		buf_start =3D state->buf_kern_start + state->buf_kern_offset;
>> --=20
>> 2=2E41=2E0
>>=20


--=20
Kees Cook
