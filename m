Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE297D1E67
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 18:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbjJUQv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 12:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbjJUQvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 12:51:54 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59D2C9;
        Sat, 21 Oct 2023 09:51:47 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 645DE60182;
        Sat, 21 Oct 2023 18:51:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1697907104; bh=ho6UWRd8O8SyFiWrb+dKpDDb+6uyTrQVuzw6q8B8OnE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=2AzgjsUKHy8cIfc4/YF9vouRvVxUfcEPnJ71GoLvGfY5EsIXFGlgkqYR7qQu48Kft
         t8tRYDV2Y39Bz87BDjr70cEegs/CIN+vGoS25zILm1MNz/1lKF984YwTlC7EIKeGXk
         uarntQBQE0knldHEpxsPuiRzxSUtTpUaEbg1PIcxzv2K4ooHlczsu4PMPKg629p5pD
         11TY1ccrK4GWDYAX+VcwPGh24TwFw3DSSEqh3iLtWqOEiWbcVuGju9gTbg9DBuHrsn
         ipjuQOzBcHIyupu88bnJbRU11cPT5vye6HQric4skEfEE2+nym9PCGI+Cc8uEo8DZz
         ZTcER7DG/zsYA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sCekpWZPGBwn; Sat, 21 Oct 2023 18:51:41 +0200 (CEST)
Received: from [192.168.1.3] (78-2-88-137.adsl.net.t-com.hr [78.2.88.137])
        by domac.alu.hr (Postfix) with ESMTPSA id 48B0960171;
        Sat, 21 Oct 2023 18:51:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1697907101; bh=ho6UWRd8O8SyFiWrb+dKpDDb+6uyTrQVuzw6q8B8OnE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fGIn5a73y21Ax/gwObg/pWet5UEH7qZkedirNqvAVgKx9ICWBVu5MpHMvG6/xjaia
         TSRs6beOqR9YHJcs9ESXfQmwBzPW6kz2+3Dp2WkQG4BJ1XbMY7WyxLvuDl6cEHckRc
         V0gSZ/UzNTV0ael0XHX9cxYNzhjQmjLGa0iJoyaNUp0M8riHUGgbDysxiMFCe/+ZKW
         o95tMBuoiBlMCVelGj2DS+EIE0ph3T3ws3b4rAWW6m7no7sQatq8V20wg+BgBKvEWZ
         f2JDaj71/vyw+G4V2MCLfnrtLCJacTNo2Eu1f8CM+UIE/+8m+gG8sre5MMwkNne6MW
         Jgf1SofKYSjiA==
Message-ID: <7f6612a5-2647-4918-a2c1-492d3ffcf800@alu.unizg.hr>
Date:   Sat, 21 Oct 2023 18:51:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] r8169: fix the KCSAN reported data-race in
 rtl_tx() while reading tp->cur_tx
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, nic_swsd@realtek.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, Marco Elver <elver@google.com>
References: <20231018193434.344176-1-mirsad.todorovac@alu.unizg.hr>
 <20231020165048.33d3bff2@kernel.org>
Content-Language: en-US
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Autocrypt: addr=mirsad.todorovac@alu.unizg.hr; keydata=
 xjMEYp0QmBYJKwYBBAHaRw8BAQdAI14D1/OE3jLBYycg8HaOJOYrvEaox0abFZtJf3vagyLN
 Nk1pcnNhZCBHb3JhbiBUb2Rvcm92YWMgPG1pcnNhZC50b2Rvcm92YWNAYWx1LnVuaXpnLmhy
 PsKPBBMWCAA3FiEEdCs8n09L2Xwp/ytk6p9/SWOJhIAFAmKdEJgFCQ0oaIACGwMECwkIBwUV
 CAkKCwUWAgMBAAAKCRDqn39JY4mEgIf/AP9hx09nve6VH6D/F3m5jRT5m1lzt5YzSMpxLGGU
 vGlI4QEAvOvGI6gPCQMhuQQrOfRr1CnnTXeaXHhlp9GaZEW45QzOOARinRCZEgorBgEEAZdV
 AQUBAQdAqJ1CxZGdTsiS0cqW3AvoufnWUIC/h3W2rpJ+HUxm61QDAQgHwn4EGBYIACYWIQR0
 KzyfT0vZfCn/K2Tqn39JY4mEgAUCYp0QmQUJDShogAIbDAAKCRDqn39JY4mEgIMnAQDPKMJJ
 fs8+QnWS2xx299NkVTRsZwfg54z9NIvH5L3HiAD9FT3zfHfvQxIViWEzcj0q+FLWoRkOh02P
 Ny0lWTyFlgc=
Organization: Academy of Fine Arts, University of Zagreb
In-Reply-To: <20231020165048.33d3bff2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/2023 1:50 AM, Jakub Kicinski wrote:
> On Wed, 18 Oct 2023 21:34:34 +0200 Mirsad Goran Todorovac wrote:
>> KCSAN reported the following data-race:
> 
> All 3 patches seem to have been applied to net, thank you!

That sounds like great news. Many thanks to Heiner, Marco, and Simon as well for reviewing
and advice.

Best regards,
Mirsad Todorovac

-- 
Mirsad Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
tel. +385 (0)1 3711 451
mob. +385 91 57 88 355
