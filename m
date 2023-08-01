Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD0376B5A3
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbjHANTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbjHANTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:19:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4039710C3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 06:19:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE635615A4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 13:19:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B5D6C433C8;
        Tue,  1 Aug 2023 13:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690895975;
        bh=jgDvo59fKoODFk8V6StawFdECwLkKl8S5v/X9XKIeMk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gTJGL+u5VaV9ozdmsiTBfhduAGxUOQXSSYgo4ON6dUAO13ulgkusUZzlGqvwaPMPk
         oU9WmgFa9binj7YJnuXdo6owpdeSSixomqQiL6Zjk6j6+0f4MSJgX2ouWx0QsbMdkc
         R3gl5WlzaN/oSZl2DwOjKv8kJiTk7RQjw+CutsnZaW4wGsi+ihYjwTAQmCEBK97ur1
         lySALjfMpbUmh+eFkN1lwCS2Sxpon68kHxXkHz/cXapYwG5SJ9ozaYXuA025dzDbD1
         Co1T2bwotNneVIrCUekgU8OaFVxkwMbhjhWwvSu8etsvBPZCjw9NG4YqF7z7A8q5ck
         ho2SjqyIIoBOQ==
Message-ID: <0f18cf9e-9c5b-02dd-b396-729b9fecdfe7@kernel.org>
Date:   Tue, 1 Aug 2023 16:19:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH] net: ethernet: ti: am65-cpsw-qos: Add Frame
 Preemption MAC Merge support
Content-Language: en-US
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, s-vadapalli@ti.com, srk@ti.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230725072338.20789-1-rogerq@kernel.org>
 <20230801131418.bhcjtflj3iu77mmc@skbuf>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230801131418.bhcjtflj3iu77mmc@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/08/2023 16:14, Vladimir Oltean wrote:
> On Tue, Jul 25, 2023 at 10:23:38AM +0300, Roger Quadros wrote:
>> Add driver support for viewing / changing the MAC Merge sublayer
>> parameters and seeing the verification state machine's current state
>> via ethtool.
>>
>> As hardware does not support interrupt notification for verification
>> events we resort to polling on link up. On link up we try a couple of
>> times for verification success and if unsuccessful then give up.
>>
>> The Frame Preemption feature is described in the Technical Reference
>> Manual [1] in section:
>> 	12.3.1.4.6.7 Intersperced Express Traffic (IET – P802.3br/D2.0)
>>
>> Due to Silicon Errata i2208 [2] we set limit min IET fragment size to 124.
>>
>> [1] AM62x TRM - https://www.ti.com/lit/ug/spruiv7a/spruiv7a.pdf
>> [2] AM62x Silicon Errata - https://www.ti.com/lit/er/sprz487c/sprz487c.pdf
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
> 
> Also:
> 
> ../drivers/net/ethernet/ti/am65-cpsw-qos.c:173:6: warning: no previous prototype for function 'am65_cpsw_iet_change_preemptible_tcs' [-Wmissing-prototypes]
> void am65_cpsw_iet_change_preemptible_tcs(struct am65_cpsw_port *port, u8 preemptible_tcs)
>      ^
> ../drivers/net/ethernet/ti/am65-cpsw-qos.c:173:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> void am65_cpsw_iet_change_preemptible_tcs(struct am65_cpsw_port *port, u8 preemptible_tcs)
> ^
> static
> ../drivers/net/ethernet/ti/am65-cpsw-qos.c:179:6: warning: no previous prototype for function 'am65_cpsw_iet_link_state_update' [-Wmissing-prototypes]
> void am65_cpsw_iet_link_state_update(struct net_device *ndev)
>      ^
> ../drivers/net/ethernet/ti/am65-cpsw-qos.c:179:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> void am65_cpsw_iet_link_state_update(struct net_device *ndev)
> ^
> static
> ../drivers/net/ethernet/ti/am65-cpsw-qos.c:699:33: error: redefinition of 'taprio'
>         struct tc_taprio_qopt_offload *taprio = type_data;
>                                        ^
> ../drivers/net/ethernet/ti/am65-cpsw-qos.c:697:33: note: previous definition is here
>         struct tc_taprio_qopt_offload *taprio = type_data;
>                                        ^
> 2 warnings and 1 error generated.
> make[7]: *** [../scripts/Makefile.build:243: drivers/net/ethernet/ti/am65-cpsw-qos.o] Error 1
> make[7]: *** Waiting for unfinished jobs....

I'm pretty sure there weren't any build errors for me.
Did you have and resolve conflicts when applying this patch?

-- 
cheers,
-roger
