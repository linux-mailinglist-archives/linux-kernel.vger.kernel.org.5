Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C4477B545
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 11:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235334AbjHNJSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 05:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234535AbjHNJSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 05:18:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAECCD7;
        Mon, 14 Aug 2023 02:18:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EFD76306B;
        Mon, 14 Aug 2023 09:18:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EA74C433C9;
        Mon, 14 Aug 2023 09:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692004689;
        bh=0UG+LfUd1Yu8KQOfBApMs70WUwSpDqQox+10j7RUvRA=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=IdgDEl2ENfVbFWfrkbAYM1LXIlkMXGHekF2Za4EagFL43WaqlxaCXhn6qZgYEZDQ7
         gsJDZGFbs8Zapp9mSJ9G35ZRV8K0VwYOI8tMBrBT/tyDXeocnKTTyAdwKtlliu9BE2
         ZOm6t1yygBleJgou9Fg1IQK7qBsB9SK9aliVT7pgEytbcKRU5hQkzF5w/EPKEiTErs
         E3+pZdOwwsltTitG4+gHBLvcV/KcHDNH/DloBiflx0oMRPUA2IlZt3lLqiupyPQz1P
         HflN7LFdFaw/tOixZPX9pKNeqFdsrHEV4Hv5/Rojc3cQjli7WTrFw0wx0Up5Lkrpr9
         C/8s5xPRNfEVQ==
Date:   Mon, 14 Aug 2023 11:18:06 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Nikita Zhandarovich <n.zhandarovich@fintech.ru>
cc:     =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [PATCH] HID: logitech-dj: Fix error handling in
 logi_dj_recv_switch_to_dj_mode()
In-Reply-To: <20230613101635.77820-1-n.zhandarovich@fintech.ru>
Message-ID: <nycvar.YFH.7.76.2308141117360.14207@cbobk.fhfr.pm>
References: <20230613101635.77820-1-n.zhandarovich@fintech.ru>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2023, Nikita Zhandarovich wrote:

> Presently, if a call to logi_dj_recv_send_report() fails, we do
> not learn about the error until after sending short
> HID_OUTPUT_REPORT with hid_hw_raw_request().
> To handle this somewhat unlikely issue, return on error in
> logi_dj_recv_send_report() (minding ugly sleep workaround) and
> take into account the result of hid_hw_raw_request().
> 
> Found by Linux Verification Center (linuxtesting.org) with static
> analysis tool SVACE.
> 
> Fixes: 6a9ddc897883 ("HID: logitech-dj: enable notifications on connect/disconnect")
> Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
> ---
>  drivers/hid/hid-logitech-dj.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
> index 62180414efcc..e6a8b6d8eab7 100644
> --- a/drivers/hid/hid-logitech-dj.c
> +++ b/drivers/hid/hid-logitech-dj.c
> @@ -1285,6 +1285,9 @@ static int logi_dj_recv_switch_to_dj_mode(struct dj_receiver_dev *djrcv_dev,
>  		 * 50 msec should gives enough time to the receiver to be ready.
>  		 */
>  		msleep(50);
> +
> +		if (retval)
> +			return retval;
>  	}
>  
>  	/*
> @@ -1306,7 +1309,7 @@ static int logi_dj_recv_switch_to_dj_mode(struct dj_receiver_dev *djrcv_dev,
>  	buf[5] = 0x09;
>  	buf[6] = 0x00;
>  
> -	hid_hw_raw_request(hdev, REPORT_ID_HIDPP_SHORT, buf,
> +	retval = hid_hw_raw_request(hdev, REPORT_ID_HIDPP_SHORT, buf,
>  			HIDPP_REPORT_SHORT_LENGTH, HID_OUTPUT_REPORT,
>  			HID_REQ_SET_REPORT);

Looks good to me. Benjamin, could you please Ack/apply it?

Thanks,

-- 
Jiri Kosina
SUSE Labs

