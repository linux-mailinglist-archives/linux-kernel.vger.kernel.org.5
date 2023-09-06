Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA97F793842
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 11:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237026AbjIFJav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 05:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbjIFJau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 05:30:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 047E019BD;
        Wed,  6 Sep 2023 02:30:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235C0C433C7;
        Wed,  6 Sep 2023 09:29:56 +0000 (UTC)
Message-ID: <7d068861-2396-00e7-5851-bfb35810ab0a@xs4all.nl>
Date:   Wed, 6 Sep 2023 11:29:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] media: amphion: handle firmware debug message
Content-Language: en-US, nl
To:     Ming Qian <ming.qian@nxp.com>, mchehab@kernel.org
Cc:     shawnguo@kernel.org, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        xiahong.bao@nxp.com, eagle.zhou@nxp.com, tao.jiang_2@nxp.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230823023837.23101-1-ming.qian@nxp.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20230823023837.23101-1-ming.qian@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2023 04:38, Ming Qian wrote:
> decoder firmware may notify host some debug message,
> it can help analyze the state of the firmware in case of error
> 
> Fixes: 9f599f351e86 ("media: amphion: add vpu core driver")
> Signed-off-by: Ming Qian <ming.qian@nxp.com>
> Reviewed-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> ---
> v2
> - force to terminate string message data
>  drivers/media/platform/amphion/vpu_defs.h    | 1 +
>  drivers/media/platform/amphion/vpu_helpers.c | 1 +
>  drivers/media/platform/amphion/vpu_malone.c  | 1 +
>  drivers/media/platform/amphion/vpu_msgs.c    | 9 +++++++++
>  drivers/media/platform/amphion/vpu_rpc.c     | 3 ++-
>  5 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/amphion/vpu_defs.h b/drivers/media/platform/amphion/vpu_defs.h
> index 667637eedb5d..7320852668d6 100644
> --- a/drivers/media/platform/amphion/vpu_defs.h
> +++ b/drivers/media/platform/amphion/vpu_defs.h
> @@ -71,6 +71,7 @@ enum {
>  	VPU_MSG_ID_TIMESTAMP_INFO,
>  	VPU_MSG_ID_FIRMWARE_XCPT,
>  	VPU_MSG_ID_PIC_SKIPPED,
> +	VPU_MSG_ID_DBG_MSG,
>  };
>  
>  enum VPU_ENC_MEMORY_RESOURSE {
> diff --git a/drivers/media/platform/amphion/vpu_helpers.c b/drivers/media/platform/amphion/vpu_helpers.c
> index af3b336e5dc3..d12310af9ebc 100644
> --- a/drivers/media/platform/amphion/vpu_helpers.c
> +++ b/drivers/media/platform/amphion/vpu_helpers.c
> @@ -489,6 +489,7 @@ const char *vpu_id_name(u32 id)
>  	case VPU_MSG_ID_UNSUPPORTED: return "unsupported";
>  	case VPU_MSG_ID_FIRMWARE_XCPT: return "exception";
>  	case VPU_MSG_ID_PIC_SKIPPED: return "skipped";
> +	case VPU_MSG_ID_DBG_MSG: return "debug msg";
>  	}
>  	return "<unknown>";
>  }
> diff --git a/drivers/media/platform/amphion/vpu_malone.c b/drivers/media/platform/amphion/vpu_malone.c
> index f771661980c0..d3425de7bccd 100644
> --- a/drivers/media/platform/amphion/vpu_malone.c
> +++ b/drivers/media/platform/amphion/vpu_malone.c
> @@ -745,6 +745,7 @@ static struct vpu_pair malone_msgs[] = {
>  	{VPU_MSG_ID_UNSUPPORTED, VID_API_EVENT_UNSUPPORTED_STREAM},
>  	{VPU_MSG_ID_FIRMWARE_XCPT, VID_API_EVENT_FIRMWARE_XCPT},
>  	{VPU_MSG_ID_PIC_SKIPPED, VID_API_EVENT_PIC_SKIPPED},
> +	{VPU_MSG_ID_DBG_MSG, VID_API_EVENT_DBG_MSG_DEC},
>  };
>  
>  static void vpu_malone_pack_fs_alloc(struct vpu_rpc_event *pkt,
> diff --git a/drivers/media/platform/amphion/vpu_msgs.c b/drivers/media/platform/amphion/vpu_msgs.c
> index d0ead051f7d1..999efeaebfd5 100644
> --- a/drivers/media/platform/amphion/vpu_msgs.c
> +++ b/drivers/media/platform/amphion/vpu_msgs.c
> @@ -180,6 +180,14 @@ static void vpu_session_handle_pic_skipped(struct vpu_inst *inst, struct vpu_rpc
>  	vpu_inst_unlock(inst);
>  }
>  
> +static void vpu_session_handle_dbg_msg(struct vpu_inst *inst, struct vpu_rpc_event *pkt)
> +{
> +	char *str = (char *)pkt->data;
> +
> +	if (strlen(str))

This can be replaced by: 'if (*str)', it's faster than strlen.

> +		dev_info(inst->dev, "instance %d firmware dbg msg : %s\n", inst->id, str);
> +}
> +
>  static struct vpu_msg_handler handlers[] = {
>  	{VPU_MSG_ID_START_DONE, vpu_session_handle_start_done},
>  	{VPU_MSG_ID_STOP_DONE, vpu_session_handle_stop_done},
> @@ -196,6 +204,7 @@ static struct vpu_msg_handler handlers[] = {
>  	{VPU_MSG_ID_UNSUPPORTED, vpu_session_handle_error},
>  	{VPU_MSG_ID_FIRMWARE_XCPT, vpu_session_handle_firmware_xcpt},
>  	{VPU_MSG_ID_PIC_SKIPPED, vpu_session_handle_pic_skipped},
> +	{VPU_MSG_ID_DBG_MSG, vpu_session_handle_dbg_msg},
>  };
>  
>  static int vpu_session_handle_msg(struct vpu_inst *inst, struct vpu_rpc_event *msg)
> diff --git a/drivers/media/platform/amphion/vpu_rpc.c b/drivers/media/platform/amphion/vpu_rpc.c
> index f626a9f835e0..8234370afee5 100644
> --- a/drivers/media/platform/amphion/vpu_rpc.c
> +++ b/drivers/media/platform/amphion/vpu_rpc.c
> @@ -144,7 +144,7 @@ static int vpu_rpc_receive_msg_buf(struct vpu_shared_addr *shared, struct vpu_rp
>  	msg->hdr.num = (msgword >> 16) & 0xff;
>  	msg->hdr.id = msgword & 0x3fff;
>  
> -	if (msg->hdr.num > ARRAY_SIZE(msg->data))
> +	if (msg->hdr.num >= ARRAY_SIZE(msg->data))

Is this right? You are changing the max length just to be able to set the
last byte to 0, which makes sense for VPU_MSG_ID_DBG_MSG but perhaps not for
others.

I think it would be better to leave this code as-is and instead set the
last byte to 0 in vpu_session_handle_dbg_msg(). That's where it is actually
needed.

Or am I missing something here?

Regards,

	Hans

>  		return -EINVAL;
>  
>  	for (i = 0; i < msg->hdr.num; i++) {
> @@ -156,6 +156,7 @@ static int vpu_rpc_receive_msg_buf(struct vpu_shared_addr *shared, struct vpu_rp
>  			data = shared->msg_mem_vir;
>  		}
>  	}
> +	msg->data[msg->hdr.num] = 0;
>  
>  	/*update rptr after data is read*/
>  	mb();

