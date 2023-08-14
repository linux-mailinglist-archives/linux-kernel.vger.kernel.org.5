Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18EA77C13B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjHNUE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjHNUEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:04:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D36410E5;
        Mon, 14 Aug 2023 13:04:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF36F6465C;
        Mon, 14 Aug 2023 20:04:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 859A9C433C7;
        Mon, 14 Aug 2023 20:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692043488;
        bh=hAxyfNnNzxVnPvxCxFqBr4+67fwVr5ZIzGGgFuBdSS0=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=LJoM6DZI8/WjEU5Wp56OPED7CXIS3btLl7TdAdRWOy08zZ1k6vDzOrP+/3trsmUbB
         PdYeaEShfOf5/BJ7MYan1xRiUVPLuL75KFaYX/rhvtNFXUkUHZz2Zb/pKJo26cAO0F
         KXdUtq4Z6R7PYsAtQPMEx49OfDc/7mR+ipXfJpjTNIcbrMKm6UMpEHXfwJEwPzGy5j
         t8PUQ4bBH2zXkXPK/icD13Va4QiS6ws4nkoeyF62v138NSzc+Zg8WstHID7D2S6MfS
         ghcg4YetNLPvts/qMABaSJjR4lsOqHMAKS/0x8XtS8MYm3RiXKUCD3km4bO9oae8Xz
         KRvekpb1Qhd+A==
Message-ID: <a113f6cf-db27-67f1-6996-39fd3912c0c8@kernel.org>
Date:   Mon, 14 Aug 2023 22:04:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 02/33] iris: vidc: add core functions
Content-Language: en-US
To:     Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        stanimir.k.varbanov@gmail.com, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
        hans.verkuil@cisco.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <1690550624-14642-1-git-send-email-quic_vgarodia@quicinc.com>
 <1690550624-14642-3-git-send-email-quic_vgarodia@quicinc.com>
 <0149fcd0-e64b-f155-05d8-f32a78d7e83b@kernel.org>
 <18ee06b6-65bc-a320-f06c-7d18ed29c739@quicinc.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <18ee06b6-65bc-a320-f06c-7d18ed29c739@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/2023 20:54, Dikshita Agarwal wrote:
>>> +
>>> +	core = devm_kzalloc(&pdev->dev, sizeof(struct msm_vidc_core), GFP_KERNEL);
>>> +	if (!core) {
>>> +		d_vpr_e("%s: failed to alloc memory for core\n", __func__);
>>
>> Ooops, this for sure did not pass any checks by tools. Sorry, please run
>> basic checks like coccinelle, smatch, sparse, W=1 builds.
>>
> we ran check patch and smatch on this code but no errors were reported.

coccinelle is missing

> please elaborate what issue you see with above code?
>>> +		return -ENOMEM;

We did quite a lot of cleanups long, long time ago removing all unneeded
error messages from memory allocations failures.

Maybe Your use of custom printks() confuses coccinelle, which is a proof
that your code is here an anti-pattern.

...

>>
> Sure, will remove these custom wrapper for locks and use standard
> mutex_lock/unlock APIs directly.
>>> +	allow = msm_vidc_allow_pm_suspend(core);
>>> +
>>> +	if (allow == MSM_VIDC_IGNORE) {
>>> +		d_vpr_h("%s: pm already suspended\n", __func__);
>>
>> So you have bug in PM runtime code? Runtime PM does not suspend devices
>> twice.
>> core is power collapsed in case of idle state when there is no processing
> happening by hardware, this can also change the core state to power_disable.
> this check is ensuring if the core is already in power disable state due to
> that, then no need to suspend it again.

No, you just re-implemented runtime PM.


Best regards,
Krzysztof

