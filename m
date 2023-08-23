Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B63F785205
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbjHWHwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjHWHwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:52:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD581BE;
        Wed, 23 Aug 2023 00:52:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F45561A24;
        Wed, 23 Aug 2023 07:52:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88C7C433C8;
        Wed, 23 Aug 2023 07:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692777167;
        bh=n9oUBtOY4v6iN8QeG3ySrjb2E4LovnG5A5s20mkNAwU=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=o4dbetyVcKe/463jEhmKakZIdv0sfO0FZftM7FIZ0vH45iTEYSZ26GGVWIhKi3lbQ
         zFnsbnvIxUzEA4WO47amELVI87xNbsAXaQ3D/tkafCpFg3ijjBTtXG0PMIckt1Ru1W
         ZZLZYu0A5xJ5e3VB+gMs+8QqvUQYmsSYFleqIdk/6vnr6Cw3QjyHn8IWjZmg06zNDV
         wwhthvluYf3IPZyrZpNseQjzG9VAszAw2uu9xSffsAcVyQurCPrj6k5vAImuK9HqfY
         AHNfHsQIkDlfYADV7Fbu0VvVutb9QW1W8II0gR4sIeEwBNYjUrBGRT6wJwiH9+CQue
         mgYgplV8zyurw==
From:   Kalle Valo <kvalo@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        Evan Quan <evan.quan@amd.com>, Andrew Lunn <andrew@lunn.ch>,
        rafael@kernel.org, lenb@kernel.org, johannes@sipsolutions.net,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, alexander.deucher@amd.com,
        rdunlap@infradead.org, quic_jjohnson@quicinc.com, horms@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [V9 1/9] drivers core: Add support for Wifi band RF mitigations
References: <20230818032619.3341234-1-evan.quan@amd.com>
        <20230818032619.3341234-2-evan.quan@amd.com>
        <2023081806-rounding-distract-b695@gregkh>
        <2328cf53-849d-46a1-87e6-436e3a1f5fd8@amd.com>
        <2023081919-mockup-bootleg-bdb9@gregkh>
        <e5d153ed-df8a-4d6f-8222-18dfd97f6371@amd.com>
        <2023082247-synthesis-revenge-470d@gregkh>
Date:   Wed, 23 Aug 2023 10:53:43 +0300
In-Reply-To: <2023082247-synthesis-revenge-470d@gregkh> (Greg KH's message of
        "Tue, 22 Aug 2023 08:39:00 +0200")
Message-ID: <87a5uiw5x4.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@linuxfoundation.org> writes:

> On Mon, Aug 21, 2023 at 10:13:45PM -0500, Limonciello, Mario wrote:
>> So I wonder if the right answer is to put it in drivers/net/wireless
>> initially and if we come up with a need later for non wifi producers we can
>> discuss moving it at that time.
>
> Please do so.

Sorry, I haven't been able to follow the discussion in detail but just a
quick comment: if there's supposed to be code which is shared with
different wifi drivers then drivers/net/wireless sounds wrong,
net/wireless or net/mac80211 would be more approriate location.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
