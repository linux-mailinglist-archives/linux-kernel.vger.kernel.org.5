Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF6581384E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443990AbjLNRRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:17:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444260AbjLNRQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:16:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E30F10C6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:16:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B767C433C8;
        Thu, 14 Dec 2023 17:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702574205;
        bh=j3EMGBksbzz4Fe6xhN1+uDIfhW9IPxgGEJtUJDyFcyE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PoIlIpUNIR39MHVocMfe0vArZzH5sDUcqpS6ePbYC5lZXvkgGElatv6DzofTv1CJ/
         paHWCzCnPMxzeGzVXQyw14lQzntAWCkJPTNpZurcncamYZops8rIwfOmxTDFOgNxZh
         AMFGs4BCR58nrL6o/pwoLOFNtM74mEX/NaoTaGBsmQTtFwRho60ZI4IjvfFbeyOeS4
         dn5RdnZf5OICu+n3oXefF67i/KvZ335zRJeojUqKUE+QYsHtVyTJv86LKdCrTRCrZ8
         cM6lbJKJtFIHlTUKRHUmzPdCaa4hgWHFkwZuhNYpw6MCz2BpnMaPYXi1iXlVBQf/ep
         ovwT6vQ6DgkVw==
Message-ID: <5e0e18da-6141-4d28-9316-f796be7489d9@kernel.org>
Date:   Thu, 14 Dec 2023 19:16:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 net-next 02/11] selftests: forwarding: ethtool_mm: fall
 back to aggregate if device does not report pMAC stats
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, shuah@kernel.org, s-vadapalli@ti.com,
        r-gunasekaran@ti.com, vigneshr@ti.com, srk@ti.com,
        horms@kernel.org, p-varis@ti.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231213110721.69154-1-rogerq@kernel.org>
 <20231213110721.69154-3-rogerq@kernel.org>
 <20231214141646.kdf5rnldpyglwvdd@skbuf>
Content-Language: en-US
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231214141646.kdf5rnldpyglwvdd@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/12/2023 16:16, Vladimir Oltean wrote:
> On Wed, Dec 13, 2023 at 01:07:12PM +0200, Roger Quadros wrote:
>> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
>> index 8f6ca458af9a..763c262a3453 100755
>> --- a/tools/testing/selftests/net/forwarding/lib.sh
>> +++ b/tools/testing/selftests/net/forwarding/lib.sh
>> @@ -146,6 +146,15 @@ check_ethtool_mm_support()
>>  	fi
>>  }
>>  
>> +check_ethtool_pmac_std_stats_support()
>> +{
>> +	local dev=$1; shift
>> +	local grp=$1; shift
>> +
>> +	[ 0 -ne $(ethtool --json -S $dev --all-groups --src pmac 2>/dev/null \
>> +		| jq '.[]."$grp" | length') ]
>> +}
>> +
>>  check_locked_port_support()
>>  {
>>  	if ! bridge -d link show | grep -q " locked"; then
>> -- 
>> 2.34.1
>>
> 
> FYI, there's another submitted patch that touches the exact same spot,
> and it looks like it has a good chance of getting merged.
> https://patchwork.kernel.org/project/netdevbpf/patch/20231214135029.383595-9-tobias@waldekranz.com/
> 
> You need to pay attention to merge conflicts, so you don't waste a patch
> iteration just because of that one thing.
> 
> I guess you might be able to wing it, because the other patch does this:
> 
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index 8f6ca458af9a..e3740163c384 100755
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -146,6 +146,15 @@  check_ethtool_mm_support()
>  	fi
>  }
>  
> +check_ethtool_counter_group_support()
> +{
> +	ethtool --help 2>&1| grep -- '--all-groups' &> /dev/null
> +	if [[ $? -ne 0 ]]; then
> +		echo "SKIP: ethtool too old; it is missing standard counter group support"
> +		exit $ksft_skip
> +	fi
> +}
> +
>  check_locked_port_support()
>  {
>  	if ! bridge -d link show | grep -q " locked"; then
> 
> which quite coincidentally does not change what your patch sees in its
> upper context, aka 3 lines like this:
> 
> ----
>  	fi
>  }
>  
> ----
> 
> You can check if your patch set applies on top of Tobias', by formatting
> it as patch files on top of net-next/main, resetting HEAD to net-next,
> applying Tobias' series and then your patches.

Thanks for the heads up :)

-- 
cheers,
-roger
