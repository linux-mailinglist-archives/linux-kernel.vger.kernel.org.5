Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D13F787C9E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 02:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbjHYAly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 20:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234492AbjHYAl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 20:41:29 -0400
X-Greylist: delayed 902 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 24 Aug 2023 17:41:27 PDT
Received: from s1-ba86.socketlabs.email-od.com (s1-ba86.socketlabs.email-od.com [142.0.186.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25ECCEE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 17:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; d=email-od.com;i=@email-od.com;s=dkim;
        c=relaxed/relaxed; q=dns/txt; t=1692924088; x=1695516088;
        h=content-transfer-encoding:content-type:in-reply-to:from:references:cc:to:content-language:subject:mime-version:date:message-id:x-thread-info:subject:to:from:cc:reply-to;
        bh=5p/Ug4kMcIbSwiMSJaBbOnZa4/tCvAUeFVtMAj9IcOQ=;
        b=k+F43bxxyVqv1rbFo2LgL/hH/YkLTSIKcMIjvDeglsb9vtq7RJTYKFoueQ7dxosy2MWfh8HLBh1bXjRxRW2FpTaMPxXAtICFijC/5L7NoylRFTifsbAychtkIBiXTBP8KYY2DYN0KQH4qDpOh8uMPldV/+3Sfgljy90EHRm5RqU=
X-Thread-Info: NDUwNC4xMi4xNWZkOTAwMDFjN2IzM2EubGludXgta2VybmVsPXZnZXIua2VybmVsLm9yZw==
Received: from r2.us-east-1.aws.in.socketlabs.com (r2.us-east-1.aws.in.socketlabs.com [142.0.191.2]) by mxrs4.email-od.com
        with ESMTP(version=Tls12 cipher=Aes256 bits=256); Thu, 24 Aug 2023 20:26:24 -0400
Received: from nalramli.com (d14-69-55-117.try.wideopenwest.com [69.14.117.55]) by r2.us-east-1.aws.in.socketlabs.com
        with ESMTP; Thu, 24 Aug 2023 20:26:22 -0400
Received: from [10.0.2.15] (d14-69-55-117.try.wideopenwest.com [69.14.117.55])
        by nalramli.com (Postfix) with ESMTPS id 24C862CE0018;
        Thu, 24 Aug 2023 20:26:22 -0400 (EDT)
Message-ID: <42eca8e9-6e45-4728-bc1f-18330b7814c1@nalramli.com>
Date:   Thu, 24 Aug 2023 20:26:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next RFC 0/1] mlx5: support per queue coalesce settings
Content-Language: en-US
To:     Saeed Mahameed <saeed@kernel.org>
Cc:     netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
        saeedm@nvidia.com, tariqt@nvidia.com, linux-kernel@vger.kernel.org,
        leon@kernel.org, jdamato@fastly.com, nalramli@fastly.com
References: <20230823223121.58676-1-dev@nalramli.com> <ZOemz1HLp95aGXXQ@x130>
From:   "Nabil S. Alramli" <dev@nalramli.com>
In-Reply-To: <ZOemz1HLp95aGXXQ@x130>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-13.3 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_IADB_DK,RCVD_IN_IADB_LISTED,
        RCVD_IN_IADB_OPTIN,RCVD_IN_IADB_RDNS,RCVD_IN_IADB_SENDERID,
        RCVD_IN_IADB_SPF,RCVD_IN_IADB_VOUCHED,SPF_HELO_PASS,SPF_PASS,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saeed,

Thank you for your review and feedback. Please see below for a couple of=20
additional questions.

On 8/24/23 14:51, Saeed Mahameed wrote:
> On 23 Aug 18:31, Nabil S. Alramli wrote:
>> Hello,
>>
>> I am Submitting this as an RFC to get feedback and to find out if the=20
>> folks
>> at Mellanox would accept this change.
>>
>> Currently, only gobal coalescing configuration queries or changes are
>> supported in the `mlx5` driver. However, per-queue operations are not,=
=20
>> and
>> result in `EOPNOTSUPP` errors when attempted with `ethtool`. This patc=
h
>> adds support for per-queue coalesce operations, with a caveat describe=
d
>> below.
>>
>> Here's an example use case:
>>
>> - An mlx5 NIC is configured with 8 queues, each queue has its IRQ pinn=
ed
>> =C2=A0to a unique CPU.
>> - Two custom RSS contexts are created: context 1 and context 2. Each
>> =C2=A0context has a different set of queues where flows are distribute=
d. For
>> =C2=A0example, context 1 may distribute flows to queues 0-3, and conte=
xt 2 may
>> =C2=A0distribute flows to queues 4-7.
>> - A series of ntuple filters are installed which direct matching flows=
 to
>> =C2=A0RSS contexts. For example, perhaps port 80 is directed to contex=
t 1 and
>> =C2=A0port 443 to context 2.
>> - Applications which receive network data associated with either conte=
xt
>> =C2=A0are pinned to the CPUs where the queues in the matching context =
have
>> =C2=A0their IRQs pinned to maximize locality.
>>
>> The apps themselves, however, may have different requirements on=20
>> latency vs
>> CPU usage and so setting the per queue IRQ coalesce values would be ve=
ry
>> helpful.
>>
>> This patch would support this, with the caveat that DIM mode changes p=
er
>> queue are not supported. DIM mode can only be changed NIC-wide. This i=
s
>> because in the mlx5 driver, global operations that change the state of
>> adaptive-ex or adaptive-tx require a reset. So in the case of=20
>> per-queue, we
>> reject such requests. This was done in the interest of simplicity for=20
>> this
>> RFC as setting the DIM mode per queue appears to require significant
>> changes to mlx5 to be able to preserve the state of the indvidual=20
>> channels
>> through a reset.
>>
>> IMO, if a user is going to set per-queue coalesce settings it might be
>> reasonable to assume that they will disable adaptive rx/tx NIC wide fi=
rst
>> and then go through and apply their desired per-queue settings.
>>
>=20
> DIM is already per channel, so I don't think it's that difficult to hav=
e
> mix support of DIM and static config per channel. Yes the code will nee=
d
> some refactoring, but with a quick glance at the code provided here, su=
ch
> refactoring is already required IMO.
>=20
That sounds good. I'll go ahead and add support for DIM per-channel=20
coalescing updates. I'll send another RFC when that is ready for initial=20
feedback.

Can you please provide some clarification as to what you mean that some=20
refactoring is needed? Are you referring to the existing code, or is=20
there something specifically in this patch?

For example, I think we'll need to make some additional changes to=20
mlx5e_safe_switch_params(), mlx5e_open_channels() and probably more. Is=20
this what you have in mind?

>> Here's an example:
>>
>> $ ethtool --per-queue eth0 queue_mask 0x4 --show-coalesce
>> Queue: 2
>> Adaptive RX: on=C2=A0 TX: on
>> stats-block-usecs: 0
>> sample-interval: 0
>> pkt-rate-low: 0
>> pkt-rate-high: 0
>>
>> rx-usecs: 8
>> rx-frames: 128
>> ...
>>
>> Now, let's try to set adaptive-rx off rx-usecs 16 for queue 2:
>>
>> $ sudo ethtool --per-queue eth0 queue_mask 0x4 --coalesce adaptive-rx=20
>> off \
>> =C2=A0rx-usecs 16
>> Cannot set device per queue parameters: Operation not supported
>>
>> This is not supported; adaptive-rx must be disabled NIC wide first:
>>
>> $ sudo ethtool -C eth0 adaptive-rx off
>>
>> And now, queue_mask 0x4 can be applied to set rx-usecs:
>>
>> $ sudo ethtool --per-queue eth0 queue_mask 0x4 --coalesce rx-usecs 16
>> $ ethtool --per-queue eth0 queue_mask 0x4 --show-coalesce
>> Queue: 2
>> Adaptive RX: off=C2=A0 TX: on
>> stats-block-usecs: 0
>> sample-interval: 0
>> pkt-rate-low: 0
>> pkt-rate-high: 0
>>
>> rx-usecs: 16
>> rx-frames: 32
>> ...
>>
>> Previously a global `struct mlx5e_params` stored the options in
>> `struct mlx5e_priv.channels.params`. That was preserved, but a channel=
-
>> specific instance was added as well, in `struct mlx5e_channel.params`.
>>
>> Note that setting global coalescing options will set the individual
>> channel settings to the same values as well.
>>
>> Is Mellanox open to this change? What would be needed to get something=
=20
>> like
>> this accepted?
>>
>=20
> Sure, we just need to pass review and few testing cycles.
>=20
> Thanks,
> Saeed.
>=20

Best Regards,

-- Nabil S. Alramli
