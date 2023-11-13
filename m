Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDED7EA028
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231218AbjKMPiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjKMPiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:38:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2310FD71;
        Mon, 13 Nov 2023 07:38:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E4CC433C7;
        Mon, 13 Nov 2023 15:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699889880;
        bh=nodC5p6ug9A05wH2ElfMtDXiy9l8bsxSv4FLIQhdg+8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=OVppq6+u/PyTFjBKZoEW1bZQdrZdfALGvpZuIevND49++UtW0H1PQBT8OCcDyj7bq
         6T5Y+bxzkoh05KHmQJ9K+YPcnS5HwNo/MkXw/19RPzalc1SsXBa55IFnnS6utSwk4T
         LWx1zxUxsF0cBMcy4y6XyFZhbTV54zaEZ0rHdSR3wwzcGF0qkYK7PLJVjRIQc58rGc
         HBmGLRVyXR6LL7h0P4WKnCtSOsuf3xfPbR4Gyn34y4olTQX1rEXeDO4qpMxSHYJIJQ
         4HbEF/CEXFjktmfTAOwNIada18f7cLpOQFSxkOuHmFoo6AMffAEDGJ3e2l51Ne9K7k
         /GwrwlYSkmdLA==
From:   Kalle Valo <kvalo@kernel.org>
To:     "Luca Weiss" <luca.weiss@fairphone.com>
Cc:     "Jeff Johnson" <quic_jjohnson@quicinc.com>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath11k: Defer on rproc_get failure
References: <20231027-ath11k-rproc-defer-v1-1-f6b6a812cd18@fairphone.com>
        <87lebowjyf.fsf@kernel.org> <CWJ4ZLEZCKQC.2STOBNUU06B2P@fairphone.com>
Date:   Mon, 13 Nov 2023 17:37:57 +0200
In-Reply-To: <CWJ4ZLEZCKQC.2STOBNUU06B2P@fairphone.com> (Luca Weiss's message
        of "Fri, 27 Oct 2023 12:07:09 +0200")
Message-ID: <87a5rhu0iy.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Luca Weiss" <luca.weiss@fairphone.com> writes:

> On Fri Oct 27, 2023 at 10:25 AM CEST, Kalle Valo wrote:
>
>> Luca Weiss <luca.weiss@fairphone.com> writes:
>>
>> > If we already have gotten the rproc_handle (meaning the "qcom,rproc"
>> > property is defined in the devicetree), it's a valid state that the
>> > remoteproc module hasn't probed yet so we should defer probing instead
>> > of just failing to probe.
>> >
>> > This resolves a race condition when the ath11k driver probes and fails
>> > before the wpss remoteproc driver has probed, like the following:
>> >
>> >   [    6.232360] ath11k 17a10040.wifi: failed to get rproc
>> >   [    6.232366] ath11k 17a10040.wifi: failed to get rproc: -22
>> >   [    6.232478] ath11k: probe of 17a10040.wifi failed with error -22
>> >        ...
>> >   [    6.252415] remoteproc remoteproc2: 8a00000.remoteproc is available
>> >   [    6.252776] remoteproc remoteproc2: powering up 8a00000.remoteproc
>> >   [    6.252781] remoteproc remoteproc2: Booting fw image qcom/qcm6490/fairphone5/wpss.mdt, size 7188
>> >
>> > So, defer the probe if we hit that so we can retry later once the wpss
>> > remoteproc is available.
>> >
>> > Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>
>> Did you test this on a real device? If yes, what ath11k hardware and firmware
>> did you use? We use Tested-on tag to document that:
>>
>> https://wireless.wiki.kernel.org/en/users/drivers/ath11k/submittingpatches#tested-on_tag
>
> Hi,
>
> Yes I tested this on qcm6490-fairphone-fp5 including some extra patches
> for wpss-pas remoteproc support (nothing special, just adding it to the
> existing PAS driver) and wifi enablement in dts.

Nice, do you have a link to the patches or a git tree which has
everything? And how difficult would it be for me to run vanilla
kernel.org kernel (no vendor kernels or anything like that) on Fairphone
5? Any documentation available for that?

I'm asking because I don't have a test setup for WCN6750 right now. It
would be awesome if I could use Fairphone for testing :)

> I built this line from info from the dmesg, hope it's okay:
>
> Tested-on: wcn6750 hw1.0 AHB WLAN.MSL.1.0.1-01264-QCAMSLSWPLZ-1.37886.3

Thanks, I added that to the commit message.

> And thinking about it, a Fixes tag would also be appropriate for this
> patch. The code was moved to a different file in commit ba929d6fe31a
> ("ath11k: Remove rproc references from common core layer") but I think
> this tag should be correct.
>
> Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")

Ok, I added that as well.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
