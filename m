Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041EA8096B1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 00:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbjLGXlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 18:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjLGXlB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 18:41:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F2C1718
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 15:41:07 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F705C433C7;
        Thu,  7 Dec 2023 23:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701992467;
        bh=F3yFkrBoPvYgnjqkAbhACfF2pHqxuP+Z8Rav20Zxl9M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fVsGFRUVrs4k5SOD5D4kjazODSA2OlpFebdxjWr9QRTQE34EGts47fCXyNNrWcQSu
         0we2lGdWGyCpY5jzbRxaB4KUQqrchdbtak2IZLwjdLovJHc3/GG3eT8gF0l+Q6R1wh
         8IuMxwKflIvH0bvQJiN1d7xTqY3fXPMM/pitmNzkk+RGGhzwJTAydRSXrNTzJ26iWP
         IxRs1McwWB/6Dk8gYMrYE1Qf7oxw3aOX3+BzM6i8xjm2+gdBGr8kS7ZFzKTt3QBw1f
         BOzJRCOAx/r2vMeuFOU+adlKp+RpubHa7AjsTb0KVYC1NaPExMotCjZApyPHR7dpx4
         GMeQdBaS7+H0w==
Date:   Thu, 7 Dec 2023 15:44:25 -0800
From:   Bjorn Andersson <andersson@kernel.org>
To:     Deepak Kumar Singh <quic_deesin@quicinc.com>
Cc:     quic_bjorande@quicinc.com, andersson@kernel.org,
        quic_clew@quicinc.com, mathieu.poirier@linaro.org,
        linux-kernel@vger.kernel.org, quic_sarannya@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH V1] rpmsg: glink: smem: validate index before fifo read
 write
Message-ID: <yqa3hodfpdisdncluoojkqk533lqko5ymbzms3mstjfcxvbkvm@dwwzg24zxpxm>
References: <20231201110631.669085-1-quic_deesin@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201110631.669085-1-quic_deesin@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 01, 2023 at 04:36:31PM +0530, Deepak Kumar Singh wrote:
> Fifo head and tail index can be modified with wrong values from
> untrusted remote procs. Glink smem is not validating these index
> before using to read or write fifo. This can result in out of
> bound memory access if head and tail have incorrect values.
> 
> Add check for validation of head and tail index. This check will
> put index within fifo boundaries, so that no invalid memory access
> is made. Further this may result in certain packet drops unless
> glink finds a valid packet header in fifo again and recovers.
> 
> Crash signature and calltrace with wrong head and tail values:
> 
> Internal error: Oops: 96000007 [#1] PREEMPT SMP
> pc : __memcpy_fromio+0x34/0xb4
> lr : glink_smem_rx_peak+0x68/0x94
> 
> __memcpy_fromio+0x34/0xb4
> glink_smem_rx_peak+0x68/0x94
> qcom_glink_native_intr+0x90/0x888
> 
> Signed-off-by: Deepak Kumar Singh <quic_deesin@quicinc.com>
> ---
>  drivers/rpmsg/qcom_glink_smem.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/rpmsg/qcom_glink_smem.c b/drivers/rpmsg/qcom_glink_smem.c
> index 7a982c60a8dd..9eba0aaae916 100644
> --- a/drivers/rpmsg/qcom_glink_smem.c
> +++ b/drivers/rpmsg/qcom_glink_smem.c
> @@ -86,9 +86,14 @@ static size_t glink_smem_rx_avail(struct qcom_glink_pipe *np)
>  	tail = le32_to_cpu(*pipe->tail);
>  
>  	if (head < tail)
> -		return pipe->native.length - tail + head;
> +		len = pipe->native.length - tail + head;
>  	else
> -		return head - tail;
> +		len = head - tail;
> +
> +	if (WARN_ON_ONCE(len > pipe->native.length))
> +		len = 0;
> +
> +	return len;
>  }
>  
>  static void glink_smem_rx_peek(struct qcom_glink_pipe *np,
> @@ -99,6 +104,10 @@ static void glink_smem_rx_peek(struct qcom_glink_pipe *np,
>  	u32 tail;
>  
>  	tail = le32_to_cpu(*pipe->tail);
> +
> +	if (WARN_ON_ONCE(tail > pipe->native.length))
> +		return;

Just returning here will leave the caller with garbage in @data, which
they will act upon. It does avoid the out of bounds read, but I'm not
confident in what happens next.

> +
>  	tail += offset;
>  	if (tail >= pipe->native.length)
>  		tail -= pipe->native.length;
> @@ -121,7 +130,7 @@ static void glink_smem_rx_advance(struct qcom_glink_pipe *np,
>  
>  	tail += count;
>  	if (tail >= pipe->native.length)
> -		tail -= pipe->native.length;
> +		tail %= pipe->native.length;

If @tail had a bogus value before we incremented then we now have a
completely random value. The next time the FIFO is read these values
will be OK and we will return some random values to the caller.

>  
>  	*pipe->tail = cpu_to_le32(tail);
>  }
> @@ -146,6 +155,9 @@ static size_t glink_smem_tx_avail(struct qcom_glink_pipe *np)
>  	else
>  		avail -= FIFO_FULL_RESERVE + TX_BLOCKED_CMD_RESERVE;
>  
> +	if (WARN_ON_ONCE(avail > pipe->native.length))
> +		avail = 0;
> +
>  	return avail;
>  }
>  
> @@ -155,6 +167,9 @@ static unsigned int glink_smem_tx_write_one(struct glink_smem_pipe *pipe,
>  {
>  	size_t len;
>  
> +	if (WARN_ON_ONCE(head > pipe->native.length))
> +		return head;

As above, but with less probability, this might end up adjusting
pipe->head (in glink_smem_tx_write()) to a random position within the
FIFO - which then upon next access will corrupt the data.

This shouldn't cause any direct issues on the Linux side though, we will
just corrupt the outgoing FIFO (which probably don't matter given that
things are already broken).

Regards,
Bjorn

> +
>  	len = min_t(size_t, count, pipe->native.length - head);
>  	if (len)
>  		memcpy(pipe->fifo + head, data, len);
> -- 
> 2.34.1
> 
