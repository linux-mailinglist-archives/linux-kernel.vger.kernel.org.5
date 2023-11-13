Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B767E96C8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 07:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjKMGxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 01:53:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjKMGxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 01:53:36 -0500
Received: from mail.nfschina.com (unknown [42.101.60.195])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 5302910E7;
        Sun, 12 Nov 2023 22:53:31 -0800 (PST)
Received: from [172.30.11.106] (unknown [180.167.10.98])
        by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPSA id C7212604FCB12;
        Mon, 13 Nov 2023 14:53:28 +0800 (CST)
Message-ID: <065d6090-38fc-0cc0-db47-f9ba5b1c5d7d@nfschina.com>
Date:   Mon, 13 Nov 2023 14:53:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH wireless-next] wlcore: debugfs: add an error code check in
 beacon_filtering_write
Content-Language: en-US
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From:   Su Hui <suhui@nfschina.com>
In-Reply-To: <87h6lquqiv.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/11/13 14:16, Kalle Valo wrote:

> Su Hui <suhui@nfschina.com> writes:
>
>> wl1271_acx_beacon_filter_opt() return error code if failed, add a check
>> for this is better and safer.
>>
>> Signed-off-by: Su Hui <suhui@nfschina.com>
> How did you test this?
>
Hi，

Only compile test.
Clang static checker complains about this code that  value stored to 
'ret' is never read.
And most of the caller check  the error code of 
wl1271_acx_beacon_filter_opt().

Such like this:
--
drivers/net/wireless/ti/wlcore/init.c:277:      ret = 
wl1271_acx_beacon_filter_opt(wl, wlvif, false);
drivers/net/wireless/ti/wlcore/init.c-278-      if (ret < 0)
drivers/net/wireless/ti/wlcore/init.c-279-              return ret;
--
drivers/net/wireless/ti/wlcore/init.c:410:      ret = 
wl1271_acx_beacon_filter_opt(wl, wlvif, false);
drivers/net/wireless/ti/wlcore/init.c-411-      if (ret < 0)
drivers/net/wireless/ti/wlcore/init.c-412-              return ret;
--
drivers/net/wireless/ti/wlcore/main.c:1652:     ret = 
wl1271_acx_beacon_filter_opt(wl, wlvif, true);
drivers/net/wireless/ti/wlcore/main.c-1653-     if (ret < 0)
drivers/net/wireless/ti/wlcore/main.c-1654-             goto out;

Sorry for the few test.

Su Hui
