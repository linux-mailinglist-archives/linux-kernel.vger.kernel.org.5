Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A367BFA58
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbjJJLwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbjJJLwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:52:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 451D494
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 04:52:08 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2848066072AE;
        Tue, 10 Oct 2023 12:52:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1696938726;
        bh=DDDOlfk5jB2cOVusgEQjce1+xSjb45yRwxIUkDJq2cE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ms6o7pQkQvURz2yq7kW6oCfCXKpvZKT5xUttW3seUmumJoT3tB7thBqIrKVpQ9eOV
         VB1rW07j4qUdwsUoplKhUnjwzpPqojLqlms7UAZ/QEOK14vRzTMUtG/N0WiwvoMyIN
         Qj62B/5iQRlI/5U85F4ey3gIhFlrk/whg+kmh4m39E8wmHXlvcRPjaxKTzat2UXXd1
         e7wMatEIjcKanAGu14YfG/ydAogvcFVDyBFY9Umy/dBpu6snHA+dg4ftIa/u0WVxdF
         5fyEXhWAnW+nL7VVBpk0GTCk5E9AkTcaKQMvuVXQ66IAXHspmf/SKrdyQ3SFUujFBz
         zb1+gCUhpERQg==
Message-ID: <bb9ae8ac-b12e-8f4f-1c21-7cde61d796c3@collabora.com>
Date:   Tue, 10 Oct 2023 13:52:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2] mailbox: remove runtime GCE clk control
Content-Language: en-US
To:     =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        "jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        =?UTF-8?B?Sm9obnNvbiBXYW5nICjnjovogZbpkasp?= 
        <Johnson.Wang@mediatek.com>,
        =?UTF-8?B?SmFzb24tY2ggQ2hlbiAo6Zmz5bu66LGqKQ==?= 
        <Jason-ch.Chen@mediatek.com>,
        =?UTF-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
References: <20231004085430.19538-1-jason-jh.lin@mediatek.com>
 <baa122da-4ae3-9023-3529-3ad38204b989@collabora.com>
 <672d86a9e9bb08c770a6884860e9d13a0aaf0eb7.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <672d86a9e9bb08c770a6884860e9d13a0aaf0eb7.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 06/10/23 11:15, Jason-JH Lin (林睿祥) ha scritto:
> Hi Angelo,
> 
> Thanks for the reviews.
> 
> On Wed, 2023-10-04 at 11:20 +0200, AngeloGioacchino Del Regno wrote:
>> Il 04/10/23 10:54, Jason-JH.Lin ha scritto:
>>> 1. GCE is a frequently used module, so runtime controlling
>>> GCE clock won't save too much power and its original design
>>> doesn't expect it to be enabled and disabled too frequently.
>>>
>>> 2. Runtime controlling GCE clock will cause display HW register
>>> configured in worng stream done event issue below:
>>>     GCE should config HW in every vblanking duration.
>>>     The stream done event is the start signal of vblanking.
>>>
>>>     If stream done event is sent between GCE clk_disable
>>>     and clk_enable. After GCE clk_enable the stream done event
>>>     may not appear immediately and have about 3us delay.
>>>
>>>     Normal case:
>>>     clk_disable -> get EventA -> clk_enable -> clear EventA
>>>     -> wait EventB -> get EventB -> config HW
>>>
>>>     Abnormal case:
>>>     clk_disable -> get EventA -> clk_enable -> EventA delay appear
>>>     -> clear EventA fail -> wait EventB but get EventA -> config HW
>>>
>>> So just remove the runtime GCE clock contorl.
>>>
>>> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
>>
>> Instead of entirely removing the logic that controls the clocks and
>> always
>> refuse to save power, what about using autosuspend?
>>
>> If the two cases that you're describing are happening always in a
>> range of
>> time, we could *yes* remove the "manual" bulk disable/enable calls,
>> but then
>> we could use runtime_suspend/runtime_resume callbacks for that.
>>
>> Hint: pm_runtime_set_autosuspend_delay(dev, 1000);
>>
>> Regards,
>> Angelo
>>
> 
> These 2 issues are caused by GCE bulk_clk enable/disable too
> frequently.
> 
> As I now, pm_runtime_set_autosuspend_delay() is for controlling the
> power domain. The power domain of GCE is infrasys which can only be
> enabled/disabled by spm during the whole system resume/suspend.
> So I'm not sure about how can pm_runtime_set_autosuspend_delay() save
> power for GCE bulk_clk in this case.
> 
> Could you give more hint for me please?
> 

I think it's faster if I send my own version of that, I'm testing that right now
on multiple Chromebooks to check if this solves the issue that you're describing,
which I believe it to be the "apparent random lockups" or display stuttering when
in a high load situation.

I don't seem to get any more stuttering nor apparent random lockups on a MT8195
Chromebook, and that's with my pm_runtime autosuspend solution, with a runtime
suspend delay of 100ms, which I'm trying to decrease as much as possible in order
to keep saving as much power as possible.

For this, if you could better describe how to reliably reproduce the issue that
you have described, it would help me a bit in making this as good as possible.

Thanks,
Angelo

