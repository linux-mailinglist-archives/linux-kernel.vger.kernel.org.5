Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E362976FD0B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 11:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjHDJQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 05:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjHDJQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 05:16:08 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C23C5B8A;
        Fri,  4 Aug 2023 02:13:52 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qRqsX-0001BG-Re; Fri, 04 Aug 2023 11:13:49 +0200
Message-ID: <b68cf309-fca4-7ae0-b42f-90d5f338acdd@leemhuis.info>
Date:   Fri, 4 Aug 2023 11:13:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH v2] HID: logitech-hidpp: rework one more time the retries
 attempts
Content-Language: en-US, de-DE
To:     bentiss@kernel.org,
        =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@riseup.net>,
        Bastien Nocera <hadess@hadess.net>,
        Jiri Kosina <jikos@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        stable@vger.kernel.org,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <20230621-logitech-fixes-v2-1-3635f7f9c8af@kernel.org>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <20230621-logitech-fixes-v2-1-3635f7f9c8af@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1691140432;4cb83ccd;
X-HE-SMSGID: 1qRqsX-0001BG-Re
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Benjamin, /me again! :-D

On 12.07.23 17:02, bentiss@kernel.org wrote:
> From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> Extract the internal code inside a helper function, fix the
> initialization of the parameters used in the helper function
> (`hidpp->answer_available` was not reset and `*response` wasn't either),
> and use a `do {...} while();` loop.
> 
> Fixes: 586e8fede795 ("HID: logitech-hidpp: Retry commands when device is busy")
> Cc: stable@vger.kernel.org

From what I understood there was hope that this would cure the last
remains (occasional init problems iirc) of the recent regressions with
this driver and their fixes. But things look stalled. Is there a reason?
Lack of reviews? Is there nevertheless hope that this will make it at
least into 6.6?

Ciao, Thorsten

> Reviewed-by: Bastien Nocera <hadess@hadess.net>
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
> as requested by https://lore.kernel.org/all/CAHk-=wiMbF38KCNhPFiargenpSBoecSXTLQACKS2UMyo_Vu2ww@mail.gmail.com/
> This is a rewrite of that particular piece of code.
> ---
> Changes in v2:
> - added __must_hold() for KASAN
> - Reworked the comment describing the functions and their return values
> - Link to v1: https://lore.kernel.org/r/20230621-logitech-fixes-v1-1-32e70933c0b0@redhat.com
> ---
>  drivers/hid/hid-logitech-hidpp.c | 115 +++++++++++++++++++++++++--------------
>  1 file changed, 75 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 129b01be488d..09ba2086c95c 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -275,21 +275,22 @@ static int __hidpp_send_report(struct hid_device *hdev,
>  }
>  
>  /*
> - * hidpp_send_message_sync() returns 0 in case of success, and something else
> - * in case of a failure.
> - * - If ' something else' is positive, that means that an error has been raised
> - *   by the protocol itself.
> - * - If ' something else' is negative, that means that we had a classic error
> - *   (-ENOMEM, -EPIPE, etc...)
> + * Effectively send the message to the device, waiting for its answer.
> + *
> + * Must be called with hidpp->send_mutex locked
> + *
> + * Same return protocol than hidpp_send_message_sync():
> + * - success on 0
> + * - negative error means transport error
> + * - positive value means protocol error
>   */
> -static int hidpp_send_message_sync(struct hidpp_device *hidpp,
> +static int __do_hidpp_send_message_sync(struct hidpp_device *hidpp,
>  	struct hidpp_report *message,
>  	struct hidpp_report *response)
>  {
> -	int ret = -1;
> -	int max_retries = 3;
> +	int ret;
>  
> -	mutex_lock(&hidpp->send_mutex);
> +	__must_hold(&hidpp->send_mutex);
>  
>  	hidpp->send_receive_buf = response;
>  	hidpp->answer_available = false;
> @@ -300,47 +301,74 @@ static int hidpp_send_message_sync(struct hidpp_device *hidpp,
>  	 */
>  	*response = *message;
>  
> -	for (; max_retries != 0 && ret; max_retries--) {
> -		ret = __hidpp_send_report(hidpp->hid_dev, message);
> +	ret = __hidpp_send_report(hidpp->hid_dev, message);
> +	if (ret) {
> +		dbg_hid("__hidpp_send_report returned err: %d\n", ret);
> +		memset(response, 0, sizeof(struct hidpp_report));
> +		return ret;
> +	}
>  
> -		if (ret) {
> -			dbg_hid("__hidpp_send_report returned err: %d\n", ret);
> -			memset(response, 0, sizeof(struct hidpp_report));
> -			break;
> -		}
> +	if (!wait_event_timeout(hidpp->wait, hidpp->answer_available,
> +				5*HZ)) {
> +		dbg_hid("%s:timeout waiting for response\n", __func__);
> +		memset(response, 0, sizeof(struct hidpp_report));
> +		return -ETIMEDOUT;
> +	}
>  
> -		if (!wait_event_timeout(hidpp->wait, hidpp->answer_available,
> -					5*HZ)) {
> -			dbg_hid("%s:timeout waiting for response\n", __func__);
> -			memset(response, 0, sizeof(struct hidpp_report));
> -			ret = -ETIMEDOUT;
> -			break;
> -		}
> +	if (response->report_id == REPORT_ID_HIDPP_SHORT &&
> +	    response->rap.sub_id == HIDPP_ERROR) {
> +		ret = response->rap.params[1];
> +		dbg_hid("%s:got hidpp error %02X\n", __func__, ret);
> +		return ret;
> +	}
>  
> -		if (response->report_id == REPORT_ID_HIDPP_SHORT &&
> -		    response->rap.sub_id == HIDPP_ERROR) {
> -			ret = response->rap.params[1];
> -			dbg_hid("%s:got hidpp error %02X\n", __func__, ret);
> +	if ((response->report_id == REPORT_ID_HIDPP_LONG ||
> +	     response->report_id == REPORT_ID_HIDPP_VERY_LONG) &&
> +	    response->fap.feature_index == HIDPP20_ERROR) {
> +		ret = response->fap.params[1];
> +		dbg_hid("%s:got hidpp 2.0 error %02X\n", __func__, ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * hidpp_send_message_sync() returns 0 in case of success, and something else
> + * in case of a failure.
> + *
> + * See __do_hidpp_send_message_sync() for a detailed explanation of the returned
> + * value.
> + */
> +static int hidpp_send_message_sync(struct hidpp_device *hidpp,
> +	struct hidpp_report *message,
> +	struct hidpp_report *response)
> +{
> +	int ret;
> +	int max_retries = 3;
> +
> +	mutex_lock(&hidpp->send_mutex);
> +
> +	do {
> +		ret = __do_hidpp_send_message_sync(hidpp, message, response);
> +		if (ret != HIDPP20_ERROR_BUSY)
>  			break;
> -		}
>  
> -		if ((response->report_id == REPORT_ID_HIDPP_LONG ||
> -		     response->report_id == REPORT_ID_HIDPP_VERY_LONG) &&
> -		    response->fap.feature_index == HIDPP20_ERROR) {
> -			ret = response->fap.params[1];
> -			if (ret != HIDPP20_ERROR_BUSY) {
> -				dbg_hid("%s:got hidpp 2.0 error %02X\n", __func__, ret);
> -				break;
> -			}
> -			dbg_hid("%s:got busy hidpp 2.0 error %02X, retrying\n", __func__, ret);
> -		}
> -	}
> +		dbg_hid("%s:got busy hidpp 2.0 error %02X, retrying\n", __func__, ret);
> +	} while (--max_retries);
>  
>  	mutex_unlock(&hidpp->send_mutex);
>  	return ret;
>  
>  }
>  
> +/*
> + * hidpp_send_fap_command_sync() returns 0 in case of success, and something else
> + * in case of a failure.
> + *
> + * See __do_hidpp_send_message_sync() for a detailed explanation of the returned
> + * value.
> + */
>  static int hidpp_send_fap_command_sync(struct hidpp_device *hidpp,
>  	u8 feat_index, u8 funcindex_clientid, u8 *params, int param_count,
>  	struct hidpp_report *response)
> @@ -373,6 +401,13 @@ static int hidpp_send_fap_command_sync(struct hidpp_device *hidpp,
>  	return ret;
>  }
>  
> +/*
> + * hidpp_send_rap_command_sync() returns 0 in case of success, and something else
> + * in case of a failure.
> + *
> + * See __do_hidpp_send_message_sync() for a detailed explanation of the returned
> + * value.
> + */
>  static int hidpp_send_rap_command_sync(struct hidpp_device *hidpp_dev,
>  	u8 report_id, u8 sub_id, u8 reg_address, u8 *params, int param_count,
>  	struct hidpp_report *response)
> 
> ---
> base-commit: 87854366176403438d01f368b09de3ec2234e0f5
> change-id: 20230621-logitech-fixes-a4c0e66ea2ad
> 
> Best regards,
